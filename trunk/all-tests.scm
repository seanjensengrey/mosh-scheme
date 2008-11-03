;; (if (equal? '#t (begin #t)) (format #t "~d   " 1) (begin (newline) (error 'test "\nfailed" '#t)))
;; (let1 val (begin (source-info '(3))) (if (equal? '("all-tests.scm" 2) val) (format #t "~d   " 2) (error 'test "failed" '("all-tests.scm" 2) val)))
;; (if (equal? '#t (begin (and))) (format #t "~d   " 3) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '3 (begin 3)) (format #t "~d   " 4) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '4 (begin 4)) (format #t "~d   " 5) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '#t (begin (if #f #f #t))) (format #t "~d   " 6) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '3 (begin ((lambda (a) 3) 4))) (format #t "~d   " 7) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '7 (begin ((lambda (a) (if 3 7 5)) 6))) (format #t "~d   " 8) (begin (newline) (error 'test "\nfailed" '7)))
;; (if (equal? '3 (begin ((lambda () 3)))) (format #t "~d   " 9) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '101 (begin ((lambda (a) a) 101))) (format #t "~d   " 10) (begin (newline) (error 'test "\nfailed" '101)))
;; (if (equal? '102 (begin (((lambda () (lambda () 102)))))) (format #t "~d   " 11) (begin (newline) (error 'test "\nfailed" '102)))
;; (if (equal? '102 (begin (((lambda () (lambda (a) 102))) 101))) (format #t "~d   " 12) (begin (newline) (error 'test "\nfailed" '102)))
;; (if (equal? '103 (begin (((lambda () (lambda (a) a))) 103))) (format #t "~d   " 13) (begin (newline) (error 'test "\nfailed" '103)))
;; (if (equal? '10 (begin (((lambda (a) (lambda () a)) 10)))) (format #t "~d   " 14) (begin (newline) (error 'test "\nfailed" '10)))
;; (if (equal? '12 (begin ((lambda (a) (set! a 12) a) 2))) (format #t "~d   " 15) (begin (newline) (error 'test "\nfailed" '12)))
;; (if (equal? '101 (begin ((lambda (a) ((lambda () (set! a 101)))) '()))) (format #t "~d   " 16) (begin (newline) (error 'test "\nfailed" '101)))
;; (if (equal? '4 (begin (call/cc (lambda (c) (c 4))))) (format #t "~d   " 17) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '(1 2 3) (begin (receive a (call/cc (lambda (c) (c 1 2 3))) a))) (format #t "~d   " 18) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '(1 2) (begin (receive a (call/cc (lambda (c) (c 1 2))) a))) (format #t "~d   " 19) (begin (newline) (error 'test "\nfailed" '(1 2))))
;; (if (equal? '(1) (begin (receive a (call/cc (lambda (c) (c 1))) a))) (format #t "~d   " 20) (begin (newline) (error 'test "\nfailed" '(1))))
;; (if (equal? '3 (begin ((lambda (cont) (if (call/cc (lambda (c) (set! cont c))) (cont #f) 3)) '()))) (format #t "~d   " 21) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '102 (begin ((lambda (cont) (if (call/cc (lambda (c) (set! cont c))) ((lambda () ((lambda () (cont #f))))) 102)) '()))) (format #t "~d   " 22) (begin (newline) (error 'test "\nfailed" '102)))
;; (if (equal? '5 (begin ((lambda () 3 4 5)))) (format #t "~d   " 23) (begin (newline) (error 'test "\nfailed" '5)))
;; (if (equal? '#t (begin (number? 3))) (format #t "~d   " 24) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (number? 'a))) (format #t "~d   " 25) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (number? 'a))) (format #t "~d   " 26) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '4 (begin (+ 4))) (format #t "~d   " 27) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '7 (begin (+ 4 3))) (format #t "~d   " 28) (begin (newline) (error 'test "\nfailed" '7)))
;; (if (equal? '17 (begin (+ 4 3 10))) (format #t "~d   " 29) (begin (newline) (error 'test "\nfailed" '17)))
;; (if (equal? '4 (begin (+ 1 1 1 1))) (format #t "~d   " 30) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '5 (begin (- 10 5))) (format #t "~d   " 31) (begin (newline) (error 'test "\nfailed" '5)))
;; (if (equal? '3 (begin (- 10 5 2))) (format #t "~d   " 32) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '(a . b) (begin (cons 'a 'b))) (format #t "~d   " 33) (begin (newline) (error 'test "\nfailed" '(a . b))))
;; (if (equal? '2 (begin (car (cons 2 3)))) (format #t "~d   " 34) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '3 (begin (cdr (cons 2 3)))) (format #t "~d   " 35) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (cadr (cons 2 (cons 3 '()))))) (format #t "~d   " 36) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '#t (begin (= 3 3))) (format #t "~d   " 37) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (= 3 4))) (format #t "~d   " 38) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '3 (begin (let ((a 3)) a))) (format #t "~d   " 39) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '1 (begin (let ((a 3) (b 1)) b))) (format #t "~d   " 40) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '3 (begin (let ((a 3) (b 1)) a))) (format #t "~d   " 41) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '1 (begin (let ((a 3) (b 1)) a b))) (format #t "~d   " 42) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '3 (begin (let1 a 3 a))) (format #t "~d   " 43) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '4 (begin (let1 a 3 (let1 b 4 b)))) (format #t "~d   " 44) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '3 (begin (let1 a 3 (let1 b 4 a)))) (format #t "~d   " 45) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '7 (begin (let1 a 3 (let1 b 4 (+ a b))))) (format #t "~d   " 46) (begin (newline) (error 'test "\nfailed" '7)))
;; (if (equal? '12 (begin (let1 a 3 (let1 b 4 (let1 c 5 (+ a b c)))))) (format #t "~d   " 47) (begin (newline) (error 'test "\nfailed" '12)))
;; (if (equal? '12 (begin (let ((a 3) (b 4)) (let1 c 5 (+ a b c))))) (format #t "~d   " 48) (begin (newline) (error 'test "\nfailed" '12)))
;; (if (equal? '13 (begin (let ((a 3) (b 4)) (+ (let1 c 5 (+ a b c)) 1)))) (format #t "~d   " 49) (begin (newline) (error 'test "\nfailed" '13)))
;; (if (equal? '4 (begin (let1 a 3 (let1 a 4 a)))) (format #t "~d   " 50) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '5 (begin (let1 a 3 (set! a (+ a 1)) (+ a 1)))) (format #t "~d   " 51) (begin (newline) (error 'test "\nfailed" '5)))
;; (if (equal? '3 (begin (let1 a 3 (let1 b 4 (set! b a) b)))) (format #t "~d   " 52) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '2 (begin (let ((a 2) (b 3)) a))) (format #t "~d   " 53) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '2 (begin (let ((a 0) (b 1) (c 2)) c))) (format #t "~d   " 54) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '4 (begin (let1 a 1 (let1 b 2 (let1 c a (+ a b c)))))) (format #t "~d   " 55) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '3 (begin (let ((a 3)) a))) (format #t "~d   " 56) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '7 (begin (let ((a 3) (b 4)) (+ a b)))) (format #t "~d   " 57) (begin (newline) (error 'test "\nfailed" '7)))
;; (if (equal? '4 (begin (let* ((a 3) (b (+ a 1))) b))) (format #t "~d   " 58) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '4 (begin (let1 a 3 (let1 b 4 (let1 c (lambda () b) (set! a c))) (a)))) (format #t "~d   " 59) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '1 (begin (let ((a 0) (b 1)) (let ((c (lambda () b))) (c))))) (format #t "~d   " 60) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '1 (begin (let ((a 0) (b 1)) ((lambda () b))))) (format #t "~d   " 61) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '3 (begin (let ((a 0) (b 1)) (let ((c (lambda () (set! b 3) b))) (c))))) (format #t "~d   " 62) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (let ((a 0) (b 1)) (let1 c (lambda () (set! b 3) b) (c))))) (format #t "~d   " 63) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '100 (begin (let1 a 100 (let1 c (let1 d (lambda () a) d) (c))))) (format #t "~d   " 64) (begin (newline) (error 'test "\nfailed" '100)))
;; (if (equal? '1000 (begin (let ((a '())) (let ((G68 (lambda (i) (if (>= i 1000) i (a (+ i 1)))))) (set! a G68) (a 0))))) (format #t "~d   " 65) (begin (newline) (error 'test "\nfailed" '1000)))
;; (if (equal? '1000 (begin (letrec ((a (lambda (i) (if (>= i 1000) i (a (+ i 1)))))) (a 0)))) (format #t "~d   " 66) (begin (newline) (error 'test "\nfailed" '1000)))
;; (if (equal? '1 (begin (letrec ((a 1) (b (lambda () a))) (b)))) (format #t "~d   " 67) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '(#t . #f) (begin (letrec ((even? (lambda (n) (if (= 0 n) #t (odd? (- n 1))))) (odd? (lambda (n) (if (= 0 n) #f (even? (- n 1)))))) (cons (even? 88) (odd? 88))))) (format #t "~d   " 68) (begin (newline) (error 'test "\nfailed" '(#t . #f))))
;; (if (equal? '10 (begin (letrec ((a (lambda (i) (if (= i 10) i (a (+ i 1)))))) (a 0)))) (format #t "~d   " 69) (begin (newline) (error 'test "\nfailed" '10)))
;; (if (equal? '1000 (begin ((lambda (a) (set! a 1000) a) '()))) (format #t "~d   " 70) (begin (newline) (error 'test "\nfailed" '1000)))
;; (if (equal? '20 (begin ((lambda (a) (set! a (lambda (i) (if (= i 20) i (a (+ i 1))))) (a 0)) '()))) (format #t "~d   " 71) (begin (newline) (error 'test "\nfailed" '20)))
;; (if (equal? '3 (begin (or #f 3 4))) (format #t "~d   " 72) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (define a 3))) (format #t "~d   " 73) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin a)) (format #t "~d   " 74) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '#f (begin (= 3 4))) (format #t "~d   " 75) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (= 3 3 3))) (format #t "~d   " 76) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (= 3 4 5))) (format #t "~d   " 77) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '101 (begin (((lambda (a) (lambda () a)) 101)))) (format #t "~d   " 78) (begin (newline) (error 'test "\nfailed" '101)))
;; (if (equal? '102 (begin (((lambda (a) (lambda (b) (+ a b))) 101) 1))) (format #t "~d   " 79) (begin (newline) (error 'test "\nfailed" '102)))
;; (if (equal? '#t (begin (null? '()))) (format #t "~d   " 80) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (null? 3))) (format #t "~d   " 81) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '(1 . 2) (begin (cons 1 2))) (format #t "~d   " 82) (begin (newline) (error 'test "\nfailed" '(1 . 2))))
;; (if (equal? '(1 2) (begin (cons 1 (cons 2 '())))) (format #t "~d   " 83) (begin (newline) (error 'test "\nfailed" '(1 2))))
;; (if (equal? '3 (begin (begin 1 2 3))) (format #t "~d   " 84) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '4 (begin ((lambda () (set! a 4) a)))) (format #t "~d   " 85) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '3 (begin ((lambda () ((lambda () 3)))))) (format #t "~d   " 86) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin ((lambda () ((lambda (x) x) 3))))) (format #t "~d   " 87) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin ((lambda (y) ((lambda (x) x) 3)) 4))) (format #t "~d   " 88) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin ((lambda () (let1 a 1 ((lambda () 3))))))) (format #t "~d   " 89) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin ((lambda () (let1 b 2 (let1 a 1 ((lambda () 3)))))))) (format #t "~d   " 90) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin ((lambda () (if 3 ((lambda () 3))))))) (format #t "~d   " 91) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '4 (begin ((lambda () (if ((lambda () 3)) 4 5))))) (format #t "~d   " 92) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '10 (begin (let loop ((i 0)) (if (= i 10) i (let1 a 1 (let1 b 0 (loop (+ i a b)))))))) (format #t "~d   " 93) (begin (newline) (error 'test "\nfailed" '10)))
;; (if (equal? '10 (begin (let loop ((i 0)) (if (= i 10) i (let1 a 1 (let1 b 0 (loop (+ i a b)))))))) (format #t "~d   " 94) (begin (newline) (error 'test "\nfailed" '10)))
;; (if (equal? '6 (begin ((lambda () (define d (lambda (x y z) (+ x y z))) (d 1 2 3))))) (format #t "~d   " 95) (begin (newline) (error 'test "\nfailed" '6)))
;; (if (equal? '3 (begin ((lambda () (define b (lambda () 3)) (b))))) (format #t "~d   " 96) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (apply car '((3 2))))) (format #t "~d   " 97) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '(1 2 3) (begin ((lambda a a) 1 2 3))) (format #t "~d   " 98) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '(2 3) (begin ((lambda (a . b) b) 1 2 3))) (format #t "~d   " 99) (begin (newline) (error 'test "\nfailed" '(2 3))))
;; (if (equal? '(2 3 4) (begin ((lambda (a . b) b) 1 2 3 4))) (format #t "~d   " 100) (begin (newline) (error 'test "\nfailed" '(2 3 4))))
;; (if (equal? '(3 4) (begin ((lambda (a b . c) c) 1 2 3 4))) (format #t "~d   " 101) (begin (newline) (error 'test "\nfailed" '(3 4))))
;; (if (equal? '(4) (begin ((lambda (a b c . d) d) 1 2 3 4))) (format #t "~d   " 102) (begin (newline) (error 'test "\nfailed" '(4))))
;; (if (equal? '() (begin ((lambda (a b c . d) d) 1 2 3))) (format #t "~d   " 103) (begin (newline) (error 'test "\nfailed" '())))
;; (if (equal? '() (begin ((lambda a a)))) (format #t "~d   " 104) (begin (newline) (error 'test "\nfailed" '())))
;; (if (equal? '(1) (begin ((lambda a a) 1))) (format #t "~d   " 105) (begin (newline) (error 'test "\nfailed" '(1))))
;; (if (equal? '34 (begin (when #t 1 2 34))) (format #t "~d   " 106) (begin (newline) (error 'test "\nfailed" '34)))
;; (if (equal? '#f (begin (not 3))) (format #t "~d   " 107) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '48 (begin (unless #f 1 2 48))) (format #t "~d   " 108) (begin (newline) (error 'test "\nfailed" '48)))
;; (if (equal? '5 (begin (and 3 4 5))) (format #t "~d   " 109) (begin (newline) (error 'test "\nfailed" '5)))
;; (if (equal? '1 (begin (let1 a 0 (and (set! a (+ a 1))) a))) (format #t "~d   " 110) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '1 (begin (let1 a 0 (or (set! a (+ a 1))) a))) (format #t "~d   " 111) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '#f (begin (and 3 #f 5))) (format #t "~d   " 112) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '3 (begin (or 3 4 5))) (format #t "~d   " 113) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '#f (begin (or #f #f #f))) (format #t "~d   " 114) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (> 4 3))) (format #t "~d   " 115) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (> 4 3 2))) (format #t "~d   " 116) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (> 4 3 1 2))) (format #t "~d   " 117) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (>= 3 3 3))) (format #t "~d   " 118) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (>= 4 3 3))) (format #t "~d   " 119) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (>= 4 3))) (format #t "~d   " 120) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (< 1 2))) (format #t "~d   " 121) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (< 1 2 3))) (format #t "~d   " 122) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (< 1 5 3))) (format #t "~d   " 123) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (<= 1 2))) (format #t "~d   " 124) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (<= 1 2 3))) (format #t "~d   " 125) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (<= 1 3 3))) (format #t "~d   " 126) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (<= 1 5 3))) (format #t "~d   " 127) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (eq? #t #t))) (format #t "~d   " 128) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (eq? #t #f))) (format #t "~d   " 129) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (eq? 'a 'a))) (format #t "~d   " 130) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (eq? 'a 'b))) (format #t "~d   " 131) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (pair? (cons 1 2)))) (format #t "~d   " 132) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (pair? 3))) (format #t "~d   " 133) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (symbol? 'a))) (format #t "~d   " 134) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (symbol? 3))) (format #t "~d   " 135) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '3 (begin (cond (#f 1) (#t 3)))) (format #t "~d   " 136) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (cond (#f 1) (#f 2) (else 3)))) (format #t "~d   " 137) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (cond (#t 3) (#f 2) (else 1)))) (format #t "~d   " 138) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '1 (begin (cond ((cons 1 2) => car) (#f 2) (else 3)))) (format #t "~d   " 139) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '3 (begin (apply (lambda (a) a) '(3)))) (format #t "~d   " 140) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '7 (begin (apply (lambda (a b) (+ a b)) '(5 2)))) (format #t "~d   " 141) (begin (newline) (error 'test "\nfailed" '7)))
;; (if (equal? '8 (begin (apply (lambda (a b c) (+ a b c)) '(5 2 1)))) (format #t "~d   " 142) (begin (newline) (error 'test "\nfailed" '8)))
;; (if (equal? '(0 b c) (begin (let ((a 0)) `(,a b c)))) (format #t "~d   " 143) (begin (newline) (error 'test "\nfailed" '(0 b c))))
;; (if (equal? '((1 2 3) b c) (begin (let ((a '(1 2 3))) `(,a b c)))) (format #t "~d   " 144) (begin (newline) (error 'test "\nfailed" '((1 2 3) b c))))
;; (if (equal? '(1 2 3 b c) (begin (let ((a '(1 2 3))) `(,@a b c)))) (format #t "~d   " 145) (begin (newline) (error 'test "\nfailed" '(1 2 3 b c))))
;; (if (equal? '(list a 'a) (begin (let ((name 'a)) `(list ,name ',name)))) (format #t "~d   " 146) (begin (newline) (error 'test "\nfailed" '(list a 'a))))
;; (if (equal? '(list 3 4) (begin `(list ,(+ 1 2) 4))) (format #t "~d   " 147) (begin (newline) (error 'test "\nfailed" '(list 3 4))))
;; (if (equal? '(1 1 2 3) (begin (let ((a '(1 2 3))) `(1 unquote a)))) (format #t "~d   " 148) (begin (newline) (error 'test "\nfailed" '(1 1 2 3))))
;; (if (equal? '(1 2 3) (begin (let ((a '(1 2 3))) `,a))) (format #t "~d   " 149) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '(1 2 3) (begin (let ((a '(1 2 3))) `(,@a)))) (format #t "~d   " 150) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '(0 1 2 3) (begin (let ((a '(1 2 3))) `(0 ,@a)))) (format #t "~d   " 151) (begin (newline) (error 'test "\nfailed" '(0 1 2 3))))
;; (if (equal? '(0 (1 2 3) 4) (begin (let ((a '(1 2 3))) `(0 ,a 4)))) (format #t "~d   " 152) (begin (newline) (error 'test "\nfailed" '(0 (1 2 3) 4))))
;; (if (equal? '(1 2 3 4) (begin (let ((a '(1 2 3))) `(,@a 4)))) (format #t "~d   " 153) (begin (newline) (error 'test "\nfailed" '(1 2 3 4))))
;; (if (equal? '((1 2 3) 4) (begin (let ((a '(1 2 3))) `((,@a) 4)))) (format #t "~d   " 154) (begin (newline) (error 'test "\nfailed" '((1 2 3) 4))))
;; (if (equal? '(((1 2 3)) 4) (begin (let ((a '(1 2 3))) `((,a) 4)))) (format #t "~d   " 155) (begin (newline) (error 'test "\nfailed" '(((1 2 3)) 4))))
;; (if (equal? 'b (begin `b)) (format #t "~d   " 156) (begin (newline) (error 'test "\nfailed" 'b)))
;; (if (equal? '(1 2 3) (begin (list 1 2 3))) (format #t "~d   " 157) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '3 (begin (aif (+ 1 2) it #f))) (format #t "~d   " 158) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (string-length "abc"))) (format #t "~d   " 159) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (string-length "あいう"))) (format #t "~d   " 160) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? 'abc (begin (string->symbol "abc"))) (format #t "~d   " 161) (begin (newline) (error 'test "\nfailed" 'abc)))
;; (if (equal? '"123" (begin (number->string 123))) (format #t "~d   " 162) (begin (newline) (error 'test "\nfailed" '"123")))
;; (if (equal? '(1 2 3 4) (begin (begin (define (proc1 . a) a) (proc1 1 2 3 4)))) (format #t "~d   " 163) (begin (newline) (error 'test "\nfailed" '(1 2 3 4))))
;; (if (equal? '(2 3) (begin ((lambda (a . b) b) 1 2 3))) (format #t "~d   " 164) (begin (newline) (error 'test "\nfailed" '(2 3))))
;; (if (equal? '1 (begin ((lambda (a . b) a) 1 2 3 4 5))) (format #t "~d   " 165) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '(2 3 4 5) (begin ((lambda (a . b) b) 1 2 3 4 5))) (format #t "~d   " 166) (begin (newline) (error 'test "\nfailed" '(2 3 4 5))))
;; (if (equal? '() (begin ((lambda (a b c d . e) e) 1 2 3 4))) (format #t "~d   " 167) (begin (newline) (error 'test "\nfailed" '())))
;; (if (equal? '1 (begin ((lambda (a b c d . e) a) 1 2 3 4))) (format #t "~d   " 168) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '2 (begin ((lambda (a b c d . e) b) 1 2 3 4))) (format #t "~d   " 169) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '3 (begin ((lambda (a b c d . e) c) 1 2 3 4))) (format #t "~d   " 170) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '4 (begin ((lambda (a b c d . e) d) 1 2 3 4))) (format #t "~d   " 171) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '(1 2 3 4) (begin (append '(1 2) '(3 4)))) (format #t "~d   " 172) (begin (newline) (error 'test "\nfailed" '(1 2 3 4))))
;; (if (equal? '3 (begin (begin (define x 3) x))) (format #t "~d   " 173) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '(1 2 3) (begin (begin (define (hoge . a) a) (hoge 1 2 3)))) (format #t "~d   " 174) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '(2 3) (begin (begin (define (hige a . b) b) (hige 1 2 3)))) (format #t "~d   " 175) (begin (newline) (error 'test "\nfailed" '(2 3))))
;; (if (equal? '(3 2) (begin (apply (lambda a a) '(3 2)))) (format #t "~d   " 176) (begin (newline) (error 'test "\nfailed" '(3 2))))
;; (if (equal? '#t (begin (equal? '(1 2 (3)) '(1 2 (3))))) (format #t "~d   " 177) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '1 (begin (let ((a 3)) 3 2 1))) (format #t "~d   " 178) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '"   " (begin (make-string 3))) (format #t "~d   " 179) (begin (newline) (error 'test "\nfailed" '"   ")))
;; (if (equal? '"ccc" (begin (make-string 3 #\c))) (format #t "~d   " 180) (begin (newline) (error 'test "\nfailed" '"ccc")))
;; (if (equal? '3 (begin (apply car '((3))))) (format #t "~d   " 181) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (apply (lambda (a) (car a)) '((3))))) (format #t "~d   " 182) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (apply (lambda (a . b) (+ a (car b))) '(1 2)))) (format #t "~d   " 183) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '"123456" (begin (string-append "12" "345" "6"))) (format #t "~d   " 184) (begin (newline) (error 'test "\nfailed" '"123456")))
;; (if (equal? '3 (begin (find (lambda (e) (= e 3)) (list 1 2 3)))) (format #t "~d   " 185) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '#t (begin (string? "hige"))) (format #t "~d   " 186) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '("key" "value") (begin (assoc "key" '(("key" "value"))))) (format #t "~d   " 187) (begin (newline) (error 'test "\nfailed" '("key" "value"))))
;; (if (equal? '("12" "34" "56") (begin (string-split "12\n34\n56" #\newline))) (format #t "~d   " 188) (begin (newline) (error 'test "\nfailed" '("12" "34" "56"))))
;; (if (equal? '#\2 (begin (let ((p (open-string-input-port "12345"))) (read-char p) (read-char p)))) (format #t "~d   " 189) (begin (newline) (error 'test "\nfailed" '#\2)))
;; (if (equal? '#t (begin (eof-object? (let ((p (open-string-input-port "1"))) (read-char p) (read-char p))))) (format #t "~d   " 190) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '123 (begin (let ((p (open-string-input-port "123 456"))) (read p)))) (format #t "~d   " 191) (begin (newline) (error 'test "\nfailed" '123)))
;; (if (equal? '#f (begin (rxmatch #/123/ "12"))) (format #t "~d   " 192) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (if (rxmatch #/123/ "123") #t #f))) (format #t "~d   " 193) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (regexp? #/abc/))) (format #t "~d   " 194) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (regexp? "abc"))) (format #t "~d   " 195) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '1 (begin (rxmatch-start (rxmatch #/\d+/ "a345a")))) (format #t "~d   " 196) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '2 (begin (rxmatch-start (rxmatch #/\d+/ "ab345a")))) (format #t "~d   " 197) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '3 (begin (rxmatch-start (rxmatch #/\d+/ "abあ345a")))) (format #t "~d   " 198) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '1 (begin (rxmatch-start (rxmatch #/(\d+)(a)/ "a345a") 1))) (format #t "~d   " 199) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '4 (begin (rxmatch-start (rxmatch #/(\d+)(a)/ "a345a") 2))) (format #t "~d   " 200) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '4 (begin (rxmatch-end (rxmatch #/\d+/ "a345a")))) (format #t "~d   " 201) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '4 (begin (rxmatch-end (rxmatch #/(\d+)(a)/ "a345a") 1))) (format #t "~d   " 202) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '5 (begin (rxmatch-end (rxmatch #/(\d+)(a)/ "a345a") 2))) (format #t "~d   " 203) (begin (newline) (error 'test "\nfailed" '5)))
;; (if (equal? '#f (begin (rxmatch-end (rxmatch #/\d+/ "aaaa")))) (format #t "~d   " 204) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (#/123/ "12"))) (format #t "~d   " 205) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '1 (begin (rxmatch-start (#/\d+/ "a345a")))) (format #t "~d   " 206) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '2 (begin (rxmatch-start (#/\d+/ "ab345a")))) (format #t "~d   " 207) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '3 (begin (rxmatch-start (#/\d+/ "abあ345a")))) (format #t "~d   " 208) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '1 (begin (rxmatch-start (#/(\d+)(a)/ "a345a") 1))) (format #t "~d   " 209) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '4 (begin (rxmatch-start (#/(\d+)(a)/ "a345a") 2))) (format #t "~d   " 210) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '"def" (begin (rxmatch-after (#/abc/ "123abcdef")))) (format #t "~d   " 211) (begin (newline) (error 'test "\nfailed" '"def")))
;; (if (equal? '"あいうえ" (begin (rxmatch-after (#/abc/ "123abcあいうえ")))) (format #t "~d   " 212) (begin (newline) (error 'test "\nfailed" '"あいうえ")))
;; (if (equal? '"あいうえ" (begin (rxmatch-after (#/かきく/ "123かきくあいうえ")))) (format #t "~d   " 213) (begin (newline) (error 'test "\nfailed" '"あいうえ")))
;; (if (equal? '"123" (begin (rxmatch-before (#/abc/ "123abcdef")))) (format #t "~d   " 214) (begin (newline) (error 'test "\nfailed" '"123")))
;; (if (equal? '"abc" (begin ((#/abc/ "123abcdef") 0))) (format #t "~d   " 215) (begin (newline) (error 'test "\nfailed" '"abc")))
;; (if (equal? '"abc" (begin ((#/abc/ "123abcdef")))) (format #t "~d   " 216) (begin (newline) (error 'test "\nfailed" '"abc")))
;; (if (equal? '"def" (begin ((#/abc/ "123abcdef") 'after))) (format #t "~d   " 217) (begin (newline) (error 'test "\nfailed" '"def")))
;; (if (equal? '"123" (begin ((#/abc/ "123abcdef") 'before))) (format #t "~d   " 218) (begin (newline) (error 'test "\nfailed" '"123")))
;; (if (equal? '#f (begin (rxmatch #/123/ "12"))) (format #t "~d   " 219) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (#/123/ "12"))) (format #t "~d   " 220) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (if (#/^abc/ "abc") #t #f))) (format #t "~d   " 221) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '"abc" (begin (regexp->string #/abc/))) (format #t "~d   " 222) (begin (newline) (error 'test "\nfailed" '"abc")))
;; (if (equal? '#f (begin (rxmatch-start (#/\d+/ "aaaa")))) (format #t "~d   " 223) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '4 (begin (rxmatch-end (#/\d+/ "a345a")))) (format #t "~d   " 224) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '4 (begin (rxmatch-end (#/(\d+)(a)/ "a345a") 1))) (format #t "~d   " 225) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '5 (begin (rxmatch-end (#/(\d+)(a)/ "a345a") 2))) (format #t "~d   " 226) (begin (newline) (error 'test "\nfailed" '5)))
;; (if (equal? '#f (begin (rxmatch-end (#/\d+/ "aaaa")))) (format #t "~d   " 227) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (rxmatch #/123/ "12"))) (format #t "~d   " 228) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (if (rxmatch #/123/ "123") #t #f))) (format #t "~d   " 229) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (#/123/ "12"))) (format #t "~d   " 230) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (if (#/^abc/ "abc") #t #f))) (format #t "~d   " 231) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (regexp? #/abc/))) (format #t "~d   " 232) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (regexp? "abc"))) (format #t "~d   " 233) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '"abc" (begin (regexp->string #/abc/))) (format #t "~d   " 234) (begin (newline) (error 'test "\nfailed" '"abc")))
;; (if (equal? '1 (begin (rxmatch-start (#/\d+/ "a345a")))) (format #t "~d   " 235) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '"345" (begin (rxmatch-substring (#/\d+/ "a345a")))) (format #t "~d   " 236) (begin (newline) (error 'test "\nfailed" '"345")))
;; (if (equal? '"345" (begin (rxmatch-substring (#/(\d+)(a)/ "a345a") 1))) (format #t "~d   " 237) (begin (newline) (error 'test "\nfailed" '"345")))
;; (if (equal? '"a" (begin (rxmatch-substring (#/(\d+)(a)/ "a345a") 2))) (format #t "~d   " 238) (begin (newline) (error 'test "\nfailed" '"a")))
;; (if (equal? '#f (begin (rxmatch-substring (#/\d+/ "aaaa")))) (format #t "~d   " 239) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '"あ" (begin ((#/あ/ "あ")))) (format #t "~d   " 240) (begin (newline) (error 'test "\nfailed" '"あ")))
;; (if (equal? '#/abc/ (begin (string->regexp "abc"))) (format #t "~d   " 241) (begin (newline) (error 'test "\nfailed" '#/abc/)))
;; (if (equal? '#f (begin (let1 m (#/^#([^(^)^\s]+)(?:\(([^\)]+)\))?/ "#comment") (m 2)))) (format #t "~d   " 242) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? 'a (begin (begin (let ((xxx 'a)) (case xxx ((b) 'b) ((a) 'a)))))) (format #t "~d   " 243) (begin (newline) (error 'test "\nfailed" 'a)))
;; (if (equal? '3 (begin (begin (let ((xxy 'a)) (case xxy ((b) 'b) ((c) 'c) (else 3)))))) (format #t "~d   " 244) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '-1 (begin ((lambda (a) (call/cc (lambda (c) (c -1) 4))) 2))) (format #t "~d   " 245) (begin (newline) (error 'test "\nfailed" '-1)))
;; (if (equal? '6 (begin (* 2 3))) (format #t "~d   " 246) (begin (newline) (error 'test "\nfailed" '6)))
;; (if (equal? '24 (begin (* 2 3 4))) (format #t "~d   " 247) (begin (newline) (error 'test "\nfailed" '24)))
;; (if (equal? '4 (begin (call/cc (lambda (c) (c 4))))) (format #t "~d   " 248) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '123 (begin (string->number "123"))) (format #t "~d   " 249) (begin (newline) (error 'test "\nfailed" '123)))
;; (if (equal? '123 (begin (let ((p (open-string-input-port "123 456"))) (read p)))) (format #t "~d   " 250) (begin (newline) (error 'test "\nfailed" '123)))
;; (if (equal? '#\1 (begin (let ((p (open-string-input-port "123 456"))) (read-char p)))) (format #t "~d   " 251) (begin (newline) (error 'test "\nfailed" '#\1)))
;; (if (equal? '(4 3 2 1) (begin (reverse '(1 2 3 4)))) (format #t "~d   " 252) (begin (newline) (error 'test "\nfailed" '(4 3 2 1))))
;; (if (equal? '("wiki" "cmd") (begin (string-split "wiki&cmd" #\&))) (format #t "~d   " 253) (begin (newline) (error 'test "\nfailed" '("wiki" "cmd"))))
;; (if (equal? '"cbc" (begin (begin (define str1 (make-string 3 #\c)) (string-set! str1 1 #\b) str1))) (format #t "~d   " 254) (begin (newline) (error 'test "\nfailed" '"cbc")))
;; (if (equal? '-1 (begin ((lambda (a) (call/cc (lambda (c) (c -1)))) 2))) (format #t "~d   " 255) (begin (newline) (error 'test "\nfailed" '-1)))
;; (if (equal? '2 (begin (let* ((a 0) (b (lambda (x y) a))) (b (begin (set! a 1)) (begin (set! a 2)))))) (format #t "~d   " 256) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '#\a (begin #\a)) (format #t "~d   " 257) (begin (newline) (error 'test "\nfailed" '#\a)))
;; (if (equal? '#f (begin (eof-object? 3))) (format #t "~d   " 258) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '101 (begin 101)) (format #t "~d   " 259) (begin (newline) (error 'test "\nfailed" '101)))
;; (if (equal? '4 (begin (define val 3) (define (func8) (define val 4) val) (func8))) (format #t "~d   " 260) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '(1 . 3) (begin ((lambda () (define p (cons 1 2)) (set-cdr! p 3) p)))) (format #t "~d   " 261) (begin (newline) (error 'test "\nfailed" '(1 . 3))))
;; (if (equal? '(3 . 2) (begin ((lambda () (define q (cons 1 2)) (set-car! q 3) q)))) (format #t "~d   " 262) (begin (newline) (error 'test "\nfailed" '(3 . 2))))
;; (if (equal? '#t (begin (begin (display "test done") #t))) (format #t "~d   " 263) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '3 (begin (vector-length (make-vector 3)))) (format #t "~d   " 264) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '101 (begin (let loop ((i 0)) (if (= i 100) (+ i 1) (loop (+ i 1)))))) (format #t "~d   " 265) (begin (newline) (error 'test "\nfailed" '101)))
;; (if (equal? '3 (begin ((lambda (cont) (if (call/cc (lambda (c) (set! cont c))) (cont #f) 3)) '()))) (format #t "~d   " 266) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '102 (begin ((lambda (cont) (if (call/cc (lambda (c) (set! cont c))) ((lambda () ((lambda () (cont #f))))) 102)) '()))) (format #t "~d   " 267) (begin (newline) (error 'test "\nfailed" '102)))
;; (if (equal? '2 (begin (let ((a 0)) (cond (#t (set! a (+ a 1)) (set! a (+ a 1)) a))))) (format #t "~d   " 268) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '#t (begin (char? #\あ))) (format #t "~d   " 269) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (eq? (list 'a) (list 'a)))) (format #t "~d   " 270) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (let ((x (list 'a))) (eq? x x)))) (format #t "~d   " 271) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '("ABC123" "DEF123") (begin (map1 (lambda (s) (string-append s "123")) '("ABC" "DEF")))) (format #t "~d   " 272) (begin (newline) (error 'test "\nfailed" '("ABC123" "DEF123"))))
;; (if (equal? '("ABC123" "DEF123") (begin (map (lambda (s) (string-append s "123")) '("ABC" "DEF")))) (format #t "~d   " 273) (begin (newline) (error 'test "\nfailed" '("ABC123" "DEF123"))))
;; (if (equal? '("ABCGHI" "DEFJKL") (begin (map (lambda (a b) (string-append a b)) '("ABC" "DEF") '("GHI" "JKL")))) (format #t "~d   " 274) (begin (newline) (error 'test "\nfailed" '("ABCGHI" "DEFJKL"))))
;; (if (equal? '(4 10 18) (begin (map (lambda (a b) (* a b)) '(1 2 3) '(4 5 6)))) (format #t "~d   " 275) (begin (newline) (error 'test "\nfailed" '(4 10 18))))
;; (if (equal? '10000 (begin (let1 a '() (let1 G68 (lambda (i) (if (>= i 10000) i (a (+ i 1)))) (set! a G68) (a 0))))) (format #t "~d   " 276) (begin (newline) (error 'test "\nfailed" '10000)))
;; (if (equal? '(list 3 4) (begin `(list ,(+ 1 2) 4))) (format #t "~d   " 277) (begin (newline) (error 'test "\nfailed" '(list 3 4))))
;; (if (equal? '(list a 'a) (begin (let ((name 'a)) `(list ,name ',name)))) (format #t "~d   " 278) (begin (newline) (error 'test "\nfailed" '(list a 'a))))
;; (if (equal? '(a 3 4 5 6 b) (begin `(a ,(+ 1 2) ,@(map abs '(4 -5 6)) b))) (format #t "~d   " 279) (begin (newline) (error 'test "\nfailed" '(a 3 4 5 6 b))))
;; (if (equal? '#t (begin (vector? #(3)))) (format #t "~d   " 280) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '3 (begin (begin (define (proc-01) 3) (proc-01)))) (format #t "~d   " 281) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (begin (define (add3 a b) (+ a b)) (add3 1 2)))) (format #t "~d   " 282) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (begin (define add2 (lambda (a b) (+ a b))) (add2 1 2)))) (format #t "~d   " 283) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (begin (define z (make-vector 2)) (vector-set! z 0 1) (vector-set! z 1 2) (make-vector 3) (null? 3) (vector-set! z 1 3) (vector-ref z 1)))) (format #t "~d   " 284) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '3 (begin (begin (define (proc-2) (define (rec) 3) (rec)) (proc-2)))) (format #t "~d   " 285) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '4 (begin (begin (define (func2) (define val 4) val) (func2)))) (format #t "~d   " 286) (begin (newline) (error 'test "\nfailed" '4)))
;; (if (equal? '#t (begin (if (values 1 2 3) #t #f))) (format #t "~d   " 287) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '5 (begin (call-with-values (lambda () (values 4 5)) (lambda (a b) b)))) (format #t "~d   " 288) (begin (newline) (error 'test "\nfailed" '5)))
;; (if (equal? '6 (begin (call-with-values (lambda () (values 1 2 3)) (lambda (a b c) (+ a b c))))) (format #t "~d   " 289) (begin (newline) (error 'test "\nfailed" '6)))
;; (if (equal? '(1 2 3) (begin (call-with-values (lambda () (values 1 2 3)) list))) (format #t "~d   " 290) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '1235 (begin (call-with-values (lambda () 1) (lambda (x) (+ x 1234))))) (format #t "~d   " 291) (begin (newline) (error 'test "\nfailed" '1235)))
;; (let1 val (begin (receive (a b c) (values 1 2 3) (+ a b c))) (if (equal? '6 val) (format #t "~d   " 292) (error 'test "failed" '6 val)))
;; (let1 val (begin (receive z (values 'x 'y) z)) (if (equal? '(x y) val) (format #t "~d   " 293) (error 'test "failed" '(x y) val)))
;; (let1 val (begin (receive (a . b) (values 'x 'y 'z) b)) (if (equal? '(y z) val) (format #t "~d   " 294) (error 'test "failed" '(y z) val)))
;; (let1 val (begin (receive (a . b) (values 'x 'y 'z) a)) (if (equal? 'x val) (format #t "~d   " 295) (error 'test "failed" 'x val)))
;; (let1 val (begin (receive x (apply values '(1 2 3)) x)) (if (equal? '(1 2 3) val) (format #t "~d   " 296) (error 'test "failed" '(1 2 3) val)))
;; (let1 val (begin (call-with-values (lambda () (values 1 2)) cons)) (if (equal? '(1 . 2) val) (format #t "~d   " 297) (error 'test "failed" '(1 . 2) val)))
;; (let1 val (begin (receive (port proc) (open-string-output-port) (display "hige" port) (display "pon" port) (proc))) (if (equal? '"higepon" val) (format #t "~d   " 298) (error 'test "failed" '"higepon" val)))
;; (if (equal? '"\"string\"" (begin (call-with-string-output-port (lambda (port) (write "string" port))))) (format #t "~d   " 299) (begin (newline) (error 'test "\nfailed" '"\"string\"")))
;; (if (equal? '"123ABC456" (begin (regexp-replace #/abc/ "123abc456" "ABC"))) (format #t "~d   " 300) (begin (newline) (error 'test "\nfailed" '"123ABC456")))
;; (if (equal? '(a) (begin (cons 'a '()))) (format #t "~d   " 301) (begin (newline) (error 'test "\nfailed" '(a))))
;; (if (equal? '((a) b c d) (begin (cons '(a) '(b c d)))) (format #t "~d   " 302) (begin (newline) (error 'test "\nfailed" '((a) b c d))))
;; (if (equal? '("a" b c) (begin (cons "a" '(b c)))) (format #t "~d   " 303) (begin (newline) (error 'test "\nfailed" '("a" b c))))
;; (if (equal? '(a . 3) (begin (cons 'a 3))) (format #t "~d   " 304) (begin (newline) (error 'test "\nfailed" '(a . 3))))
;; (if (equal? '((a b) . c) (begin (cons '(a b) 'c))) (format #t "~d   " 305) (begin (newline) (error 'test "\nfailed" '((a b) . c))))
;; (if (equal? 'a (begin (car '(a b c)))) (format #t "~d   " 306) (begin (newline) (error 'test "\nfailed" 'a)))
;; (if (equal? '(a) (begin (car '((a) b c d)))) (format #t "~d   " 307) (begin (newline) (error 'test "\nfailed" '(a))))
;; (if (equal? '1 (begin (car '(1 . 2)))) (format #t "~d   " 308) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '(b c d) (begin (cdr '((a) b c d)))) (format #t "~d   " 309) (begin (newline) (error 'test "\nfailed" '(b c d))))
;; (if (equal? '2 (begin (cdr '(1 . 2)))) (format #t "~d   " 310) (begin (newline) (error 'test "\nfailed" '2)))
;; (if (equal? '(c b a) (begin (reverse '(a b c)))) (format #t "~d   " 311) (begin (newline) (error 'test "\nfailed" '(c b a))))
;; (if (equal? '((e (f)) d (b c) a) (begin (reverse '(a (b c) d (e (f)))))) (format #t "~d   " 312) (begin (newline) (error 'test "\nfailed" '((e (f)) d (b c) a))))
;; (if (equal? '#t (begin (equal? 'a 'a))) (format #t "~d   " 313) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (equal? '(a) '(a)))) (format #t "~d   " 314) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (equal? '(a (b) c) '(a (b) c)))) (format #t "~d   " 315) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (equal? "abc" "abc"))) (format #t "~d   " 316) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (equal? 2 2))) (format #t "~d   " 317) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (equal? (make-vector 5 'a) (make-vector 5 'a)))) (format #t "~d   " 318) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (eq? 'a 'a))) (format #t "~d   " 319) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (eq? '(a) '(a)))) (format #t "~d   " 320) (begin (newline) (error 'test "\nfailed" '#f)))
;; (let1 val (begin (eq? (list 'a) (list 'a))) (if (equal? '#f val) (format #t "~d   " 321) (error 'test "failed" '#f val)))
;; (if (equal? '#f (begin (eq? "a" "a"))) (format #t "~d   " 322) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (eq? "" ""))) (format #t "~d   " 323) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (eq? '() '()))) (format #t "~d   " 324) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (eq? 2 2))) (format #t "~d   " 325) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (eq? #\A #\A))) (format #t "~d   " 326) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (eq? car car))) (format #t "~d   " 327) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (let ((n (+ 2 3))) (eq? n n)))) (format #t "~d   " 328) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (let ((x '(a))) (eq? x x)))) (format #t "~d   " 329) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (let ((x '#())) (eq? x x)))) (format #t "~d   " 330) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (let ((p (lambda (x) x))) (eq? p p)))) (format #t "~d   " 331) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '-1 (begin (- 3 4))) (format #t "~d   " 332) (begin (newline) (error 'test "\nfailed" '-1)))
;; (if (equal? '-6 (begin (- 3 4 5))) (format #t "~d   " 333) (begin (newline) (error 'test "\nfailed" '-6)))
;; (if (equal? '-3 (begin (- 3))) (format #t "~d   " 334) (begin (newline) (error 'test "\nfailed" '-3)))
;; (if (equal? 'greater (begin (cond ((> 3 2) 'greater) ((< 3 2) 'less)))) (format #t "~d   " 335) (begin (newline) (error 'test "\nfailed" 'greater)))
;; (if (equal? 'equal (begin (cond ((> 3 3) 'greater) ((< 3 3) 'less) (else 'equal)))) (format #t "~d   " 336) (begin (newline) (error 'test "\nfailed" 'equal)))
;; (if (equal? '2 (begin (cond ('(1 2 3) => cadr) (else #f)))) (format #t "~d   " 337) (begin (newline) (error 'test "\nfailed" '2)))
;; (let1 val (begin (do ((vec (make-vector 5)) (i 0 (+ i 1))) ((= i 5) vec) (vector-set! vec i i))) (if (equal? '#(0 1 2 3 4) val) (format #t "~d   " 338) (error 'test "failed" '#(0 1 2 3 4) val)))
;; (let1 val (begin (let ((x '(1 3 5 7 9))) (do ((x x (cdr x)) (sum 0 (+ sum (car x)))) ((null? x) sum)))) (if (equal? '25 val) (format #t "~d   " 339) (error 'test "failed" '25 val)))
;; (if (equal? '#(0 ("Sue" "Sue") "Anna") (begin (let ((vec (vector 0 '(2 2 2 2) "Anna"))) (vector-set! vec 1 '("Sue" "Sue")) vec))) (format #t "~d   " 340) (begin (newline) (error 'test "\nfailed" '#(0 ("Sue" "Sue") "Anna"))))
;; (if (equal? '8 (begin (vector-ref '#(1 1 2 3 5 8 13 21) 5))) (format #t "~d   " 341) (begin (newline) (error 'test "\nfailed" '8)))
;; (if (equal? '#t (begin (or (= 2 2) (> 2 1)))) (format #t "~d   " 342) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (or (= 2 2) (< 2 1)))) (format #t "~d   " 343) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (or #f #f #f))) (format #t "~d   " 344) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '(b c) (begin (or '(b c) (/ 3 0)))) (format #t "~d   " 345) (begin (newline) (error 'test "\nfailed" '(b c))))
;; (if (equal? '#f (begin (not #t))) (format #t "~d   " 346) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (not 3))) (format #t "~d   " 347) (begin (newline) (error 'test "\nfailed" '#f)))
;; (let1 val (begin (not (list 3))) (if (equal? '#f val) (format #t "~d   " 348) (error 'test "failed" '#f val)))
;; (if (equal? '#t (begin (not #f))) (format #t "~d   " 349) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (not '()))) (format #t "~d   " 350) (begin (newline) (error 'test "\nfailed" '#f)))
;; (let1 val (begin (not (list))) (if (equal? '#f val) (format #t "~d   " 351) (error 'test "failed" '#f val)))
;; (if (equal? '#f (begin (not 'nil))) (format #t "~d   " 352) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '6 (begin (let ((x 2) (y 3)) (* x y)))) (format #t "~d   " 353) (begin (newline) (error 'test "\nfailed" '6)))
;; (if (equal? '35 (begin (let ((x 2) (y 3)) (let ((x 7) (z (+ x y))) (* z x))))) (format #t "~d   " 354) (begin (newline) (error 'test "\nfailed" '35)))
;; (if (equal? '70 (begin (let ((x 2) (y 3)) (let* ((x 7) (z (+ x y))) (* z x))))) (format #t "~d   " 355) (begin (newline) (error 'test "\nfailed" '70)))
;; (if (equal? '#t (begin (eqv? 'a 'a))) (format #t "~d   " 356) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (eqv? 'a 'b))) (format #t "~d   " 357) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (eqv? 2 2))) (format #t "~d   " 358) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (eqv? '() '()))) (format #t "~d   " 359) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (eqv? 100000000 100000000))) (format #t "~d   " 360) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (eqv? (cons 1 2) (cons 1 2)))) (format #t "~d   " 361) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (eqv? (lambda () 1) (lambda () 2)))) (format #t "~d   " 362) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (eqv? #f 'nil))) (format #t "~d   " 363) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (define (foo n) (let loop ((n n)) (cond ((null? n)) (else (loop (cdr n)))))) (and (foo '()) (foo '(1 2 3))))) (format #t "~d   " 364) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '3 (begin (digit->integer #\3 10))) (format #t "~d   " 365) (begin (newline) (error 'test "\nfailed" '3)))
;; (if (equal? '0 (begin (+))) (format #t "~d   " 366) (begin (newline) (error 'test "\nfailed" '0)))
;; (if (equal? '1 (begin (*))) (format #t "~d   " 367) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '6 (begin (apply (lambda (a b c) (+ a b c)) 1 2 '(3)))) (format #t "~d   " 368) (begin (newline) (error 'test "\nfailed" '6)))
;; (if (equal? '6 (begin (apply (lambda (a b c) (+ a b c)) '(1 2 3)))) (format #t "~d   " 369) (begin (newline) (error 'test "\nfailed" '6)))
;; (if (equal? '6 (begin (apply (lambda (a b c) (+ a b c)) 1 '(2 3)))) (format #t "~d   " 370) (begin (newline) (error 'test "\nfailed" '6)))
;; (if (equal? '(2) (begin (apply (lambda (x y) (apply y '((3 2)))) `(,car ,cdr)))) (format #t "~d   " 371) (begin (newline) (error 'test "\nfailed" '(2))))
;; (if (equal? '3 (begin (/ 6 2))) (format #t "~d   " 372) (begin (newline) (error 'test "\nfailed" '3)))
;; (let1 val (begin (mod 23 10)) (if (equal? '3 val) (format #t "~d   " 373) (error 'test "failed" '3 val)))
;; (let1 val (begin (even? 2)) (if (equal? '#t val) (format #t "~d   " 374) (error 'test "failed" '#t val)))
;; (let1 val (begin (even? 3)) (if (equal? '#f val) (format #t "~d   " 375) (error 'test "failed" '#f val)))
;; (let1 val (begin (for-all even? '(3 1 4 1 5 9))) (if (equal? '#f val) (format #t "~d   " 376) (error 'test "failed" '#f val)))
;; (let1 val (begin (for-all even? '(3 1 4 1 5 9 . 2))) (if (equal? '#f val) (format #t "~d   " 377) (error 'test "failed" '#f val)))
;; (let1 val (begin (for-all even? '(2 4 14))) (if (equal? '#t val) (format #t "~d   " 378) (error 'test "failed" '#t val)))
;; (let1 val (begin (for-all (lambda (a b) (< a b)) '(1 2 3) '(2 3 4))) (if (equal? '#t val) (format #t "~d   " 379) (error 'test "failed" '#t val)))
;; (let1 val (begin (for-all (lambda (a b) (< a b)) '(1 2 4) '(2 3 4))) (if (equal? '#f val) (format #t "~d   " 380) (error 'test "failed" '#f val)))
;; (let1 val (begin (+ (/ 2) (/ 4) (/ 4))) (if (equal? '1 val) (format #t "~d   " 381) (error 'test "failed" '1 val)))
;; (let1 val (begin (- (/ 1 2) (/ 1 4) (/ 1 4))) (if (equal? '0 val) (format #t "~d   " 382) (error 'test "failed" '0 val)))
;; (let1 val (begin (= (/ 3 2) (+ (/ 1 2) 1))) (if (equal? '#t val) (format #t "~d   " 383) (error 'test "failed" '#t val)))
;; (let1 val (begin (= (/ 5 2) (+ 1 (/ 1 2) 1))) (if (equal? '#t val) (format #t "~d   " 384) (error 'test "failed" '#t val)))
;; (let1 val (begin (= (/ 3 2) (- 3 (/ 1 2) 1))) (if (equal? '#t val) (format #t "~d   " 385) (error 'test "failed" '#t val)))
;; (let1 val (begin (* (/ 3 2) 2)) (if (equal? '3 val) (format #t "~d   " 386) (error 'test "failed" '3 val)))
;; (let1 val (begin (* 2 (/ 3 2))) (if (equal? '3 val) (format #t "~d   " 387) (error 'test "failed" '3 val)))
;; (let1 val (begin (* (/ 4 2) (/ 3 2))) (if (equal? '3 val) (format #t "~d   " 388) (error 'test "failed" '3 val)))
;; (let1 val (begin (/ (/ 2 2) (/ 1 2))) (if (equal? '2 val) (format #t "~d   " 389) (error 'test "failed" '2 val)))
;; (let1 val (begin (/ (/ 4 2) 1)) (if (equal? '2 val) (format #t "~d   " 390) (error 'test "failed" '2 val)))
;; (if (equal? 'error (guard (con (#t 'error)) (/ 1 0))) (format #t "~d   " 391) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (/ 1 (* 0 (/ 1 2))))) (format #t "~d   " 392) (error 'test "failed"))(let1 val (begin (> 1 (/ 1 2))) (if (equal? '#t val) (format #t "~d   " 393) (error 'test "failed" '#t val)))
;; (let1 val (begin (> (/ 1 2) 1)) (if (equal? '#f val) (format #t "~d   " 394) (error 'test "failed" '#f val)))
;; (let1 val (begin (> 1 (/ 1 2))) (if (equal? '#t val) (format #t "~d   " 395) (error 'test "failed" '#t val)))
;; (let1 val (begin (> (/ 1 2) (/ 1 3))) (if (equal? '#t val) (format #t "~d   " 396) (error 'test "failed" '#t val)))
;; (let1 val (begin (<= (/ 1 2) 1)) (if (equal? '#t val) (format #t "~d   " 397) (error 'test "failed" '#t val)))
;; (let1 val (begin (>= 1 (/ 1 2))) (if (equal? '#t val) (format #t "~d   " 398) (error 'test "failed" '#t val)))
;; (let1 val (begin (>= (/ 1 2) (/ 1 3))) (if (equal? '#t val) (format #t "~d   " 399) (error 'test "failed" '#t val)))
;; (let1 val (begin (< (/ 1 2) 1)) (if (equal? '#t val) (format #t "~d   " 400) (error 'test "failed" '#t val)))
;; (let1 val (begin (< 1 (/ 1 2))) (if (equal? '#f val) (format #t "~d   " 401) (error 'test "failed" '#f val)))
;; (let1 val (begin (< (/ 1 2) (/ 1 3))) (if (equal? '#f val) (format #t "~d   " 402) (error 'test "failed" '#f val)))
;; (let1 val (begin (<= (/ 1 2) 1)) (if (equal? '#t val) (format #t "~d   " 403) (error 'test "failed" '#t val)))
;; (let1 val (begin (<= 1 (/ 1 2))) (if (equal? '#f val) (format #t "~d   " 404) (error 'test "failed" '#f val)))
;; (let1 val (begin (<= (/ 1 2) (/ 1 3))) (if (equal? '#f val) (format #t "~d   " 405) (error 'test "failed" '#f val)))
;; (let1 val (begin (= (/ 2 2) 1)) (if (equal? '#t val) (format #t "~d   " 406) (error 'test "failed" '#t val)))
;; (let1 val (begin (= 1 (/ 2 2))) (if (equal? '#t val) (format #t "~d   " 407) (error 'test "failed" '#t val)))
;; (let1 val (begin (= (/ 1 2) (/ 2 4))) (if (equal? '#t val) (format #t "~d   " 408) (error 'test "failed" '#t val)))
;; (let1 val (begin (>= (/ 1 2) (inexact (/ 1 3)))) (if (equal? '#t val) (format #t "~d   " 409) (error 'test "failed" '#t val)))
;; (let1 val (begin (> (/ 3 2) (+ (inexact (/ 1 3)) (inexact (/ 1 3)) (inexact (/ 1 3))) (/ 99 100))) (if (equal? '#t val) (format #t "~d   " 410) (error 'test "failed" '#t val)))
;; (let1 val (begin (> 1 (/ (inexact 98) 100) (/ 97 100))) (if (equal? '#t val) (format #t "~d   " 411) (error 'test "failed" '#t val)))
;; (let1 val (begin (rational? 3)) (if (equal? '#t val) (format #t "~d   " 412) (error 'test "failed" '#t val)))
;; (let1 val (begin (rational? (/ 1 4))) (if (equal? '#t val) (format #t "~d   " 413) (error 'test "failed" '#t val)))
;; (let1 val (begin (rational? (/ (/ 1 2) (+ (greatest-fixnum) 1)))) (if (equal? '#t val) (format #t "~d   " 414) (error 'test "failed" '#t val)))
;; (let1 val (begin (flonum? (/ (inexact (/ 1 3)) (+ (greatest-fixnum) 1)))) (if (equal? '#t val) (format #t "~d   " 415) (error 'test "failed" '#t val)))
;; (let1 val (begin (= (/ (+ (greatest-fixnum) 1) 1) (+ (greatest-fixnum) 1))) (if (equal? '#t val) (format #t "~d   " 416) (error 'test "failed" '#t val)))
;; (let1 val (begin (rational? (/ (+ (greatest-fixnum) 1) (/ 1 3)))) (if (equal? '#t val) (format #t "~d   " 417) (error 'test "failed" '#t val)))
;; (let1 val (begin (flonum? (/ (+ (greatest-fixnum) 1) (inexact (/ 1 3))))) (if (equal? '#t val) (format #t "~d   " 418) (error 'test "failed" '#t val)))
;; (let1 val (begin (/ (+ (greatest-fixnum) 1) (+ (greatest-fixnum) 1))) (if (equal? '1 val) (format #t "~d   " 419) (error 'test "failed" '1 val)))
;; (let1 val (begin (fixnum? (/ (+ (greatest-fixnum) 1) (+ (greatest-fixnum) 1)))) (if (equal? '#t val) (format #t "~d   " 420) (error 'test "failed" '#t val)))
;; (if (equal? '#t (begin (fixnum? (least-fixnum)))) (format #t "~d   " 421) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (fixnum? (greatest-fixnum)))) (format #t "~d   " 422) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (fixnum? (+ (greatest-fixnum) 1)))) (format #t "~d   " 423) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (fixnum? (- (least-fixnum) 1)))) (format #t "~d   " 424) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (number? (+ (greatest-fixnum) 1)))) (format #t "~d   " 425) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (number? (- (least-fixnum) 1)))) (format #t "~d   " 426) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (> (+ (greatest-fixnum) 1) (greatest-fixnum)))) (format #t "~d   " 427) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (< (- (least-fixnum) 1) (least-fixnum)))) (format #t "~d   " 428) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (fixnum? (- (+ (greatest-fixnum) 1) 1)))) (format #t "~d   " 429) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (fixnum? (+ (- (least-fixnum) 1) 1)))) (format #t "~d   " 430) (begin (newline) (error 'test "\nfailed" '#t)))
;; (let1 val (begin (number? 3)) (if (equal? '#t val) (format #t "~d   " 431) (error 'test "failed" '#t val)))
;; (let1 val (begin (number? (/ 1 4))) (if (equal? '#t val) (format #t "~d   " 432) (error 'test "failed" '#t val)))
;; (let1 val (begin (mod 123 10)) (if (equal? '3 val) (format #t "~d   " 433) (error 'test "failed" '3 val)))
;; (let1 val (begin (mod 123 -10)) (if (equal? '3 val) (format #t "~d   " 434) (error 'test "failed" '3 val)))
;; (let1 val (begin (mod -123 10)) (if (equal? '7 val) (format #t "~d   " 435) (error 'test "failed" '7 val)))
;; (let1 val (begin (mod -123 -10)) (if (equal? '7 val) (format #t "~d   " 436) (error 'test "failed" '7 val)))
;; (let1 val (begin (div 123 10)) (if (equal? '12 val) (format #t "~d   " 437) (error 'test "failed" '12 val)))
;; (let1 val (begin (div 123 -10)) (if (equal? '-12 val) (format #t "~d   " 438) (error 'test "failed" '-12 val)))
;; (let1 val (begin (div -123 10)) (if (equal? '-13 val) (format #t "~d   " 439) (error 'test "failed" '-13 val)))
;; (let1 val (begin (div -123 -10)) (if (equal? '13 val) (format #t "~d   " 440) (error 'test "failed" '13 val)))
;; (if (equal? '#\c (begin (string-ref "abc" 2))) (format #t "~d   " 441) (begin (newline) (error 'test "\nfailed" '#\c)))
;; (if (equal? '#t (begin (list? '(a b c)))) (format #t "~d   " 442) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (list? '()))) (format #t "~d   " 443) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (list? '(a . b)))) (format #t "~d   " 444) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '"abc" (begin "abc")) (format #t "~d   " 445) (begin (newline) (error 'test "\nfailed" '"abc")))
;; (let1 val (begin (match '(0 (1 2) (3 4 5)) ((a (b c) (d e f)) (list a b c d e f)))) (if (equal? '(0 1 2 3 4 5) val) (format #t "~d   " 446) (error 'test "failed" '(0 1 2 3 4 5) val)))
;; (let1 val (begin (match 123 ((? string? x) (list 'string x)) ((? number? x) (list 'number x)))) (if (equal? '(number 123) val) (format #t "~d   " 447) (error 'test "failed" '(number 123) val)))
;; (let1 val (begin (define let-analyzer (match-lambda (('let (? symbol?) ((var expr) ...) body ...) (format "named let, vars=~s exprs=~s" var expr)) (('let ((var expr) ...) body ...) (format "normal let, vars=~s exprs=~s" var expr)) (_ (format "malformed let")))) (let-analyzer '(let ((a b) (c d)) e f g))) (if (equal? '"normal let, vars=(a c) exprs=(b d)" val) (format #t "~d   " 448) (error 'test "failed" '"normal let, vars=(a c) exprs=(b d)" val)))
;; (let1 val (begin (let-analyzer '(let foo ((x (f a b)) (y (f c d))) e f g))) (if (equal? '"named let, vars=(x y) exprs=((f a b) (f c d))" val) (format #t "~d   " 449) (error 'test "failed" '"named let, vars=(x y) exprs=((f a b) (f c d))" val)))
;; (let1 val (begin (let-analyzer '(let (a) b c d))) (if (equal? '"malformed let" val) (format #t "~d   " 450) (error 'test "failed" '"malformed let" val)))
;; (let1 val (begin (match '(the answer is 42) (`(the answer is ,value) value) (else #f))) (if (equal? '42 val) (format #t "~d   " 451) (error 'test "failed" '42 val)))
;; (let1 val (begin (match '(the answer was 42) (`(the answer is ,value) value) (else #f))) (if (equal? '#f val) (format #t "~d   " 452) (error 'test "failed" '#f val)))
;; (let1 val (begin (match '(a b c d) ((the answer is value) value) (else #f))) (if (equal? 'd val) (format #t "~d   " 453) (error 'test "failed" 'd val)))
;; (let1 val (begin (match "mosh.scm" ((? string? (= #/(.*)\.([^.]+)$/ m)) (format "base=~a suffix=~a" (m 1) (m 2))))) (if (equal? '"base=mosh suffix=scm" val) (format #t "~d   " 454) (error 'test "failed" '"base=mosh suffix=scm" val)))
;; (let1 val (begin (do ((i 0) (j 0)) ((zero? j) (set! i 1) (set! i 2) i))) (if (equal? '2 val) (format #t "~d   " 455) (error 'test "failed" '2 val)))
;; (if (equal? 'composite (begin (case (* 2 3) ((2 3 5 7) 'prime) ((1 4 6 8 9) 'composite)))) (format #t "~d   " 456) (begin (newline) (error 'test "\nfailed" 'composite)))
;; (if (equal? 'consonant (begin (case (car '(c d)) ((a e i o u) 'vowel) ((w y) 'semivowel) (else 'consonant)))) (format #t "~d   " 457) (begin (newline) (error 'test "\nfailed" 'consonant)))
;; (if (equal? '0 (begin (case 1 ((2 1) 0)))) (format #t "~d   " 458) (begin (newline) (error 'test "\nfailed" '0)))
;; (if (equal? '0 (begin (case 2 ((2 1) 0)))) (format #t "~d   " 459) (begin (newline) (error 'test "\nfailed" '0)))
;; (let1 val (begin (procedure? car)) (if (equal? '#t val) (format #t "~d   " 460) (error 'test "failed" '#t val)))
;; (let1 val (begin (procedure? 'car)) (if (equal? '#f val) (format #t "~d   " 461) (error 'test "failed" '#f val)))
;; (let1 val (begin (procedure? (lambda (x) (* x x)))) (if (equal? '#t val) (format #t "~d   " 462) (error 'test "failed" '#t val)))
;; (let1 val (begin (procedure? '(lambda (x) (* x x)))) (if (equal? '#f val) (format #t "~d   " 463) (error 'test "failed" '#f val)))
;; (if (equal? '#t (begin (char>=? #\b #\a))) (format #t "~d   " 464) (begin (newline) (error 'test "\nfailed" '#t)))
;; (let1 val (begin (char>=? #\c #\b #\a)) (if (equal? '#t val) (format #t "~d   " 465) (error 'test "failed" '#t val)))
;; (if (equal? '#t (begin (char>=? #\b #\b))) (format #t "~d   " 466) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (char>=? #\b #\c))) (format #t "~d   " 467) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (char>? #\b #\a))) (format #t "~d   " 468) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (char>? #\b #\b))) (format #t "~d   " 469) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (char>? #\b #\c))) (format #t "~d   " 470) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (char<=? #\a #\b))) (format #t "~d   " 471) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (char<=? #\b #\b))) (format #t "~d   " 472) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (char<=? #\c #\b))) (format #t "~d   " 473) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (char<? #\a #\b))) (format #t "~d   " 474) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (char<? #\b #\b))) (format #t "~d   " 475) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (char<? #\c #\b))) (format #t "~d   " 476) (begin (newline) (error 'test "\nfailed" '#f)))
;; (let1 val (begin (cons* 1 2 3 4)) (if (equal? '(1 2 3 . 4) val) (format #t "~d   " 477) (error 'test "failed" '(1 2 3 . 4) val)))
;; (let1 val (begin (cons* 1)) (if (equal? '1 val) (format #t "~d   " 478) (error 'test "failed" '1 val)))
;; (let1 val (begin (receive (x y) (car+cdr '(1 . 3)) (cons x y))) (if (equal? '(1 . 3) val) (format #t "~d   " 479) (error 'test "failed" '(1 . 3) val)))
;; (if (equal? '1 (begin (append 1))) (format #t "~d   " 480) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '(1 . 2) (begin (append '(1) 2))) (format #t "~d   " 481) (begin (newline) (error 'test "\nfailed" '(1 . 2))))
;; (if (equal? '(1 2 . 3) (begin (append '(1 2) 3))) (format #t "~d   " 482) (begin (newline) (error 'test "\nfailed" '(1 2 . 3))))
;; (if (equal? '(1 2 3) (begin (append '(1 2) '(3)))) (format #t "~d   " 483) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '(1 2 3 . 4) (begin (append '(1 2) '(3) 4))) (format #t "~d   " 484) (begin (newline) (error 'test "\nfailed" '(1 2 3 . 4))))
;; (if (equal? '(1 2 3 . 4) (begin (append '(1 2) '(3) 4))) (format #t "~d   " 485) (begin (newline) (error 'test "\nfailed" '(1 2 3 . 4))))
;; (if (equal? '1 (begin (append '() 1))) (format #t "~d   " 486) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '(1) (begin (append '(1) '()))) (format #t "~d   " 487) (begin (newline) (error 'test "\nfailed" '(1))))
;; (if (equal? '1 (begin (append! 1))) (format #t "~d   " 488) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '(1 . 2) (begin (append! '(1) 2))) (format #t "~d   " 489) (begin (newline) (error 'test "\nfailed" '(1 . 2))))
;; (if (equal? '(1 2 . 3) (begin (append! '(1 2) 3))) (format #t "~d   " 490) (begin (newline) (error 'test "\nfailed" '(1 2 . 3))))
;; (if (equal? '(1 2 3) (begin (append! '(1 2) '(3)))) (format #t "~d   " 491) (begin (newline) (error 'test "\nfailed" '(1 2 3))))
;; (if (equal? '(1 2 3 . 4) (begin (append! '(1 2) '(3) 4))) (format #t "~d   " 492) (begin (newline) (error 'test "\nfailed" '(1 2 3 . 4))))
;; (if (equal? '(1 2 3 . 4) (begin (append! '(1 2) '(3) 4))) (format #t "~d   " 493) (begin (newline) (error 'test "\nfailed" '(1 2 3 . 4))))
;; (if (equal? '1 (begin (append! '() 1))) (format #t "~d   " 494) (begin (newline) (error 'test "\nfailed" '1)))
;; (if (equal? '(1) (begin (append! '(1) '()))) (format #t "~d   " 495) (begin (newline) (error 'test "\nfailed" '(1))))
;; (let1 val (begin (take '(a b c d e) 2)) (if (equal? '(a b) val) (format #t "~d   " 496) (error 'test "failed" '(a b) val)))
;; (let1 val (begin (drop '(a b c d e) 2)) (if (equal? '(c d e) val) (format #t "~d   " 497) (error 'test "failed" '(c d e) val)))
;; (let1 val (begin (take '(1 2 3 . d) 2)) (if (equal? '(1 2) val) (format #t "~d   " 498) (error 'test "failed" '(1 2) val)))
;; (let1 val (begin (drop '(1 2 3 . d) 2)) (if (equal? '(3 . d) val) (format #t "~d   " 499) (error 'test "failed" '(3 . d) val)))
;; (let1 val (begin (take '(1 2 3 . d) 3)) (if (equal? '(1 2 3) val) (format #t "~d   " 500) (error 'test "failed" '(1 2 3) val)))
;; (let1 val (begin (drop '(1 2 3 . d) 3)) (if (equal? 'd val) (format #t "~d   " 501) (error 'test "failed" 'd val)))
;; (let1 val (begin (take-right '(a b c d e) 2)) (if (equal? '(d e) val) (format #t "~d   " 502) (error 'test "failed" '(d e) val)))
;; (let1 val (begin (drop-right '(a b c d e) 2)) (if (equal? '(a b c) val) (format #t "~d   " 503) (error 'test "failed" '(a b c) val)))
;; (let1 val (begin (take-right '(1 2 3 . d) 2)) (if (equal? '(2 3 . d) val) (format #t "~d   " 504) (error 'test "failed" '(2 3 . d) val)))
;; (let1 val (begin (drop-right '(1 2 3 . d) 2)) (if (equal? '(1) val) (format #t "~d   " 505) (error 'test "failed" '(1) val)))
;; (let1 val (begin (take-right '(1 2 3 . d) 0)) (if (equal? 'd val) (format #t "~d   " 506) (error 'test "failed" 'd val)))
;; (let1 val (begin (drop-right '(1 2 3 . d) 0)) (if (equal? '(1 2 3) val) (format #t "~d   " 507) (error 'test "failed" '(1 2 3) val)))
;; (let1 val (begin (xcons '(b c) 'a)) (if (equal? '(a b c) val) (format #t "~d   " 508) (error 'test "failed" '(a b c) val)))
;; (let1 val (begin (make-list 4 'c)) (if (equal? '(c c c c) val) (format #t "~d   " 509) (error 'test "failed" '(c c c c) val)))
;; (let1 val (begin (list-tabulate 4 values)) (if (equal? '(0 1 2 3) val) (format #t "~d   " 510) (error 'test "failed" '(0 1 2 3) val)))
;; (let1 val (begin (list-copy '(1 2 3 4))) (if (equal? '(1 2 3 4) val) (format #t "~d   " 511) (error 'test "failed" '(1 2 3 4) val)))
;; (let1 val (begin (let1 lst (circular-list 'z 'q) (and (eq? (first lst) 'z) (eq? (second lst) 'q) (third lst) 'z))) (if (equal? 'z val) (format #t "~d   " 512) (error 'test "failed" 'z val)))
;; (let1 val (begin (proper-list? '())) (if (equal? '#t val) (format #t "~d   " 513) (error 'test "failed" '#t val)))
;; (let1 val (begin (proper-list? '(1 2 3))) (if (equal? '#t val) (format #t "~d   " 514) (error 'test "failed" '#t val)))
;; (let1 val (begin (proper-list? '(1 . 3))) (if (equal? '#f val) (format #t "~d   " 515) (error 'test "failed" '#f val)))
;; (let1 val (begin (dotted-list? '(1 2 . 3))) (if (equal? '#t val) (format #t "~d   " 516) (error 'test "failed" '#t val)))
;; (let1 val (begin (dotted-list? '(1 2 3))) (if (equal? '#f val) (format #t "~d   " 517) (error 'test "failed" '#f val)))
;; (let1 val (begin (last-pair '(a b c))) (if (equal? '(c) val) (format #t "~d   " 518) (error 'test "failed" '(c) val)))
;; (let1 val (begin (last '(a b c))) (if (equal? 'c val) (format #t "~d   " 519) (error 'test "failed" 'c val)))
;; (let1 val (begin (not-pair? 3)) (if (equal? '#t val) (format #t "~d   " 520) (error 'test "failed" '#t val)))
;; (let1 val (begin (not-pair? '(1 2))) (if (equal? '#f val) (format #t "~d   " 521) (error 'test "failed" '#f val)))
;; (let1 val (begin (list= eq?)) (if (equal? '#t val) (format #t "~d   " 522) (error 'test "failed" '#t val)))
;; (let1 val (begin (list= eq? '(a))) (if (equal? '#t val) (format #t "~d   " 523) (error 'test "failed" '#t val)))
;; (let1 val (begin (list= eq? '(a) '(a))) (if (equal? '#t val) (format #t "~d   " 524) (error 'test "failed" '#t val)))
;; (let1 val (begin (list= eq? '(a) '(a b))) (if (equal? '#f val) (format #t "~d   " 525) (error 'test "failed" '#f val)))
;; (let1 val (begin (receive (x y) (split-at '(a b c d e f g h) 3) (cons x y))) (if (equal? '((a b c) d e f g h) val) (format #t "~d   " 526) (error 'test "failed" '((a b c) d e f g h) val)))
;; (if (equal? '"123" (begin (string #\1 #\2 #\3))) (format #t "~d   " 527) (begin (newline) (error 'test "\nfailed" '"123")))
;; (if (equal? '"taro&amp;hanako" (begin (regexp-replace-all #/&/ "taro&hanako" "&amp;"))) (format #t "~d   " 528) (begin (newline) (error 'test "\nfailed" '"taro&amp;hanako")))
;; (let1 val (begin (let1 ht (make-hashtable (lambda (x) 2) (lambda (a b) #t)) (hashtable-set! ht 1 1) (hashtable-set! ht 2 2) (hashtable-ref ht 1))) (if (equal? '2 val) (format #t "~d   " 529) (error 'test "failed" '2 val)))
;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "my" "apple") (hashtable-set! ht "our" "water") (hashtable-ref ht "my"))) (if (equal? '"apple" val) (format #t "~d   " 530) (error 'test "failed" '"apple" val)))
;; (let1 val (begin (hashtable? (make-hashtable string-hash string=?))) (if (equal? '#t val) (format #t "~d   " 531) (error 'test "failed" '#t val)))
;; (let1 val (begin (hashtable? (make-eq-hashtable))) (if (equal? '#t val) (format #t "~d   " 532) (error 'test "failed" '#t val)))
;; (let1 val (begin (hashtable? '(a . b))) (if (equal? '#f val) (format #t "~d   " 533) (error 'test "failed" '#f val)))
;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "my" "apple") (hashtable-set! ht "our" "water") (hashtable-size ht))) (if (equal? '2 val) (format #t "~d   " 534) (error 'test "failed" '2 val)))
;; (let1 val (begin (let1 ht (make-eq-hashtable) (hashtable-set! ht "my" "apple") (hashtable-set! ht "my" "apple") (hashtable-size ht))) (if (equal? '2 val) (format #t "~d   " 535) (error 'test "failed" '2 val)))
;; (let1 val (begin (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-delete! ht 1) (hashtable-ref ht 1 #f))) (if (equal? '#f val) (format #t "~d   " 536) (error 'test "failed" '#f val)))
;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-delete! ht "one") (hashtable-ref ht "one" #f))) (if (equal? '#f val) (format #t "~d   " 537) (error 'test "failed" '#f val)))
;; (let1 val (begin (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-contains? ht 2))) (if (equal? '#f val) (format #t "~d   " 538) (error 'test "failed" '#f val)))
;; ;; (let1 val (begin (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-contains? ht 1))) (if (equal? '#t val) (format #t "~d   " 539) (error 'test "failed" '#t val)))
;; ;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-contains? ht "two"))) (if (equal? '#f val) (format #t "~d   " 540) (error 'test "failed" '#f val)))
;; ;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-contains? ht "one"))) (if (equal? '#t val) (format #t "~d   " 541) (error 'test "failed" '#t val)))
;; ;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" "one") (hashtable-update! ht "one" (lambda (x) (string-append "!" x "!")) "hige") (hashtable-update! ht "two" (lambda (x) (string-append "!" x "!")) "hige") (string-append (hashtable-ref ht "one") (hashtable-ref ht "two")))) (if (equal? '"!one!!hige!" val) (format #t "~d   " 542) (error 'test "failed" '"!one!!hige!" val)))
;; ;; (let1 val (begin (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (let1 ht-copy (hashtable-copy ht) (and (string=? (hashtable-ref ht-copy 1) "one") (not (hashtable-mutable? ht-copy)))))) (if (equal? '#t val) (format #t "~d   " 543) (error 'test "failed" '#t val)))
;; ;; (let1 val (begin (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (let1 ht-copy (hashtable-copy ht #t) (and (string=? (hashtable-ref ht-copy 1) "one") (hashtable-mutable? ht-copy))))) (if (equal? '#t val) (format #t "~d   " 544) (error 'test "failed" '#t val)))
;; ;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" "one") (let1 ht-copy (hashtable-copy ht) (and (string=? (hashtable-ref ht-copy "one") "one") (not (hashtable-mutable? ht-copy)))))) (if (equal? '#t val) (format #t "~d   " 545) (error 'test "failed" '#t val)))
;; ;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" "one") (let1 ht-copy (hashtable-copy ht #t) (and (string=? (hashtable-ref ht-copy "one") "one") (hashtable-mutable? ht-copy))))) (if (equal? '#t val) (format #t "~d   " 546) (error 'test "failed" '#t val)))
;; ;; (let1 val (begin (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-set! ht 2 "two") (hashtable-clear! ht) (hashtable-size ht))) (if (equal? '0 val) (format #t "~d   " 547) (error 'test "failed" '0 val)))
;; ;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-set! ht "two" 2) (hashtable-clear! ht) (hashtable-size ht))) (if (equal? '0 val) (format #t "~d   " 548) (error 'test "failed" '0 val)))
;; ;; (let1 val (begin (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-set! ht 2 "two") (vector->list (hashtable-keys ht)))) (if (equal? '(1 2) val) (format #t "~d   " 549) (error 'test "failed" '(1 2) val)))
;; ;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-set! ht "two" 2) (let1 keys (vector->list (hashtable-keys ht)) (and (member "one" keys) (member "two" keys) (= 2 (length keys)))))) (if (equal? '#t val) (format #t "~d   " 550) (error 'test "failed" '#t val)))
;; ;; (let1 val (begin (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-set! ht "two" 2) (receive (keys vals) (hashtable-entries ht) (append (vector->list keys) (vector->list vals))))) (if (equal? '("two" "one" 2 1) val) (format #t "~d   " 551) (error 'test "failed" '("two" "one" 2 1) val)))
;; (let1 val (begin (equal? eq? (hashtable-equivalence-function (make-eq-hashtable)))) (if (equal? '#t val) (format #t "~d   " 552) (error 'test "failed" '#t val)))
;; (let1 val (begin (hashtable-hash-function (make-eq-hashtable))) (if (equal? '#f val) (format #t "~d   " 553) (error 'test "failed" '#f val)))
;; (let1 val (begin (equal? string=? (hashtable-equivalence-function (make-hashtable string-hash string=?)))) (if (equal? '#t val) (format #t "~d   " 554) (error 'test "failed" '#t val)))
;; (let1 val (begin (equal? string-hash (hashtable-hash-function (make-hashtable string-hash string=?)))) (if (equal? '#t val) (format #t "~d   " 555) (error 'test "failed" '#t val)))
;; (let1 val (begin (= (string-ci-hash "abc") (string-ci-hash "AbC"))) (if (equal? '#t val) (format #t "~d   " 556) (error 'test "failed" '#t val)))
;; (let1 val (begin (= (symbol-hash 'abc) (symbol-hash 'abc))) (if (equal? '#t val) (format #t "~d   " 557) (error 'test "failed" '#t val)))
;; (let1 val (begin (= (symbol-hash 'abc) (symbol-hash 'aBc))) (if (equal? '#f val) (format #t "~d   " 558) (error 'test "failed" '#f val)))
;; (let1 val (begin (= (equal-hash '(a b c)) (equal-hash '(a b c)))) (if (equal? '#t val) (format #t "~d   " 559) (error 'test "failed" '#t val)))
;; (let1 val (begin (equal? eqv? (hashtable-equivalence-function (make-eqv-hashtable)))) (if (equal? '#t val) (format #t "~d   " 560) (error 'test "failed" '#t val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (point? (record-predicate :point)) (point-x (record-accessor :point 0)) (point-y (record-accessor :point 1)) (point-x-set! (record-mutator :point 0)) (point-y-set! (record-mutator :point 1)) (p1 (make-point 1 2))) (and (point? p1) (record? p1) (= (point-x p1) 1) (= (point-y p1) 2) (point-x-set! p1 5) (= (point-x p1) 5)))) (if (equal? '#t val) (format #t "~d   " 561) (error 'test "failed" '#t val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point2 (make-record-type-descriptor 'point2 :point #f #f #f '#((mutable x) (mutable y)))) (make-point2 (record-constructor (make-record-constructor-descriptor :point2 #f #f))) (point? (record-predicate :point)) (point-x (record-accessor :point 0)) (point-y (record-accessor :point 1)) (point-x-set! (record-mutator :point 0)) (point-y-set! (record-mutator :point 1)) (point2? (record-predicate :point2)) (point2-xx (record-accessor :point2 0)) (point2-yy (record-accessor :point2 1)) (point2-xx-set! (record-mutator :point2 0)) (point2-yy-set! (record-mutator :point2 1)) (p2 (make-point2 1 2 3 4))) (and (point? p2) (point2? p2) (record? p2) (= (point-x p2) 1) (= (point-y p2) 2) (= (point2-xx p2) 3) (= (point2-yy p2) 4) (point-x-set! p2 5) (= (point-x p2) 5) (point-y-set! p2 6) (= (point-y p2) 6) (point2-xx-set! p2 7) (= (point2-xx p2) 7) (point2-yy-set! p2 8) (= (point2-yy p2) 8)))) (if (equal? '#t val) (format #t "~d   " 562) (error 'test "failed" '#t val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd/abs (make-record-constructor-descriptor :point #f (lambda (new) (lambda (x y) (new (abs x) (abs y)))))) (point-x (record-accessor :point 0)) (point-y (record-accessor :point 1)) (make-point/abs (record-constructor :point-cd/abs))) (and (= (point-x (make-point/abs -1 -2)) 1) (= (point-y (make-point/abs -1 -2)) 2)))) (if (equal? '#t val) (format #t "~d   " 563) (error 'test "failed" '#t val)))
;; (let1 val (begin (let* ((color->rgb (lambda (c) (cons 'rgb c))) (:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (:point-cd/abs (make-record-constructor-descriptor :point #f (lambda (new) (lambda (x y) (new (abs x) (abs y)))))) (point-x (record-accessor :point 0)) (:cpoint (make-record-type-descriptor 'cpoint :point #f #f #f '#((mutable rgb)))) (cpoint-rgb (record-accessor :cpoint 0)) (make-cpoint (record-constructor (make-record-constructor-descriptor :cpoint :point-cd (lambda (p) (lambda (x y c) ((p x y) (color->rgb c))))))) (make-cpoint/abs (record-constructor (make-record-constructor-descriptor :cpoint :point-cd/abs (lambda (p) (lambda (x y c) ((p x y) (color->rgb c)))))))) (and (equal? (cpoint-rgb (make-cpoint -1 -3 'red)) '(rgb . red)) (= (point-x (make-cpoint -1 -3 'red)) -1) (= (point-x (make-cpoint/abs -1 -3 'red)) 1)))) (if (equal? '#t val) (format #t "~d   " 564) (error 'test "failed" '#t val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f #f #f #t '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (p (make-point 1 2))) (record? p))) (if (equal? '#f val) (format #t "~d   " 565) (error 'test "failed" '#f val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (p (make-point 1 2))) (eqv? :point (record-rtd p)))) (if (equal? '#t val) (format #t "~d   " 566) (error 'test "failed" '#t val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (p (make-point 1 2))) (record-type-name (record-rtd p)))) (if (equal? 'point val) (format #t "~d   " 567) (error 'test "failed" 'point val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point2 (make-record-type-descriptor 'point2 :point #f #f #f '#((mutable x) (mutable y))))) (record-type-name (record-type-parent :point2)))) (if (equal? 'point val) (format #t "~d   " 568) (error 'test "failed" 'point val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y)))) (:point2 (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y))))) (eq? :point :point2))) (if (equal? '#t val) (format #t "~d   " 569) (error 'test "failed" '#t val)))
;; (let1 val (begin (let* ((:point2 (make-record-type-descriptor 'point2 #f #f #f #f '#((mutable x) (mutable y))))) (record-type-generative? :point2))) (if (equal? '#t val) (format #t "~d   " 570) (error 'test "failed" '#t val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y))))) (record-type-generative? :point))) (if (equal? '#f val) (format #t "~d   " 571) (error 'test "failed" '#f val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y))))) (record-type-field-names :point))) (if (equal? '#(x y) val) (format #t "~d   " 572) (error 'test "failed" '#(x y) val)))
;; (let1 val (begin (let* ((:point (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y))))) (record-field-mutable? :point 1))) (if (equal? '#t val) (format #t "~d   " 573) (error 'test "failed" '#t val)))
;; (let1 val (begin (let ((x '()) (c #f)) (dynamic-wind (lambda () (set! x (cons 'a x))) (lambda () (dynamic-wind (lambda () (set! x (cons 'b x))) (lambda () (dynamic-wind (lambda () (set! x (cons 'c x))) (lambda () (set! c (call/cc (lambda (x) x)))) (lambda () (set! x (cons 'd x))))) (lambda () (set! x (cons 'e x)))) (dynamic-wind (lambda () (set! x (cons 'f x))) (lambda () (when c (c #f))) (lambda () (set! x (cons 'g x))))) (lambda () (set! x (cons 'h x)))) (reverse x))) (if (equal? '(a b c d e f g b c d e f g h) val) (format #t "~d   " 574) (error 'test "failed" '(a b c d e f g b c d e f g h) val)))
;; (let1 val (begin ((lambda () (receive x (dynamic-wind (lambda () #f) (lambda () (values 'a 'b 'c)) (lambda () #f)) x)))) (if (equal? '(a b c) val) (format #t "~d   " 575) (error 'test "failed" '(a b c) val)))
;; (let1 val (begin ((lambda () (receive x (dynamic-wind (lambda () #f) (lambda () (values)) (lambda () #f)) x)))) (if (equal? '() val) (format #t "~d   " 576) (error 'test "failed" '() val)))
;; (let1 val (begin (eval 3 '())) (if (equal? '3 val) (format #t "~d   " 577) (error 'test "failed" '3 val)))
;; (if (equal? '#t (begin (equal? '(#(1 2 3) . #(one two three)) '(#(1 2 3) . #(one two three))))) (format #t "~d   " 578) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? 'error (guard (con (#t 'error)) (call/cc (lambda (cont) (with-exception-handler (lambda (c) (cont 'error)) (lambda () (car 3))))))) (format #t "~d   " 579) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (car 3))) (format #t "~d   " 580) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (cdr 3))) (format #t "~d   " 581) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (cddr 3))) (format #t "~d   " 582) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (cdar 3))) (format #t "~d   " 583) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (cadr 3))) (format #t "~d   " 584) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (caar 3))) (format #t "~d   " 585) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (values 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))) (format #t "~d   " 586) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (apply values '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)))) (format #t "~d   " 587) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (apply (lambda (s) (display s)) '(1 2)))) (format #t "~d   " 588) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (number? 2 2))) (format #t "~d   " 589) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (make-record-constructor-descriptor))) (format #t "~d   " 590) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (hashtable-clear! 1 1 1))) (format #t "~d   " 591) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (record-predicate 3))) (format #t "~d   " 592) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (record-constructor 3))) (format #t "~d   " 593) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (make-record-type-descriptor 'point 3 'uid #f #f #f))) (format #t "~d   " 594) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (point-x (record-accessor :point 3))) #f))) (format #t "~d   " 595) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((immutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (point-x (record-mutator :point 0))) #f))) (format #t "~d   " 596) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((immutable x) (mutable y)))) (:point2 (make-record-type-descriptor 'point2 #f #f #f #f '#((immutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (:point2-cd (make-record-constructor-descriptor :point2 #f #f)) (make-point (record-constructor :point-cd)) (point2-x (record-accessor :point2 0))) (point2-x (make-point 1 2))))) (format #t "~d   " 597) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (let* ((:point (make-record-type-descriptor 'point #f #f #t #t '#((immutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd))) (record-rtd (make-point 2 21))))) (format #t "~d   " 598) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (apply read-char (current-input-port)))) (format #t "~d   " 599) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (rxmatch-start (rxmatch #/\d+/ "a345a") 5))) (format #t "~d   " 600) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (string-ref "hige" 5))) (format #t "~d   " 601) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (open-file-input-port "not-exist-path/////xxx"))) (format #t "~d   " 602) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (open-file-output-port "not-exist-path/////xxx"))) (format #t "~d   " 603) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (format "~a ~a" 1))) (format #t "~d   " 604) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) my-unbound-variable)) (format #t "~d   " 605) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (my-unbound-variable))) (format #t "~d   " 606) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (vector-ref 'v 3))) (format #t "~d   " 607) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (receive (a) (values 1 2)))) (format #t "~d   " 608) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (receive (a b) (values 1)))) (format #t "~d   " 609) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (3))) (format #t "~d   " 610) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (/ 3 0))) (format #t "~d   " 611) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (error "our" "message"))) (format #t "~d   " 612) (error 'test "failed"))(if (equal? '#t (begin (let ((x (list 'a 'b 'c 'a)) (y (list 'a 'b 'c 'a 'b 'c 'a))) (set-cdr! (list-tail x 2) x) (set-cdr! (list-tail y 5) y) (equal? x y)))) (format #t "~d   " 613) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (apply = '(3 3)))) (format #t "~d   " 614) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (apply = '(3 4)))) (format #t "~d   " 615) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (apply = '(3 3 3 3)))) (format #t "~d   " 616) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (apply = '(3 3 3 4)))) (format #t "~d   " 617) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#f (begin (apply = '(4 3 3 3)))) (format #t "~d   " 618) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? 'error (guard (con (#t 'error)) (apply = '(4 'z 3 3)))) (format #t "~d   " 619) (error 'test "failed"))(if (equal? '#t (begin (apply > '(4 3)))) (format #t "~d   " 620) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (apply > '(4 3 2)))) (format #t "~d   " 621) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (apply > '(4 3 1 2)))) (format #t "~d   " 622) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (apply >= '(3 3 3)))) (format #t "~d   " 623) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (apply >= '(4 3 3)))) (format #t "~d   " 624) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (apply >= '(4 3)))) (format #t "~d   " 625) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (apply < '(1 2)))) (format #t "~d   " 626) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (apply < '(1 2 3)))) (format #t "~d   " 627) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (apply < '(1 5 3)))) (format #t "~d   " 628) (begin (newline) (error 'test "\nfailed" '#f)))
;; (if (equal? '#t (begin (apply <= '(1 2)))) (format #t "~d   " 629) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (apply <= '(1 2 3)))) (format #t "~d   " 630) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#t (begin (apply <= '(1 3 3)))) (format #t "~d   " 631) (begin (newline) (error 'test "\nfailed" '#t)))
;; (if (equal? '#f (begin (apply <= '(1 5 3)))) (format #t "~d   " 632) (begin (newline) (error 'test "\nfailed" '#f)))
(if (equal? 'error (guard (con (#t 'error)) (+ 1 2 'a))) (format #t "~d   " 633) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (/ 1 0))) (format #t "~d   " 634) (error 'test "failed"))(if (equal? '4 (begin (apply + '(4)))) (format #t "~d   " 635) (begin (newline) (error 'test "\nfailed" '4)))
(if (equal? '7 (begin (apply + '(4 3)))) (format #t "~d   " 636) (begin (newline) (error 'test "\nfailed" '7)))
(if (equal? '17 (begin (apply + '(4 3 10)))) (format #t "~d   " 637) (begin (newline) (error 'test "\nfailed" '17)))
(if (equal? '4 (begin (apply + '(1 1 1 1)))) (format #t "~d   " 638) (begin (newline) (error 'test "\nfailed" '4)))
(if (equal? '5 (begin (apply - '(10 5)))) (format #t "~d   " 639) (begin (newline) (error 'test "\nfailed" '5)))
(if (equal? '3 (begin (apply - '(10 5 2)))) (format #t "~d   " 640) (begin (newline) (error 'test "\nfailed" '3)))
(if (equal? '6 (begin (apply * '(2 3)))) (format #t "~d   " 641) (begin (newline) (error 'test "\nfailed" '6)))
(if (equal? '24 (begin (apply * '(2 3 4)))) (format #t "~d   " 642) (begin (newline) (error 'test "\nfailed" '24)))
(if (equal? '3 (begin (apply / '(6 2)))) (format #t "~d   " 643) (begin (newline) (error 'test "\nfailed" '3)))
(if (equal? 'error (guard (con (#t 'error)) (apply / '(6 0)))) (format #t "~d   " 644) (error 'test "failed"))(if (equal? '(0 1 2 #f) (begin (let* ((e (make-enumeration '(red green blue))) (i (enum-set-indexer e))) (list (i 'red) (i 'green) (i 'blue) (i 'yellow))))) (format #t "~d   " 645) (begin (newline) (error 'test "\nfailed" '(0 1 2 #f))))
(if (equal? '(red green blue) (begin (enum-set->list (make-enumeration '(red green blue))))) (format #t "~d   " 646) (begin (newline) (error 'test "\nfailed" '(red green blue))))
(if (equal? '(red blue) (begin (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (enum-set->list (c '(blue red)))))) (format #t "~d   " 647) (begin (newline) (error 'test "\nfailed" '(red blue))))
(if (equal? '(#t #f #t #t #f #t) (begin (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (list (enum-set-member? 'blue (c '(red blue))) (enum-set-member? 'green (c '(red blue))) (enum-set-subset? (c '(red blue)) e) (enum-set-subset? (c '(red blue)) (c '(blue red))) (enum-set-subset? (c '(red blue)) (c '(red))) (enum-set=? (c '(red blue)) (c '(blue red))))))) (format #t "~d   " 648) (begin (newline) (error 'test "\nfailed" '(#t #f #t #t #f #t))))
(if (equal? 'error (guard (con (#t 'error)) (guard (c (#t 'error)) (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (c '(pink)))))) (format #t "~d   " 649) (error 'test "failed"))(if (equal? '((red green blue) (red green blue) 1 #t #f #t #t #f #t #t #f #f #t #t #f #f #t) (begin (let* ((e (make-enumeration '(red green blue))) (r ((enum-set-constructor e) '(red)))) (list (enum-set->list (enum-set-universe e)) (enum-set->list (enum-set-universe r)) ((enum-set-indexer ((enum-set-constructor e) '(red))) 'green) (enum-set-member? 'red e) (enum-set-member? 'black e) (enum-set-subset? e e) (enum-set-subset? r e) (enum-set-subset? e r) (enum-set-subset? e (make-enumeration '(blue green red))) (enum-set-subset? e (make-enumeration '(blue green red black))) (enum-set-subset? (make-enumeration '(blue green red black)) e) (enum-set-subset? ((enum-set-constructor (make-enumeration '(blue green red black))) '(red)) e) (enum-set-subset? ((enum-set-constructor (make-enumeration '(green red))) '(red)) e) (enum-set=? e e) (enum-set=? r e) (enum-set=? e r) (enum-set=? e (make-enumeration '(blue green red))))))) (format #t "~d   " 650) (begin (newline) (error 'test "\nfailed" '((red green blue) (red green blue) 1 #t #f #t #t #f #t #t #f #f #t #t #f #f #t))))
(if (equal? '(#t #f #t #t #f #t) (begin (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (list (enum-set-member? 'blue (c '(red blue))) (enum-set-member? 'green (c '(red blue))) (enum-set-subset? (c '(red blue)) e) (enum-set-subset? (c '(red blue)) (c '(blue red))) (enum-set-subset? (c '(red blue)) (c '(red))) (enum-set=? (c '(red blue)) (c '(blue red))))))) (format #t "~d   " 651) (begin (newline) (error 'test "\nfailed" '(#t #f #t #t #f #t))))
(if (equal? '(red blue) (begin (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (enum-set->list (c '(blue red)))))) (format #t "~d   " 652) (begin (newline) (error 'test "\nfailed" '(red blue))))
(if (equal? '((red blue) (red) (green)) (begin (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (list (enum-set->list (enum-set-union (c '(blue)) (c '(red)))) (enum-set->list (enum-set-intersection (c '(red green)) (c '(red blue)))) (enum-set->list (enum-set-difference (c '(red green)) (c '(red blue)))))))) (format #t "~d   " 653) (begin (newline) (error 'test "\nfailed" '((red blue) (red) (green)))))
(if (equal? '(green blue) (begin (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (enum-set->list (enum-set-complement (c '(red))))))) (format #t "~d   " 654) (begin (newline) (error 'test "\nfailed" '(green blue))))
(if (equal? '(red black) (begin (let ((e1 (make-enumeration '(red green blue black))) (e2 (make-enumeration '(red black white)))) (enum-set->list (enum-set-projection e1 e2))))) (format #t "~d   " 655) (begin (newline) (error 'test "\nfailed" '(red black))))
(if (equal? 'error (guard (con (#t 'error)) (call-with-string-input-port "(" (lambda (in) (read in))))) (format #t "~d   " 656) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (call-with-string-input-port "(" (lambda (in) (apply read (list in)))))) (format #t "~d   " 657) (error 'test "failed"))(if (equal? '#t (begin (eq? #\A #\A))) (format #t "~d   " 658) (begin (newline) (error 'test "\nfailed" '#t)))
(let1 val (begin (bytevector-length (make-bytevector 3))) (if (equal? '3 val) (format #t "~d   " 659) (error 'test "failed" '3 val)))
(let1 val (begin (make-bytevector 4 3)) (if (equal? '#vu8(3 3 3 3) val) (format #t "~d   " 660) (error 'test "failed" '#vu8(3 3 3 3) val)))
(let1 val (begin (bytevector=? #vu8(3 3 3) #vu8(3 3 3))) (if (equal? '#t val) (format #t "~d   " 661) (error 'test "failed" '#t val)))
(let1 val (begin (bytevector=? #vu8(3 4 3) #vu8(3 3 3))) (if (equal? '#f val) (format #t "~d   " 662) (error 'test "failed" '#f val)))
(let1 val (begin (let ((bytevector (make-bytevector 4))) (bytevector-fill! bytevector 3) bytevector)) (if (equal? '#vu8(3 3 3 3) val) (format #t "~d   " 663) (error 'test "failed" '#vu8(3 3 3 3) val)))
(if (equal? '#vu8(1 2 3 1 2 3 4 8) (begin (let ((b #vu8(1 2 3 4 5 6 7 8))) (bytevector-copy! b 0 b 3 4) b))) (format #t "~d   " 664) (begin (newline) (error 'test "\nfailed" '#vu8(1 2 3 1 2 3 4 8))))
(if (equal? '#vu8(1 2 3 4) (begin (bytevector-copy #vu8(1 2 3 4)))) (format #t "~d   " 665) (begin (newline) (error 'test "\nfailed" '#vu8(1 2 3 4))))
(if (equal? '255 (begin (bytevector-u8-ref #vu8(255) 0))) (format #t "~d   " 666) (begin (newline) (error 'test "\nfailed" '255)))
(if (equal? '255 (begin (bytevector-u8-ref (make-bytevector 1 -1) 0))) (format #t "~d   " 667) (begin (newline) (error 'test "\nfailed" '255)))
(if (equal? '255 (begin (bytevector-u8-ref (make-bytevector 1 255) 0))) (format #t "~d   " 668) (begin (newline) (error 'test "\nfailed" '255)))
(if (equal? '255 (begin (let ((bytevector (make-bytevector 1))) (bytevector-fill! bytevector -1) (bytevector-u8-ref bytevector 0)))) (format #t "~d   " 669) (begin (newline) (error 'test "\nfailed" '255)))
(if (equal? '-1 (begin (bytevector-s8-ref #vu8(255) 0))) (format #t "~d   " 670) (begin (newline) (error 'test "\nfailed" '-1)))
(if (equal? '-1 (begin (bytevector-s8-ref (make-bytevector 1 -1) 0))) (format #t "~d   " 671) (begin (newline) (error 'test "\nfailed" '-1)))
(if (equal? '-1 (begin (bytevector-s8-ref (make-bytevector 1 255) 0))) (format #t "~d   " 672) (begin (newline) (error 'test "\nfailed" '-1)))
(if (equal? '-1 (begin (let ((bytevector (make-bytevector 1))) (bytevector-fill! bytevector -1) (bytevector-s8-ref bytevector 0)))) (format #t "~d   " 673) (begin (newline) (error 'test "\nfailed" '-1)))
(if (equal? '255 (begin (let ((b (make-bytevector 1))) (bytevector-u8-set! b 0 255) (bytevector-u8-ref b 0)))) (format #t "~d   " 674) (begin (newline) (error 'test "\nfailed" '255)))
(if (equal? '255 (begin (let ((b (make-bytevector 1))) (bytevector-s8-set! b 0 -1) (bytevector-u8-ref b 0)))) (format #t "~d   " 675) (begin (newline) (error 'test "\nfailed" '255)))
(if (equal? 'error (guard (con (#t 'error)) (bytevector-u8-ref 1 (make-bytevector 1)))) (format #t "~d   " 676) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s8-ref 1 (make-bytevector 1)))) (format #t "~d   " 677) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u8-ref -1 (make-bytevector 1)))) (format #t "~d   " 678) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s8-ref -1 (make-bytevector 1)))) (format #t "~d   " 679) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u8-set! 1 (make-bytevector 1)) 1)) (format #t "~d   " 680) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s8-set! 1 (make-bytevector 1)) 1)) (format #t "~d   " 681) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u8-set! -1 (make-bytevector 1)) 1)) (format #t "~d   " 682) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s8-set! -1 (make-bytevector 1)) 1)) (format #t "~d   " 683) (error 'test "failed"))(if (equal? '#vu8(1 2 3 4) (begin (u8-list->bytevector '(1 2 3 4)))) (format #t "~d   " 684) (begin (newline) (error 'test "\nfailed" '#vu8(1 2 3 4))))
(if (equal? 'error (guard (con (#t 'error)) (u8-list->bytevector '(1 2 3 -1 4)))) (format #t "~d   " 685) (error 'test "failed"))(if (equal? '(1 2 3 4) (begin (bytevector->u8-list #vu8(1 2 3 4)))) (format #t "~d   " 686) (begin (newline) (error 'test "\nfailed" '(1 2 3 4))))
(if (equal? '65023 (begin (bytevector-u16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 'little))) (format #t "~d   " 687) (begin (newline) (error 'test "\nfailed" '65023)))
(if (equal? '-513 (begin (bytevector-s16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 'little))) (format #t "~d   " 688) (begin (newline) (error 'test "\nfailed" '-513)))
(if (equal? '65533 (begin (bytevector-u16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 'big))) (format #t "~d   " 689) (begin (newline) (error 'test "\nfailed" '65533)))
(if (equal? '-3 (begin (bytevector-s16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 'big))) (format #t "~d   " 690) (begin (newline) (error 'test "\nfailed" '-3)))
(if (equal? '255 (begin (bytevector-u16-ref #vu8(255 0) 0 'little))) (format #t "~d   " 691) (begin (newline) (error 'test "\nfailed" '255)))
(if (equal? '65280 (begin (bytevector-u16-ref #vu8(255 0) 0 'big))) (format #t "~d   " 692) (begin (newline) (error 'test "\nfailed" '65280)))
(if (equal? 'error (guard (con (#t 'error)) (bytevector-u16-ref #vu8(255 0) 1 'little))) (format #t "~d   " 693) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u16-ref #vu8(255 0) 1 'big))) (format #t "~d   " 694) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u16-native-ref #vu8(255 0 1 2) 1))) (format #t "~d   " 695) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s16-native-ref #vu8(255 0 1 2) 1))) (format #t "~d   " 696) (error 'test "failed"))(if (equal? '#t (begin (= (bytevector-u16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 (native-endianness)) (bytevector-u16-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14)))) (format #t "~d   " 697) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (= (bytevector-s16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 (native-endianness)) (bytevector-s16-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14)))) (format #t "~d   " 698) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '12345 (begin (let ((b #vu8(0 0 0 0 0))) (bytevector-u16-set! b 0 12345 'little) (bytevector-u16-ref b 0 'little)))) (format #t "~d   " 699) (begin (newline) (error 'test "\nfailed" '12345)))
(if (equal? '12345 (begin (let ((b #vu8(0 0 0 0 0))) (bytevector-u16-set! b 0 12345 'big) (bytevector-u16-ref b 0 'big)))) (format #t "~d   " 700) (begin (newline) (error 'test "\nfailed" '12345)))
(if (equal? '12345 (begin (let ((b #vu8(0 0 0 0 0))) (bytevector-s16-set! b 0 12345 'little) (bytevector-s16-ref b 0 'little)))) (format #t "~d   " 701) (begin (newline) (error 'test "\nfailed" '12345)))
(if (equal? '12345 (begin (let ((b #vu8(0 0 0 0 0))) (bytevector-s16-set! b 0 12345 'big) (bytevector-s16-ref b 0 'big)))) (format #t "~d   " 702) (begin (newline) (error 'test "\nfailed" '12345)))
(if (equal? 'error (guard (con (#t 'error)) (let ((b #vu8(0 0 0 0 0))) (bytevector-s16-set! b 0 32768 'little) (bytevector-s16-ref b 0 'little)))) (format #t "~d   " 703) (error 'test "failed"))(if (equal? '#t (begin (let ((b #vu8(0 0 0 0))) (bytevector-u16-set! b 0 12345 (native-endianness)) (bytevector-u16-native-set! b 2 12345) (= (bytevector-u16-native-ref b 0) (bytevector-u16-native-ref b 2))))) (format #t "~d   " 704) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((b #vu8(0 0 0 0))) (bytevector-s16-set! b 0 12345 (native-endianness)) (bytevector-s16-native-set! b 2 12345) (= (bytevector-s16-native-ref b 0) (bytevector-s16-native-ref b 2))))) (format #t "~d   " 705) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '-33554433 (begin (bytevector-u32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 'little))) (format #t "~d   " 706) (begin (newline) (error 'test "\nfailed" '-33554433)))
(if (equal? '-33554433 (begin (bytevector-s32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 'little))) (format #t "~d   " 707) (begin (newline) (error 'test "\nfailed" '-33554433)))
(if (equal? '-3 (begin (bytevector-u32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 'big))) (format #t "~d   " 708) (begin (newline) (error 'test "\nfailed" '-3)))
(if (equal? '-3 (begin (bytevector-s32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 'big))) (format #t "~d   " 709) (begin (newline) (error 'test "\nfailed" '-3)))
(if (equal? '#t (begin (= (bytevector-u32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 (native-endianness)) (bytevector-u32-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12)))) (format #t "~d   " 710) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (= (bytevector-s32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 (native-endianness)) (bytevector-s32-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12)))) (format #t "~d   " 711) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '12345 (begin (let ((b #vu8(0 0 0 0 0))) (bytevector-u32-set! b 0 12345 'little) (bytevector-u32-ref b 0 'little)))) (format #t "~d   " 712) (begin (newline) (error 'test "\nfailed" '12345)))
(if (equal? '12345 (begin (let ((b #vu8(0 0 0 0 0))) (bytevector-u32-set! b 0 12345 'big) (bytevector-u32-ref b 0 'big)))) (format #t "~d   " 713) (begin (newline) (error 'test "\nfailed" '12345)))
(if (equal? '-1 (begin (bytevector-u64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 'little))) (format #t "~d   " 714) (begin (newline) (error 'test "\nfailed" '-1)))
(if (equal? '-1 (begin (bytevector-s64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 'little))) (format #t "~d   " 715) (begin (newline) (error 'test "\nfailed" '-1)))
(if (equal? '-3 (begin (bytevector-s64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 'big))) (format #t "~d   " 716) (begin (newline) (error 'test "\nfailed" '-3)))
(if (equal? '#t (begin (= (bytevector-u64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 (native-endianness)) (bytevector-u64-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8)))) (format #t "~d   " 717) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (= (bytevector-s64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 (native-endianness)) (bytevector-s64-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8)))) (format #t "~d   " 718) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '12345 (begin (let ((b #vu8(0 0 0 0 0 0 0 0))) (bytevector-u64-set! b 0 12345 'little) (bytevector-u64-ref b 0 'little)))) (format #t "~d   " 719) (begin (newline) (error 'test "\nfailed" '12345)))
(if (equal? '12345 (begin (let ((b #vu8(0 0 0 0 0 0 0 0))) (bytevector-u64-set! b 0 12345 'big) (bytevector-u64-ref b 0 'big)))) (format #t "~d   " 720) (begin (newline) (error 'test "\nfailed" '12345)))
(if (equal? '"あいう" (begin (utf8->string #vu8(227 129 130 227 129 132 227 129 134)))) (format #t "~d   " 721) (begin (newline) (error 'test "\nfailed" '"あいう")))
(if (equal? '"あいう" (begin (bytevector->string #vu8(227 129 130 227 129 132 227 129 134) (make-transcoder (utf-8-codec))))) (format #t "~d   " 722) (begin (newline) (error 'test "\nfailed" '"あいう")))
(if (equal? '#vu8(227 129 130 227 129 132 227 129 134) (begin (string->bytevector "あいう" (make-transcoder (utf-8-codec))))) (format #t "~d   " 723) (begin (newline) (error 'test "\nfailed" '#vu8(227 129 130 227 129 132 227 129 134))))
(if (equal? 'error (guard (con (#t 'error)) (bytevector->string #vu8(129 130 227 129 132 227 129 134) (make-transcoder (utf-8-codec))))) (format #t "~d   " 724) (error 'test "failed"))(if (equal? '#vu8(227 129 130 227 129 132 227 129 134) (begin (string->utf8 "あいう"))) (format #t "~d   " 725) (begin (newline) (error 'test "\nfailed" '#vu8(227 129 130 227 129 132 227 129 134))))
(if (equal? '#vu8(97 0 0 0 112 0 0 0 112 0 0 0 187 3 0 0 101 0 0 0) (begin (string->utf32 "appλe" 'little))) (format #t "~d   " 726) (begin (newline) (error 'test "\nfailed" '#vu8(97 0 0 0 112 0 0 0 112 0 0 0 187 3 0 0 101 0 0 0))))
(if (equal? '#vu8(0 0 0 97 0 0 0 112 0 0 0 112 0 0 3 187 0 0 0 101) (begin (string->utf32 "appλe" 'big))) (format #t "~d   " 727) (begin (newline) (error 'test "\nfailed" '#vu8(0 0 0 97 0 0 0 112 0 0 0 112 0 0 3 187 0 0 0 101))))
(if (equal? '#vu8(0 0 0 97 0 0 0 112 0 0 0 112 0 0 3 187 0 0 0 101) (begin (string->utf32 "appλe"))) (format #t "~d   " 728) (begin (newline) (error 'test "\nfailed" '#vu8(0 0 0 97 0 0 0 112 0 0 0 112 0 0 3 187 0 0 0 101))))
(if (equal? 'error (guard (con (#t 'error)) (string->utf32 "appλe" 'hoge))) (format #t "~d   " 729) (error 'test "failed"))(if (equal? '#t (begin (and (let ((str "apple")) (string=? str (utf32->string (string->utf32 str 'big) 'big))) (let ((str "appλe")) (string=? str (utf32->string (string->utf32 str 'big) 'big))) (let ((str "")) (string=? str (utf32->string (string->utf32 str 'big) 'big))) #t))) (format #t "~d   " 730) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (and (let ((str "apple")) (string=? str (utf32->string (string->utf32 str 'little) 'little))) (let ((str "appλe")) (string=? str (utf32->string (string->utf32 str 'little) 'little))) (let ((str "")) (string=? str (utf32->string (string->utf32 str 'little) 'little))) #t))) (format #t "~d   " 731) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "apple") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? str (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'big)) (string=? str (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'little)) #t)))) (format #t "~d   " 732) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "appλe") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? str (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'big)) (string=? str (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'little)) #t)))) (format #t "~d   " 733) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "apple") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? str (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'big)) (string=? str (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'little)))))) (format #t "~d   " 734) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "appλe") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(254 255 0 0) (string->utf32 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(0 0 255 254) (string->utf32 str 'big)) 'big #t) (string-append "￾" str)))))) (format #t "~d   " 735) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(254 255 0 0) (string->utf32 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(0 0 255 254) (string->utf32 str 'big)) 'big #t) (string-append "￾" str)))))) (format #t "~d   " 736) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(254 255 0 0) (string->utf32 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(0 0 255 254) (string->utf32 str 'big)) 'big #t) (string-append "￾" str)))))) (format #t "~d   " 737) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#vu8(97 0 112 0 112 0 187 3 101 0) (begin (string->utf16 "appλe" 'little))) (format #t "~d   " 738) (begin (newline) (error 'test "\nfailed" '#vu8(97 0 112 0 112 0 187 3 101 0))))
(if (equal? '#vu8(0 97 0 112 0 112 3 187 0 101) (begin (string->utf16 "appλe" 'big))) (format #t "~d   " 739) (begin (newline) (error 'test "\nfailed" '#vu8(0 97 0 112 0 112 3 187 0 101))))
(if (equal? '#vu8(0 97 0 112 0 112 3 187 0 101) (begin (string->utf16 "appλe"))) (format #t "~d   " 740) (begin (newline) (error 'test "\nfailed" '#vu8(0 97 0 112 0 112 3 187 0 101))))
(if (equal? '#t (begin (and (let ((str "apple")) (string=? str (utf16->string (string->utf16 str 'big) 'big))) (let ((str "appλe")) (string=? str (utf16->string (string->utf16 str 'big) 'big))) (let ((str "")) (string=? str (utf16->string (string->utf16 str 'big) 'big))) #t))) (format #t "~d   " 741) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "apple") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'big) str) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'little) str) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'big)) 'big #t) (string-append "￾" str)))))) (format #t "~d   " 742) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "appλe") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'big) str) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'little) str) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'big)) 'big #t) (string-append "￾" str)))))) (format #t "~d   " 743) (begin (newline) (error 'test "\nfailed" '#t)))
(if (equal? '#t (begin (let ((str "") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'big) str) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'little) str) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'big)) 'big #t) (string-append "￾" str)))))) (format #t "~d   " 744) (begin (newline) (error 'test "\nfailed" '#t)))
