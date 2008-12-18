
(let loop ([ret '(a b c)])
  (if (null? ret)
      '()
      (loop (cdr ret))))
