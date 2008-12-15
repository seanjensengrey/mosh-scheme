;; (disasm
;;  (lambda ()
;;   ((lambda (a b) (+ a b)) x y)))

(disasm
 (lambda ()
  (let ([a x] [b y]) (+ a b))))
