(import (rnrs)
        (mosh)
        (only (srfi :1) alist-cons)
        (only (srfi :13) string-join)
        (mosh socket)
        (mosh test))

(let ([socket (make-client-socket "localhost" "11121")])
  (define (recv-reply)
    (let ([buffer-size 4096])
      (let loop ([ret (make-bytevector 0)]
                 [data (socket-recv socket buffer-size)])
        (let* ([total-size (+ (bytevector-length ret) (bytevector-length data))]
               [new (make-bytevector total-size)])
          (bytevector-copy! ret 0 new 0 (bytevector-length ret))
          (bytevector-copy! data 0 new (bytevector-length ret) (bytevector-length data))
          (if (= (bytevector-length data) buffer-size)
              (loop new (socket-recv socket buffer-size))
              new)))))
  (define (send text)
    (socket-send socket (string->utf8 text)))
  (define (set/s key value index)
    (send (format "set/s ~a ~a 0 0 ~d\r\n~a\r\n" key index (string-length value) value))
    (socket-recv socket 1024))
  (define (set key value)
    (send (format "set ~a 0 0 ~d\r\n~a\r\n" key (string-length value) value))
    (socket-recv socket 1024))
  (define (get/s key1 key2 index limit)
    (send (format "get/s ~a ~a ~a ~d\r\n" key1 key2 index limit))
    (let loop ([lines (string-split (utf8->string (recv-reply)) #\newline)]
               [ret '()])
      (cond
       [(#/^VALUE ([^\s]+) [^\s]+ \d+$/ (car lines)) =>
        (lambda (m)
          (loop (cddr lines) (alist-cons (m 1) (cadr lines) ret)))]
       [(#/END/ (car lines))
        (reverse ret)]
       [else
        (error 'gets "malformed gets replry" (car lines))])))
  (define (gets . keys)
    (send (format "get ~a\r\n" (string-join keys " ")))
    (let loop ([lines (string-split (utf8->string (recv-reply)) #\newline)]
               [ret '()])
      (cond
       [(#/^VALUE ([^\s]+) [^\s]+ \d+$/ (car lines)) =>
        (lambda (m)
          (loop (cddr lines) (alist-cons (m 1) (cadr lines) ret)))]
       [(#/END/ (car lines))
        (reverse ret)]
       [else
        (error 'gets "malformed gets replry" (car lines))])))
  (define (get key)
    (let ([ret (assoc key (gets key))])
      (if ret
          (cdr ret)
          #f)))
  (set "Hello" "World!")
  (set "Good" "Bye!")
  (set "Hi" "Higepon")
  (test-equal "Higepon" (get "Hi"))
  (test-equal "Bye!" (get "Good"))
  (test-equal "World!" (get "Hello"))
  (set/s "def" "$def" "myindex")
  (set/s "abc" "$abc" "myindex")
  (set/s "abd" "$abd" "myindex")
  (display (get/s "ab" "ac" "myindex" 2))

  #;(let ([ret (gets "Hello" "Good" "Hi" "Not Exist")])
    (test-eq 3 (length ret))
    (test-true (assoc "Hello" ret))
    (test-true (assoc "Good" ret))
    (test-true (assoc "Hi" ret))))

(test-results)
