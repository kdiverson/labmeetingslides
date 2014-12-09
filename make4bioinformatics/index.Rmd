---
title       : Reproducible research without the reading
subtitle    : Using make for bioinformatics
author      : Kathryn Iverson
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : standalone # {standalone, draft, selfcontained}
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

* Simply, a makefile is a file that contains a set of instructions (rules) to build a file (the target)

* Actually, it's a ~40 year old functional programming language, sort of

---

## A simple example

hello_make:
```
say_hi:
  echo "hello world"
```

say_hi is the target and `echo "hello world"` is the rule
```
pintsize:make4bioinformatics kiverson$ make -f hello_make say_hi 
echo "hello world"
hello world
```

By default make looks for a file called Makefile but it can be named anything (hello_make) and is given with the -f option. 

We tell make to make the target 'say_hi' and it does so by executing the rules and printing them to the screen. An @ before the command disables printing.

---

## Another example
```
hello.txt:
  @echo "hello world" > $@
  @echo "today is `date`" >> $@
```

```
pintsize:make4bioinformatics kiverson$ make -f hello_make hello.txt
pintsize:make4bioinformatics kiverson$ cat hello.txt 
hello world
today is Tue Nov 25 11:50:45 CST 2014
pintsize:make4bioinformatics kiverson$ make -f hello_make hello.txt
make: `hello.txt' is up to date.
pintsize:make4bioinformatics kiverson$
```

### Targets and Rules
Targets can be files and the rule(s) will only execute if the file doesn't exits. Rules can be on multiple lines.

---

## Special characters


@ -> don't print command to screen `@echo`

$@ -> placeholder for target file  `@echo "hello world" > $@`
```
FILES = hello1.txt hello2.txt hello3.txt

all: $(FILES)

%.txt:
  touch $*.txt

clean:
	rm $(FILES)
```
% -> wildcard `%.txt`

$* -> retrieves value from wildcard `touch $*.txt`

'-' beforea command ignores errors `-echo`

---

## Parallelization

Make can seperate processes onto different processors with the -j option

```
make -j 3
```

This makes all the .txt files at once in parallel

```
FILES = hello1.txt hello2.txt hello3.txt

all: $(FILES)

%.txt:
  touch $*.txt

clean:
  rm $(FILES)
```

---

## Prereqs and conditionals

```
target: (conditionals)
  commands
```

```
results.txt: contigs1.fa contigs2.fa
  cat contigs1.fa contigs2.fa | ./contigstats > results.txt
```

Make will create results.txt if contigs1.fa and contigs2.fa exist and will create them first if they don't. Will also update any target file if it's older than the conditionals.

```
contigs1.fa:
  python get_contigs.py > contigs1.fa
  
results.txt: contigs1.fa contigs2.fa
  cat contigs1.fa contigs2.fa | ./contigstats > results.txt
```

results.txt will be recalculated when contigs1.fa is run.

---

make_assembly:

```
contigs1.fa: reads1.fa
  velveth assembly1 reads1.fa
  velvetg assembly1
  mv assembly1/contigs.fa contigs1.fa

contigs2.fa: reads2.fa
  velveth assembly2 reads2.fa
  velvetg assembly2
  mv assembly2/contigs.fa contigs2.fa

results.txt: contigs1.fa contigs2.fa
  cat contigs1.fa contigs2.fa | ./contigstats > results.txt
  
N50: contigs1.fa contigs2.fa
  ./calcN50 contigs1.fa
  ./calcN50 contigs2.fa
```

---

## Variables

* Declared with '=' and called with '$()'

make_contigs
```
CONTIGS = contigs1.fa contigs2.fa

print_contigs:
  @echo "the contig files are $(CONTIGS)"
```

```
pintsize:make4bioinformatics kiverson$ make -f make_contigs print_contigs
the contig files are contigs1.fa contigs2.fa
```

* '$<' first prerequisite
* '$?' all the out of date prereqs
* '$\^' all prereqs

---

## Functions
Add suffix to a list: `$(addsuffix <suffix>, list)`

````
SEQS = seq1.fa seq2.fa seq3.fa
TRIMMED = $(addsuffix .trimmed, $(seqs) )
RESULTS =  $(addprefix /data/results/, $(TRIMMED) )
$(RESULTS): $(SEQS)
  qualtrim $^
```

---

## Macros

* Basically the same as a variable but you'll sound cool: `MACRO = definition`
* Can be stored in a separate file and imported to your main makefile
* One set of setting for running on a server and on set for a laptop

---

config-axiom:
```
RESULTS_DIR = /home/kiverson/project/data/results/
NPROC = 16
```
config-workstation:
```
RESULTS_DIR = /project/
NPROC = 4
```

project-makefile:
```
include config-axiom
RESULTS =  $(addprefix $(RESULTS_DIR), results.txt )
$RESULTS:
  calc $NPROC data.txt > $@
```

command line:
```
$ make -NPROC=80 -f project-makefile
```


