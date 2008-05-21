
(define result '(69 generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc generic-assoc append $append-map1-sum))

(define (vector-map proc v)
  (let1 len (vector-length v)
    (let loop ([i 0])
      (if (>= i len)
          '()
          (cons (vector-ref v i) (loop (+ i 1)))))))

(print (vector-map (lambda (x) (* x 2)) '#(1 2 3 4)))

(define (hash-table-map proc ht)
  (let1 keys (hash-table-keys ht)
    (print keys)
    (vector-map
     (lambda (key)
       (proc key (hash-table-ref ht key)))
     keys)))


;;; borrowed from elk

;; (define (sort obj pred)
;;   (vector->list (sort! (list->vector obj) pred)))

;; (define (sort! v pred)
;;   (let ((len (vector-length v)))
;;     (define (internal-sort l r)
;;       (let ((i l) (j r) (x (vector-ref v (quotient (- (+ l r) 1) 2))))
;; 	(let loop ()
;; 	     (do () ((not (pred (vector-ref v i) x))) (set! i (+ 1 i)))
;; 	     (do () ((not (pred x (vector-ref v j)))) (set! j (- j 1)))
;; 	     (if (<= i j)
;; 		 (let ((temp (vector-ref v i)))
;; 		   (vector-set! v i (vector-ref v j))
;; 		   (vector-set! v j temp)
;; 		   (set! i (+ 1 i))
;; 		   (set! j (- j 1))))
;; 	     (if (<= i j)
;; 		 (loop)))
;; 	(if (< l j)
;; 	    (internal-sort l j))
;; 	(if (< i r)
;; 	    (internal-sort i r))))
;;     (if (> len 1)
;; 	(internal-sort 0 (- len 1)))
;;     v))




;; result format is '(total-sample-count sym1 sym2 ... symn)
(define (show-profile result)
  (print "***")
  (let ([total (car result)]
        [syms  (cdr result)]
        [table (make-eq-hashtable)])
    (let loop ([syms syms])
      (cond
       [(null? syms)
          '()]
       [else
        (aif (hash-table-ref table (car syms) #f)
            (hash-table-set! table (car syms) (+ it 1))
            (hash-table-set! table (car syms) 1))
        (loop (cdr syms))]))
    (print "==")
    (print 
    (hash-table-map
     (lambda (key value)
       (cons key (cons value (/ (* 100 value) total)))
       3)
     table))))


(print (show-profile result))
    
    
