(define value #f)
(define value-is-ready? #f)

;; todo mutex

(define (make-mail-box)
  (cons (make-condition-variable) '()))

(define (send mail-box obj)
  (set-cdr! mail-box (cons obj (cdr mail-box)))
  (condition-variable-notify! (car mail-box)))

(let ([vm (make-vm '
           (lambda ()
             (let ([mail-box (symbol-value 'mail-box)])
               (define (mail-exists?)
                 (pair? (cdr mail-box)))
               (define (receive)
                 (let loop ()
                   (cond
                    [(mail-exists?)
                     (let ([val (cadr mail-box)])
                       (set-cdr! mail-box (cddr mail-box))
                       val)]
                    [else
                     (condition-variable-wait! (car mail-box))
                     (loop)])))
               (display (receive))
               (newline)
               (display (receive))
               (newline)
               (display (receive))
               (newline)
             (exit 1234)))
           '((rnrs) ;; (mosh socket)
             (rnrs mutable-pairs)
             (mosh)) "mutator")]
      [mail-box (make-mail-box)])
  (vm-set-value! vm 'mail-box mail-box)
  (display vm)
  (display (vm? vm))
  (vm-start! vm)
  (send mail-box 'hello)
  (send mail-box 'world)
  (send mail-box 'world)
  (display (vm-join! vm)))
