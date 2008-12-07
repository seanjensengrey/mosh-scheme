/*
 * VM.cpp - Virtual stack based machine.
 *
 *   Copyright (c) 2008  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
 *
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following conditions
 *   are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  $Id: VM.cpp 5323 2008-05-09 09:06:26Z higepon $
 */

#include "VM.h"

#ifdef DUMP_ALL_INSTRUCTIONS
    extern FILE* stream;
#endif

using namespace scheme;

#define SAVE_REGISTERS()                       \
    const Object ac = ac_;                     \
    const Object cl = cl_;                     \
    const Object errorHandler = errorHandler_; \
    Object* const pc = pc_;                    \
    Object* const fp = fp_;                    \
    Object* const sp = sp_;

#define RESTORE_REGISTERS()       \
    ac_ = ac;                     \
    cl_ = cl;                     \
    errorHandler_ = errorHandler; \
    fp_ = fp;                     \
    pc_ = pc;                     \
    sp_ = sp;

VM::VM(int stackSize, TextualOutputPort& outport, TextualOutputPort& errorPort, Object inputPort) :
    ac_(Object::Nil),
    cl_(Object::Nil),
    pc_(NULL),
    stackSize_(stackSize),
    outputPort_(outport),
    errorPort_(errorPort),
    inputPort_(inputPort),
    stdinPort_(Object::makeBinaryInputPort(stdin)),
    errorObj_(Object::Nil)
{
#ifdef USE_BOEHM_GC
    stack_ = new (GC)Object[stackSize];
#else
    stack_ = new Object[stackSize];
#endif
    stackEnd_ = stack_ + stackSize;
    sp_ = stack_;
    fp_ = stack_;
    libraries_ = Object::makeEqHashTable();
    instances_ = Object::makeEqHashTable();
    nameSpace_ = Object::makeEqHashTable();
}

VM::~VM() {}

Object VM::raiseContinuable(Object o)
{
    return callClosure(errorHandler_, o);
}


Object VM::withExceptionHandler(Object handler, Object thunk)
{
    SAVE_REGISTERS();
    errorHandler_ = handler;
    jmp_buf org;
    Object ret;
    copyJmpBuf(org, returnPoint_);
    if (setjmp(returnPoint_) != 0) {
        copyJmpBuf(returnPoint_, org);
        if (handler.isNil()) {
            defaultExceptionHandler(errorObj_);
        } else {
            ret = callClosure(handler, errorObj_);
        }
    } else {
        ret = callClosure0(thunk);
        copyJmpBuf(returnPoint_, org);
    }
    RESTORE_REGISTERS();
    return ret;
}

void VM::defaultExceptionHandler(Object error)
{
    errorPort_.format(UC("  Error:\n    ~a\n"), L1(error));
}

void VM::loadFile(const ucs4string& file)
{
    jmp_buf org;
    copyJmpBuf(org, returnPoint_);
    if (setjmp(returnPoint_) != 0) {
        // call default error handler
        defaultExceptionHandler(errorObj_);
        exit(-1);
    } else {
        const Object port = Object::makeTextualInputFilePort(file.ascii_c_str());
        TextualInputPort* p = port.toTextualInputPort();
        for (Object o = p->getDatum(); !o.isEof(); o = p->getDatum()) {
            const Object compiled = compile(o);
            evaluate(compiled);
        }
        copyJmpBuf(returnPoint_, org);
    }
}

// same as (eval ...)
Object VM::eval(Object obj, Object env)
{
    // env is currently ignored
    return evaluate(compile(obj));
}

void VM::load(const ucs4string& file)
{
    ucs4string moshLibPath(UC(MOSH_LIB_PATH));
    moshLibPath += UC("/") + file;
    if (fileExistsP(file)) {
        loadFile(file);
    } else if (fileExistsP(moshLibPath)) {
        loadFile(moshLibPath);
    } else {
        RAISE1("cannot find file ~a in load path", Object::makeString(file));
    }
}


void VM::importTopLevel()
{
    notFound_  = Symbol::intern(UC("vm hash table not found"));
    topLevelInstance_ = Object::makeEqHashTable();
    EqHashTable* ht = instances_.toEqHashTable();
    ht->set(Symbol::intern(UC("top level ")), topLevelInstance_);
}

void VM::initLibraryTable()
{
    const Object toplevel = Symbol::intern(UC("top level "));
    libraries_.toEqHashTable()->eraseAllExcept(toplevel);
    instances_.toEqHashTable()->eraseAllExcept(toplevel);
}

Object VM::evaluate(Object codeVector)
{
    Vector* const v = codeVector.toVector();
    return evaluate(v->data(), v->length());
}


Object VM::evaluate(Object* code, int codeSize)
{
    static Object closure = Object::Undef;
    if (Object::Undef == closure) {
#       include "cprocedures.cpp"
        closure = Object::makeClosure(NULL, 0, false, cProcs, cProcNum, 0, Object::False /* todo */);
    }
    closure.toClosure()->pc = code;
    ac_ = closure;
    cl_ = closure;
    fp_ = 0;

    Object* const direct = getDirectThreadedCode(code, codeSize);
    return run(direct, NULL);
}

Object VM::callClosure0(Object closure)
{
    static Object applyCode[] = {
        Object::makeRaw(Instruction::FRAME),
        Object::makeInt(5),
        Object::makeRaw(Instruction::CONSTANT),
        Object::Undef,
        Object::makeRaw(Instruction::CALL),
        Object::makeInt(0),
        Object::makeRaw(Instruction::HALT),
    };

    applyCode[3] = closure;

    SAVE_REGISTERS();
    const Object ret = evaluate(applyCode, sizeof(applyCode) / sizeof(Object));
    RESTORE_REGISTERS();
    return ret;
}


