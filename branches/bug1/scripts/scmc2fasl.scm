(import (rnrs)
        (srfi :1)
        (mosh))

(define (extract obj)
  (cond
   [(vector? obj)
    (vector-map extract obj)]
   [(and (pair? obj) (eq? (car obj) '*insn*))
    (make-instruction (second obj))]
   [(and (pair? obj) (eq? (car obj) '*compiler-insn*))
    (make-compiler-instruction (second obj))]
   [(list? obj)
    (map extract obj)]
   [else obj]))

(define (main args)
  (with-input-from-file (second args)
    (lambda ()
      (let ([obj (extract (read))])
        (call-with-port (open-file-output-port (third args) (file-options no-fail) (buffer-mode none))
           (lambda (port)
             (fasl-write obj port)))
        ;; check sanity
        (call-with-port (open-file-input-port (third args) (file-options no-fail) (buffer-mode none))
           (lambda (port)
             (let ([restored (fasl-read port)])
               (unless (equal? obj restored)
                 (let loop ([i 0])
                   (cond
                    [(= (vector-length obj) i) '()]
                    [
                     (if (equal? (vector-ref obj i) (vector-ref restored i))
                         (loop (+ i 1))
                         (begin
                           (unless (and (flonum? (vector-ref obj i)) (flonum? (vector-ref restored i)))
                             (assertion-violation 'scmc2fasl
                                                  (format "fasl read/write have inconsistent state : ~d is wrong ~a : ~a\n"
                                                          i
                                                          (vector-ref obj i)
                                                          (vector-ref restored i))))
                           (loop (+ i 1))))]
                       ))
                 )))))))


  0)

(main (command-line))
