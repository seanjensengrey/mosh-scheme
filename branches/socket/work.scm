(import (rnrs)
        (mosh)
        (match))

;; (match (list 'hige 1 2 3)
;;   [('hige x y . z)
;;    (format #t "x=~a y=~a" x y)])

(match '(0 (1 2) (3 4 5))
  ((a (b c) (d e f))
   (list a b c d e f)))

 	

(display (match 123
  ((? string? x) (list 'string x))
  ((? number? x) (list 'number x))))

 	

;; (match '(the answer is 42)
;;   (`(the answer is ,value) value)
;;   (else #f))


;        (mosh socket))

;; (define (print x)
;;   (display x)
;;   (newline))

;; (print    AF_INET)
;; (print    AF_INET6)
;; (print     AF_UNSPEC)
;; (print     SOCK_STREAM)
;; (print     SOCK_DGRAM)
;; (print     AI_ADDRCONFIG)
;; (print     AI_ALL)
;; (print     AI_CANONNAME)
;; (print     AI_NUMERICHOST)
;; (print     AI_NUMERICSERV)
;; (print     AI_PASSIVE)
;; (print     AI_V4MAPPED)
;; (print     IPPROTO_TCP)
;; (print     IPPROTO_UDP)
;; (print     IPPROTO_RAW)
;; (print     SHUT_RD)
;; (print     SHUT_WR)
;; (print     SHUT_RDWR)
