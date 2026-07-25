---
unit: FIT1058
week: 2
parent: "[[Function (Mathematics)]]"
tags: [Math/Functions, Math/Discrete, Monash/CS_DS]
---
# [[Function Composition]]

**Context:** [[FIT1058_MOC]] · chains [[Function (Mathematics)|functions]] into a pipeline · needs codomain/domain to match · reverses on inversion · powers a [[Cryptosystem]]

> [!abstract] Quick Revision
> - **🎯 Objective:** feed one function's output into another ➔ $(g\circ f)(x)=g(f(x))$, "g after f".
> - **📦 Core Components:** matching (codom $f$ = dom $g$) ➔ associative ➔ identity neutral.
> - **⚡ Key Constraint:** **not commutative**; inverting reverses order ($(g\circ f)^{-1}=f^{-1}\circ g^{-1}$).

## 📝 Core
### 1. Composition (g after f)
- **Definition** ➔ $f:A\to B$, $g:B\to C$ ⟹ $g\circ f:A\to C$, $(g\circ f)(x)=g(f(x))$.
- **Order** ➔ right-hand function runs **first** (textual order reverses evaluation).
- **Matching** ➔ defined only when codomain of $f$ = domain of $g$.

### 2. Algebraic Properties
- **Not commutative** ➔ $g\circ f\neq f\circ g$ in general.
- **Associative** ➔ $h\circ(g\circ f)=(h\circ g)\circ f$.
- **Identity neutral** ➔ $g\circ i=g=i\circ g$; **iteration** ➔ $f^{(n)}=f\circ\cdots\circ f$.

### 3. Inverses (Socks-and-Shoes)
- **Cancel** ➔ $f^{-1}\circ f=i_A$, $f\circ f^{-1}=i_B$ ([[Inverse Function]]).
- **Reverse order** ➔ $(g\circ f)^{-1}=f^{-1}\circ g^{-1}$.
- **Application** ➔ cascaded encryptions build a stronger [[Cryptosystem]].

**Key identities:**

$$(g\circ f)(x)=g(f(x)),\qquad (g\circ f)^{-1}=f^{-1}\circ g^{-1}$$
$$(\text{Father}\circ\text{Mother})(p)=\text{Father}(\text{Mother}(p))\ (\text{maternal grandfather})$$

## ⚖️ Core Decision Matrix
| Property | Holds? | Statement |
| :--- | :--- | :--- |
| commutative | **no** | $g\circ f\neq f\circ g$ |
| associative | yes | $h\circ(g\circ f)=(h\circ g)\circ f$ |
| identity | yes | $g\circ i=g$ |
| bijection preserved | yes | $g\circ f$ bijective iff both are |

> [!NOTE] **When It Flips:** composition models multi-stage computation; non-commutativity means swapping stages changes the result. Cascading two ciphers gives key space $K\times K'$ and decryption $d_k\circ d'_{k'}$ (socks-and-shoes).

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Compute $g\circ f$ and $f\circ g$ at $x=3$; confirm non-commutativity.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
(g\circ f)(3) &= (3+1)^2 = 16 \\
(f\circ g)(3) &= 3^2+1 = 10 \\
16 &\neq 10 \Rightarrow g\circ f\neq f\circ g
\end{aligned}
$$
**Final Extracted Output:** $g\circ f=(x+1)^2$, $f\circ g=x^2+1$; non-commutative.

## ⚠️ Common Mistakes
- 💡 **Written order ≠ evaluation order** ➔ in $g\circ f$, $f$ runs first though $g$ is written first; to invert, reverse ($f^{-1}\circ g^{-1}$).

## 🧠 Active Recall
> [!FAQ]- State the matching condition for $g\circ f$ and why written order reverses evaluation order.
> - **Hint:** Codomain meets domain.
> > [!SUCCESS]- Answer
> > - **Short answer:** Requires codomain of $f$ = domain of $g$; $(g\circ f)(x)=g(f(x))$ applies $f$ first.
> > - **Why:** **Last acts leftmost** ➔ the notation lists the final function on the left.

> [!FAQ]- Justify the socks-and-shoes rule $(g\circ f)^{-1}=f^{-1}\circ g^{-1}$.
> - **Hint:** Undo the last step first.
> > [!SUCCESS]- Answer
> > - **Short answer:** $(f^{-1}\circ g^{-1})\circ(g\circ f)=f^{-1}\circ i\circ f=i$ (associativity).
> > - **Why:** **Reverse order** ➔ undo $g$ then $f$, like shoes before socks.

> [!FAQ]- Is composition commutative? Associative? What role does the identity play?
> - **Hint:** Order matters, grouping doesn't.
> > [!SUCCESS]- Answer
> > - **Short answer:** Not commutative; associative; identity is neutral ($g\circ i=g$).
> > - **Why:** **Unambiguous chains** ➔ associativity lets $h\circ g\circ f$ drop brackets.
