(import (rnrs)
        (mosh test))

(test-begin "re2c greeding bug check")

(let ([p (open-string-input-port
           "ab cd ef gh ij kl mn op qr st uv wx yz\n")])
  (test-equal "ab" (get-datum p))
  (test-eqv #\space  (get-char p))
  (test-equal "cd" (get-datum p))
  (test-eqv #\space (get-char p))
  (close-port p))

(let ([p (open-string-input-port
           "\"abcdefghijklmnopqrstuvwxyz\"")])
  (test-equal "string length greater than 18 (fill buffer)" "abcdefghijklmnopqrstuvwxyz" (get-datum p))
  (close-port p))

(test-end)
