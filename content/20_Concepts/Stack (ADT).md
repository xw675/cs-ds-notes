---
unit: FIT1008
week: [2, 5]
parent: "[[Abstract Data Type (ADT)]]"
tags: [CS/DataStructures, SWE/OOP, CS/Abstraction, CS/Complexity]
---
# [[Stack (ADT)]]

**Context:** [[FIT1008_MOC]] · a **LIFO** [[Abstract Data Type (ADT)]] · backbone clustering its **ArrayStack** and **LinkStack** implementations · contract via [[Abstract Base Class]]

> [!abstract] Quick Revision
> - **🎯 Objective:** LIFO top-only access ➔ the ADT behind the call stack, recursion/DFS, expression evaluation.
> - **📦 Core Components:** **Contract** ➔ ABC `push`/`pop`/`peek` | **ArrayStack** ➔ contiguous, fixed/growable | **LinkStack** ➔ [[Node]] chain, never full.
> - **⚡ Key Constraint:** all ops $O(1)$ ➔ decision is **space**: wasted array slack vs one pointer/node (crossover ≈ half-full).

## 📝 Core
### 1. Stack Contract (LIFO)
- **LIFO discipline** ➔ `push`/`pop`/`peek` act only at the **top**; last-in-first-out.
- **Interface** ➔ `push` · `pop` · `peek` · `is_empty` · `is_full` · `__len__` · `clear`.
- **ABC split** ➔ storage-independent (`__len__`, `is_empty`) concrete | `push`/`pop`/`peek`/`is_full` `@abstractmethod` | `Stack()` ➔ `TypeError`.

### 2. ArrayStack (Array-Backed)
- **Storage substrate** ➔ fixed [[Array (Data Structure)]] + int `length`; `top = length-1`.
- **Structural invariant** ➔ valid data in `0..length-1` ([[Invariant]]); beyond = garbage.
- **Growth mode** ➔ fixed raises on overflow | growable doubles ➔ `push` $O(1)$ amortised ([[Dynamic Array Resizing]]).

