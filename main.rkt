#lang racket/base

;; Sleep for N minutes
;;   racket tomato-timer.rkt N

;; -----------------------------------------------------------------------------

(require
  (only-in racket/date
    current-date
    date->string
    date-display-format)
  (only-in racket/string
    non-empty-string?
    string-trim))

;; =============================================================================

;; make-piper : input-port? output-port? -> thread?
;; Create a thread to pipe input from `in-port` to `out-port`.
;; Immediately returns a new thread descriptor.
(define (make-piper in-port out-port)
  (thread (λ ()
    (let loop ()
      (let ([ln (read-line in-port)])
        (when (not (eof-object? ln))
          (displayln ln out-port)
          (loop)))))))

;; make-sleeper : exact-postive-integer? -> thread?
;; Create a thread that sleeps for a given number of minutes.
;; Immediately returns a new thread descriptor.
(define (make-sleeper minutes)
  (thread (λ () (sleep (* 60 minutes)))))

;; print-todo-list : input-port -> void?
;; Read input from a port that describes a TODO list
(define (print-todo-list in-port)
  (displayln "TIME UP")
  (define ln (read-line in-port))
  (when (not (eof-object? ln))
    (displayln "postponed items:")
    (displayln (format-todo-item ln))
    (for ([ln (in-lines in-port)])
      (define str (string-trim ln))
      (when (non-empty-string? str)
        (displayln (format-todo-item str)))
      (void))))

;; format-todo-item : string? -> string?
(define (format-todo-item str)
  (string-append "- [ ] " str))

(define (print-start)
  (define d (current-date))
  (parameterize ([date-display-format 'iso-8601])
    (printf "starting timer (current time: ~a:~a)~n" (date-hour d) (date-minute d))
    (void)))

(define (tomato-timer minutes)
  (print-start)
  (define-values (_in _out) (make-pipe #f 'tomato-in 'tomato-out))
  (define t (make-piper (current-input-port) _out))
  (define s (make-sleeper minutes))
  (thread-wait s)
  (kill-thread t)
  (close-output-port _out)
  (print-todo-list _in)
  (close-input-port _in)
  (void))

(module+ main
  (require racket/cmdline)
  (command-line
    #:program "tomato-timer"
    #:args ([sleep-for "25"])
    (let ([n (string->number sleep-for)])
      (unless (exact-positive-integer? n)
        (raise-argument-error 'tomato-timer "a positive integer" n))
      (tomato-timer n))))

