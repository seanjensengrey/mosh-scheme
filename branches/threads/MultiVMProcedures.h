/*
 * MultiVMProcedures.h - 
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
 *  $Id: MultiVMProcedures.h 261 2008-07-25 06:16:44Z higepon $
 */

#ifndef SCHEME_MULTI_VM_PROCEDURES_
#define SCHEME_MULTI_VM_PROCEDURES_

#include "scheme.h"
#include "OSCompatThread.h"

namespace scheme {


    class MultiVMManager EXTEND_GC
    {
    private:
        typedef gc_vector<Thread*> Threads;
        Threads* threads_;
    public:
        MultiVMManager() : threads_(new gc_vector<Thread*>)
        {
        }
        void add(Thread* thread)
        {
            threads_->push_back(thread);
        }
        void remove(Thread* thread)
        {
            Threads::iterator it = threads_->begin();
            while (it != threads_->end()) {
                if (thread == *it) {
                    threads_->erase(it);
                    return;
                }
                it++;
            }
            MOSH_ASSERT(false);
        }
        void joinAll()
        {
            for (Threads::iterator it = threads_->begin(); it != threads_->end(); ++it) {
                (*it)->join(NULL);
            }
        }
    };

    Object vmPEx(VM* theVM, int argc, const Object* argv);
    Object makeVmEx(VM* theVM, int argc, const Object* argv);
    Object vmStartDEx(VM* theVM, int argc, const Object* argv);
//    Object vmSpecificEx(VM* theVM, int argc, const Object* argv);
    MultiVMManager* getMultiVMManager();
}; // namespace scheme

#endif // SCHEME_MULTI_VM_PROCEDURES_