// accept one argument.
Object VM::callClosure(Object closure, Object arg)
{
    static Object applyCode[] = {
        Object::makeRaw(Instruction::FRAME),
        Object::makeInt(8),
        Object::makeRaw(Instruction::CONSTANT),
        Object::Undef,
        Object::makeRaw(Instruction::PUSH),
        Object::makeRaw(Instruction::CONSTANT),
        Object::Undef,
        Object::makeRaw(Instruction::CALL),
        Object::makeInt(1),
        Object::makeRaw(Instruction::HALT),
    };

    applyCode[3] = arg;
    applyCode[6] = closure;

    SAVE_REGISTERS();
    const Object ret = evaluate(applyCode, sizeof(applyCode) / sizeof(Object));
    RESTORE_REGISTERS();
    return ret;
}

// accept arguments as list.
Object VM::applyClosure(Object closure, Object args)
{
    static Object applyCode[] = {
        Object::makeRaw(Instruction::FRAME),
        Object::makeInt(7),
        Object::makeRaw(Instruction::CONSTANT),
        Object::Undef,
        Object::makeRaw(Instruction::PUSH),
        Object::makeRaw(Instruction::CONSTANT),
        Object::Undef,
        Object::makeRaw(Instruction::APPLY),
        Object::makeRaw(Instruction::HALT),
    };
    applyCode[3] = args;
    applyCode[6] = closure;

    SAVE_REGISTERS();
    const Object ret = evaluate(applyCode, sizeof(applyCode) / sizeof(Object));
    RESTORE_REGISTERS();
    return ret;
}

// we need to save registers.
Object VM::callClosureByName(Object procSymbol, Object arg)
{
    static Object applyCode[] = {
        Object::makeRaw(Instruction::FRAME),
        Object::makeInt(8),
        Object::makeRaw(Instruction::CONSTANT),
        Object::Undef,
        Object::makeRaw(Instruction::PUSH),
        Object::makeRaw(Instruction::REFER_GLOBAL),
        Object::Undef,
        Object::makeRaw(Instruction::CALL),
        Object::makeInt(1),
        Object::makeRaw(Instruction::HALT),
    };
    //todo
    ucs4string proc(UC("top level :$:"));
    proc += procSymbol.toSymbol()->c_str();
    applyCode[3] = arg;
    applyCode[6] = Symbol::intern(proc.c_str());

    SAVE_REGISTERS();
    const Object ret = evaluate(Object::makeVector(sizeof(applyCode) / sizeof(Object), applyCode));
    RESTORE_REGISTERS();
    return ret;
}

Object VM::apply(Object proc, Object args)
{
    const int procLength = Pair::length(proc);
    const int length  = procLength + 7;
#ifdef USE_BOEHM_GC
    Object* code = new(GC) Object[length];
#else
    Object* code = new Object[length ];
#endif
    code[0] = Object::makeRaw(Instruction::FRAME);
    code[1] = Object::makeInt(procLength + 5);
    code[2] = Object::makeRaw(Instruction::CONSTANT);
    code[3] = args;
    code[4] = Object::makeRaw(Instruction::PUSH);
    int i = 0;
    for (Object o = proc; !o.isNil(); o = o.cdr()) {
        code[5 + i] = o.car();
        i++;
    }
    code[5 + i] = Object::makeRaw(Instruction::APPLY);
    code[6 + i] = Object::makeRaw(Instruction::HALT);

    static Object closure = Object::Undef;
    if (Object::Undef == closure) {
#       include "cprocedures.cpp"
        closure = Object::makeClosure(NULL, 0, false, cProcs, cProcNum, 1, Object::False /* todo */);
    }
    closure.toClosure()->pc = code;
    SAVE_REGISTERS();
    Object* const direct = getDirectThreadedCode(code, length);
    const Object ret = run(direct, NULL);
    RESTORE_REGISTERS();
    return ret;
}

Object VM::compile(Object code)
{
    static Object proc = Symbol::intern(UC("compile"));
    const Object compiled = callClosureByName(proc, code);
    return compiled;
}

//#define DUMP_ALL_INSTRUCTIONS

#ifdef USE_DIRECT_THREADED_CODE
#define SWITCH(val) goto *val;

#ifdef DUMP_ALL_INSTRUCTIONS
#include "DebugInstruction.h"
#define CASE(insn)  LABEL_##insn : logBuf[0] = DebugInstruction:: insn; logBuf[1] = 6;
#define NEXT                        \
{                                   \
    fwrite(logBuf, 1, 2, stream);   \
    goto *(*pc_++).val  ;           \
}
#else
#define CASE(insn)  LABEL_##insn :
#define NEXT                         \
{                                    \
    asm volatile(" \t # -- next start");   \
    goto *((*pc_++).val);            \
    asm volatile(" \t # -- next end");   \
}

#endif // DUMP_ALL_INSTRUCTIONS

#define DEFAULT     LABEL_DEFAULT :
#define INSTRUCTION(insn) &&LABEL_ ## insn

#else /* !USE_DIRECT_THREADED_CODE */
#define SWITCH(val) switch (val)
#define CASE(insn)  case Instruction:: insn :
#define NEXT        break;
#define DEFAULT     default:
#define INSTRUCTION(insn) Instruction:: ## insn
#endif

