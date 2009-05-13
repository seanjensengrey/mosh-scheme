/*
 * Object.cpp -
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
 *  $Id$
 */

#include "Object.h"
#include "Object-inl.h"
#include "Pair.h"
#include "Pair-inl.h"
#include "Record.h"
#include "Equivalent.h"
#include "Vector.h"
#include "SString.h"
#include "Symbol.h"
#include "ByteVector.h"
#include "Closure.h"
#include "Stack.h"
#include "EqHashTable.h"
#include "GenericHashTable.h"
#include "EqvHashTable.h"
#include "CProcedure.h"
#include "Box.h"
#include "Regexp.h"
#include "UtilityProcedures.h"
#include "Callable.h"
#include "Record.h"
#include "RecordTypeDescriptor.h"
#include "RecordConstructorDescriptor.h"
#include "OSCompat.h"
#include "CompoundCondition.h"
#include "FileBinaryInputPort.h"
#include "FileBinaryOutputPort.h"
#include "TextualOutputPort.h"
#include "TextualInputPort.h"
#include "Latin1Codec.h"
#include "Transcoder.h"
#include "StringTextualInputPort.h"
#include "StringTextualOutputPort.h"
#include "ByteArrayBinaryInputPort.h"
#include "CustomBinaryInputPort.h"
#include "CustomTextualInputPort.h"
#include "CustomTextualOutputPort.h"
#include "CustomTextualInputOutputPort.h"
#include "CustomBinaryOutputPort.h"
#include "CustomBinaryInputOutputPort.h"
#include "CodeBuilder.h"
#include "Ratnum.h"
#include "Flonum.h"
#include "Bignum.h"
#include "ProcedureMacro.h"
#include "Compnum.h"
#include "Arithmetic.h"
#include "BufferedFileBinaryInputPort.h"
#include "TranscodedTextualInputPort.h"
#include "TranscodedTextualOutputPort.h"
#include "TranscodedTextualInputOutputPort.h"
#include "OSCompatSocket.h"

using namespace scheme;

const Object Object::Nil     = Object::makeConst(CONST_NIL);
const Object Object::Eof     = Object::makeConst(CONST_EOF);
const Object Object::Undef   = Object::makeConst(CONST_UNDEF);
const Object Object::UnBound = Object::makeConst(CONST_UNBOUND);
const Object Object::True    = Object::makeConst(CONST_TRUE);
const Object Object::False   = Object::makeConst(CONST_FALSE);
const Object Object::Ignore  = Object::makeConst(CONST_IGNORE);

bool Object::isRational() const
{
    return isFixnum() || isBignum() || (isFlonum() && toFlonum()->isRational()) || isRatnum();
}


bool Object::isReal() const
{
    return isFixnum() || isBignum() || isFlonum() || isRatnum() || (isCompnum() && toCompnum()->isReal());
}

bool Object::isInteger() const
{
    return isFixnum() || isBignum() || (isNumber() && Arithmetic::isInteger(*this));
}

bool Object::equal(VM* theVM, Object o) const
{
    return ::equal(*this, o, new EqHashTable());
}

Object Object::makeBinaryInputPort(File* file)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::BinaryInputPort,
                                                        reinterpret_cast<intptr_t>(new FileBinaryInputPort(file)))));
}

Object Object::makeBinaryOutputPort(File* file)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::BinaryOutputPort,
                                                        reinterpret_cast<intptr_t>(new FileBinaryOutputPort(file)))));
}

Object Object::makeBinaryInputPort(BinaryInputPort* port)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::BinaryInputPort,
                                                        reinterpret_cast<intptr_t>(port))));
}

Object Object::makeBinaryInputOutputPort(BinaryInputOutputPort* port)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::BinaryInputOutputPort,
                                                        reinterpret_cast<intptr_t>(port))));
}


Object Object::makeBinaryOutputPort(BinaryOutputPort* port)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::BinaryOutputPort,
                                                        reinterpret_cast<intptr_t>(port))));
}

Object Object::makeTextualOutputPort(BinaryOutputPort* port, Transcoder* transcoder)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualOutputPort,
                                                        reinterpret_cast<intptr_t>(new TranscodedTextualOutputPort(port, transcoder)))));
}

Object Object::makeTextualInputOutputPort(BinaryInputOutputPort* port, Transcoder* transcoder)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputOutputPort,
                                                        reinterpret_cast<intptr_t>(new TranscodedTextualInputOutputPort(port, transcoder)))));
}



Object Object::makeTextualInputFilePort(const ucs4char* file)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputPort,
                                                        reinterpret_cast<intptr_t>(new TranscodedTextualInputPort(new BufferedFileBinaryInputPort(file)
                                                                                                    , nativeTranscoder())))));
}

Object Object::makeTextualInputFilePort(const char* file)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputPort,
                                                        reinterpret_cast<intptr_t>(new TranscodedTextualInputPort(new BufferedFileBinaryInputPort(file)
                                                                                                    , nativeTranscoder())))));
}


