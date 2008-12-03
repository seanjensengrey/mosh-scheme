(display "GO\n")
(define a 1)
(display
 (let loop ([i 1])
   (if (= i 10)
       'done
       (let1 b a
         (loop (+ i b))))))

(define a 1)
(define x 0)
(display
 (let loop ([i 1])
   (if (= i 10)
       'done
       (let1 b a
         (let1 c x
         (loop (+ i b c)))))))

(define a 1)
(define x 0)
(display
 (let loop ([i 1])
   (if (= i 10)
       'done
       (let ([b a]
             [c x])
         (loop (+ i b c))))))


(define a 1)
(define x 0)
(display
 (let loop ([i 1]
            [j 0])
   (if (= i 10)
       j
       (let ([b a]
             [c x])
         (loop (+ i b c) (+ j b))))))

(define a 1)
(define x 0)
(display
 (let loop ([i 1]
            [j 0])
   (if (= i 10)
       j
       (letrec ([b a]
                [c x])
         (loop (+ i b c) (+ j b))))))

(define a 1)
(define x 0)
(display
 (let loop ([i 1]
            [j 0])
   (if (= i 10)
       j
       (let* ([b a]
              [c x])
         (loop (+ i b c) (+ j b))))))

(define a 1)
(define x 0)
(display
 (let loop ([i 1]
            [j 0])
   (if (= i 10)
       j
       ((lambda (b c)
          (loop (+ i b c) (+ j b))) a x))))



;; (define a 1)
;; (define x 0)
;; (display
;;  (let loop ([i 1]
;;             [j 0])
;;    (if (= i 10)
;;        j
;;        (receive (b c) (values a x)
;;          (loop (+ i b c) (+ j b))))))
