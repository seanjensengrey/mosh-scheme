(if (equal? '#t #t) (format #t "~d   " 1) (error 'test "failed" #t))
(let1 val (source-info '(3)) (if (equal? '("./all-tests.scm" 2) val) (format #t "~d   " 2) (error 'test "failed" '("./all-tests.scm" 2) val)))
(if (equal? '#t (and)) (format #t "~d   " 3) (error 'test "failed" #t))
(if (equal? '3 3) (format #t "~d   " 4) (error 'test "failed" 3))
(if (equal? '4 4) (format #t "~d   " 5) (error 'test "failed" 4))
(if (equal? '#t (if #f #f #t)) (format #t "~d   " 6) (error 'test "failed" #t))
(if (equal? '3 ((lambda (a) 3) 4)) (format #t "~d   " 7) (error 'test "failed" 3))
(if (equal? '7 ((lambda (a) (if 3 7 5)) 6)) (format #t "~d   " 8) (error 'test "failed" 7))
(if (equal? '3 ((lambda () 3))) (format #t "~d   " 9) (error 'test "failed" 3))
(if (equal? '101 ((lambda (a) a) 101)) (format #t "~d   " 10) (error 'test "failed" 101))
(if (equal? '102 (((lambda () (lambda () 102))))) (format #t "~d   " 11) (error 'test "failed" 102))
(if (equal? '102 (((lambda () (lambda (a) 102))) 101)) (format #t "~d   " 12) (error 'test "failed" 102))
(if (equal? '103 (((lambda () (lambda (a) a))) 103)) (format #t "~d   " 13) (error 'test "failed" 103))
(if (equal? '10 (((lambda (a) (lambda () a)) 10))) (format #t "~d   " 14) (error 'test "failed" 10))
(if (equal? '12 ((lambda (a) (set! a 12) a) 2)) (format #t "~d   " 15) (error 'test "failed" 12))
(if (equal? '101 ((lambda (a) ((lambda () (set! a 101)))) '())) (format #t "~d   " 16) (error 'test "failed" 101))
(if (equal? '4 (call/cc (lambda (c) (c 4)))) (format #t "~d   " 17) (error 'test "failed" 4))
(if (equal? '(1 2 3) (receive a (call/cc (lambda (c) (c 1 2 3))) a)) (format #t "~d   " 18) (error 'test "failed" (1 2 3)))
(if (equal? '(1 2) (receive a (call/cc (lambda (c) (c 1 2))) a)) (format #t "~d   " 19) (error 'test "failed" (1 2)))
(if (equal? '(1) (receive a (call/cc (lambda (c) (c 1))) a)) (format #t "~d   " 20) (error 'test "failed" (1)))
(if (equal? '3 ((lambda (cont) (if (call/cc (lambda (c) (set! cont c))) (cont #f) 3)) '())) (format #t "~d   " 21) (error 'test "failed" 3))
(if (equal? '102 ((lambda (cont) (if (call/cc (lambda (c) (set! cont c))) ((lambda () ((lambda () (cont #f))))) 102)) '())) (format #t "~d   " 22) (error 'test "failed" 102))
(if (equal? '5 ((lambda () 3 4 5))) (format #t "~d   " 23) (error 'test "failed" 5))
(if (equal? '#t (number? 3)) (format #t "~d   " 24) (error 'test "failed" #t))
(if (equal? '#f (number? 'a)) (format #t "~d   " 25) (error 'test "failed" #f))
(if (equal? '#f (number? 'a)) (format #t "~d   " 26) (error 'test "failed" #f))
(if (equal? '4 (+ 4)) (format #t "~d   " 27) (error 'test "failed" 4))
(if (equal? '7 (+ 4 3)) (format #t "~d   " 28) (error 'test "failed" 7))
(if (equal? '17 (+ 4 3 10)) (format #t "~d   " 29) (error 'test "failed" 17))
(if (equal? '4 (+ 1 1 1 1)) (format #t "~d   " 30) (error 'test "failed" 4))
(if (equal? '5 (- 10 5)) (format #t "~d   " 31) (error 'test "failed" 5))
(if (equal? '3 (- 10 5 2)) (format #t "~d   " 32) (error 'test "failed" 3))
(if (equal? '(a . b) (cons 'a 'b)) (format #t "~d   " 33) (error 'test "failed" (a . b)))
(if (equal? '2 (car (cons 2 3))) (format #t "~d   " 34) (error 'test "failed" 2))
(if (equal? '3 (cdr (cons 2 3))) (format #t "~d   " 35) (error 'test "failed" 3))
(if (equal? '3 (cadr (cons 2 (cons 3 '())))) (format #t "~d   " 36) (error 'test "failed" 3))
(if (equal? '#t (= 3 3)) (format #t "~d   " 37) (error 'test "failed" #t))
(if (equal? '#f (= 3 4)) (format #t "~d   " 38) (error 'test "failed" #f))
(if (equal? '3 (let ((a 3)) a)) (format #t "~d   " 39) (error 'test "failed" 3))
(if (equal? '1 (let ((a 3) (b 1)) b)) (format #t "~d   " 40) (error 'test "failed" 1))
(if (equal? '3 (let ((a 3) (b 1)) a)) (format #t "~d   " 41) (error 'test "failed" 3))
(if (equal? '1 (let ((a 3) (b 1)) a b)) (format #t "~d   " 42) (error 'test "failed" 1))
(if (equal? '3 (let1 a 3 a)) (format #t "~d   " 43) (error 'test "failed" 3))
(if (equal? '4 (let1 a 3 (let1 b 4 b))) (format #t "~d   " 44) (error 'test "failed" 4))
(if (equal? '3 (let1 a 3 (let1 b 4 a))) (format #t "~d   " 45) (error 'test "failed" 3))
(if (equal? '7 (let1 a 3 (let1 b 4 (+ a b)))) (format #t "~d   " 46) (error 'test "failed" 7))
(if (equal? '12 (let1 a 3 (let1 b 4 (let1 c 5 (+ a b c))))) (format #t "~d   " 47) (error 'test "failed" 12))
(if (equal? '12 (let ((a 3) (b 4)) (let1 c 5 (+ a b c)))) (format #t "~d   " 48) (error 'test "failed" 12))
(if (equal? '13 (let ((a 3) (b 4)) (+ (let1 c 5 (+ a b c)) 1))) (format #t "~d   " 49) (error 'test "failed" 13))
(if (equal? '4 (let1 a 3 (let1 a 4 a))) (format #t "~d   " 50) (error 'test "failed" 4))
(if (equal? '5 (let1 a 3 (set! a (+ a 1)) (+ a 1))) (format #t "~d   " 51) (error 'test "failed" 5))
(if (equal? '3 (let1 a 3 (let1 b 4 (set! b a) b))) (format #t "~d   " 52) (error 'test "failed" 3))
(if (equal? '2 (let ((a 2) (b 3)) a)) (format #t "~d   " 53) (error 'test "failed" 2))
(if (equal? '2 (let ((a 0) (b 1) (c 2)) c)) (format #t "~d   " 54) (error 'test "failed" 2))
(if (equal? '4 (let1 a 1 (let1 b 2 (let1 c a (+ a b c))))) (format #t "~d   " 55) (error 'test "failed" 4))
(if (equal? '3 (let ((a 3)) a)) (format #t "~d   " 56) (error 'test "failed" 3))
(if (equal? '7 (let ((a 3) (b 4)) (+ a b))) (format #t "~d   " 57) (error 'test "failed" 7))
(if (equal? '4 (let* ((a 3) (b (+ a 1))) b)) (format #t "~d   " 58) (error 'test "failed" 4))
(if (equal? '4 (let1 a 3 (let1 b 4 (let1 c (lambda () b) (set! a c))) (a))) (format #t "~d   " 59) (error 'test "failed" 4))
(if (equal? '1 (let ((a 0) (b 1)) (let ((c (lambda () b))) (c)))) (format #t "~d   " 60) (error 'test "failed" 1))
(if (equal? '1 (let ((a 0) (b 1)) ((lambda () b)))) (format #t "~d   " 61) (error 'test "failed" 1))
(if (equal? '3 (let ((a 0) (b 1)) (let ((c (lambda () (set! b 3) b))) (c)))) (format #t "~d   " 62) (error 'test "failed" 3))
(if (equal? '3 (let ((a 0) (b 1)) (let1 c (lambda () (set! b 3) b) (c)))) (format #t "~d   " 63) (error 'test "failed" 3))
(if (equal? '100 (let1 a 100 (let1 c (let1 d (lambda () a) d) (c)))) (format #t "~d   " 64) (error 'test "failed" 100))
(if (equal? '1000 (let ((a '())) (let ((G68 (lambda (i) (if (>= i 1000) i (a (+ i 1)))))) (set! a G68) (a 0)))) (format #t "~d   " 65) (error 'test "failed" 1000))
(if (equal? '1000 (letrec ((a (lambda (i) (if (>= i 1000) i (a (+ i 1)))))) (a 0))) (format #t "~d   " 66) (error 'test "failed" 1000))
(if (equal? '1 (letrec ((a 1) (b (lambda () a))) (b))) (format #t "~d   " 67) (error 'test "failed" 1))
(if (equal? '(#t . #f) (letrec ((even? (lambda (n) (if (= 0 n) #t (odd? (- n 1))))) (odd? (lambda (n) (if (= 0 n) #f (even? (- n 1)))))) (cons (even? 88) (odd? 88)))) (format #t "~d   " 68) (error 'test "failed" (#t . #f)))
(if (equal? '10 (letrec ((a (lambda (i) (if (= i 10) i (a (+ i 1)))))) (a 0))) (format #t "~d   " 69) (error 'test "failed" 10))
(if (equal? '1000 ((lambda (a) (set! a 1000) a) '())) (format #t "~d   " 70) (error 'test "failed" 1000))
(if (equal? '20 ((lambda (a) (set! a (lambda (i) (if (= i 20) i (a (+ i 1))))) (a 0)) '())) (format #t "~d   " 71) (error 'test "failed" 20))
(if (equal? '3 (or #f 3 4)) (format #t "~d   " 72) (error 'test "failed" 3))
(if (equal? '3 (define a 3)) (format #t "~d   " 73) (error 'test "failed" 3))
(if (equal? '3 a) (format #t "~d   " 74) (error 'test "failed" 3))
(if (equal? '#f (= 3 4)) (format #t "~d   " 75) (error 'test "failed" #f))
(if (equal? '#t (= 3 3 3)) (format #t "~d   " 76) (error 'test "failed" #t))
(if (equal? '#f (= 3 4 5)) (format #t "~d   " 77) (error 'test "failed" #f))
(if (equal? '101 (((lambda (a) (lambda () a)) 101))) (format #t "~d   " 78) (error 'test "failed" 101))
(if (equal? '102 (((lambda (a) (lambda (b) (+ a b))) 101) 1)) (format #t "~d   " 79) (error 'test "failed" 102))
(if (equal? '#t (null? '())) (format #t "~d   " 80) (error 'test "failed" #t))
(if (equal? '#f (null? 3)) (format #t "~d   " 81) (error 'test "failed" #f))
(if (equal? '(1 . 2) (cons 1 2)) (format #t "~d   " 82) (error 'test "failed" (1 . 2)))
(if (equal? '(1 2) (cons 1 (cons 2 '()))) (format #t "~d   " 83) (error 'test "failed" (1 2)))
(if (equal? '3 (begin 1 2 3)) (format #t "~d   " 84) (error 'test "failed" 3))
(if (equal? '4 ((lambda () (set! a 4) a))) (format #t "~d   " 85) (error 'test "failed" 4))
(if (equal? '3 ((lambda () ((lambda () 3))))) (format #t "~d   " 86) (error 'test "failed" 3))
(if (equal? '3 ((lambda () ((lambda (x) x) 3)))) (format #t "~d   " 87) (error 'test "failed" 3))
(if (equal? '3 ((lambda (y) ((lambda (x) x) 3)) 4)) (format #t "~d   " 88) (error 'test "failed" 3))
(if (equal? '3 ((lambda () (let1 a 1 ((lambda () 3)))))) (format #t "~d   " 89) (error 'test "failed" 3))
(if (equal? '3 ((lambda () (let1 b 2 (let1 a 1 ((lambda () 3))))))) (format #t "~d   " 90) (error 'test "failed" 3))
(if (equal? '3 ((lambda () (if 3 ((lambda () 3)))))) (format #t "~d   " 91) (error 'test "failed" 3))
(if (equal? '4 ((lambda () (if ((lambda () 3)) 4 5)))) (format #t "~d   " 92) (error 'test "failed" 4))
(if (equal? '10 (let loop ((i 0)) (if (= i 10) i (let1 a 1 (let1 b 0 (loop (+ i a b))))))) (format #t "~d   " 93) (error 'test "failed" 10))
(if (equal? '10 (let loop ((i 0)) (if (= i 10) i (let1 a 1 (let1 b 0 (loop (+ i a b))))))) (format #t "~d   " 94) (error 'test "failed" 10))
(if (equal? '6 ((lambda () (define d (lambda (x y z) (+ x y z))) (d 1 2 3)))) (format #t "~d   " 95) (error 'test "failed" 6))
(if (equal? '3 ((lambda () (define b (lambda () 3)) (b)))) (format #t "~d   " 96) (error 'test "failed" 3))
(if (equal? '3 (apply car '((3 2)))) (format #t "~d   " 97) (error 'test "failed" 3))
(if (equal? '(1 2 3) ((lambda a a) 1 2 3)) (format #t "~d   " 98) (error 'test "failed" (1 2 3)))
(if (equal? '(2 3) ((lambda (a . b) b) 1 2 3)) (format #t "~d   " 99) (error 'test "failed" (2 3)))
(if (equal? '(2 3 4) ((lambda (a . b) b) 1 2 3 4)) (format #t "~d   " 100) (error 'test "failed" (2 3 4)))
(if (equal? '(3 4) ((lambda (a b . c) c) 1 2 3 4)) (format #t "~d   " 101) (error 'test "failed" (3 4)))
(if (equal? '(4) ((lambda (a b c . d) d) 1 2 3 4)) (format #t "~d   " 102) (error 'test "failed" (4)))
(if (equal? '() ((lambda (a b c . d) d) 1 2 3)) (format #t "~d   " 103) (error 'test "failed" ()))
(if (equal? '() ((lambda a a))) (format #t "~d   " 104) (error 'test "failed" ()))
(if (equal? '(1) ((lambda a a) 1)) (format #t "~d   " 105) (error 'test "failed" (1)))
(if (equal? '34 (when #t 1 2 34)) (format #t "~d   " 106) (error 'test "failed" 34))
(if (equal? '#f (not 3)) (format #t "~d   " 107) (error 'test "failed" #f))
(if (equal? '48 (unless #f 1 2 48)) (format #t "~d   " 108) (error 'test "failed" 48))
(if (equal? '5 (and 3 4 5)) (format #t "~d   " 109) (error 'test "failed" 5))
(if (equal? '1 (let1 a 0 (and (set! a (+ a 1))) a)) (format #t "~d   " 110) (error 'test "failed" 1))
(if (equal? '1 (let1 a 0 (or (set! a (+ a 1))) a)) (format #t "~d   " 111) (error 'test "failed" 1))
(if (equal? '#f (and 3 #f 5)) (format #t "~d   " 112) (error 'test "failed" #f))
(if (equal? '3 (or 3 4 5)) (format #t "~d   " 113) (error 'test "failed" 3))
(if (equal? '#f (or #f #f #f)) (format #t "~d   " 114) (error 'test "failed" #f))
(if (equal? '#t (> 4 3)) (format #t "~d   " 115) (error 'test "failed" #t))
(if (equal? '#t (> 4 3 2)) (format #t "~d   " 116) (error 'test "failed" #t))
(if (equal? '#f (> 4 3 1 2)) (format #t "~d   " 117) (error 'test "failed" #f))
(if (equal? '#t (>= 3 3 3)) (format #t "~d   " 118) (error 'test "failed" #t))
(if (equal? '#t (>= 4 3 3)) (format #t "~d   " 119) (error 'test "failed" #t))
(if (equal? '#t (>= 4 3)) (format #t "~d   " 120) (error 'test "failed" #t))
(if (equal? '#t (< 1 2)) (format #t "~d   " 121) (error 'test "failed" #t))
(if (equal? '#t (< 1 2 3)) (format #t "~d   " 122) (error 'test "failed" #t))
(if (equal? '#f (< 1 5 3)) (format #t "~d   " 123) (error 'test "failed" #f))
(if (equal? '#t (<= 1 2)) (format #t "~d   " 124) (error 'test "failed" #t))
(if (equal? '#t (<= 1 2 3)) (format #t "~d   " 125) (error 'test "failed" #t))
(if (equal? '#t (<= 1 3 3)) (format #t "~d   " 126) (error 'test "failed" #t))
(if (equal? '#f (<= 1 5 3)) (format #t "~d   " 127) (error 'test "failed" #f))
(if (equal? '#t (eq? #t #t)) (format #t "~d   " 128) (error 'test "failed" #t))
(if (equal? '#f (eq? #t #f)) (format #t "~d   " 129) (error 'test "failed" #f))
(if (equal? '#t (eq? 'a 'a)) (format #t "~d   " 130) (error 'test "failed" #t))
(if (equal? '#f (eq? 'a 'b)) (format #t "~d   " 131) (error 'test "failed" #f))
(if (equal? '#t (pair? (cons 1 2))) (format #t "~d   " 132) (error 'test "failed" #t))
(if (equal? '#f (pair? 3)) (format #t "~d   " 133) (error 'test "failed" #f))
(if (equal? '#t (symbol? 'a)) (format #t "~d   " 134) (error 'test "failed" #t))
(if (equal? '#f (symbol? 3)) (format #t "~d   " 135) (error 'test "failed" #f))
(if (equal? '3 (cond (#f 1) (#t 3))) (format #t "~d   " 136) (error 'test "failed" 3))
(if (equal? '3 (cond (#f 1) (#f 2) (else 3))) (format #t "~d   " 137) (error 'test "failed" 3))
(if (equal? '3 (cond (#t 3) (#f 2) (else 1))) (format #t "~d   " 138) (error 'test "failed" 3))
(if (equal? '1 (cond ((cons 1 2) => car) (#f 2) (else 3))) (format #t "~d   " 139) (error 'test "failed" 1))
(if (equal? '3 (apply (lambda (a) a) '(3))) (format #t "~d   " 140) (error 'test "failed" 3))
(if (equal? '7 (apply (lambda (a b) (+ a b)) '(5 2))) (format #t "~d   " 141) (error 'test "failed" 7))
(if (equal? '8 (apply (lambda (a b c) (+ a b c)) '(5 2 1))) (format #t "~d   " 142) (error 'test "failed" 8))
(if (equal? '(0 b c) (let ((a 0)) `(,a b c))) (format #t "~d   " 143) (error 'test "failed" (0 b c)))
(if (equal? '((1 2 3) b c) (let ((a '(1 2 3))) `(,a b c))) (format #t "~d   " 144) (error 'test "failed" ((1 2 3) b c)))
(if (equal? '(1 2 3 b c) (let ((a '(1 2 3))) `(,@a b c))) (format #t "~d   " 145) (error 'test "failed" (1 2 3 b c)))
(if (equal? '(list a 'a) (let ((name 'a)) `(list ,name ',name))) (format #t "~d   " 146) (error 'test "failed" (list a 'a)))
(if (equal? '(list 3 4) `(list ,(+ 1 2) 4)) (format #t "~d   " 147) (error 'test "failed" (list 3 4)))
(if (equal? '(1 1 2 3) (let ((a '(1 2 3))) `(1 unquote a))) (format #t "~d   " 148) (error 'test "failed" (1 1 2 3)))
(if (equal? '(1 2 3) (let ((a '(1 2 3))) `,a)) (format #t "~d   " 149) (error 'test "failed" (1 2 3)))
(if (equal? '(1 2 3) (let ((a '(1 2 3))) `(,@a))) (format #t "~d   " 150) (error 'test "failed" (1 2 3)))
(if (equal? '(0 1 2 3) (let ((a '(1 2 3))) `(0 ,@a))) (format #t "~d   " 151) (error 'test "failed" (0 1 2 3)))
(if (equal? '(0 (1 2 3) 4) (let ((a '(1 2 3))) `(0 ,a 4))) (format #t "~d   " 152) (error 'test "failed" (0 (1 2 3) 4)))
(if (equal? '(1 2 3 4) (let ((a '(1 2 3))) `(,@a 4))) (format #t "~d   " 153) (error 'test "failed" (1 2 3 4)))
(if (equal? '((1 2 3) 4) (let ((a '(1 2 3))) `((,@a) 4))) (format #t "~d   " 154) (error 'test "failed" ((1 2 3) 4)))
(if (equal? '(((1 2 3)) 4) (let ((a '(1 2 3))) `((,a) 4))) (format #t "~d   " 155) (error 'test "failed" (((1 2 3)) 4)))
(if (equal? 'b `b) (format #t "~d   " 156) (error 'test "failed" b))
(if (equal? '(1 2 3) (list 1 2 3)) (format #t "~d   " 157) (error 'test "failed" (1 2 3)))
(if (equal? '3 (aif (+ 1 2) it #f)) (format #t "~d   " 158) (error 'test "failed" 3))
(if (equal? '3 (string-length "abc")) (format #t "~d   " 159) (error 'test "failed" 3))
(if (equal? '3 (string-length "あいう")) (format #t "~d   " 160) (error 'test "failed" 3))
(if (equal? 'abc (string->symbol "abc")) (format #t "~d   " 161) (error 'test "failed" abc))
(if (equal? '"123" (number->string 123)) (format #t "~d   " 162) (error 'test "failed" "123"))
(if (equal? '(1 2 3 4) (begin (define (proc1 . a) a) (proc1 1 2 3 4))) (format #t "~d   " 163) (error 'test "failed" (1 2 3 4)))
(if (equal? '(2 3) ((lambda (a . b) b) 1 2 3)) (format #t "~d   " 164) (error 'test "failed" (2 3)))
(if (equal? '1 ((lambda (a . b) a) 1 2 3 4 5)) (format #t "~d   " 165) (error 'test "failed" 1))
(if (equal? '(2 3 4 5) ((lambda (a . b) b) 1 2 3 4 5)) (format #t "~d   " 166) (error 'test "failed" (2 3 4 5)))
(if (equal? '() ((lambda (a b c d . e) e) 1 2 3 4)) (format #t "~d   " 167) (error 'test "failed" ()))
(if (equal? '1 ((lambda (a b c d . e) a) 1 2 3 4)) (format #t "~d   " 168) (error 'test "failed" 1))
(if (equal? '2 ((lambda (a b c d . e) b) 1 2 3 4)) (format #t "~d   " 169) (error 'test "failed" 2))
(if (equal? '3 ((lambda (a b c d . e) c) 1 2 3 4)) (format #t "~d   " 170) (error 'test "failed" 3))
(if (equal? '4 ((lambda (a b c d . e) d) 1 2 3 4)) (format #t "~d   " 171) (error 'test "failed" 4))
(if (equal? '(1 2 3 4) (append '(1 2) '(3 4))) (format #t "~d   " 172) (error 'test "failed" (1 2 3 4)))
(if (equal? '3 (begin (define x 3) x)) (format #t "~d   " 173) (error 'test "failed" 3))
(if (equal? '(1 2 3) (begin (define (hoge . a) a) (hoge 1 2 3))) (format #t "~d   " 174) (error 'test "failed" (1 2 3)))
(if (equal? '(2 3) (begin (define (hige a . b) b) (hige 1 2 3))) (format #t "~d   " 175) (error 'test "failed" (2 3)))
(if (equal? '(3 2) (apply (lambda a a) '(3 2))) (format #t "~d   " 176) (error 'test "failed" (3 2)))
(if (equal? '#t (equal? '(1 2 (3)) '(1 2 (3)))) (format #t "~d   " 177) (error 'test "failed" #t))
(if (equal? '1 (let ((a 3)) 3 2 1)) (format #t "~d   " 178) (error 'test "failed" 1))
(if (equal? '"   " (make-string 3)) (format #t "~d   " 179) (error 'test "failed" "   "))
(if (equal? '"ccc" (make-string 3 #\c)) (format #t "~d   " 180) (error 'test "failed" "ccc"))
(if (equal? '3 (apply car '((3)))) (format #t "~d   " 181) (error 'test "failed" 3))
(if (equal? '3 (apply (lambda (a) (car a)) '((3)))) (format #t "~d   " 182) (error 'test "failed" 3))
(if (equal? '3 (apply (lambda (a . b) (+ a (car b))) '(1 2))) (format #t "~d   " 183) (error 'test "failed" 3))
(if (equal? '"123456" (string-append "12" "345" "6")) (format #t "~d   " 184) (error 'test "failed" "123456"))
(if (equal? '3 (find (lambda (e) (= e 3)) (list 1 2 3))) (format #t "~d   " 185) (error 'test "failed" 3))
(if (equal? '#t (string? "hige")) (format #t "~d   " 186) (error 'test "failed" #t))
(if (equal? '("key" "value") (assoc "key" '(("key" "value")))) (format #t "~d   " 187) (error 'test "failed" ("key" "value")))
(if (equal? '("12" "34" "56") (string-split "12\n34\n56" #\newline)) (format #t "~d   " 188) (error 'test "failed" ("12" "34" "56")))
(if (equal? '#\2 (let ((p (open-string-input-port "12345"))) (read-char p) (read-char p))) (format #t "~d   " 189) (error 'test "failed" #\2))
(if (equal? '#t (eof-object? (let ((p (open-string-input-port "1"))) (read-char p) (read-char p)))) (format #t "~d   " 190) (error 'test "failed" #t))
(if (equal? '123 (let ((p (open-string-input-port "123 456"))) (read p))) (format #t "~d   " 191) (error 'test "failed" 123))
(if (equal? '#f (rxmatch #/123/ "12")) (format #t "~d   " 192) (error 'test "failed" #f))
(if (equal? '#t (if (rxmatch #/123/ "123") #t #f)) (format #t "~d   " 193) (error 'test "failed" #t))
(if (equal? '#t (regexp? #/abc/)) (format #t "~d   " 194) (error 'test "failed" #t))
(if (equal? '#f (regexp? "abc")) (format #t "~d   " 195) (error 'test "failed" #f))
(if (equal? '1 (rxmatch-start (rxmatch #/\d+/ "a345a"))) (format #t "~d   " 196) (error 'test "failed" 1))
(if (equal? '2 (rxmatch-start (rxmatch #/\d+/ "ab345a"))) (format #t "~d   " 197) (error 'test "failed" 2))
(if (equal? '3 (rxmatch-start (rxmatch #/\d+/ "abあ345a"))) (format #t "~d   " 198) (error 'test "failed" 3))
(if (equal? '1 (rxmatch-start (rxmatch #/(\d+)(a)/ "a345a") 1)) (format #t "~d   " 199) (error 'test "failed" 1))
(if (equal? '4 (rxmatch-start (rxmatch #/(\d+)(a)/ "a345a") 2)) (format #t "~d   " 200) (error 'test "failed" 4))
(if (equal? '4 (rxmatch-end (rxmatch #/\d+/ "a345a"))) (format #t "~d   " 201) (error 'test "failed" 4))
(if (equal? '4 (rxmatch-end (rxmatch #/(\d+)(a)/ "a345a") 1)) (format #t "~d   " 202) (error 'test "failed" 4))
(if (equal? '5 (rxmatch-end (rxmatch #/(\d+)(a)/ "a345a") 2)) (format #t "~d   " 203) (error 'test "failed" 5))
(if (equal? '#f (rxmatch-end (rxmatch #/\d+/ "aaaa"))) (format #t "~d   " 204) (error 'test "failed" #f))
(if (equal? '#f (#/123/ "12")) (format #t "~d   " 205) (error 'test "failed" #f))
(if (equal? '1 (rxmatch-start (#/\d+/ "a345a"))) (format #t "~d   " 206) (error 'test "failed" 1))
(if (equal? '2 (rxmatch-start (#/\d+/ "ab345a"))) (format #t "~d   " 207) (error 'test "failed" 2))
(if (equal? '3 (rxmatch-start (#/\d+/ "abあ345a"))) (format #t "~d   " 208) (error 'test "failed" 3))
(if (equal? '1 (rxmatch-start (#/(\d+)(a)/ "a345a") 1)) (format #t "~d   " 209) (error 'test "failed" 1))
(if (equal? '4 (rxmatch-start (#/(\d+)(a)/ "a345a") 2)) (format #t "~d   " 210) (error 'test "failed" 4))
(if (equal? '"def" (rxmatch-after (#/abc/ "123abcdef"))) (format #t "~d   " 211) (error 'test "failed" "def"))
(if (equal? '"あいうえ" (rxmatch-after (#/abc/ "123abcあいうえ"))) (format #t "~d   " 212) (error 'test "failed" "あいうえ"))
(if (equal? '"あいうえ" (rxmatch-after (#/かきく/ "123かきくあいうえ"))) (format #t "~d   " 213) (error 'test "failed" "あいうえ"))
(if (equal? '"123" (rxmatch-before (#/abc/ "123abcdef"))) (format #t "~d   " 214) (error 'test "failed" "123"))
(if (equal? '"abc" ((#/abc/ "123abcdef") 0)) (format #t "~d   " 215) (error 'test "failed" "abc"))
(if (equal? '"abc" ((#/abc/ "123abcdef"))) (format #t "~d   " 216) (error 'test "failed" "abc"))
(if (equal? '"def" ((#/abc/ "123abcdef") 'after)) (format #t "~d   " 217) (error 'test "failed" "def"))
(if (equal? '"123" ((#/abc/ "123abcdef") 'before)) (format #t "~d   " 218) (error 'test "failed" "123"))
(if (equal? '#f (rxmatch #/123/ "12")) (format #t "~d   " 219) (error 'test "failed" #f))
(if (equal? '#f (#/123/ "12")) (format #t "~d   " 220) (error 'test "failed" #f))
(if (equal? '#t (if (#/^abc/ "abc") #t #f)) (format #t "~d   " 221) (error 'test "failed" #t))
(if (equal? '"abc" (regexp->string #/abc/)) (format #t "~d   " 222) (error 'test "failed" "abc"))
(if (equal? '#f (rxmatch-start (#/\d+/ "aaaa"))) (format #t "~d   " 223) (error 'test "failed" #f))
(if (equal? '4 (rxmatch-end (#/\d+/ "a345a"))) (format #t "~d   " 224) (error 'test "failed" 4))
(if (equal? '4 (rxmatch-end (#/(\d+)(a)/ "a345a") 1)) (format #t "~d   " 225) (error 'test "failed" 4))
(if (equal? '5 (rxmatch-end (#/(\d+)(a)/ "a345a") 2)) (format #t "~d   " 226) (error 'test "failed" 5))
(if (equal? '#f (rxmatch-end (#/\d+/ "aaaa"))) (format #t "~d   " 227) (error 'test "failed" #f))
(if (equal? '#f (rxmatch #/123/ "12")) (format #t "~d   " 228) (error 'test "failed" #f))
(if (equal? '#t (if (rxmatch #/123/ "123") #t #f)) (format #t "~d   " 229) (error 'test "failed" #t))
(if (equal? '#f (#/123/ "12")) (format #t "~d   " 230) (error 'test "failed" #f))
(if (equal? '#t (if (#/^abc/ "abc") #t #f)) (format #t "~d   " 231) (error 'test "failed" #t))
(if (equal? '#t (regexp? #/abc/)) (format #t "~d   " 232) (error 'test "failed" #t))
(if (equal? '#f (regexp? "abc")) (format #t "~d   " 233) (error 'test "failed" #f))
(if (equal? '"abc" (regexp->string #/abc/)) (format #t "~d   " 234) (error 'test "failed" "abc"))
(if (equal? '1 (rxmatch-start (#/\d+/ "a345a"))) (format #t "~d   " 235) (error 'test "failed" 1))
(if (equal? '"345" (rxmatch-substring (#/\d+/ "a345a"))) (format #t "~d   " 236) (error 'test "failed" "345"))
(if (equal? '"345" (rxmatch-substring (#/(\d+)(a)/ "a345a") 1)) (format #t "~d   " 237) (error 'test "failed" "345"))
(if (equal? '"a" (rxmatch-substring (#/(\d+)(a)/ "a345a") 2)) (format #t "~d   " 238) (error 'test "failed" "a"))
(if (equal? '#f (rxmatch-substring (#/\d+/ "aaaa"))) (format #t "~d   " 239) (error 'test "failed" #f))
(if (equal? '"あ" ((#/あ/ "あ"))) (format #t "~d   " 240) (error 'test "failed" "あ"))
(if (equal? '#/abc/ (string->regexp "abc")) (format #t "~d   " 241) (error 'test "failed" #/abc/))
(if (equal? '#f (let1 m (#/^#([^(^)^\s]+)(?:\(([^\)]+)\))?/ "#comment") (m 2))) (format #t "~d   " 242) (error 'test "failed" #f))
(if (equal? 'a (begin (let ((xxx 'a)) (case xxx ((b) 'b) ((a) 'a))))) (format #t "~d   " 243) (error 'test "failed" a))
(if (equal? '3 (begin (let ((xxy 'a)) (case xxy ((b) 'b) ((c) 'c) (else 3))))) (format #t "~d   " 244) (error 'test "failed" 3))
(if (equal? '-1 ((lambda (a) (call/cc (lambda (c) (c -1) 4))) 2)) (format #t "~d   " 245) (error 'test "failed" -1))
(if (equal? '6 (* 2 3)) (format #t "~d   " 246) (error 'test "failed" 6))
(if (equal? '24 (* 2 3 4)) (format #t "~d   " 247) (error 'test "failed" 24))
(if (equal? '4 (call/cc (lambda (c) (c 4)))) (format #t "~d   " 248) (error 'test "failed" 4))
(if (equal? '123 (string->number "123")) (format #t "~d   " 249) (error 'test "failed" 123))
(if (equal? '123 (let ((p (open-string-input-port "123 456"))) (read p))) (format #t "~d   " 250) (error 'test "failed" 123))
(if (equal? '#\1 (let ((p (open-string-input-port "123 456"))) (read-char p))) (format #t "~d   " 251) (error 'test "failed" #\1))
(if (equal? '(4 3 2 1) (reverse '(1 2 3 4))) (format #t "~d   " 252) (error 'test "failed" (4 3 2 1)))
(if (equal? '("wiki" "cmd") (string-split "wiki&cmd" #\&)) (format #t "~d   " 253) (error 'test "failed" ("wiki" "cmd")))
(if (equal? '"cbc" (begin (define str1 (make-string 3 #\c)) (string-set! str1 1 #\b) str1)) (format #t "~d   " 254) (error 'test "failed" "cbc"))
(if (equal? '-1 ((lambda (a) (call/cc (lambda (c) (c -1)))) 2)) (format #t "~d   " 255) (error 'test "failed" -1))
(if (equal? '2 (let* ((a 0) (b (lambda (x y) a))) (b (begin (set! a 1)) (begin (set! a 2))))) (format #t "~d   " 256) (error 'test "failed" 2))
(if (equal? '#\a #\a) (format #t "~d   " 257) (error 'test "failed" #\a))
(if (equal? '#f (eof-object? 3)) (format #t "~d   " 258) (error 'test "failed" #f))
(if (equal? '101 101) (format #t "~d   " 259) (error 'test "failed" 101))
(if (equal? '4 (define val 3) (define (func8) (define val 4) val) (func8)) (format #t "~d   " 260) (error 'test "failed" 4))
(if (equal? '(1 . 3) ((lambda () (define p (cons 1 2)) (set-cdr! p 3) p))) (format #t "~d   " 261) (error 'test "failed" (1 . 3)))
(if (equal? '(3 . 2) ((lambda () (define q (cons 1 2)) (set-car! q 3) q))) (format #t "~d   " 262) (error 'test "failed" (3 . 2)))
(if (equal? '#t (begin (display "test done") #t)) (format #t "~d   " 263) (error 'test "failed" #t))
(if (equal? '3 (vector-length (make-vector 3))) (format #t "~d   " 264) (error 'test "failed" 3))
(if (equal? '101 (let loop ((i 0)) (if (= i 100) (+ i 1) (loop (+ i 1))))) (format #t "~d   " 265) (error 'test "failed" 101))
(if (equal? '3 ((lambda (cont) (if (call/cc (lambda (c) (set! cont c))) (cont #f) 3)) '())) (format #t "~d   " 266) (error 'test "failed" 3))
(if (equal? '102 ((lambda (cont) (if (call/cc (lambda (c) (set! cont c))) ((lambda () ((lambda () (cont #f))))) 102)) '())) (format #t "~d   " 267) (error 'test "failed" 102))
(if (equal? '2 (let ((a 0)) (cond (#t (set! a (+ a 1)) (set! a (+ a 1)) a)))) (format #t "~d   " 268) (error 'test "failed" 2))
(if (equal? '#t (char? #\あ)) (format #t "~d   " 269) (error 'test "failed" #t))
(if (equal? '#f (eq? (list 'a) (list 'a))) (format #t "~d   " 270) (error 'test "failed" #f))
(if (equal? '#t (let ((x (list 'a))) (eq? x x))) (format #t "~d   " 271) (error 'test "failed" #t))
(if (equal? '("ABC123" "DEF123") (map1 (lambda (s) (string-append s "123")) '("ABC" "DEF"))) (format #t "~d   " 272) (error 'test "failed" ("ABC123" "DEF123")))
(if (equal? '("ABC123" "DEF123") (map (lambda (s) (string-append s "123")) '("ABC" "DEF"))) (format #t "~d   " 273) (error 'test "failed" ("ABC123" "DEF123")))
(if (equal? '("ABCGHI" "DEFJKL") (map (lambda (a b) (string-append a b)) '("ABC" "DEF") '("GHI" "JKL"))) (format #t "~d   " 274) (error 'test "failed" ("ABCGHI" "DEFJKL")))
(if (equal? '(4 10 18) (map (lambda (a b) (* a b)) '(1 2 3) '(4 5 6))) (format #t "~d   " 275) (error 'test "failed" (4 10 18)))
(if (equal? '10000 (let1 a '() (let1 G68 (lambda (i) (if (>= i 10000) i (a (+ i 1)))) (set! a G68) (a 0)))) (format #t "~d   " 276) (error 'test "failed" 10000))
(if (equal? '(list 3 4) `(list ,(+ 1 2) 4)) (format #t "~d   " 277) (error 'test "failed" (list 3 4)))
(if (equal? '(list a 'a) (let ((name 'a)) `(list ,name ',name))) (format #t "~d   " 278) (error 'test "failed" (list a 'a)))
(if (equal? '(a 3 4 5 6 b) `(a ,(+ 1 2) ,@(map abs '(4 -5 6)) b)) (format #t "~d   " 279) (error 'test "failed" (a 3 4 5 6 b)))
(if (equal? '#t (vector? #(3))) (format #t "~d   " 280) (error 'test "failed" #t))
(if (equal? '3 (begin (define (proc-01) 3) (proc-01))) (format #t "~d   " 281) (error 'test "failed" 3))
(if (equal? '3 (begin (define (add3 a b) (+ a b)) (add3 1 2))) (format #t "~d   " 282) (error 'test "failed" 3))
(if (equal? '3 (begin (define add2 (lambda (a b) (+ a b))) (add2 1 2))) (format #t "~d   " 283) (error 'test "failed" 3))
(if (equal? '3 (begin (define z (make-vector 2)) (vector-set! z 0 1) (vector-set! z 1 2) (make-vector 3) (null? 3) (vector-set! z 1 3) (vector-ref z 1))) (format #t "~d   " 284) (error 'test "failed" 3))
(if (equal? '3 (begin (define (proc-2) (define (rec) 3) (rec)) (proc-2))) (format #t "~d   " 285) (error 'test "failed" 3))
(if (equal? '4 (begin (define (func2) (define val 4) val) (func2))) (format #t "~d   " 286) (error 'test "failed" 4))
(if (equal? '#t (if (values 1 2 3) #t #f)) (format #t "~d   " 287) (error 'test "failed" #t))
(if (equal? '5 (call-with-values (lambda () (values 4 5)) (lambda (a b) b))) (format #t "~d   " 288) (error 'test "failed" 5))
(if (equal? '6 (call-with-values (lambda () (values 1 2 3)) (lambda (a b c) (+ a b c)))) (format #t "~d   " 289) (error 'test "failed" 6))
(if (equal? '(1 2 3) (call-with-values (lambda () (values 1 2 3)) list)) (format #t "~d   " 290) (error 'test "failed" (1 2 3)))
(if (equal? '1235 (call-with-values (lambda () 1) (lambda (x) (+ x 1234)))) (format #t "~d   " 291) (error 'test "failed" 1235))
(let1 val (receive (a b c) (values 1 2 3) (+ a b c)) (if (equal? '6 val) (format #t "~d   " 292) (error 'test "failed" '6 val)))
(let1 val (receive z (values 'x 'y) z) (if (equal? '(x y) val) (format #t "~d   " 293) (error 'test "failed" '(x y) val)))
(let1 val (receive (a . b) (values 'x 'y 'z) b) (if (equal? '(y z) val) (format #t "~d   " 294) (error 'test "failed" '(y z) val)))
(let1 val (receive (a . b) (values 'x 'y 'z) a) (if (equal? 'x val) (format #t "~d   " 295) (error 'test "failed" 'x val)))
(let1 val (receive x (apply values '(1 2 3)) x) (if (equal? '(1 2 3) val) (format #t "~d   " 296) (error 'test "failed" '(1 2 3) val)))
(let1 val (call-with-values (lambda () (values 1 2)) cons) (if (equal? '(1 . 2) val) (format #t "~d   " 297) (error 'test "failed" '(1 . 2) val)))
(let1 val (receive (port proc) (open-string-output-port) (display "hige" port) (display "pon" port) (proc)) (if (equal? '"higepon" val) (format #t "~d   " 298) (error 'test "failed" '"higepon" val)))
(if (equal? '"\"string\"" (call-with-string-output-port (lambda (port) (write "string" port)))) (format #t "~d   " 299) (error 'test "failed" "\"string\""))
(if (equal? '"123ABC456" (regexp-replace #/abc/ "123abc456" "ABC")) (format #t "~d   " 300) (error 'test "failed" "123ABC456"))
(if (equal? '(a) (cons 'a '())) (format #t "~d   " 301) (error 'test "failed" (a)))
(if (equal? '((a) b c d) (cons '(a) '(b c d))) (format #t "~d   " 302) (error 'test "failed" ((a) b c d)))
(if (equal? '("a" b c) (cons "a" '(b c))) (format #t "~d   " 303) (error 'test "failed" ("a" b c)))
(if (equal? '(a . 3) (cons 'a 3)) (format #t "~d   " 304) (error 'test "failed" (a . 3)))
(if (equal? '((a b) . c) (cons '(a b) 'c)) (format #t "~d   " 305) (error 'test "failed" ((a b) . c)))
(if (equal? 'a (car '(a b c))) (format #t "~d   " 306) (error 'test "failed" a))
(if (equal? '(a) (car '((a) b c d))) (format #t "~d   " 307) (error 'test "failed" (a)))
(if (equal? '1 (car '(1 . 2))) (format #t "~d   " 308) (error 'test "failed" 1))
(if (equal? '(b c d) (cdr '((a) b c d))) (format #t "~d   " 309) (error 'test "failed" (b c d)))
(if (equal? '2 (cdr '(1 . 2))) (format #t "~d   " 310) (error 'test "failed" 2))
(if (equal? '(c b a) (reverse '(a b c))) (format #t "~d   " 311) (error 'test "failed" (c b a)))
(if (equal? '((e (f)) d (b c) a) (reverse '(a (b c) d (e (f))))) (format #t "~d   " 312) (error 'test "failed" ((e (f)) d (b c) a)))
(if (equal? '#t (equal? 'a 'a)) (format #t "~d   " 313) (error 'test "failed" #t))
(if (equal? '#t (equal? '(a) '(a))) (format #t "~d   " 314) (error 'test "failed" #t))
(if (equal? '#t (equal? '(a (b) c) '(a (b) c))) (format #t "~d   " 315) (error 'test "failed" #t))
(if (equal? '#t (equal? "abc" "abc")) (format #t "~d   " 316) (error 'test "failed" #t))
(if (equal? '#t (equal? 2 2)) (format #t "~d   " 317) (error 'test "failed" #t))
(if (equal? '#t (equal? (make-vector 5 'a) (make-vector 5 'a))) (format #t "~d   " 318) (error 'test "failed" #t))
(if (equal? '#t (eq? 'a 'a)) (format #t "~d   " 319) (error 'test "failed" #t))
(if (equal? '#f (eq? '(a) '(a))) (format #t "~d   " 320) (error 'test "failed" #f))
(let1 val (eq? (list 'a) (list 'a)) (if (equal? '#f val) (format #t "~d   " 321) (error 'test "failed" '#f val)))
(if (equal? '#f (eq? "a" "a")) (format #t "~d   " 322) (error 'test "failed" #f))
(if (equal? '#f (eq? "" "")) (format #t "~d   " 323) (error 'test "failed" #f))
(if (equal? '#t (eq? '() '())) (format #t "~d   " 324) (error 'test "failed" #t))
(if (equal? '#t (eq? 2 2)) (format #t "~d   " 325) (error 'test "failed" #t))
(if (equal? '#t (eq? #\A #\A)) (format #t "~d   " 326) (error 'test "failed" #t))
(if (equal? '#t (eq? car car)) (format #t "~d   " 327) (error 'test "failed" #t))
(if (equal? '#t (let ((n (+ 2 3))) (eq? n n))) (format #t "~d   " 328) (error 'test "failed" #t))
(if (equal? '#t (let ((x '(a))) (eq? x x))) (format #t "~d   " 329) (error 'test "failed" #t))
(if (equal? '#t (let ((x '#())) (eq? x x))) (format #t "~d   " 330) (error 'test "failed" #t))
(if (equal? '#t (let ((p (lambda (x) x))) (eq? p p))) (format #t "~d   " 331) (error 'test "failed" #t))
(if (equal? '-1 (- 3 4)) (format #t "~d   " 332) (error 'test "failed" -1))
(if (equal? '-6 (- 3 4 5)) (format #t "~d   " 333) (error 'test "failed" -6))
(if (equal? '-3 (- 3)) (format #t "~d   " 334) (error 'test "failed" -3))
(if (equal? 'greater (cond ((> 3 2) 'greater) ((< 3 2) 'less))) (format #t "~d   " 335) (error 'test "failed" greater))
(if (equal? 'equal (cond ((> 3 3) 'greater) ((< 3 3) 'less) (else 'equal))) (format #t "~d   " 336) (error 'test "failed" equal))
(if (equal? '2 (cond ('(1 2 3) => cadr) (else #f))) (format #t "~d   " 337) (error 'test "failed" 2))
(let1 val (do ((vec (make-vector 5)) (i 0 (+ i 1))) ((= i 5) vec) (vector-set! vec i i)) (if (equal? '#(0 1 2 3 4) val) (format #t "~d   " 338) (error 'test "failed" '#(0 1 2 3 4) val)))
(let1 val (let ((x '(1 3 5 7 9))) (do ((x x (cdr x)) (sum 0 (+ sum (car x)))) ((null? x) sum))) (if (equal? '25 val) (format #t "~d   " 339) (error 'test "failed" '25 val)))
(if (equal? '#(0 ("Sue" "Sue") "Anna") (let ((vec (vector 0 '(2 2 2 2) "Anna"))) (vector-set! vec 1 '("Sue" "Sue")) vec)) (format #t "~d   " 340) (error 'test "failed" #(0 ("Sue" "Sue") "Anna")))
(if (equal? '8 (vector-ref '#(1 1 2 3 5 8 13 21) 5)) (format #t "~d   " 341) (error 'test "failed" 8))
(if (equal? '#t (or (= 2 2) (> 2 1))) (format #t "~d   " 342) (error 'test "failed" #t))
(if (equal? '#t (or (= 2 2) (< 2 1))) (format #t "~d   " 343) (error 'test "failed" #t))
(if (equal? '#f (or #f #f #f)) (format #t "~d   " 344) (error 'test "failed" #f))
(if (equal? '(b c) (or '(b c) (/ 3 0))) (format #t "~d   " 345) (error 'test "failed" (b c)))
(if (equal? '#f (not #t)) (format #t "~d   " 346) (error 'test "failed" #f))
(if (equal? '#f (not 3)) (format #t "~d   " 347) (error 'test "failed" #f))
(let1 val (not (list 3)) (if (equal? '#f val) (format #t "~d   " 348) (error 'test "failed" '#f val)))
(if (equal? '#t (not #f)) (format #t "~d   " 349) (error 'test "failed" #t))
(if (equal? '#f (not '())) (format #t "~d   " 350) (error 'test "failed" #f))
(let1 val (not (list)) (if (equal? '#f val) (format #t "~d   " 351) (error 'test "failed" '#f val)))
(if (equal? '#f (not 'nil)) (format #t "~d   " 352) (error 'test "failed" #f))
(if (equal? '6 (let ((x 2) (y 3)) (* x y))) (format #t "~d   " 353) (error 'test "failed" 6))
(if (equal? '35 (let ((x 2) (y 3)) (let ((x 7) (z (+ x y))) (* z x)))) (format #t "~d   " 354) (error 'test "failed" 35))
(if (equal? '70 (let ((x 2) (y 3)) (let* ((x 7) (z (+ x y))) (* z x)))) (format #t "~d   " 355) (error 'test "failed" 70))
(if (equal? '#t (eqv? 'a 'a)) (format #t "~d   " 356) (error 'test "failed" #t))
(if (equal? '#f (eqv? 'a 'b)) (format #t "~d   " 357) (error 'test "failed" #f))
(if (equal? '#t (eqv? 2 2)) (format #t "~d   " 358) (error 'test "failed" #t))
(if (equal? '#t (eqv? '() '())) (format #t "~d   " 359) (error 'test "failed" #t))
(if (equal? '#t (eqv? 100000000 100000000)) (format #t "~d   " 360) (error 'test "failed" #t))
(if (equal? '#f (eqv? (cons 1 2) (cons 1 2))) (format #t "~d   " 361) (error 'test "failed" #f))
(if (equal? '#f (eqv? (lambda () 1) (lambda () 2))) (format #t "~d   " 362) (error 'test "failed" #f))
(if (equal? '#f (eqv? #f 'nil)) (format #t "~d   " 363) (error 'test "failed" #f))
(if (equal? '#t (define (foo n) (let loop ((n n)) (cond ((null? n)) (else (loop (cdr n)))))) (and (foo '()) (foo '(1 2 3)))) (format #t "~d   " 364) (error 'test "failed" #t))
(if (equal? '3 (digit->integer #\3 10)) (format #t "~d   " 365) (error 'test "failed" 3))
(if (equal? '0 (+)) (format #t "~d   " 366) (error 'test "failed" 0))
(if (equal? '1 (*)) (format #t "~d   " 367) (error 'test "failed" 1))
(if (equal? '6 (apply (lambda (a b c) (+ a b c)) 1 2 '(3))) (format #t "~d   " 368) (error 'test "failed" 6))
(if (equal? '6 (apply (lambda (a b c) (+ a b c)) '(1 2 3))) (format #t "~d   " 369) (error 'test "failed" 6))
(if (equal? '6 (apply (lambda (a b c) (+ a b c)) 1 '(2 3))) (format #t "~d   " 370) (error 'test "failed" 6))
(if (equal? '(2) (apply (lambda (x y) (apply y '((3 2)))) `(,car ,cdr))) (format #t "~d   " 371) (error 'test "failed" (2)))
(if (equal? '3 (/ 6 2)) (format #t "~d   " 372) (error 'test "failed" 3))
(let1 val (mod 23 10) (if (equal? '3 val) (format #t "~d   " 373) (error 'test "failed" '3 val)))
(let1 val (even? 2) (if (equal? '#t val) (format #t "~d   " 374) (error 'test "failed" '#t val)))
(let1 val (even? 3) (if (equal? '#f val) (format #t "~d   " 375) (error 'test "failed" '#f val)))
(let1 val (for-all even? '(3 1 4 1 5 9)) (if (equal? '#f val) (format #t "~d   " 376) (error 'test "failed" '#f val)))
(let1 val (for-all even? '(3 1 4 1 5 9 . 2)) (if (equal? '#f val) (format #t "~d   " 377) (error 'test "failed" '#f val)))
(let1 val (for-all even? '(2 4 14)) (if (equal? '#t val) (format #t "~d   " 378) (error 'test "failed" '#t val)))
(let1 val (for-all (lambda (a b) (< a b)) '(1 2 3) '(2 3 4)) (if (equal? '#t val) (format #t "~d   " 379) (error 'test "failed" '#t val)))
(let1 val (for-all (lambda (a b) (< a b)) '(1 2 4) '(2 3 4)) (if (equal? '#f val) (format #t "~d   " 380) (error 'test "failed" '#f val)))
(let1 val (+ (/ 2) (/ 4) (/ 4)) (if (equal? '1 val) (format #t "~d   " 381) (error 'test "failed" '1 val)))
(let1 val (- (/ 1 2) (/ 1 4) (/ 1 4)) (if (equal? '0 val) (format #t "~d   " 382) (error 'test "failed" '0 val)))
(let1 val (= (/ 3 2) (+ (/ 1 2) 1)) (if (equal? '#t val) (format #t "~d   " 383) (error 'test "failed" '#t val)))
(let1 val (= (/ 5 2) (+ 1 (/ 1 2) 1)) (if (equal? '#t val) (format #t "~d   " 384) (error 'test "failed" '#t val)))
(let1 val (= (/ 3 2) (- 3 (/ 1 2) 1)) (if (equal? '#t val) (format #t "~d   " 385) (error 'test "failed" '#t val)))
(let1 val (* (/ 3 2) 2) (if (equal? '3 val) (format #t "~d   " 386) (error 'test "failed" '3 val)))
(let1 val (* 2 (/ 3 2)) (if (equal? '3 val) (format #t "~d   " 387) (error 'test "failed" '3 val)))
(let1 val (* (/ 4 2) (/ 3 2)) (if (equal? '3 val) (format #t "~d   " 388) (error 'test "failed" '3 val)))
(let1 val (/ (/ 2 2) (/ 1 2)) (if (equal? '2 val) (format #t "~d   " 389) (error 'test "failed" '2 val)))
(let1 val (/ (/ 4 2) 1) (if (equal? '2 val) (format #t "~d   " 390) (error 'test "failed" '2 val)))
(if (equal? 'error (guard (con (#t 'error)) (/ 1 0))) (format #t "~d   " 391) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (/ 1 (* 0 (/ 1 2))))) (format #t "~d   " 392) (error 'test "failed"))(let1 val (> 1 (/ 1 2)) (if (equal? '#t val) (format #t "~d   " 393) (error 'test "failed" '#t val)))
(let1 val (> (/ 1 2) 1) (if (equal? '#f val) (format #t "~d   " 394) (error 'test "failed" '#f val)))
(let1 val (> 1 (/ 1 2)) (if (equal? '#t val) (format #t "~d   " 395) (error 'test "failed" '#t val)))
(let1 val (> (/ 1 2) (/ 1 3)) (if (equal? '#t val) (format #t "~d   " 396) (error 'test "failed" '#t val)))
(let1 val (<= (/ 1 2) 1) (if (equal? '#t val) (format #t "~d   " 397) (error 'test "failed" '#t val)))
(let1 val (>= 1 (/ 1 2)) (if (equal? '#t val) (format #t "~d   " 398) (error 'test "failed" '#t val)))
(let1 val (>= (/ 1 2) (/ 1 3)) (if (equal? '#t val) (format #t "~d   " 399) (error 'test "failed" '#t val)))
(let1 val (< (/ 1 2) 1) (if (equal? '#t val) (format #t "~d   " 400) (error 'test "failed" '#t val)))
(let1 val (< 1 (/ 1 2)) (if (equal? '#f val) (format #t "~d   " 401) (error 'test "failed" '#f val)))
(let1 val (< (/ 1 2) (/ 1 3)) (if (equal? '#f val) (format #t "~d   " 402) (error 'test "failed" '#f val)))
(let1 val (<= (/ 1 2) 1) (if (equal? '#t val) (format #t "~d   " 403) (error 'test "failed" '#t val)))
(let1 val (<= 1 (/ 1 2)) (if (equal? '#f val) (format #t "~d   " 404) (error 'test "failed" '#f val)))
(let1 val (<= (/ 1 2) (/ 1 3)) (if (equal? '#f val) (format #t "~d   " 405) (error 'test "failed" '#f val)))
(let1 val (= (/ 2 2) 1) (if (equal? '#t val) (format #t "~d   " 406) (error 'test "failed" '#t val)))
(let1 val (= 1 (/ 2 2)) (if (equal? '#t val) (format #t "~d   " 407) (error 'test "failed" '#t val)))
(let1 val (= (/ 1 2) (/ 2 4)) (if (equal? '#t val) (format #t "~d   " 408) (error 'test "failed" '#t val)))
(let1 val (>= (/ 1 2) (inexact (/ 1 3))) (if (equal? '#t val) (format #t "~d   " 409) (error 'test "failed" '#t val)))
(let1 val (> (/ 3 2) (+ (inexact (/ 1 3)) (inexact (/ 1 3)) (inexact (/ 1 3))) (/ 99 100)) (if (equal? '#t val) (format #t "~d   " 410) (error 'test "failed" '#t val)))
(let1 val (> 1 (/ (inexact 98) 100) (/ 97 100)) (if (equal? '#t val) (format #t "~d   " 411) (error 'test "failed" '#t val)))
(let1 val (rational? 3) (if (equal? '#t val) (format #t "~d   " 412) (error 'test "failed" '#t val)))
(let1 val (rational? (/ 1 4)) (if (equal? '#t val) (format #t "~d   " 413) (error 'test "failed" '#t val)))
(let1 val (rational? (/ (/ 1 2) (+ (greatest-fixnum) 1))) (if (equal? '#t val) (format #t "~d   " 414) (error 'test "failed" '#t val)))
(let1 val (flonum? (/ (inexact (/ 1 3)) (+ (greatest-fixnum) 1))) (if (equal? '#t val) (format #t "~d   " 415) (error 'test "failed" '#t val)))
(let1 val (= (/ (+ (greatest-fixnum) 1) 1) (+ (greatest-fixnum) 1)) (if (equal? '#t val) (format #t "~d   " 416) (error 'test "failed" '#t val)))
(let1 val (rational? (/ (+ (greatest-fixnum) 1) (/ 1 3))) (if (equal? '#t val) (format #t "~d   " 417) (error 'test "failed" '#t val)))
(let1 val (flonum? (/ (+ (greatest-fixnum) 1) (inexact (/ 1 3)))) (if (equal? '#t val) (format #t "~d   " 418) (error 'test "failed" '#t val)))
(let1 val (/ (+ (greatest-fixnum) 1) (+ (greatest-fixnum) 1)) (if (equal? '1 val) (format #t "~d   " 419) (error 'test "failed" '1 val)))
(let1 val (fixnum? (/ (+ (greatest-fixnum) 1) (+ (greatest-fixnum) 1))) (if (equal? '#t val) (format #t "~d   " 420) (error 'test "failed" '#t val)))
(if (equal? '#t (fixnum? (least-fixnum))) (format #t "~d   " 421) (error 'test "failed" #t))
(if (equal? '#t (fixnum? (greatest-fixnum))) (format #t "~d   " 422) (error 'test "failed" #t))
(if (equal? '#f (fixnum? (+ (greatest-fixnum) 1))) (format #t "~d   " 423) (error 'test "failed" #f))
(if (equal? '#f (fixnum? (- (least-fixnum) 1))) (format #t "~d   " 424) (error 'test "failed" #f))
(if (equal? '#t (number? (+ (greatest-fixnum) 1))) (format #t "~d   " 425) (error 'test "failed" #t))
(if (equal? '#t (number? (- (least-fixnum) 1))) (format #t "~d   " 426) (error 'test "failed" #t))
(if (equal? '#t (> (+ (greatest-fixnum) 1) (greatest-fixnum))) (format #t "~d   " 427) (error 'test "failed" #t))
(if (equal? '#t (< (- (least-fixnum) 1) (least-fixnum))) (format #t "~d   " 428) (error 'test "failed" #t))
(if (equal? '#t (fixnum? (- (+ (greatest-fixnum) 1) 1))) (format #t "~d   " 429) (error 'test "failed" #t))
(if (equal? '#t (fixnum? (+ (- (least-fixnum) 1) 1))) (format #t "~d   " 430) (error 'test "failed" #t))
(let1 val (number? 3) (if (equal? '#t val) (format #t "~d   " 431) (error 'test "failed" '#t val)))
(let1 val (number? (/ 1 4)) (if (equal? '#t val) (format #t "~d   " 432) (error 'test "failed" '#t val)))
(let1 val (mod 123 10) (if (equal? '3 val) (format #t "~d   " 433) (error 'test "failed" '3 val)))
(let1 val (mod 123 -10) (if (equal? '3 val) (format #t "~d   " 434) (error 'test "failed" '3 val)))
(let1 val (mod -123 10) (if (equal? '7 val) (format #t "~d   " 435) (error 'test "failed" '7 val)))
(let1 val (mod -123 -10) (if (equal? '7 val) (format #t "~d   " 436) (error 'test "failed" '7 val)))
(let1 val (div 123 10) (if (equal? '12 val) (format #t "~d   " 437) (error 'test "failed" '12 val)))
(let1 val (div 123 -10) (if (equal? '-12 val) (format #t "~d   " 438) (error 'test "failed" '-12 val)))
(let1 val (div -123 10) (if (equal? '-13 val) (format #t "~d   " 439) (error 'test "failed" '-13 val)))
(let1 val (div -123 -10) (if (equal? '13 val) (format #t "~d   " 440) (error 'test "failed" '13 val)))
(if (equal? '#\c (string-ref "abc" 2)) (format #t "~d   " 441) (error 'test "failed" #\c))
(if (equal? '#t (list? '(a b c))) (format #t "~d   " 442) (error 'test "failed" #t))
(if (equal? '#t (list? '())) (format #t "~d   " 443) (error 'test "failed" #t))
(if (equal? '#f (list? '(a . b))) (format #t "~d   " 444) (error 'test "failed" #f))
(if (equal? '"abc" "abc") (format #t "~d   " 445) (error 'test "failed" "abc"))
(let1 val (match '(0 (1 2) (3 4 5)) ((a (b c) (d e f)) (list a b c d e f))) (if (equal? '(0 1 2 3 4 5) val) (format #t "~d   " 446) (error 'test "failed" '(0 1 2 3 4 5) val)))
(let1 val (match 123 ((? string? x) (list 'string x)) ((? number? x) (list 'number x))) (if (equal? '(number 123) val) (format #t "~d   " 447) (error 'test "failed" '(number 123) val)))
(let1 val (define let-analyzer (match-lambda (('let (? symbol?) ((var expr) ...) body ...) (format "named let, vars=~s exprs=~s" var expr)) (('let ((var expr) ...) body ...) (format "normal let, vars=~s exprs=~s" var expr)) (_ (format "malformed let")))) (let-analyzer '(let ((a b) (c d)) e f g)) (if (equal? '"normal let, vars=(a c) exprs=(b d)" val) (format #t "~d   " 448) (error 'test "failed" '"normal let, vars=(a c) exprs=(b d)" val)))
(let1 val (let-analyzer '(let foo ((x (f a b)) (y (f c d))) e f g)) (if (equal? '"named let, vars=(x y) exprs=((f a b) (f c d))" val) (format #t "~d   " 449) (error 'test "failed" '"named let, vars=(x y) exprs=((f a b) (f c d))" val)))
(let1 val (let-analyzer '(let (a) b c d)) (if (equal? '"malformed let" val) (format #t "~d   " 450) (error 'test "failed" '"malformed let" val)))
(let1 val (match '(the answer is 42) (`(the answer is ,value) value) (else #f)) (if (equal? '42 val) (format #t "~d   " 451) (error 'test "failed" '42 val)))
(let1 val (match '(the answer was 42) (`(the answer is ,value) value) (else #f)) (if (equal? '#f val) (format #t "~d   " 452) (error 'test "failed" '#f val)))
(let1 val (match '(a b c d) ((the answer is value) value) (else #f)) (if (equal? 'd val) (format #t "~d   " 453) (error 'test "failed" 'd val)))
(let1 val (match "mosh.scm" ((? string? (= #/(.*)\.([^.]+)$/ m)) (format "base=~a suffix=~a" (m 1) (m 2)))) (if (equal? '"base=mosh suffix=scm" val) (format #t "~d   " 454) (error 'test "failed" '"base=mosh suffix=scm" val)))
(let1 val (do ((i 0) (j 0)) ((zero? j) (set! i 1) (set! i 2) i)) (if (equal? '2 val) (format #t "~d   " 455) (error 'test "failed" '2 val)))
(if (equal? 'composite (case (* 2 3) ((2 3 5 7) 'prime) ((1 4 6 8 9) 'composite))) (format #t "~d   " 456) (error 'test "failed" composite))
(if (equal? 'consonant (case (car '(c d)) ((a e i o u) 'vowel) ((w y) 'semivowel) (else 'consonant))) (format #t "~d   " 457) (error 'test "failed" consonant))
(if (equal? '0 (case 1 ((2 1) 0))) (format #t "~d   " 458) (error 'test "failed" 0))
(if (equal? '0 (case 2 ((2 1) 0))) (format #t "~d   " 459) (error 'test "failed" 0))
(let1 val (procedure? car) (if (equal? '#t val) (format #t "~d   " 460) (error 'test "failed" '#t val)))
(let1 val (procedure? 'car) (if (equal? '#f val) (format #t "~d   " 461) (error 'test "failed" '#f val)))
(let1 val (procedure? (lambda (x) (* x x))) (if (equal? '#t val) (format #t "~d   " 462) (error 'test "failed" '#t val)))
(let1 val (procedure? '(lambda (x) (* x x))) (if (equal? '#f val) (format #t "~d   " 463) (error 'test "failed" '#f val)))
(if (equal? '#t (char>=? #\b #\a)) (format #t "~d   " 464) (error 'test "failed" #t))
(let1 val (char>=? #\c #\b #\a) (if (equal? '#t val) (format #t "~d   " 465) (error 'test "failed" '#t val)))
(if (equal? '#t (char>=? #\b #\b)) (format #t "~d   " 466) (error 'test "failed" #t))
(if (equal? '#f (char>=? #\b #\c)) (format #t "~d   " 467) (error 'test "failed" #f))
(if (equal? '#t (char>? #\b #\a)) (format #t "~d   " 468) (error 'test "failed" #t))
(if (equal? '#f (char>? #\b #\b)) (format #t "~d   " 469) (error 'test "failed" #f))
(if (equal? '#f (char>? #\b #\c)) (format #t "~d   " 470) (error 'test "failed" #f))
(if (equal? '#t (char<=? #\a #\b)) (format #t "~d   " 471) (error 'test "failed" #t))
(if (equal? '#t (char<=? #\b #\b)) (format #t "~d   " 472) (error 'test "failed" #t))
(if (equal? '#f (char<=? #\c #\b)) (format #t "~d   " 473) (error 'test "failed" #f))
(if (equal? '#t (char<? #\a #\b)) (format #t "~d   " 474) (error 'test "failed" #t))
(if (equal? '#f (char<? #\b #\b)) (format #t "~d   " 475) (error 'test "failed" #f))
(if (equal? '#f (char<? #\c #\b)) (format #t "~d   " 476) (error 'test "failed" #f))
(let1 val (cons* 1 2 3 4) (if (equal? '(1 2 3 . 4) val) (format #t "~d   " 477) (error 'test "failed" '(1 2 3 . 4) val)))
(let1 val (cons* 1) (if (equal? '1 val) (format #t "~d   " 478) (error 'test "failed" '1 val)))
(let1 val (receive (x y) (car+cdr '(1 . 3)) (cons x y)) (if (equal? '(1 . 3) val) (format #t "~d   " 479) (error 'test "failed" '(1 . 3) val)))
(if (equal? '1 (append 1)) (format #t "~d   " 480) (error 'test "failed" 1))
(if (equal? '(1 . 2) (append '(1) 2)) (format #t "~d   " 481) (error 'test "failed" (1 . 2)))
(if (equal? '(1 2 . 3) (append '(1 2) 3)) (format #t "~d   " 482) (error 'test "failed" (1 2 . 3)))
(if (equal? '(1 2 3) (append '(1 2) '(3))) (format #t "~d   " 483) (error 'test "failed" (1 2 3)))
(if (equal? '(1 2 3 . 4) (append '(1 2) '(3) 4)) (format #t "~d   " 484) (error 'test "failed" (1 2 3 . 4)))
(if (equal? '(1 2 3 . 4) (append '(1 2) '(3) 4)) (format #t "~d   " 485) (error 'test "failed" (1 2 3 . 4)))
(if (equal? '1 (append '() 1)) (format #t "~d   " 486) (error 'test "failed" 1))
(if (equal? '(1) (append '(1) '())) (format #t "~d   " 487) (error 'test "failed" (1)))
(if (equal? '1 (append! 1)) (format #t "~d   " 488) (error 'test "failed" 1))
(if (equal? '(1 . 2) (append! '(1) 2)) (format #t "~d   " 489) (error 'test "failed" (1 . 2)))
(if (equal? '(1 2 . 3) (append! '(1 2) 3)) (format #t "~d   " 490) (error 'test "failed" (1 2 . 3)))
(if (equal? '(1 2 3) (append! '(1 2) '(3))) (format #t "~d   " 491) (error 'test "failed" (1 2 3)))
(if (equal? '(1 2 3 . 4) (append! '(1 2) '(3) 4)) (format #t "~d   " 492) (error 'test "failed" (1 2 3 . 4)))
(if (equal? '(1 2 3 . 4) (append! '(1 2) '(3) 4)) (format #t "~d   " 493) (error 'test "failed" (1 2 3 . 4)))
(if (equal? '1 (append! '() 1)) (format #t "~d   " 494) (error 'test "failed" 1))
(if (equal? '(1) (append! '(1) '())) (format #t "~d   " 495) (error 'test "failed" (1)))
(let1 val (take '(a b c d e) 2) (if (equal? '(a b) val) (format #t "~d   " 496) (error 'test "failed" '(a b) val)))
(let1 val (drop '(a b c d e) 2) (if (equal? '(c d e) val) (format #t "~d   " 497) (error 'test "failed" '(c d e) val)))
(let1 val (take '(1 2 3 . d) 2) (if (equal? '(1 2) val) (format #t "~d   " 498) (error 'test "failed" '(1 2) val)))
(let1 val (drop '(1 2 3 . d) 2) (if (equal? '(3 . d) val) (format #t "~d   " 499) (error 'test "failed" '(3 . d) val)))
(let1 val (take '(1 2 3 . d) 3) (if (equal? '(1 2 3) val) (format #t "~d   " 500) (error 'test "failed" '(1 2 3) val)))
(let1 val (drop '(1 2 3 . d) 3) (if (equal? 'd val) (format #t "~d   " 501) (error 'test "failed" 'd val)))
(let1 val (take-right '(a b c d e) 2) (if (equal? '(d e) val) (format #t "~d   " 502) (error 'test "failed" '(d e) val)))
(let1 val (drop-right '(a b c d e) 2) (if (equal? '(a b c) val) (format #t "~d   " 503) (error 'test "failed" '(a b c) val)))
(let1 val (take-right '(1 2 3 . d) 2) (if (equal? '(2 3 . d) val) (format #t "~d   " 504) (error 'test "failed" '(2 3 . d) val)))
(let1 val (drop-right '(1 2 3 . d) 2) (if (equal? '(1) val) (format #t "~d   " 505) (error 'test "failed" '(1) val)))
(let1 val (take-right '(1 2 3 . d) 0) (if (equal? 'd val) (format #t "~d   " 506) (error 'test "failed" 'd val)))
(let1 val (drop-right '(1 2 3 . d) 0) (if (equal? '(1 2 3) val) (format #t "~d   " 507) (error 'test "failed" '(1 2 3) val)))
(let1 val (xcons '(b c) 'a) (if (equal? '(a b c) val) (format #t "~d   " 508) (error 'test "failed" '(a b c) val)))
(let1 val (make-list 4 'c) (if (equal? '(c c c c) val) (format #t "~d   " 509) (error 'test "failed" '(c c c c) val)))
(let1 val (list-tabulate 4 values) (if (equal? '(0 1 2 3) val) (format #t "~d   " 510) (error 'test "failed" '(0 1 2 3) val)))
(let1 val (list-copy '(1 2 3 4)) (if (equal? '(1 2 3 4) val) (format #t "~d   " 511) (error 'test "failed" '(1 2 3 4) val)))
(let1 val (let1 lst (circular-list 'z 'q) (and (eq? (first lst) 'z) (eq? (second lst) 'q) (third lst) 'z)) (if (equal? 'z val) (format #t "~d   " 512) (error 'test "failed" 'z val)))
(let1 val (proper-list? '()) (if (equal? '#t val) (format #t "~d   " 513) (error 'test "failed" '#t val)))
(let1 val (proper-list? '(1 2 3)) (if (equal? '#t val) (format #t "~d   " 514) (error 'test "failed" '#t val)))
(let1 val (proper-list? '(1 . 3)) (if (equal? '#f val) (format #t "~d   " 515) (error 'test "failed" '#f val)))
(let1 val (dotted-list? '(1 2 . 3)) (if (equal? '#t val) (format #t "~d   " 516) (error 'test "failed" '#t val)))
(let1 val (dotted-list? '(1 2 3)) (if (equal? '#f val) (format #t "~d   " 517) (error 'test "failed" '#f val)))
(let1 val (last-pair '(a b c)) (if (equal? '(c) val) (format #t "~d   " 518) (error 'test "failed" '(c) val)))
(let1 val (last '(a b c)) (if (equal? 'c val) (format #t "~d   " 519) (error 'test "failed" 'c val)))
(let1 val (not-pair? 3) (if (equal? '#t val) (format #t "~d   " 520) (error 'test "failed" '#t val)))
(let1 val (not-pair? '(1 2)) (if (equal? '#f val) (format #t "~d   " 521) (error 'test "failed" '#f val)))
(let1 val (list= eq?) (if (equal? '#t val) (format #t "~d   " 522) (error 'test "failed" '#t val)))
(let1 val (list= eq? '(a)) (if (equal? '#t val) (format #t "~d   " 523) (error 'test "failed" '#t val)))
(let1 val (list= eq? '(a) '(a)) (if (equal? '#t val) (format #t "~d   " 524) (error 'test "failed" '#t val)))
(let1 val (list= eq? '(a) '(a b)) (if (equal? '#f val) (format #t "~d   " 525) (error 'test "failed" '#f val)))
(let1 val (receive (x y) (split-at '(a b c d e f g h) 3) (cons x y)) (if (equal? '((a b c) d e f g h) val) (format #t "~d   " 526) (error 'test "failed" '((a b c) d e f g h) val)))
(if (equal? '"123" (string #\1 #\2 #\3)) (format #t "~d   " 527) (error 'test "failed" "123"))
(if (equal? '"taro&amp;hanako" (regexp-replace-all #/&/ "taro&hanako" "&amp;")) (format #t "~d   " 528) (error 'test "failed" "taro&amp;hanako"))
(let1 val (let1 ht (make-hashtable (lambda (x) 2) (lambda (a b) #t)) (hashtable-set! ht 1 1) (hashtable-set! ht 2 2) (hashtable-ref ht 1)) (if (equal? '2 val) (format #t "~d   " 529) (error 'test "failed" '2 val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "my" "apple") (hashtable-set! ht "our" "water") (hashtable-ref ht "my")) (if (equal? '"apple" val) (format #t "~d   " 530) (error 'test "failed" '"apple" val)))
(let1 val (hashtable? (make-hashtable string-hash string=?)) (if (equal? '#t val) (format #t "~d   " 531) (error 'test "failed" '#t val)))
(let1 val (hashtable? (make-eq-hashtable)) (if (equal? '#t val) (format #t "~d   " 532) (error 'test "failed" '#t val)))
(let1 val (hashtable? '(a . b)) (if (equal? '#f val) (format #t "~d   " 533) (error 'test "failed" '#f val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "my" "apple") (hashtable-set! ht "our" "water") (hashtable-size ht)) (if (equal? '2 val) (format #t "~d   " 534) (error 'test "failed" '2 val)))
(let1 val (let1 ht (make-eq-hashtable) (hashtable-set! ht "my" "apple") (hashtable-set! ht "my" "apple") (hashtable-size ht)) (if (equal? '2 val) (format #t "~d   " 535) (error 'test "failed" '2 val)))
(let1 val (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-delete! ht 1) (hashtable-ref ht 1 #f)) (if (equal? '#f val) (format #t "~d   " 536) (error 'test "failed" '#f val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-delete! ht "one") (hashtable-ref ht "one" #f)) (if (equal? '#f val) (format #t "~d   " 537) (error 'test "failed" '#f val)))
(let1 val (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-contains? ht 2)) (if (equal? '#f val) (format #t "~d   " 538) (error 'test "failed" '#f val)))
(let1 val (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-contains? ht 1)) (if (equal? '#t val) (format #t "~d   " 539) (error 'test "failed" '#t val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-contains? ht "two")) (if (equal? '#f val) (format #t "~d   " 540) (error 'test "failed" '#f val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-contains? ht "one")) (if (equal? '#t val) (format #t "~d   " 541) (error 'test "failed" '#t val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" "one") (hashtable-update! ht "one" (lambda (x) (string-append "!" x "!")) "hige") (hashtable-update! ht "two" (lambda (x) (string-append "!" x "!")) "hige") (string-append (hashtable-ref ht "one") (hashtable-ref ht "two"))) (if (equal? '"!one!!hige!" val) (format #t "~d   " 542) (error 'test "failed" '"!one!!hige!" val)))
(let1 val (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (let1 ht-copy (hashtable-copy ht) (and (string=? (hashtable-ref ht-copy 1) "one") (not (hashtable-mutable? ht-copy))))) (if (equal? '#t val) (format #t "~d   " 543) (error 'test "failed" '#t val)))
(let1 val (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (let1 ht-copy (hashtable-copy ht #t) (and (string=? (hashtable-ref ht-copy 1) "one") (hashtable-mutable? ht-copy)))) (if (equal? '#t val) (format #t "~d   " 544) (error 'test "failed" '#t val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" "one") (let1 ht-copy (hashtable-copy ht) (and (string=? (hashtable-ref ht-copy "one") "one") (not (hashtable-mutable? ht-copy))))) (if (equal? '#t val) (format #t "~d   " 545) (error 'test "failed" '#t val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" "one") (let1 ht-copy (hashtable-copy ht #t) (and (string=? (hashtable-ref ht-copy "one") "one") (hashtable-mutable? ht-copy)))) (if (equal? '#t val) (format #t "~d   " 546) (error 'test "failed" '#t val)))
(let1 val (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-set! ht 2 "two") (hashtable-clear! ht) (hashtable-size ht)) (if (equal? '0 val) (format #t "~d   " 547) (error 'test "failed" '0 val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-set! ht "two" 2) (hashtable-clear! ht) (hashtable-size ht)) (if (equal? '0 val) (format #t "~d   " 548) (error 'test "failed" '0 val)))
(let1 val (let1 ht (make-eq-hashtable) (hashtable-set! ht 1 "one") (hashtable-set! ht 2 "two") (vector->list (hashtable-keys ht))) (if (equal? '(1 2) val) (format #t "~d   " 549) (error 'test "failed" '(1 2) val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-set! ht "two" 2) (let1 keys (vector->list (hashtable-keys ht)) (and (member "one" keys) (member "two" keys) (= 2 (length keys))))) (if (equal? '#t val) (format #t "~d   " 550) (error 'test "failed" '#t val)))
(let1 val (let1 ht (make-hashtable string-hash string=?) (hashtable-set! ht "one" 1) (hashtable-set! ht "two" 2) (receive (keys vals) (hashtable-entries ht) (append (vector->list keys) (vector->list vals)))) (if (equal? '("two" "one" 2 1) val) (format #t "~d   " 551) (error 'test "failed" '("two" "one" 2 1) val)))
(let1 val (equal? eq? (hashtable-equivalence-function (make-eq-hashtable))) (if (equal? '#t val) (format #t "~d   " 552) (error 'test "failed" '#t val)))
(let1 val (hashtable-hash-function (make-eq-hashtable)) (if (equal? '#f val) (format #t "~d   " 553) (error 'test "failed" '#f val)))
(let1 val (equal? string=? (hashtable-equivalence-function (make-hashtable string-hash string=?))) (if (equal? '#t val) (format #t "~d   " 554) (error 'test "failed" '#t val)))
(let1 val (equal? string-hash (hashtable-hash-function (make-hashtable string-hash string=?))) (if (equal? '#t val) (format #t "~d   " 555) (error 'test "failed" '#t val)))
(let1 val (= (string-ci-hash "abc") (string-ci-hash "AbC")) (if (equal? '#t val) (format #t "~d   " 556) (error 'test "failed" '#t val)))
(let1 val (= (symbol-hash 'abc) (symbol-hash 'abc)) (if (equal? '#t val) (format #t "~d   " 557) (error 'test "failed" '#t val)))
(let1 val (= (symbol-hash 'abc) (symbol-hash 'aBc)) (if (equal? '#f val) (format #t "~d   " 558) (error 'test "failed" '#f val)))
(let1 val (= (equal-hash '(a b c)) (equal-hash '(a b c))) (if (equal? '#t val) (format #t "~d   " 559) (error 'test "failed" '#t val)))
(let1 val (equal? eqv? (hashtable-equivalence-function (make-eqv-hashtable))) (if (equal? '#t val) (format #t "~d   " 560) (error 'test "failed" '#t val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (point? (record-predicate :point)) (point-x (record-accessor :point 0)) (point-y (record-accessor :point 1)) (point-x-set! (record-mutator :point 0)) (point-y-set! (record-mutator :point 1)) (p1 (make-point 1 2))) (and (point? p1) (record? p1) (= (point-x p1) 1) (= (point-y p1) 2) (point-x-set! p1 5) (= (point-x p1) 5))) (if (equal? '#t val) (format #t "~d   " 561) (error 'test "failed" '#t val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point2 (make-record-type-descriptor 'point2 :point #f #f #f '#((mutable x) (mutable y)))) (make-point2 (record-constructor (make-record-constructor-descriptor :point2 #f #f))) (point? (record-predicate :point)) (point-x (record-accessor :point 0)) (point-y (record-accessor :point 1)) (point-x-set! (record-mutator :point 0)) (point-y-set! (record-mutator :point 1)) (point2? (record-predicate :point2)) (point2-xx (record-accessor :point2 0)) (point2-yy (record-accessor :point2 1)) (point2-xx-set! (record-mutator :point2 0)) (point2-yy-set! (record-mutator :point2 1)) (p2 (make-point2 1 2 3 4))) (and (point? p2) (point2? p2) (record? p2) (= (point-x p2) 1) (= (point-y p2) 2) (= (point2-xx p2) 3) (= (point2-yy p2) 4) (point-x-set! p2 5) (= (point-x p2) 5) (point-y-set! p2 6) (= (point-y p2) 6) (point2-xx-set! p2 7) (= (point2-xx p2) 7) (point2-yy-set! p2 8) (= (point2-yy p2) 8))) (if (equal? '#t val) (format #t "~d   " 562) (error 'test "failed" '#t val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd/abs (make-record-constructor-descriptor :point #f (lambda (new) (lambda (x y) (new (abs x) (abs y)))))) (point-x (record-accessor :point 0)) (point-y (record-accessor :point 1)) (make-point/abs (record-constructor :point-cd/abs))) (and (= (point-x (make-point/abs -1 -2)) 1) (= (point-y (make-point/abs -1 -2)) 2))) (if (equal? '#t val) (format #t "~d   " 563) (error 'test "failed" '#t val)))
(let1 val (let* ((color->rgb (lambda (c) (cons 'rgb c))) (:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (:point-cd/abs (make-record-constructor-descriptor :point #f (lambda (new) (lambda (x y) (new (abs x) (abs y)))))) (point-x (record-accessor :point 0)) (:cpoint (make-record-type-descriptor 'cpoint :point #f #f #f '#((mutable rgb)))) (cpoint-rgb (record-accessor :cpoint 0)) (make-cpoint (record-constructor (make-record-constructor-descriptor :cpoint :point-cd (lambda (p) (lambda (x y c) ((p x y) (color->rgb c))))))) (make-cpoint/abs (record-constructor (make-record-constructor-descriptor :cpoint :point-cd/abs (lambda (p) (lambda (x y c) ((p x y) (color->rgb c)))))))) (and (equal? (cpoint-rgb (make-cpoint -1 -3 'red)) '(rgb . red)) (= (point-x (make-cpoint -1 -3 'red)) -1) (= (point-x (make-cpoint/abs -1 -3 'red)) 1))) (if (equal? '#t val) (format #t "~d   " 564) (error 'test "failed" '#t val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f #f #f #t '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (p (make-point 1 2))) (record? p)) (if (equal? '#f val) (format #t "~d   " 565) (error 'test "failed" '#f val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (p (make-point 1 2))) (eqv? :point (record-rtd p))) (if (equal? '#t val) (format #t "~d   " 566) (error 'test "failed" '#t val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (p (make-point 1 2))) (record-type-name (record-rtd p))) (if (equal? 'point val) (format #t "~d   " 567) (error 'test "failed" 'point val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point2 (make-record-type-descriptor 'point2 :point #f #f #f '#((mutable x) (mutable y))))) (record-type-name (record-type-parent :point2))) (if (equal? 'point val) (format #t "~d   " 568) (error 'test "failed" 'point val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y)))) (:point2 (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y))))) (eq? :point :point2)) (if (equal? '#t val) (format #t "~d   " 569) (error 'test "failed" '#t val)))
(let1 val (let* ((:point2 (make-record-type-descriptor 'point2 #f #f #f #f '#((mutable x) (mutable y))))) (record-type-generative? :point2)) (if (equal? '#t val) (format #t "~d   " 570) (error 'test "failed" '#t val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y))))) (record-type-generative? :point)) (if (equal? '#f val) (format #t "~d   " 571) (error 'test "failed" '#f val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y))))) (record-type-field-names :point)) (if (equal? '#(x y) val) (format #t "~d   " 572) (error 'test "failed" '#(x y) val)))
(let1 val (let* ((:point (make-record-type-descriptor 'point #f 'point-uid #f #f '#((mutable x) (mutable y))))) (record-field-mutable? :point 1)) (if (equal? '#t val) (format #t "~d   " 573) (error 'test "failed" '#t val)))
(let1 val (let ((path '()) (c '())) (let ((add (lambda (s) (set! path (cons s path))))) (dynamic-wind (lambda () (add 'connect)) (lambda () (add (call-with-current-continuation (lambda (c0) (set! c c0) 'talk1)))) (lambda () (add 'disconnect))) (if (< (length path) 4) (c 'talk2) (reverse path)))) (if (equal? '(connect talk1 disconnect connect talk2 disconnect) val) (format #t "~d   " 574) (error 'test "failed" '(connect talk1 disconnect connect talk2 disconnect) val)))
(let1 val (let* ((c '()) (dynwind-test1 (lambda () (let ((path '())) (let ((add (lambda (s) (set! path (cons s path))))) (dynamic-wind (lambda () (add 'connect)) (lambda () (add (call-with-current-continuation (lambda (c0) (set! c c0) 'talk1)))) (lambda () (add 'disconnect))) (if (< (length path) 4) (c 'talk2) (reverse path)))))) (dynwind-test2 (lambda () (let ((path '())) (dynamic-wind (lambda () (set! path (cons 1 path))) (lambda () (set! path (append (dynwind-test1) path))) (lambda () (set! path (cons 3 path)))) path)))) (dynwind-test2)) (if (equal? '(3 connect talk1 disconnect connect talk2 disconnect 1) val) (format #t "~d   " 575) (error 'test "failed" '(3 connect talk1 disconnect connect talk2 disconnect 1) val)))
(let1 val (let ((x '()) (c #f)) (dynamic-wind (lambda () (set! x (cons 'a x))) (lambda () (dynamic-wind (lambda () (set! x (cons 'b x))) (lambda () (dynamic-wind (lambda () (set! x (cons 'c x))) (lambda () (set! c (call/cc (lambda (x) x)))) (lambda () (set! x (cons 'd x))))) (lambda () (set! x (cons 'e x)))) (dynamic-wind (lambda () (set! x (cons 'f x))) (lambda () (when c (c #f))) (lambda () (set! x (cons 'g x))))) (lambda () (set! x (cons 'h x)))) (reverse x)) (if (equal? '(a b c d e f g b c d e f g h) val) (format #t "~d   " 576) (error 'test "failed" '(a b c d e f g b c d e f g h) val)))
(let1 val ((lambda () (receive x (dynamic-wind (lambda () #f) (lambda () (values 'a 'b 'c)) (lambda () #f)) x))) (if (equal? '(a b c) val) (format #t "~d   " 577) (error 'test "failed" '(a b c) val)))
(let1 val ((lambda () (receive x (dynamic-wind (lambda () #f) (lambda () (values)) (lambda () #f)) x))) (if (equal? '() val) (format #t "~d   " 578) (error 'test "failed" '() val)))
(let1 val (eval 3 '()) (if (equal? '3 val) (format #t "~d   " 579) (error 'test "failed" '3 val)))
(if (equal? '#t (equal? '(#(1 2 3) . #(one two three)) '(#(1 2 3) . #(one two three)))) (format #t "~d   " 580) (error 'test "failed" #t))
(if (equal? 'error (guard (con (#t 'error)) (call/cc (lambda (cont) (with-exception-handler (lambda (c) (cont 'error)) (lambda () (car 3))))))) (format #t "~d   " 581) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (car 3))) (format #t "~d   " 582) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (cdr 3))) (format #t "~d   " 583) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (cddr 3))) (format #t "~d   " 584) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (cdar 3))) (format #t "~d   " 585) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (cadr 3))) (format #t "~d   " 586) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (caar 3))) (format #t "~d   " 587) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (values 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))) (format #t "~d   " 588) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (apply values '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)))) (format #t "~d   " 589) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (apply (lambda (s) (display s)) '(1 2)))) (format #t "~d   " 590) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (number? 2 2))) (format #t "~d   " 591) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (make-record-constructor-descriptor))) (format #t "~d   " 592) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (hashtable-clear! 1 1 1))) (format #t "~d   " 593) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (record-predicate 3))) (format #t "~d   " 594) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (record-constructor 3))) (format #t "~d   " 595) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (make-record-type-descriptor 'point 3 'uid #f #f #f))) (format #t "~d   " 596) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((mutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (point-x (record-accessor :point 3))) #f))) (format #t "~d   " 597) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((immutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd)) (point-x (record-mutator :point 0))) #f))) (format #t "~d   " 598) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (let* ((:point (make-record-type-descriptor 'point #f #f #f #f '#((immutable x) (mutable y)))) (:point2 (make-record-type-descriptor 'point2 #f #f #f #f '#((immutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (:point2-cd (make-record-constructor-descriptor :point2 #f #f)) (make-point (record-constructor :point-cd)) (point2-x (record-accessor :point2 0))) (point2-x (make-point 1 2))))) (format #t "~d   " 599) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (let* ((:point (make-record-type-descriptor 'point #f #f #t #t '#((immutable x) (mutable y)))) (:point-cd (make-record-constructor-descriptor :point #f #f)) (make-point (record-constructor :point-cd))) (record-rtd (make-point 2 21))))) (format #t "~d   " 600) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (apply read-char (current-input-port)))) (format #t "~d   " 601) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (rxmatch-start (rxmatch #/\d+/ "a345a") 5))) (format #t "~d   " 602) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (string-ref "hige" 5))) (format #t "~d   " 603) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (open-file-input-port "not-exist-path/////xxx"))) (format #t "~d   " 604) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (open-file-output-port "not-exist-path/////xxx"))) (format #t "~d   " 605) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (format "~a ~a" 1))) (format #t "~d   " 606) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) my-unbound-variable)) (format #t "~d   " 607) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (my-unbound-variable))) (format #t "~d   " 608) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (vector-ref 'v 3))) (format #t "~d   " 609) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (receive (a) (values 1 2)))) (format #t "~d   " 610) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (receive (a b) (values 1)))) (format #t "~d   " 611) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (3))) (format #t "~d   " 612) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (/ 3 0))) (format #t "~d   " 613) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (error "our" "message"))) (format #t "~d   " 614) (error 'test "failed"))(if (equal? '#t (let ((x (list 'a 'b 'c 'a)) (y (list 'a 'b 'c 'a 'b 'c 'a))) (set-cdr! (list-tail x 2) x) (set-cdr! (list-tail y 5) y) (equal? x y))) (format #t "~d   " 615) (error 'test "failed" #t))
(if (equal? '#t (apply = '(3 3))) (format #t "~d   " 616) (error 'test "failed" #t))
(if (equal? '#f (apply = '(3 4))) (format #t "~d   " 617) (error 'test "failed" #f))
(if (equal? '#t (apply = '(3 3 3 3))) (format #t "~d   " 618) (error 'test "failed" #t))
(if (equal? '#f (apply = '(3 3 3 4))) (format #t "~d   " 619) (error 'test "failed" #f))
(if (equal? '#f (apply = '(4 3 3 3))) (format #t "~d   " 620) (error 'test "failed" #f))
(if (equal? 'error (guard (con (#t 'error)) (apply = '(4 'z 3 3)))) (format #t "~d   " 621) (error 'test "failed"))(if (equal? '#t (apply > '(4 3))) (format #t "~d   " 622) (error 'test "failed" #t))
(if (equal? '#t (apply > '(4 3 2))) (format #t "~d   " 623) (error 'test "failed" #t))
(if (equal? '#f (apply > '(4 3 1 2))) (format #t "~d   " 624) (error 'test "failed" #f))
(if (equal? '#t (apply >= '(3 3 3))) (format #t "~d   " 625) (error 'test "failed" #t))
(if (equal? '#t (apply >= '(4 3 3))) (format #t "~d   " 626) (error 'test "failed" #t))
(if (equal? '#t (apply >= '(4 3))) (format #t "~d   " 627) (error 'test "failed" #t))
(if (equal? '#t (apply < '(1 2))) (format #t "~d   " 628) (error 'test "failed" #t))
(if (equal? '#t (apply < '(1 2 3))) (format #t "~d   " 629) (error 'test "failed" #t))
(if (equal? '#f (apply < '(1 5 3))) (format #t "~d   " 630) (error 'test "failed" #f))
(if (equal? '#t (apply <= '(1 2))) (format #t "~d   " 631) (error 'test "failed" #t))
(if (equal? '#t (apply <= '(1 2 3))) (format #t "~d   " 632) (error 'test "failed" #t))
(if (equal? '#t (apply <= '(1 3 3))) (format #t "~d   " 633) (error 'test "failed" #t))
(if (equal? '#f (apply <= '(1 5 3))) (format #t "~d   " 634) (error 'test "failed" #f))
(if (equal? 'error (guard (con (#t 'error)) (+ 1 2 'a))) (format #t "~d   " 635) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (/ 1 0))) (format #t "~d   " 636) (error 'test "failed"))(if (equal? '4 (apply + '(4))) (format #t "~d   " 637) (error 'test "failed" 4))
(if (equal? '7 (apply + '(4 3))) (format #t "~d   " 638) (error 'test "failed" 7))
(if (equal? '17 (apply + '(4 3 10))) (format #t "~d   " 639) (error 'test "failed" 17))
(if (equal? '4 (apply + '(1 1 1 1))) (format #t "~d   " 640) (error 'test "failed" 4))
(if (equal? '5 (apply - '(10 5))) (format #t "~d   " 641) (error 'test "failed" 5))
(if (equal? '3 (apply - '(10 5 2))) (format #t "~d   " 642) (error 'test "failed" 3))
(if (equal? '6 (apply * '(2 3))) (format #t "~d   " 643) (error 'test "failed" 6))
(if (equal? '24 (apply * '(2 3 4))) (format #t "~d   " 644) (error 'test "failed" 24))
(if (equal? '3 (apply / '(6 2))) (format #t "~d   " 645) (error 'test "failed" 3))
(if (equal? 'error (guard (con (#t 'error)) (apply / '(6 0)))) (format #t "~d   " 646) (error 'test "failed"))(if (equal? '(0 1 2 #f) (let* ((e (make-enumeration '(red green blue))) (i (enum-set-indexer e))) (list (i 'red) (i 'green) (i 'blue) (i 'yellow)))) (format #t "~d   " 647) (error 'test "failed" (0 1 2 #f)))
(if (equal? '(red green blue) (enum-set->list (make-enumeration '(red green blue)))) (format #t "~d   " 648) (error 'test "failed" (red green blue)))
(if (equal? '(red blue) (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (enum-set->list (c '(blue red))))) (format #t "~d   " 649) (error 'test "failed" (red blue)))
(if (equal? '(#t #f #t #t #f #t) (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (list (enum-set-member? 'blue (c '(red blue))) (enum-set-member? 'green (c '(red blue))) (enum-set-subset? (c '(red blue)) e) (enum-set-subset? (c '(red blue)) (c '(blue red))) (enum-set-subset? (c '(red blue)) (c '(red))) (enum-set=? (c '(red blue)) (c '(blue red)))))) (format #t "~d   " 650) (error 'test "failed" (#t #f #t #t #f #t)))
(if (equal? 'error (guard (con (#t 'error)) (guard (c (#t 'error)) (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (c '(pink)))))) (format #t "~d   " 651) (error 'test "failed"))(if (equal? '((red green blue) (red green blue) 1 #t #f #t #t #f #t #t #f #f #t #t #f #f #t) (let* ((e (make-enumeration '(red green blue))) (r ((enum-set-constructor e) '(red)))) (list (enum-set->list (enum-set-universe e)) (enum-set->list (enum-set-universe r)) ((enum-set-indexer ((enum-set-constructor e) '(red))) 'green) (enum-set-member? 'red e) (enum-set-member? 'black e) (enum-set-subset? e e) (enum-set-subset? r e) (enum-set-subset? e r) (enum-set-subset? e (make-enumeration '(blue green red))) (enum-set-subset? e (make-enumeration '(blue green red black))) (enum-set-subset? (make-enumeration '(blue green red black)) e) (enum-set-subset? ((enum-set-constructor (make-enumeration '(blue green red black))) '(red)) e) (enum-set-subset? ((enum-set-constructor (make-enumeration '(green red))) '(red)) e) (enum-set=? e e) (enum-set=? r e) (enum-set=? e r) (enum-set=? e (make-enumeration '(blue green red)))))) (format #t "~d   " 652) (error 'test "failed" ((red green blue) (red green blue) 1 #t #f #t #t #f #t #t #f #f #t #t #f #f #t)))
(if (equal? '(#t #f #t #t #f #t) (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (list (enum-set-member? 'blue (c '(red blue))) (enum-set-member? 'green (c '(red blue))) (enum-set-subset? (c '(red blue)) e) (enum-set-subset? (c '(red blue)) (c '(blue red))) (enum-set-subset? (c '(red blue)) (c '(red))) (enum-set=? (c '(red blue)) (c '(blue red)))))) (format #t "~d   " 653) (error 'test "failed" (#t #f #t #t #f #t)))
(if (equal? '(red blue) (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (enum-set->list (c '(blue red))))) (format #t "~d   " 654) (error 'test "failed" (red blue)))
(if (equal? '((red blue) (red) (green)) (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (list (enum-set->list (enum-set-union (c '(blue)) (c '(red)))) (enum-set->list (enum-set-intersection (c '(red green)) (c '(red blue)))) (enum-set->list (enum-set-difference (c '(red green)) (c '(red blue))))))) (format #t "~d   " 655) (error 'test "failed" ((red blue) (red) (green))))
(if (equal? '(green blue) (let* ((e (make-enumeration '(red green blue))) (c (enum-set-constructor e))) (enum-set->list (enum-set-complement (c '(red)))))) (format #t "~d   " 656) (error 'test "failed" (green blue)))
(if (equal? '(red black) (let ((e1 (make-enumeration '(red green blue black))) (e2 (make-enumeration '(red black white)))) (enum-set->list (enum-set-projection e1 e2)))) (format #t "~d   " 657) (error 'test "failed" (red black)))
(if (equal? 'error (guard (con (#t 'error)) (call-with-string-input-port "(" (lambda (in) (read in))))) (format #t "~d   " 658) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (call-with-string-input-port "(" (lambda (in) (apply read (list in)))))) (format #t "~d   " 659) (error 'test "failed"))(if (equal? '#t (eq? #\A #\A)) (format #t "~d   " 660) (error 'test "failed" #t))
(let1 val (bytevector-length (make-bytevector 3)) (if (equal? '3 val) (format #t "~d   " 661) (error 'test "failed" '3 val)))
(let1 val (make-bytevector 4 3) (if (equal? '#vu8(3 3 3 3) val) (format #t "~d   " 662) (error 'test "failed" '#vu8(3 3 3 3) val)))
(let1 val (bytevector=? #vu8(3 3 3) #vu8(3 3 3)) (if (equal? '#t val) (format #t "~d   " 663) (error 'test "failed" '#t val)))
(let1 val (bytevector=? #vu8(3 4 3) #vu8(3 3 3)) (if (equal? '#f val) (format #t "~d   " 664) (error 'test "failed" '#f val)))
(let1 val (let ((bytevector (make-bytevector 4))) (bytevector-fill! bytevector 3) bytevector) (if (equal? '#vu8(3 3 3 3) val) (format #t "~d   " 665) (error 'test "failed" '#vu8(3 3 3 3) val)))
(if (equal? '#vu8(1 2 3 1 2 3 4 8) (let ((b #vu8(1 2 3 4 5 6 7 8))) (bytevector-copy! b 0 b 3 4) b)) (format #t "~d   " 666) (error 'test "failed" #vu8(1 2 3 1 2 3 4 8)))
(if (equal? '#vu8(1 2 3 4) (bytevector-copy #vu8(1 2 3 4))) (format #t "~d   " 667) (error 'test "failed" #vu8(1 2 3 4)))
(if (equal? '255 (bytevector-u8-ref #vu8(255) 0)) (format #t "~d   " 668) (error 'test "failed" 255))
(if (equal? '255 (bytevector-u8-ref (make-bytevector 1 -1) 0)) (format #t "~d   " 669) (error 'test "failed" 255))
(if (equal? '255 (bytevector-u8-ref (make-bytevector 1 255) 0)) (format #t "~d   " 670) (error 'test "failed" 255))
(if (equal? '255 (let ((bytevector (make-bytevector 1))) (bytevector-fill! bytevector -1) (bytevector-u8-ref bytevector 0))) (format #t "~d   " 671) (error 'test "failed" 255))
(if (equal? '-1 (bytevector-s8-ref #vu8(255) 0)) (format #t "~d   " 672) (error 'test "failed" -1))
(if (equal? '-1 (bytevector-s8-ref (make-bytevector 1 -1) 0)) (format #t "~d   " 673) (error 'test "failed" -1))
(if (equal? '-1 (bytevector-s8-ref (make-bytevector 1 255) 0)) (format #t "~d   " 674) (error 'test "failed" -1))
(if (equal? '-1 (let ((bytevector (make-bytevector 1))) (bytevector-fill! bytevector -1) (bytevector-s8-ref bytevector 0))) (format #t "~d   " 675) (error 'test "failed" -1))
(if (equal? '255 (let ((b (make-bytevector 1))) (bytevector-u8-set! b 0 255) (bytevector-u8-ref b 0))) (format #t "~d   " 676) (error 'test "failed" 255))
(if (equal? '255 (let ((b (make-bytevector 1))) (bytevector-s8-set! b 0 -1) (bytevector-u8-ref b 0))) (format #t "~d   " 677) (error 'test "failed" 255))
(if (equal? 'error (guard (con (#t 'error)) (bytevector-u8-ref 1 (make-bytevector 1)))) (format #t "~d   " 678) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s8-ref 1 (make-bytevector 1)))) (format #t "~d   " 679) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u8-ref -1 (make-bytevector 1)))) (format #t "~d   " 680) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s8-ref -1 (make-bytevector 1)))) (format #t "~d   " 681) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u8-set! 1 (make-bytevector 1)) 1)) (format #t "~d   " 682) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s8-set! 1 (make-bytevector 1)) 1)) (format #t "~d   " 683) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u8-set! -1 (make-bytevector 1)) 1)) (format #t "~d   " 684) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s8-set! -1 (make-bytevector 1)) 1)) (format #t "~d   " 685) (error 'test "failed"))(if (equal? '#vu8(1 2 3 4) (u8-list->bytevector '(1 2 3 4))) (format #t "~d   " 686) (error 'test "failed" #vu8(1 2 3 4)))
(if (equal? 'error (guard (con (#t 'error)) (u8-list->bytevector '(1 2 3 -1 4)))) (format #t "~d   " 687) (error 'test "failed"))(if (equal? '(1 2 3 4) (bytevector->u8-list #vu8(1 2 3 4))) (format #t "~d   " 688) (error 'test "failed" (1 2 3 4)))
(if (equal? '65023 (bytevector-u16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 'little)) (format #t "~d   " 689) (error 'test "failed" 65023))
(if (equal? '-513 (bytevector-s16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 'little)) (format #t "~d   " 690) (error 'test "failed" -513))
(if (equal? '65533 (bytevector-u16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 'big)) (format #t "~d   " 691) (error 'test "failed" 65533))
(if (equal? '-3 (bytevector-s16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 'big)) (format #t "~d   " 692) (error 'test "failed" -3))
(if (equal? '255 (bytevector-u16-ref #vu8(255 0) 0 'little)) (format #t "~d   " 693) (error 'test "failed" 255))
(if (equal? '65280 (bytevector-u16-ref #vu8(255 0) 0 'big)) (format #t "~d   " 694) (error 'test "failed" 65280))
(if (equal? 'error (guard (con (#t 'error)) (bytevector-u16-ref #vu8(255 0) 1 'little))) (format #t "~d   " 695) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u16-ref #vu8(255 0) 1 'big))) (format #t "~d   " 696) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-u16-native-ref #vu8(255 0 1 2) 1))) (format #t "~d   " 697) (error 'test "failed"))(if (equal? 'error (guard (con (#t 'error)) (bytevector-s16-native-ref #vu8(255 0 1 2) 1))) (format #t "~d   " 698) (error 'test "failed"))(if (equal? '#t (= (bytevector-u16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 (native-endianness)) (bytevector-u16-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14))) (format #t "~d   " 699) (error 'test "failed" #t))
(if (equal? '#t (= (bytevector-s16-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14 (native-endianness)) (bytevector-s16-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 14))) (format #t "~d   " 700) (error 'test "failed" #t))
(if (equal? '12345 (let ((b #vu8(0 0 0 0 0))) (bytevector-u16-set! b 0 12345 'little) (bytevector-u16-ref b 0 'little))) (format #t "~d   " 701) (error 'test "failed" 12345))
(if (equal? '12345 (let ((b #vu8(0 0 0 0 0))) (bytevector-u16-set! b 0 12345 'big) (bytevector-u16-ref b 0 'big))) (format #t "~d   " 702) (error 'test "failed" 12345))
(if (equal? '12345 (let ((b #vu8(0 0 0 0 0))) (bytevector-s16-set! b 0 12345 'little) (bytevector-s16-ref b 0 'little))) (format #t "~d   " 703) (error 'test "failed" 12345))
(if (equal? '12345 (let ((b #vu8(0 0 0 0 0))) (bytevector-s16-set! b 0 12345 'big) (bytevector-s16-ref b 0 'big))) (format #t "~d   " 704) (error 'test "failed" 12345))
(if (equal? 'error (guard (con (#t 'error)) (let ((b #vu8(0 0 0 0 0))) (bytevector-s16-set! b 0 32768 'little) (bytevector-s16-ref b 0 'little)))) (format #t "~d   " 705) (error 'test "failed"))(if (equal? '#t (let ((b #vu8(0 0 0 0))) (bytevector-u16-set! b 0 12345 (native-endianness)) (bytevector-u16-native-set! b 2 12345) (= (bytevector-u16-native-ref b 0) (bytevector-u16-native-ref b 2)))) (format #t "~d   " 706) (error 'test "failed" #t))
(if (equal? '#t (let ((b #vu8(0 0 0 0))) (bytevector-s16-set! b 0 12345 (native-endianness)) (bytevector-s16-native-set! b 2 12345) (= (bytevector-s16-native-ref b 0) (bytevector-s16-native-ref b 2)))) (format #t "~d   " 707) (error 'test "failed" #t))
(if (equal? '-33554433 (bytevector-u32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 'little)) (format #t "~d   " 708) (error 'test "failed" -33554433))
(if (equal? '-33554433 (bytevector-s32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 'little)) (format #t "~d   " 709) (error 'test "failed" -33554433))
(if (equal? '-3 (bytevector-u32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 'big)) (format #t "~d   " 710) (error 'test "failed" -3))
(if (equal? '-3 (bytevector-s32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 'big)) (format #t "~d   " 711) (error 'test "failed" -3))
(if (equal? '#t (= (bytevector-u32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 (native-endianness)) (bytevector-u32-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12))) (format #t "~d   " 712) (error 'test "failed" #t))
(if (equal? '#t (= (bytevector-s32-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12 (native-endianness)) (bytevector-s32-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 12))) (format #t "~d   " 713) (error 'test "failed" #t))
(if (equal? '12345 (let ((b #vu8(0 0 0 0 0))) (bytevector-u32-set! b 0 12345 'little) (bytevector-u32-ref b 0 'little))) (format #t "~d   " 714) (error 'test "failed" 12345))
(if (equal? '12345 (let ((b #vu8(0 0 0 0 0))) (bytevector-u32-set! b 0 12345 'big) (bytevector-u32-ref b 0 'big))) (format #t "~d   " 715) (error 'test "failed" 12345))
(if (equal? '-1 (bytevector-u64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 'little)) (format #t "~d   " 716) (error 'test "failed" -1))
(if (equal? '-1 (bytevector-s64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 'little)) (format #t "~d   " 717) (error 'test "failed" -1))
(if (equal? '-3 (bytevector-s64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 'big)) (format #t "~d   " 718) (error 'test "failed" -3))
(if (equal? '#t (= (bytevector-u64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 (native-endianness)) (bytevector-u64-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8))) (format #t "~d   " 719) (error 'test "failed" #t))
(if (equal? '#t (= (bytevector-s64-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8 (native-endianness)) (bytevector-s64-native-ref #vu8(255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 253) 8))) (format #t "~d   " 720) (error 'test "failed" #t))
(if (equal? '12345 (let ((b #vu8(0 0 0 0 0 0 0 0))) (bytevector-u64-set! b 0 12345 'little) (bytevector-u64-ref b 0 'little))) (format #t "~d   " 721) (error 'test "failed" 12345))
(if (equal? '12345 (let ((b #vu8(0 0 0 0 0 0 0 0))) (bytevector-u64-set! b 0 12345 'big) (bytevector-u64-ref b 0 'big))) (format #t "~d   " 722) (error 'test "failed" 12345))
(if (equal? '"あいう" (utf8->string #vu8(227 129 130 227 129 132 227 129 134))) (format #t "~d   " 723) (error 'test "failed" "あいう"))
(if (equal? '"あいう" (bytevector->string #vu8(227 129 130 227 129 132 227 129 134) (make-transcoder (utf-8-codec)))) (format #t "~d   " 724) (error 'test "failed" "あいう"))
(if (equal? '#vu8(227 129 130 227 129 132 227 129 134) (string->bytevector "あいう" (make-transcoder (utf-8-codec)))) (format #t "~d   " 725) (error 'test "failed" #vu8(227 129 130 227 129 132 227 129 134)))
(if (equal? 'error (guard (con (#t 'error)) (bytevector->string #vu8(129 130 227 129 132 227 129 134) (make-transcoder (utf-8-codec))))) (format #t "~d   " 726) (error 'test "failed"))(if (equal? '#vu8(227 129 130 227 129 132 227 129 134) (string->utf8 "あいう")) (format #t "~d   " 727) (error 'test "failed" #vu8(227 129 130 227 129 132 227 129 134)))
(if (equal? '#vu8(97 0 0 0 112 0 0 0 112 0 0 0 187 3 0 0 101 0 0 0) (string->utf32 "appλe" 'little)) (format #t "~d   " 728) (error 'test "failed" #vu8(97 0 0 0 112 0 0 0 112 0 0 0 187 3 0 0 101 0 0 0)))
(if (equal? '#vu8(0 0 0 97 0 0 0 112 0 0 0 112 0 0 3 187 0 0 0 101) (string->utf32 "appλe" 'big)) (format #t "~d   " 729) (error 'test "failed" #vu8(0 0 0 97 0 0 0 112 0 0 0 112 0 0 3 187 0 0 0 101)))
(if (equal? '#vu8(0 0 0 97 0 0 0 112 0 0 0 112 0 0 3 187 0 0 0 101) (string->utf32 "appλe")) (format #t "~d   " 730) (error 'test "failed" #vu8(0 0 0 97 0 0 0 112 0 0 0 112 0 0 3 187 0 0 0 101)))
(if (equal? 'error (guard (con (#t 'error)) (string->utf32 "appλe" 'hoge))) (format #t "~d   " 731) (error 'test "failed"))(if (equal? '#t (and (let ((str "apple")) (string=? str (utf32->string (string->utf32 str 'big) 'big))) (let ((str "appλe")) (string=? str (utf32->string (string->utf32 str 'big) 'big))) (let ((str "")) (string=? str (utf32->string (string->utf32 str 'big) 'big))) #t)) (format #t "~d   " 732) (error 'test "failed" #t))
(if (equal? '#t (and (let ((str "apple")) (string=? str (utf32->string (string->utf32 str 'little) 'little))) (let ((str "appλe")) (string=? str (utf32->string (string->utf32 str 'little) 'little))) (let ((str "")) (string=? str (utf32->string (string->utf32 str 'little) 'little))) #t)) (format #t "~d   " 733) (error 'test "failed" #t))
(if (equal? '#t (let ((str "apple") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? str (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'big)) (string=? str (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'little)) #t))) (format #t "~d   " 734) (error 'test "failed" #t))
(if (equal? '#t (let ((str "appλe") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? str (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'big)) (string=? str (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'little)) #t))) (format #t "~d   " 735) (error 'test "failed" #t))
(if (equal? '#t (let ((str "apple") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? str (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'big)) (string=? str (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'little))))) (format #t "~d   " 736) (error 'test "failed" #t))
(if (equal? '#t (let ((str "appλe") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(254 255 0 0) (string->utf32 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(0 0 255 254) (string->utf32 str 'big)) 'big #t) (string-append "￾" str))))) (format #t "~d   " 737) (error 'test "failed" #t))
(if (equal? '#t (let ((str "") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(254 255 0 0) (string->utf32 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(0 0 255 254) (string->utf32 str 'big)) 'big #t) (string-append "￾" str))))) (format #t "~d   " 738) (error 'test "failed" #t))
(if (equal? '#t (let ((str "") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf32->string (bv-append #vu8(255 254 0 0) (string->utf32 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(254 255 0 0) (string->utf32 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf32->string (bv-append #vu8(0 0 254 255) (string->utf32 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf32->string (bv-append #vu8(0 0 255 254) (string->utf32 str 'big)) 'big #t) (string-append "￾" str))))) (format #t "~d   " 739) (error 'test "failed" #t))
(if (equal? '#vu8(97 0 112 0 112 0 187 3 101 0) (string->utf16 "appλe" 'little)) (format #t "~d   " 740) (error 'test "failed" #vu8(97 0 112 0 112 0 187 3 101 0)))
(if (equal? '#vu8(0 97 0 112 0 112 3 187 0 101) (string->utf16 "appλe" 'big)) (format #t "~d   " 741) (error 'test "failed" #vu8(0 97 0 112 0 112 3 187 0 101)))
(if (equal? '#vu8(0 97 0 112 0 112 3 187 0 101) (string->utf16 "appλe")) (format #t "~d   " 742) (error 'test "failed" #vu8(0 97 0 112 0 112 3 187 0 101)))
(if (equal? '#t (and (let ((str "apple")) (string=? str (utf16->string (string->utf16 str 'big) 'big))) (let ((str "appλe")) (string=? str (utf16->string (string->utf16 str 'big) 'big))) (let ((str "")) (string=? str (utf16->string (string->utf16 str 'big) 'big))) #t)) (format #t "~d   " 743) (error 'test "failed" #t))
(if (equal? '#t (let ((str "apple") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'big) str) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'little) str) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'big)) 'big #t) (string-append "￾" str))))) (format #t "~d   " 744) (error 'test "failed" #t))
(if (equal? '#t (let ((str "appλe") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'big) str) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'little) str) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'big)) 'big #t) (string-append "￾" str))))) (format #t "~d   " 745) (error 'test "failed" #t))
(if (equal? '#t (let ((str "") (bv-append (lambda (bv1 bv2) (let ((bv (make-bytevector (+ (bytevector-length bv1) (bytevector-length bv2))))) (bytevector-copy! bv1 0 bv 0 (bytevector-length bv1)) (bytevector-copy! bv2 0 bv (bytevector-length bv1) (bytevector-length bv2)) bv)))) (and (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'big) str) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'little) str) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'little)) 'little #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'little)) 'little #t) (string-append "￾" str)) (string=? (utf16->string (bv-append #vu8(254 255) (string->utf16 str 'big)) 'big #t) (string-append "﻿" str)) (string=? (utf16->string (bv-append #vu8(255 254) (string->utf16 str 'big)) 'big #t) (string-append "￾" str))))) (format #t "~d   " 746) (error 'test "failed" #t))
