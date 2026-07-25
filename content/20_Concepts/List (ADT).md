---
unit: FIT1008
domain: A
week: [3, 4, 5]
parent: "[[Abstract Data Type (ADT)]]"
tags: [CS/DataStructures, SWE/OOP, CS/Abstraction, CS/Complexity]
---
# [[List (ADT)]]

**Context:** [[FIT1008_MOC]] · the most general linear [[Abstract Data Type (ADT)]] · backbone clustering **ArrayList / LinkList / LinkListIterator** · stacks & queues are it with access restricted to one end

> [!abstract] Quick Revision
> - **🎯 Objective:** ordered, any-position collection ➔ the general linear ADT; stacks/queues are one-end-restricted cases.
> - **📦 Core Components:** **Contract** ➔ `__getitem__`/`insert`/`delete_at_index` | **ArrayList** ➔ $O(1)$ access, $O(n)$ shift | **LinkList** ➔ $O(1)$ relink, $O(n)$ walk | **LinkListIterator** ➔ $O(1)$ mutate-in-traversal.
> - **⚡ Key Constraint:** array vs linked are **mirror images** ➔ bottleneck = whichever of *random access* vs *structural edit* the workload hits.

## 📝 Core
### 1. List Contract (Ordered, Positional)
- **Positional access** ➔ elements have positions ➔ touch **any** index via `__getitem__`/`insert`/`delete_at_index`.
- **Ordered ≠ sorted** ➔ order is *position*, not *value* (`[20,5,30,1]` valid); no `is_full` (array resizes).
- **Operation reuse** ➔ `remove = index + delete_at_index` | `append = insert(len, …)`.

### 2. ArrayList (Array-Backed)
- **Storage substrate** ➔ fixed [[Array (Data Structure)]] + `length`; head at 0, data `0..length-1`.
- **Access vs edit** ➔ random access $O(1)$ | order-preserving insert/delete **shift** $O(n)$ | grows via [[Dynamic Array Resizing]].
- **`remove` is $\Theta(N)$ either way** ➔ head ⟹ cheap `index` + full shift; tail ⟹ full scan + no shift.

### 3. LinkList (Linked)
- **Storage substrate** ➔ [[Node]] chain + `head`; reach an index by **walking links** ($O(n)$).
- **Relink is $O(1)$** ➔ the $O(n)$ culprit is the walk `__get_node_at_index`, not the relink.
- **Insert order** ➔ **new→rest then prev→new** or the tail leaks; tail pointer / doubly-link fix $O(n)$ cases.

### 4. LinkListIterator (Walk & Mutate)
- **Cursor** ➔ `current` pointer, one item per `__next__` (the [[Iterator]] for a LinkList).
- **Modifying version** ➔ holds list + `previous` ➔ delete/insert *during* traversal in $O(1)$.
- **vs fail-fast** ➔ *provides* controlled mutation instead of *forbidding* it (ArrayList same edit = $O(n)$).

## ⚙️ Core Implementation
### 🔹 ArrayList — $O(1)$ access, $O(n)$ shift
> [!code]- `ArrayList(List[T])`
> ```python
> class ArrayList(List[T]):
>     def __getitem__(self, i):                    # O(1)
>         if not 0 <= i < len(self): raise IndexError
>         return self.array[i]
>     def delete_at_index(self, i):                # O(n): shift left to close the gap
>         item = self[i]; self.length -= 1
>         for k in range(i, self.length):
>             self.array[k] = self.array[k + 1]
>         return item
>     def index(self, item):                       # Linear Search: O(n*comp)
>         for k in range(len(self)):
>             if item == self.array[k]: return k
>         raise ValueError
> ```
> 💡 **Common Mistake:** **`append` is amortised $O(1)$** ([[Dynamic Array Resizing]]); a *gap buffer* (array + movable gap) is the hybrid giving localised-edit $O(1)$ while keeping $O(1)$ random access.

### 🔹 LinkList — $O(1)$ relink, $O(n)$ walk
> [!code]- `LinkList(List[T])`
> ```python
> class LinkList(List[T]):
>     def __init__(self): List.__init__(self); self.head = None
>     def __get_node_at_index(self, index):          # the linear walk — O(index)
>         if 0 <= index < len(self):
>             current = self.head
>             for _ in range(index): current = current.link
>             return current
>         raise ValueError("Index out of bounds")
>     def insert(self, index, item):
>         new = Node(item)
>         if index == 0:                              # head insert — special case, O(1)
>             new.link = self.head; self.head = new
>         else:
>             prev = self.__get_node_at_index(index - 1)
>             new.link = prev.link                    # 1. new -> rest
>             prev.link = new                         # 2. prev -> new (order matters!)
>         self.length += 1
> ```
> 💡 **Common Mistake:** **Reverse the two assignments = tail leak** ➔ `prev.link` is overwritten before `X` captures the rest; a **sentinel head** removes the `index == 0` special-case.

