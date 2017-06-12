#lang racket/base

;; Sleep for N minutes
;;   racket tomato-timer.rkt N

;; -----------------------------------------------------------------------------

(require
  (only-in racket/date
    current-date
    date->string
    date-display-format)
  (only-in racket/format
    ~a)
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
;; Create a thread that sleeps for a given number of seconds.
;; Immediately returns a new thread descriptor.
(define (make-sleeper seconds)
  (thread (λ () (sleep seconds))))

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
    (printf "starting timer (current time: ~a:~a)~n" (two-digits (date-hour d)) (two-digits (date-minute d)))
    (void)))

(define (two-digits n)
  (~a n #:align 'right #:min-width 2 #:left-pad-string "0"))

(define (tomato-timer seconds)
  (print-start)
  (define-values (_in _out) (make-pipe #f 'tomato-in 'tomato-out))
  (define t (make-piper (current-input-port) _out))
  (define s (make-sleeper seconds))
  (thread-wait s)
  (kill-thread t)
  (close-output-port _out)
  (print-todo-list _in)
  (close-input-port _in)
  (void))

(define (time->seconds n unit)
  (case unit
   [(H) (* n 3600)]
   [(M) (* n 60)]
   [(S) n]
   [else (raise-argument-error 'time->seconds "(or/c 'H 'M 'S)" 1 n unit)]))

(module+ main
  (require racket/cmdline)
  (define units (box 'M))
  (command-line
    #:program "tomato-timer"
    #:once-any
    [("-M" "--minutes") "Sleep for N minutes (default)" (set-box! units 'M)]
    [("-H" "--hours") "Sleep for N hours" (set-box! units 'H)]
    [("-S" "--seconds") "Sleep for N seconds" (set-box! units 'S)]
    #:args ([sleep-for "25"])
    (let ([n (string->number sleep-for)])
      (unless (exact-positive-integer? n)
        (raise-argument-error 'tomato-timer "a positive integer" n))
      (tomato-timer (time->seconds n (unbox units))))))

