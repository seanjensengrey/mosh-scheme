/*
 * FFIProcedreus.h - <ffi> procedures.
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
 *  $Id: FFIProcedreus.h 261 2008-07-25 06:16:44Z higepon $
 */

#ifndef SCHEME_FFI_PROCEDURES_
#define SCHEME_FFI_PROCEDURES_

#include "scheme.h"

namespace scheme {

Object internalFfiMallocEx(VM* theVM, int argc, const Object* argv);
Object internalFfiFreeEx(VM* theVM, int argc, const Object* argv);
Object internalFfiSupportedPEx(VM* theVM, int argc, const Object* argv);
Object internalFfiLookupEx(VM* theVM, int argc, const Object* argv);
Object internalFfiOpenEx(VM* theVM, int argc, const Object* argv);
Object internalFfiCallTointEx(VM* theVM, int argc, const Object* argv);
Object internalFfiCallTocharEx(VM* theVM, int argc, const Object* argv);
Object internalFfiCallTodoubleEx(VM* theVM, int argc, const Object* argv);
Object internalFfiCallTovoidEx(VM* theVM, int argc, const Object* argv);
Object internalFfiCallTovoidMulEx(VM* theVM, int argc, const Object* argv);
Object internalFfiMakeCCallbackTrampolineEx(VM* theVM, int argc, const Object* argv);
Object sharedErrnoEx(VM* theVM, int argc, const Object* argv);

Object pointerPEx(VM* theVM, int argc, const Object* argv);
Object pointerTointegerEx(VM* theVM, int argc, const Object* argv);
Object integerTopointerEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCInt8DEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCInt16DEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCInt32DEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCInt64DEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCUint8DEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCUint16DEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCUint32DEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCUint64DEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCPointerDEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCDoubleDEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCFloatDEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCLongLongDEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCLongDEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCIntDEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCShortDEx(VM* theVM, int argc, const Object* argv);
Object pointerSetCCharDEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCPointerEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCDoubleEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCFloatEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCUint8Ex(VM* theVM, int argc, const Object* argv);
Object pointerRefCUint16Ex(VM* theVM, int argc, const Object* argv);
Object pointerRefCUint32Ex(VM* theVM, int argc, const Object* argv);
Object pointerRefCUint64Ex(VM* theVM, int argc, const Object* argv);
Object pointerRefCInt8Ex(VM* theVM, int argc, const Object* argv);
Object pointerRefCInt16Ex(VM* theVM, int argc, const Object* argv);
Object pointerRefCInt32Ex(VM* theVM, int argc, const Object* argv);
Object pointerRefCInt64Ex(VM* theVM, int argc, const Object* argv);
Object pointerRefCUnsignedLongLongEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCSignedLongLongEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCUnsignedLongEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCSignedLongEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCUnsignedIntEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCSignedIntEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCUnsignedShortEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCSignedShortEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCUnsignedCharEx(VM* theVM, int argc, const Object* argv);
Object pointerRefCSignedCharEx(VM* theVM, int argc, const Object* argv);


} // namespace scheme

#endif // SCHEME_FFI_PROCEDURES_
