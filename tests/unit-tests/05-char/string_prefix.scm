(include "#.scm")

(test-eq #t (string-prefix? "ab" "abracadabra"))
(test-eq #f (string-prefix? "ba" "abracadabra"))
(test-eq #t (string-suffix? "bra" "abracadabra"))
(test-eq #f (string-suffix? "abr" "abracadabra"))
(test-error-tail type-exception? (string-prefix? 1 "ab"))
(test-error-tail type-exception? (string-suffix? "ab" 1))
