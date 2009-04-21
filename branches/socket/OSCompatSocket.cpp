/*
 * OSCompatSocket.cpp -
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
 *  $Id: OSCompatSocket.cpp 183 2008-07-04 06:19:28Z higepon $
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

#include "scheme.h"
#include "Object.h"
#include "Object-inl.h"
#include "Pair.h"
#include "Pair-inl.h"
#include "UTF8Codec.h"
#include "Transcoder.h"
#include "OSCompat.h"
#include "OSCompatSocket.h"

using namespace scheme;

Socket::Socket(int fd, const ucs4string& address) :
    socket_(fd),
    lastError_(0),
    address_(address)
{

}

Socket::Socket(int domain, int type, int protocol) :
    socket_(socket(domain, type, protocol)),
    lastError_(errno),
    address_(UC(""))
{
}

bool Socket::isOpen() const
{
    return socket_ != -1;
}

ucs4string Socket::getLastErrorMessage() const
{
    return getLastErrorMessageInternal(lastError_);
}

ucs4string Socket::toString() const
{
    if (address_.empty()) {
        return UC("<socket>");
    } else {
        ucs4string ret = UC("<socket ");
        ret += address_;
        ret += UC(">");
        return ret;
    }
}

/**
   read from socket
   @param data [in] buffer to read
   @param size [in] size to read
   @param flags [in] flags
   @retval >=0 read size
   @retval -1 error
*/
int Socket::receive(uint8_t* data, int size, int flags)
{
    MOSH_ASSERT(isOpen());
    return recv(socket_, data, size, flags);
}

// Factories
Socket* Socket::createClientSocket(const char* node,
                                   const char* service,
                                   int ai_family,
                                   int ai_socktype,
                                   int ai_flags,
                                   int ai_protocol,
                                   bool& isErrorOccured,
                                   ucs4string& errorMessage)
{
    struct addrinfo hints;
    memset(&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = ai_family;
    hints.ai_socktype = ai_socktype;
    hints.ai_flags = ai_flags;
    hints.ai_protocol = ai_protocol;
    hints.ai_canonname = NULL;
    hints.ai_addr = NULL;
    hints.ai_next = NULL;
    struct addrinfo* result;
    int ret;

    // TODO server socket?
    MOSH_ASSERT(!((ai_flags & AI_PASSIVE) && node == NULL));

    // check temporary failure
    do {
        ret = getaddrinfo(node, service, &hints, &result);
    } while (EAI_AGAIN == ret);


    if (ret != 0) {
        isErrorOccured = true;
        errorMessage = ucs4string::from_c_str(gai_strerror(ret));
        return NULL;
    }

    // there may be many addresses for one host
    int lastError = 0;
    for (struct addrinfo* p = result; p != NULL; p = p->ai_next) {
        const int fd = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
        if (-1 == fd) {
            lastError = errno;
            continue;
        }
        if (connect(fd, p->ai_addr, p->ai_addrlen) == 0) {
            // address => name
            int ret;
            char host[NI_MAXHOST];
            char serv[NI_MAXSERV];
            do {
                ret = getnameinfo(p->ai_addr,
                                  p->ai_addrlen,
                                  host, sizeof(host),
                                  serv, sizeof(serv), NI_NAMEREQD);
            } while (EAI_AGAIN == ret);
            char name[NI_MAXSERV + NI_MAXHOST + 1];
            snprintf(name, sizeof(name), "%s:%s", host, serv);
            freeaddrinfo(result);
            return new Socket(fd, ucs4string::from_c_str(name));
        } else {
            lastError = errno;
            close(fd);
        }
    }
    freeaddrinfo(result);
    isErrorOccured = true;
    errorMessage = getLastErrorMessageInternal(lastError);
    return NULL;
}
