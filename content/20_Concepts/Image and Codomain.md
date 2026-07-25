---
unit: FIT1058
week: 2
parent: "[[Function (Mathematics)]]"
tags: [Math/Functions, Math/Discrete, Monash/CS_DS]
---
# [[Image and Codomain]]

**Context:** [[FIT1058_MOC]] · the two "output sets" of a [[Function (Mathematics)|function]] · image $\subseteq$ codomain · the gap is closed by [[Injection, Surjection, Bijection|surjectivity]]

> [!abstract] Quick Revision
> - **🎯 Objective:** codomain = declared output set; image = values actually produced ➔ image $\subseteq$ codomain.
> - **📦 Core Components:** codomain (promise) ➔ image $\{f(x)\}$ (truth).
> - **⚡ Key Constraint:** image = codomain **iff** surjective; the exact image is often intractable.

## 📝 Core
### 1. Two Output Sets
- **Codomain** ➔ declared output space $B$, guaranteed to contain every $f(x)$.
- **Image** ➔ $\text{Image}(f)=\{f(x):x\in A\}$, the exact set of values.
- **Inclusion** ➔ image $\subseteq$ codomain (possibly proper).

### 2. Promise vs Truth
- **Codomain promises** ➔ all outputs lie in $B$, but not that every element of $B$ is hit.
- **Why generous** ➔ the exact image can be hard/impossible to pin down (sum-of-four-cubes is open).
- **Examples** ➔ Fibonacci image $\{1,2,3,5,8,\dots\}\subsetneq\mathbb N$; $x^2$ image $\mathbb R^+_0\subsetneq\mathbb R$.

### 3. When They Coincide
- **Surjective** ➔ image = codomain ➔ every codomain element is used.
- **Terminology** ➔ avoid "range" (ambiguous); use codomain / image.

**Key identities:**

$$\text{Image}(f)=\{f(x):x\in A\}\subseteq B=\text{codomain}$$
$$\text{surjective}\iff \text{Image}(f)=\text{codomain}$$

## ⚖️ Core Decision Matrix
| Set | Meaning | Determined by |
| :--- | :--- | :--- |
| codomain | declared output space | the specification |
| image | achieved values | the rule |
| relation | image $\subseteq$ codomain | always |
| equality | image = codomain | surjective |

> [!NOTE] **When It Flips:** the codomain is chosen for convenience; the image is forced by the rule. "Surjective" is exactly "the codomain promise is met with nothing unused". The preimages $f^{-1}(y)$ partition the domain ([[Equivalence Relation]]).

## 📊 Exam Execution Trace

### Manual Execution Trace
$f:\{-1,0,1,2\}\to\mathbb Z$, $f(x)=x^2$:

| Step / State | $x$ | $f(x)$ | Image so far |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | $\emptyset$ |
| 1 | $-1,1$ | 1 | $\{1\}$ |
| 2 | 0 | 0 | $\{0,1\}$ |
| 3 | 2 | 4 | $\{0,1,4\}$ |

## ⚠️ Common Mistakes
- 💡 **Codomain must contain all values** ➔ a set smaller than the image is not a valid codomain; a generous codomain (e.g. $\mathbb Z$) is chosen because the exact image may be intractable.

## 🧠 Active Recall
> [!FAQ]- Distinguish codomain and image, and why do we usually specify a codomain rather than the image?
> - **Hint:** Promise vs truth.
> > [!SUCCESS]- Answer
> > - **Short answer:** Codomain = declared output set (promise); image = exact values produced.
> > - **Why:** **Intractable image** ➔ a clean superset like $\mathbb Z$ is easy to state and still valid (sum-of-four-cubes is open).

> [!FAQ]- Why avoid "range", and when does image equal codomain?
> - **Hint:** Surjectivity.
> > [!SUCCESS]- Answer
> > - **Short answer:** "Range" is ambiguous (image or codomain); image = codomain exactly when surjective.
> > - **Why:** **Onto** ➔ every codomain element is some $f(x)$, no unused elements.
