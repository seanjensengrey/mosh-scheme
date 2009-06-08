(import (rnrs)
        (mosh)
        (mosh concurrent)
        (mosh test))

(let ([pid (spawn
             (lambda ()
               (test-eqv 'hello
                         (receive
                          [('apple)
                           (test-false #t)]
                          [('greeting what)
                           what]))
               (test-equal '(some hello)
                           (receive
                            [x x]))
               (test-equal 'good
                           (receive
                            ['good 'good]))
               (test-eqv 'hello2
                         (receive
                          [('greeting what)
                           what]))
               (test-eqv 'hello3
                         (receive
                          [('greeting what)
                           what]))
               (test-equal '(a . pen)
                           (let-values ([(x y) (receive
                                                [('this 'is x y) (values x y)])])
                             (cons x y)))
               ;; timeout
               (test-eqv 'time-out
                         (receive
                          [('greeting what) what]
                          [after 1
                                 'time-out]))
               (display "after")

               (register 'sub (self))
               ;; doesn't work yet
              (receive
                 [('register from name)
                  (! from `(ok ,name))])
;; ああ。mail-box lock してないところあるね。
              (time (receive
                 [('register from name)
                  (! from `(ok ,name))]))

               (test-results)
;               (process-exit 'normal)
;               (error 'hoge "hage")
               )
             '((rnrs) (mosh concurrent) (mosh) (mosh test)))])

(link pid)

(! pid '(some hello))
(! pid '(greeting hello))
(! pid '(greeting hello2))
(! pid '(greeting hello3))
(! pid 'good)
(! pid '(this is a pen))

(! pid `(register ,(self) "higepon"))
(receive
    [('ok name) (test-equal "higepon" name)])

(! 'sub `(register ,(self) "higepon"))
(receive
    [('ok name) (test-equal "higepon" name)])

(receive
    [('exit why) (test-equal 'normal why)])

(let ([pid2 (spawn-link (lambda () (error 'unknown "hogehoge2")) '((rnrs) (mosh concurrent)))])
  (receive
      [('exit why) (test-true (error? why))
       #;(raise why)]))



(test-results)


(join! pid))

