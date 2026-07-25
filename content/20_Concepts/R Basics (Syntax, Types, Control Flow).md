---
unit: [FIT1043, FIT2086]
domain: E
week: [0, 8]
parent: "[[R for Data Science]]"
tags: [DataScience/Tools, Tool/R]
type: pattern
aliases: [R Syntax, R Data Types, R Control Flow, R for loop]
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

## ⚠️ Common Mistakes
- 💡 **Use `<-`, and numbers default to numeric** ➔ `10` is `"numeric"`, not integer; wrap with `as.integer()` when you truly need an integer.
- 💡 **`break` ≠ `next`** ➔ `break` exits the loop; `next` only skips the rest of the current pass.
