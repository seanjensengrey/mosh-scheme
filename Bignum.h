/*
 * Bignum.h -
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
 *  $Id: Bignum.h 261 2008-07-25 06:16:44Z higepon $
 */

#ifndef SCHEME_BIGNUM_
#define SCHEME_BIGNUM_

#include "scheme.h"
#include "Fixnum.h"

#ifdef _WIN32
    #ifdef _WIN64
        #define MOSH_BIGNUM_SIZEOF_INTPTR_T 8
    #else
        #define MOSH_BIGNUM_SIZEOF_INTPTR_T 4
    #endif
#elif defined(__GNUC__) && defined(__WORDSIZE)
    #if (__WORDSIZE == 64)
        #define MOSH_BIGNUM_SIZEOF_INTPTR_T 8
    #else
        #define MOSH_BIGNUM_SIZEOF_INTPTR_T 4
    #endif
#else
    #error "define MOSH_BIGNUM_SIZEOF_INTPTR_T"
#endif

namespace scheme {

class Bignum EXTEND_GC
{
public:
    ~Bignum();
    Bignum()
    {
        mpz_init(this->value);
    }

    Bignum(long value)
    {
        mpz_init(this->value);
        mpz_set_si(this->value, value);
    }

    Bignum(const mpz_t value)
    {
        mpz_init_set(this->value, value);
    }


    char* toString(int radix = 10) const;

    double toDouble() const
    {
        return mpz_get_d(value);
    }


    bool isEven() const
    {
        return mpz_even_p(value) != 0;
    }

    Object sqrt() const;

    Object abs() const
    {
        Bignum* const b = new Bignum;
        mpz_abs(b->value, value);
        return makeInteger(b);
    }

    bool isNegative() const
    {
        return mpz_cmp_si(value, 0) < 0;
    }

    bool fitsU32() const
    {
        return mpz_cmp_si(value, 0)
            && mpz_popcount(value) <= 32;
    }

    // todo fix me
    bool fitsS32() const
    {
        mpz_t temp;
        mpz_init(temp);
        mpz_abs(temp, value);
        return mpz_popcount(temp) <= 31;
    }

    uint32_t toU32() const
    {
        return (uint32_t)mpz_get_ui(value);
    }

    int32_t toS32() const
    {
        MOSH_ASSERT(fitsS32());
            return (int32_t)mpz_get_si(value);
    }

    bool fitsU64() const
    {
        return mpz_cmp_si(value, 0)
            && mpz_popcount(value) <= 64;
    }

    // todo fix me
    bool fitsS64() const
    {
        mpz_t temp;
        mpz_init(temp);
        mpz_abs(temp, value);
        return mpz_popcount(temp) <= 63;
    }

    uint64_t toU64() const
    {
        MOSH_ASSERT(fitsU64());
#if (MOSH_BIGNUM_SIZEOF_INTPTR_T == 4)
        uint64_t ret = 0;
        mpz_t temp;
        mpz_init(temp);
        mpz_fdiv_q_2exp(temp, value, 32);
        ret = mpz_get_ui(temp);
        ret = ret << 32; // upper 32bit
        mpz_set_ui(temp, 0xffffffff);
        mpz_and(temp, value, temp);
        ret += mpz_get_ui(temp); // lower 32bit
        return ret;
#else
        return mpz_get_ui(value);
#endif
    }

    int64_t toS64() const
    {
        MOSH_ASSERT(fitsS64());
#if (MOSH_BIGNUM_SIZEOF_INTPTR_T == 4)
        uint64_t ret = 0;
        mpz_t temp;
        mpz_init(temp);
        mpz_fdiv_q_2exp(temp, value, 32);
        ret = mpz_get_si(temp);
        ret = ret << 32; // upper 32bit
        mpz_set_ui(temp, 0xffffffff);
        mpz_and(temp, value, temp);
        ret += mpz_get_ui(temp); // lower 32bit
        return ret;
#else
        return mpz_get_si(value);
#endif
    }

