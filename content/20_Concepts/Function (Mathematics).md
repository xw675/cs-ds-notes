---
unit: FIT1058
week: 2
parent: "[[Binary Relation]]"
tags: [Math/Functions, Math/Discrete]
---
# [[Function (Mathematics)]]

**Context:** [[FIT1058_MOC]] · the formal model of a computational task · three parts (domain, codomain, rule) · its graph is a subset of a [[Cartesian Product]] · a special [[Binary Relation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** assign each domain element exactly one codomain value ➔ models *what* a task does, not *how*.
> - **📦 Core Components:** domain ➔ codomain ➔ rule ➔ graph $\subseteq$ dom $\times$ codomain.
> - **⚡ Key Constraint:** totality + single-valuedness — every input has **exactly one** output.

## 📝 Core
### 1. The Function (Triple)
- **Three parts** ➔ **domain** (inputs), **codomain** (output space), **rule** ($x\mapsto f(x)$).
- **Defining constraint** ➔ every input has **exactly one** output (total + single-valued).
- **What not how** ➔ specifies input/output, no algorithm required.

### 2. The Graph (Set of Pairs)
- **Definition** ➔ $\text{graph}(f)=\{(x,f(x)):x\in\text{dom}\}\subseteq\text{dom}\times\text{codomain}$.
- **Functional relation** ➔ each domain element is the first coordinate of **exactly one** pair.
- **Arrows** ➔ exactly one arrow leaves each domain point (never 0, never 2).

### 3. Standard Functions
- **Identity** ➔ $i_A(x)=x$; **constant** ➔ $c_a(x)=a$.
- **Indicator** ➔ $\chi_A(x)=1$ if $x\in A$ else $0$; **empty** ➔ $\emptyset:\emptyset\to\emptyset$.

**Key identities:**

$$f:\text{domain}\to\text{codomain},\qquad x\mapsto f(x); \qquad f:\mathbb R\to\mathbb R,\ x\mapsto x^2$$
$$\text{graph}(f)=\{(x,f(x)):x\in\text{dom}(f)\}\subseteq\text{dom}(f)\times\text{codomain}$$

## ⚖️ Core Decision Matrix
| Aspect | Requirement | Consequence |
| :--- | :--- | :--- |
| totality | every input mapped | no missing outputs |
| single-valued | one output each | no ambiguity |
| domain part of identity | same rule, different domain | **different** function |
| multi-argument | domain is a [[Cartesian Product]] | $f(x,y)=f((x,y))$ |

> [!NOTE] **When It Flips:** a function is the **triple** (domain, codomain, rule), not the rule alone — same formula on different domains gives different functions. The rule ($x\mapsto x^2$) is the *what*; an algorithm is the *how*.

## 📊 Exam Execution Trace

### Manual Execution Trace
$f:\{1,2,3\}\to\mathbb Z$, $f(x)=2x-1$:

| Step / State | $x$ | $f(x)$ | Pair |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | 1 | 1 | $(1,1)$ |
| 2 | 2 | 3 | $(2,3)$ |
| 3 | 3 | 5 | $(3,5)$ |

## ⚠️ Common Mistakes
- 💡 **$\to$ links sets, $\mapsto$ links elements** ➔ $A\to B$ is a signature; $x\mapsto f(x)$ maps one element to its value — not interchangeable.

## 🧠 Active Recall
> [!FAQ]- Why are two functions with identical rules but different domains different functions?
> - **Hint:** Function = triple.
> > [!SUCCESS]- Answer
> > - **Short answer:** The domain (and codomain) is part of a function's identity, not just the rule.
> > - **Why:** **Different graphs** ➔ $w^3{+}\dots$ on $\mathbb Z^4$ vs $\mathbb R^4$ are different sets of pairs.

> [!FAQ]- What is the graph, and what property makes a function more than an arbitrary set of pairs?
> - **Hint:** Functional relation.
> > [!SUCCESS]- Answer
> > - **Short answer:** graph$=\{(x,f(x))\}$; each domain element is the first coordinate of exactly one pair.
> > - **Why:** **Total + single-valued** ➔ exactly one arrow leaves each domain point.

> [!FAQ]- Distinguish a function's *rule* from an *algorithm* (squaring example).
> - **Hint:** What vs how.
> > [!SUCCESS]- Answer
> > - **Short answer:** The rule $x\mapsto x^2$ fixes each output; an algorithm is a step-by-step method.
> > - **Why:** **No method required** ➔ many algorithms can realise the same rule.
