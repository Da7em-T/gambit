(include "#.scm")

(define p (make-parameter 1))

(test-equal 1 (p))
(test-equal 2 (begin (p 2) (p)))
(test-equal 3 (parameterize ((p 3)) (p)))
(test-equal 2 (p))
(test-equal 4 (parameterize ((p 4)) (parameterize ((p 5)) (p)) (p)))
(test-equal 2 (p))

(define q
  (make-parameter
   0
   (lambda (x)
     (if (number? x)
         (* x 2)
         (error "n")))))

(test-equal 0 (q))
(test-equal 10 (begin (q 5) (q)))
(test-equal 8 (parameterize ((q 4)) (q)))
(test-equal 10 (q))
(test-assert (procedure? p))
(test-assert (procedure? q))
(test-error error-exception? (q 'nope))
(test-error-tail type-exception? (make-parameter 1 'not-a-procedure))
(test-error-tail type-exception? (make-parameter 1 2 3))
(test-error-tail wrong-number-of-arguments-exception? (make-parameter))
