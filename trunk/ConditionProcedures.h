/*
 * ConditionProcedures.h - 
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
 *  $Id: ConditionProcedures.h 261 2008-07-25 06:16:44Z higepon $
 */

#ifndef __SCHEME_CONDITION_PROCEDURES__
#define __SCHEME_CONDITION_PROCEDURES__

#include "scheme.h"
#include "Callable.h"

namespace scheme {

    Object conditionAccessorEx(VM* theVM, int argc, const Object* argv);
    Object conditionPredicateEx(VM* theVM, int argc, const Object* argv);
    Object conditionPEx(VM* theVM, int argc, const Object* argv);
    Object simpleConditionsEx(VM* theVM, int argc, const Object* argv);
    Object conditionEx(VM* theVM, int argc, const Object* argv);

    class ConditionPredicate : public Callable
    {
    public:
        ConditionPredicate(Object rtd);
        ~ConditionPredicate();

        Object call(VM* vm, int argc, const Object* argv);

    private:
        const Object rtd_;
    };

    class ConditionAccessor : public Callable
    {
    public:
        ConditionAccessor(Object rtd, Object proc);
        ~ConditionAccessor();

        Object call(VM* vm, int argc, const Object* argv);

    private:
        const Object rtd_;
        const Object proc_;
    };


}; // namespace scheme

#endif // __SCHEME_CONDITION_PROCEDURES__