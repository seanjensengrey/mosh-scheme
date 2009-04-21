(let ([socket (make-client-socket "www.monaos.org" "http"
                                  (os-constant 'AF_INET)
                                  (os-constant 'SOCK_STREAM)
                                  0
                                  0)])
  (socket-send socket (string->utf8 "GET /index.html HTTP/1.0\r\nhost: www.monaos.org\r\n\r\n") 0)
  (display (utf8->string (socket-recv socket 1000 0)))
  (socket-close socket))
