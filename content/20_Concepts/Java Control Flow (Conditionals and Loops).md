---
unit: FIT2099
domain: B
week: 1
parent: "[[Java Program Structure]]"
tags: [SWE/Java, SWE/OOP]
type: pattern
aliases: [if-else, ternary, switch, for loop, while loop, for-each]
---
# [[Java Control Flow (Conditionals and Loops)]]

**Context:** [[FIT2099_MOC]] · make decisions and repeat work in a [[Java Program Structure|Java method]] · branch (if/switch) and loop (while/for)
**Problem it solves:** choose a branch by condition, or repeat a block a known or unknown number of times.

> [!abstract] Quick Revision
> - **🎯 Trigger:** decide → if/else, ternary, or switch; repeat → for/for-each (count known) or while/do-while (count unknown).
> - **⚡ Key Constraint:** `switch` cases **fall through** without `break`; `while` loops need the loop variable **updated** or they run forever.

## 🔧 Minimal Working Example
```java
if (operator == '+')      result = a + b;
else if (operator == '-') result = a - b;
else                      result = 0;          // catch-all

int min = (a < b) ? a : b;                      // ternary: condition ? ifTrue : ifFalse
```
**Expected output:** `result` set by the matching branch; `min` = the smaller of `a`, `b`.

- **if / else if / else** ➔ the general branch; the final `else` is the catch-all.
- **Ternary** ➔ `(cond) ? valueIfTrue : valueIfFalse` — a one-line if/else for an assignment.
- **switch** ➔ dispatch on one value; each `case` needs a `break`; `default` is the catch-all.
- **Loops** ➔ `while (cond) {}` · `do {} while (cond)` (runs ≥1) · `for (init; cond; update) {}` · `for (T x : coll) {}`.

## 🔀 Variations
- **switch (needs break)** ➔
```java
switch (operator) {
    case '+': result = a + b; break;
    case '-': result = a - b; break;
    default:  result = 0;     break;
}
```
- **for vs for-each** ➔ `for (int i = 0; i < xs.length; i++)` when you need the **index**; `for (String s : xs)` to just visit each element.
- **do-while** ➔ runs the body **before** testing — ideal for "keep asking until valid input".

## ✍️ Practice
> [!QUESTION]- Practice 1: Print every divisor of 100 (numbers that divide it evenly), using a `for` loop.
> > [!SUCCESS]- Reference solution
> > ```java
> > int number = 100;
> > for (int i = 1; i <= number; i++) {
> >     if (number % i == 0) System.out.println(i);
> > }
> > ```
> > - **Key move:** `for` bundles init/condition/update in one line, so the loop variable can't be forgotten.

## ⚠️ Common Mistakes
- 💡 **Missing `break` = fall-through** ➔ without `break`, a matched `case` runs into every case below it.
- 💡 **Infinite `while`** ➔ forget to update the loop variable (`i++`) and the condition never becomes false.
- 💡 **Which loop?** ➔ count known ➔ `for`/`for-each`; count unknown (wait for a condition) ➔ `while`/`do-while`.
