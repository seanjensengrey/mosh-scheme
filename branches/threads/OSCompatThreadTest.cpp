/*
 * OSCompatThreadTest - Test for OS compatibility thread functions
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
 *  $Id: TestVector.cpp 183 2008-07-04 06:19:28Z higepon $
 */
#include <gtest/gtest.h>

#include "scheme.h"
#include "Object.h"
#include "Object-inl.h"
#include "Pair.h"
#include "Pair-inl.h"
#include "OSCompat.h"
#include "ByteVector.h"
#include "PortProcedures.h"
#include "OSCompatThread.h"

using namespace scheme;

class MoshTest : public testing::Test {
protected:
    virtual void SetUp() {
        mosh_init();
    }
};

static void* return1Func(void* param)
{
    static int ret = 1;
    return &ret;
}

static void* return2Func(void* param)
{
    static int ret = 2;
    return &ret;
}

static void* returnFixnum(void* param)
{
    static Object ret = Object::makeFixnum((int)param + 1234);
    return &ret;
}


TEST_F(MoshTest, simple) {
    Thread thread;
    ASSERT_TRUE(thread.create(return1Func, NULL));
    int* ret;
    ASSERT_TRUE(thread.join((void**)&ret));
    EXPECT_EQ(1, *ret);
}

TEST_F(MoshTest, simpleObject) {
    Thread thread;
    ASSERT_TRUE(thread.create(returnFixnum, (void*)2));
    Object* ret;
    ASSERT_TRUE(thread.join((void**)&ret));
    EXPECT_EQ(1236, (*ret).toFixnum());
}


TEST_F(MoshTest, twoThreads) {
    Thread thread1;
    ASSERT_TRUE(thread1.create(return1Func, NULL));
    int* ret;
    ASSERT_TRUE(thread1.join((void**)&ret));

    Thread thread2;
    ASSERT_TRUE(thread2.create(return2Func, NULL));
    ASSERT_TRUE(thread2.join((void**)&ret));
    EXPECT_EQ(2, *ret);
}

TEST_F(MoshTest, twoThreads2) {
    Thread thread1;
    ASSERT_TRUE(thread1.create(return1Func, NULL));
    int* ret;

    Thread thread2;
    ASSERT_TRUE(thread2.create(return2Func, NULL));
    ASSERT_TRUE(thread2.join((void**)&ret));
    EXPECT_EQ(2, *ret);
    ASSERT_TRUE(thread1.join((void**)&ret));
    EXPECT_EQ(1, *ret);
}

