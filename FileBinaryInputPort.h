/*
 * FileBinaryInputPort.h - <file binary input port>
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
 *  $Id: FileBinaryInputPort.h 261 2008-07-25 06:16:44Z higepon $
 */

#ifndef __SCHEME_FILE_BINARY_INPUT_PORT__
#define __SCHEME_FILE_BINARY_INPUT_PORT__

#include "BinaryInputPort.h"

namespace scheme {

class FileBinaryInputPort : public BinaryInputPort
{
public:
    FileBinaryInputPort(FILE* stream);
    FileBinaryInputPort(int fd);
    FileBinaryInputPort(ucs4string file);
    FileBinaryInputPort(const char* file);
    virtual ~FileBinaryInputPort();

    ucs4string toString();
    int getU8();
    ByteVector* getByteVector(int size);
    int open();
    int close();
    int fileno() const;
    virtual bool isClosed() const;

private:
    int fd_;
    FILE* stream_; // todo: delete
    ucs4string fileName_;
    bool isClosed_;
};

}; // namespace scheme

#endif // __SCHEME_FILE_BINARY_INPUT_PORT__