### 🔹 LinkListIterator — mutate while traversing
> [!code]- `LinkListIterator` (modifying) + `__iter__`
> ```python
> class LinkListIterator(Generic[T]):            # modifying version
>     def __init__(self, a_list):
>         self.list = a_list; self.previous = None; self.current = a_list.head
>     def __next__(self):
>         if self.current is not None:
>             item = self.current.item
>             self.previous = self.current        # remember predecessor
>             self.current = self.current.link
>             return item
>         raise StopIteration
>     def delete(self):                           # remove node at current — O(1)
>         item = self.current.item
>         self.current = self.current.link
>         if self.previous is None: self.list.head = self.current   # deleting head
>         else: self.previous.link = self.current                   # unlink current
>         self.list.length -= 1
>         return item
>
> def __iter__(self): return LinkListIterator(self)   # pass the LIST, so it can mutate head/length
> ```
> 💡 **Common Mistake:** **Modifying iterator needs `previous` + the list** ➔ to rewire the predecessor and reset `head`/`length` when the first node goes; a read-only iterator needs only `current`.

## ⚖️ Core Decision Matrix
| Operation | **ArrayList** | **LinkList** | Cause |
| :--- | :--- | :--- | :--- |
| `__getitem__` / `__setitem__` | $O(1)$ | $O(n)$ | direct index vs walk links |
| insert / delete at **head** | $O(n)$ (shift) | $O(1)$ (relink) | move all vs repoint head |
| insert / delete at index $i$ | $O(n)$ | $O(i)$ walk + $O(1)$ relink | shift vs locate-then-relink |
| `append` | $O(1)$ amortised | $O(1)$ tail-ptr / $O(n)$ walk | resize vs reach end |
| `index` (search) | $O(n\cdot\text{comp})$ | $O(n\cdot\text{comp})$ | linear scan either way |
| memory / locality | contiguous, cache-friendly | $+1$ pointer/node, scattered | — |

> [!NOTE] **When It Flips:** array = $O(1)$ access / $O(n)$ edit; linked = the exact inverse ➔ choose **array** for index-heavy/read-heavy, **linked** for frequent insert/delete at known positions. In-place delete = $O(1)$ (LinkListIterator relink) vs $O(n)$ (ArrayList shift).

## 📊 Exam Execution Trace

### Manual Execution Trace
`LinkList.insert(2, X)` on `head→A→B→C`:

| Step / State | Trigger Op | Pointer Action | List Payload |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | start | want index 2 | `head→A→B→C` |
| 1 | locate prev | `prev = node@1` | `prev = B` |
| 2 | `new.link = prev.link` | `X→C` (B still →C) | `head→A→B→C`, `X→C` |
| 3 | `prev.link = new` | `B→X` | `head→A→B→X→C` |

Reverse steps 2–3 ⟹ `B→X` first overwrites `prev.link` (→C) **before** `X` captures it ⟹ `C` onward leaked.

### Applied Exercise
**Problem:** Prove `ArrayList.remove(item)` is $\Theta(N)$ regardless of the item's position.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{item at head:} \quad & \text{index} = O(1),\; \text{delete shift} = O(N) \Rightarrow \Theta(N)\\
\text{item at tail:} \quad & \text{index} = O(N),\; \text{delete shift} = O(1) \Rightarrow \Theta(N)\\
\therefore\; & \text{best case of one component} = \text{worst case of the other}
\end{aligned}
$$
**Final Extracted Output:** `remove = index + delete_at_index` ⟹ one component is always $\Theta(N)$, so the sum is $\Theta(N)$.

## 🧠 Active Recall
> [!FAQ]- Array-backed and linked-backed lists implement the same ADT — give random-access and head-insertion costs and the design rule.
> - **Hint:** Recognise the mirror-image cost profile.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Array** $O(1)$ access / $O(n)$ head insert; **Linked** $O(n)$ access / $O(1)$ head insert.
> > - **Why:** **Opposite optimisation** ➔ array for index-heavy/read-heavy, linked for frequent insert/delete at known positions.

> [!FAQ]- Why is `remove(item)` $\Theta(N)$ for an ArrayList regardless of position?
> - **Hint:** Decompose into `index` + `delete_at_index`.
> > [!SUCCESS]- Answer
> > - **Short answer:** One of the two components is always $\Theta(N)$ ➔ sum $\Theta(N)$.
> > - **Why:** **Complementary costs** ➔ head item = cheap `index` + full shift; end item = full scan + $O(1)$ delete.

> [!FAQ]- In LinkList `insert` at index > 0, why must the assignments be new→rest then prev→new?
> - **Hint:** Preserve the reference to the tail.
> > [!SUCCESS]- Answer
> > - **Short answer:** Point `new.link = prev.link` **while `prev.link` still references the rest**, then `prev.link = new`.
> > - **Why:** **Order dependence** ➔ reversing overwrites `prev.link` first, leaking everything after the insertion point.

> [!FAQ]- Mid-traversal delete is $O(1)$ via LinkListIterator but $O(n)$ in an ArrayList — and how does that differ from a fail-fast iterator?
> - **Hint:** Relink vs shift, and forbid vs provide mutation.
> > [!SUCCESS]- Answer
> > - **Short answer:** Linked delete = relink `previous.link` ($O(1)$); array delete = shift later elements ($O(n)$).
> > - **Why:** **Forbid vs engineer** ➔ a fail-fast iterator *raises* on modification; a modifying iterator *supports* controlled $O(1)$ mutation.
