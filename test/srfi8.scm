(import (rnrs)
        (srfi :8)
        (mosh test))

(test-eqv (receive (a b . c) (values 1 2 3 4 5)
         (apply + a b c))
       15)

(test-results)
