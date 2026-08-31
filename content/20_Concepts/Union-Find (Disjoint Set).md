---
unit: FIT2004
week: 6
source: [lecture, applied]
domain: A
parent: "[[Set (ADT)]]"
tags: [CS/DataStructures, CS/Algorithms]
aliases: [Disjoint Set, Disjoint-Set Forest, Union Find, DSU]
---
# [[Union-Find (Disjoint Set)]]

**Context:** [[FIT2004_MOC]] · maintains a partition of $V$ elements under merging, answering **"are these two in the same set?"** in near-constant time — the cycle test that makes [[Kruskal's Greedy Algorithm|Kruskal]] fast
**Parent Framework:** [[Set (ADT)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** two operations only ➔ `find(u)` returns $u$'s **representative**, `union(u,v)` merges the two sets; same representative $\equiv$ same set.
> - **📦 Core Components:** one `parent` array ➔ **positive $=$ parent index**, **negative $=$ root, magnitude $=$ size (or rank)** | union-by-size/rank ➔ height $\le\log_2 V$ | path compression ➔ re-parents the whole `find` path to the root.
> - **⚡ Key Constraint:** a negative entry is meaningful **only at a root** — reading a non-root's magnitude as a size is the single highest-frequency hand-trace error.

## 📝 How It Works
### 1. The Two Operations
- **Represent each set as a [[Tree]]** ➔ the set's identity is its **root**; the whole structure is a [[Forest]], one tree per set.
- **`find(u)`** ➔ walk `parent` upward until the entry is negative; that index **is** the representative. Cost $=$ height.
- **`union(u,v)`** ➔ `find` both; **equal roots ⟹ refuse** (already merged), otherwise point one root at the other.
- **Why it fits [[Kruskal's Greedy Algorithm|Kruskal]]** ➔ edge $\langle u,v,w\rangle$ closes a cycle **iff** $u,v$ already share a root, so the cycle test *is* `find(u) == find(v)`, and accepting the edge *is* the `union`.

### 2. The Array Encoding
- **One array, two meanings** ➔ `parent[i] >= 0` ⟹ index of $i$'s parent; `parent[i] < 0` ⟹ $i$ is a root and $\lvert\text{parent}[i]\rvert$ is its **size** (or its **rank/height**, depending on the heuristic chosen).
- **Initialisation** ➔ every entry $-1$: $V$ singleton trees of size $1$, height $0$.
- **No pointers, no objects** ➔ $\Theta(V)$ space total, cache-friendly, and the state fits on one exam line.
- **Root bookkeeping is the whole update** ➔ a union writes exactly **two** cells: the losing root's parent, and the winning root's negative counter.

### 3. Heuristic 1 — Union by Size *(prep P3)*
- **Rule** ➔ the tree with **fewer elements** is appended beneath the root of the larger; on a tie the unit's convention makes the **first argument's** root the new root.
- **New counter** ➔ $\text{size}'(r)=\text{size}(r)+\text{size}(s)$.
- **Guarantee** ➔ $\text{size}(r)\ge 2^{\text{height}(r)}$ ⟹ $\text{height}(r)\le\log_2 V$ (proof in Applied Exercise) ⟹ every `find` and `union` is $O(\log V)$.
- **Why it works** ➔ a node's depth only increases when its whole tree is the smaller side, which at least **doubles** the set it belongs to; a node can be doubled at most $\log_2 V$ times.

### 4. Heuristic 2 — Union by Rank, and Path Compression *(applied P11)*
- **Union by rank/height** ➔ store the **height** instead of the size and append the **shorter** tree; the height grows only when the two heights are equal. Targets the quantity that `find` actually pays for, so it keeps trees at least as shallow as union-by-size — often shallower.
- **Path compression** ➔ after a `find`, re-point **every node on the walked path** directly at the root. Costs nothing extra asymptotically (the path is already traversed) and permanently flattens it.
- **It fires even on a refused union** ➔ `union(8,3)` with $8,3$ already in the same set performs no merge, but the two `find` calls still compress both paths — a rejected edge in [[Kruskal's Greedy Algorithm|Kruskal]] still speeds up the rest of the run.
- **Rank is then a bound, not a height** ➔ compression shortens paths without updating ranks, so the stored rank becomes an upper bound on the true height. This is why the pair is `rank + compression`, never `size + compression` bookkeeping.
- **Result** ➔ amortised cost per operation is **almost $O(1)$**; the combination is what turns [[Kruskal's Greedy Algorithm|Kruskal]]'s cycle testing into a non-bottleneck.

> [!NOTE] 🔭 **Beyond the lecture** *(not in the slides)*: the exact amortised bound for union-by-rank $+$ path compression is $O(\alpha(V))$, $\alpha$ the inverse Ackermann function, $<5$ for any $V$ writable in this universe. FIT2004 asks only for "almost constant"; the full disjoint-set analysis is FIT3155 material.

## ⚙️ Core Implementation
### 🔹 Parent array, union by size
> [!code]- Code
> ```python
> class UnionFind:
>     def __init__(self, n):
>         self.parent = [-1] * n         # negative at a root == set size
>
>     def find(self, u):                 # O(height)
>         while self.parent[u] >= 0:
>             u = self.parent[u]
>         return u                       # first negative entry == the root
>
>     def union(self, u, v):             # returns False if already merged
>         ru, rv = self.find(u), self.find(v)
>         if ru == rv:
>             return False               # same set -> Kruskal rejects this edge
>         if -self.parent[ru] < -self.parent[rv]:   # compare SIZES, not indices
>             ru, rv = rv, ru            # ru is now the larger root
>         self.parent[ru] += self.parent[rv]        # sizes add (both negative)
>         self.parent[rv] = ru                      # smaller hangs off larger
>         return True
> ```
> 💡 **Common Mistake:** **`if ru < rv`** ➔ compares **indices**, not sizes, so the shape degenerates to a chain and `find` becomes $O(V)$. The comparison is always on $\lvert\text{parent}[\cdot]\rvert$.

### 🔹 Path compression
> [!code]- Code
> ```python
>     def find(self, u):                 # two passes: locate, then flatten
>         root = u
>         while self.parent[root] >= 0:
>             root = self.parent[root]
>         while self.parent[u] >= 0:     # re-point every node on the path
>             self.parent[u], u = root, self.parent[u]
>         return root
> ```
> 💡 **Common Mistake:** **Overwriting `parent[u]` before reading it** ➔ the walk loses its next step. Capture the old parent in the same statement, or the loop stalls on `root`.

## ⚖️ Complexity
$V$ elements, at most $V-1$ successful unions.

| Variant | `find` | `union` | All $V-1$ unions | Extra state |
| :--- | :--- | :--- | :--- | :--- |
| Naive parent array | $O(V)$ | $O(V)$ | $O(V^{2})$ | none — degenerates to a chain |
| Lecture's set list $+$ map array | $O(1)$ | $O(V)$ *(copy a set, rewrite the map)* | $O(V^{2})$ | $\Theta(V)$ lists $+$ $\Theta(V)$ map |
| Same, **smaller into larger** | $O(1)$ | $O(V)$ worst, $O(\log V)$ **amortised** | $O(V\log V)$ | as above |
| **Union by size or rank** | $O(\log V)$ | $O(\log V)$ | $O(V\log V)$ | $\Theta(V)$ array only |
| Union by rank $+$ **path compression** | almost $O(1)$ amortised | almost $O(1)$ amortised | almost $O(V)$ | $\Theta(V)$ array only |

- **Worst case is a *sequence* bound** ➔ a single compressed `find` can still cost $\Theta(\log V)$; only the **amortised** figure is near-constant ➔ [[FIT2004 Unit Cheatsheet]] §1️⃣ *amortised is a guarantee, not a probability*.
- **Space is always $\Theta(V)$ auxiliary** ➔ one integer array, no recursion in the iterative form.
- **At most $V-1$ unions ever succeed** ➔ each successful union reduces the component count by one, from $V$ to $1$; every further call is a refused $O(\text{find})$ query.

## 📊 Exam Execution Trace & Applied Exercises
Prep P3 — $10$ elements, all `parent[i] = -1`, **union by size**, first argument wins ties.

### Manual Execution Trace
| Op | Roots found *(size)* | Action | `parent[0..9]` |
| :--- | :--- | :--- | :--- |
| **init** | — | $10$ singletons | `-1 -1 -1 -1 -1 -1 -1 -1 -1 -1` |
| `union(1,5)` | $1(1),\,5(1)$ tie | $5$ under $1$ | `-1 -2 -1 -1 -1  1 -1 -1 -1 -1` |
| `union(2,7)` | $2(1),\,7(1)$ tie | $7$ under $2$ | `-1 -2 -2 -1 -1  1 -1  2 -1 -1` |
| `union(4,8)` | $4(1),\,8(1)$ tie | $8$ under $4$ | `-1 -2 -2 -1 -2  1 -1  2  4 -1` |
| `union(5,8)` | $1(2),\,4(2)$ tie | $4$ under $1$ | `-1 -4 -2 -1  1  1 -1  2  4 -1` |
| `union(6,7)` | $6(1),\,2(2)$ | $6$ under $2$ | `-1 -4 -3 -1  1  1  2  2  4 -1` |
| `union(6,0)` | $2(3),\,0(1)$ | $0$ under $2$ | ` 2 -4 -4 -1  1  1  2  2  4 -1` |
| `union(2,3)` | $2(4),\,3(1)$ | $3$ under $2$ | ` 2 -4 -5  2  1  1  2  2  4 -1` |
| `union(4,0)` | $1(4),\,2(5)$ | $1$ under $2$ | ` 2  2 -9  2  1  1  2  2  4 -1` |
| `union(8,3)` | $2,\,2$ **same** | **refused** | *(unchanged)* |
| `union(9,0)` | $9(1),\,2(9)$ | $9$ under $2$ | ` 2  2 -10 2  1  1  2  2  4  2` |

**Final Extracted Output:** one tree rooted at $2$ (size $10$): children $\{0,1,3,6,7,9\}$, $1\to\{4,5\}$, $4\to\{8\}$ ⟹ **height $3$**. Under union-by-**rank** $+$ path compression the same sequence finishes at **height $2$** — the shallower shape is the point of the exercise.

- **Read the trap** ➔ `union(5,8)` merges the trees of the **roots** of $5$ and $8$, not the elements themselves; the tie is broken on the first argument's root ($1$), not on the smaller index.

### Applied Exercise — the union-by-size height bound *(P8)*
**Problem:** prove $\text{size}(r)\ge 2^{\text{height}(r)}$ for every root $r$ built by union-by-size, then bound one union and all unions.
$$
\begin{aligned}
\textbf{Base: } & \text{a singleton has } \text{size}=1,\ \text{height}=0,\ 1\ge 2^{0}. \\
\textbf{IH: } & \text{after } k \text{ unions the claim holds for every root; merge } s \text{ under } r \text{ with } \text{size}(r)\ge \text{size}(s). \\
\textbf{Case } h(r)>h(s):\ & h'(r)=h(r),\ \text{size}'(r)\ge\text{size}(r)\ge 2^{h(r)}=2^{h'(r)}. \\
\textbf{Case } h(r)\le h(s):\ & h'(r)=h(s)+1,\ \text{size}'(r)=\text{size}(r)+\text{size}(s)\ge 2\,\text{size}(s)\ge 2\cdot 2^{h(s)}=2^{h'(r)}. \\
\textbf{Hence: } & \log_2\text{size}(r)\ge \text{height}(r),\ \text{and } \text{size}(r)\le V \Rightarrow \text{height}(r)\le\log_2 V.
\end{aligned}
$$
**Final Extracted Output:** a union costs $O(h(r)+h(s))=O(\log V)$; at most $V-1$ unions ever succeed (each drops the component count by one) ⟹ **all** unions cost $O(V\log V)$.

## ⚠️ Common Mistakes
- 💡 **Reading a size off a non-root** ➔ only negative entries carry sizes. Always `find` first, compare the **roots'** counters, then write.
- 💡 **Unioning the arguments instead of their roots** ➔ `parent[v] = u` corrupts the forest; it must be `parent[root_v] = root_u`.
- 💡 **Claiming path compression alone gives near-constant time** ➔ the near-constant bound needs **both** heuristics; compression on top of an unbalanced union still permits deep trees before the first `find` reaches them.

## 🧠 Active Recall
> [!FAQ]- Why does union-by-size guarantee $O(\log V)$ per operation, and where exactly does the factor of two come from?
> - **Hint:** whose depth increases.
> > [!SUCCESS]- Answer
> > - **Short answer:** a node's depth grows only when its tree is the **smaller** side, and that at least doubles the set containing it.
> > - **Why:** **The invariant $\text{size}(r)\ge 2^{\text{height}(r)}$** ➔ proved by induction on the number of unions, with the height only rising in the case $h(r)\le h(s)$, where the size at least doubles. **Inverting it** ➔ $\text{height}\le\log_2\text{size}\le\log_2 V$, and `find` costs exactly the height. **Doubling is bounded** ➔ a set can double at most $\log_2 V$ times before it is all of $V$.

> [!FAQ]- [[Kruskal's Greedy Algorithm|Kruskal]] rejects an edge whose endpoints are already connected. Is that call wasted?
> - **Hint:** two `find`s still happened.
> > [!SUCCESS]- Answer
> > - **Short answer:** no — with path compression the two `find` calls flatten both paths even though no merge occurs.
> > - **Why:** **Compression is a side effect of `find`, not of `union`** ➔ every node on both walked paths is re-pointed at its root. **The work was already paid for** ➔ the path had to be traversed to answer the query at all, so flattening is free. **Later edges get cheaper** ➔ the applied sheet's `union(8,3)` is exactly this case, and it is what leaves the final forest shallow and wide.

> [!FAQ]- You must choose between storing size and storing rank in the negative cells. What decides it?
> - **Hint:** which quantity `find` charges you for.
> > [!SUCCESS]- Answer
> > - **Short answer:** rank, because `find` pays the **height**, and rank is the quantity that directly bounds it.
> > - **Why:** **Size is a proxy** ➔ it bounds the height only through $\text{size}\ge2^{\text{height}}$, so it can attach a shallow-but-small tree beneath a deep-but-large one and add a level unnecessarily. **Rank targets the cost directly** ➔ appending the shorter tree raises the height **only** when the two ranks are equal. **Size wins on one axis** ➔ it is the quantity you need anyway if the application asks for component **sizes**; then keep sizes and accept the extra level.
