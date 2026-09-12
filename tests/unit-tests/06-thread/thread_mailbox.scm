(include "#.scm")

(define t-recv
  (make-thread
   (lambda ()
     (thread-receive))))

(thread-start! t-recv)
(test-equal (void) (thread-send t-recv 'hello))
(test-eq 'hello (thread-join! t-recv 2.0 'join-timeout))

(define t-timeout
  (make-thread
   (lambda ()
     (thread-receive 0.05 'timeout-default))))

(test-eq 'timeout-default
         (thread-join! (thread-start! t-timeout) 2.0 'join-timeout))

(define t-next
  (make-thread
   (lambda ()
     (thread-send (current-thread) 'queued)
     (thread-mailbox-next))))

(test-eq 'queued (thread-join! (thread-start! t-next) 2.0 'join-timeout))

(test-error-tail type-exception? (thread-send #f 'x))
(test-error-tail type-exception? (thread-receive 'not-a-timeout))
(test-error-tail wrong-number-of-arguments-exception? (thread-send))
(test-error-tail wrong-number-of-arguments-exception? (thread-send t-recv))
(test-error-tail
 wrong-number-of-arguments-exception?
 (thread-send t-recv 'x 'y))
