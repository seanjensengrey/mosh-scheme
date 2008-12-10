(disasm (lambda ()
          (map2 (lambda (s) (string-append s "123")) "ABC")))
;; (define g 1)

;; (define (inner x)
;;   (fx+ x 0))

;; (define (outer p)
;;   (let loop ([i 0])
;;     (if (= i 3)
;;         '()
;;         (loop (+ (length p) (inner 0) i)))))

;; ;(outer '())

;; (disasm inner)
