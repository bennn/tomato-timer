#lang info
(define collection "tomato-timer")
(define deps '("base"))
(define build-deps '("racket-doc" "rackunit-lib"))
(define pkg-desc "Command-line timer")
(define version "0.0")
(define pkg-authors '(ben))
(define scribblings '(("docs/tomato-timer.scrbl" () (omit))))
(define raco-commands '(("tomato-timer" (submod tomato-timer/main main) "Start a new timer" #f)))