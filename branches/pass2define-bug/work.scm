(define v-sort!
  (lambda (proc vect)
    (let* ((n (vector-length vect)) (work (make-vector (+ (div n 2) 1))))

      (define simple-sort!
        (lambda (first last)
          (let loop1 ((i first))
            (cond ((< i last)
                   (let ((m (vector-ref vect i)) (k i))
                     (let loop2 ((j (+ i 1)))
                       (cond ((<= j last)
                              (if (proc (vector-ref vect j) m)
                                  (begin
                                    (set! m (vector-ref vect j))
                                    (set! k j)))
                              (loop2 (+ j 1)))
                             (else
                              (vector-set! vect k (vector-ref vect i))
                              (vector-set! vect i m)
                              (loop1 (+ i 1)))))))))))

      (define sort!
        (lambda (first last)
          (cond ((> (- last first) 10)
                 (let ((middle (div (+ first last) 2)))
                   (sort! first middle)
                   (sort! (+ middle 1) last)
                   (let loop ((i first) (p2size 0))
                     (cond ((> i middle)
                            (let loop ((p1 (+ middle 1)) (p2 0) (p3 first))
                              (cond ((and (<= p1 last) (< p2 p2size))
                                     (cond ((proc (vector-ref work p2) (vector-ref vect p1))
                                            (vector-set! vect p3 (vector-ref work p2))
                                            (loop p1 (+ p2 1) (+ p3 1)))
                                           (else
                                            (vector-set! vect p3 (vector-ref vect p1))
                                            (loop (+ p1 1) p2 (+ p3 1)))))
                                    (else
                                     (let loop ((s2 p2)(d3 p3))
                                       (cond ((< s2 p2size)
                                              (vector-set! vect d3 (vector-ref work s2))
                                              (loop (+ s2 1) (+ d3 1)))))))))
                           (else
                            (vector-set! work p2size (vector-ref vect i))
                            (loop (+ i 1) (+ p2size 1)))))))
                (else
                 (simple-sort! first last)))))

      (sort! 0 (- n 1)))))

;; (define vect (vector 3 5 2 1))
;; (define proc <)

;; (define simple-sort!
;;         (lambda (first last)
;;           (let1 vect (vector 3 5 2 1)
;;           (let loop1 ((i first))
;;             (cond ((< i last)
;;                    (let ((m (vector-ref vect i)) (k i))
;;                      (let loop2 ((j (+ i 1)))
;;                        (cond ((<= j last)
;;                               (if (proc (vector-ref vect j) m)
;;                                   (begin
;;                                     (set! m (vector-ref vect j))
;;                                     (set! k j)))
;;                               (loop2 (+ j 1)))
;;                              (else
;;                               (vector-set! vect k (vector-ref vect i))
;;                               (vector-set! vect i m)
;;                               (loop1 (+ i 1))))))))))))

;;     (simple-sort! 0 2)
;;   (sys-display vect)

;(display (list= eq? '(a) '(a)))

;; (define (zero? x) (= x 0))

;; ;; recur が receive の value で起きる。
;; (define (split-at x k)
;;   (let recur ((lis x) (k k))
;;     (if (zero? k) (values '() lis)
;;     (receive (prefix suffix) (recur (cdr lis) (- k 1))
;;       (values (cons (car lis) prefix) suffix)))))

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
