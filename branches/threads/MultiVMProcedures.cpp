/*
 * MultiVMProcedures.cpp -
 *
 *   Copyright (c) 2009  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
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
 *  $Id: MultiVMProcedures.cpp 183 2008-07-04 06:19:28Z higepon $
 */

#include "Object.h"
#include "Object-inl.h"
#include "Pair.h"
#include "Pair-inl.h"
#include "SString.h"
#include "scheme.h"
#include "VM.h"
#include "ProcedureMacro.h"
#include "Transcoder.h"
#include "OSCompat.h"
#include "StandardInputPort.h"
#include "StandardOutputPort.h"
#include "StandardErrorPort.h"
#include "OSCompatThread.h"
#include "MultiVMProcedures.h"

using namespace scheme;

static void* vmEntry(void* param);

// TODO
// 1. join all threads
// 2. configure GC macros
// 
// # (current-vm) => #<vm>
// # (vm? obj) => #t or #f
// # (vm-specific vm) => obj
// # (vm-specific-set! vm obj) => undef
// # (vm-start! thread) => undef
// # (vm-yield!) => undef
// # (vm-sleep! timeout) => undef
// # (vm-terminate! vm) => unef
// # (vm-join! vm [timeout [timeout-val]])


// (vm-start! vm) => undef
Object scheme::vmStartDEx(VM* theVM, int argc, const Object* argv)
{
    DeclareProcedureName("vm-start!");
    checkArgumentLength(1);
    argumentAsVM(0, vm);
    Thread* thread = new Thread;
    thread->create(vmEntry, vm);

    // todo
    thread->join(NULL);
    return Object::Undef;
}


// (make-vm thunk-sexp import-spec-sexp . name) => #<vm>
Object scheme::makeVmEx(VM* theVM, int argc, const Object* argv)
{
    DeclareProcedureName("make-vm");
    checkArgumentLengthBetween(2, 3);
    argumentCheckPair(0, thunkSexp);
    argumentCheckPair(1, importSpecSexp);
    Transcoder* transcoder = nativeTranscoder();
    Object inPort    = Object::makeTextualInputPort(new StandardInputPort(), transcoder);
    Object outPort   = Object::makeTextualOutputPort(new StandardOutputPort(), transcoder);
    Object errorPort = Object::makeTextualOutputPort(new StandardErrorPort(), transcoder);
    VM* vm = new VM(10000, outPort, errorPort, inPort, false /* isProfiler */);
    vm->loadCompiler();
    vm->setValueString(UC("%loadpath"), Object::False);
    vm->setValueString(UC("*command-line-args*"), Pair::list1("./test/stack-trace2.scm"));
    vm->setValueString(UC("%vm-import-spec"), importSpecSexp);
    vm->setValueString(UC("%vm-thunk"), thunkSexp);
    if (argc == 3) {
        argumentAsString(2, vmName);
        vm->setName(vmName->data());
    }
    return Object::makeVM(vm);
}

void* vmEntry(void* param)
{
    VM* vm = (VM*)param;
    vm->activateR6RSMode(false);
}
