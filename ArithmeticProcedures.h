/*
 * ArithmeticProcedures.h - arithmetic procedures.
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
 *  $Id: ArithmeticProcedures.h 261 2008-07-25 06:16:44Z higepon $
 */

#ifndef __SCHEME_ARITHMETIC_PROCEDURES__
#define __SCHEME_ARITHMETIC_PROCEDURES__

#include "scheme.h"
#include "ErrorProcedures.h"

namespace scheme {

    Object infinitePEx(int argc, const Object* argv);
    Object finitePEx(int argc, const Object* argv);
    Object nanPEx(int argc, const Object* argv);
    Object inexactEx(int argc, const Object* argv);
    Object exactEx(int argc, const Object* argv);
    Object exactPEx(int argc, const Object* argv);
    Object inexactPEx(int argc, const Object* argv);
    Object realPartEx(int argc, const Object* argv);
    Object imagPartEx(int argc, const Object* argv);
    Object numberPEx(int argc, const Object* argv);
    Object rationalPEx(int argc, const Object* argv);
    Object flonumPEx(int argc, const Object* argv);
    Object bignumPEx(int argc, const Object* argv);
    Object fixnumPEx(int argc, const Object* argv);
    Object makeComplexEx(int argc, const Object* argv);
    Object fixnumWidthEx(int argc, const Object* argv);
    Object leastFixnumEx(int argc, const Object* argv);
    Object greatestFixnumEx(int argc, const Object* argv);
    Object quotientEx(int argc, const Object* argv);
    Object remainderEx(int argc, const Object* argv);
    Object maxEx(int argc, const Object* argv);
    Object minEx(int argc, const Object* argv);
    Object eqEx(int argc, const Object* argv);
    Object gtEx(int argc, const Object* argv);
    Object geEx(int argc, const Object* argv);
    Object ltEx(int argc, const Object* argv);
    Object leEx(int argc, const Object* argv);
    Object addEx(int argc, const Object* argv);
    Object subEx(int argc, const Object* argv);
    Object mulEx(int argc, const Object* argv);
    Object divideEx(int argc, const Object* argv);

}; // namespace scheme

#endif // __SCHEME_ARITHMETIC_PROCEDURES__
