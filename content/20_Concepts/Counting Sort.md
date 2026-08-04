---
unit: FIT2004
domain: A
week: 2
source: [lecture]
parent: "[[Sorting Problem]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity]
aliases: [Count Sort, Bucket Count Sort]
---
# [[Counting Sort]]

**Context:** [[FIT2004_MOC]] · the first **non-comparison** sort — tally keys in an index-addressed array instead of comparing them · the stable subroutine [[Radix Sort]] is built from · contrast the $\Omega(N\log N)$ comparison floor in [[Sorting Problem]]

> [!abstract] Quick Revision
> - **🎯 Objective:** use each key as an **array index** into a frequency table ➔ sort in $\Theta(N+M)$ with **zero comparisons**, beating the comparison lower bound.
> - **📦 Core Components:** **max scan** $\Theta(N)$ | **count array** size $M{+}1$ | **tally** $\Theta(N)$ via $O(1)$ indexing | **rebuild** $\Theta(N+M)$.
> - **⚡ Key Constraint:** $M$ is the **key range**, not the item count ➔ one huge value inflates $M$ and both time and space; the sort is only a win when $M \ll N$.

## 📝 How It Works
### 1. Why It Escapes the Comparison Bound
- **No comparisons** ➔ the key *is* the address — `count[key] += 1` never asks "$a<b$?" ⟹ the $\Omega(N\log N)$ floor for [[Sorting Problem|comparison sorts]] simply does not apply.
- **Precondition** ➔ keys must be **non-negative integers in a bounded range** $[0, M]$ that index an array in $O(1)$; arbitrary orderable objects do not qualify.

### 2. The Four Phases
- **Phase 1 — find max** ➔ one linear scan gives $M=\max(\text{input})$ ⟹ $\Theta(N)$; you cannot allocate before you know the range.
- **Phase 2 — allocate count** ➔ zero-filled array of length $M{+}1$, position $v$ holds $\text{freq}(v)$ ⟹ $\Theta(M)$.
- **Phase 3 — tally** ➔ for each item, `count[item] += 1` ⟹ $\Theta(N)$, **because** array access is $O(1)$; that $O(1)$ is the whole trick.
- **Phase 4 — rebuild** ➔ walk `count` left→right emitting value $v$ exactly $\text{count}[v]$ times ⟹ $\Theta(N+M)$ — $M$ cells visited, $N$ items written.

### 3. Stability Is Not Free
- **Naive version is UNSTABLE** ➔ storing only a frequency **discards item identity**; the emitted items are freshly manufactured copies of the key, so the payload attached to equal keys is lost/reordered.
- **Fix A — chained buckets** ➔ store the *items* in a list per slot (the [[Hash Table|separate-chaining]] shape) and append in input order ⟹ stable.
- **Space of Fix A is $\Theta(M+N)$, NOT $\Theta(M\cdot N)$** ➔ the buckets partition the input, so **all buckets together hold exactly $N$ items** — the $M$ slots and the $N$ payloads add, never multiply.
- **Fix B — position (prefix-sum) array** ➔ turn counts into starting offsets, then place items in a single input-order pass ⟹ stable with a flat $\Theta(M+N)$ array, no lists ➔ §4.

### 4. Stable Counting Sort via a Position Array
- **Build `count`** ➔ `count[key] += 1` over the input, as before.
- **Build `position`** ➔ `position[first] = 1`, then $\text{position}[i]=\text{position}[i-1]+\text{count}[i-1]$ ➔ a **prefix sum**: each key learns where its block starts.
- **Construct output** ➔ scan the input **in order**; for each $(key,val)$ write `output[position[key]] = (key,val)` then `position[key] += 1` ⟹ earlier-arriving equal keys land in earlier slots ⟹ **stable**.
- **Cost unchanged** ➔ still $\Theta(N+M)$ time, $\Theta(N+M)$ space — stability costs an extra array, not an extra factor.

