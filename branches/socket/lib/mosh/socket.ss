; socket.ss - Socket interface
;
;   Copyright (c) 2009  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
;
;   Redistribution and use in source and binary forms, with or without
;   modification, are permitted provided that the following conditions
;   are met:
;
;   1. Redistributions of source code must retain the above copyright
;      notice, this list of conditions and the following disclaimer.
;
;   2. Redistributions in binary form must reproduce the above copyright
;      notice, this list of conditions and the following disclaimer in the
;      documentation and/or other materials provided with the distribution.
;
;   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
;  $Id: socket.ss 621 2008-11-09 06:22:47Z higepon $

(library (mosh socket)
  (export AF_INET SOCK_STREAM
    socket?
    socket-accept
    make-client-socket
    make-server-socket
    socket-recv
    socket-send
    socket-close
    socket-shutdown
    socket-port
    call-with-socket)
  (import (only (rnrs) ... _ define define-syntax syntax-case cond lambda if syntax->datum syntax => quasiquote quasisyntax
                else unsyntax call-with-values apply values)
          (only (mosh control) let-optionals*)
          (only (mosh) os-constant)
          (rename (system)
                  (socket-recv %socket-recv)
                  (socket-send %socket-send)
                  (make-client-socket %make-client-socket)
                  (make-server-socket %make-server-socket)))

  ;; borrowed from Ypsilon Scheme by Yoshikatsu Fujita.
  (define-syntax define-const
    (lambda (x)
      (syntax-case x ()
        ((_ name)
         (cond [(os-constant (syntax->datum #'name))
                => (lambda (value) #`(define name #,value))]
               [else #'(define-syntax name unsupported-option)])))))

  (define-const AF_INET)
  (define-const SOCK_STREAM)

  (define (make-client-socket node service . options)
    (let-optionals* options ([ai-family AF_INET]
                             [ai-socktype SOCK_STREAM]
                             [ai-flags 0]
                             [ai-protocol 0])
      (%make-client-socket node service ai-family ai-socktype ai-flags ai-protocol)))

  (define (make-server-socket service . options)
    (let-optionals* options ([ai-family AF_INET]
                             [ai-socktype SOCK_STREAM]
                             [ai-protocol 0])
      (%make-server-socket service ai-family ai-socktype ai-protocol)))

  (define (call-with-socket socket proc)
    (call-with-values
        (lambda () (proc socket))
      (lambda args
        (socket-close socket)
        (apply values args))))

  (define (socket-recv socket size . options)
    (let-optionals* options ([flags 0])
      (%socket-recv socket size flags)))

  (define (socket-send socket data . options)
    (let-optionals* options ([flags 0])
      (%socket-send socket data flags)))

)
