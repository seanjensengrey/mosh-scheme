(library (xunit)
         (export assert-true assert-false test-results)
         (import (rnrs) (mosh) (match))

(define (condition-printer e port)
    (define max-condition-len (apply max (map (lambda (c) (string-length (symbol->string (record-type-name (record-rtd c))))) (simple-conditions e))))
    (display "Condition components:\n" port)
    (for-each-with-index
     (lambda (i x)
       (let ([rtd (record-rtd x)]
             [fields-alist (record->field-alist x)])
        (format port " ~d. ~a" i (rpad (symbol->string (record-type-name rtd)) " " max-condition-len))
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

(define (identity x) x)

(define-syntax assert-true
  (lambda (x)
    (syntax-case x ()
      [(_ expr)
       #'(test-bool '(assert-true expr) (lambda () expr) identity)])))

(define-syntax assert-false
  (lambda (x)
    (syntax-case x ()
      [(_ expr)
       #'(test-bool '(assert-false expr) (lambda () expr) not)])))



(define (test-results)
  (let-values (([out get-string] (open-string-output-port)))
    (for-each
     (lambda (error)
       (match error
        [('unexpected expr exception)
         (format out "unexpected error ~s :\n~a\n" expr (exception->string exception))]
        [else
         (format out "~s\n" error)]))
     error*)
    (format out "~d run, ~d failed" run-count failed-count)
    (get-string)))

)
