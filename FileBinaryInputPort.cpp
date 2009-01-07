/*
 * FileBinaryInputPort.cpp -
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
 *  $Id: FileBinaryInputPort.cpp 183 2008-07-04 06:19:28Z higepon $
 */

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "Object.h"
#include "Object-inl.h"
#include "HeapObject.h"
#include "SString.h"
#include "Pair.h"
#include "Pair-inl.h"
#include "ByteVector.h"
#include "FileBinaryInputPort.h"

using namespace scheme;

FileBinaryInputPort::FileBinaryInputPort(FILE* stream) : stream_(stream), fileName_(UC("<unknown file>")), isClosed_(false)
{
    fd_ = fileno(stream_); // temp
}

FileBinaryInputPort::FileBinaryInputPort(int fd) : fd_(fd), fileName_(UC("<unknown file>")), isClosed_(false)
{
}

FileBinaryInputPort::FileBinaryInputPort(ucs4string file) : fileName_(file), isClosed_(false)
{
    fd_ = ::open(file.ascii_c_str(), O_RDONLY);
}

FileBinaryInputPort::FileBinaryInputPort(const char* file)
{
    fileName_ = Object::makeString(file).toString()->data();
    fd_ = ::open(file, O_RDONLY);
}

int FileBinaryInputPort::open()
{
    if (-1 == fd_) {
        return MOSH_FAILURE;
    } else {
        return MOSH_SUCCESS;
    }
}

ucs4string FileBinaryInputPort::toString()
{
    return fileName_;
}

FileBinaryInputPort::~FileBinaryInputPort()
{
    close();
}

int FileBinaryInputPort::getU8()
{
    uint8_t c;
    if (0 == read(fd_, &c, 1)) {
        return EOF;
    } else {
        return c;
    }
}

ByteVector* FileBinaryInputPort::getByteVector(int size)
{
#ifdef USE_BOEHM_GC
    uint8_t* buf = new(PointerFreeGC) uint8_t[size];
#else
    uint8_t* buf = new uint8_t[size];
#endif
    int ret = read(fd_, buf, size);
    return new ByteVector(ret, buf);
}

bool FileBinaryInputPort::isClosed() const
{
    return isClosed_;
}

int FileBinaryInputPort::close()
{
    if (!isClosed() && fd_ != -1) {
        isClosed_ = true;
        if (fd_ != fileno(stdin)) {
            ::close(fd_);
        }
    }
    return MOSH_SUCCESS;
}
