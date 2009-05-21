(define value #f)
(define value-is-ready? #f)

(let ([vm (make-vm '(lambda () (display "hello\n")) '((rnrs) (mosh socket)) "mutator")])
  (display vm)
  (display (vm? vm))

      (vm-start! vm))
