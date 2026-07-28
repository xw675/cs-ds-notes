---
unit: [FIT1043, FIT2086]
domain: E
week: [0, 2, 8]
source: [lecture, applied, lab]
parent: "[[R for Data Science]]"
tags: [DataScience/Tools, Tool/R]
type: pattern
aliases: [R Syntax, R Data Types, R Control Flow, R for loop, R functions, user-defined functions in R, return, stop, cat, ls, rm, source, R script files]
---
# [[R Basics (Syntax, Types, Control Flow)]]

**Context:** [[FIT1043_MOC]] · the language fundamentals of [[R for Data Science|R]] · assignment, types, and control flow before [[R Vectors|vectors]]/[[R Data Frames and IO|data frames]]
**Problem it solves:** write and read basic R — assign variables, check/convert types, and branch/loop.

> [!abstract] Quick Revision
> - **🎯 Trigger:** any R snippet ➔ assign with the arrow operator, inspect type with class(), branch/loop with if/for/while.
> - **⚡ Key Constraint:** R's assignment is `<-` (not `=`), and a bare number like `10` is **numeric**, not integer — use `as.integer()` to force it.

## 🔧 Minimal Working Example
```r
A <- 10            # assign (preferred operator)
5 * A + 6          # [1] 56
y <- 8
class(y)           # [1] "numeric"
is.integer(y)      # [1] FALSE
as.character(y)    # [1] "8"   (type conversion)
```
**Expected output:** `A` holds 10; `class(y)` is `"numeric"`; conversion returns the string `"8"`.

- **Assignment** ➔ `x <- value` (the R idiom); expressions evaluate interactively (`2^3+2` → `10`).
- **Basic types** ➔ **numeric** (`10.5`), **integer** (`as.integer(10.5)`), **complex** (`1+2i`), **logical** (`TRUE`), **character** (`"Intro To R"`).
- **Inspect / test / convert** ➔ `class(x)` · `is.integer(x)` · `as.character(x)`; `help(c)` for docs.
- **Control flow** ➔ `if(expr){...}`, `for(i in 1:n){...}`, `while(cond){...}`; `break` exits, `next` skips to the next iteration.

## 🔀 Variations
- **for / while** ➔ `for(i in 1:3) print(i^2)` → 1,4,9; a `while(i<=6)` loop with `i = i+1` prints squares.
- **break vs next** ➔ in `for(i in 1:5)`, `if(i==3) break` prints 1,2; `if(i==3) next` prints 1,2,4,5.
- **Two ways to step a loop** ➔ filter inside (`for(i in 1:15) if (i %% 2 == 1) cat(i,"\n")`) or generate the right sequence (`for(i in seq(1,15,2))`) — `seq(from, to, by)` beats a modulo test when the pattern is regular. `%%` is the **remainder** operator, `%/%` integer division.
- **Printing inside loops and functions** ➔ R suppresses auto-printing there, so use `cat("value:", i, "\n")`; `\n` forces the newline (`print()` also works but formats less freely).

### Workspace and help
- **Session objects** ➔ `ls()` lists them · `rm(x, y)` removes named ones · `rm(list=ls())` clears everything (the standard clean-slate line at the top of a script).
- **Help** ➔ `help("ls")` (or `?ls`) opens the doc — the **examples at the bottom** are the fastest way in; `apropos("med")` keyword-searches command names when you can't recall one.
- **Script files** ➔ put commands in `studio1.R` and run with `source("studio1.R")` ➔ reproducibility: the script, not the console history, is the record of an analysis. Comment with `#`; whitespace is ignored, so use it.

### User-defined functions
```r
myfactorial <- function(n)
{
  if (n < 0 || floor(n) != n)          # error checking FIRST
  {
    stop("n must be non-negative integer")
  }
  if (n == 0) { return(1) }            # base case
  else        { return(n * myfactorial(n-1)) }   # recursive case
}
myfactorial(4)   # 24
```
- **Definition** ➔ `name <- function(args) { ... }`; `return(value)` hands a value back.
- **Not usable until executed** ➔ defining a function in a script does nothing until you `source` it; re-running the definition **overwrites** the old one, so no need to delete first.
- **Integer test idiom** ➔ `floor(n) != n` detects a non-integer ($\lfloor4.7\rfloor=4\ne4.7$); `stop()` aborts with a message.
- **`||` vs `|`** ➔ `||` is the scalar OR for `if` conditions (short-circuits on the first value); `|` is the element-wise OR for vectors. `!` negates: `!is.numeric(x)` reads "*not* numeric".

### Returning several values with a list
```r
findminmax <- function(x)
{
  if (!is.numeric(x) || !is.vector(x)) { stop("Input must be a numeric vector") }
  retval = list()                        # the container
  retval$min = Inf; retval$max = -Inf    # sentinels: any real value beats them
  for (i in 1:length(x))
  {
    if (x[i] < retval$min) { retval$min = x[i] }
    if (x[i] > retval$max) { retval$max = x[i] }
  }
  retval$rng = retval$max - retval$min
  return(retval)
}
findminmax(c(4,3,10,33,-2,8))    # $min -2, $max 33, $rng 35
```
- **`list()` is R's multi-value return** ➔ add fields with `$`; lists nest freely (`retval$c$g`) and hold mixed types (numbers, strings, other lists).
- **Sentinel initialisation** ➔ starting at `Inf` / `-Inf` guarantees the first comparison replaces it — safer than seeding with `x[1]`.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Print the squares of 1..5 but **skip** 3, using a for loop.
> > [!SUCCESS]- Reference solution
> > ```r
> > for (i in 1:5) {
> >   if (i == 3) next
> >   print(i^2)
> > }
> > # 1, 4, 16, 25
> > ```
> > - **Key move:** `next` skips the current iteration; `break` would stop the loop entirely.

> [!QUESTION]- Practice 2: Write a function that returns the minimum, maximum and range of a numeric vector, rejecting non-numeric input.
> > [!SUCCESS]- Reference solution
> > ```r
> > findminmax <- function(x)
> > {
> >   if (!is.numeric(x) || !is.vector(x)) { stop("Input must be a numeric vector") }
> >   retval = list(min = Inf, max = -Inf)
> >   for (i in 1:length(x))
> >   {
> >     if (x[i] < retval$min) { retval$min = x[i] }
> >     if (x[i] > retval$max) { retval$max = x[i] }
> >   }
> >   retval$rng = retval$max - retval$min
> >   return(retval)
> > }
> > findminmax(c(4,3,10,33,-2,8))   # min -2, max 33, rng 35
> > ```
> > - **Key move:** three values out of one function ⟹ a **list**; `Inf`/`-Inf` sentinels make the first comparison always fire.

## ⚠️ Common Mistakes
- 💡 **Use `<-`, and numbers default to numeric** ➔ `10` is `"numeric"`, not integer; wrap with `as.integer()` when you truly need an integer.
- 💡 **`break` ≠ `next`** ➔ `break` exits the loop; `next` only skips the rest of the current pass.
- 💡 **Loops and functions don't auto-print** ➔ a bare `i` inside a loop shows nothing; use `cat()` or `print()`.
- 💡 **A function must be executed before it exists** ➔ editing the definition in a script changes nothing until you `source` it again; a stale definition in memory is a classic phantom bug.
- 💡 **Recursion needs a reachable base case** ➔ `myfactorial(-1)` without the `stop()` guard recurses forever; validate the argument before the recursive call.
