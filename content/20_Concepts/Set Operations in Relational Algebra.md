---
unit: FIT2094
week: 3
parent: "[[Relational Algebra]]"
tags: [CS/Databases, Math/SetTheory, Monash/CS_DS]
---
# [[Set Operations in Relational Algebra]]

**Context:** [[FIT2094_MOC]] · **union**, **intersect**, **difference** on [[Relation (Database)|relations]] · require **union-compatible** operands · the FIT1058 [[Set Operations (Mathematics)|set operations]] applied to data

> [!abstract] Quick Revision
> - **🎯 Objective:** set ops on relation bodies ➔ union $\cup$, intersect $\cap$, difference $-$.
> - **📦 Core Components:** require **union-compatible** operands (same arity, compatible domains).
> - **⚡ Key Constraint:** difference is **not symmetric** ($A-B\neq B-A$); duplicates auto-collapse.

![[relational-algebra-set-operation.png]]

## 📝 Core
### 1. The Operations
- **Union** ➔ $A\cup B$ = tuples in either (duplicates once).
- **Intersection** ➔ $A\cap B$ = tuples in both.
- **Difference** ➔ $A-B$ = tuples in $A$ not $B$.

### 2. Union-Compatibility
- **Same arity** ➔ same number of attributes.
- **Compatible domains** ➔ positionally matching [[Domain (Relational Model)|domains]].
- **Mandatory** ➔ else the result isn't a well-formed relation.

### 3. Symmetry
- **Symmetric** ➔ union, intersection commute.
- **Asymmetric** ➔ difference: $A-B\neq B-A$.

**Key identities:**

$$\text{STOREA}=\{1,2,3\},\ \text{STOREB}=\{1,2,33\} \quad(\text{by product\_id})$$
$$A\cup B=\{1,2,3,33\},\quad A\cap B=\{1,2\},\quad A-B=\{3\},\quad B-A=\{33\}$$

## ⚖️ Core Decision Matrix
| Operation | Symbol | Symmetric? | Result |
| :--- | :--- | :--- | :--- |
| union | $\cup$ | yes | either |
| intersection | $\cap$ | yes | both |
| difference | $-$ | **no** | in A not B |
| precondition | — | — | union-compatible |

> [!NOTE] **When It Flips:** these are exactly the FIT1058 set operations on the tuple sets — inclusion–exclusion and De Morgan carry over, with union-compatibility as the new precondition. Closure holds, so set ops compose with σ/π and joins. Unlike joins (different schemas), set ops need **identical** schemas.

## 📊 Exam Execution Trace

### Manual Execution Trace
STOREA$=\{1,2,3\}$, STOREB$=\{1,2,33\}$:

| Step / State | Op | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $A\cup B$ | $\{1,2,3,33\}$ |
| 2 | $A\cap B$ | $\{1,2\}$ |
| 3 | $A-B$ | $\{3\}$ |

## ⚠️ Common Mistakes
- 💡 **Union-compatibility required** ➔ same arity + positionally compatible domains (both `(product_id, product_name)`); difference is directional.

## 🧠 Active Recall
> [!FAQ]- Define union, intersection, and difference on relations, and the union-compatibility requirement.
> - **Hint:** Set ops + compatibility.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\cup$ = either, $\cap$ = both, $-$ = in A not B; operands must be union-compatible (same arity, compatible domains).
> > - **Why:** **Well-formed** ➔ compatibility ensures the result is a valid relation.

> [!FAQ]- Which set operation is not symmetric, and how do these relate to FIT1058 set theory?
> - **Hint:** Difference directional.
> > [!SUCCESS]- Answer
> > - **Short answer:** Difference: $A-B\neq B-A$; union/intersection commute.
> > - **Why:** **Tuple sets** ➔ these are FIT1058 set operations on relation bodies plus union-compatibility.
