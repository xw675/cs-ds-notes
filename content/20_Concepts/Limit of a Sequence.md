---
unit: FIT1058
week: 6
parent: "[[Sequence (Mathematics)]]"
tags: [Math/Analysis, Math/Sequences, Monash/CS_DS]
---
# [[Limit of a Sequence]]

**Context:** [[FIT1058_MOC]] · the long-run value a [[Sequence (Mathematics)|sequence]] settles to · defined with nested [[Multiple Quantifiers|quantifiers]] ($\forall\varepsilon\,\exists N\,\forall n$) · underlies [[Geometric Series|infinite series]] and [[Big-O Notation|growth]]

> [!abstract] Quick Revision
> - **🎯 Objective:** the value terms get arbitrarily close to and stay close to ➔ $\forall\varepsilon\,\exists N\,\forall n>N:\ |a_n-\ell|<\varepsilon$.
> - **📦 Core Components:** $\varepsilon$ tolerance ➔ $N$ cutoff (depends on $\varepsilon$) ➔ all later terms within $\varepsilon$.
> - **⚡ Key Constraint:** quantifier **order** ($\forall\varepsilon\,\exists N$) is essential; "eventually", not "always".

## 📝 Core
### 1. The Definition
- **Limit** ➔ $\lim_{n\to\infty}a_n=\ell\Leftrightarrow\forall\varepsilon>0\ \exists N\ \forall n>N:\ |a_n-\ell|<\varepsilon$.
- **Read** ➔ for any target distance $\varepsilon$, some point $N$ beyond which all terms lie within $\varepsilon$.

### 2. Order & Scope
- **$N$ after $\varepsilon$** ➔ $N$ may depend on $\varepsilon$ (smaller $\varepsilon$ → larger $N$).
- **Eventually** ➔ only terms beyond $N$ matter; finitely many early strays are irrelevant.
- **$\varepsilon>0$** ➔ arbitrarily small, never 0.

### 3. Non-Convergence
- **Unbounded** ➔ $(n),(n^2)$ grow without bound.
- **Oscillating** ➔ $((-1)^n)$ bounded, no limit.
- **Split** ➔ odd/even terms to different values.

**Key identities:**

$$\text{Given }\varepsilon>0,\text{ choose }N>\tfrac1\varepsilon.\ n>N\Rightarrow\tfrac1n<\varepsilon\Rightarrow\left|\tfrac1n-0\right|<\varepsilon.$$

> [!NOTE] **When It Flips:** an infinite [[Geometric Series]] is the *limit* of partial sums (exists iff $|r|<1$); for diverging sequences, [[Big-O Notation|growth order]] replaces a finite limit. Only the infinite tail matters, never a finite prefix.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Prove $\lim_{n\to\infty}\tfrac1n=0$ and find $N$ for $\varepsilon=0.01$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{given }\varepsilon>0,\ N&>\tfrac1\varepsilon \Rightarrow n>N \Rightarrow \tfrac1n<\varepsilon \\
\varepsilon=0.01 &: N=101 \Rightarrow a_{102}=\tfrac1{102}<0.01\ \checkmark
\end{aligned}
$$
**Final Extracted Output:** $N=\lceil1/\varepsilon\rceil$ works for every $\varepsilon$ ⟹ limit 0.

## ⚠️ Common Mistakes
- 💡 **Order matters** ➔ $\forall\varepsilon\,\exists N$ lets $N$ depend on $\varepsilon$; swapping to $\exists N\,\forall\varepsilon$ demands one cutoff for all $\varepsilon$ — a far stronger, usually false claim.

## 🧠 Active Recall
> [!FAQ]- State the $\varepsilon$–$N$ definition and prove $\lim\frac1n=0$.
> - **Hint:** $N$ as a function of $\varepsilon$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\forall\varepsilon>0\ \exists N\ \forall n>N:\ |a_n-\ell|<\varepsilon$; take $N>\tfrac1\varepsilon$ for $\tfrac1n$.
> > - **Why:** **Exists for every $\varepsilon$** ➔ so the limit is 0.

> [!FAQ]- Why must $N$ depend on $\varepsilon$, and why only terms "beyond $N$"?
> - **Hint:** Quantifier order + eventually.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\forall\varepsilon\,\exists N$ picks $N$ after $\varepsilon$; tighter $\varepsilon$ needs later $N$.
> > - **Why:** **Tail only** ➔ finitely many early strays can't affect the limit.
