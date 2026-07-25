---
unit: FIT1058
week: 7
parent: "[[Divisibility]]"
tags: [Math/NumberTheory, Math/Discrete]
---
# [[Prime Number]]

**Context:** [[FIT1058_MOC]] · the multiplicative "atoms" of $\mathbb N$ · defined via [[Divisibility|proper divisors]] · every integer $>1$ is a product of primes (proved by [[Mathematical Induction|strong induction]])

> [!abstract] Quick Revision
> - **🎯 Objective:** an integer $>1$ with no proper divisors ➔ the multiplicative atoms of $\mathbb N$.
> - **📦 Core Components:** proper divisor ➔ prime vs composite ➔ existence of prime factorisation.
> - **⚡ Key Constraint:** existence (strong induction) is separate from **uniqueness** (Fundamental Theorem).

## 📝 Core
### 1. The Definition
- **Proper divisor** ➔ a divisor neither 1 nor $n$.
- **Prime** ➔ integer $>1$ with **no proper divisors** ($2,3,5,7,11,\dots$); else **composite**.
- **Atoms** ➔ indivisible; every positive integer assembles from them.

### 2. Existence Theorem
- **Claim** ➔ every integer $\ge2$ is a product of primes.
- **Strong induction** ➔ composite $n=ab$ with $1<a,b<n$; both factor by hypothesis.
- **Why strong** ➔ $a,b$ can be far below $n-1$, so all smaller $k$ needed.

### 3. Uniqueness Is Separate
- **Existence** ➔ this theorem.
- **Uniqueness** ➔ Fundamental Theorem of Arithmetic (stronger, later).
- **$1$ excluded** ➔ admitting it wrecks unique factorisation.

## ⚖️ Core Decision Matrix
| Concept | About | Test difficulty |
| :--- | :--- | :--- |
| primality | one number, no proper divisor | harder |
| [[Coprimality]] | two numbers, $\gcd=1$ | easy (Euclid) |
| factorisation | product of primes | hardest |
| $\phi(p)$ | $p-1$ | from primality |

> [!NOTE] **When It Flips:** primality is a property of *one* number; coprimality a relation between *two*. Testing coprimality is easy; testing primality is harder and *factorising* harder still — the gap cryptography depends on.

## 📊 Exam Execution Trace

### Manual Execution Trace
Factoring 84:

| Step / State | $n$ | smallest prime $p$ | $n/p$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | 84 | 2 | 42 |
| 1 | 42 | 2 | 21 |
| 2 | 21 | 3 | 7 |
| 3 | 7 | 7 | 1 |

## ⚠️ Common Mistakes
- 💡 **Existence ≠ uniqueness** ➔ this proves a factorisation *exists*; that it is *unique* is the Fundamental Theorem, proved separately.

## 🧠 Active Recall
> [!FAQ]- Prove every integer $\ge2$ is a product of primes, and why *strong* induction is needed.
> - **Hint:** Factor into smaller parts.
> > [!SUCCESS]- Answer
> > - **Short answer:** Basis $n=2$; composite $n=ab$ ($1<a,b<n$) factors by hypothesis, so $n$ does.
> > - **Why:** **Strong** ➔ $a,b$ can be far below $n-1$, so all smaller $k$ must be assumed.

> [!FAQ]- Distinguish "prime" from "coprime" and their test difficulty.
> - **Hint:** One number vs a pair.
> > [!SUCCESS]- Answer
> > - **Short answer:** Prime = one integer with no proper divisor; coprime = two integers with $\gcd=1$ (e.g. 21, 25).
> > - **Why:** **Euclid is easy** ➔ coprimality is fast; primality/factorisation are hard.