    void setU32(uint32_t value)
    {
        mpz_set_ui(this->value, value);
    }

    void setDouble(double value)
    {
        mpz_set_d(this->value, value);
    }

    Object bitwiseNot() const
    {
        Bignum* b = new Bignum;
        mpz_com(b->value, value);
        return Object::makeBignum(b);
    }

    Object bitwiseAnd(int n)
    {
        return bitwiseAnd(new Bignum(n));
    }

    Object bitwiseAnd(Bignum* b)
    {
        Bignum* ret = new Bignum();
        mpz_and(ret->value, value, b->value);
        return makeInteger(ret);
    }

    Object bitwiseIor(int n)
    {
        return bitwiseIor(new Bignum(n));
    }

    Object bitwiseIor(Bignum* b)
    {
        Bignum* ret = new Bignum();
        mpz_ior(ret->value, value, b->value);
        return Object::makeBignum(ret);
    }

    Object bitwiseXor(int n)
    {
        return bitwiseXor(new Bignum(n));
    }

    Object bitwiseXor(Bignum* b)
    {
        Bignum* ret = new Bignum();
        mpz_xor(ret->value, value, b->value);
        return Object::makeBignum(ret);
    }

    Object bitwiseBitCount()
    {
        if (gt(this, 0)) {
            return makeInteger(mpz_popcount(value));
        } else {
            Bignum* b = new Bignum;
            mpz_com(b->value, value);
            const unsigned long ret = mpz_popcount(b->value);
            return makeInteger(~ret);
        }
    }

    Object bitwiseLength()
    {
        if (mpz_cmp_si(value, 0) < 0) {
            return bitwiseNot().toBignum()->bitwiseLength();
        } else {
            size_t size = mpz_sizeinbase(value, 2);
            return makeInteger(size);
        }
    }

    Object bitwiseFirstBitSet()
    {
        const unsigned long int found = mpz_scan1(value, 0);
        if (found == ULONG_MAX) {
            return Object::makeFixnum(-1);
        } else {
            return makeInteger(found);
        }
    }

    static Object quotient(int n1, const Bignum* n2)
    {
        Bignum* ret = new Bignum(n1);
        mpz_tdiv_q(ret->value, ret->value, n2->value);
        return makeInteger(ret);
    }

    static Object quotient(const Bignum* n1, int n2)
    {
        Bignum* ret = new Bignum(n2);
        mpz_tdiv_q(ret->value, n1->value, ret->value);
        return makeInteger(ret);
    }

    static Object quotient(const Bignum* n1, const Bignum* n2)
    {
        Bignum* ret = new Bignum;
        mpz_tdiv_q(ret->value, n1->value, n2->value);
        return makeInteger(ret);
    }

    static Object remainder(int n1, const Bignum* n2)
    {
        Bignum* ret = new Bignum(n1);
        mpz_tdiv_r(ret->value, ret->value, n2->value);
        return makeInteger(ret);
    }

    static Object remainder(const Bignum* n1, int n2)
    {
        Bignum* ret = new Bignum(n2);
        mpz_tdiv_r(ret->value, n1->value, ret->value);
        return makeInteger(ret);
    }

    static Object remainder(const Bignum* n1, const Bignum* n2)
    {
        Bignum* ret = new Bignum;
        mpz_tdiv_r(ret->value, n1->value, n2->value);
        return makeInteger(ret);
    }


    static Object bitwiseShiftLeft(const Bignum* n1, unsigned long n2)
    {
        Bignum* ret = new Bignum;
        mpz_mul_2exp(ret->value, n1->value, n2);
        return makeInteger(ret);
    }

    static Object bitwiseShiftLeft(int n1, unsigned long n2)
    {
        Bignum* ret = new Bignum(n1);
        mpz_mul_2exp(ret->value, ret->value, n2);
        return makeInteger(ret);
    }

