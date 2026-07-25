---
unit: FIT1058
week: 7
parent: "[[Euclidean Algorithm]]"
tags: [Math/NumberTheory, CS/Algorithms]
---
# [[Extended Euclidean Algorithm]]

**Context:** [[FIT1058_MOC]] · the [[Euclidean Algorithm]] plus bookkeeping triples · returns $x,y$ with $\gcd(m,n)=xm+yn$ · the engine for [[Modular Inverse|modular inverses]]

> [!abstract] Quick Revision
> - **🎯 Objective:** run Euclid while tracking each value as $xm+yn$ ➔ output $\gcd$ **and** the Bézout $x,y$.
> - **📦 Core Components:** seed triples $(m,1,0),(n,0,1)$ ➔ vector update ➔ invariant $a=xm+yn$.
> - **⚡ Key Constraint:** the engine for [[Modular Inverse|modular inverses]]; extra cost is only bookkeeping.

## 📝 Core
### 1. The Algorithm (Triples)
- **Purpose** ➔ run the [[Euclidean Algorithm]] tracking each value as an [[Integer Linear Combination]] of $m,n$.
- **Output** ➔ $\gcd(m,n)$ and integers $x,y$ with $\gcd(m,n)=xm+yn$.
- **Seeds** ➔ $(a,x,y)=(m,1,0)$, $(b,z,w)=(n,0,1)$.

### 2. The Update
- **Quotient** ➔ $q=\lfloor a/b\rfloor$.
- **Vector step** ➔ new $(b,z,w)=(a,x,y)-q(b,z,w)$; old $b$-triple becomes new $a$-triple.
- **Stop** ➔ $b=0$ ⟹ output the $a$-triple.

### 3. Invariant & Check
- **Invariant** ➔ every triple keeps $a=xm+yn$, $b=zm+wn$.
- **Answer** ➔ final $a$-triple gives $\gcd=xm+yn$.
- **Self-check** ➔ final $b$-triple gives $0=zm+wn$; failure flags an arithmetic slip.

**Key identities:**

$$q=\lfloor a/b\rfloor,\qquad \text{new }(a,x,y)=(b,z,w),\qquad \text{new }(b,z,w)=(a-qb,\ x-qz,\ y-qw)$$

> [!NOTE] **When It Flips:** the coefficients $x,y$ are exactly what [[Coprimality]] needs ($xm+yn=1$) and what yields [[Modular Inverse|$x^{-1}$ in $\mathbb Z_n$]] (from $yx+zn=1$, inverse is $y\bmod n$) — central to RSA-style key setup.

## 📊 Exam Execution Trace

### Manual Execution Trace
EEA on $(26,7)$:

| Step / State | $q$ | $(a,x,y)$ | $(b,z,w)$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | $(26,1,0)$ | $(7,0,1)$ |
| 1 | 3 | $(7,0,1)$ | $(5,1,-3)$ |
| 2 | 1 | $(5,1,-3)$ | $(2,-1,4)$ |
| 3 | 2 | $(2,-1,4)$ | $(1,3,-11)$ |
| 4 | 2 | $(1,3,-11)$ | $(0,-7,26)$ |

## ⚠️ Common Mistakes
- 💡 **Invariant $a=xm+yn$** ➔ true for seeds and preserved by the update; the final $b$-triple's $0=zm+wn$ is a free consistency check.

## 🧠 Active Recall
> [!FAQ]- What invariant do the EEA triples maintain, and how does it give both the answer and a check?
> - **Hint:** $a=xm+yn$ preserved.
> > [!SUCCESS]- Answer
> > - **Short answer:** Each triple keeps $a=xm+yn$; final $a$-triple gives $\gcd=xm+yn$, final $b$-triple gives $0=zm+wn$.
> > - **Why:** **Preserved by update** ➔ true for seeds, and the vector step maintains it.

> [!FAQ]- How does EEA produce a modular inverse, and how much extra work over plain Euclid?
> - **Hint:** Bézout gives the inverse.
> > [!SUCCESS]- Answer
> > - **Short answer:** On $x,n$ with $\gcd=1$ it returns $yx+zn=1$, so $x^{-1}=y\bmod n$; gcd steps are identical.
> > - **Why:** **Only accounting** ➔ overhead is updating coefficient pairs, not extra divisions.
