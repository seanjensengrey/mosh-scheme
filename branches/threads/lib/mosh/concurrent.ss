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
  (export ! receive spawn self join!)
  (import (mosh) (rnrs) (mosh queue) (match))

(define-record-type mail-box
  (fields
   (immutable condition)
   (immutable mutex)
   (mutable mails))
  (protocol
   (lambda (c)
     (lambda ()
       (c (make-condition-variable) (make-mutex) (make-queue))))))

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
    (queue-push! (mail-box-mails mb) obj)
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

(define-syntax receive
  (lambda (x)
  (syntax-case x (after)
    [(_ [match-expr body0 body ...] ... [after timeout after-body0 after-body ...])
     (integer? (syntax->datum #'timeout))
     #'(let ([saved (make-queue)])
         (letrec ([rec (lambda ()
                         (match (receive-internal! timeout)
                           ['%timeout
                            ;; restore!
                              (mutex-lock! (mail-box-mutex (process-mail-box (self))))
                            (let ([mails (mail-box-mails (process-mail-box (self)))])

                              (queue-append! saved mails)
                              (mail-box-mails-set! (process-mail-box (self)) saved)
                              (mutex-unlock! (mail-box-mutex (process-mail-box (self)))))
                            after-body0 after-body ...]
                           [match-expr
                            (mutex-lock! (mail-box-mutex (process-mail-box (self))))
                            (let ([mails (mail-box-mails (process-mail-box (self)))])
                              (queue-append! saved mails)
                              (mail-box-mails-set! (process-mail-box (self)) saved)
                              (mutex-unlock! (mail-box-mutex (process-mail-box (self))))
                              body0 body ...)] ...
                           [x
                            (queue-push! saved x)
                            (rec)]))])
           (rec)))]
    [(_ [match-expr body0 body ...] ...)
     #'(let ([saved (make-queue)])
         (letrec ([rec (lambda ()
                         (match (receive-internal!)
                           [match-expr
                              (mutex-lock! (mail-box-mutex (process-mail-box (self))))
                            (let ([mails (mail-box-mails (process-mail-box (self)))])
                              (queue-append! saved mails)
                              (mail-box-mails-set! (process-mail-box (self)) saved)
                              (mutex-unlock! (mail-box-mutex (process-mail-box (self))))
                              body0 body ...)] ...
                           [x
                            (queue-push! saved x)
                            (rec)]))])
           (rec)))])))

(define (receive-internal! . timeout)
  (let ([mb (process-mail-box (self))])
  (let loop ()
    (cond
     [(queue-empty? (mail-box-mails mb))
      (cond
       [(pair? timeout)
        (let ([timeout? (not (condition-variable-wait! (mail-box-condition mb) (car timeout)))])
          (if timeout?
              '%timeout
              (loop)))]
       [else
        (condition-variable-wait! (mail-box-condition mb))
        (loop)])]
     [else
      (mutex-lock! (mail-box-mutex mb))
      (let ([val (queue-pop! (mail-box-mails mb))])
        (mutex-unlock! (mail-box-mutex mb))
        val)]))))

(define (join! process)
  (vm-join! (process-vm process)))

(when (main-vm?)
  (let ([process (make-process (vm-self))])
    (vm-set-value! (vm-self) 'self process)))

)
