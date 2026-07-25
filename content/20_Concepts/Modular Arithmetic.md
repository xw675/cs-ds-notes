---
unit: FIT1058
week: 7
parent: "[[Divisibility]]"
tags: [Math/NumberTheory, Math/Discrete]
aliases: [Modulo Operation, Congruence, mod]
---
# [[Modular Arithmetic]]

**Context:** [[FIT1058_MOC]] · remainder operation $n\bmod d$ + congruence $a\equiv b\pmod n$ · an [[Equivalence Relation]] partitioning $\mathbb Z$ into $\mathbb Z_n$ · basis of the [[Euclidean Algorithm]], [[Modular Inverse]] and [[Modular Exponentiation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $n=qd+r$, $0\le r\le d-1$ ➔ remainder operation ⟹ congruence relation ⟹ arithmetic on $n$ residue classes.
> - **📦 Core Components:** $n\bmod d$ (operation) ➔ $a\equiv b\pmod n$ (relation) ➔ $+,-,\times$ on $\mathbb Z_n$.
> - **⚡ Key Constraint:** negative $n$ rounds the quotient **down** ($r\ge0$, so $-6\bmod5=4$); division needs a [[Modular Inverse]].

## 📝 Core

### 1. The Modulo Operation (Division Algorithm)
- **Division Algorithm** ➔ unique $q,r$ with $n=qd+r$, $0\le r\le d-1$; $q=\lfloor n/d\rfloor$.
- **Notation** ➔ $n\bmod d$ is an infix operation ($6\bmod4=2$); zero remainder ⟺ $d\mid n$.
- **Negative $n$** ➔ floor keeps $r\ge0$: $-6\bmod5=4$ (largest multiple $\le-6$ is $-10$).
- **Programming caveat** ➔ `%` agrees for non-negatives; for negatives some languages return $-1$ — `%` ≠ mathematical mod.

### 2. Congruence (the Relation)
- **Three definitions** ➔ $a\equiv b\pmod n\iff n\mid(a-b)\iff a\bmod n=b\bmod n$.
- **Equivalence structure** ➔ reflexive/symmetric/transitive ([[Equivalence Relation]]) ⟹ [[Set Partition|partitions]] $\mathbb Z$ into $n$ classes $[a]=a+n\mathbb Z$.
- **Operation vs relation** ➔ $n\bmod d$ *returns a value*; $a\equiv b$ and $d\mid n$ are *true/false*; link: $a\equiv b\Leftrightarrow a\bmod n=b\bmod n$.

### 3. Class Arithmetic on $\mathbb Z_n$
- **Representative rule** ➔ $[a]+[b]=[a+b]$, $[a]-[b]=[a-b]$, $xy\equiv ab\pmod n$ — pick one member each, combine, reduce.
- **Worked micro-example** ➔ in $\mathbb Z_5$: $3+4=7\equiv2$, $3\times4=12\equiv2$.
- **Division** ➔ does **not** transfer in general; needs a [[Modular Inverse]], which exists iff the element is [[Coprimality|coprime]] to $n$.
- **Everyday instances** ➔ weekdays (mod 7), clocks (mod 24), parity toggle (mod 2), last digit (mod 10).

> [!NOTE] **When It Flips:** for fixed $d>0$ the pair $(q,r)$ is unique, making $\bmod$ well-defined; replacing repeated subtraction with one $\bmod$ is exactly the speed-up from naïve gcd to the [[Euclidean Algorithm]].

## ⚠️ Common Mistakes
- 💡 **$-6\bmod5=4$, not $-1$** ➔ the floor convention forces $r\in[0,d-1]$; a language's `%` might return $-1$ but mathematical mod never does.
- 💡 **$\mathbb Z_n$ equation ≠ congruence** ➔ "$2+3=1$ in $\mathbb Z_4$" is an equation (the only value there); "$2+3\equiv1\pmod4$" is a congruence (also $\equiv37$); but "$2+3=37$ in $\mathbb Z_4$" is wrong ($37\notin\mathbb Z_4$).

## 🧠 Active Recall
> [!FAQ]- Give three equivalent definitions of $a\equiv b\pmod n$ and explain why the classes partition $\mathbb Z$.
> - **Hint:** Congruence is an equivalence.
> > [!SUCCESS]- Answer
> > - **Short answer:** $n\mid(a-b)$ ⟺ $\exists k:a-b=kn$ ⟺ $a\bmod n=b\bmod n$.
> > - **Why:** **Equivalence relation** ➔ reflexive/symmetric/transitive ⟹ $n$ disjoint residue classes $[0],\dots,[n-1]$.

> [!FAQ]- Why can class arithmetic use single representatives, and how do "$2+3=1$ in $\mathbb Z_4$" and "$2+3\equiv1\pmod4$" differ?
> - **Hint:** Well-defined operations.
> > [!SUCCESS]- Answer
> > - **Short answer:** $[a]+[b]=[a+b]$ depends only on the classes; one representative each suffices.
> > - **Why:** **Equation vs congruence** ➔ $\mathbb Z_4$ has only $\{0,1,2,3\}$; a congruence allows any class member ($37$), an equation does not.

> [!FAQ]- Compute $-6\bmod 5$ and justify via the Division Algorithm.
> - **Hint:** Floor the quotient.
> > [!SUCCESS]- Answer
> > - **Short answer:** $-6=(-2)\cdot5+4$ ⟹ $-6\bmod5=4$.
> > - **Why:** **Round down** ➔ $q=\lfloor-6/5\rfloor=-2$ is the largest integer with $qd\le n$, guaranteeing $0\le r\le d-1$.
