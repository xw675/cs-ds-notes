---
unit: FIT1008
week: 2
parent: "[[Abstract Data Type (ADT)]]"
tags: [CS/DataStructures, CS/Abstraction]
---
# [[Data Type]]

**Context:** [[FIT1008_MOC]] · an [[Abstract Data Type (ADT)]] **plus** an implementation · the middle rung of the abstraction ladder · contrast [[Data Structure]]

> [!abstract] Quick Revision
> - **🎯 Objective:** values + meaning + operations + a concrete implementation ➔ an ADT made concrete.
> - **📦 Core Components:** **ADT** (no impl) ➔ **Data Type** (ADT + impl) ➔ **[[Data Structure]]** (layout).
> - **⚡ Key Constraint:** the implementation a data type pins down **fixes the operations' complexity**.

## 📝 Core
### 1. The Data Type (ADT + Implementation)
- **Definition** ➔ values + meaning + operations **+** a concrete **implementation** (`int`, `str`, `list`).
- **Abstraction ladder** ➔ ADT (no impl) → data type (ADT + impl) → [[Data Structure]] (layout, op = *access*).
- **Cost consequence** ➔ the implementation is exactly what fixes the operations' complexity.

### 2. Type Systems
- **Checking time** ➔ **static** (compile-time, Java/C++) vs **dynamic** (run-time, Python).
- **Other axes** ➔ strong vs weak coercion | primitive (`int`) vs composite (`list`) | **value** (copied) vs **reference** (shared) semantics.
- **Type safety** ➔ prevents applying an operation to an incompatible value.

## ⚙️ Core Implementation
### 🔹 Values, operations, implementation
> [!code]- data types in Python
> ```python
> x: int = 7          # values (…-1,0,1…), meaning (integers), ops (+,//,<), bit-level impl
> y = x // 2          # the operation's result depends on the implementation
> s: str = "abcd"     # a different data type with its own values/ops/impl
> ```
> 💡 **Common Mistake:** **Value vs reference semantics** ➔ value copies on assignment (mutation can't affect the original); reference shares the object (mutation affects all names) — the classic Python-mutable-aliasing bug.

## ⚖️ Core Decision Matrix
| Concept | Values + meaning | Operations | Implementation |
| :--- | :--- | :--- | :--- |
| [[Abstract Data Type (ADT)]] | ✅ | ✅ | ❌ |
| **Data Type** | ✅ | ✅ | ✅ |
| [[Data Structure]] | values only | *access* only | ✅ (layout) |

> [!NOTE] **When It Flips:** complexity follows implementation — the same ADT realised as different data types has different costs (the implementation is what a data type adds). Static-vs-dynamic trade-off: early error detection + optimisation vs flexibility + development speed.

## 📊 Exam Execution Trace

### Manual Execution Trace
Placing `list` on the abstraction ladder:

| Step / State | Role | Answer for `list` |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | ADT | "ordered sequence with index access" (interface) |
| 2 | **Data Type** | `list` — interface **+** dynamic-array storage + complexities |
| 3 | Data Structure | the resizable [[Array (Data Structure)]] underneath |

### Applied Exercise
**Problem:** Enumerate the type-system axes that classify a data type.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{checking time} &: \text{static (compile)} \;\;\text{vs}\;\; \text{dynamic (run)} \\
\text{coercion} &: \text{strong} \;\;\text{vs}\;\; \text{weak} \\
\text{assignment} &: \text{value (copy)} \;\;\text{vs}\;\; \text{reference (share)}
\end{aligned}
$$
**Final Extracted Output:** a data type is positioned by checking-time, coercion strength, and assignment semantics.

## 🧠 Active Recall
> [!FAQ]- In the unit's terms, distinguish an ADT, a data type, and a data structure, and place `list` in each role.
> - **Hint:** Three rungs of the abstraction ladder.
> > [!SUCCESS]- Answer
> > - **Short answer:** ADT = interface only; data type = ADT + implementation; data structure = physical layout.
> > - **Why:** **`list`** ➔ data type; "ordered sequence with index access" = ADT; the resizable [[Array (Data Structure)]] = data structure.

> [!FAQ]- Contrast static vs dynamic typing and name the core trade-off.
> - **Hint:** When type checking happens.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Static** = compile-time (errors early, optimisable); **dynamic** = run-time (flexible, concise).
> > - **Why:** **Trade-off** ➔ early safety/performance vs flexibility/development speed.

> [!FAQ]- Why do value semantics and reference semantics matter for a data type?
> - **Hint:** What assignment/passing does.
> > [!SUCCESS]- Answer
> > - **Short answer:** Value copies (mutation can't affect the original); reference shares (mutation affects all references).
> > - **Why:** **Aliasing** ➔ governs whether a mutable object is unexpectedly shared — a frequent bug source.
