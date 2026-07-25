---
unit: FIT1058
week: 7
parent: "[[Greatest Common Divisor]]"
tags: [Math/NumberTheory, CS/Algorithms, Monash/CS_DS]
---
# [[Euclidean Algorithm]]

**Context:** [[FIT1058_MOC]] · computes [[Greatest Common Divisor|gcd]] by repeated reduction · subtraction sped up to [[Modular Arithmetic|remainder]] · extended to find [[Integer Linear Combination|Bézout coefficients]]

> [!abstract] Quick Revision
> - **🎯 Objective:** compute $\gcd(a,b)$ by iterating $(a,b)\to(b,\,a\bmod b)$ ➔ stop when $b\mid a$, output $b$.
> - **📦 Core Components:** **reduction** $\gcd(a,b)=\gcd(b,a\bmod b)$ ➔ **base case** $b\mid a$ ➔ quotient $q$ saved for [[Extended Euclidean Algorithm]].
> - **⚡ Key Constraint:** remainder form collapses $\lfloor a/b\rfloor$ subtractions into one $a\bmod b$; terminates as $b$ strictly decreases.

## 📝 Core
### 1. The Reduction (Subtraction → Remainder)
- **Identity** ➔ $\gcd(a,b)=\gcd(b,\,a-b)$ ([[Greatest Common Divisor]] reduction theorem).
- **Speed-up** ➔ replace repeated $-b$ with a single $a\bmod b$ ➔ $\gcd(a,b)=\gcd(b,\,a\bmod b)$.
- **Base case** ➔ $b\mid a$ ⟹ **output** $b$.

### 2. Why It Works & Halts
- **Correctness** ➔ each step preserves the pair's [[Greatest Common Divisor|common divisors]] ⟹ final divisor = original $\gcd$.
- **Termination** ➔ second argument strictly decreases and stays $\ge0$ ⟹ must reach $b\mid a$.
- **Quotient saved** ➔ $q=\lfloor a/b\rfloor$ recorded ➔ reused by [[Extended Euclidean Algorithm]] for Bézout $x,y$.

**Key identities:**

$$\gcd(174,48)=\gcd(48,\underbrace{30}_{174\bmod48})=\gcd(30,\underbrace{18}_{48\bmod30})=\gcd(18,\underbrace{12}_{30\bmod18})=\gcd(12,\underbrace{6}_{18\bmod12})=6$$

## ⚖️ Core Decision Matrix
| Form | Step cost | When it hurts |
| :--- | :--- | :--- |
| **Subtraction** $\gcd(a,b{-}\dots)$ | $\lfloor a/b\rfloor$ subtractions to one remainder | huge quotient ⟹ many steps |
| **Remainder** $a\bmod b$ | one modulo per step | none — the efficient form |
| **Extended** | remainder + a Bézout triple | slightly more bookkeeping |

> [!NOTE] **When It Flips:** the remainder form runs in $O(\log\min(a,b))$ divisions (worst case: consecutive [[Fibonacci Sequence|Fibonacci]] numbers). It is the standard test for [[Coprimality]] ($\gcd=1$) and, extended, computes [[Modular Inverse|modular inverses]].

## 📊 Exam Execution Trace

### Manual Execution Trace
$\gcd(252,198)$, iterating $(a,b)\to(b,\,a\bmod b)$:

| Step / State | $a$ | $b$ | $q=\lfloor a/b\rfloor$ | $a\bmod b$ |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | 252 | 198 | — | — |
| 1 | 252 | 198 | 1 | 54 |
| 2 | 198 | 54 | 3 | 36 |
| 3 | 54 | 36 | 1 | 18 |
| 4 | 36 | 18 | 2 | 0 → $18\mid36$ |

## ⚠️ Common Mistakes
- 💡 **Keep going until $b\mid a$, don't stop at the first small remainder** ➔ the answer is the *last divisor*, not the last remainder; and record $q=\lfloor a/b\rfloor$ if the Bézout coefficients are wanted.

## 🧠 Active Recall
> [!FAQ]- Why is the remainder form faster than the subtraction form, and why does it terminate?
> - **Hint:** One modulo = many subtractions; monotone decrease.
> > [!SUCCESS]- Answer
> > - **Short answer:** $a\bmod b$ does all $\lfloor a/b\rfloor$ subtractions at once; the second argument strictly decreases while staying $\ge0$, so it reaches $b\mid a$.
> > - **Why:** **Divisor-preserving** ➔ every step keeps the pair's common divisors, so the final divisor is the original $\gcd$.

> [!FAQ]- Trace the Euclidean Algorithm on $\gcd(48,174)$.
> - **Hint:** Iterate remainders to divisibility.
> > [!SUCCESS]- Answer
> > - **Short answer:** $174\bmod48=30$, $48\bmod30=18$, $30\bmod18=12$, $18\bmod12=6$; $6\mid12$ ⟹ output $\mathbf6$.
> > - **Why:** **Last divisor** ➔ the answer is the divisor at the base case $b\mid a$, not the last non-zero remainder computed mid-loop.

> [!FAQ]- What does the *extended* algorithm add, and why keep the quotient $q$?
> - **Hint:** Bézout bookkeeping.
> > [!SUCCESS]- Answer
> > - **Short answer:** It returns $x,y$ with $\gcd(a,b)=xa+yb$ ([[Integer Linear Combination]]).
> > - **Why:** **Back-substitution** ➔ each $q=\lfloor a/b\rfloor$ is reused to unwind the remainders into the coefficients — the basis of [[Modular Inverse|modular inverses]].
