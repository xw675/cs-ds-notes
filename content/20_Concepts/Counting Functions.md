---
unit: FIT1058
domain: D
week: 2
parent: "[[Function (Mathematics)]]"
tags: [Math/Combinatorics, Math/Functions]
---
# [[Counting Functions]]

**Context:** [[FIT1058_MOC]] · counts how many [[Function (Mathematics)|functions]] of each type exist between finite sets · uses the product rule · linked to [[Injection, Surjection, Bijection]]

> [!abstract] Quick Revision
> - **🎯 Objective:** count functions $f:A\to B$ by type ($\lvert A\rvert=m$, $\lvert B\rvert=n$) ➔ all / injective / bijective.
> - **📦 Core Components:** all $=n^m$ ➔ injections $=\tfrac{n!}{(n-m)!}$ ➔ bijections $=n!$.
> - **⚡ Key Constraint:** injections vanish if $m>n$ (pigeonhole); surjections need inclusion–exclusion.

## 📝 Core
### 1. The Counts
- **All functions** ➔ $n^m$ (each of $m$ inputs picks any of $n$ outputs independently).
- **Injections** ➔ $\frac{n!}{(n-m)!}=n(n-1)\cdots(n-m+1)$ (choices shrink; $0$ if $m>n$).
- **Bijections** ➔ $n!$ (needs $m=n$; permutations of the set).

### 2. Why the Formulas
- **Product rule** ➔ independent choices multiply ⟹ $n^m$.
- **Shrinking choices** ➔ each used value unavailable ⟹ falling product.
- **Pigeonhole** ➔ $m>n$ forces a collision ⟹ no injection.

### 3. What's Deferred
- **Surjections** ➔ inclusion–exclusion / Stirling numbers of the second kind (not a simple product).

**Key identities:**

$$\#\{f:A\to B\}=n^m,\qquad \#\text{injections}=\frac{n!}{(n-m)!},\qquad \#\text{bijections}=n!\ (m=n)$$

## ⚖️ Core Decision Matrix
| Type | Count | Reason |
| :--- | :--- | :--- |
| all functions | $n^m$ | $n$ choices, $m$ times |
| injections | $\frac{n!}{(n-m)!}$ | shrinking choices; $0$ if $m>n$ |
| bijections ($m=n$) | $n!$ | permutations |
| surjections | inclusion–exclusion | not a plain product |

> [!NOTE] **When It Flips:** every bijection is an injection with $m=n$: $\tfrac{n!}{0!}=n!$ (consistent). Relations ($2^{mn}$, [[n-ary Relation]]) vastly outnumber functions ($n^m$) because they drop single-valuedness.

## 📊 Exam Execution Trace

### Manual Execution Trace
$\lvert A\rvert=2$, $\lvert B\rvert=3$:

| Step / State | Type | Formula | Value |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | all | $3^2$ | 9 |
| 2 | injections | $3!/1!$ | 6 |
| 3 | bijections ($m=n=3$) | $3!$ | 6 |

## ⚠️ Common Mistakes
- 💡 **Injections keep order, subsets don't** ➔ $\tfrac{n!}{(n-m)!}$ is the *ordered* selection; dividing by $m!$ gives $\binom{n}{m}$ ([[Binomial Coefficient]]). Injections vanish when $m>n$.

## 🧠 Active Recall
> [!FAQ]- Derive the number of functions and injections from a size-$m$ to a size-$n$ set.
> - **Hint:** Independent vs shrinking choices.
> > [!SUCCESS]- Answer
> > - **Short answer:** Functions $n^m$; injections $n(n-1)\cdots(n-m+1)=\tfrac{n!}{(n-m)!}$.
> > - **Why:** **Pigeonhole** ➔ $m>n$ makes a factor $\le0$, count $0$.

> [!FAQ]- Why is the number of bijections on an $n$-set $n!$, and what are they called?
> - **Hint:** $m=n$ injection count.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\tfrac{n!}{0!}=n!$; these are the **permutations**.
> > - **Why:** **Falling product** ➔ $n,n-1,\dots,1$ distinct image choices.
