;(display (list= eq? '(a) '(a)))

(define (zero? x) (= x 0))

;; recur が receive の value で起きる。
(define (split-at x k)
  (let recur ((lis x) (k k))
    (if (zero? k) (values '() lis)
    (receive (prefix suffix) (recur (cdr lis) (- k 1))
      (values (cons (car lis) prefix) suffix)))))

;; (receive (x y) (split-at '(a b c d e f g h) 1)
;;   (sys-display x)
;;   (sys-display y))
;(disasm split-at)


;(disasm list=)

;(disasm (lambda ()

;; 問題点 'done に至った後に leave が1回しか動いていなければ正解。
;; 簡単な pretty-rinter を作ってjump 先を明示しようぜ．
;; (sys-display (let loop1 ([i 0])
;;   (if (= i 1)
;;       'done
;;       (let loop2 ([j 0])
;;         (if (= j 1)
;;             (loop1 (+ i 1))
;;             (loop2 (+ j 1)))))))
;; ;)

;(display "hge")
;; (define (a flag)
;;   (format #t "~a" flag)
;;   (if flag
;;       (c '(1))
;;       (b '(a 3) 'x)))

;; (define (b args x)
;;   (let loop ([args args])
;;     (if (null? args)
;;         '()
;;         (let1 xxx xx
;;           (if (symbol? (car args))
;;               (begin (sys-display x) (a #t))
;;               (begin (sys-display x) (sys-display xxx)))
;;         (loop (cdr args))))))

;; (define xx 1)
;; (define (c x)
;;   (let loop ([i 0])
;;     (if (= i 2)
;;         '()
;;           (loop (+ i (length x))))))


;; (a #f)

;(disasm b)

;; (disasm (lambda ()
;;           (map2 (lambda (s) (string-append s "123")) "ABC")))
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
