(display "GO\n")
;; (define a 1)
;; (display
;;  (let loop ([i 1])
;;    (if (= i 10)
;;        'done
;;        (let1 b a
;;          (loop (+ i b))))))

(define a 1)
(define x 0)
(display
 (let loop ([i 1])
   (if (= i 10)
       'done
       (let1 b a
         (let1 c x
         (loop (+ i b c)))))))

