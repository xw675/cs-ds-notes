---
unit: FIT1008
week: 2
parent: "[[Abstract Data Type (ADT)]]"
tags: [SWE/OOP, CS/Abstraction]
---
# [[Abstract Base Class]]

**Context:** [[FIT1008_MOC]] · the Python mechanism encoding an [[Abstract Data Type (ADT)]]'s contract as enforced code · base of [[Stack (ADT)]]/[[Queue (ADT)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** encode a contract in code ➔ some methods shared, others abstract; cannot be instantiated.
> - **📦 Core Components:** inherit `ABC` + `@abstractmethod` | storage-**independent** concrete vs storage-**dependent** abstract.
> - **⚡ Key Constraint:** instantiation **fails** until every abstract method is implemented ➔ early, checked guarantees.

## 📝 Core
### 1. The ABC (Enforced Contract)
- **Mechanism** ➔ some methods implemented (shared), others **abstract** for subclasses ➔ turns an [[Abstract Data Type (ADT)]] into enforced code.
- **Cannot instantiate** ➔ exists to be inherited; `Stack()` ➔ `TypeError`, `ArrayStack(6)` ➔ OK.
- **Python syntax** ➔ inherit `ABC`, decorate unimplemented methods `@abstractmethod`.

### 2. The Concrete/Abstract Split
- **Concrete (base)** ➔ storage-**independent** logic (`__len__`, `is_empty`, `clear`) reads shared `length` ➔ written once, inherited.
- **Abstract** ➔ storage-**dependent** logic (`push`/`pop`/`peek`/`is_full`) ➔ only a subclass that knows its storage can implement it.

## ⚙️ Core Implementation
### 🔹 `Stack(ABC, Generic[T])`
> [!code]- abstract + concrete methods
> ```python
> from abc import ABC, abstractmethod
> from typing import TypeVar, Generic
> T = TypeVar('T')                       # generic placeholder type
>
> class Stack(ABC, Generic[T]):
>     def __init__(self) -> None:
>         self.length = 0                # concrete, shared
>     @abstractmethod
>     def push(self, item: T) -> None: ...   # no body -> subclass MUST implement
>     def is_empty(self) -> bool:        # concrete, inherited
>         return len(self) == 0
> # Stack()       -> TypeError (abstract)
> # ArrayStack(6) -> OK (implements the abstract methods)
> ```
> 💡 **Common Mistake:** **Instantiation blocked until all abstract methods exist** ➔ `Generic[T]` parameterises by element type (`Stack[int]`) for consistent checking without per-type duplication.

## ⚖️ Core Decision Matrix
| | Abstract method | Concrete method |
| :--- | :--- | :--- |
| Body? | ❌ (`...`) | ✅ |
| Decorator | `@abstractmethod` | none |
| Subclass must override? | ✅ | optional |
| Blocks instantiation? | ✅ until implemented | ❌ |

> [!NOTE] **When It Flips:** three ways to satisfy an interface — **ABC** (nominal, enforced, allows shared code), **pure interface** (Java `interface`, contract only), **duck typing** (structural, flexible but unchecked until call time). ABCs trade flexibility for early, checked guarantees.

## 📊 Exam Execution Trace

### Manual Execution Trace
Which methods go where:

| Step / State | Method | Depends on | Placement |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | `is_empty`/`__len__` | shared `length` | **concrete** (base) |
| 2 | `clear` | shared state | concrete (base) |
| 3 | `push`/`pop`/`peek` | backing storage | **abstract** |
| 4 | `is_full` | storage capacity | abstract |

### Applied Exercise
**Problem:** Show how the ABC enforces the contract at instantiation.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\texttt{Stack()} &\Rightarrow \text{TypeError (abstract methods unimplemented)} \\
\texttt{ArrayStack(6)} &\Rightarrow \text{OK (all abstract methods supplied)}
\end{aligned}
$$
**Final Extracted Output:** the ABC blocks instantiation until the full abstract set is implemented — a compile/instantiation-time guarantee.

## 🧠 Active Recall
> [!FAQ]- Compare an ABC, a pure interface, and duck typing as ways to satisfy an ADT's contract.
> - **Hint:** Nominal-enforced vs structural-deferred.
> > [!SUCCESS]- Answer
> > - **Short answer:** **ABC** = nominal + enforced (+ shared code); **pure interface** = contract only; **duck typing** = structural, unverified until call time.
> > - **Why:** **Trade-off** ➔ ABCs give early checked guarantees at the cost of rigid hierarchies; duck typing is flexible but defers errors to run time.

> [!FAQ]- Which methods belong concrete in the base class and which stay abstract?
> - **Hint:** Storage-independent vs storage-dependent.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Concrete** = `__len__`/`is_empty`/`clear` (shared `length`); **abstract** = `push`/`pop`/`peek`/`is_full` (backing store).
> > - **Why:** **Knowledge boundary** ➔ only a concrete subclass that knows its storage can implement the storage-dependent ops.

> [!FAQ]- Why does inheriting from an ABC and honouring its contract make subclasses safely interchangeable?
> - **Hint:** Full operation set + invariant preservation.
> > [!SUCCESS]- Answer
> > - **Short answer:** Every subclass implements all abstract operations with the specified behaviour and preserves the class [[Invariant]].
> > - **Why:** **ADT promise** ➔ a client coded against the base behaves correctly with any subclass — swap array-backed for linked with no client change.
