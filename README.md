tomato-timer
====
[![Scribble](https://img.shields.io/badge/Docs-Scribble-blue.svg)](http://docs.racket-lang.org/tomato-timer/index.html)

A command-line timer.

### Usage:

To start a 25-minute timer:

```
  $ raco tomato-timer
```


### Advanced Usage:

To start an `N` minute timer:

```
  $ raco tomato-timer <N>
```

To record TODO list items while the timer is running, type them in the terminal:

```
  $ raco tomato-timer
  feed the cat
  google 'ron paul'
  clean keyboard
```

This will print:

```
  TIME UP
  postponed items:
  - [ ] feed the cat
  - [ ] google 'ron paul'
  - [ ] clean keyboard
```


### Install

```
  raco pkg install tomato-timer
```
