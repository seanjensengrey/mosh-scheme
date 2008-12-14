;; (define (a appender lis1)
;;   (let recur ((elt (car lis1)) (rest (cdr lis1)))
;;       (if (null-list? rest)
;;           elt
;;           (appender elt (recur (car rest) (cdr rest))))))

;; (define (a appender lis1)
;;   (let recur ((rest (cdr lis1)))
;;       (if (null? rest)
;;          '()
;;           (appender '() (recur '())))))












;(disasm
;(lambda ()
;; (let1 val (begin (define a 3))

(define (tak x y z)
  (if (not (< y x))
      z
      (tak (tak (- x 1) y z)
           (tak (- y 1) z x)
           (tak (- z 1) x y))))

(disasm tak)
;;   (if val #t #f))


;(display (macroexpand '(guard (con (#t 'error)) (letrec ((a 3) (b a)) (display b) (newline)))))
;(guard (con (#t 'error)) (letrec ((a 3) (b a)) (display b) (newline))); (format #t " Running ~d/~d" 71 1878) (add-error '(letrec ((a 3) (b a)) (display b) (newline)) 'error 'not-error))(display "")(let1 val (begin (letrec ((even? (lambda (n) (if (= 0 n) #t (odd? (- n 1))))) (odd? (lambda (n) (if (= 0 n) #f (even? (- n 1)))))) (cons (even? 88) (odd? 88)))) (if (equal? '(#t . #f) val) (format #t " Running ~d/~d" 72 1878) (begin (add-error '(letrec ((even? (lambda (n) (if (= 0 n) #t (odd? (- n 1))))) (odd? (lambda (n) (if (= 0 n) #f (even? (- n 1)))))) (cons (even? 88) (odd? 88))) '(#t . #f) val))))

;(a append '(1 2 3))
;; (import (rnrs)
;;         (clos2 user)
;;         (mosh string))

;; (define-class <point> () x y)

;; (define-method initialize 'after ((point <point>) init-args)
;;   (initialize-direct-slots point <point> init-args))

;; (define-method print-object ((point <point>) port)
;;   (print-object-with-slots point port))

;; (define-generic distance-to-origin)

;; (define-method distance-to-origin ((point <point>))
;;   (sqrt (+ (expt (slot-ref point 'x) 2)
;;            (expt (slot-ref point 'y) 2))))

;; (define p1 (make <point> 'x 3 'y 4))

;; (format #t "distance of ~a to origin: ~a~%\n" p1 (distance-to-origin p1))
