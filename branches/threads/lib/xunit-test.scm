(import (prefix (xunit) xunit:)
        (mosh test)
        (rnrs))

(test-begin "basic assert")

(test-true (xunit:test-true #t))
(test-true (xunit:test-true (number? 3)))
(test-false (xunit:test-true (number? #\a)))

;; xunit:test-true evaluate expression only once.
(define once 0)
(test-true (xunit:test-true (begin (set! once (+ once 1)) #t)))
(test-eq 1 once)

(test-true (condition? (xunit:test-true (car 3))))

(test-false (xunit:test-false (pair? 3)))

(xunit:test-eq 3 (+ 1 2))
(xunit:test-eq 4 (+ 1 2))

(xunit:fail "my tests failed")

(xunit:test-error error? 3)

(xunit:test-error pair? (car 3))

(xunit:test-null 3)

(xunit:test-write-equal "#\\b" #\a)

(test-equal
"============================================================
  (test-true (number? #\\a))
============================================================

  ERROR : (test-true (car 3))
    Condition components:
     1. &assertion
     2. &who             who: \"car\"
     3. &message         message: \"pair required\"
     4. &irritants       irritants: (3)

============================================================
  (+ 1 2) : expected 4, actual 3
============================================================
  FAILURE : my tests failed
============================================================
  3 :
    expected to raise error which satisfies error? predicate
============================================================
  (car 3) :
    raised error doesn't satisfy pair? predicate
============================================================
  3 : expected (), actual 3
============================================================
  (write #\\a) : expected #\\b, actual #\\a
" (xunit:test-error-string))

(test-equal
 "[  FAILED  ] 4 passed, 8 failed." (xunit:test-summary-string))
(test-end)
