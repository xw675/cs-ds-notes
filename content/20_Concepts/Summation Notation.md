---
unit: FIT1058
domain: D
week: 6
parent: "[[Sequence (Mathematics)]]"
tags: [Math/Discrete, Math/Sequences]
---
# [[Summation Notation]]

**Context:** [[FIT1058_MOC]] · the $\sum$ sign for adding a [[Sequence (Mathematics)|sequence]]'s terms · partial sums form a new sequence · evaluated by [[Arithmetic Series]] / [[Geometric Series]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\sum_{i=1}^n s_i$ = add a sequence's terms ➔ partial sums $(S_n)$ form a new sequence.
> - **📦 Core Components:** index ➔ range ➔ summand ➔ bound local variable.
> - **⚡ Key Constraint:** math fixes no order (associative/commutative); code's finite arithmetic is order-sensitive.

## 📝 Core
### 1. The Notation
- **Definition** ➔ $S_n=\sum_{i=1}^n s_i=s_1+\dots+s_n$; partial sums are a new sequence.
- **Anatomy** ➔ $i$ = index; $i=1$ initial; $n$ final; $[1,n]_{\mathbb N}$ range; $s_i$ summand.
- **Evaluate** ➔ substitute each index value, add.

### 2. Notation vs Algorithm
- **Math** ➔ specifies the *result*, fixes **no order** (addition associative + commutative).
- **Program** ➔ also fixes order, names/initialises the total; finite arithmetic isn't perfectly associative ⟹ rounding depends on order.

### 3. The Index Is Bound
- **Arbitrary name** ➔ $\sum_i s_i=\sum_j s_j$ (renamed consistently).
- **Local** ➔ scope = the summation, like a [[Term, Variable, and Constant|bound variable]] under a [[Quantifiers (Existential and Universal)|quantifier]].
- **Reuse warning** ➔ outer $i$ differs from summation's $i$.

**Key identities:**

$$S_n=\sum_{i=1}^{n}s_i=s_1+s_2+\dots+s_n,\qquad \sum_{i=1}^n s_i=\sum_{j=1}^n s_j\ (\text{reindex})$$

## ⚖️ Core Decision Matrix
| Aspect | Notation | Program |
| :--- | :--- | :--- |
| specifies | the result | result + order |
| order | none (assoc/comm) | fixed |
| arithmetic | exact | finite precision |
| rounding | n/a | order-dependent |

> [!NOTE] **When It Flips:** studying the partial-sum sequence $(S_n)$ is often the goal; its closed form comes from [[Arithmetic Series|arithmetic]] / [[Geometric Series|geometric]] series formulas. Mathematically the sum is unique; in floating-point, order changes accumulated error.

## 📊 Exam Execution Trace

### Manual Execution Trace
$\sum_{i=1}^5(2i-1)$:

| Step / State | $i$ | $s_i=2i-1$ | $S_i$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | 0 |
| 1 | 1 | 1 | 1 |
| 2 | 2 | 3 | 4 |
| 3 | 3 | 5 | 9 |
| 4 | 4,5 | 7,9 | 16,25 |

## ⚠️ Common Mistakes
- 💡 **Reindex everywhere** ➔ change both limits and the summand together, and avoid a name already used outside; the index is a bound, local variable.

## 🧠 Active Recall
> [!FAQ]- Name every part of $\sum_{i=1}^n s_i$ and why the letter $i$ doesn't matter.
> - **Hint:** Bound local index.
> > [!SUCCESS]- Answer
> > - **Short answer:** $i$ index, $i=1$ initial, $n$ final, $[1,n]$ range, $s_i$ summand; renaming consistently leaves the value unchanged.
> > - **Why:** **Scope** ➔ the index is local, like a quantifier-bound variable.

> [!FAQ]- Why does summation impose no order, yet a program's sum can be order-dependent?
> - **Hint:** Exact vs finite precision.
> > [!SUCCESS]- Answer
> > - **Short answer:** Addition is associative/commutative, so $\sum$ is a single value; a program fixes order and uses finite precision.
> > - **Why:** **Rounding** ➔ different orders accumulate error differently.
