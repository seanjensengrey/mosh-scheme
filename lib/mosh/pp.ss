#|
    Title: Pretty Printing

    Pretty Printer library written by Marc Feeley (c) 1991.

    library: (mosh pp)

    Pretty Printer Library
|#
(library (mosh pp)
  (export pretty-print p pp)
  (import (only (rnrs) define if make-string case else let* and pair? symbol?
                car cdr + null? let cond > string-length symbol->string or identifier?
                vector? lambda set! cons - vector->list quote min < substring bytevector? bytevector->u8-list
                boolean? number? number->string procedure? string? char=? string-ref values record-type-descriptor?
                char? input-port? output-port? eof-object? cadr begin display newline apply eq? condition?
                current-output-port define-syntax syntax-case ... syntax call-with-values hashtable? record?)
          (only (system) socket?)
          (only (mosh) regexp?)
          (only (rnrs mutable-strings) string-set!))

; File; "pp.scm"   (c) 1991, Marc Feeley

; 'generic-write' is a procedure that transforms a Scheme data value (or
; Scheme program expression) into its textual representation.  The interface
; to the procedure is sufficiently general to easily implement other useful
; formatting procedures such as pretty printing, output to a string and
; truncated output.
;
; Parameters;
;
;   OBJ       Scheme data value to transform.
;   DISPLAY?  Boolean, controls whether characters and strings are quoted.
;   WIDTH     Extended boolean, selects format:
;               #f = single line format
;               integer > 0 = pretty-print (value = max nb of chars per line)
;   OUTPUT    Procedure of 1 argument of string type, called repeatedly
;               with successive substrings of the textual representation.
;               This procedure can return #f to stop the transformation.
;
; The value returned by 'generic-write' is undefined.
;
; Examples;
;
;   (write obj)   = (generic-write obj #f #f display-string)
;   (display obj) = (generic-write obj #t #f display-string)
;
; where display-string = (lambda (s) (for-each write-char (string->list s)) #t)


(define (generic-write obj display? width output)
  (define unspec (if #f #t))
  (define (read-macro? l)
    (define (length1? l) (and (pair? l) (null? (cdr l))))
    (let ((head (car l)) (tail (cdr l)))
      (case head
        ((QUOTE QUASIQUOTE UNQUOTE UNQUOTE-SPLICING
          quote quasiquote unquote unquote-splicing
          syntax quasisyntax unsyntax unsyntax-splicing
          SYNTAX QUASISYNTAX UNSYNTAX UNSYNTAX-SPLICING) (length1? tail))
        (else                                        #f))))

  (define (read-macro-body l)
    (cadr l))

  (define (read-macro-prefix l)
    (let ((head (car l)) (tail (cdr l)))
      (case head
        ((QUOTE quote)            "'")
        ((QUASIQUOTE quasiquote)       "`")
        ((UNQUOTE unquote)          ",")
        ((UNQUOTE-SPLICING unquote-splicing) ",@")
        ((SYNTAX syntax)            "#'")
        ((QUASISYNTAX quasisyntax)       "#`")
        ((UNSYNTAX unsyntax)          "#,")
        ((UNSYNTAX-SPLICING unsyntax-splicing) "#,@"))))

  (define (out str col)
    (and col (output str) (+ col (string-length str))))

  (define (wr obj col)

    (define (wr-expr expr col)
      (if (read-macro? expr)
        (wr (read-macro-body expr) (out (read-macro-prefix expr) col))
        (wr-lst expr col)))

    (define (wr-lst l col)
      (if (pair? l)
        (let loop ((l (cdr l)) (col (wr (car l) (out "(" col))))
          (and col
               (cond ((pair? l) (loop (cdr l) (wr (car l) (out " " col))))
                     ((null? l) (out ")" col))
                     (else      (out ")" (wr l (out " . " col)))))))
        (out "()" col)))

    (cond ((pair? obj)        (wr-expr obj col))
          ((null? obj)        (wr-lst obj col))
          ((vector? obj)      (wr-lst (vector->list obj) (out "#" col)))
          ((boolean? obj)     (out (if obj "#t" "#f") col))
          ((number? obj)      (out (number->string obj) col))
          ((symbol? obj)      (out (symbol->string obj) col))
          ((bytevector? obj)  (wr-lst (bytevector->u8-list obj) (out "#vu8" col))) ;; added for Mosh
          ((regexp? obj)   (out "#[regexp]" col)) ;; added for Mosh
          ((record? obj)   (out "#[record]" col)) ;; added for Mosh
          ((identifier? obj) (out "#[identifier]" col)) ;; added for Mosh
          ((condition? obj)   (out "#[condition]" col)) ;; added for Mosh
          ((record-type-descriptor? obj)   (out "#[record-type-descriptor]" col)) ;; added for Mosh
          ((eq? unspec obj)   (out "#[unspecified]" col)) ;; added for Mosh
          ((procedure? obj)   (out "#[procedure]" col))
          ((string? obj)      (if display?
                                (out obj col)
                                (let loop ((i 0) (j 0) (col (out "\"" col)))
                                  (if (and col (< j (string-length obj)))
                                    (let ((c (string-ref obj j)))
                                      (if (or (char=? c #\\)
                                              (char=? c #\"))
                                        (loop j
                                              (+ j 1)
                                              (out "\\"
                                                   (out (substring obj i j)
                                                        col)))
                                        (loop i (+ j 1) col)))
                                    (out "\""
                                         (out (substring obj i j) col))))))
          ((char? obj)        (if display?
                                (out (make-string 1 obj) col)
                                (out (case obj
                                       ((#\space)   "space")
                                       ((#\newline) "newline")
                                       (else        (make-string 1 obj)))
                                     (out "#\\" col))))
          ((input-port? obj)  (out "#[input-port]" col))
          ((output-port? obj) (out "#[output-port]" col))
          ((eof-object? obj)  (out "#[eof-object]" col))
          ((socket? obj)      (out "#[socket]" col)) ;; added for Mosh
          ((hashtable? obj)   (out "#[hashtable]" col)) ;; added for Mosh
          (else               (out "#[unknown]" col))))

  (define (pp obj col)

    (define (spaces n col)
      (if (> n 0)
        (if (> n 7)
          (spaces (- n 8) (out "        " col))
          (out (substring "        " 0 n) col))
        col))

    (define (indent to col)
      (and col
           (if (< to col)
             (and (out (make-string 1 #\newline) col) (spaces to 0))
             (spaces (- to col) col))))

    (define (pr obj col extra pp-pair)
      (if (or (pair? obj) (vector? obj)) ; may have to split on multiple lines
        (let ((result '())
              (left (min (+ (- (- width col) extra) 1) max-expr-width)))
          (generic-write obj display? #f
            (lambda (str)
              (set! result (cons str result))
              (set! left (- left (string-length str)))
              (> left 0)))
          (if (> left 0) ; all can be printed on one line
            (out (reverse-string-append result) col)
            (if (pair? obj)
              (pp-pair obj col extra)
              (pp-list (vector->list obj) (out "#" col) extra pp-expr))))
        (wr obj col)))

    (define (pp-expr expr col extra)
      (if (read-macro? expr)
        (pr (read-macro-body expr)
            (out (read-macro-prefix expr) col)
            extra
            pp-expr)
        (let ((head (car expr)))
          (if (symbol? head)
            (let ((proc (style head)))
              (if proc
                (proc expr col extra)
                (if (> (string-length (symbol->string head))
                       max-call-head-width)
                  (pp-general expr col extra #f #f #f pp-expr)
                  (pp-call expr col extra pp-expr))))
            (pp-list expr col extra pp-expr)))))

    ; (head item1
    ;       item2
    ;       item3)
    (define (pp-call expr col extra pp-item)
      (let ((col* (wr (car expr) (out "(" col))))
        (and col
             (pp-down (cdr expr) col* (+ col* 1) extra pp-item))))

    ; (item1
    ;  item2
    ;  item3)
    (define (pp-list l col extra pp-item)
      (let ((col (out "(" col)))
        (pp-down l col col extra pp-item)))

    (define (pp-down l col1 col2 extra pp-item)
      (let loop ((l l) (col col1))
        (and col
             (cond ((pair? l)
                    (let ((rest (cdr l)))
                      (let ((extra (if (null? rest) (+ extra 1) 0)))
                        (loop rest
                              (pr (car l) (indent col2 col) extra pp-item)))))
                   ((null? l)
                    (out ")" col))
                   (else
                    (out ")"
                         (pr l
                             (indent col2 (out "." (indent col2 col)))
                             (+ extra 1)
                             pp-item)))))))

    (define (pp-general expr col extra named? pp-1 pp-2 pp-3)

      (define (tail1 rest col1 col2 col3)
        (if (and pp-1 (pair? rest))
          (let* ((val1 (car rest))
                 (rest (cdr rest))
                 (extra (if (null? rest) (+ extra 1) 0)))
            (tail2 rest col1 (pr val1 (indent col3 col2) extra pp-1) col3))
          (tail2 rest col1 col2 col3)))

      (define (tail2 rest col1 col2 col3)
        (if (and pp-2 (pair? rest))
          (let* ((val1 (car rest))
                 (rest (cdr rest))
                 (extra (if (null? rest) (+ extra 1) 0)))
            (tail3 rest col1 (pr val1 (indent col3 col2) extra pp-2)))
          (tail3 rest col1 col2)))

      (define (tail3 rest col1 col2)
        (pp-down rest col2 col1 extra pp-3))

      (let* ((head (car expr))
             (rest (cdr expr))
             (col* (wr head (out "(" col))))
        (if (and named? (pair? rest))
          (let* ((name (car rest))
                 (rest (cdr rest))
                 (col** (wr name (out " " col*))))
            (tail1 rest (+ col indent-general) col** (+ col** 1)))
          (tail1 rest (+ col indent-general) col* (+ col* 1)))))

    (define (pp-expr-list l col extra)
      (pp-list l col extra pp-expr))

    (define (pp-LAMBDA expr col extra)
      (pp-general expr col extra #f pp-expr-list #f pp-expr))

    (define (pp-IF expr col extra)
      (pp-general expr col extra #f pp-expr #f pp-expr))

    (define (pp-COND expr col extra)
      (pp-call expr col extra pp-expr-list))

    (define (pp-CASE expr col extra)
      (pp-general expr col extra #f pp-expr #f pp-expr-list))

    (define (pp-AND expr col extra)
      (pp-call expr col extra pp-expr))

    (define (pp-LET expr col extra)
      (let* ((rest (cdr expr))
             (named? (and (pair? rest) (symbol? (car rest)))))
        (pp-general expr col extra named? pp-expr-list #f pp-expr)))

    (define (pp-BEGIN expr col extra)
      (pp-general expr col extra #f #f #f pp-expr))

    (define (pp-DO expr col extra)
      (pp-general expr col extra #f pp-expr-list pp-expr-list pp-expr))

    ; define formatting style (change these to suit your style)

    (define indent-general 2)

    (define max-call-head-width 5)

    (define max-expr-width 50)

    (define (style head)
      (case head
        ((LAMBDA LET* LETREC DEFINE) pp-LAMBDA)
        ((IF SET!)                   pp-IF)
        ((COND)                      pp-COND)
        ((CASE)                      pp-CASE)
        ((AND OR)                    pp-AND)
        ((LET)                       pp-LET)
        ((BEGIN)                     pp-BEGIN)
        ((DO)                        pp-DO)
        (else                        #f)))

    (pr obj col 0 pp-expr))

  (if width
    (out (make-string 1 #\newline) (pp obj 0))
    (wr obj 0)))

; (reverse-string-append l) = (apply string-append (reverse l))

(define (reverse-string-append l)

  (define (rev-string-append l i)
    (if (pair? l)
      (let* ((str (car l))
             (len (string-length str))
             (result (rev-string-append (cdr l) (+ i len))))
        (let loop ((j 0) (k (- (- (string-length result) i) len)))
          (if (< j len)
            (begin
              (string-set! result k (string-ref str j))
              (loop (+ j 1) (+ k 1)))
            result)))
      (make-string i)))

  (rev-string-append l 0))

; (object->string obj) returns the textual representation of 'obj' as a
; string.
;
; Note: (write obj) = (display (object->string obj))

(define (object->string obj)
  (let ((result '()))
    (generic-write obj #f #f (lambda (str) (set! result (cons str result)) #t))
    (reverse-string-append result)))

; (object->limited-string obj limit) returns a string containing the first
; 'limit' characters of the textual representation of 'obj'.

(define (object->limited-string obj limit)
  (let ((result '()) (left limit))
    (generic-write obj #f #f
      (lambda (str)
        (let ((len (string-length str)))
          (if (> len left)
            (begin
              (set! result (cons (substring str 0 left) result))
              (set! left 0)
              #f)
            (begin
              (set! result (cons str result))
              (set! left (- left len))
              #t)))))
    (reverse-string-append result)))

; (pretty-print obj port) pretty prints 'obj' on 'port'.  The current
; output port is used if 'port' is not specified.

#|
    Function: pretty-print

    pretty print out Scheme object to the output port.

    Prototype:
    > (pretty-print obj . port)

    Parameters:

      obj - object to print
      port - output port. Default is (current-output-port).

    Returns:

      unspecified
|#
(define (pretty-print obj . opt)
  (let ((port (if (pair? opt) (car opt) (current-output-port))))
    (generic-write obj #f 79 (lambda (s) (display s port) #t))))

#|
    Function: p

    Print obj and return obj.
    This is useful for debugging like following.
    > (and (p hoge) (p hige))

    Prototype:
    > (p obj)

    Parameters:

      obj - object to print. obj can be multiple values.

    Returns:

      obj
|#
(define-syntax p
  (lambda (x)
    (syntax-case x ()
      [(_ obj)
       #'(call-with-values (lambda () obj) (lambda x (display x) (newline) (apply values x)))])))

#|
    Function: pp

    short cut for <pretty-print>

    Prototype:
    > (pp obj)

    Parameters:

      obj - object to print. obj can be multiple values.

    Returns:

      unspecified
|#
(define pp pretty-print)


; (pretty-print-to-string obj) returns a string with the pretty-printed
; textual representation of 'obj'.

(define (pretty-print-to-string obj)
  (let ((result '()))
    (generic-write obj #f 79 (lambda (str) (set! result (cons str result)) #t))
    (reverse-string-append result)))

)
