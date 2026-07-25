---
unit: FIT1008
domain: A
week: [10, 11]
parent: "[[Dictionary (ADT)]]"
tags: [CS/DataStructures, SWE/OOP, CS/Algorithms, CS/Complexity]
---
# [[Hash Table]]

**Context:** [[FIT1008_MOC]] · the [[Array (Data Structure)]]-backed implementation of a [[Dictionary (ADT)]] · backbone clustering the **whole hashing pipeline** (hash function → collision resolution → probing → load factor)

> [!abstract] Quick Revision
> - **🎯 Objective:** map keys directly to array indices ➔ expected $O(1)$ add/search/delete, beating sorted-list $O(\log n)$, but unordered.
> - **📦 Core Components:** **Hash Function** ➔ uniform spread | **Collision Resolution** ➔ chaining vs open addressing | **Load Factor** $\alpha$ ➔ cost dial + rehash trigger.
> - **⚡ Key Constraint:** expected $\Theta(1+\alpha)$, worst-case $O(n)$ on collisions ➔ hinges on a uniform hash + bounded $\alpha$.

## 📝 Core
### 1. The Hash Table (Expected $O(1)$)
- **Core mechanism** ➔ keys → index via [[Hash Table#2. Hash Function ("what" → "where")|hash]] into a large [[Array (Data Structure)|array]] ➔ $O(1)$ access ⟹ expected $O(1)$ ops.
- **SUHA analysis** ➔ $\alpha=n/m$; uniform hashing ⟹ expected chain length $\alpha$ ⟹ $\Theta(1+\alpha)=\Theta(1)$ while $\alpha=O(1)$.
- **Birthday paradox** ➔ collisions appear by $n\approx\sqrt m$ ⟹ resolution mandatory even at low load.

### 2. Hash Function ("what" → "where")
- **Properties** ➔ **deterministic** + **fast** ($O(\text{key length})$) + **uniform** (short chains/clusters).
- **Design rules** ➔ use *all* the key, weight by *position* (else anagrams collide), Horner's method (mod each step).
- **Prime discipline** ➔ multiplier coprime to $m$ (prime base + prime $m$); avoid zero divisors of $m-1$.

### 3. Collision Resolution
- **Collision** ➔ two keys → one slot ➔ **inevitable** (finite table, huge key space).
- **Two families** ➔ **separate chaining** (a [[List (ADT)|LinkList]] per cell) | **open addressing** (probe in-array).
- **Cost** ➔ chained ops are $\Theta(\text{chain length})$ (duplicate check); a bad hash collapses to one $O(n)$ chain.

### 4. Open Addressing — Probe Sequences
- **Mechanism** ➔ store every key in-array; probe a deterministic sequence to empty (add) or match (search); $\alpha<1$ required.
- **Schemes** ➔ **linear** $(h+i)$ → primary clustering | **quadratic** $(h+i^2)$ → secondary + may miss slots | **double** $(h_1+i\,h_2)$ → cures both.
- **`hash2` rule** ➔ **never return 0** and **coprime to $m$** (else can't visit every slot).

### 5. Linear Probing
- **Mechanism** ➔ home taken ⟹ **walk `+1`** (wrapping); each cell holds `(key, data)`.
- **Invariant** ➔ key with `hash=N` lies between slot `N` and the first empty ([[Invariant]]) ⟹ search stops at first empty.
- **Delete** ➔ naïve blank **severs the run** ⟹ blank + **reinsert trailing cluster** or use **tombstones**; keep $\alpha<1/2$.

### 6. Load Factor — Cost Dial
- **Definition** ➔ $\alpha=n/m$ predicts cost: low ⟹ $O(1)$; high ⟹ toward $O(n)$.
- **Caps** ➔ chaining tolerates $\alpha\le1$ (linear $\Theta(1+\alpha)$); open addressing $\alpha<2/3$ (probes climb steeply as $\alpha\to1$).
- **Rehash** ➔ cross threshold ⟹ double $m$, reinsert all $n$ ($O(n)$, but $O(1)$ amortised).

## ⚙️ Core Implementation
### 🔹 Hash Function — polynomial / Horner
> [!code]- `hash(word, m)` and the `hash2` non-zero step
> ```python
> def hash(word: str, m: int) -> int:        # polynomial rolling hash
>     value, a, b = 0, 31415, 27183          # a, b ideally prime
>     for char in word:
>         value = (ord(char) + a * value) % m
>         a = a * b % (m - 1)                # vary the multiplier per position
>     return value
>
> def hash2(self, key: str) -> int:          # double-hashing step, in 1..PRIME (never 0)
>     PRIME = 7
>     return PRIME - (ord(key[0]) % PRIME)
> ```
> 💡 **Common Mistake:** **Summing chars ignores position** ➔ anagrams collide; a multiplier sharing a factor with $m$ (`*1024 % 128`) keeps only the last char — prime base + prime $m$, coprime.

### 🔹 Separate Chaining — a LinkList per cell
> [!code]- chained `add` / `search`
> ```python
> def add(self, key, value):
>     h = hash(key)
>     if self.table[h] is None:
>         self.table[h] = LinkList()
>     self.table[h].insert(0, (key, value))   # after checking key absent (update vs add)
>
> def search(self, key):
>     chain = self.table[hash(key)]
>     if chain is not None:
>         for k, v in chain:
>             if k == key: return v
>     raise KeyError(key)
> ```
> 💡 **Common Mistake:** **Cost is $\Theta(1+\alpha)$** ➔ expected chain length $\alpha$ ⟹ unsuccessful search $\alpha$, successful $1+\alpha/2$; $O(1)$ only while $\alpha$ is bounded.

### 🔹 Linear Probing — `+1` probe, rehash-on-full, correct delete
> [!code]- `__linear_probe`, `__setitem__`, `__delitem__`
> ```python
> def __linear_probe(self, key: str, is_search: bool) -> int:
>     position = self.hash(key)
>     for _ in range(len(self.table)):
>         if self.table[position] is None:
>             if is_search: raise KeyError(key)   # off the chain -> absent
>             else:         return position       # first empty -> insert here
>         elif self.table[position][0] == key:
>             return position                     # found the key
>         else:
>             position = (position + 1) % len(self.table)   # step + wrap
>     raise KeyError(key)                         # table full -> rehash
>
> def __setitem__(self, key, data):               # ADD / UPDATE
>     try:
>         position = self.__linear_probe(key, False)
>     except KeyError:
>         self.__rehash(); self[key] = data        # full -> grow + retry
>     else:
>         if self.table[position] is None: self.count += 1
>         self.table[position] = (key, data)
>
> def __delitem__(self, key):                      # blank then reinsert the cluster
>     pos = self.__linear_probe(key, False)
>     self.table[pos] = None; self.count -= 1
>     pos = (pos + 1) % len(self.table)
>     while self.table[pos] is not None:
>         item = self.table[pos]; self.table[pos] = None; self.count -= 1
>         self[str(item[0])] = item[1]
>         pos = (pos + 1) % len(self.table)
> ```
> 💡 **Common Mistake:** **Scan the whole table before rehashing** ➔ the add might be an **update**; in practice rehash much earlier, once $\alpha$ passes the threshold.

### 🔹 Quadratic & Double Hashing — breaking clusters
> [!code]- `__quadratic_probe` and `__double_hashing`
> ```python
> def __quadratic_probe(self, key, is_search):    # +i^2 from HOME slot
>     position = self.hash(key); orig = position; step = 1
>     for _ in range(len(self.table)):
>         if self.table[position] is None:
>             return (_ for _ in ()).throw(KeyError(key)) if is_search else position
>         elif self.table[position][0] == key: return position
>         else: position = (orig + step*step) % len(self.table); step += 1
>     raise KeyError(key)
>
> def __double_hashing(self, key, is_search):      # constant key-dependent step
>     position = self.hash(key); step = self.hash2(key)
>     for _ in range(len(self.table)):
>         if self.table[position] is None:
>             if is_search: raise KeyError(key)
>             else: return position
>         elif self.table[position][0] == key: return position
>         else: position = (position + step) % len(self.table)
>     raise KeyError(key)
> ```
> 💡 **Common Mistake:** **Quadratic may never find an empty slot** even when one exists; double hashing's step must be non-zero and coprime to $m$ to visit *every* slot.

## ⚖️ Core Decision Matrix
| Variant / Strategy | Trigger Condition | Advantage (Pro) | Disadvantage (Con) / Complexity Bound | Cache / Memory Impact |
| :--- | :--- | :--- | :--- | :--- |
| **Separate chaining** | $\alpha$ may exceed 1 | trivial delete (unlink) | $\Theta(1+\alpha)$; $O(n)$ if one chain | $+1$ pointer/node, poor |
| **Linear probing** | Low $\alpha$, cache-critical | **excellent** locality | primary clustering; $O(N)$ worst | none, in-array |
| **Quadratic probing** | Avoid primary clustering | cures primary | secondary remains; may miss slots | none |
| **Double hashing** | Near-uniform probing | cures both clusterings | awkward delete; cache-missing jumps | none |

> [!NOTE] **When It Flips:** dictionary backings — unsorted [[List (ADT)]] $O(N)$, [[Sorted List (ADT)]] $O(\log N)$ search/$O(N)$ add, balanced [[Binary Tree]] $O(\log N)$ + **ordered**, **Hash Table** $O(1)^*$ but **unordered**. Use a hash table for big $N$ + no ordering; a BST for range/successor/worst-case guarantees.

## 📊 Exam Execution Trace

### Manual Execution Trace
Linear probing, $m=7$, `hash(k)=k % 7`, insert `10, 17, 24, 3`:

| Step / State | Trigger Op | Home `k%7` | Probe Path      | Final Slot        |
| :----------- | :--------- | :--------- | :-------------- | :---------------- |
| **0 (Init)** | `init`     | $-$        | $-$             | `[_,_,_,_,_,_,_]` |
| 1            | insert 10  | `3`        | slot 3 empty    | **3**             |
| 2            | insert 17  | `3`        | 3 taken → 4     | **4**             |
| 3            | insert 24  | `3`        | 3,4 taken → 5   | **5**             |
| 4            | insert 3   | `3`        | 3,4,5 taken → 6 | **6**             |

A **primary cluster** now spans slots 3–6; any new key hashing to 3–6 must probe to slot 0.

### Applied Exercise
**Problem:** Show rehash amortises to $O(1)$ and derive the chained SUHA search cost.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{rehash work over } n \text{ inserts} &= 1 + 2 + 4 + \dots + n < 2n \Rightarrow \text{total} < 3n \Rightarrow O(1)\text{ amortised}\\
\text{chained search (SUHA)} &: \text{unsuccessful} = \alpha,\quad \text{successful} = 1 + \tfrac{\alpha}{2} = \Theta(1+\alpha)
\end{aligned}
$$
**Final Extracted Output:** per-insert $O(1)$ amortised (geometric doubling); keyed ops $\Theta(1+\alpha) = O(1)$ at bounded load.

## 🧠 Active Recall
> [!FAQ]- Derive the expected search cost of a chained hash table and state the assumption it relies on.
> - **Hint:** Apply SUHA to chain length.
> > [!SUCCESS]- Answer
> > - **Short answer:** Unsuccessful = $\alpha$; successful = $1+\alpha/2$ ➔ both $\Theta(1+\alpha)$.
> > - **Why:** **Bounded load** ➔ $\Theta(1+\alpha)=\Theta(1)$ iff $\alpha=O(1)$, assuming uniform independent hashing.

> [!FAQ]- A hash table is "$O(1)$" yet rehashing is "$O(n)$" — reconcile this.
> - **Hint:** Amortise the geometric rehash.
> > [!SUCCESS]- Answer
> > - **Short answer:** Rehash (double $m$, reinsert $n$) is an occasional $O(n)$ event, geometrically rare.
> > - **Why:** **Doubling argument** ➔ summed and divided over the $n$ inserts, per-insert cost is $O(1)$ amortised (same as [[Dynamic Array Resizing|dynamic arrays]]).

> [!FAQ]- State the linear-probing invariant and use it to explain why naïve deletion is incorrect.
> - **Hint:** Connect the probe-run invariant to deletion.
> > [!SUCCESS]- Answer
> > - **Short answer:** A key with `hash=N` lies between `N` and the first empty slot ➔ search stops at the first empty.
> > - **Why:** **Severed run** ➔ blanking a slot mid-run hides later keys behind an empty ⟹ reported absent; correct delete reinserts the cluster or uses tombstones.

> [!FAQ]- Distinguish primary clustering, secondary clustering, and which scheme cures each.
> - **Hint:** Map probe step to clustering type.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Primary** (linear) = one growing run; **secondary** (quadratic) = same-home keys share a path; **double hashing** cures both.
> > - **Why:** **Key-dependent step** ➔ $h_2(k)$ varies per key, so even same-home keys diverge, approximating uniform probing.

> [!FAQ]- Why does open addressing demand a far stricter load-factor cap than chaining, and can low $\alpha$ still give $O(n)$?
> - **Hint:** Distinguish average load from worst-case distribution.
> > [!SUCCESS]- Answer
> > - **Short answer:** Chaining $\Theta(1+\alpha)$ tolerates $\alpha>1$; open addressing caps $\alpha<1/2$–$2/3$ (probes climb steeply as $\alpha\to1$).
> > - **Why:** **Average ≠ distribution** ➔ a poor/adversarial hash piles keys into one chain/cluster ⟹ $O(n)$ worst-case even at low load.
