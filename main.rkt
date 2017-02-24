#lang racket/base

;; Sleep for N minutes
;;   racket tomato-timer.rkt N

(define (tomato-timer minutes)
  (sleep (* 60 minutes)))

(module+ main
  (require racket/cmdline)
  (command-line
    #:program "tomato-timer"
    #:args ([sleep-for "25"])
    (let ([n (string->number sleep-for)])
      (unless (exact-positive-integer? n)
        (raise-argument-error 'tomato-timer "a positive integer" n))
      (tomato-timer n))))

