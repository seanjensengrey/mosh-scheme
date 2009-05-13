/*
 * Ratnum.cpp -
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
 *  $Id: Ratnum.cpp 183 2008-07-04 06:19:28Z higepon $
 */

#include "Object.h"
#include "Object-inl.h"
#include "Bignum.h"
#include "Ratnum.h"


using namespace scheme;

Object Ratnum::sqrt() const
{
    if (mpq_sgn(value) >= 0) {
        return sqrtUnsigned(value);
    } else {
        mpq_t neg;
        mpq_init(neg);
        mpq_neg(neg, value);
        return Object::makeCompnum(Object::makeFixnum(0),
                                   sqrtUnsigned(neg));
    }
}

Object Ratnum::sqrtUnsigned(const mpq_t r) const
{
    MOSH_ASSERT(mpq_sgn(value) >= 0);
    mpz_t num;
    mpz_t den;
    mpz_init(num);
    mpz_init(den);
    mpz_sqrt(num, mpq_numref(value));
    mpz_sqrt(den, mpq_denref(value));
    mpq_t ret;
    mpq_init(ret);
    mpq_set_num(ret, num);
    mpq_set_den(ret, den);
    mpz_clear(num); // we have to this. mpq_set_den/num just copy
    mpz_clear(den);
    return makeNumber(ret);
}

Object Ratnum::floor() const
{
    Bignum temp;
    mpz_fdiv_q(temp.value_,  mpq_numref(value), mpq_denref(value));
    return Bignum::makeInteger(temp.value_);
}

Object Ratnum::ceiling() const
{
    Bignum temp;
    mpz_cdiv_q(temp.value_, mpq_numref(value), mpq_denref(value));
    return Bignum::makeInteger(temp.value_);
}

Object Ratnum::truncate() const
{
    Bignum temp;
    mpz_tdiv_q(temp.value_, mpq_numref(value), mpq_denref(value));
    return Bignum::makeInteger(temp.value_);
}

Object Ratnum::round() const
{
    Ratnum* half = new Ratnum(1, 2);
    Object n = Ratnum::add(half, (Ratnum*)this);
    const Object ret = Arithmetic::floor(n);

    if (!Arithmetic::eq(ret, n)) {
        return ret;
    } else {
        const Object d = Arithmetic::mul(ret, Object::makeRatnum(half));
        if (Arithmetic::eq(d, Arithmetic::floor(d))) {
            return ret;
        } else {
            return Arithmetic::sub(ret, Object::makeFixnum(1));
        }
    }
}