    static Object bitwiseShiftRight(const Bignum* n1, unsigned long n2)
    {
        Bignum* ret = new Bignum;
        mpz_fdiv_q_2exp(ret->value, n1->value, n2);
        return makeInteger(ret);
    }

    static Object bitwiseShiftRight(int n1, unsigned long n2)
    {
        Bignum* ret = new Bignum(n1);
        mpz_fdiv_q_2exp(ret->value, ret->value, n2);
        return makeInteger(ret);
    }


#define MAKE_BIGNUM_OP(op)\
    static Object op(int n1, Bignum* n2)\
    {\
        mpz_t ret;     \
        mpz_init(ret); \
        mpz_set_si(ret, n1); \
        mpz_##op(ret, ret, n2->value);\
        return makeInteger(ret);\
    }\
    static Object op(Bignum* n1, int n2)\
    {\
        mpz_t ret;     \
        mpz_init(ret); \
        mpz_set_si(ret, n2); \
        mpz_##op(ret, n1->value, ret);\
        return makeInteger(ret);\
    }\
    static Object op(Bignum* n1, Bignum* n2)\
    {\
        mpz_t ret;     \
        mpz_init(ret); \
        mpz_##op(ret, n1->value, n2->value);\
        return makeInteger(ret);\
    }

    MAKE_BIGNUM_OP(add)
    MAKE_BIGNUM_OP(sub)
    MAKE_BIGNUM_OP(mul)

#define MAKE_BIGNUM_COMPARE(compare, symbol)\
    static bool compare(Bignum* n1, int n2)\
    {\
        return mpz_cmp_si(n1->value, n2) symbol;\
    }\
    static bool compare(int n1, Bignum* n2)\
    {\
        return (- mpz_cmp_si(n2->value, n1)) symbol;\
    }\
    static bool compare(Bignum* n1, Bignum* n2)\
    {\
        return mpz_cmp(n1->value, n2->value) symbol;\
    }

    MAKE_BIGNUM_COMPARE(gt, >0)
    MAKE_BIGNUM_COMPARE(ge, >=0)
    MAKE_BIGNUM_COMPARE(lt, <0)
    MAKE_BIGNUM_COMPARE(le, <=0)
    MAKE_BIGNUM_COMPARE(eq, ==0)

    static Object add(int n1, int n2)
    {
        const long ret = n1 + n2;
        if (Fixnum::canFit(ret)) {
            return Object::makeFixnum(ret);
        } else {
            return Object::makeBignum(ret);
        }
    }
    static Object sub(int n1, int n2)
    {
        const long ret = n1 - n2;
        if (Fixnum::canFit(ret)) {
            return Object::makeFixnum(ret);
        } else {
            return Object::makeBignum(ret);
        }
    }

    static Object mul(int n1, int n2)
    {
        const long ret = n1 * n2;

        /* Overflow check from Gauche */
        if ((n2 != 0 && ret / n2 != n1) || !Fixnum::canFit(ret)) {
            return Bignum::mul(new Bignum(n1), n2);
        } else {
            return Object::makeFixnum(ret);
        }
    }

    static Object makeIntegerFromU32(uint32_t n)
    {
        if (Fixnum::canFit(n)) {
            return Object::makeFixnum(n);
        } else {
            Bignum* const b = new Bignum();
            b->setU32(n);
            return Object::makeBignum(b);
        }
    }

    static Object makeIntegerFromU64(uint64_t n)
    {
        Bignum* const b = new Bignum();
        b->setU32(n >> 32);
        mpz_mul_2exp(b->value, b->value, 32);
        mpz_add_ui(b->value, b->value, (n & 0xffffffff));
        return makeInteger(b);
    }

