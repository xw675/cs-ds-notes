---
unit: FIT2094
week: 3
parent: "[[Relational Model]]"
tags: [CS/Databases, Math/SetTheory]
---
# [[Relation (Database)]]

**Context:** [[FIT2094_MOC]] · the central object of the [[Relational Model]] · **heading** (schema) + **body** (tuples) · sized by degree and cardinality

> [!abstract] Quick Revision
> - **🎯 Objective:** a structured set of data ➔ heading (schema) + body (tuples).
> - **📦 Core Components:** heading $R(A_1,\dots,A_n)$ ➔ body $\{t_1,\dots,t_m\}$.
> - **⚡ Key Constraint:** degree ($n$ attributes, fixed) vs cardinality ($m$ tuples, varies).

## 📝 Core
### 1. Two Parts
- **Heading (schema)** ➔ $R(A_1,\dots,A_n)$ — name + attributes, each from a [[Domain (Relational Model)|domain]].
- **Body (instance)** ➔ $r(R)=\{t_1,\dots,t_m\}$ — the current set of tuples, changing over time.

### 2. Tuple, Degree, Cardinality
- **Tuple** ➔ ordered list $t=\langle v_1,\dots,v_n\rangle$.
- **Degree** ➔ $n$ = number of **attributes** (heading property).
- **Cardinality** ➔ $m$ = number of **tuples** (body property, fluctuates).

### 3. Writing a Relation
- **Singular name** ➔ it denotes a set.
- **PK underlined** ➔ $\text{STAFF}(\underline{\text{staff\_id}}, \dots)$.

**Key identities:**

$$\text{CUSTOMER}(\underline{\text{custno}}, \text{custname}, \text{custadd}, \text{custcredlimit}) \quad(\text{heading, degree } 4)$$
$$r(\text{CUSTOMER})=\{t_1, t_2, t_3\} \quad(\text{body, cardinality } 3)$$

## ⚖️ Core Decision Matrix
| Term | Meaning | Belongs to |
| :--- | :--- | :--- |
| heading | schema $R(A_1,\dots,A_n)$ | structure |
| body | tuples $\{t_1,\dots,t_m\}$ | data |
| degree | # attributes $n$ | heading |
| cardinality | # tuples $m$ | body |

> [!NOTE] **When It Flips:** because the body is a *set*, no duplicate tuples and tuples/attributes are unordered ([[Relation Properties]]). An $n$-degree relation is a subset of the [[Cartesian Product]] of its attribute domains — the [[n-ary Relation]].

## 📊 Exam Execution Trace

### Manual Execution Trace
CUSTOMER with 3 rows:

| Step / State | Quantity | Value |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | degree | 4 (attributes) |
| 2 | cardinality | 3 (tuples) |
| 3 | PK | custno (underlined) |

## ⚠️ Common Mistakes
- 💡 **Degree fixed, cardinality varies** ➔ degree is a design-time schema property; cardinality is run-time data that changes as rows are inserted/deleted.

## 🧠 Active Recall
> [!FAQ]- Define the heading and body of a relation, and the terms degree and cardinality.
> - **Hint:** Schema vs instance.
> > [!SUCCESS]- Answer
> > - **Short answer:** Heading = $R(A_1,\dots,A_n)$ (structure); body = $\{t_1,\dots,t_m\}$ (data); degree = $n$ attributes; cardinality = $m$ tuples.
> > - **Why:** **Fixed vs varying** ➔ degree from the heading, cardinality from the body.

> [!FAQ]- How is a relation written, and how does it correspond to the n-ary relation?
> - **Hint:** Singular + underlined PK.
> > [!SUCCESS]- Answer
> > - **Short answer:** Singular name, PK underlined; a degree-$n$ relation is a subset of the product of $n$ domains.
> > - **Why:** **Same terms** ➔ degree (attributes) and cardinality (tuples) match the [[n-ary Relation]].
