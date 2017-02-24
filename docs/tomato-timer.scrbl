#lang scribble/manual

@require[(for-label racket/base tomato-timer)]

@title{Tomato Timer}
@author{@hyperlink["https://www.github.com/bennn"]{Ben Greenman}}

@defmodule[tomato-timer]

To start a 25 minute timer:
@verbatim{
  $ raco tomato-timer
}

To start an @racket[N] minute timer:
@verbatim{
  $ raco tomato-timer N
}

To record TODO list items while the timer is running, type them in the terminal:

@verbatim{
  $ raco tomato-timer
  feed the cat
  google 'ron paul'
  clean keyboard
}

This example will print:

@verbatim{
  TIME UP
  postponed items:
  - [ ] feed the cat
  - [ ] google 'ron paul'
  - [ ] clean keyboard
}
