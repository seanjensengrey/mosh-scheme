(define value #f)
(define value-is-ready? #f)

(let ([vm (make-vm '(lambda () (display (symbol-value 'cond)) (display "hello\n")) '((rnrs) (mosh socket)) "mutator")])
  (vm-set-value! vm 'cond 99)
  (display vm)
  (display (vm? vm))

      (vm-start! vm))
