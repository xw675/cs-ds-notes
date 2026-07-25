---
unit: FIT1058
week: 6
parent: "[[Function (Mathematics)]]"
tags: [Math/Discrete, Math/Sequences]
---
# [[Sequence (Mathematics)]]

**Context:** [[FIT1058_MOC]] · an ordered list, formalised as a [[Function (Mathematics)|function]] on $\mathbb N$ · contrast with an unordered [[Set (Mathematics)|set]] · the home of [[Recurrence Relation|recurrences]], [[Limit of a Sequence|limits]] and [[Big-O Notation|growth analysis]]

> [!abstract] Quick Revision
> - **🎯 Objective:** an ordered list = a function on $\mathbb N$ ➔ $n$-th term $f_n$.
> - **📦 Core Components:** ordered + may repeat ➔ closed form vs recurrence.
> - **⚡ Key Constraint:** must be pinned by a rule, not an informal "$\dots$"; contrast the unordered [[Set (Mathematics)|set]].

## 📝 Core
### 1. The Definition
- **Sequence** ➔ a [[Function (Mathematics)|function]] $f:\mathbb N\to A$ (infinite) or $f:[1,n]_{\mathbb N}\to A$ (finite).
- **$n$-th term** ➔ $f(n)=f_n$; number sequence when $A$ is a [[Sets of Numbers|number set]].
- **Length** ➔ size of a finite sequence's domain.

### 2. Sequence vs Set
- **Set** ➔ unordered, no repetition.
- **Sequence** ➔ ordered, may repeat ($1,1,2,3,5$).
- **Finite sequence** ➔ an $n$-tuple; a string is a sequence of letters.

### 3. Defining a Sequence
- **Not an "$\dots$" list** ➔ only suggests a pattern.
- **Closed form** ➔ $f_n$ in $n$ alone ($n^2$).
- **[[Recurrence Relation|Recurrence]]** ➔ $f_n$ from earlier terms + base case(s).

**Key identities:**

$$\text{closed: } (n^2)_{n=1}^{\infty} = 1,4,9,16,25,\dots$$
$$\text{recurrence: } f_1=1,\ f_n=n f_{n-1}\ (\text{factorials})$$

## ⚖️ Core Decision Matrix
| Feature | Sequence | Set |
| :--- | :--- | :--- |
| order | matters | irrelevant |
| repetition | allowed | none |
| formalism | function on $\mathbb N$ | collection |
| finite form | $n$-tuple | — |

> [!NOTE] **When It Flips:** sequences are fundamental to computation — memory is laid out in order, and time-vs-input-size is the sequence [[Big-O Notation]] analyses. Closed form gives any term in one step; a recurrence is often more natural but hides growth until unrolled.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** List the first five terms of $(n^2:n\in\mathbb N)$ and state domain/codomain.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
f:\mathbb N\to\mathbb N,\ f(n)=n^2 \\
f(1..5) = 1,4,9,16,25,\quad f(4)=16
\end{aligned}
$$
**Final Extracted Output:** an infinite sequence (function on $\mathbb N$); repetition allowed but here all distinct.

## ⚠️ Common Mistakes
- 💡 **"$f_1,f_2,\dots$" is not a definition** ➔ many sequences share any finite prefix; pin it with a closed form or a recurrence + base case.

## 🧠 Active Recall
> [!FAQ]- Define a sequence precisely, and how it differs from a set.
> - **Hint:** Ordered + repeatable.
> > [!SUCCESS]- Answer
> > - **Short answer:** A function $f:\mathbb N\to A$ (or $[1,n]$); ordered and may repeat, unlike a set.
> > - **Why:** **$n$-tuple** ➔ a finite sequence is a tuple; length = domain size.

> [!FAQ]- Why is "$f_1,f_2,f_3,\dots$" not a definition, and what are the two valid ways?
> - **Hint:** Rule required.
> > [!SUCCESS]- Answer
> > - **Short answer:** An "$\dots$" list only hints a pattern; define by closed form or recurrence + base case.
> > - **Why:** **Ambiguity** ➔ many sequences share any prefix.
