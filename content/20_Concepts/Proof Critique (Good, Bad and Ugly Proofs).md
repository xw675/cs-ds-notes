---
unit: FIT2014
week: 2
parent: "[[Proof Techniques]]"
tags: [Math/Proof, Math/Theory]
aliases: [bad proofs, faulty induction, spot the error, ex falso quodlibet, proof style, ugly proofs, four colour theorem]
---
# [[Proof Critique (Good, Bad and Ugly Proofs)]]

**Context:** [[FIT2014_MOC]] · judging whether an argument **is** a proof, and whether it is a *good* one · the "what is wrong with this proof?" skill · builds on [[Proof Techniques]] and [[Mathematical Induction]]

> [!abstract] Quick Revision
> - **🎯 Objective:** classify proofs as **good** (correct + illuminating), **bad** (invalid) or **ugly** (valid but graceless) ➔ and, for bad ones, name the exact broken step.
> - **⚡ Key Constraint:** most faulty inductions break in one of two places — a **missing/false base case**, or an **inductive step that fails at the smallest $k$** even though it looks fine in general.

## ✅ Good proofs — the hallmarks
- **Correct, short, illuminating** ➔ classic exemplars: **Euclid** (infinitely many primes), **$\sqrt{2}$ is irrational**, **Cantor** (the set of all languages is uncountable — see [[Countability and Cantor Diagonalisation]]).
- **$\sqrt{2}$ irrational (sketch)** ➔ assume $\sqrt2=\frac{m}{n}$ in lowest terms; then $2n^{2}=m^{2}$, so $m$ is even, $m=2k$; substituting gives $n^{2}=2k^{2}$, so $n$ is even too — contradicting "no common factors".
- **Shared move** ➔ each *chooses the right object* (the number $q=p_1p_2\cdots p_n+1$; a fraction in lowest terms; the diagonal language) — the creative step that makes the contradiction bite.

## ❌ Bad proofs — the catalogue
### 1. Reasoning from a falsehood
- **Ex falso quodlibet** ➔ from a false premise **anything** follows, because $P\Rightarrow Q$ is **True whenever $P$ is False**.
- **Hardy's joke** ➔ from $2+2=5$ derive $4=5$, so $1=2$; since $|\{\text{McTaggart},\text{the Pope}\}|=2=1$, "McTaggart is the Pope".

### 2. Induction with no valid base case
- **"Theorem": every graph has a cycle** ➔ the step (remove a vertex $v$, apply the hypothesis to $G-v$, note a cycle in $G-v$ is a cycle in $G$) is *locally* fine, but the proof **assumes** "every graph on $n$ vertices has a cycle" and never establishes a base case. Trees are the counterexample.
- **Diagnosis** ➔ no basis ⟹ the chain never starts, so nothing is proved.

### 3. Induction whose step fails at the smallest case
- **"Theorem": every string over $\{\mathtt{a},\mathtt{b}\}$ is uniform** (all letters identical) ➔ the step takes $w$ of length $n+1$, deletes the first letter to get $w_1$ and the last to get $w_2$, claims both are uniform by hypothesis, then argues they **overlap** in $n-1$ letters so must use the same letter.
- **Diagnosis** ➔ the overlap argument needs $n-1>0$; at $n=1$ the two substrings **do not overlap**, so the step fails exactly at the join between the base case and the rest. A step that works "for large $n$" is not enough.

### 4. Mis-stated inductive hypotheses
| Attempted phrasing | Verdict |
| :--- | :--- |
| "Assume that **for all $k$**, $S(k)$ is true" | ❌ assumes what we are trying to prove |
| "Assume that **for some $k$**, $S(k)$ is true" | ❌ assumes only what the base case already gives |
| "Assume $S(k)$ is true, **for some $k$**" | ❌ same mistake |
| "**Let $k\ge1$.** Assume $S(k)$ is true" | ✅ announces $k$ as **arbitrary** subject to the stated condition |

## 🟡 Ugly proofs — valid but graceless
- **Unnecessary contradiction dressing** ➔ wrapping a perfectly **direct** proof in "assume the opposite … contradiction". The $\text{DOUBLEWORD}\subseteq\text{EVEN-EVEN}$ proof needs no contradiction: derive membership directly. **When you have a direct proof, don't dress it up.**
- **Enormous / computer-assisted proofs** ➔ the **Four Colour Theorem** (every planar graph has a 4-colouring) was proved by checking 1476 configurations by computer across ~400 pages (Appel–Haken 1977), later reduced to 633 configurations (Robertson et al. 1997) and finally **formally machine-verified** (Gonthier 2008). Valid, but hard for a human to *understand*.
- **Proofs that shrink over time** ➔ **Abel–Ruffini** (no general algebraic formula for polynomial roots of degree $\ge5$): Ruffini's incomplete proof ran >500 pages (1799), his complete one 140 pages (1813), and Abel's just **six pages** (1824).

## ⚠️ Common Mistakes
- 💡 **A locally-valid step is not a valid induction** ➔ always test the step at the **smallest** $k$ it must cover; the graph-cycle and uniform-string "proofs" both look fine for large $n$.
- 💡 **The inductive hypothesis must fix an arbitrary $k$** ➔ "for all $k$" begs the question; "for some $k$" is too weak. Write "**Let $k\ge1$. Assume $S(k)$.**"
- 💡 **Contradiction is not a default wrapper** ➔ reach for it when the direct route is hard; otherwise it obscures the argument (an *ugly* proof).
- 💡 **Valid ≠ good** ➔ correctness is the bar; brevity, clarity and insight are what make a proof *good*.

## 🧠 Active Recall
> [!FAQ]- The "every string is uniform" induction has a correct-looking step. Where exactly does it break?
> > [!SUCCESS]- Answer
> > - **Short answer:** the step deletes the first and last letters of a length-$(n{+}1)$ string to get $w_1,w_2$ of length $n$, then argues they **overlap in $n-1$ letters** and so must use the same letter. That requires $n-1>0$, i.e. $n\ge2$ — at **$n=1$** the two pieces don't overlap and nothing forces them to agree.
> > - **Why:** **The chain breaks at the first link** ➔ the base case covers $n=1$, but the step only works from $n\ge2$ onward, so $S(1)\Rightarrow S(2)$ is never established and the cascade never propagates.

> [!FAQ]- Why is "assume that for all $k$, $S(k)$ is true" a fatal way to open an inductive step?
> > [!SUCCESS]- Answer
> > - **Short answer:** it assumes the **conclusion** ($\forall n\,S(n)$) as the hypothesis — circular reasoning. The correct opening fixes an **arbitrary but particular** $k$: "Let $k\ge1$. Assume $S(k)$."
> > - **Why:** **Arbitrary, not universal** ➔ induction proves the *implication* $S(k)\Rightarrow S(k+1)$ for an unspecified $k$; assuming the universal statement outright makes the argument prove nothing, while "for some $k$" merely restates the base case.
