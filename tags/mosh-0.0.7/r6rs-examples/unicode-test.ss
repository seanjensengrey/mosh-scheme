(import (rnrs)
        (mosh test))

(test* "\x41;" "A")
(test* "\x41;\x42;C\x44;" "ABCD")
(test* (string-normalize-nfd "a\x0308;\x0323;か\x3099;e\x304;\x301;\x323;") "a\x0323;\x0308;か\x3099;e\x323;\x304;\x301;")