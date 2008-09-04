/*
 * Port.h - <port>
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
 *  $Id$
 */

#ifndef __SCHEME_PORT_H__
#define __SCHEME_PORT_H__

#include "scheme.h"
#include "BinaryInputPort.h"
#include "BinaryOutputPort.h"
#include "ByteArrayBinaryInputPort.h"
#include "FileBinaryInputPort.h"
#include "FileBinaryOutputPort.h"
#include "CustomBinaryInputPort.h"
#include "TextualOutputPort.h"

namespace scheme {


//----------------------------------------------------------------------
//    Binary output port
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//    Codec and Transcoder
//----------------------------------------------------------------------
class Codec EXTEND_GC
{
public:
    virtual ~Codec() {}
    virtual int out(BinaryOutputPort* port, ucs4char c) = 0;
    virtual int out(uint8_t* buf, ucs4char c) = 0;
    virtual ucs4char in(BinaryInputPort* port) = 0;
};

class UTF8Codec : public Codec
{
public:
    // Be careful, buf is shared.
    int out(BinaryOutputPort* port, ucs4char u)
    {
        static uint8_t buf[4];
        const int size = out(buf, u);
        return port->putU8(buf, size);
    }

    int out(uint8_t* buf, ucs4char u)
    {
        // UTF8-1
        if (u < 0x80) {
            buf[0] = (uint8_t)u;
            return 1;
        // UTF8-2
        } else if (u < 0x7ff) {
            buf[0] = 0xc0 | ((u >> 6) & 0x1f);
            buf[1] = 0x80 | (u & 0x3f);
            return 2;
        // UTF8-3
        } else if (u < 0xffff) {
            buf[0] = 0xe0 | ((u >> 12) & 0xf);
            buf[1] = 0x80 | ((u >> 6) & 0x3f);
            buf[2] = 0x80 | (u & 0x3f);
            return 3;
        // UTF8-4
        } else if (u < 0x10ffff) {
            buf[0] = 0xf0 | ((u >> 18) & 0x7);
            buf[1] = 0x80 | ((u >> 12) & 0x3f);
            buf[2] = 0x80 | ((u >> 6) & 0x3f);
            buf[3] = 0x80 | (u & 0x3f);
            return 4;
        } else {
//            fprintf(stderr, "malformed utf8 error\n");
            return 0;
//            exit(-1);
        }
    }

    bool isUtf8Tail(uint8_t b)
    {
        return (0x80 <= b && b <= 0xbf);
    }

    ucs4char in(BinaryInputPort* port)
    {
        const int f = port->getU8();
        if (f == EOF) return EOF;
        uint8_t first = (uint8_t)(f & 0xff);

        // UTF8-1(ascii) = %x00-7F
        if (first < 0x80) {
            return first;
            // UTF8-2 = %xC2-DF UTF8-tail
        } else if (0xc2 <= first && first <= 0xdf) {
            uint8_t second = port->getU8();
            if (isUtf8Tail(second)) {
                return ((first & 0x1f) << 6) | (second & 0x3f);
            } else {
                // error
                printf("%s %s:%d\n", __func__, __FILE__, __LINE__);fflush(stdout);// debug
                fprintf(stderr, "%s first = %x error\n", __func__, first);
                exit(-1);
            }
            // UTF8-3 = %xE0 %xA0-BF UTF8-tail / %xE1-EC 2( UTF8-tail ) /
            //          %xED %x80-9F UTF8-tail / %xEE-EF 2( UTF8-tail )
        } else if (0xe0 <= first && first <= 0xef) {
            uint8_t second = port->getU8();
            uint8_t third =  port->getU8();
            if (!isUtf8Tail(third)) {
                // error
                printf("%s %s:%d\n", __func__, __FILE__, __LINE__);fflush(stdout);// debug
                fprintf(stderr, "%s first = %x error\n", __func__, first);
                exit(-1);
            } else if ((0xe0 == first && 0xa0 <= second && second <= 0xbf)    |
                       (0xed == first && 0x80 <= second && second <= 0x9f)    |
                       (0xe1 <= first && first <= 0xec && isUtf8Tail(second)) |
                       (0xee == first || 0xef == first) && isUtf8Tail(second)) {
                return ((first & 0xf) << 12) | ((second & 0x3f) << 6) | (third & 0x3f);
            } else {
                // error
                return 0;
            }
            // UTF8-4 = %xF0 %x90-BF 2( UTF8-tail ) / %xF1-F3 3( UTF8-tail ) /
            //          %xF4 %x80-8F 2( UTF8-tail )
        } else if (0xf0 <= first && first <= 0xf4) {
            uint8_t second =  port->getU8();
            uint8_t third =  port->getU8();
            uint8_t fourth = port->getU8();
            if (!isUtf8Tail(third) || !isUtf8Tail(fourth)) {
                printf("%s %s:%d\n", __func__, __FILE__, __LINE__);fflush(stdout);// debug
                // error
                fprintf(stderr, "%s first = %x error\n", __func__, first);
                exit(-1);
            } else if ((0xf0 == first && 0x90 <= second && second <= 0xbf)     |
                       (0xf4 == first && 0x80 <= second && second <= 0x8f)     |
                       (0xf1 <= first && first <= 0xf3 && isUtf8Tail(second))) {
                return ((first & 0x7) << 18) | ((second & 0x3f) << 12) | ((third & 0x3f) << 6) | fourth;
            } else {
                // error
                printf("%s %s:%d\n", __func__, __FILE__, __LINE__);fflush(stdout);// debug
                fprintf(stderr, "%s first = %x error\n", __func__, first);
                exit(-1);
            }
        } else {
            // error
            printf("%s %s:%d\n", __func__, __FILE__, __LINE__);fflush(stdout);// debug
            fprintf(stderr, "%s first = %x error\n", __func__, first);
            exit(-1);
        }
    }
};

class Transcoder EXTEND_GC
{
public:
    enum EolStyle
    {
        LF,
        CR,
        CRLF,
        NEL,
        CRNEL,
        LS,
        NONE,
    };
    enum ErrorHandlingMode
    {
        IGNORE_ERROR,
        RAISE,
        REPLACE,
    };
    Transcoder(Codec* codec, enum EolStyle e, enum ErrorHandlingMode m) : codec_(codec)
    {
    }

