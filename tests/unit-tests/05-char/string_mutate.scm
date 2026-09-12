(include "#.scm")

(test-equal "bcd" (string-copy "abcde" 1 4))
(test-equal "abcde" (string-copy "abcde"))
(test-equal "abxde"
  (let ((s (string #\a #\b #\c #\d #\e)))
    (string-set! s 2 #\x)
    s))
(test-equal "xxxxx"
  (let ((s (string #\a #\b #\c #\d #\e)))
    (string-fill! s #\x)
    s))
(test-error-tail type-exception? (string-copy 1))
(test-error-tail type-exception? (string-set! 1 0 #\x))
(test-error-tail type-exception? (string-fill! 1 #\x))
