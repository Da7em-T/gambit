(include "#.scm")

(define-type-of-thread mythread)

(define t-uninit (make-mythread))

(define e-uninit
  (with-exception-catcher
   (lambda (x) x)
   (lambda () (thread-name t-uninit))))

(test-assert (uninitialized-thread-exception? e-uninit))
(test-eq thread-name (uninitialized-thread-exception-procedure e-uninit))
(test-eq t-uninit (car (uninitialized-thread-exception-arguments e-uninit)))
(test-assert (eq? #f (uninitialized-thread-exception? #f)))

(define t-term (make-thread (lambda () (thread-sleep! 10) 1)))
(thread-start! t-term)
(thread-terminate! t-term)

(define e-term
  (with-exception-catcher
   (lambda (x) x)
   (lambda () (thread-join! t-term))))

(test-assert (terminated-thread-exception? e-term))
(test-eq thread-join! (terminated-thread-exception-procedure e-term))
(test-eq t-term (car (terminated-thread-exception-arguments e-term)))
(test-assert (eq? #f (terminated-thread-exception? #f)))

(define t-started (make-thread (lambda () 1)))
(thread-start! t-started)

(define e-started
  (with-exception-catcher
   (lambda (x) x)
   (lambda () (thread-start! t-started))))

(test-assert (started-thread-exception? e-started))
(test-eq thread-start! (started-thread-exception-procedure e-started))
(test-eq t-started (car (started-thread-exception-arguments e-started)))
(test-assert (eq? #f (started-thread-exception? #f)))

(test-eq 1 (thread-join! t-started 2.0 'join-timeout))

(test-error-tail type-exception? (uninitialized-thread-exception-procedure #f))
(test-error-tail type-exception? (uninitialized-thread-exception-arguments #f))
(test-error-tail type-exception? (terminated-thread-exception-procedure #f))
(test-error-tail type-exception? (terminated-thread-exception-arguments #f))
(test-error-tail type-exception? (started-thread-exception-procedure #f))
(test-error-tail type-exception? (started-thread-exception-arguments #f))
