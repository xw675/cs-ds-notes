---
unit: FIT1058
domain: D
week: 7
parent: "[[Sets of Numbers]]"
tags: [Math/NumberTheory, Math/Discrete]
---
# [[Divisibility]]

**Context:** [[FIT1058_MOC]] · multiples and divisors of integers · the relation $d\mid n$ · the foundation of [[Prime Number|primes]], [[Greatest Common Divisor|gcd]] and [[Modular Arithmetic|congruence]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $d\mid n$: $n=qd$ for some integer $q$ ➔ the relation underpinning all number theory.
> - **📦 Core Components:** multiple/divisor ➔ $d\mathbb Z$ ➔ sum/difference/combination rule.
> - **⚡ Key Constraint:** $d\mid m,n\Rightarrow d\mid(xm+yn)$, but the converse **fails**.

## 📝 Core
### 1. The Relation (Multiples & Divisors)
- **Definition** ➔ $d\mid n\Leftrightarrow n=qd$ for some $q\in\mathbb Z$ ($d$ a divisor, $n$ a multiple).
- **Multiple set** ➔ $d\mathbb Z=\{\dots,-2d,-d,0,d,2d,\dots\}$ (evens $=2\mathbb Z$).
- **Even** ➔ "$n$ even" $\Leftrightarrow 2\mid n$.

### 2. Combination Rule
- **Sum/difference** ➔ $d\mid m\wedge d\mid n\Rightarrow d\mid(m\pm n)$.
- **General** ➔ $d\mid(xm+yn)$ for all $x,y\in\mathbb Z$ ([[Integer Linear Combination]]).
- **Converse fails** ➔ $2\mid(3+5)$ but $2\nmid3,\,2\nmid5$.

**Key identities:**

$$d\mid m \wedge d\mid n \Rightarrow d\mid(xm+yn)\ \ \forall x,y\in\mathbb Z$$
$$\text{proof: } m=q_1d,\ n=q_2d \Rightarrow xm+yn=(xq_1+yq_2)d$$

> [!NOTE] **When It Flips:** the sum/difference rule is the engine of the [[Euclidean Algorithm]] ($\gcd(a,b)=\gcd(b,a-b)$) and [[Integer Linear Combination|Bézout's identity]]. $d\mathbb Z$ is symmetric about $0$ and always contains $0$ ($q=0$).

## 📊 Exam Execution Trace

### Manual Execution Trace
Divisors of 18:

| Step / State | Factorisation | Divisors |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $1\cdot18$ | $1,18$ |
| 2 | $2\cdot9$ | $2,9$ |
| 3 | $3\cdot6$ | $3,6$ |

## ⚠️ Common Mistakes
- 💡 **Converse fails** ➔ $d\mid(m+n)$ does *not* give $d\mid m$ and $d\mid n$; the rule moves from divisors to combinations, never back.

## 🧠 Active Recall
> [!FAQ]- If $d\mid m$ and $d\mid n$, what else must $d$ divide — and why doesn't $2\mid(3+5)$ make 2 divide 3?
> - **Hint:** Combinations, not summands.
> > [!SUCCESS]- Answer
> > - **Short answer:** $d\mid(xm+yn)$ for all integers $x,y$; the converse fails.
> > - **Why:** **Factor out $d$** ➔ $xm+yn=(xq_1+yq_2)d$; divisibility of a sum says nothing about summands.

> [!FAQ]- State $d\mid n$ via multiples, remainders, and the set $d\mathbb Z$.
> - **Hint:** Three equivalent forms.
> > [!SUCCESS]- Answer
> > - **Short answer:** $n=qd$ ⟺ $n\in d\mathbb Z$ ⟺ $n\bmod d=0$.
> > - **Why:** **Exact division** ➔ all three say "$d$ goes into $n$ exactly"; $d>0$, $n$ any integer.