### 3. LinkStack (Linked)
- **Storage substrate** ➔ [[Node]] chain + single `top` pointer at head.
- **Pointer mechanics** ➔ `push` ➔ `new.link=top` | `top=new`; `pop` ➔ `top=top.link` (old node GC'd).
- **Never full** ➔ no `is_full`, no resize; memory shrinks on `pop` — a fixed array cannot.

## ⚙️ Core Implementation
### 🔹 Abstract Base — the contract
> [!code]- `Stack(ABC, Generic[T])`
> ```python
> class Stack(ABC, Generic[T]):
>     def __init__(self): self.length = 0
>     @abstractmethod
>     def push(self, item: T) -> None: ...    # storage-dependent -> abstract
>     @abstractmethod
>     def pop(self) -> T: ...
>     @abstractmethod
>     def peek(self) -> T: ...
>     def __len__(self) -> int: return self.length   # shared -> concrete
>     def is_empty(self) -> bool: return len(self) == 0
> ```
> 💡 **Common Mistake:** **`is_full` is abstract** ➔ fullness depends on storage capacity, which only a concrete subclass knows; `is_empty` reads shared `length` so it is concrete.

### 🔹 ArrayStack
> [!code]- `ArrayStack(Stack[T])`
> ```python
> class ArrayStack(Stack[T]):
>     MIN_CAPACITY = 1                               # ArrayR can't be size 0
>     def __init__(self, max_capacity: int) -> None:
>         Stack.__init__(self)                       # length = 0
>         self.array = ArrayR(max(self.MIN_CAPACITY, max_capacity))
>     def is_full(self) -> bool:
>         return len(self) == len(self.array)
>     def push(self, item: T) -> None:
>         if self.is_full(): raise Exception("Stack is full")
>         self.array[len(self)] = item; self.length += 1     # write then top++
>     def pop(self) -> T:
>         if self.is_empty(): raise Exception("Stack is empty")
>         self.length -= 1; return self.array[self.length]   # top-- then return
>     def peek(self) -> T:
>         if self.is_empty(): raise Exception("Stack is empty")
>         return self.array[self.length - 1]
> ```
> 💡 **Common Mistake:** **Growable `push` is amortised** ➔ doubling pays the $O(n)$ copy via geometric series ($<3n$); constant growth ➔ $\Theta(n^2)$. Guard with **exceptions**, not `assert` (`-O` strips it).

### 🔹 LinkStack
> [!code]- `LinkStack(Stack[T])`
> ```python
> class LinkStack(Stack[T]):
>     def __init__(self):
>         Stack.__init__(self);
>         self.top = None
>     def is_full(self):
>         return False                 # linked -> never full
>     def push(self, item):
>         new = Node(item);
>         new.link = self.top;
>         self.top = new;
>         self.length += 1
>     def pop(self):
>         if self.is_empty():
>             raise ValueError("Stack is empty")
>         item = self.top.item;
>         self.top = self.top.link;
>         self.length -= 1  # old node GC'd
>         return item
> ```
> 💡 **Common Mistake:** **Reassign `top` before unreachable** ➔ `pop` must set `top=top.link` so GC reclaims the old node; cost is one pointer/element + poor locality.

## ⚖️ Core Decision Matrix
| Variant / Strategy | Trigger Condition | Advantage (Pro) | Disadvantage (Con) / Complexity Bound | Cache / Memory Impact |
| :--- | :--- | :--- | :--- | :--- |
| **ArrayStack** (fixed) | Capacity known, dense | $O(1)$ push/pop/peek | raises if full; wastes $(C-n)w$ slack | contiguous, cache-friendly |
| **ArrayStack** (growable) | Unknown but bounded | $O(1)$ amortised push | resize copy $O(n)$ worst | contiguous, doubles on grow |
| **LinkStack** | Variable / unbounded | true $O(1)$, never full | $+1$ pointer/node; no random access | scattered, poor locality |

> [!NOTE] **When It Flips:** array of capacity $C$ holding $n$ uses $\approx Cw$; LinkStack uses $\approx 2nw$ ➔ **LinkStack wins when $n < C/2$** (array under half-full), ArrayStack wins when nearly full.

## 📊 Exam Execution Trace

### Manual Execution Trace
`ArrayStack(3)`: `push 7, push 4, pop, push 9, peek`

| Step / State | Trigger Op | `array` (cap 3) | `length` | Top idx | Return Payload |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `init` | `[_, _, _]` | `0` | $-$ | $-$ |
| 1 | `push 7` | `[7, _, _]` | `1` | `0` | $-$ |
| 2 | `push 4` | `[7, 4, _]` | `2` | `1` | $-$ |
| 3 | `pop` | `[7, 4, _]` | `1` | `0` | `4` |
| 4 | `push 9` | `[7, 9, _]` | `2` | `1` | $-$ |
| 5 | `peek` | `[7, 9, _]` | `2` | `1` | `9` |

### Applied Exercise
**Problem:** Bound the cost of $n$ `push`es on a doubling ArrayStack.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{copy work} &= 1 + 2 + 4 + \dots + n = \sum_{i=0}^{\log_2 n} 2^{i} = 2n - 1 \\
\text{total} &= \underbrace{n}_{\text{writes}} + \underbrace{(2n-1)}_{\text{copies}} < 3n \implies \text{amortised} = \tfrac{<3n}{n} = O(1)
\end{aligned}
$$
**Final Extracted Output:** `push` is $O(1)$ **amortised** (not worst-case); a single resize is $O(n)$.

## 🧠 Active Recall
> [!FAQ]- Why does a stack underlie both recursion and DFS, and what does that imply for converting recursion to iteration?
> - **Hint:** Identify the LIFO ⟷ call-stack equivalence and its de-recursification consequence.
> > [!SUCCESS]- Answer
> > - **Short answer:** Both resolve the **most-recently-started** task first ➔ LIFO discipline *is* a stack.
> > - **Why:** **Call-stack simulation** ➔ any [[Recursion]] becomes iterative via an explicit [[Stack (ADT)]] ([[Recursion|Recursion to Iteration via Stack]]) — push pending work, pop in reverse.

> [!FAQ]- ArrayStack vs LinkStack are both $O(1)$ per op — on what grounds do you choose?
> - **Hint:** Discriminate by space/cache, not asymptotic time.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Array** for dense/bounded/perf-critical; **Linked** for highly variable/unbounded size.
> > - **Why:** **Memory crossover** ➔ array $\approx Cw$ wastes slack; LinkStack $\approx 2nw$ pays a pointer/element — array wins near full, linked wins below half-full.

> [!FAQ]- A growable ArrayStack occasionally does an $O(n)$ resize, yet `push` is "$O(1)$" — justify, and why does the growth *factor* matter?
> - **Hint:** Apply amortised (aggregate) analysis and contrast multiplicative vs additive growth.
> > [!SUCCESS]- Answer
> > - **Short answer:** Doubling ➔ total of $n$ pushes $< 3n$ ➔ $O(1)$ **amortised**.
> > - **Why:** **Geometric vs arithmetic** ➔ multiplicative growth sums copies to $<2n$; constant growth $c$ resizes every $c$ pushes ➔ $\Theta(n^2)$.

> [!FAQ]- Why is `is_empty` concrete in the base class but `is_full` abstract?
> - **Hint:** Separate storage-independent from storage-dependent operations.
> > [!SUCCESS]- Answer
> > - **Short answer:** `is_empty` reads shared `length` ➔ written once, inherited; `is_full` needs storage capacity ➔ abstract.
> > - **Why:** **ABC contract** ➔ a fixed array has a capacity, a LinkStack never fills, so only a concrete subclass can define `is_full` ([[Abstract Base Class]]).
