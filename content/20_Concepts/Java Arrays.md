---
unit: FIT2099
week: 1
parent: "[[Java Program Structure]]"
tags: [SWE/Java, SWE/OOP]
type: pattern
aliases: [Java Array, array length]
---
# [[Java Arrays]]

**Context:** [[FIT2099_MOC]] · store many values of one type under one name · fixed length · iterated with a [[Java Control Flow (Conditionals and Loops)|for/for-each loop]]
**Problem it solves:** create a fixed-size collection of same-typed items, then access/update by index.

> [!abstract] Quick Revision
> - **🎯 Trigger:** many values of the same type ➔ an array, not 100 separate variables.
> - **⚡ Key Constraint:** arrays are **0-based** and **fixed length**; index the last item with `arr.length - 1` (note `length` is a field, no `()`).

## 🔧 Minimal Working Example
```java
String[] students = {"Adam", "Billy", "Charlie"};   // literal, length 3
System.out.println(students[0]);                     // access: "Adam" (0-based)
students[2] = "Chuck";                                // update by index
System.out.println(students.length);                 // 3  (field, not method)
```
**Expected output:** `Adam`; then `students[2]` becomes `Chuck`; length `3`.

- **Create (literal)** ➔ `String[] a = {"x","y"};` — values known up front.
- **Create (empty, fixed size)** ➔ `String[] a = new String[5];` then assign `a[0] = "x"`.
- **Access / update** ➔ `a[i]` reads or writes position `i` (0-based).
- **Length** ➔ `a.length` — an attribute (no parentheses), unlike `String.length()`.

## 🔀 Variations
- **Iterate with index** ➔ `for (int i = 0; i < a.length; i++) …` when you need `i`.
- **Iterate values** ➔ `for (String s : a) …` (for-each) to just visit each element.

## ✍️ Practice
> [!QUESTION]- Practice 1: Make a 5-element `int` array, fill it with the squares 1²…5², and print each on its own line.
> > [!SUCCESS]- Reference solution
> > ```java
> > int[] sq = new int[5];
> > for (int i = 0; i < sq.length; i++) sq[i] = (i + 1) * (i + 1);
> > for (int v : sq) System.out.println(v);
> > ```
> > - **Key move:** index-`for` to fill (needs `i`), for-each to print (values only).

## ⚠️ Common Mistakes
- 💡 **`length` has no parentheses** ➔ array `a.length` is a field; only `String` uses `.length()` (a method).
- 💡 **Fixed size + 0-based** ➔ `new String[5]` holds indices 0–4; `a[5]` throws `ArrayIndexOutOfBoundsException`.
