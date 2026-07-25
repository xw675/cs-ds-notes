---
unit: FIT1043
parent: "[[Python for Data Science]]"
tags: [DataScience/Tools, Python/Basics, Monash/CS_DS]
type: pattern
aliases: [Python Syntax, Python Data Types, Python List, Python Control Flow]
---
# [[Python Basics (Syntax, Types, Control Flow)]]

**Context:** [[FIT1043_MOC]] · the language fundamentals of [[Python for Data Science|Python]] · precede [[Pandas DataFrame Basics|pandas]] · lab: `30_Projects/FIT1043_Labs/Week1-Python-Basics.ipynb`
**Problem it solves:** assign variables, use the core types, and branch/loop in Python.

> [!abstract] Quick Revision
> - **🎯 Trigger:** any Python snippet ➔ assign with =, pick a type (number/string/list), branch/loop with if/for.
> - **⚡ Key Constraint:** list indexing is **0-based**; `remove()` deletes the first matching **value**, `del`/index deletes by **position**.

## 🔧 Minimal Working Example
```python
currentYear = 2019                 # number
s = 'Welcome to FIT1043'           # string
print(s + ' in ' + str(currentYear))   # concat needs str()

lst = []                           # list
lst.append(1); lst.append('hi')    # grow
lst[0]                             # index (0-based) -> 1
len(lst)                          # 2
```
**Expected output:** the concatenated string; `lst` = `[1, 'hi']`; `len` = 2.

- **Arithmetic** ➔ `+ - * /`, `**` (power), `%` (modulo); `"ab"*3` repeats a string.
- **Types** ➔ number, string (`str()` to convert), list (ordered, mutable).
- **List ops** ➔ `append(x)` add; `remove(v)` drop first value `v`; `del lst[i]` drop by index; `lst[i]` access (0-based); `len(lst)`.
- **Conditions** ➔ `==` / `!=`; `if … : / else :`; membership `x in [a, b]`.
- **Packages** ➔ `!pip install name` (once), then `import name`.

## 🔀 Variations
- **Input + dynamic year** ➔ avoid hard-coding: `import datetime; now = datetime.datetime.now(); now.year - int(input('age: '))`.
- **Membership branch** ➔ `if currentYear in [2019, 2018]: ...` tests several values at once.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Ask for a birth year and print the person's age using the *current* year (not a hard-coded 2019).
> > [!SUCCESS]- Reference solution
> > ```python
> > import datetime
> > now = datetime.datetime.now()
> > birth = int(input('Please enter your birth year: '))
> > print('You are', now.year - birth)
> > ```
> > - **Key move:** `datetime.now().year` makes it dynamic; `int()` converts the string from `input()`.

## ⚠️ Common Mistakes
- 💡 **`remove(v)` ≠ `del lst[i]`** ➔ `remove` deletes the first element equal to `v`; `del`/indexing deletes by position.
- 💡 **`input()` returns a string** ➔ wrap with `int()`/`float()` before arithmetic; and concatenation needs `str()` on numbers.
