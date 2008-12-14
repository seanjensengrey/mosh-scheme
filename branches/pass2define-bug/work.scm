(define match:expanders
  (letrec (
           ;; (inline-let (lambda (let-exp)
           (gen (lambda (x sf plist erract length>= eta)
                  (if (null? plist)
                      (erract x)
                      (let* ((v '())
                             (val (lambda (x) (cdr (assq x v))))
                             (fail (lambda (sf)
                                     (gen x
                                          sf
                                          (cdr plist)
                                          erract
                                          length>=
                                          eta)))
                             (success (lambda (sf)
                                        (set-car! (cddddr (car plist)) #t)
                                        (let* ((code (cadr (car plist)))
                                               (bv (caddr (car plist)))
                                               (fail-sym (cadddr
                                                           (car plist))))
                                          (if fail-sym
                                              (let ((ap `(,code
                                                           ,fail-sym
                                                           ,@(map val bv))))
                                                `(call-with-current-continuation
                                                   (lambda (,fail-sym)
                                                     (let ((,fail-sym (lambda ()
                                                                        (,fail-sym
                                                                          ,(fail sf)))))
                                                       ,ap))))
                                              `(,code ,@(map val bv)))))))
                        (let next ((p (caar plist))
                                   (e x)
                                   (sf sf)
                                   (kf fail)
                                   (ks success))
                          (cond
                            ((and (pair? p) (eq? 'quote (car p))) (emit `(equal?
                                                                           ,e
                                                                           ,p)
                                                                        sf
                                                                        kf
                                                                        ks))
                            ((and (pair? p) (eq? '? (car p))) (let ((tst `(,(cadr p)
                                                                            ,e)))
                                                                (emit tst
                                                                      sf
                                                                      kf
                                                                      ks)))
                            ((and (pair? p) (eq? '= (car p))) (next (caddr
                                                                      p)
                                                                    `(,(cadr p)
                                                                       ,e)
                                                                    sf
                                                                    kf
                                                                    ks))
                            ((and (pair? p) (eq? 'and (car p))) (let loop ((p (cdr p))
                                                                           (sf sf))
                                                                  (if (null?
                                                                        p)
                                                                      (ks sf)
                                                                      (next (car p)
                                                                            e
                                                                            sf
                                                                            kf
                                                                            (lambda (sf)
                                                                              (loop (cdr p)
                                                                                    sf))))))
                            ((and (pair? p)
                                  (pair? (cdr p))
                                  (dot-dot-k? (cadr p))) (emit `(list? ,e)
                                                               sf
                                                               kf
                                                               (lambda (sf)
                                                                 (let* ((k (dot-dot-k?
                                                                             (cadr p)))
                                                                        (ks (lambda (sf)
                                                                              (let ((bound (list-ref
                                                                                             p
                                                                                             2)))
                                                                                (cond
                                                                                  ((eq? (car p)
                                                                                        '_) (ks sf))
                                                                                  ((null?
                                                                                     bound) (let* ((ptst (next (car p)
                                                                                                               eta
                                                                                                               sf
                                                                                                               (lambda (sf)
                                                                                                                 #f)
                                                                                                               (lambda (sf)
                                                                                                                 #t)))
                                                                                                   (tst (if (and (pair?
                                                                                                                   ptst)
                                                                                                                 (symbol?
                                                                                                                   (car ptst))
                                                                                                                 (pair?
                                                                                                                   (cdr ptst))
                                                                                                                 (eq? eta
                                                                                                                      (cadr ptst))
                                                                                                                 (null?
                                                                                                                   (cddr ptst)))
                                                                                                            (car ptst)
                                                                                                            `(lambda (,eta)
                                                                                                               ,ptst))))
                                                                                              (assm `(match:andmap
                                                                                                       ,tst
                                                                                                       ,e)
                                                                                                    (kf sf)
                                                                                                    (ks sf))))
                                                                                  ((and (symbol?
                                                                                          (car p))
                                                                                        (equal?
                                                                                          (list (car p))
                                                                                          bound)) (next (car p)
                                                                                                        e
                                                                                                        sf
                                                                                                        kf
                                                                                                        ks))
                                                                                  (else (let* ((gloop (list-ref
                                                                                                        p
                                                                                                        3))
                                                                                               (ge (list-ref
                                                                                                     p
                                                                                                     4))
                                                                                               (fresh (list-ref
                                                                                                        p
                                                                                                        5))
                                                                                               (p1 (next (car p)
                                                                                                         `(car ,ge)
                                                                                                         sf
                                                                                                         kf
                                                                                                         (lambda (sf)
                                                                                                           `(,gloop
                                                                                                              (cdr ,ge)
                                                                                                              ,@(map (lambda (b
                                                                                                                              f)
                                                                                                                       `(cons ,(val b)
                                                                                                                              ,f))
                                                                                                                     bound
                                                                                                                     fresh))))))
                                                                                          (set! v
                                                                                            (append
                                                                                              (map cons
                                                                                                   bound
                                                                                                   (map (lambda (x)
                                                                                                          `(reverse
                                                                                                             ,x))
                                                                                                        fresh))
                                                                                              v))
                                                                                          `(let ,gloop
                                                                                             ((,ge ,e)
                                                                                              ,@(map (lambda (x)
                                                                                                       `(,x '()))
                                                                                                     fresh))
                                                                                             (if (null?
                                                                                                   ,ge)
                                                                                                 ,(ks sf)
                                                                                                 ,p1)))))))))
                                                                   (case k
                                                                     ((0) (ks sf))
                                                                     ((1) (emit `(pair?
                                                                                   ,e)
                                                                                sf
                                                                                kf
                                                                                ks))
                                                                     (else (emit `((,length>=
                                                                                     ,k)
                                                                                   ,e)
                                                                                 sf
                                                                                 kf
                                                                                 ks)))))))
                            (else (display
                                    "FATAL ERROR IN PATTERN MATCHER")
                             (newline)
                             (error #f "THIS NEVER HAPPENS"))))))))
           )
    (list gen)))