Object VM::run(Object* code, jmp_buf returnPoint, bool returnTable /* = false */)
{
#ifdef DUMP_ALL_INSTRUCTIONS
    uint8_t logBuf[2];
    Transcoder* transcoder = new Transcoder(new UTF8Codec, Transcoder::LF, Transcoder::IGNORE);
    TextualOutputPort logPort(TextualOutputPort(new FileBinaryOutputPort(stream), transcoder));
#endif
#ifdef USE_DIRECT_THREADED_CODE
#include "labels.cpp"

    if (returnTable) {
        return Object::makeRaw(dispatch_table);
    }
#endif

    static Object returnCode[] = {
        Object::makeRaw(INSTRUCTION(RETURN)),
        Object::makeInt(0),
    };

    static Object callCode[] = {
        Object::makeRaw(INSTRUCTION(CALL)),
        Object::makeInt(0),
        Object::makeRaw(INSTRUCTION(HALT)),
    };

    Object operand;

    pc_ = code;

    for (;;) {
        const Object insn = *pc_++;
        SWITCH((int)insn.val) {
        CASE(HALT)
        {
#ifdef DUMP_ALL_INSTRUCTIONS
            fwrite(logBuf, 1, 2, stream);
#endif
            return ac_;
        }
        CASE(APPEND)
        {
            const Object list1 = index(sp_, 0);
            const Object list2 = ac_;
            TRACE_INSN0("APPEND");
            ac_ = Pair::append(list1, list2);
            sp_--;
            NEXT;
        }
        CASE(CALL1)
        {
            operand = Object::makeInt(1);
            goto call_entry;
        }
        CASE(CALL2)
        {
            operand = Object::makeInt(2);
            goto call_entry;
        }
        CASE(CALL3)
        {
            operand = Object::makeInt(3);
            goto call_entry;
        }
        CASE(CALL)
        {
            TRACE_INSN1("CALL", "(~a)\n", ac_);
            operand = fetchOperand();
        call_entry:
#ifdef DUMP_ALL_INSTRUCTIONS
            const int m = operand.toInt();
            if (m <= DebugInstruction::OPERAND_MAX) logBuf[1] = m;
#endif
            if (ac_.isCProcedure()) {
#ifdef DUMP_ALL_INSTRUCTIONS
                fwrite(logBuf, 1, 2, stream);
#endif
                ac_ = ac_.toCProcedure()->call(stackToPairArgs(sp_, operand.toInt()));
                returnCode[1] = operand;
                pc_  = returnCode;
            } else if (ac_.isClosure()) {

                const Closure* const c = ac_.toClosure();
                if (c->maxStack + sp_ >= stackEnd_) {
                    RAISE1("stack over flow sp=~d", Object::makeInt(sp_ - stack_));
                }

                const int argLength = operand.toInt();
                const int requiredLength = c->argLength;
                cl_ = ac_;
                pc_ = c->pc;
                if (c->isOptionalArg) {
                    const int extraLength = argLength - requiredLength;
                    if (-1 == extraLength) {
                        Object* const sp = unShiftArgs(sp_, 1);
                        indexSet(sp, 0, Object::Nil);
                        sp_ = sp;
                        fp_ = sp - requiredLength;
                    } else if (extraLength >= 0) {
                        indexSet(sp_, extraLength, stackToPairArgs(sp_, extraLength + 1));
                        Object* const sp = sp_ - extraLength;
                        fp_ = sp - requiredLength;
                        sp_ = sp;
                    } else {
                        RAISE2("wrong number of arguments for #<closure> (required ~d, got ~d)"
                               , Object::makeInt(requiredLength)
                               , operand);
                    }
                } else if (requiredLength == argLength) {
                    fp_ = sp_ - argLength;
                } else {
                    RAISE2("wrong number of arguments for #<closure> (required ~d, got ~d)"
                           , Object::makeInt(requiredLength)
                           , operand);
                }
            } else if (ac_.isRegexp()) {
                extern Object rxmatchEx(Object args);
                ac_ = Object::makeCProcedure(scheme::rxmatchEx).toCProcedure()->call(Object::cons(ac_, stackToPairArgs(sp_, operand.toInt())));
                returnCode[1] = operand;
                pc_  = returnCode;
            } else if (ac_.isRegMatch()) {
                extern Object regMatchProxy(Object args);
                ac_ = Object::makeCProcedure(scheme::regMatchProxy).toCProcedure()->call(Object::cons(ac_, stackToPairArgs(sp_, operand.toInt())));
                returnCode[1] = operand;
                pc_  = returnCode;
            } else {
                RAISE2("not supported apply ~a ~a", operand, ac_);
            }
            NEXT;
        }
        CASE(APPLY)
        {
            TRACE_INSN0("APPLY");
            const Object args = index(sp_, 0);
            if (args.isNil()) {
                callCode[1] = Object::makeInt(0);
                pc_  = callCode;
                sp_--;
            } else if (args.isValues()) { // call-with-values
                const Object arg = args.toValues()->values();
                const int length = Pair::length(arg);
                const Closure* const c = ac_.toClosure();
                int requiredLength = c->argLength;
                if (!c->isOptionalArg && requiredLength != length) {
                    RAISE1("Values received ~a values than expected", length > requiredLength ? Object::makeString(UC("more")) : Object::makeString(UC("fewer")));
                }

                const int shiftLen = length > 1 ? length - 1 : 0;
                Object* const sp = unShiftArgs(sp_,shiftLen);
                pairArgsToStack(sp, 0, arg);
                callCode[1] = Object::makeInt(length);
                pc_  = callCode;
                sp_ = sp;
            } else {
                const int length = Pair::length(args);
                const int shiftLen = length > 1 ? length - 1 : 0;
                Object* const sp = sp_ + shiftLen; //unShiftArgs(sp_, 0, shiftLen);////
                pairArgsToStack(sp, 0, args);
                callCode[1] = Object::makeInt(length);
                pc_ = callCode;
                sp_ = sp;
            }
            NEXT;
        }
        CASE(PUSH)
        {
            TRACE_INSN0("PUSH");
            push(ac_);
            NEXT;
        }
        CASE(CONSTANT_PUSH)
        {
            const Object c = fetchOperand();
            ac_ = c;
            push(ac_);
            NEXT;
        }
        CASE(ASSIGN_FREE)
        {
            const Object n = fetchOperand();
#ifdef DUMP_ALL_INSTRUCTIONS
            const int m = n.toInt();
            if (m <= DebugInstruction::OPERAND_MAX) logBuf[1] = m;
#endif
            TRACE_INSN1("ASSIGN_FREE", "(~d)\n", n);
            referFree(n).toBox()->set(ac_);
            NEXT;
        }
        CASE(ASSIGN_GLOBAL)
        {
            const Object id = fetchOperand();
            TRACE_INSN1("ASSIGN_GLOBAL", "(~a)\n", id);
            const Object val = nameSpace_.toEqHashTable()->ref(id, notFound_);
            if (val == notFound_) {
                Object e = splitId(id);
                RAISE2("can't set! to unbound variable ~a on ~a", e.cdr(), e.car());
            } else {
                nameSpace_.toEqHashTable()->set(id, ac_);
                ac_ = Object::Undef;
            }
            NEXT;
        }
        CASE(ASSIGN_LOCAL)
        {
            const Object n = fetchOperand();
#ifdef DUMP_ALL_INSTRUCTIONS
            const int m = n.toInt();
            if (m <= DebugInstruction::OPERAND_MAX) logBuf[1] = m;
#endif
            TRACE_INSN1("ASSIGN_LOCAL", "(~d)\n", n);
//            index(fp_, n.toInt()).toBox()->set(ac_);
            referLocal(n.toInt()).toBox()->set(ac_);
//            index(fp_ + , n.toInt()).toBox()->set(ac_);
            NEXT;
        }
        CASE(BOX)
        {
            const Object n = fetchOperand();
#ifdef DUMP_ALL_INSTRUCTIONS
            const int m = n.toInt();
            if (m <= DebugInstruction::OPERAND_MAX) logBuf[1] = m;
#endif
            TRACE_INSN1("BOX", "(~a)\n", n);
            indexSet(sp_, n.toInt(), Object::makeBox(index(sp_, n.toInt())));
            NEXT;
        }
        CASE(CAAR)
        {
            TRACE_INSN0("CAAR");
            if (!ac_.isPair()) {
                RAISE1("caar pair required, but got ~a", ac_);
            }
            ac_ = ac_.car();
            if (!ac_.isPair()) {
                RAISE1("caar pair required, but got ~a", ac_);
            }
            ac_ = ac_.car();
            NEXT;
        }
        CASE(CADR)
        {
            TRACE_INSN0("CADR");
            if (!ac_.isPair()) {
                RAISE1("cadr pair required, but got ~a\n", ac_);
            }
            ac_ = ac_.cdr();
            if (!ac_.isPair()) {
                RAISE1("cadr pair required, but got ~a\n", ac_);
            }
            ac_ = ac_.car();
            NEXT;
        }
        CASE(CAR)
        {
            TRACE_INSN0("CAR");
            if (!ac_.isPair()) {
                RAISE1("car pair required, but got ~a", ac_);
            }
            ac_ = ac_.car();
            NEXT;
        }
        CASE(CAR_PUSH)
        {
            TRACE_INSN0("CAR_PUSH");
            if (!ac_.isPair()) {
                RAISE1("car pair required, but got ~a", ac_);
            }
            push(ac_.car());
            NEXT;
        }
        CASE(CDAR)
        {
            TRACE_INSN0("CDAR");
            if (!ac_.isPair()) {
                RAISE1("cdar pair required, but got ~a", ac_);
            }
            ac_ = ac_.car();
            if (!ac_.isPair()) {
                RAISE1("cdar pair required, but got ~a", ac_);
            }
            ac_ = ac_.cdr();
            NEXT;
        }
        CASE(CDDR)
        {
            TRACE_INSN0("CDDR");
            if (!ac_.isPair()) {
                RAISE1("cddr pair required, but got ~a", ac_);
            }
            ac_ = ac_.cdr();
            if (!ac_.isPair()) {
                RAISE1("cddr pair required, but got ~a", ac_);
            }
            ac_ = ac_.cdr();
            NEXT;
        }
        CASE(CDR)
        {
            TRACE_INSN0("CDR");
            if (!ac_.isPair()) {
                RAISE1("cdr pair required, but got ~a", ac_);
            }
            ac_ = ac_.cdr();
            NEXT;
        }
        CASE(CDR_PUSH)
        {
            TRACE_INSN0("CDR_PUSH");
            if (!ac_.isPair()) {
                RAISE1("cdr pair required, but got ~a", ac_);
            }
            push(ac_.cdr());
            NEXT;
        }
        CASE(CLOSURE)
        {
            const int skipSize         = fetchOperand().toInt();
            const int argLength        = fetchOperand().toInt();
            const bool isOptionalArg   = !fetchOperand().isFalse();
            const int freeVariablesNum = fetchOperand().toInt();
            const int maxStack         = fetchOperand().toInt();
            const Object sourceInfo    = fetchOperand();
            TRACE_INSN1("CLOSURE", "(n => ~d)\n", Object::makeInt(freeVariablesNum));
            ac_ = Object::makeClosure(pc_, argLength, isOptionalArg, (sp_ - freeVariablesNum), freeVariablesNum, maxStack, sourceInfo);
            sp_ -= freeVariablesNum;
            pc_ += skipSize - 6;
            NEXT;
        }
        CASE(CONS)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("CONS");
            ac_ = Object::cons(n, ac_);
            sp_--;
            NEXT;
        }
        CASE(CONSTANT)
        {
            const Object c = fetchOperand();
            TRACE_INSN1("CONSTANT", "(~a)\n", c);
            ac_ = c;
            NEXT;
        }
        CASE(PUSH_CONSTANT)
        {
            push(ac_);
            ac_ = fetchOperand();
            NEXT;
        }
        CASE(DEFINE_GLOBAL)
        {
            const Object id = fetchOperand();
            defineGlobal(id, ac_);
            TRACE_INSN1("DEFINE_GLOBAL", "([~a])\n", id);
            NEXT;
        }
        CASE(DISPLAY)
        {
            const Object n = fetchOperand();
            const int freeVariablesNum = n.toInt();
            // display closure
            cl_ = Object::makeClosure(NULL, 0, false, sp_ - freeVariablesNum, freeVariablesNum, 0, Object::False);
            TRACE_INSN0("DISPLAY");
            sp_ = sp_ - freeVariablesNum;
            NEXT;
        }
        CASE(ENTER)
        {
            TRACE_INSN0("ENTER");
            const Object n = fetchOperand(); // not used
            fp_ = sp_ - n.toInt();
            NEXT;
        }
        CASE(PUSH_ENTER)
        {
            push(ac_);
            TRACE_INSN0("ENTER");
            const Object n = fetchOperand(); // not used
            fp_ = sp_ - n.toInt();
            NEXT;
        }
        CASE(EQ)
        {
            const Object o = index(sp_, 0);
            TRACE_INSN0("EQ");
            ac_ = o.eq(ac_);
            sp_--;
            NEXT;
        }
        CASE(EQV)
        {
            const Object o = index(sp_, 0);
            TRACE_INSN0("EQV");
            ac_ = o.eqv(ac_);
            sp_--;
            NEXT;
        }
        CASE(EQUAL)
        {
            const Object o = index(sp_, 0);
            TRACE_INSN0("EQUAL");
            ac_ = o.equal(ac_);
            sp_--;
            NEXT;
        }
        CASE(PUSH_FRAME)
        {
            push(ac_);
            goto frame_entry;
        }
        CASE(FRAME)
        {
        frame_entry:
            const Object n = fetchOperand();
            TRACE_INSN1("FRAME", "(~d)\n", n);
#ifdef DUMP_ALL_INSTRUCTIONS
            const int m = n.toInt();
            if (m <= DebugInstruction::OPERAND_MAX) logBuf[1] = m;
#endif

            const int skipSize = n.toInt();
            push(Object::makeObjectPointer(pc_ + skipSize - 1));
            push(cl_);
            push(Object::makeObjectPointer(fp_));
            NEXT;
        }
        CASE(IMPORT)
        {
            const Object libname = fetchOperand();
            TRACE_INSN1("IMPORT", "(~a)\n", libname);
            const Object instance = instances_.toEqHashTable()->ref(libname, notFound_);
            if (instance == notFound_){
                instances_.toEqHashTable()->set(libname, Object::makeEqHashTable());
                const Object lib = libraries_.toEqHashTable()->ref(libname, notFound_);
                if (getLibraryCompiledBody(lib).isFalse()) {
                    static const Object proc = Symbol::intern(UC("compile-library-body!"));
                    callClosureByName(proc, lib);
                }
                // todo more efficient code
                Vector* const v = getLibraryCompiledBody(lib).toVector();
                Object* code = v->data();
                pc_ = getDirectThreadedCode(code, v->length());
            } else {
                returnCode[1] = Object::makeInt(0);
                pc_  = returnCode;
            }
            NEXT;
        }
        CASE(REFER_FREE0_INDIRECT)
        {
            ac_ = referFree(0);
            goto indirect_entry;
        }
        CASE(REFER_FREE1_INDIRECT)
        {
            ac_ = referFree(1);
            goto indirect_entry;
        }
        CASE(INDIRECT)
        {
            TRACE_INSN0("INDIRECT");
        indirect_entry:
            ac_ = ac_.toBox()->value();
            NEXT;
        }
        CASE(LEAVE1)
        {
            operand = Object::makeInt(1);
            goto leave_entry;
        }
        CASE(LEAVE)
        {
            operand= fetchOperand();
        leave_entry:
#ifdef DUMP_ALL_INSTRUCTIONS
            if (operand.toInt() <= DebugInstruction::OPERAND_MAX) logBuf[1] = operand.toInt();
#endif
            TRACE_INSN1("LEAVE", "(~d)\n", operand);

            Object* const sp = sp_ - operand.toInt();

            fp_ = index(sp, 0).toObjectPointer();
            cl_ = index(sp, 1);

            sp_ = sp - 2;
            NEXT;
        }
        CASE(LET_FRAME)
        {
            TRACE_INSN0("LET_FRAME");
            push(cl_);
            push(Object::makeObjectPointer(fp_));
            NEXT;
        }
        CASE(LIBRARY)
        {
            const Object libname = fetchOperand();
            const Object library = fetchOperand();
            libraries_.toEqHashTable()->set(libname, library);
            NEXT;
        }
        CASE(LIST)
        {
            printf("CASE(LIST)\n");
            exit(-1);
            NEXT;
        }
        CASE(LOCAL_JMP)
        {
            const Object n = fetchOperand();
            TRACE_INSN1("LOCAL_JMP", "(~d)\n", n);
            pc_ += n.toInt() - 1;
            NEXT;
        }
        CASE(MAKE_CONTINUATION)
        {
            const Object n = fetchOperand();
            TRACE_INSN1("MAKE_CONTINUATION", "(~d)\n", n);
            ac_ = makeContinuation(n);
            NEXT;
        }
        CASE(MAKE_VECTOR)
        {
            const Object n = index(sp_, 0);
            ac_ = Object::makeVector(n.toInt(), ac_);
            sp_--;
            NEXT;

        }
        CASE(NOP)
        {
            TRACE_INSN0("NOP");
            NEXT;
        }
        CASE(NOT)
        {
            TRACE_INSN0("NOT");
            ac_ = ac_.isFalse() ? Object::True : Object::False;
            NEXT;
        }
        CASE(NULL_P)
        {
            TRACE_INSN0("NULL_P");
            ac_ = ac_.isNil() ? Object::True : Object::False;
            NEXT;
        }
        CASE(NUMBER_ADD)
        {
            TRACE_INSN0("NUMBER_ADD");
            ac_ = Object::makeInt(index(sp_, 0).toInt() + ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_EQUAL)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("NUMBER_EQUAL");
            ac_ = Object::makeBool(n.toInt() == ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_GE)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("NUMBER_GE");
            ac_ = Object::makeBool(n.toInt() >= ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_GT)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("NUMBER_GT");
            ac_ = Object::makeBool(n.toInt() > ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_LE)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("NUMBER_LE");
            ac_ = Object::makeBool(n.toInt() <= ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_LT)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("NUMBER_GE");
            ac_ = Object::makeBool(n.toInt() < ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_MUL)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("NUMBER_MUL");
            ac_ = Object::makeInt(n.toInt() * ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_DIV)
        {
            const Object n = index(sp_, 0);
            if (ac_.toInt() == 0) {
                RAISE2("Dividing by zero (/ ~d ~d)", n, ac_);
            }
            ac_ = Object::makeInt(n.toInt() / ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_SUB)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("NUMBER_SUB");
            ac_ = Object::makeInt(n.toInt() - ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(NUMBER_SUB_PUSH)
        {
            const Object n = index(sp_, 0);
            TRACE_INSN0("NUMBER_SUB");
            ac_ = Object::makeInt(n.toInt() - ac_.toInt());
            sp_--;
            push(ac_);
            NEXT;
        }
        CASE(REFER_LOCAL0_NUMBER_ADD_PUSH)
        {
            ac_ = referLocal(0);
            goto number_add_push_entry;
        }
        CASE(NUMBER_ADD_PUSH)
        {
        number_add_push_entry:
            const Object n = index(sp_, 0);
            ac_ = Object::makeInt(n.toInt() + ac_.toInt());
            sp_--;
            push(ac_);
            NEXT;
        }
        CASE(PAIR_P)
        {
            TRACE_INSN0("PAIR_P");
            ac_ = Object::makeBool(ac_.isPair());
            NEXT;
        }
        CASE(READ)
        {
            TRACE_INSN0("READ");
            if (ac_.isNil()) {
                printf("%s %s:%d\n", __func__, __FILE__, __LINE__);fflush(stdout);// debug
                exit(-1);
            } else {
                ac_ = ac_.toTextualInputPort()->getDatum();
            }
            NEXT;
        }
        CASE(READ_CHAR)
        {
            TRACE_INSN0("READ_CHAR");
            if (ac_.isNil()) {
                printf("%s %s:%d\n", __func__, __FILE__, __LINE__);fflush(stdout);// debug
                exit(-1);
            } else {
                const ucs4char c = ac_.toTextualInputPort()->getChar();
                ac_= c == EOF ? Object::Eof : Object::makeChar(c);
            }
            NEXT;
        }
        CASE(REDUCE)
        {
            TRACE_INSN0("REDUCE");
            const Object n = fetchOperand();
            sp_ = fp_ + n.toInt();;
            NEXT;
        }
        CASE(REFER_FREE)
        {
            operand = fetchOperand();
        refer_free_entry:
#ifdef DUMP_ALL_INSTRUCTIONS
            const int m = operand.toInt();
            if (m <= DebugInstruction::OPERAND_MAX) logBuf[1] = m;
#endif

            ac_ = referFree(operand);
            TRACE_INSN1("REFER_FREE", "(~d)\n", operand);
            NEXT;
        }
        CASE(REFER_FREE_PUSH)
        {
            push(referFree(fetchOperand()));
            NEXT;
        }
        CASE(REFER_FREE0_PUSH)
        {
            push(referFree(0));
            NEXT;
        }
        CASE(REFER_FREE1_PUSH)
        {
            push(referFree(1));
            NEXT;
        }
        CASE(REFER_FREE2_PUSH)
        {
            push(referFree(2));
            NEXT;
        }
        CASE(REFER_FREE0)
        {
            operand = Object::makeInt(0);
            goto refer_free_entry;
        }
        CASE(REFER_FREE1)
        {
            operand = Object::makeInt(1);
            goto refer_free_entry;
        }
        CASE(REFER_FREE2)
        {
            operand = Object::makeInt(2);
            goto refer_free_entry;
        }
        CASE(REFER_FREE3)
        {
            operand = Object::makeInt(3);
            goto refer_free_entry;
        }
        CASE(REFER_GLOBAL)
        {
            const Object id = fetchOperand();
            const Object val = nameSpace_.toEqHashTable()->ref(id, notFound_);
            if (val == notFound_) {
                Object e = splitId(id);
                RAISE2("unbound variable ~a on ~a", e.cdr(), e.car());
            } else {
                ac_ = val;
            }
            NEXT;
        }
        CASE(REFER_GLOBAL_CALL)
        {
            const Object id = fetchOperand();
            const Object val = nameSpace_.toEqHashTable()->ref(id, notFound_);
            if (val == notFound_) {
                Object e = splitId(id);
                RAISE2("unbound variable ~a on ~a", e.cdr(), e.car());
            } else {
                ac_ = val;
            }
            operand = fetchOperand();
            goto call_entry;
        }
        CASE(REFER_LOCAL)
        {
            operand = fetchOperand();
        refer_local_entry:
#ifdef DUMP_ALL_INSTRUCTIONS
            const int m = operand.toInt();
            if (m <= DebugInstruction::OPERAND_MAX) logBuf[1] = m;
#endif

            ac_ = referLocal(operand.toInt());
            TRACE_INSN1("REFER_LOCAL", "(~d)\n", operand);
            NEXT;
        }
        CASE(REFER_LOCAL0)
        {
            operand = Object::makeInt(0);
            goto refer_local_entry;
        }
        CASE(REFER_LOCAL1)
        {
            operand = Object::makeInt(1);
            goto refer_local_entry;
        }
        CASE(REFER_LOCAL2)
        {
            operand = Object::makeInt(2);
            goto refer_local_entry;
        }
        CASE(REFER_LOCAL3)
        {
            operand = Object::makeInt(3);
            goto refer_local_entry;
        }
        CASE(REFER_LOCAL0_PUSH_CONSTANT)
        {
            push(referLocal(0));
            const Object n = fetchOperand();
            ac_ = n;
            TRACE_INSN0("REFER_LOCAL_PUSH0");
            NEXT;
        }
        CASE(REFER_LOCAL1_PUSH_CONSTANT)
        {
            push(referLocal(1));
            const Object n = fetchOperand();
            ac_ = n;
            TRACE_INSN0("REFER_LOCAL_PUSH0");
            NEXT;
        }
        CASE(REFER_LOCAL_PUSH)
        {
            push(referLocal(fetchOperand().toInt()));
            TRACE_INSN0("REFER_LOCAL_PUSH0");
            NEXT;
        }
        CASE(REFER_LOCAL0_PUSH)
        {
            push(referLocal(0));
            TRACE_INSN0("REFER_LOCAL_PUSH0");
            NEXT;
        }
        CASE(REFER_LOCAL1_PUSH)
        {
            push(referLocal(1));
            TRACE_INSN0("REFER_LOCAL_PUSH1");
            NEXT;
        }
        CASE(REFER_LOCAL2_PUSH)
        {
            push(referLocal(2));
            TRACE_INSN0("REFER_LOCAL_PUSH1");
            NEXT;
        }
        CASE(RESTORE_CONTINUATION)
        {
            const Object s = fetchOperand();
            TRACE_INSN0("RESTORE_CONTINUATION");
            sp_ = stack_ + s.toStack()->restore(stack_);
            NEXT;
        }
        CASE(RETURN1)
        {
            operand = Object::makeInt(1);
            goto return_entry;
        }
        CASE(RETURN2)
        {
            operand = Object::makeInt(2);
            goto return_entry;
        }
        CASE(RETURN3)
        {
            operand = Object::makeInt(3);
            goto return_entry;
        }
        CASE(RETURN)
        {
            operand = fetchOperand();
        return_entry:
#ifdef DUMP_ALL_INSTRUCTIONS
            const int m = operand.toInt();
            if (m <= DebugInstruction::OPERAND_MAX) logBuf[1] = m;
#endif


            TRACE_INSN1("RETURN", "(~d)\n", operand);
            Object* const sp = sp_ - operand.toInt();
            fp_ = index(sp, 0).toObjectPointer();
            cl_ = index(sp, 1);
            pc_ = index(sp, 2).toObjectPointer();
            sp_ = sp - 3;
            NEXT;
        }
        CASE(SET_CAR)
        {
            TRACE_INSN0("SET_CAR");
            const Object p = index(sp_, 0);
            p.car() = ac_;
            ac_ = Object::Undef;
            sp_--;
            NEXT;
        }
        CASE(SET_CDR)
        {
            TRACE_INSN0("SET_CDR");
            const Object p = index(sp_, 0);
            p.cdr() = ac_;
            ac_ = Object::Undef;
            sp_--;
            NEXT;
        }
        CASE(SHIFT)
        {
            const int depth = fetchOperand().toInt();
            const int diff  = fetchOperand().toInt();
#ifdef DUMP_ALL_INSTRUCTIONS
            if (depth <= DebugInstruction::OPERAND_MAX) logBuf[1] = depth;
#endif
            sp_ = shiftArgsToBottom(sp_, depth, diff);
            TRACE_INSN3("SHIFT", "(~d, ~d, sp=>~a)\n", Object::makeInt(depth), Object::makeInt(diff), Object::makeInt(stackEnd_ - sp_));
            NEXT;
        }
        CASE(SHIFT_CALL)
        {
            const int depth = fetchOperand().toInt();
            const int diff  = fetchOperand().toInt();
            sp_ = shiftArgsToBottom(sp_, depth, diff);
            operand = fetchOperand();
            goto call_entry;
        }
        CASE(SYMBOL_P)
        {
            TRACE_INSN0("SYMBOL_P");
            ac_ = Object::makeBool(ac_.isSymbol());
            NEXT;
        }
        CASE(TEST)
        {
            TRACE_INSN0("TEST");
        test_entry:
            if (ac_.isFalse()) {
                const Object skipSize = fetchOperand();
                skip(skipSize.toInt() - 1);
            } else {
                pc_++;
            }
            NEXT;
        }
        CASE(NOT_TEST)
        {
            ac_ = ac_.isFalse() ? Object::True : Object::False;
            goto test_entry;
        }
        CASE(NUMBER_LE_TEST)
        {
            ac_ = Object::makeBool(index(sp_, 0).toInt() <= ac_.toInt());
            sp_--;
            goto test_entry;
        }
        CASE(REFER_LOCAL0_EQV_TEST)
        {
            ac_ = index(sp_, 0).eqv(referLocal(0));
            sp_--;
            goto test_entry;
        }
        CASE(UNDEF)
        {
            TRACE_INSN0("UNDEF");
            ac_ = Object::Undef;
            NEXT;
        }
        CASE(VECTOR_LENGTH)
        {
            TRACE_INSN0("VECTOR_LENGTH");
            ac_ = Object::makeInt(ac_.toVector()->length());
            NEXT;
        }
        CASE(VECTOR_P)
        {
            TRACE_INSN0("VECTOR_P");
            ac_ = Object::makeBool(ac_.isVector());
            NEXT;
        }
        CASE(REFER_LOCAL0_VECTOR_REF)
        {
            ac_ = referLocal(0);
            goto vector_ref_entry;
        }
        CASE(REFER_LOCAL0_VECTOR_SET)
        {
            ac_ = referLocal(0);
            goto vector_set_entry;
        }
        CASE(VECTOR_REF)
        {
        vector_ref_entry:
            const Object v = index(sp_, 0);
            if (!v.isVector()) {
                RAISE1("vector-ref vector required, but got ~a", v);
            }
            TRACE_INSN0("VECTOR_REF");
            ac_ = v.toVector()->ref(ac_.toInt());
            sp_--;
            NEXT;
        }
        CASE(VECTOR_SET)
        {
        vector_set_entry:
            const Object v = index(sp_, 1);
            const Object n = index(sp_, 0);
            TRACE_INSN0("VECTOR_SET");
            v.toVector()->set(n.toInt(), ac_);
            ac_ = Object::Undef;
            sp_ -= 2;
            NEXT;
        }
        DEFAULT
        {
            printf("val=%d\n", (*(pc_ - 1)).val);
            RAISE1("unknown instruction ~a", *(pc_ - 1));

            NEXT;
        }
        } // SWITCH
    }
}

// id is (format "~a:$:~a" libname symbolname)
Object VM::splitId(Object id)
{
    const ucs4string text = id.toSymbol()->c_str();
    ucs4string::size_type i = text.find(UC(":$:"));
    if (i == ucs4string::npos) {
        return Object::Nil;
    }
    Object libname = Object::makeString(text.substr(0, i).c_str());
    Object symbol = Object::makeString(text.substr(i + 3, text.size() - i - 3).c_str());
    return Object::cons(libname, symbol);
}


Object VM::getStackTrace()
{
    const int MAX_DEPTH = 20;
    Object sport = Object::makeStringOutputPort();
    TextualOutputPort* port = sport.toTextualOutputPort();
    Object* fp = fp_;
    Object* cl = &cl_;
    for (int i = 0;;) {
        if (!cl->isClosure()) {
            // this case is very rare and may be bug of VM.
            fprintf(stderr, "fatal: stack corrupt!\n");
            exit(-1);
        }
        Object src = cl->toClosure()->sourceInfo;
        if (src.isPair()) {
            if (src.car().isFalse()) {
                port->format(UC("      <unknown location>: ~a \n"), L1(src.cdr()));
            } else {
                port->format(UC("      ~a:~a: ~a \n"), L3(src.car().car(), src.car().cdr(), src.cdr()));
            }
            i++;
        }
        if (i > MAX_DEPTH) {
            port->display(UC("      ... (more stack dump truncated)\n"));
            break;
        }

        cl = fp - 2;
        if (fp > stack_) {
            fp = (fp - 1)->toObjectPointer();
        } else {
            break;
        }
    }
    return sysGetOutputStringEx(L1(sport));
}

void VM::raise(Object o)
{
    errorObj_ = o;
    longjmp(returnPoint_, -1);
}

void VM::raiseFormat(const ucs4char* fmt, Object list)
{
    const Object errorMessage = formatEx(Object::cons(Object::makeString(fmt), list));
    raise(stringAppendEx(L3(errorMessage, Object::makeString(UC("\n")), getStackTrace())));
}