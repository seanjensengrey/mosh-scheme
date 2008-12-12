(import (rnrs)
        (mosh string)) ;; format

(define-record-type point (fields x y z w))

(define (point->list p)
  (list (point-x p) (point-y p) (point-z p) (point-w p)))

(define pi 3.14159)

(define-syntax negate
  (syntax-rules ()
    [(_ x)
     (* -1 x)]))

(define (make-translation-matrix tx ty tz)
  `#(1 0 0 ,tx
     0 1 0 ,ty
     0 0 1 ,tz
     0 0 0 1))

(define (make-rotate-z-matrix phi)
  `#(,(cos phi) ,(negate (sin phi)) 0 0
     ,(sin phi) ,(cos phi) 0 0
     0 0 1 0
     0 0 0 1))

(define (make-scale-matrix sx sy sz)
  `#(,sx 0   0   0
     0   ,sy 0   0
     0   0   ,sz 0
     0   0   0   1))

(define (make-shear-xz-matrix s)
  `#(1 0 ,s 0
     0 1 0  0
     0 0 1  0
     0 0 0  1))

(define (make-shear-xy-matrix s)
  `#(1 ,s 0  0
     0 1 0  0
     0 0 1  0
     0 0 0  1))


(define (mul m p)
  (let ([x (point-x p)]
        [y (point-y p)]
        [z (point-z p)]
        [w (point-w p)])
    (make-point (+ (* x (vector-ref m 0)) (* y (vector-ref m 1)) (* z (vector-ref m 2)) (* w (vector-ref m 3)))
                (+ (* x (vector-ref m 4)) (* y (vector-ref m 5)) (* z (vector-ref m 6)) (* w (vector-ref m 7)))
                (+ (* x (vector-ref m 8)) (* y (vector-ref m 9)) (* z (vector-ref m 10)) (* w (vector-ref m 11)))
                (+ (* x (vector-ref m 12)) (* y (vector-ref m 13)) (* z (vector-ref m 14)) (* w (vector-ref m 15))))))

(define (mulm m1 m2)
  (let-syntax ([ref (syntax-rules ()
                    [(_ v i)
                     (vector-ref v i)])])
  (vector (+ (* (ref m1 0)  (ref m2 0)) (* (ref m1 1)  (ref m2 4)) (* (ref m1 2)  (ref m2 8))  (* (ref m1 3) (ref m2 12)))
          (+ (* (ref m1 0)  (ref m2 1)) (* (ref m1 1)  (ref m2 5)) (* (ref m1 2)  (ref m2 9))  (* (ref m1 3) (ref m2 13)))
          (+ (* (ref m1 0)  (ref m2 2)) (* (ref m1 1)  (ref m2 6)) (* (ref m1 2)  (ref m2 10)) (* (ref m1 3) (ref m2 14)))
          (+ (* (ref m1 0)  (ref m2 3)) (* (ref m1 1)  (ref m2 7)) (* (ref m1 2)  (ref m2 11)) (* (ref m1 3) (ref m2 15)))
          (+ (* (ref m1 4)  (ref m2 0)) (* (ref m1 5)  (ref m2 4)) (* (ref m1 6)  (ref m2 8))  (* (ref m1 7) (ref m2 12)))
          (+ (* (ref m1 4)  (ref m2 1)) (* (ref m1 5)  (ref m2 5)) (* (ref m1 6)  (ref m2 9))  (* (ref m1 7) (ref m2 13)))
          (+ (* (ref m1 4)  (ref m2 2)) (* (ref m1 5)  (ref m2 6)) (* (ref m1 6)  (ref m2 10)) (* (ref m1 7) (ref m2 14)))
          (+ (* (ref m1 4)  (ref m2 3)) (* (ref m1 5)  (ref m2 7)) (* (ref m1 6)  (ref m2 11)) (* (ref m1 7) (ref m2 15)))
          (+ (* (ref m1 8)  (ref m2 0)) (* (ref m1 9)  (ref m2 4)) (* (ref m1 10) (ref m2 8))  (* (ref m1 11) (ref m2 12)))
          (+ (* (ref m1 8)  (ref m2 1)) (* (ref m1 9)  (ref m2 5)) (* (ref m1 10) (ref m2 9))  (* (ref m1 11) (ref m2 13)))
          (+ (* (ref m1 8)  (ref m2 2)) (* (ref m1 9)  (ref m2 6)) (* (ref m1 10) (ref m2 10)) (* (ref m1 11) (ref m2 14)))
          (+ (* (ref m1 8)  (ref m2 3)) (* (ref m1 9)  (ref m2 7)) (* (ref m1 10) (ref m2 11)) (* (ref m1 11) (ref m2 15)))
          (+ (* (ref m1 12) (ref m2 0)) (* (ref m1 13) (ref m2 4)) (* (ref m1 14) (ref m2 8))  (* (ref m1 15) (ref m2 12)))
          (+ (* (ref m1 12) (ref m2 1)) (* (ref m1 13) (ref m2 5)) (* (ref m1 14) (ref m2 9))  (* (ref m1 15) (ref m2 13)))
          (+ (* (ref m1 12) (ref m2 2)) (* (ref m1 13) (ref m2 6)) (* (ref m1 14) (ref m2 10)) (* (ref m1 15) (ref m2 14)))
          (+ (* (ref m1 12) (ref m2 3)) (* (ref m1 13) (ref m2 4)) (* (ref m1 14) (ref m2 11)) (* (ref m1 15) (ref m2 15))))))


(define before '((1.0 1.0 0.0 1.0) (1.0 2.0 0.0 1.0) (2.0 2.0 0.0 1.0) (2.0 1.0 0.0 1.0)))

;(define t (make-translation-matrix-matrix 1 2 3))

;(define t (make-rotate-z-matrix (/ pi 4)))

;(define t (make-scale-matrix 1 3 1))

;(define t (make-shear-xy-matrix 1.2))

(define t (mulm (make-rotate-z-matrix (/ pi 4)) (make-translation-matrix 1 2 3)))

(format #t "(define rect-before '~a)\n" before)
(format #t "(define rect-after '~a)\n"
        (map point->list
             (map (lambda (p) (mul t (apply make-point p))) before)))