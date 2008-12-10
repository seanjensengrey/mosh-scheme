(disasm (lambda ()
          (map2 (lambda (s) (string-append s "123")) "ABC")))
;; (define g 1)

;; (define plus +)
;; (define (inner x)
;;   (let1 op plus
;;     (op x 1)))

;; (define (outer p)
;;   (let loop ([i 0])
;;     (sys-display i)
;;     (if (= i 3)
;;         '()
;;         (loop (+ (length p) (inner 0) i)))))

;; (outer '())

;; (define (pass3/rec1 cb arg locals frees can-frees sets tail depth)
;;   (if (pair? arg)
;;       (pass3/compile-args1 cb arg locals frees can-frees sets tail depth)
;;       1))

;; (define (pass3/compile-arg1 cb arg locals frees can-frees sets tail depth)
;;   (let1 size (pass3/rec1 cb arg locals frees can-frees sets #f depth)
;;     (sys-display cb)
;;     (+ size 1)))

;; (define (pass3/compile-args1 cb args locals frees can-frees sets tail depth)
;;   (let loop ([size 0]
;;              [iform args])
;;     (cond
;;      [(null? iform) size]
;;      [else
;;       (loop (+ size (pass3/compile-arg1 cb (car iform) locals frees can-frees sets tail depth))
;;             (cdr iform))])))


;; (pass3/compile-args1 'cb '(1 (2 3) 4) '() '() '() '() '() '())


;(disasm pass3/compile-args)
;(disasm pass3/compile-args1)
