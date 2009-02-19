; input-port.scm - Tests for <input port>
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
;  $Id: test.ss 621 2008-11-09 06:22:47Z higepon $


(import (rnrs)
        (mosh test))

(define (with-all-buffer-mode proc)
  (for-each proc (list (buffer-mode none) (buffer-mode block) (buffer-mode line))))

;; open-file-input-port with transcoder
(with-all-buffer-mode
 (lambda (mode)
   (let ([port (open-file-input-port "./test/utf16.txt" (file-options) mode (make-transcoder (utf-16-codec)))])
     (test/t (input-port? port))
     (test* (read port) "あいう")
     (test/f (port-eof? port)) ;; #f for textual port
     (close-port port))))

;; open-bytevector-input-port
(let ([port (open-bytevector-input-port (u8-list->bytevector (map char->integer (string->list "abc")))
                                        (make-transcoder (utf-8-codec)))])
  (test* (read-char port) #\a)
  (test* (read-char port) #\b)
  (test* (read-char port) #\c)
  (test/t (eof-object? (read-char port))))

(let ([port (open-bytevector-input-port (u8-list->bytevector (map char->integer (string->list "abc"))))])
  (test* (get-u8 port) (char->integer #\a))
  (test* (get-u8 port) (char->integer #\b))
  (test* (get-u8 port) (char->integer #\c))
  (test/t (eof-object? (get-u8 port))))

;; custom input-port
(let* ([pos 0]
       [p (make-custom-binary-input-port
           "custom in"
           (lambda (bv start count)
             (if (= pos 16)
                 0
                 (begin
                   (set! pos (+ 1 pos))
                   (bytevector-u8-set! bv start pos)
                   1)))
           (lambda () pos)
           (lambda (p) (set! pos p))
           (lambda () 'ok))])
  (test/t (port-has-port-position? p))
  (test/t (port-has-set-port-position!? p))
  (test* (port-position p) 0)
  (test* (get-bytevector-n p 3) #vu8(1 2 3))
  (test* (port-position p) 3)
  (test* (lookahead-u8 p) 4)
  (test* (lookahead-u8 p) 4)
  (test* (port-position p) 3)
  (set-port-position! p 10)
  (get-bytevector-n p 2)
  (test* (get-bytevector-n p 2) #vu8(13 14))
  (test* (get-bytevector-n p 2) #vu8(15 16))
  (test* (get-bytevector-n p 2) (eof-object))
  (set-port-position! p 2)
  (test* (get-bytevector-n p 3) #vu8(3 4 5))
  (close-port p))

;; standard-input-port doesn't suport port-position on Mosh.
(test/f (port-has-port-position? (standard-input-port)))
(test/f (port-has-set-port-position!? (standard-input-port)))
(test/violation? (set-port-position! (standard-input-port) 0))
(test/violation? (port-position (standard-input-port)))

(test-end)