Object Object::makeStringInputPort(const ucs4string& str)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputPort,
                                                        reinterpret_cast<intptr_t>(new StringTextualInputPort(str)))));
}

Object Object::makeStringOutputPort()
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualOutputPort,
                                                        reinterpret_cast<intptr_t>(new StringTextualOutputPort()))));
}

Object Object::makeStringInputPort(const uint8_t* buf, int size)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputPort,
                                                        reinterpret_cast<intptr_t>(new TranscodedTextualInputPort(new ByteArrayBinaryInputPort(buf, size)
                                                                                                    , nativeTranscoder())))));
}

Object Object::makeCustomTextualInputPort(VM* theVM,
                                          const ucs4string& id,
                                          Object readProc,
                                          Object getPositionProc,
                                          Object setPositionProc,
                                          Object closeProc)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputPort,
                                                        reinterpret_cast<intptr_t>(new CustomTextualInputPort(theVM,
                                                                                                          id,
                                                                                                          readProc,
                                                                                                          getPositionProc,
                                                                                                          setPositionProc,
                                                                                                          closeProc)))));
}

Object Object::makeCustomTextualOutputPort(VM* theVM,
                                          const ucs4string& id,
                                          Object writeProc,
                                          Object getPositionProc,
                                          Object setPositionProc,
                                          Object closeProc)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualOutputPort,
                                                        reinterpret_cast<intptr_t>(new CustomTextualOutputPort(theVM,
                                                                                                          id,
                                                                                                          writeProc,
                                                                                                          getPositionProc,
                                                                                                          setPositionProc,
                                                                                                          closeProc)))));
}


Object Object::makeCustomTextualInputOutputPort(VM* theVM,
                                                const ucs4string& id,
                                                Object readProc,
                                                Object writeProc,
                                                Object getPositionProc,
                                                Object setPositionProc,
                                                Object closeProc)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputOutputPort,
                                                        reinterpret_cast<intptr_t>(new CustomTextualInputOutputPort(theVM,
                                                                                                                id,
                                                                                                                readProc,
                                                                                                                writeProc,
                                                                                                                getPositionProc,
                                                                                                                setPositionProc,
                                                                                                                closeProc)))));
}


Object Object::makeCustomBinaryInputPort(VM* theVM, const ucs4string& id, Object readProc, Object getPositionProc, Object setPositionProc, Object closeProc)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::BinaryInputPort,
                                                        reinterpret_cast<intptr_t>(new CustomBinaryInputPort(theVM, id, readProc, getPositionProc, setPositionProc, closeProc)))));
}

Object Object::makeCustomBinaryOutputPort(VM* theVM, const ucs4string& id, Object writeDProc, Object getPositionProc, Object setPositionDProc, Object closeProc)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::BinaryOutputPort,
                                                        reinterpret_cast<intptr_t>(new CustomBinaryOutputPort(theVM, id, writeDProc, getPositionProc, setPositionDProc, closeProc)))));
}

Object Object::makeCustomBinaryInputOutputPort(VM* theVM, const ucs4string& id, Object readProc, Object writeProc, Object getPositionProc, Object setPositionProc, Object closeProc)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::BinaryInputOutputPort,
                                                        reinterpret_cast<intptr_t>(new CustomBinaryInputOutputPort(theVM, id, readProc, writeProc, getPositionProc, setPositionProc, closeProc)))));
}


Object Object::makeCodec(Codec* codec)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Codec,
                                                        reinterpret_cast<intptr_t>(codec))));
}

Object Object::makeTranscoder(Transcoder* transcoder)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Transcoder,
                                                        reinterpret_cast<intptr_t>(transcoder))));
}

Object Object::makeTranscoder(Codec* codec)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Transcoder,
                                                        reinterpret_cast<intptr_t>(new Transcoder(codec)))));
}

Object Object::makeTranscoder(Codec* codec, enum EolStyle eolStyle)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Transcoder,
                                                        reinterpret_cast<intptr_t>(new Transcoder(codec, eolStyle)))));
}

Object Object::makeTranscoder(Codec* codec, enum EolStyle eolStyle, enum ErrorHandlingMode errorHandlingMode)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Transcoder,
                                                        reinterpret_cast<intptr_t>(new Transcoder(codec, eolStyle, errorHandlingMode)))));
}

Object Object::makeTextualInputPort(BinaryInputPort* port, Transcoder* transcoder)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputPort,
                                                        reinterpret_cast<intptr_t>(new TranscodedTextualInputPort(port, transcoder)))));
}

Object Object::makeTextualInputPort(TextualInputPort* port)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::TextualInputPort,
                                                        reinterpret_cast<intptr_t>(port))));
}

Object Object::makeRegexp(const ucs4string& pattern, bool caseFold /* = false */)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Regexp,
                                                        reinterpret_cast<intptr_t>(new Regexp(pattern, caseFold)))));
}

