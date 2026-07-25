---
unit: FIT1008
week: [3, 5]
parent: "[[Abstract Data Type (ADT)]]"
tags: [CS/DataStructures, SWE/OOP, CS/Abstraction, CS/Complexity]
---
# [[Queue (ADT)]]

**Context:** [[FIT1008_MOC]] · a **FIFO** [[Abstract Data Type (ADT)]] · backbone clustering its **LinearQueue / CircularQueue / LinkQueue** implementations · the dual of [[Stack (ADT)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** FIFO front-only access ➔ the ADT behind BFS, scheduling, buffering, producer–consumer.
> - **📦 Core Components:** **Contract** ➔ `append`/`serve`, two moving ends | **LinearQueue** ➔ leaks space | **CircularQueue** ➔ ring, no waste | **LinkQueue** ➔ two-pointer chain, unbounded.
> - **⚡ Key Constraint:** all ops $O(1)$ ➔ **two ends move** ⟹ array versions need `front`+`rear`, creating the wasted-space flaw the ring fixes.

## 📝 Core
### 1. Queue Contract (FIFO)
- **FIFO discipline** ➔ `append` at rear, `serve` from front; only the **front** accessible.
- **Interface** ➔ `append` · `serve` · `is_empty` · `is_full` · `__len__` · `clear`.
- **Stack contrast** ➔ single difference = access end (LIFO newest vs FIFO oldest) ➔ queues for arrival-order (BFS, scheduling).

### 2. LinearQueue (Naïve Array)
- **Storage substrate** ➔ fixed [[Array (Data Structure)]] + `front`, `rear`, `length`; both indices move **rightward only**.
- **Invariant** ➔ valid data `front..rear-1`, `rear - front == length` ([[Invariant]]).
- **Space leak** ➔ `is_full` tests `rear == len(array)` ➔ reports full while holding freed cells.

### 3. CircularQueue (Ring Buffer)
- **Mechanism** ➔ array as a **ring**; `front`/`rear` wrap to 0 via modulo ➔ reuses freed cells, all $O(1)$.
- **Full/empty ambiguity** ➔ both give `rear == front` ➔ track `length` OR **sacrifice one slot**.
- **Traversal** ➔ must start at `front` and step `% len` (live cells may straddle the end).

### 4. LinkQueue (Two-Pointer Chain)
- **Storage substrate** ➔ [[Node]] chain + `front` (serve) and `rear` (append) pointers.
- **`rear` payoff** ➔ tail-append $O(1)$ (vs $O(n)$ for a plain [[List (ADT)|LinkList]]); unbounded, no wrap logic.
- **Invariant** ➔ `front is None` ⇔ `rear is None`; the two empty-boundary transitions must keep both in sync.

## ⚙️ Core Implementation
### 🔹 Abstract Base — the contract
> [!code]- `Queue(ABC, Generic[T])`
> ```python
> class Queue(ABC, Generic[T]):
>     def __init__(self): self.length = 0
>     @abstractmethod
>     def append(self, item: T) -> None: ...   # add to rear
>     @abstractmethod
>     def serve(self) -> T: ...                 # remove from front
>     def __len__(self): return self.length
>     def is_empty(self): return len(self) == 0
> ```
> 💡 **Common Mistake:** **Two indices, not one** ➔ `front` drifts right, so a single `length` can't locate the rear; array queues need `front`+`rear` with `rear - front == length`.

### 🔹 LinearQueue — the wasted-space flaw
> [!code]- `LinearQueue(Queue[T])`
> ```python
> class LinearQueue(Queue[T]):
>     def __init__(self, max_capacity):
>         Queue.__init__(self); self.front = 0; self.rear = 0
>         self.array = ArrayR(max(1, max_capacity))
>     def append(self, item):
>         if self.is_full(): raise Exception("Queue is full")
>         self.array[self.rear] = item; self.length += 1; self.rear += 1   # rear → right
>     def serve(self):
>         if self.is_empty(): raise Exception("Queue is empty")
>         self.length -= 1; item = self.array[self.front]; self.front += 1  # front → right
>         return item
>     def is_full(self):
>         return self.rear == len(self.array)        # rear ran off the end — the flaw
> ```
> 💡 **Common Mistake:** **`is_full` is `rear == len(array)`** ➔ three ranked fixes: wrap modulo → CircularQueue ($O(1)$) | linked LinkQueue (unbounded) | shift-to-front ($O(n)$, worst).

### 🔹 CircularQueue — the ring
> [!code]- `CircularQueue(Queue[T])`
> ```python
> class CircularQueue(Queue[T]):
>     def is_full(self): return len(self) == len(self.array)   # length, not position
>     def append(self, item):
>         if self.is_full(): raise Exception("Queue is full")
>         self.array[self.rear] = item; self.length += 1
>         self.rear = (self.rear + 1) % len(self.array)        # wrap
>     def serve(self):
>         if self.is_empty(): raise Exception("Queue is empty")
>         self.length -= 1; item = self.array[self.front]
>         self.front = (self.front + 1) % len(self.array)      # wrap
>         return item
> ```
> 💡 **Common Mistake:** **Iterate from `front` with `% len`** ➔ live elements may straddle the array end (indices 4,5,0,1); iterating raw from 0 visits garbage out of order.

### 🔹 LinkQueue — two pointers
> [!code]- `LinkQueue(Queue[T])`
> ```python
> class LinkQueue(Queue[T]):
>     def __init__(self): Queue.__init__(self); self.front = None; self.rear = None
>     def is_empty(self): return self.front is None
>     def append(self, item):                       # enqueue at rear
>         new = Node(item)
>         if self.is_empty(): self.front = new      # first element: front AND rear
>         else: self.rear.link = new                # link old rear to new
>         self.rear = new; self.length += 1
>     def serve(self):                              # dequeue from front
>         if self.is_empty(): raise ValueError("Queue is empty")
>         item = self.front.item; self.front = self.front.link; self.length -= 1
>         if self.is_empty(): self.rear = None      # removed the last -> reset rear
>         return item
> ```
> 💡 **Common Mistake:** **Empty-boundary transitions** ➔ append-to-empty must set `front` too; serve-the-last must reset `rear = None`, preserving `front is None ⇔ rear is None`.

## ⚖️ Core Decision Matrix
| Variant / Strategy | Trigger Condition | Advantage (Pro) | Disadvantage (Con) / Complexity Bound | Cache / Memory Impact |
| :--- | :--- | :--- | :--- | :--- |
| **LinearQueue** | Pedagogical only | simple $O(1)$ ops | **leaks** served cells, false-full | contiguous |
| **CircularQueue** | Bounded, perf-critical | $O(1)$, full array usable | fixed capacity | contiguous, cache-friendly |
| **LinkQueue** | Variable / unbounded | $O(1)$, never full | $+1$ pointer/node | scattered, poor locality |

> [!NOTE] **When It Flips:** circular = linear's $O(1)$ **without** the space leak (used in network rings, audio buffers, OS run-queues); choose **linked** only when size is genuinely unbounded — doubly-link for an $O(1)$ deque, Michael–Scott CAS for lock-free concurrency.

## 📊 Exam Execution Trace

### Manual Execution Trace
`CircularQueue(cap 4)`: `append A,B,C; serve; append D,E`

| Step / State | Trigger Op | `array` (cap 4) | `front` | `rear` | `len` | Return Payload |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `init` | `[_,_,_,_]` | `0` | `0` | `0` | $-$ |
| 1 | `append A` | `[A,_,_,_]` | `0` | `1` | `1` | $-$ |
| 2 | `append B` | `[A,B,_,_]` | `0` | `2` | `2` | $-$ |
| 3 | `append C` | `[A,B,C,_]` | `0` | `3` | `3` | $-$ |
| 4 | `serve` | `[A,B,C,_]` | `1` | `3` | `2` | `A` |
| 5 | `append D` | `[A,B,C,D]` | `1` | `0` ↩ | `3` | $-$ |
| 6 | `append E` | `[E,B,C,D]` | `1` | `1` ↩ | `4` | $-$ |

`rear` **wraps** $3\to0\to1$; queue is full (`len == 4`) with live order `B,C,D,E`.

### Applied Exercise
**Problem:** Show why `rear == front` cannot detect fullness in a ring.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{empty:} \quad & \text{front} = \text{rear} \\
\text{after } n \text{ appends} + n \text{ serves:} \quad & \text{front} = \text{rear} \;(\text{wrapped}) \\
\therefore\; & \text{position alone ambiguous} \Rightarrow \text{track } \texttt{length} \text{ or sacrifice one slot}
\end{aligned}
$$
**Final Extracted Output:** fullness requires a `length` counter (or the sacrifice-a-slot trick), not a position test.

## 🧠 Active Recall
> [!FAQ]- Why does an array-backed queue need two indices while a stack needs one, and what problem does that create?
> - **Hint:** Connect "both ends move" to the wasted-space flaw.
> > [!SUCCESS]- Answer
> > - **Short answer:** `serve` advances `front`, `append` advances `rear` ➔ **both ends move**, so one `length` can't locate the rear.
> > - **Why:** **Rightward drift** ➔ `front` abandons left cells ⟹ false-full; the **CircularQueue** wrap reclaims them.

> [!FAQ]- In a circular queue `rear == front` could mean full *or* empty — give two disambiguations and a context for each.
> - **Hint:** Resolve the ring's position ambiguity.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Count-based** (`len == capacity`/`0`) or **sacrifice-a-slot** (full = `(rear+1)%n == front`).
> > - **Why:** **Concurrency cost** ➔ sacrifice-a-slot avoids a shared counter ⟹ preferred in lock-free ring buffers where atomic length updates are expensive.

> [!FAQ]- What does LinkQueue's `rear` pointer buy, and what invariant must `append`/`serve` preserve?
> - **Hint:** Tail-append cost + pointer synchronisation.
> > [!SUCCESS]- Answer
> > - **Short answer:** `rear` makes **tail-append $O(1)$** (vs $O(n)$ traversal).
> > - **Why:** **`front is None ⇔ rear is None`** ➔ append-to-empty sets both; serve-the-last resets `rear = None` so it can't dangle.

> [!FAQ]- Three problem domains where a queue (not a stack) is correct, and why?
> - **Hint:** Map FIFO to arrival-order processing.
> > [!SUCCESS]- Answer
> > - **Short answer:** **BFS/shortest paths**, **scheduling/buffering**, **producer–consumer**.
> > - **Why:** **"Oldest first"** ➔ FIFO guarantees arrival-order exploration, fair service, and a bounded buffer decoupling fast producer from slow consumer.
