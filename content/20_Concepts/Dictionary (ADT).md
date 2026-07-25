---
unit: FIT1008
week: 10
parent: "[[Abstract Data Type (ADT)]]"
tags: [CS/DataStructures, OOP/Python, CS/Abstraction]
---
# [[Dictionary (ADT)]]

**Context:** [[FIT1008_MOC]] · a container keyed by label, unlike [[List (ADT)]] · implemented by a [[Hash Table]] · a [[Set (ADT)]] with values

> [!abstract] Quick Revision
> - **🎯 Objective:** look things up by what they are (a unique key) ➔ not by position — x["Name"].
> - **📦 Core Components:** search / add / update / delete, all **keyed** ➔ hash-backed vs tree-backed.
> - **⚡ Key Constraint:** hash map $O(1)$ expected but **unordered**; tree map $O(\log n)$ but **ordered** (range/successor).

## 📝 Core
### 1. The Dictionary (Keyed Access)
- **Map** ➔ each value **uniquely identified by a key**, not position ➔ Python's `dict` on a [[Hash Table]].
- **Operations** ➔ search, add, update, delete — all **keyed**.
- **Add vs update** ➔ decided purely by **key presence** (keys are **unique**).

### 2. Two Realisations
- **Hash-backed** ➔ [[Hash Table]] ➔ expected $O(1)$ keyed ops, **no key order**.
- **Tree-backed** ➔ balanced [[Binary Tree]] ➔ $O(\log n)$ keyed ops, **sorted key order** (range/successor, ordered iteration).
- **Recurring choice** ➔ "$O(1)$ unordered vs $O(\log n)$ ordered".

## ⚙️ Core Implementation
### 🔹 Keyed operations
> [!code]- `dict` usage
> ```python
> x = {"Name": "Peter", "Age": 5}
> x["Name"]          # SEARCH -> 'Peter'   (KeyError if absent)
> x["Age"] = 6       # UPDATE (key present)
> x["Class"] = "1A"  # ADD    (new key)
> del x["Name"]      # DELETE
> ```
> 💡 **Common Mistake:** **Keys unique + hashable/comparable** ➔ hash map needs hashable, tree map needs comparable; a mutable-as-key whose hash/order changes after insertion is a classic bug.

## ⚖️ Core Decision Matrix
| Operation | Hash map (expected) | Tree map (worst) |
| :--- | :--- | :--- |
| search `x[k]` | $O(1)$ | $O(\log n)$ |
| add / update | $O(1)$ amortised | $O(\log n)$ |
| delete | $O(1)$ | $O(\log n)$ |
| ordered iteration | $O(n\log n)$ (must sort) | $O(n)$ in order |

> [!NOTE] **When It Flips:** the hash map forfeits ordering for speed; the tree map keeps order at a $\log$ factor. Hash-map $O(1)$ is *expected* (good hashing) and *amortised* (rehash on growth) — adversarial keys degrade it to $O(n)$. A dictionary is a [[Set (ADT)]] *with values attached to each key* — same membership machinery.

## 📊 Exam Execution Trace

### Manual Execution Trace
Choosing a backing store:

| Step / State | Requirement | Choose |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | fastest point lookups, order irrelevant | **hash map** ($O(1)$ expected) |
| 2 | range queries / sorted iteration | **tree map** ($O(\log n)$, ordered) |
| 3 | worst-case guarantees | **tree map** ($O(\log n)$ worst vs hash $O(n)$) |

### Applied Exercise
**Problem:** Show `add` vs `update` is decided by key presence.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
x[k] = v:\quad k \notin x &\Rightarrow \textbf{add} \text{ (count}{+}{+}) \\
k \in x &\Rightarrow \textbf{update} \text{ (overwrite value, keys unique)}
\end{aligned}
$$
**Final Extracted Output:** the unique-key invariant means the same syntax branches on membership — no duplicate keys ever coexist.

## 🧠 Active Recall
> [!FAQ]- You need range queries and ordered iteration — hash map or tree map, and what do you sacrifice?
> - **Hint:** Order costs a log factor.
> > [!SUCCESS]- Answer
> > - **Short answer:** A **tree map** (balanced BST): $O(\log n)$ point ops, $O(\log n+k)$ range, $O(n)$ in-order.
> > - **Why:** **Sacrifice $O(1)$** ➔ you give up the hash map's expected $O(1)$ point operations for ordered structure.

> [!FAQ]- Why is `dict`'s $O(1)$ described as *expected* and *amortised*, not worst-case?
> - **Hint:** Two separate qualifiers.
> > [!SUCCESS]- Answer
> > - **Short answer:** *Expected*: good hashing ⟹ $O(1)$ average, but all-colliding adversarial keys ⟹ $O(n)$. *Amortised*: periodic $O(n)$ rehash spread over $n$ inserts ⟹ $O(1)$ each.
> > - **Why:** **No worst-case guarantee** ➔ a single lookup can be $O(n)$; the bound is average + sequence-amortised.

> [!FAQ]- What two requirements must keys satisfy, and how does each backing store use them?
> - **Hint:** Unique + (hashable or comparable).
> > [!SUCCESS]- Answer
> > - **Short answer:** **Unique** (the invariant), and **hashable** (hash map — compute an index) or **comparable** (tree map — order in the BST).
> > - **Why:** **Mutable-key bug** ➔ arises when a key's hash/order changes after insertion.