Object Object::makeRegMatch(OnigRegion* region, const ucs4string& text)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::RegMatch,
                                                        reinterpret_cast<intptr_t>(new RegMatch(region, text)))));
}
Object Object::makeSymbol(const ucs4char* str)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Symbol, reinterpret_cast<intptr_t>(new Symbol(str)))));
}

Object Object::makeBox(Object o)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Box, reinterpret_cast<intptr_t>(new Box(o)))));
}

Object Object::makeByteVector(int n)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::ByteVector, reinterpret_cast<intptr_t>(new ByteVector(n)))));
}

Object Object::makeByteVector(int n, int8_t v)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::ByteVector, reinterpret_cast<intptr_t>(new ByteVector(n, v)))));
}

Object Object::makeStack(Object* src, int size)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Stack, reinterpret_cast<intptr_t>(new Stack(src, size)))));
}


Object Object::makeEqHashTable()
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::EqHashTable, reinterpret_cast<intptr_t>(new EqHashTable()))));
}

Object Object::makeEqvHashTable(VM* theVM)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::EqvHashTable, reinterpret_cast<intptr_t>(new EqvHashTable(theVM)))));
}


Object Object::makeCProcedure(Object (*proc)(VM* vm, int, const Object*))
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::CProcedure, reinterpret_cast<intptr_t>(new CProcedure(proc)))));
}

Object Object::makeCodeBuilder()
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::CodeBuilder,
                                                        reinterpret_cast<intptr_t>(new CodeBuilder()))));
}

Object Object::makeGenericHashTable(VM* theVM, Object hashFunction, Object equivalenceFunction)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::GenericHashTable,
                                                        reinterpret_cast<intptr_t>(new GenericHashTable(theVM, hashFunction, equivalenceFunction)))));
}

Object Object::makeCallable(Callable* callable)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Callable,
                                                        reinterpret_cast<intptr_t>(callable))));
}

Object Object::makeRecordTypeDescriptor(Object name,
                                        Object parent,
                                        Object uid,
                                        Object isSealed,
                                        Object isOpaque,
                                        Object fields)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::RecordTypeDescriptor,
                                                        reinterpret_cast<intptr_t>(new RecordTypeDescriptor(name,
                                                                                                        parent,
                                                                                                        uid,
                                                                                                        isSealed,
                                                                                                        isOpaque,
                                                                                                        fields)))));
}

Object Object::makeRecord(Object rtd, const Object* fields, int fieldsLength)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Record,
                                                        reinterpret_cast<intptr_t>(new Record(rtd,
                                                                                          fields,
                                                                                          fieldsLength)))));
}

Object Object::makeRecordConstructorDescriptor(VM* theVM,
                                               Object rtd,
                                               Object parentRcd,
                                               Object protocol)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::RecordConstructorDescriptor,
                                                        reinterpret_cast<intptr_t>(new RecordConstructorDescriptor(theVM,
                                                                                                               rtd,
                                                                                                               parentRcd,
                                                                                                               protocol)))));
}

Object Object::makeCompoundCondition(int conditionCounts, const Object* conditions)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::CompoundCondition,
                                                        reinterpret_cast<intptr_t>(new CompoundCondition(conditionCounts,
                                                                                                     conditions)))));
}

Object Object::makeCompoundCondition(Object conditions)
{
    const int conditionCounts = Pair::length(conditions);
    Object* conditionsArray = Object::makeObjectArray(conditionCounts);
    Object p = conditions;
    for (int i = 0; i < conditionCounts; i++) {
        conditionsArray[i] = p.car();
        p = p.cdr();
    }
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::CompoundCondition,
                                                        reinterpret_cast<intptr_t>(new CompoundCondition(conditionCounts,
                                                                                                     conditionsArray)))));
}

Object Object::makeRatnum(int numerator, int denominator)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Ratnum,
                                                        reinterpret_cast<intptr_t>(new Ratnum(numerator, denominator)))));
}

Object Object::makeRatnum(Ratnum* r)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Ratnum,
                                                        reinterpret_cast<intptr_t>(r))));
}

Object Object::makeCompnum(Object real, Object imag)
{
    if (Arithmetic::isExactZero(imag)) {
        return real;
    } else {
        return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Compnum,
                                                            reinterpret_cast<intptr_t>(new Compnum(real, imag)))));
    }
}

Object Object::makeSocket(const Socket* socket)
{
    return Object(reinterpret_cast<intptr_t>(new HeapObject(HeapObject::Socket,
                                                        reinterpret_cast<intptr_t>(socket))));
}

bool Object::isIntegerValued() const
{
    return Arithmetic::isIntegerValued(*this);
}

bool Object::isList() const
{
    return Pair::isList(*this);
}

bool Object::isOctet() const
{
    return (isFixnum() && ByteVector::isOctet(toFixnum()));
}
