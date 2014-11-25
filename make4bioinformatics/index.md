---
title       : Reproducible research without the reading
subtitle    : Using make for bioinformatics
author      : Kathryn Iverson
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## tl;dnr research

Just the facts, ma'am

1. Run code exactly as the author ~~intended~~ wrote it
2. Build and execute complicated commands on multiple files or with multiple parameters
3. Don't re-run code unnecessarily


--- .class #id 

## GNU make

* Make is a tool that automatically builds stuff (usually software) based on directions given in a makefile

* Make runs command line instructions quickly and efficiently

## What is a makefile?

Simply, a makefile is a file that contains a set of instructions (rules) to build a file (the target)

---

## A simple example

hello_make:
```{shell}
say_hi:
  echo "hello world"
```

say_hi is the target and `echo "hello world"` is the rule
```
pintsize: kiverson$ make -f hello_make say_hi 
echo "hello world"
hello world
```

By default make looks for a file called Makefile but it can be named anything (hello_make) and is given with the -f option. 

We tell make to make the target 'say_hi' and it does so by executing the rules and printing them to the screen. An @ before the command disables printing.

---

## A longer example

---

## Targets
Targets can be files and the rule(s) will only execute if the file doesn't exits

## Rules
Rules can be multiple lines
