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

(display           (if (not (pair? 3))
               4
               5))

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
