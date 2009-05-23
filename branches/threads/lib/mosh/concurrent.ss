; concurrent.ss
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
;  $Id: concurrent.ss 621 2008-11-09 06:22:47Z higepon $

(library (mosh concurrent)
  (export ! receive! spawn self)
  (import (mosh) (rnrs))

(define-record-type mail-box
  (fields
   (immutable condition)
   (immutable mutex)
   (mutable mail*))
  (protocol
   (lambda (c)
     (lambda ()
       (c (make-condition-variable) (make-mutex) '())))))


(define-record-type process
  (fields
   (immutable vm)
   (immutable mail-box))
  (protocol
   (lambda (c)
     (lambda (vm)
       (c vm (make-mail-box))))))

(define (! process obj)
  (let ([mb (process-mail-box process)])
    (mutex-lock! (mail-box-mutex mb))
    (mail-box-mail*-set! mb (cons obj (mail-box-mail* mb)))
    (mutex-unlock! (mail-box-mutex mb))
    (condition-variable-notify! (mail-box-condition mb))))

(define (spawn expr import-spec)
(let* ([vm (make-vm expr import-spec)]
      [process (make-process vm)])
  (vm-set-value! vm 'self process)
  (vm-start! vm)
  process))

(define (self)
  (symbol-value 'self))

(define (receive! process)
  (let ([mb (process-mail-box process)])
  (define (mail-exists?)
    (pair? (mail-box-mail* mb)))
  (let loop ()
    (cond
     [(mail-exists?)
      (mutex-lock! (mail-box-mutex mb))
      (let ([val (car (mail-box-mail* mb))])
        (mail-box-mail*-set! mb (cdr (mail-box-mail* mb)))
        (mutex-unlock! (mail-box-mutex mb))
        val)]
     [else
      (condition-variable-wait! (mail-box-condition mb))
      (loop)]))))



)