## ⚙️ Core Implementation
### 🔹 Basic counting sort (unstable, keys only)
> [!code]- `counting_sort` — raw index manipulation, no library calls
> ```python
> def counting_sort(my_list):
>     if len(my_list) == 0:
>         return my_list
>     # Phase 1: find the maximum -- O(N)
>     maximum = my_list[0]
>     for i in range(1, len(my_list)):
>         if my_list[i] > maximum:
>             maximum = my_list[i]
>     # Phase 2: allocate the count array -- O(M)
>     count = [0] * (maximum + 1)
>     # Phase 3: tally -- O(N), O(1) per item because the key IS the index
>     for i in range(len(my_list)):
>         count[my_list[i]] += 1
>     # Phase 4: rebuild in place -- O(N + M)
>     write = 0
>     for value in range(len(count)):
>         for _ in range(count[value]):
>             my_list[write] = value
>             write += 1
>     return my_list
> ```
> 💡 **Common Mistake:** **Phase 4 looks like a nested loop but is not $\Theta(NM)$** ➔ the inner loop runs $\text{count}[v]$ times and $\sum_v \text{count}[v]=N$, so the two loops together cost $\Theta(N+M)$.

### 🔹 Stable counting sort (position array, key–value pairs)
> [!code]- `stable_counting_sort` — prefix-sum offsets, $1$-indexed as in the lecture
> ```python
> def stable_counting_sort(pairs, max_key):
>     # pairs = [(key, val), ...]; keys in 1..max_key
>     count = [0] * (max_key + 1)
>     for i in range(len(pairs)):
>         count[pairs[i][0]] += 1
>     # prefix sum -> starting slot of each key's block
>     position = [0] * (max_key + 1)
>     position[1] = 1
>     for k in range(2, max_key + 1):
>         position[k] = position[k - 1] + count[k - 1]
>     # place in INPUT order -> equal keys keep relative order
>     output = [None] * (len(pairs) + 1)          # slot 0 unused
>     for i in range(len(pairs)):
>         key = pairs[i][0]
>         output[position[key]] = pairs[i]
>         position[key] += 1
>     return output[1:]
> ```
> 💡 **Common Mistake:** **Scanning the input backwards, or forgetting `position[key] += 1`** ➔ either overwrites the block's first slot repeatedly or reverses equal keys — and an unstable subsort silently destroys [[Radix Sort]].

## ⚖️ Core Decision Matrix
| Variant | Trigger condition | Pro | Con / complexity bound | Memory impact |
| :--- | :--- | :--- | :--- | :--- |
| **Frequency only** | keys carry no payload | simplest; rebuild is two loops | **unstable** — identity discarded | $\Theta(M)$ auxiliary |
| **Chained buckets** | payloads present, lists acceptable | stable; conceptually easy | pointer chasing; per-node overhead | $\Theta(M+N)$ auxiliary |
| **Position prefix-sum** | payloads present, [[Radix Sort]] subroutine | stable, flat arrays, cache-friendly | two extra passes, $1$-index bookkeeping | $\Theta(M+N)$ auxiliary |
| [[Merge Sort]] (comparison) | $M$ unbounded or keys not integers | works on any orderable type | $\Theta(N\log N)\cdot O(k)$ | $\Theta(N)$ |

> [!NOTE] **When It Flips:** counting sort wins while $M \ll N\log N$. Sorting $10^6$ lowercase letters ($M{=}26$) is $\Theta(N)$; sorting $7$ numbers where one is $981$ costs $\Theta(N{+}981)$ — worse than [[Merge Sort]]. Once $M$ dominates, either switch to a comparison sort or decompose the key into digits ➔ [[Radix Sort]].

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
Stable counting sort on `(3,a) (1,p) (3,c) (7,f) (5,g) (3,b) (7,d) (8,w)`, keys $1..8$.
Counts: $c_1{=}1,\;c_3{=}3,\;c_5{=}1,\;c_7{=}2,\;c_8{=}1$ ⟹ prefix positions $p=[\,1{:}1,\;2{:}2,\;3{:}2,\;4{:}5,\;5{:}5,\;6{:}6,\;7{:}6,\;8{:}8\,]$.

