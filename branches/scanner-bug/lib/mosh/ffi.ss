; ffi.ss - Foreign Function Interface.
;
;   Copyright (c) 2009  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
;
;   Redistribution and use in source and binary forms, with or without
;   modification, are permitted provided that the following conditions
;   are met:
;
;   1. Redistributions of source code must retain the above copyright
;      notice, this list of conditions and the following disclaimer.
;
;   2. Redistributions in binary form must reproduce the above copyright
;      notice, this list of conditions and the following disclaimer in the
;      documentation and/or other materials provided with the distribution.
;
;   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
;  $Id: ffi.ss 621 2008-11-09 06:22:47Z higepon $

#|
    Title: Foreign Function Interface

    What is FFI?:
    Mosh provides a general Foreign Function Interface (FFI) methods.

    With these methods, you can load shared library, call C-function in it and get a result of function call.

    Example:
    (start code)
    ;; use mysql client library
    (let* ([libmysqlclient (open-shared-library "libmysqlclient.so.15")]
           [mysql-init     (c-function libmysqlclient void* mysql_init void*)])
      (display (mysql-init 0)))
    (end code)

    (start code)
    ;; generate png image with Cairo library.
    (import (rnrs)
            (mosh ffi))

    (let* ((libcairo (open-shared-library "libcairo.so"))
             (cairo-image-surface-create (c-function libcairo void* cairo_image_surface_create int int int))
             (cairo-surface-write-to-png (c-function libcairo int cairo_surface_write_to_png void* char*))
             (cairo-create (c-function libcairo void* cairo_create void*))
             (set-line-width (c-function libcairo void cairo_set_line_width void* double))
             (rgba (c-function libcairo void cairo_set_source_rgba void* double double double double))
             (move-to (c-function libcairo void cairo_move_to void* double double))
             (line-to (c-function libcairo void cairo_line_to void* double double))
             (TOY-show-text (c-function libcairo void cairo_show_text void* char*))
             (stroke (c-function libcairo void cairo_stroke void*)))

           (let* ((surface (cairo-image-surface-create 1 300 300))
                  (ctx (cairo-create surface)))
             (rgba ctx 1.0 1.0 1.0 1.0)
             (set-line-width ctx 8.0)
             (move-to ctx 10.0 10.0)
             (line-to ctx 10.0 290.0)
             (line-to ctx 290.0 290.0)
             (line-to ctx 290.0 10.0)
             (line-to ctx 10.0 10.0)
             (move-to ctx 100.0 150.0)
             (TOY-show-text ctx "mosh")
             (stroke ctx)
             (display (cairo-surface-write-to-png surface "test.png"))))
    (end code)


    library: (mosh ffi)

    Foreign Function Interface Library
|#
(library (mosh ffi)
  (export make-c-function c-function open-shared-library find-shared-libray
          (rename (%ffi-pointer->string pointer->string) (%ffi-pointer-ref pointer-ref)
                  (%ffi-supported? ffi-supported?)))
  (import (only (rnrs) define define-syntax syntax-case lambda map let syntax exists
                       quasiquote unless assertion-violation quote = length and number?
                       for-each apply hashtable-ref unquote integer? string? ... or zero? filter
                       for-all procedure? flonum? fixnum? cond else inexact guard file-exists? find)
          (only (mosh) alist->eq-hash-table format readdir)
          (rename (system) (%ffi-open open-shared-library))
          (only (system) %ffi-lookup %ffi-call->void %ffi-call->void* %ffi-call->int %ffi-call->double %ffi-call->string-or-zero))
#|
    Function: ffi-supported?

    Returns #t when ffi is supported, otherwise #f.

    Prototype:
    > (ffi-supported?)

    Returns:

      #t when ffi is supported, otherwise #f.
|#

#|
    Function: pointer->string

    Returns string value at which pointer points.

    Prototype:
    > (pointer->string pointer)

    Parameters:

      pointer - integer valued pointer. When not-pointer integer is passed, it may cause crash.

    Returns:

      string value at which pointer points.
|#

#|
    Function: pointer-ref

    Refer the value of pointer[index].

    Prototype:
    > (pointer-ref pointer . index)

    Parameters:

      pointer - integer valued pointer. When not-pointer integer is passed, it may cause crash.
      index   - index. default values is 0.

    Returns:

      pointer value of pointer[index]
|#


#|
    Function: open-shared-library

    Open shared library.

    Prototype:
    > (open-shared-library library)

    Parameters:

      library - Path to library.

    Returns:

      Loaded shared library object.

    Errors:
      Raise error when can't load library
|#


#|
    Function: c-function

    Make foreign c-function closure.

    Prototype:
    > (c-function lib ret func . arg)

    Parameters:

      lib - library object returned by <open-shared-library>
      ret - return type of c-function. void*, char*, void, double and int are supported.
      func - name of c-function as symbol
      arg - list of argument types. void*, int, double and char* are supported.

    Returns:

      Foreign function closure
|#
(define-syntax c-function
  (lambda (x)
    (syntax-case x ()
      [(_ lib ret func arg ...)
       #'(make-c-function lib 'ret 'func '(arg ...)))]))

(define stub-ht (alist->eq-hash-table
                 `((void*  . ,%ffi-call->void*)
                   (char*  . ,%ffi-call->string-or-zero) ;; char* may be NULL,
                   (void   . ,%ffi-call->void)
                   (double . ,%ffi-call->double)
                   (int    . ,%ffi-call->int))))

(define checker-ht (alist->eq-hash-table
                    `((void*  . ,(lambda (x) (and (integer? x) x)))
                      (int    . ,(lambda (x) (and (integer? x) x)))
                      (double . ,(lambda (x) (cond
                                              [(flonum? x) x]
                                              [(fixnum? x) (inexact x)]
                                              [else #f])))
                      (char*  . ,(lambda (x) (and (or (and (number? x) (zero? x)) string?) x))))))

(define (find-shared-libray regex)
  (exists
   (lambda (path)
     (find regex (guard [c (#t '())] (readdir path))))
   (filter file-exists? '("/lib" "/usr/lib/" "/usr/local/lib"))))

(define (make-c-function lib ret-type name arg-types)
  (let ([func (%ffi-lookup lib name)]
        [stub (hashtable-ref stub-ht ret-type #f)]
        [checkers (map (lambda (type) (hashtable-ref checker-ht type #f)) arg-types)])
    (unless (for-all procedure? checkers)
      (assertion-violation 'c-function "invalid argument type for c-function"))
    (unless stub
      (assertion-violation 'c-function "wrong return type" ret-type))
    (unless func
      (assertion-violation 'c-function "c-function not found" name))
    (lambda args
      (unless (= (length arg-types) (length args))
        (assertion-violation name (format "wrong arguments number ~d required, but got ~d"
                                          (length arg-types)
                                          (length args)) args))
      (apply stub func (map
                        (lambda (checker arg)
                          (let ([valid-arg (checker arg)])
                            (unless valid-arg
                              (assertion-violation name "wrong argument " arg))
                            valid-arg))
                        checkers
                        args)))))
)