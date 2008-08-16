/*
 * StringProcedures.cpp - <string> prcedures.
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
 *  $Id: StringProcedures.cpp 183 2008-07-04 06:19:28Z higepon $
 */

#include "StringProcedures.h"
#include "ProcedureMacro.h"

using namespace scheme;

extern scheme::VM* theVM;

static Object makeList(scheme::gc_vector<ucs4string>& v, scheme::gc_vector<ucs4string>::size_type i);

Object scheme::stringRefEx(int argc, const Object* argv)
{
    DeclareProcedureName("string-ref");
    checkArgumentLength(2);

    argumentAsString(0, text);
    argumentAsInt(1, index);

    return Object::makeChar(text->charAt(index));
}

Object scheme::stringEqPEx(int argc, const Object* argv)
{
    DeclareProcedureName("string=?");
    checkArgumentLength(2);

    argumentAsString(0, string1);
    argumentAsString(1, string2);
    return Object::makeBool(*string1 == *string2);
}

Object scheme::stringToregexpEx(int argc, const Object* argv)
{
    DeclareProcedureName("string->regexp");
    checkArgumentLength(1);
    argumentAsString(0, text);
    return Object::makeRegexp(text->data());
}

Object scheme::makeStringEx(int argc, const Object* argv)
{
    DeclareProcedureName("make-string");
    checkArgumentLengthBetween(1, 2);
    argumentAsInt(0, stringSize);

    if (2 == argc) {
        argumentAsChar(1, ch);
        return Object::makeString(stringSize, ch);
    } else {
        return Object::makeString(stringSize);
    }
}

Object scheme::stringSetDEx(int argc, const Object* argv)
{
    DeclareProcedureName("string-set!");
    checkArgumentLength(3);

    argumentAsString(0, text);
    argumentAsInt(1, index);
    argumentAsChar(2, ch);

    text->data()[index] = ch;
    return Object::Undef;
}

Object scheme::stringLengthEx(int argc, const Object* argv)
{
    DeclareProcedureName("string-length");
    checkArgumentLength(1);
    argumentAsString(0, text);
    return Object::makeInt(text->data().length());
}

Object scheme::stringTosymbol(Object str)
{
    MOSH_ASSERT(str.isString());
    return Symbol::intern(str.toString()->data().c_str());
}

Object scheme::stringTosymbolEx(int argc, const Object* argv)
{
    DeclareProcedureName("string->symbol");
    checkArgumentLength(1);
    argumentCheckString(0, text);
    return stringTosymbol(text);
}

Object scheme::stringTonumberEx(int argc, const Object* argv)
{
    DeclareProcedureName("string->number");
    checkArgumentLength(1);
    argumentAsString(0, text);
    return Object::makeInt(atoi(text->data().ascii_c_str()));
}

Object scheme::stringAppendEx(int argc, const Object* argv)
{
    DeclareProcedureName("string-append");
    ucs4string ret;
    for (int i = 0; i < argc; i++) {
        argumentAsString(i, text);
        ret += text->data();
    }
    return Object::makeString(ret);
}

Object scheme::stringSplitEx(int argc, const Object* argv)
{
    DeclareProcedureName("string-split");
    argumentAsString(0, text);
    argumentAsChar(1, ch);

    gc_vector<ucs4string> v;
    text->data().split(ch, v);
    return makeList(v, 0);
}

Object makeList(scheme::gc_vector<ucs4string>& v, scheme::gc_vector<ucs4string>::size_type i)
{
    if (i == v.size()) {
        return Object::Nil;
    } else {
        return Object::cons(Object::makeString(v[i]), makeList(v, i + 1));
    }
}
