(library (xunit)
         (export test-true test-false test-eq test-eqv test-equal test-null
                 test-write-equal
                 test-error test-results fail
                 test-error-string   ; exported for tests of xunit
                 test-summary-string ; exported for tests of xunit
                 )
         (import (only (rnrs) define apply max map lambda string-length symbol->string record-type-name record-rtd simple-conditions
                       display let when newline null? car cdr write define-syntax syntax-case _ ... syntax if string=? cond quote else
                       unless + - append cons vector->list record-type-field-names record-type-parent symbol? record-accessor
                       reverse <= string-append do let-values open-string-output-port set! quasiquote call/cc with-exception-handler
                       for-each zero? dynamic-wind exit > begin not eq? eqv? equal? unquote)
                 (only (mosh) host-os format ungensym)
                 (only (match) match))

(define (condition-printer e port)
    (define max-condition-len (apply max (map (lambda (c) (string-length (symbol->string (record-type-name (record-rtd c))))) (simple-conditions e))))
    (display "    Condition components:\n" port)
    (for-each-with-index
     (lambda (i x)
       (let ([rtd (record-rtd x)]
             [fields-alist (record->field-alist x)])
        (format port "     ~d. ~a" i (rpad (symbol->string (record-type-name rtd)) " " max-condition-len))
        (when (null? fields-alist)
          (newline port))
         (let loop ([first #t]
                    [fields-alist fields-alist])
           (cond
            [(null? fields-alist) '()]
            [else
             (let ([field (car fields-alist)])
               (unless first
                 (display (rpad "" " " (+ 4 max-condition-len)) port))
             (display "       " port)
             (display (car field) port)
             (display ": " port)
             (write (cdr field) port)
             (newline port)
             (loop #f (cdr fields-alist)))
             ]
          ))))
     (simple-conditions e)))

(define (record->field-alist r)
  (define (ref rtd i x)
    (let ([val ((record-accessor rtd i) x)])
      (if (symbol? val)
          (ungensym val)
          val)))
  (let loop ([ret '()]
             [rtd (record-rtd r)])
    (cond
     [rtd
      (loop (append ret
      (map-with-index
       (lambda (i field)
         (cons field (ref rtd i r)))
       (vector->list (record-type-field-names rtd)))) (record-type-parent rtd))]
     [else ret])))

(define (map-with-index proc lst)
  (let loop ([i 0]
             [lst lst]
             [ret '()])
    (if (null? lst)
        (reverse ret)
        (loop (+ i 1) (cdr lst) (cons (proc i (car lst)) ret)))))

(define (rpad str pad n)
  (let ([rest (- n (string-length (format "~a" str)))])
    (let loop ([rest rest]
               [ret (format "~a" str)])
      (if (<= rest 0)
          ret
          (loop (- rest 1) (string-append ret pad))))))
  (define (for-each-with-index proc lst)
    (do ((i 1 (+ i 1)) ; start with 1
         (lst lst (cdr lst)))
        ((null? lst))
      (proc i (car lst))))

(define (exception->string e)
  (let-values (([out get-string] (open-string-output-port)))
    (condition-printer e out)
    (get-string)))

(define run-count 0)
(define failed-count 0)
(define error* '())

(define (run-count++)
  (set! run-count (+ run-count 1)))

(define (failed-count++)
  (set! failed-count (+ failed-count 1)))

(define (add-error! expr)
  (set! error* (cons expr error*)))

(define (fail message)
  (failed-count++)
  (add-error! `(failure ,message)))

(define (test-bool expr thunk true?)
  (run-count++)
  (call/cc
   (lambda (escape)
     (with-exception-handler
      (lambda (e)
        (failed-count++)
        (add-error! `(unexpected ,expr ,e))
        (escape e))
      (lambda ()
        (let ([val (thunk)])
          (unless (true? val)
            (add-error! expr)
            (failed-count++))
          val))))))

(define (test-cmp expr pred thunk expected)
  (run-count++)
  (call/cc
   (lambda (escape)
     (with-exception-handler
      (lambda (e)
        (failed-count++)
        (add-error! `(unexpected ,expr ,e))
        (escape e))
      (lambda ()
        (let ([val (thunk)])
          (unless (pred val expected)
            (add-error! `(compare-error ,expr ,expected ,val))
            (failed-count++))
          val))))))

(define (identity x) x)

(define-syntax test-true
  (lambda (x)
    (syntax-case x ()
      [(_ expr)
       #'(test-bool '(test-true expr) (lambda () expr) identity)])))

(define-syntax test-false
  (lambda (x)
    (syntax-case x ()
      [(_ expr)
       #'(test-bool '(test-false expr) (lambda () expr) not)])))

(define-syntax test-eq
  (lambda (x)
    (syntax-case x ()
      [(_ expected expr)
       #'(test-cmp 'expr eq? (lambda () expr) expected)])))

(define-syntax test-eqv
  (lambda (x)
    (syntax-case x ()
      [(_ expected expr)
       #'(test-cmp 'expr eqv? (lambda () expr) expected)])))

(define-syntax test-equal
  (lambda (x)
    (syntax-case x ()
      [(_ expected expr)
       #'(test-cmp 'expr equal? (lambda () expr) expected)])))

(define-syntax test-write-equal
  (lambda (x)
    (syntax-case x ()
      [(_ expected expr)
       #'(let-values ([(port get-string) (open-string-output-port)])
           (write expr port)
           (test-cmp '(write expr) string=? get-string expected))])))


(define-syntax test-error
  (lambda (x)
    (syntax-case x ()
      [(_ pred expr)
       #'(begin
           (run-count++)
           (call/cc
            (lambda (escape)
              (with-exception-handler
               (lambda (e)
                 (unless (pred e)
                   (failed-count++)
                   (add-error! `(error-not-pred expr pred)))
                 (escape e))
               (lambda ()
                 (let ([val expr])
                   (add-error! `(error-not-raised expr pred))
                     (failed-count++)
                   val))))))])))

(define-syntax test-null
  (lambda (x)
    (syntax-case x ()
      [(_ expr)
       #'(test-cmp 'expr eq? (lambda () expr) '())])))


(define-syntax with-color
  (lambda (x)
    (syntax-case x ()
      [(_ color expr more ...)
       (if (string=? (host-os) "win32")
           #'(begin expr more ...)
           #'(dynamic-wind
                 (lambda () (display color))
                 (lambda () expr more ...)
                 (lambda () (display "\x1b;[m")))]))))

(define-syntax with-color-green
  (lambda (x)
    (syntax-case x ()
      [(_ expr more ...)
       #'(with-color "\x1b;[0;32m" expr more ...)])))

(define-syntax with-color-red
  (lambda (x)
    (syntax-case x ()
      [(_ expr more ...)
       #'(with-color "\x1b;[0;31m" expr more ...)])))

(define (test-error-string)
  (let-values (([out get-string] (open-string-output-port)))
    (for-each
     (lambda (error)
       (display "============================================================" out)
       (newline out)
       (match error
        [('unexpected expr exception)
         (format out "\n  ERROR : ~s\n~a\n" expr (exception->string exception))]
        [('compare-error expr expected actual)
         (format out "  ~s : expected ~a, actual ~a\n" expr expected actual)]
        [('failure message)
         (format out "  FAILURE : ~a\n" message)]
        [('error-not-raised expr pred)
         (format out "  ~a :\n    expected to raise error which satisfies ~a predicate\n"
                 expr pred)]
        [('error-not-pred expr pred)
         (format out "  ~a :\n    raised error doesn't satisfy ~a predicate\n" expr pred)]
        [else
         (format out "  ~s\n" error)]))
     (reverse error*))
    (get-string)))

(define (test-summary-string)
  (if (zero? failed-count)
      (format "[  PASSED  ] ~d tests." run-count failed-count)
      (format "[  FAILED  ] ~d passed, ~d failed." (- run-count failed-count) failed-count)))

(define (test-results)
  (define has-error? (> failed-count 0))
  (display (test-error-string))
  (when has-error?
    (newline))
  (cond
   [has-error?
    (with-color-red
     (display (test-summary-string)))]
   [else
    (with-color-green
     (display (test-summary-string)))])
  (newline)
  (when has-error?
    (exit -1)))

)
