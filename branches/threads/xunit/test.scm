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

(test-equal
"unexpected error (assert-true (car 3)) :
Condition components:
 1. &assertion
 2. &who             who: \"car\"
 3. &message         message: \"pair required\"
 4. &irritants       irritants: (3)

(assert-true (number? #\\a))
6 run, 2 failed" (test-results))

(test-end)
