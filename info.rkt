#lang info
(define collection "tomato-timer")
(define deps '("base"))
(define build-deps '("racket-doc" "rackunit-lib" "scribble-lib"))
(define pkg-desc "Command-line timer")
(define version "0.1")
(define pkg-authors '(ben))
(define scribblings '(("docs/tomato-timer.scrbl" () (omit-start))))
(define raco-commands '(("tomato-timer" (submod tomato-timer/main main) "Start a new timer" #f)))
