(import (rnrs)
        (mosh)
        (only (srfi :1) append! first second third list-ref)
        (only (srfi :13) string-tokenize)
        (only (srfi :27) random-integer random-source-randomize! default-random-source)
        (mosh process)
        (mosh control))

(define (make-sentence dic first second)
  (cond
   [(hashtable-ref dic (cons first second) #f)
    => (lambda (v)
         (write first)
         (newline)
         (display (length v))
         (make-sentence dic second (list-ref v (random-integer (length v)))))]
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
    (if (or (string=? (first words) "") (string=? (first words) "　"))
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

(define (read-dic port)
  (let ([dic (make-hashtable equal-hash equal?)])
    (for-each
     (lambda (x)
       (hashtable-set! dic (car x) (cdr x)))
     (read port))
    dic))

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

(define (collect-verb+noun text)
  (call-with-port (open-output-file "./mecab.tmp")
    (lambda (out) (display text out)))
  (call-with-port (open-string-input-port (spawn->string "mecab" '("./mecab.tmp")))
    (lambda (in)
      (let loop ([line (get-line in)] [verb '()] [noun '()])
        (cond
         [(eof-object? line) (values verb noun)]
         [(#/([^\s]+)\s+動詞/ line)
          => (lambda (m)
               (let ([next-line (get-line in)])
                 (cond
                  [(eof-object? next-line)
                   (loop next-line verb noun)]
                  [else
                   (loop (get-line in)
                         (cons (cons (m 1) ((#/([^\s]+)\s/ next-line) 1)) verb)
                         noun)])))]
         [(#/([^\s]+)\s+名詞/ line)
          => (lambda (m)
               (let ([next-line (get-line in)])
                 (cond
                  [(eof-object? next-line)
                   (loop next-line verb noun)]
                  [else
                   (loop (get-line in)
                         verb
                         (cons (cons (m 1) ((#/([^\s]+)\s/ next-line) 1)) noun))])))]
         [else
          (loop (get-line in) verb noun)])))))


(define (main2 args)
(random-source-randomize! default-random-source) ;
  (call-with-input-file (second args)
    (lambda (in)
      (let ([dic (read-dic in)])
        (let loop ([line (get-line (current-input-port))])
          (call-with-port (open-output-file "./hige")
            (lambda (out) (display line out)))
          (call-with-port (open-string-input-port (spawn->string "mecab" '("hige")))
            (lambda (in)
              (make-sentence dic ((#/([^\s]+)\s/ (get-line in)) 1) ((#/([^\s]+)\s/ (get-line in)) 1))))
          (loop (get-line (current-input-port))))))))

(define (spawn->string command args)
  (let-values ([(in out) (pipe)])
    (let-values ([(pid cin cout cerr) (spawn command args (list #f out #f))])
      (close-port out)
      (begin0
        (port->string (transcoded-port in (make-transcoder (utf-8-codec))))
        (close-port in)
        (waitpid pid)))))

(define (port->string p)
  (let loop ([ret '()][c (read-char p)])
    (if (eof-object? c)
        (list->string (reverse ret))
        (loop (cons c ret) (read-char p)))))

;(main2 (command-line))

(let-values (([verb noun] (collect-verb+noun "こんにちは今日は散歩に行きましょう")))
  (format #t "verb = ~a noun=~a\n" verb noun))