    static Object makeIntegerFromS64(int64_t n)
    {
        Bignum* const b = new Bignum();
        mpz_set_si(b->value, n >> 32);
        mpz_mul_2exp(b->value, b->value, 32);
        mpz_add_ui(b->value, b->value, (n & 0xffffffff));
        return makeInteger(b);
    }

    static Object makeIntegerFromIntprt_t(intptr_t p)
    {
        MOSH_ASSERT(sizeof(uint64_t) >= sizeof(intptr_t));
        const uint64_t val = static_cast<uint64_t>(p);
        if (Fixnum::canFit(val)) {
            return Object::makeFixnum(static_cast<int>(val));
        } else {
            return makeIntegerFromU64(val);
        }
    }

    static Object makeIntegerFromUintprt_t(uintptr_t p)
    {
#if (MOSH_BIGNUM_SIZEOF_INTPTR_T == 4)
        const uint32_t val = static_cast<uint32_t>(p);
        if (Fixnum::canFit(val)) {
            return Object::makeFixnum(val);
        } else {
            return makeIntegerFromU32(val);
        }
#else
        const uint64_t val = static_cast<uint64_t>(p);
        if (Fixnum::canFit(val)) {
            return Object::makeFixnum(static_cast<int>(val));
        } else {
            return makeIntegerFromU64(val);
        }
#endif
    }

    intptr_t toIntptr_t()
    {
#if (MOSH_BIGNUM_SIZEOF_INTPTR_T == 4)
        return toS32();
#else
        return toS64();
#endif
    }

    uintptr_t toUintptr_t()
    {
#if (MOSH_BIGNUM_SIZEOF_INTPTR_T == 4)
        return toU32();
#else
        return toU64();
#endif
    }


    static intptr_t toIntptr_t(Object n)
    {
        MOSH_ASSERT(n.isFixnum() || n.isBignum());
        if (n.isFixnum()) {
            return n.toFixnum();
        } else if (n.isBignum()) {
            return n.toBignum()->toIntptr_t();
        } else {
            // not reached
            return 0;
        }
    }

    static uintptr_t toUintptr_t(Object n)
    {
        MOSH_ASSERT(n.isFixnum() || n.isBignum());
        if (n.isFixnum()) {
            return n.toFixnum();
        } else if (n.isBignum()) {
            return n.toBignum()->toUintptr_t();
        } else {
            // not reached
            return 0;
        }
    }


    static Object makeInteger(long n)
    {
        if (Fixnum::canFit(n)) {
            return Object::makeFixnum(n);
        } else {
            return Object::makeBignum(n);
        }
    }

    static Object makeInteger(const mpz_t n)
    {
        if (mpz_fits_slong_p(n) != 0) {
            const intptr_t val = mpz_get_si(n);
            if (val >= Fixnum::MIN &&
                val <= Fixnum::MAX) {
                return Object::makeFixnum(val);
            }
        }
        return Object::makeBignum(n);
    }

    static Object makeInteger(Bignum* b)
    {
        return makeInteger(b->value);
    }

    static Object makeInteger(const ucs4string& text)
    {
        mpz_t v;
        mpz_init(v);
        mpz_init_set_str(v, text.ascii_c_str(), 10);
        return makeInteger(v);
    }


    mpz_t value;

private:
};

inline Object Object::makeBignum(long n)
{
    return Object(reinterpret_cast<word>(new HeapObject(HeapObject::Bignum,
                                                        reinterpret_cast<word>(new Bignum(n)))));
}

inline Object Object::makeBignum(const mpz_t b)
{
    return Object(reinterpret_cast<word>(new HeapObject(HeapObject::Bignum,
                                                        reinterpret_cast<word>(new Bignum(b)))));
}

inline Object Object::makeBignum(Bignum* b)
{
    return Object(reinterpret_cast<word>(new HeapObject(HeapObject::Bignum,
                                                        reinterpret_cast<word>(b))));
}

} // namespace scheme

#endif // SCHEME_BIGNUM_
