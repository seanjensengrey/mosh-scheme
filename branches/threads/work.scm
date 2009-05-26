 (import (rnrs)
        (mosh)
        (rnrs mutable-pairs)
;        (mosh queue)
        (mosh test)
        (mosh concurrent))

;; todo
;; spawn unquote
;; mosh concurrent auto-import
(let ([pid (spawn
             (lambda ()
               (test-begin "receive")
               (test-eqv 'hello
                         (receive
                          [('apple)
                           (test-false #t)]
                          [('greeting what)
                           what]))
               (test-equal '(some hello)
                           (receive
                            [x x]))
               (test-equal 'good
                           (receive
                            ['good 'good]))
               (test-eqv 'hello2
                         (receive
                          [('greeting what)
                           what]))
               (test-eqv 'hello3
                         (receive
                          [('greeting what)
                           what]))
               (test-equal '(a . pen)
                           (let-values ([(x y) (receive
                                                [('this 'is x y) (values x y)])])
                             (cons x y)))
               ;; timeout
               (test-eqv 'time-out
                         (receive
                          [('greeting what) what]
                          [after 1
                                 'time-out]))

               (register 'sub (self))
               ;; doesn't work yet
              (receive
                 [('register from name)
                  (! from `(ok ,name))])

;; ああ。mail-box lock してないところあるね。
              (receive
                 [('register from name)
                  (! from `(ok ,name))])

               (test-end)
;               (process-exit 'normal)
;               (error 'hoge "hage")
               )
             '((rnrs) (mosh concurrent) (mosh test)))])

(link pid)

(! pid '(some hello))
(! pid '(greeting hello))
(! pid '(greeting hello2))
(! pid '(greeting hello3))
(! pid 'good)
(! pid '(this is a pen))

(test-begin "main process")
(! pid `(register ,(self) "higepon"))
(receive
    [('ok name) (test-equal "higepon" name)])

(! 'sub `(register ,(self) "higepon"))
(receive
    [('ok name) (test-equal "higepon" name)])

(receive
    [('exit why) (test-equal 'normal why)])

(let ([pid2 (spawn-link (lambda () (error 'unknown "hogehoge2")) '((rnrs) (mosh concurrent)))])
  (receive
      [('exit why) (test-true (error? why))
       #;(raise why)]))



(test-end)


(join! pid))
;; (define-record-type mail-box
;;   (fields
;;    (immutable condition)
;;    (immutable mutex)
;;    (mutable mail*))
;;   (protocol
;;    (lambda (c)
;;      (lambda ()
;;        (c (make-condition-variable) (make-mutex) '())))))


;; (define-record-type process
;;   (fields
;;    (immutable vm)
;;    (immutable mail-box))
;;   (protocol
;;    (lambda (c)
;;      (lambda (vm)
;;        (c vm (make-mail-box))))))

;; (define (! process obj)
;;   (let ([mb (process-mail-box process)])
;;     (mutex-lock! (mail-box-mutex mb))
;;     (mail-box-mail*-set! mb (cons obj (mail-box-mail* mb)))
;;     (mutex-unlock! (mail-box-mutex mb))
;;     (condition-variable-notify! (mail-box-condition mb))))

;; (define (receive process)
;;   (let ([mb (process-mail-box process)])
;;   (define (mail-exists?)
;;     (pair? (mail-box-mail* mb)))
;;   (let loop ()
;;     (cond
;;      [(mail-exists?)
;;       (mutex-lock! (mail-box-mutex mb))
;;       (let ([val (car (mail-box-mail* mb))])
;;         (mail-box(vector-set! mail-box 1 (cdr (vector-ref mail-box 1)))
;;                        (mutex-unlock! mutex)
;;                        val)]
;;                     [else
;;                      (condition-variable-wait! (vector-ref mail-box 0))
;;                      (loop)])))


;; ;(display (make-process 'x))

;; ;; (make-process 'hige 'hage)

;; (let* ([vm (make-vm '(lambda () (display 'hello)) '((rnrs)))]
;;       [process (make-process vm)])
;;   (send! process '(1 2 3))
;;   (display process))


;; (define (make-mail-box)
;;   (vector (make-condition-variable) '() (make-mutex)))

;; (define (send mail-box obj)
;;   (let ([mutex (vector-ref mail-box 2)])
;;     (mutex-lock! mutex)
;;     (vector-set! mail-box 1 (cons obj (vector-ref mail-box 1)))
;;     (mutex-unlock! mutex)
;;     (condition-variable-notify! (vector-ref mail-box 0))))

;; (let* ([vm (make-vm '
;;            (lambda ()
;;              (let* ([mail-box (symbol-value 'mail-box)]
;;                     [mutex (vector-ref mail-box 2)])
;;                (define (mail-exists?)
;;                  (pair? (vector-ref mail-box 1)))
;;                (define (receive)
;;                  (let loop ()
;;                    (cond
;;                     [(mail-exists?)
;;                      (mutex-lock! mutex)
;;                      (let ([val (car (vector-ref mail-box 1))])
;;                        (vector-set! mail-box 1 (cdr (vector-ref mail-box 1)))
;;                        (mutex-unlock! mutex)
;;                        val)]
;;                     [else
;;                      (condition-variable-wait! (vector-ref mail-box 0))
;;                      (loop)])))
;;                (display (receive))
;;                (newline)
;;                (display (receive))
;;                (newline)
;;                (display (receive))
;;                (newline)
;;              (exit 1234)))
;;            '((rnrs) ;; (mosh socket)
;;              (rnrs mutable-pairs)
;;              (mosh)) "mutator")]
;;       [mail-box (make-mail-box)])
;;   (vm-set-value! vm 'mail-box mail-box)
;;   (display vm)
;;   (display (vm? vm))
;;   (vm-start! vm)
;;   (send mail-box 'hello)
;;   (send mail-box 'world)
;;   (send mail-box 'world)
;;   (display (vm-join! vm)))
