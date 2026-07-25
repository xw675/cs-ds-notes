---
unit: [FIT1043, FIT2086]
week: 8
parent: "[[R Basics (Syntax, Types, Control Flow)]]"
tags: [DataScience/Tools, Tool/R]
type: pattern
aliases: [R Vector, c(), Vectorised, anyNA, is.na]
---
# [[R Vectors]]

**Context:** [[FIT1043_MOC]] · R's core 1-D structure · columns of a [[R Data Frames and IO|data frame]] are vectors · built with `c()`
**Problem it solves:** create a vector, index its elements, do element-wise arithmetic, and test for missing values.

> [!abstract] Quick Revision
> - **🎯 Trigger:** store/operate on many values ➔ build with c(); index with square brackets; arithmetic is **element-wise**.
> - **⚡ Key Constraint:** R indexing is **1-based**, and negative indices **exclude** (they don't count from the end).

## 🔧 Minimal Working Example
```r
B <- c(5, 6, 3, 0)          # concatenate into a vector
B <- c(B, c(1, 2))          # [1] 5 6 3 0 1 2  (grow it)
x <- c("Jan","Feb","Mar","April")
x[c(1,3,4)]                 # "Jan" "Mar" "April"  (by position)
x[c(-1,-4)]                 # "Feb" "Mar"          (exclude 1 and 4)
x[1:3]                      # "Jan" "Feb" "Mar"    (range)
```
**Expected output:** as commented — positive indices select, negative indices exclude, `a:b` is a range.

- **Create/grow** ➔ `c(...)` concatenates values (and vectors) into one vector.
- **Index** ➔ positive positions select; **negative positions exclude**; `1:3` selects a range.
- **Element-wise arithmetic** ➔ same-length vectors combine per element: `c(1,2,4)*c(12,4,3)` → `12 8 12`.
- **Missing values** ➔ `anyNA(x)` → TRUE if any `NA`; `is.na(x)` → a logical vector flagging each `NA`.

## 🔀 Variations
- **Element-wise ops** ➔ `v1 * v2`, `v1 + v2`, etc., require equal length; each position is computed independently.
- **NA detection** ➔ `is.na(c("Java", NA, "R", NA))` → `FALSE TRUE FALSE TRUE`.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Given `x <- c("Java", NA, "Python", "R", NA)`, check whether it has any missing values and flag which elements are missing.
> > [!SUCCESS]- Reference solution
> > ```r
> > anyNA(x)     # [1] TRUE
> > is.na(x)     # [1] FALSE TRUE FALSE FALSE TRUE
> > ```
> > - **Key move:** `anyNA` gives one TRUE/FALSE; `is.na` gives a per-element logical vector.

## ⚠️ Common Mistakes
- 💡 **Negative index = exclude, not from-the-end** ➔ `x[-1]` drops the first element (unlike Python's `x[-1]`).
- 💡 **Recycling on unequal lengths** ➔ element-wise ops assume equal length; mismatched lengths recycle the shorter one (often a bug).