    Transcoder(Codec* codec) : codec_(codec)
    {
    }


    Codec* getCodec() const { return codec_; }

private:
    Codec* codec_;
};

//----------------------------------------------------------------------
//    Textual output port
//----------------------------------------------------------------------

class StringTextualOutputPort : public TextualOutputPort
{
public:
    StringTextualOutputPort() : index_(0) {}
    virtual ~StringTextualOutputPort() {}

    void putChar(ucs4char c)
    {
        buffer_ += c;
        index_++;
    }

    ucs4string getString() { return buffer_; }

    int close()
    {
        return 0;
    }

private:
    ucs4string buffer_;
    ucs4string::size_type index_;
};

class TextualByteVectorOutputPort : public TextualOutputPort
{
public:
    TextualByteVectorOutputPort(Transcoder* transcoder) : transcoder_(transcoder), codec_(transcoder->getCodec()) {}
    virtual ~TextualByteVectorOutputPort() {}

    void putChar(ucs4char c)
    {
        uint8_t buf[4];
        const int size = codec_->out(buf, c);
        for (int i = 0; i < size; i++) {
            v_.push_back(buf[i]);
        }
    }

    const gc_vector<uint8_t>& getByteVector() const
    {
        return v_;
    }

    int close()
    {
        return 0;
    }


private:
    Transcoder* transcoder_;
    Codec* codec_;
    gc_vector<uint8_t> v_;
};

//----------------------------------------------------------------------
//    Textual input port
//----------------------------------------------------------------------
class TextualInputPort EXTEND_GC
{
public:
    TextualInputPort(BinaryInputPort* port, Transcoder* coder) : port_(port), codec_(coder->getCodec()), coder_(coder), line_(1)
    {
    }

    TextualInputPort() {}

    virtual ~TextualInputPort()
    {
    }

    virtual ucs4char getChar()
    {
        ucs4char c;
        if (buffer_.empty()) {
            c= codec_->in(port_);
        } else {
            c = buffer_[buffer_.size() - 1];
            buffer_.erase(buffer_.size() - 1, 1);
        }
        if (c == '\n') ++line_;
        return c;
    }

    virtual int getLine() const { return line_; }

    virtual void unGetChar(ucs4char c)
    {
        if (EOF == c) return;
        buffer_ += c;
    }

    virtual ucs4string toString() {
        return port_->toString();
    }

    virtual void setError(Object error)
    {
        error_ = error;
    }

    virtual Object error() const
    {
        return error_;
    }

    virtual Object getDatum(bool& errorOccured)
    {
        return read(this, errorOccured);
    }

    virtual Object getDatum2()
    {
        return read2(this);
    }

    virtual int close()
    {
        return port_->close();
    }

private:
    BinaryInputPort* port_;
    Codec* codec_;
    Transcoder* coder_;
    ucs4string buffer_;
    int line_;
    Object error_;
};

class StringTextualInputPort : public TextualInputPort
{
public:
    StringTextualInputPort(const ucs4string& str) : buffer_(str), index_(0) {}
    virtual ~StringTextualInputPort() {}

    ucs4char getChar()
    {
        if (buffer_.size() == index_)
        {
            return EOF;
        }
        return buffer_[index_++];
    }

    void unGetChar(ucs4char c)
    {
        if (EOF == c) return;
        index_--;
    }

    ucs4string toString() {
        return UC("<string port>");
    }

    int close() { return 0; }

private:
    ucs4string buffer_;
    ucs4string::size_type index_;
};

bool fileExistsP(const ucs4string& file);

}; // namespace scheme

#endif // __SCHEME_PORT_H__
