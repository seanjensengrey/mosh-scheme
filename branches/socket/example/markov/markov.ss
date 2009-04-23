(import (rnrs)
        (mosh)
        (only (srfi :1) append! first second third)
        (only (srfi :13) string-tokenize)
        (mosh control))

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
    (if (or (string=? (first words) "") (string=? (second words) ""))
        (learn dic (cdr words))
        (let1 prefix (cons (first words) (second words))
          (aif (hashtable-ref dic prefix #f)
               (append! it (list (third words)))
               (hashtable-set! dic prefix (list (third words))))
          (learn dic (cdr words)))])))

(define (write-dic dic port)
  (display "(" port)
  (hashtable-for-each
   (lambda (key value)
     (write (cons key value) port))
   dic)
  (display ")" port))

(define (main args)
  (call-with-input-file (second args)
    (lambda (in)
      (let ([dic (make-hashtable equal-hash equal?)])
        (let loop ([line (get-line in)]
                   [i 1])
          (cond
           [(eof-object? line)
            (make-sentence dic "Mona" "は")
            (display "start writing\n")
            (call-with-port (open-output-file "./okuoku.dic")
              (lambda (port)
                (write-dic dic port)))
            (display "end writing2\n")
            ]
           [else
            (let ([words (string-split line #\space)])
              (when (> (length words) 2)
                (learn dic words))
              (format #t "learning ~d\r" i)
              (loop (get-line in) (+ i 1)))]))))))

(main (command-line))
