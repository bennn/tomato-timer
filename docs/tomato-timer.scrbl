#lang scribble/manual

@require[(for-label racket/base tomato-timer)]

@title{Tomato Timer}
@author{@hyperlink["https://www.github.com/bennn"]{Ben Greenman}}

To start a 25 minute timer:
@racketblock[
  raco tomato-timer
]

To start an @racket[N] minute timer:
@racketblock[
  raco tomato-timer N
]