| Step | Item read | Slot written $=p[\text{key}]$ | $p[\text{key}]$ after | Output so far |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | `[_ _ _ _ _ _ _ _]` |
| 1 | $(3,a)$ | 2 | $2\to3$ | `[_ a _ _ _ _ _ _]` |
| 2 | $(1,p)$ | 1 | $1\to2$ | `[p a _ _ _ _ _ _]` |
| 3 | $(3,c)$ | 3 | $3\to4$ | `[p a c _ _ _ _ _]` |
| 4 | $(7,f)$ | 6 | $6\to7$ | `[p a c _ _ f _ _]` |
| 5 | $(5,g)$ | 5 | $5\to6$ | `[p a c _ g f _ _]` |
| 6 | $(3,b)$ | 4 | $4\to5$ | `[p a c b g f _ _]` |
| 7 | $(7,d)$ | 7 | $7\to8$ | `[p a c b g f d _]` |
| 8 | $(8,w)$ | 8 | $8\to9$ | `[p a c b g f d w]` |

**Final:** $(1,p)(3,a)(3,c)(3,b)(5,g)(7,f)(7,d)(8,w)$ — the key-$3$ payloads keep their input order $a,c,b$ ⟹ **stable**.

### Applied Exercise
**Problem:** Derive total time and auxiliary space, then decide whether counting sort beats [[Merge Sort]] on $N=7$ with input $200,151,291,981,369,421,671$.
$$
\begin{aligned}
T(N,M) &= \underbrace{\Theta(N)}_{\text{max}}+\underbrace{\Theta(M)}_{\text{alloc}}+\underbrace{\Theta(N)}_{\text{tally}}+\underbrace{\Theta(N+M)}_{\text{rebuild}} = \Theta(N+M) \\
S_{\text{aux}} &= \Theta(M) \quad\text{(frequency only)}\qquad \Theta(M+N)\ \text{(stable)} \\
M &= 981,\; N=7 \;\Rightarrow\; \Theta(N+M)=\Theta(988) \;\gg\; N\log_2 N \approx 20
\end{aligned}
$$
**Final Extracted Output:** $\Theta(N{+}M)$ time, $\Theta(M)$ / $\Theta(M{+}N)$ auxiliary; here $M\gg N$ so counting sort **loses badly** — the fix is to sort digit-by-digit with $M=10$ ➔ [[Radix Sort]].

## ⚠️ Common Mistakes
- 💡 **Quoting $\Theta(N)$ unconditionally** ➔ the bound is $\Theta(N+M)$; $M$ may only be dropped after you **state** that the key range is capped (alphabet $M{=}26$, digits $M{=}10$).
- 💡 **Claiming bucket space is $\Theta(N\cdot M)$** ➔ lecturer-flagged as the *very common misconception*: buckets partition the input, so the total payload is $N$ ⟹ $\Theta(M+N)$.
- 💡 **Assuming counting sort is stable by default** ➔ it is not; stability must be engineered (buckets or prefix-sum positions), and [[Radix Sort]] silently breaks without it.

## 🧠 Active Recall
> [!FAQ]- Counting sort runs in $\Theta(N+M)$ — does this contradict the $\Omega(N\log N)$ sorting lower bound?
> - **Hint:** Check what the lower bound is a bound *on*.
> > [!SUCCESS]- Answer
> > - **Short answer:** No — $\Omega(N\log N)$ bounds **comparison-based** sorts only, and counting sort performs no comparisons.
> > - **Why:** **Key-as-address** ➔ `count[key] += 1` extracts order from the key's *value* via $O(1)$ indexing, so the decision-tree argument that produces $\Omega(N\log N)$ never applies.

> [!FAQ]- Why does making counting sort stable cost $\Theta(M+N)$ space rather than $\Theta(M\cdot N)$?
> - **Hint:** Count the items across all buckets, not per bucket.
> > [!SUCCESS]- Answer
> > - **Short answer:** The buckets **partition** the $N$ items — $\sum_v \text{count}[v]=N$ — so slots and payloads add.
> > - **Why:** **Additive, not multiplicative** ➔ $M$ empty slots plus $N$ stored items gives $\Theta(M+N)$; $\Theta(M\cdot N)$ would require every bucket to hold all $N$ items.

> [!FAQ]- Your keys are $32$-bit integers. Justify, with the bound, why counting sort is the wrong choice and what replaces it.
> - **Hint:** Put a number on $M$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $M=2^{32}$ ⟹ $\Theta(N+2^{32})$ time **and** space — unusable for any realistic $N$.
> > - **Why:** **Decompose the key** ➔ [[Radix Sort]] treats the integer as $K$ digits in base $M'$, paying $\Theta(K(N+M'))$ with $M'$ small, which is $\Theta(N)$ for fixed-width keys.
