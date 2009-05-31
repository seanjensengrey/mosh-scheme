(import (xunit)
        (mosh test)
        (rnrs))

(test-begin "basic assert")

(test-true (assert-true #t))
(test-true (assert-true (number? 3)))
(test-false (assert-true (number? #\a)))

;; assert-true evaluate expression only once.
(define once 0)
(test-true (assert-true (begin (set! once (+ once 1)) #t)))
(test-eq 1 once)

(test-true (condition? (assert-true (car 3))))

(test-false (assert-false (pair? 3)))

(assert-eq 3 (+ 1 2))
(assert-eq 4 (+ 1 2))

(test-equal
"(assert-true (number? #\\a))
unexpected error (assert-true (car 3)) :
Condition components:
 1. &assertion
 2. &who             who: \"car\"
 3. &message         message: \"pair required\"
 4. &irritants       irritants: (3)

(+ 1 2) : expected 4, actual 3
8 run, 3 failed" (test-results))

(test-end)
