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
  (export ! receive spawn self join! register whereis link process-exit spawn-link)
  (import (only (mosh) main-vm? vm-set-value! vm-self make-condition-variable make-mutex mutex-lock! mutex-unlock! condition-variable-notify!
                whereis vm-start! make-vm symbol-value condition-variable-wait! vm-join! register time)
          (only (rnrs) define-record-type immutable mutable protocol lambda define for-each quote exit fields _ ... define-syntax
                syntax-case syntax integer? syntax->datum when let quasiquote unless error if let* memq remq cons cond pair? not car
                else letrec unquote display)
          (only (mosh queue) make-queue queue-push! queue-empty? queue-pop! queue-append!)
          (only (match) match))

(define-record-type mail-box
  (fields
   (immutable condition)
   (immutable mutex)
   (mutable mails))
  (protocol
   (lambda (c)
     (lambda ()
       (c (make-condition-variable) (make-mutex) (make-queue))))))

(define (process-exit status)
  (for-each
   (lambda (to)
     (! to `(exit ,status)))
   (pid-links (self)))
  (exit status))

(define-record-type pid
  (fields
   (immutable vm)
   (immutable mail-box)
   (mutable links))
  (protocol
   (lambda (c)
     (lambda (vm)
       (c vm (make-mail-box) '())))))

(define (! pid obj)
  (let ([p (if (pid? pid)
               pid
               (whereis pid))])
    (unless p
      (error '! "pid not found" pid))
    (let ([mb (pid-mail-box p)])
      (mutex-lock! (mail-box-mutex mb))
      (queue-push! (mail-box-mails mb) obj)
      (mutex-unlock! (mail-box-mutex mb))
      (condition-variable-notify! (mail-box-condition mb)))))

(define (unlink pid)
  (let* ([self (self)]
         [links (pid-links pid)])
    (when (memq pid links)
      (pid-links-set! pid (remq pid links)))
    (let ([links (pid-links self)])
      (when (memq self links)
        (pid-links-set! pid (remq self links))))))

(define (link pid)
  (let* ([self (self)]
         [links (pid-links pid)])
    (unless (memq pid links)
      (pid-links-set! pid (cons pid links)))
    (let ([links (pid-links self)])
      (unless (memq self links)
        (pid-links-set! pid (cons self links))))))

(define-syntax spawn
  (lambda (x)
    (syntax-case x ()
      [(_ expr import-spec)
       #'(spawn-internal 'expr import-spec)])))

(define-syntax spawn-link
  (lambda (x)
    (syntax-case x ()
      [(_ expr import-spec)
       #'(let ([pid (spawn-internal 'expr import-spec)])
           (link pid)
           pid)])))

(define (spawn-internal thunk import-spec)
  (let* ([vm (make-vm `(lambda () (guard (c [#t (process-exit c)]) (,thunk) (process-exit 'normal))) import-spec)]
         [pid (make-pid vm)])
    (vm-set-value! vm 'self pid)
    (vm-start! vm)
    pid))

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
                              (mutex-lock! (mail-box-mutex (pid-mail-box (self))))
                            (let ([mails (mail-box-mails (pid-mail-box (self)))])

                              (queue-append! saved mails)
                              (mail-box-mails-set! (pid-mail-box (self)) saved)
                              (mutex-unlock! (mail-box-mutex (pid-mail-box (self)))))
                            after-body0 after-body ...]
                           [match-expr
                            (mutex-lock! (mail-box-mutex (pid-mail-box (self))))
                            (let ([mails (mail-box-mails (pid-mail-box (self)))])
                              (queue-append! saved mails)
                              (mail-box-mails-set! (pid-mail-box (self)) saved)
                              (mutex-unlock! (mail-box-mutex (pid-mail-box (self))))
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
                            (mutex-lock! (mail-box-mutex (pid-mail-box (self))))
                            (let ([mails (mail-box-mails (pid-mail-box (self)))])
                              (queue-append! saved mails)
                              (mail-box-mails-set! (pid-mail-box (self)) saved)
                              (mutex-unlock! (mail-box-mutex (pid-mail-box (self))))
                              body0 body ...)] ...
                           [x
                            (queue-push! saved x)
                            (rec)]))])
           (rec)))])))

(define (receive-internal! . timeout)
  (let ([mb (pid-mail-box (self))])
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

(define (join! pid)
  (vm-join! (pid-vm pid)))

(when (main-vm?)
  (let ([pid (make-pid (vm-self))])
    (vm-set-value! (vm-self) 'self pid)))

)
