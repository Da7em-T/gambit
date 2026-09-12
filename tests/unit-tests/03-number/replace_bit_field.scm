(include "#.scm")

(test-assert (exact-integer? (replace-bit-field 4 2 1 240)))
(test-error-tail type-exception? (replace-bit-field 'a 2 1 240))
(test-error-tail wrong-number-of-arguments-exception? (replace-bit-field 4 2 1))
(test-error-tail wrong-number-of-arguments-exception? (replace-bit-field 4 2 1 240 0))
