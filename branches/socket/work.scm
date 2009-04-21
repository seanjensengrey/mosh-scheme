(display (make-client-socket "www.monaos.org" "22"
                             (os-constant 'AF_INET)
                             (os-constant 'SOCK_STREAM)
                             0
                             0))
