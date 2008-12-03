(display
 (let loop ([i 1])
   (if (= i 10)
       'done
         (loop (+ i 1)))))


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

(define a 1)
(define x 0)
(display
 (let loop ([i 1]
            [j 0])
   (if (= i 10)
       j
       (if a
       (let* ([b a]
              [c x])
         (loop (+ i b c) (+ j b)))))))


(display "1**********\n")

(define-macro (do2 . sexp)
  (match sexp
    [((var) ...)
     1]
    ))

(display "2**********\n")
(display (do2 (i)))

	(define-macro (do2 . sexp)
	  (match sexp
	    [(((var init step ...) ...)
	         (test expr ...)
	       command ...)
	     `(letrec
	       ((loop
	         (lambda (,@var)
	           (if ,test
	               (begin
	                 #f ; avoid empty begin
	                 ,@expr)
	               (begin
	                 ,@command
	                 (loop ,@(map (lambda (v s) `(do2 "step" ,v ,@s)) var step)))))))
	        (loop ,@init))]
	    [("step" x)
	     x]
	    [("step" x y)
	     y]
	    [else
	     (syntax-error "malformed do2 on mosh")]))
	
	(display (do2 ((i 0 (+ i 1)))
	    ((= i 5) i)))

;; (define a 1)
;; (define x 0)
;; (display
;;  (let loop ([i 1]
;;             [j 0])
;;    (if (= i 10)
;;        j
;;        (receive (b c) (values a x)
;;          (loop (+ i b c) (+ j b))))))
