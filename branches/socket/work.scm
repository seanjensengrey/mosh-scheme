(let ([socket (make-client-socket "www.monaos.org" "ssh"
                                  (os-constant 'AF_INET)
                                  (os-constant 'SOCK_STREAM)
                                  0
                                  0)])
  (display (utf8->string (socket-recv socket 1000 0))))
