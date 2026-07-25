---
unit: FIT1058
week: 7
parent: "[[Greatest Common Divisor]]"
tags: [Math/NumberTheory, Math/Discrete, Monash/CS_DS]
---
# [[Coprimality]]

**Context:** [[FIT1058_MOC]] · $\gcd(a,b)=1$ · characterised by $xm+yn=1$ · decides which elements have a [[Modular Inverse|modular inverse]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $a,b$ coprime iff $\gcd(a,b)=1$ ➔ share no factor but 1.
> - **📦 Core Components:** not primality ➔ Bézout $xm+yn=1$ ➔ tested by [[Euclidean Algorithm]].
> - **⚡ Key Constraint:** $x$ invertible in $\mathbb Z_n$ **iff** $\gcd(x,n)=1$; coprimality is pairwise, not transitive.

## 📝 Core
### 1. The Relation
- **Definition** ➔ coprime $\Leftrightarrow\gcd(a,b)=1$ — no shared factor but 1.
- **Not primality** ➔ 21, 25 coprime though neither [[Prime Number|prime]].
- **Prime case** ➔ $a$ prime ⟹ $a,b$ coprime unless $a\mid b$.

### 2. Bézout Characterisation
- **Iff** ➔ $m,n$ coprime $\Leftrightarrow\exists x,y:\ xm+yn=1$.
- **Why** ➔ $\gcd=1$ = smallest positive [[Integer Linear Combination]] = 1 achievable.
- **Test** ➔ [[Euclidean Algorithm]] for gcd; [[Extended Euclidean Algorithm]] for $x,y$.

> [!NOTE] **When It Flips:** the payoff theorem — $x$ has a [[Modular Inverse]] in $\mathbb Z_n$ **iff** $\gcd(x,n)=1$; the Bézout coefficient is the inverse. Coprimality sidesteps factorisation entirely, so it is far easier than primality.

## 📊 Exam Execution Trace

### Manual Execution Trace
$\gcd(25,21)$:

| Step / State | Pair | Reduce |
| :--- | :--- | :--- |
| **0 (Init)** | $(25,21)$ | — |
| 1 | $(21,4)$ | $25\bmod21=4$ |
| 2 | $(4,1)$ | $21\bmod4=1$ |
| 3 | gcd | $1$ → coprime |

## ⚠️ Common Mistakes
- 💡 **Coprime ≠ prime** ➔ 21, 25 are coprime with neither prime; the Bézout coefficient $x$ *is* the modular inverse ($\gcd(x,n)=1$).

## 🧠 Active Recall
> [!FAQ]- Prove $m,n$ coprime iff $xm+yn=1$ for some integers $x,y$.
> - **Hint:** gcd = smallest positive combination.
> > [!SUCCESS]- Answer
> > - **Short answer:** coprime ⟺ $\gcd=1$ ⟺ 1 is the smallest positive $xm+yn$ ⟺ $1\in m\mathbb Z+n\mathbb Z$.
> > - **Why:** **Least positive** ➔ 1 is minimal, so attaining it forces gcd 1.

> [!FAQ]- Why is coprimality easier than primality, and what does it determine in $\mathbb Z_n$?
> - **Hint:** No factorisation needed.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\gcd=1$ is testable by Euclid without factorising; $x$ invertible in $\mathbb Z_n$ iff $\gcd(x,n)=1$.
> > - **Why:** **$\mathbb Z_n^*$** ➔ the invertible elements are exactly those coprime to $n$, counted by $\phi(n)$.
