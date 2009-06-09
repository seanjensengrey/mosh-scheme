(import (rnrs)
        (mosh)
        (mosh concurrent)
        (mosh test))

(let ([pid (spawn-link
            (lambda () (car 3)) ;; this causes error
            '((rnrs) (mosh) (mosh concurrent)))])
  (receive
    [('exit why)
     (test-true (process-error? why))
     (let ([who (find who-condition? (simple-conditions (process-error why)))])
       (test-true who)
       (test-equal "car" (condition-who who)))]
    [x (fail (format "unexpected ~a\n" x))])
  (join! pid))

(test-results)
