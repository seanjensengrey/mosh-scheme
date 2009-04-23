(import (rnrs)
        (mosh)
        (only (srfi :1) append! first second third)
        (only (srfi :13) string-tokenize)
        (mosh control))


;; ToDo
;; (1) handle eos

;; (define (file->sexp-list file)
;;   (call-with-input-file file
;;     (lambda (port)
;;       (let loop ([ret '()]
;;                  [sexp (read port)])
;;         (if (eof-object? sexp)
;;             (reverse ret)
;;             (loop (cons sexp ret) (read port)))))))

;; (define (make-sentence dic first second)
;;   (cond
;;    [(hashtable-ref dic (cons first second) #f)
;;     => (lambda (v)
;;          (write first)
;;          (newline)
;;          (make-sentence dic second (car v)))]
;;    [else
;;     (display "\ndone\n")]))

;; (define (main args)
;;   (let loop ([data (file->sexp-list (second args))]
;;              [result (make-hashtable equal-hash equal?)])
;;     (cond
;;      [(null? (cddr data))
;;       (make-sentence result "それ" "に")

;;       ]
;;      [else
;;       (let1 prefix (cons (car data) (cadr data))
;;         (aif (hashtable-ref result prefix #f)
;;              (loop (cdr data)
;;                    (begin
;;                      (append! it (list (caddr data)))
;;                      result
;;                      ))
;;              (loop (cdr data)
;;                    (begin
;;                      (hashtable-set! result prefix (list (caddr data)))
;;                      result))))])))

;; (main (command-line))


;; (define (file->sexp-list file)
;;   (call-with-input-file file
;;     (lambda (port)
;;       (let loop ([ret '()]
;;                  [sexp (read port)])
;;         (if (eof-object? sexp)
;;             (reverse ret)
;;             (loop (cons sexp ret) (read port)))))))

(define (make-sentence dic first second)
  (cond
   [(hashtable-ref dic (cons first second) #f)
    => (lambda (v)
         (write first)
         (newline)
         (make-sentence dic second (car v)))]
   [else
    (display "\ndone\n")]))

;; space seprated file => list of string
(define (file->sexp file)
  (call-with-input-file file
    (lambda (in)
      (display (string-split (get-line in) #\space)))))

(define (learn dic words)
  (cond
   [(null? (cddr words)) '()]
   [else
    (let1 prefix (cons (first words) (second words))
      (aif (hashtable-ref dic prefix #f)
           (append! it (list (third words)))
           (hashtable-set! dic prefix (list (third words))))
      (learn dic (cdr words)))]))

(define (main args)
  (call-with-input-file (second args)
    (lambda (in)
      (let ([dic (make-hashtable equal-hash equal?)])
        (let loop ([line (get-line in)])
          (cond
           [(eof-object? line)
            (make-sentence dic "勉強" "方法")]
           [else
            (let ([words (string-split line #\space)])
              (when (> (length words) 2)
                (learn dic words))
              (loop (get-line in)))]))))))

(main (command-line))

