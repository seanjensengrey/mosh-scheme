;;; Ikarus Scheme -- A compiler for R6RS Scheme.
;;; Copyright (C) 2006,2007,2008  Abdulaziz Ghuloum
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License version 3 as
;;; published by the Free Software Foundation.
;;;
;;; This program is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(library (psyntax compat)
  (export define-record make-parameter parameterize format gensym
          eval-core symbol-value set-symbol-value!
          make-struct-type read-annotated
          annotation? annotation-expression annotation-source
          annotation-stripped
          read-library-source-file
          library-version-mismatch-warning
          library-stale-warning
          file-locator-resolution-error
          label-binding set-label-binding! remove-location
          make-source-position-condition)
  (import
;    (only (ikarus.compiler) eval-core)
;    (only (ikarus.reader.annotated) read-library-source-file)
;    (ikarus))
    (rnrs)
    (rnrs mutable-pairs)
    (except (mosh) make-parameter parameterize)
    (only (system) get-environment-variable)
    (only (psyntax system $bootstrap)
          void gensym eval-core set-symbol-value! symbol-value))


  ;; mosh 
  (define (make-record-printer name proc) display)
  ;; mosh
  (define-condition-type &source-position &condition
    make-source-position-condition source-position-condition?
    (file-name source-position-file-name)
    (character source-position-character))
  
  ;; Mosh

  ;; mosh
  (define (make-struct-type . x)
    (error 'make-struct-type "mosh doesn't need this, because define-struct-macro is unused"))

  (define (library-version-mismatch-warning name depname filename)
    (format (current-error-port)
        "WARNING: library ~s has an inconsistent dependency \
         on library ~s; file ~s will be recompiled from \
         source.\n"
       name depname filename))
 
  (define (library-stale-warning name filename)
    (format (current-error-port)
       "WARNING: library ~s is stale; file ~s will be recompiled from source.\n"
       name filename))

  (define (file-locator-resolution-error libname failed-list pending-list)
    (define-condition-type &library-resolution &condition
       make-library-resolution-condition
       library-resolution-condition?
       (library condition-library)
       (files condition-files))
    (define-condition-type &imported-from &condition
       make-imported-from-condition imported-from-condition?
       (importing-library importing-library))

    (raise 
      (apply condition (make-error)
        (make-who-condition 'expander)
        (make-message-condition
          "cannot locate library in library-path")
        (make-library-resolution-condition 
          libname failed-list)
        (map make-imported-from-condition pending-list))))


;;   (define-syntax define-record
;;     (syntax-rules ()
;;       [(_ name (field* ...) printer)
;;        (begin
;;          (define-struct name (field* ...))
;;          (module ()
;;             (set-rtd-printer! (type-descriptor name)
;;               printer)))]
;;       [(_ name (field* ...))
;;        (define-struct name (field* ...))]))

  (define (set-label-binding! label binding)
    (set-symbol-value! label binding))

  (define (label-binding label)
    (guard (c (#t #f))
    (symbol-value label))) ; mosh
;    (and (symbol-bound? label) (symbol-value label)))

;;   (define (remove-location x)
;;     (import (ikarus system $symbols))
;;     ($unintern-gensym x))

  ;; Mosh
  (define (remove-location x)
    (gensym x))


  ;; defined for mosh
  (define read-annotated read)
  (define (annotation-stripped x) (annotation-expression x)) ;; what is difference between annotation-stripped and annotation-expression?
  (define (annotation? x) (source-info x))
  (define (annotation-source x) (source-info x))
  (define (annotation-expression x)
    (if (pair? x)
        (cons (car x) (cdr x))
        (display "line:46\n")))

  (define (scm->fasl filename)
    (string-append filename ".mosh-fasl"))

  (define (fasl-save filename obj)
    (call-with-port (open-file-output-port filename) (lambda (port) ((symbol-value 'fasl-write!) obj port))))

  (define (fasl-load filename)
    (call-with-port (open-file-input-port filename) (symbol-value 'fasl-read!)))

  (define (serialize-library filename obj)
    (format #t "serialize-library ~a\n..." filename)
    (let* ([expanded2core (symbol-value 'expanded2core)]
           [compile (symbol-value 'compile-w/o-halt)]
           [code obj]
           [pivot (cddddr (cddddr code))]
           [visit (compile (expanded2core (car pivot)))])
      (set-car! pivot visit)
      (let* ([pivot (cdr pivot)]
             [invoke (compile (expanded2core (car pivot)))])
        (set-car! pivot invoke)))
    (let ([fasl-file (scm->fasl filename)])
      (when (file-exists? fasl-file)
        (delete-file fasl-file))
      (guard [c (#t (format #t "Warning:serialize-library failed " filename)
                    (when (file-exists? fasl-file)
                      (delete-file fasl-file))
                    #f)]
             (fasl-save fasl-file obj)
             (display "OK\n"))))

  (define (load-serialized-library filename obj)
    (let ([fasl-file (scm->fasl filename)])
      ;; todo we may use file-newer? directory.
      (if (and (file-exists? fasl-file) ((symbol-value 'file-newer?) fasl-file filename))
          (let* ([expanded2core (symbol-value 'expanded2core)]
                 [eval-compiled-core (symbol-value 'eval-compiled!)]
                 [code (fasl-load fasl-file)]
                 [pivot (cddddr (cddddr code))]
                 [visit (car pivot)]
                 [visit-proc (lambda () (eval-compiled-core visit))])
            (set-car! pivot visit-proc)
            (let* ([pivot (cdr pivot)]
                   [invoke (car pivot)])
              (set-car! pivot (lambda () (eval-compiled-core invoke)))
              (apply obj code))
            #t)
          #f)))

  (define (read-library-source-file file-name)
        (with-input-from-file file-name read-annotated))

  (define make-parameter
    (case-lambda
      ((x) (make-parameter x (lambda (x) x)))
      ((x fender)
       (let ((x (fender x)))
         (case-lambda
           (() x)
           ((v) (set! x (fender v))))))))

  (define-syntax parameterize
    (lambda (x)
      (syntax-case x ()
        ((_ () b b* ...) (syntax (let () b b* ...)))
        ((_ ((olhs* orhs*) ...) b b* ...)
         (with-syntax (((lhs* ...) (generate-temporaries (syntax (olhs* ...))))
                       ((rhs* ...) (generate-temporaries (syntax (olhs* ...)))))
           (syntax (let ((lhs* olhs*) ...
                   (rhs* orhs*) ...)
               (let ((swap
                      (lambda ()
                        (let ((t (lhs*)))
                          (lhs* rhs*)
                          (set! rhs* t))
                        ...)))
                 (dynamic-wind
                   swap
                   (lambda () b b* ...)
                   swap)))))))))

(define-syntax define-record
  (lambda (x)
      (define (syn->str s)
          (symbol->string
              (syntax->datum s)))
    (define (gen-getter id)
      (lambda (fld)
        (datum->syntax id
          (string->symbol
            (string-append (syn->str id) "-" (syn->str fld))))))
    (define (gen-setter id)
      (lambda (fld)
        (datum->syntax id
          (string->symbol
            (string-append "set-" (syn->str id) "-" (syn->str fld) "!")))))
    (syntax-case x ()
      [(_ name (field* ...) printer)
       #`(begin 
           (define-record name (field* ...)) 
           (define rp (make-record-printer 'name printer)))]
      [(_ name (field* ...))
       (with-syntax ([(getter* ...)
                      (map (gen-getter #'name) #'(field* ...))]
                     [(setter* ...)
                      (map (gen-setter #'name) #'(field* ...))])
         #`(define-record-type name
             (sealed #t) ; for better performance
             (opaque #t) ; for security
             (nongenerative) ; for sanity
             (fields (mutable field* getter* setter*) ...)))])))
)
