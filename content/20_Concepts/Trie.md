---
unit: FIT2004
week: 9
source: [lecture, applied]
domain: A
parent: "[[Tree]]"
tags: [CS/DataStructures, CS/Algorithms]
aliases: [Prefix Trie, Retrieval Tree, reTRIEval Tree, Binary Trie]
---
# [[Trie]]

**Context:** [[FIT2004_MOC]] · string retrieval in $O(M)$ independent of $N$ — a $k$-ary [[Tree]] branching on **characters**; the base structure that [[Suffix Trie and Suffix Tree|suffix tries and trees]] specialise
**Parent Framework:** [[Tree]]

> [!abstract] Quick Revision
> - **🎯 Objective:** one child slot per alphabet character $+$ one for the terminal `$` ➔ insert/search walk one edge per character ⟹ $O(M)$, and a `$`-first in-order DFS lists every word **sorted** in $O(T)$.
> - **📦 Core Components:** `links = [None]*27` ➔ $O(1)$ child lookup | payload `data` ➔ counts, frequencies, scores | iterative $O(1)$ aux vs recursive $O(M)$ aux.
> - **⚡ Key Constraint:** **without `$` a prefix is indistinguishable from a word** — insert `apple`, and `app` "exists". Every inserted word and every search key ends in `$`, and `$` sits at `links[0]`.

## 📝 How It Works
### 1. Structure — $k+1$ Children and the Terminal `$`
- **BST vs trie** ➔ a [[Binary Search Tree (BST)|BST]] has $2$ children (left/right); a trie has $k$ — the charset size: `a..z` $=26$ · `a..z`$+$`A..Z` $=52$ · DNA $=4$ (`A,C,G,T`).
- **$+1$ for `$`** ➔ `apple$` means `apple` is stored; `app` reaching a node with no `$` child is only a **prefix**. Searching `tar` in {`taco, taro, tarot, coco, chobo`} walks `t-a-r` successfully and fails on `$` ⟹ not found.
- **`$` at `links[0]`** ➔ `$` sorts before every letter, so a `$`-first in-order walk emits `app` before `apple` — consistent with sorting. Map `a` $\to1$, `z` $\to26$.
- **Fixed-size array, not a list/dict** ➔ index $=$ character ⟹ child lookup is $O(k)=O(1)$ for a constant charset. Cost: the slots are mostly `None` ⟹ wasted space.
- **Payload** ➔ whatever the query needs (frequency, top-$k$ words, prefix count) — keep it **small**, since there is one per node and a trie has many nodes.
- **Edge vs node labels** ➔ the character properly lives on the **edge** (consistent with graph representation); labels drawn in nodes are also accepted in the exam.

### 2. Operations — Every Traversal Starts at the Root
- **Insert** ➔ for each character of `word$`: child exists ⟹ move to it · missing ⟹ create it, then move.
- **Search** ➔ for each character of `key$`: child exists ⟹ move · missing ⟹ return `False` / raise. Worst $O(M)$, best $O(1)$ (first character absent).
- **Full traversal** ➔ in-order DFS over `links[0..26]` visits every node once ⟹ the stored words in **alphabetical order** in $O(\#\text{nodes})=O(T)$ ($T=$ total characters incl. `$`); with $A$ words of length $\le B$ that is $O(AB)$.
- **Iterative vs recursive** ➔ same $O(M)$ time; iterative is $O(1)$ aux, recursive $O(M)$ aux (stack depth $=$ key length). **Recursion is preferred** when information must flow back **up** (subtree counts, best leaf below, flags) — iteration needs a second loop or an explicit stack.
- **Delete** ➔ not required at this level.

### 3. Properties — "Use the Properties to Explain Complexity"
$N$ words, longest $M$ letters, $T$ total characters including every `$`.
- **Nodes** ➔ $\le N(M+1)$ ⟹ $O(NM)$; tighter $\le T+1$ ⟹ $O(T)$ (root $+$ one node per character, when no prefixes are shared).
- **Leaves** ➔ $\le N$ — every leaf is a `$` node. **Maximum**, because duplicates end at the same `$` leaf.
- **Height** ➔ exactly $M+1$ edges root-to-deepest-leaf — **the `$` edge counts**.
- **Lecture example** ➔ {`taco, taro, tarot, coco, chobo`}: $T=27$, $21$ nodes (shared `ta`, `tar`, `c`), $5$ leaves, height $6$ (`tarot$`).
- **Prep P1** ➔ {`cat, cathode, canopy, dog, danger, domain`}: $T=37$, $30$ nodes, $24$ inner, $6$ leaves, height $8$ (`cathode$`). The `t` node branches into `$` and `h` — a stored word that is also a prefix keeps its own `$` child.

### 4. Augmented Tries — Applied P1, P2, P5, P7
- **P1 distinct strings in $O(T)$** ➔ insert all with `$`, count `$` nodes; equal strings end at the **same** node.
- **P2 count words with prefix $p$ in $O(m)$** ➔ a counter in every node, `+1` on every node moved to **or** created during insert ⟹ `node.data` $=$ number of words through it; query $=$ walk $p$, return the count. Build cost unchanged. *Rejected:* walk $p$ then count leaves below ⟹ up to $O(T)$.
- **P7 most powerful prefix in $O(T)$** ➔ add $w_i\times\text{depth}$ to each node on insert; answer $=$ max-score node. `baby`$10$, `bank`$20$, `bit`$40$ ⟹ $\text{score}(\texttt{b})=70$, $\text{score}(\texttt{ba})=60$, $\text{score}(\texttt{bit})=\mathbf{120}$.
- **P5 predecessor in $O(m+n)$** *(output-sensitive)* ➔ walk the query, remembering the **deepest node with a child smaller than the next character**; on success return the query; on failure jump back there, take its **greatest smaller child**, then follow the greatest child to a leaf. No such node ⟹ `null` ➔ trace below.

### 5. A Trie as an Accelerator `[D]` — Applied P10–P12
- **P10 max $x\oplus a_i$ in $O(w)$** ➔ store the $w$-bit integers MSB-first in a **binary trie**; at each level prefer the child with the **opposite** bit to $x$ (a $1$ in a high position beats every lower bit), else take the only child.
- **P11 max subarray XOR in $O(nw)$** ➔ $F(L,R)=a_L\oplus\dots\oplus a_R=P_R\oplus P_{L-1}$ with prefix XOR $P$ ($x\oplus x=0$, associativity); for each $R$ query the trie of $P_0..P_{R-1}$ with $P_R$, then insert $P_R$ ⟹ same move as [[Maximum Subarray Sum]]'s prefix sums.
- **P12 word break $O(n^{2}m)\to O(n^{2}+nm)$** ➔ the [[Dynamic Programming]] loop *"every $w\in L$ that is a prefix of $S[i..n]$"* is one trie walk of $S[i..n]$; each node with a `$` child is a word $p$ ⟹ candidate $\text{DP}[i+\lvert p\rvert]$. Build $O(nm)$ $+$ $n$ walks of $O(n)$.

## ⚙️ Core Implementation
### 🔹 Lecture `Node` / `Trie` $+$ insert, search, prefix count, sorted output
> [!code]- Code
> ```python
> class Node:
>     def __init__(self, data=None):
>         self.data = data              # payload: count, frequency, ...
>         self.links = [None] * 27      # [0] = '$', [1..26] = 'a'..'z'
>
> class Trie:
>     def __init__(self):
>         self.root = Node()
>
>     @staticmethod
>     def _index(c):
>         return 0 if c == '$' else ord(c) - 97 + 1
>
>     def insert(self, word):                       # iterative: O(M) time, O(1) aux
>         node = self.root
>         for c in word + '$':
>             i = self._index(c)
>             if node.links[i] is None:             # missing -> create
>                 node.links[i] = Node()
>             node = node.links[i]                  # exists -> follow
>         node.data = word                          # payload at the $ leaf
>
>     def search(self, word):                       # O(M) worst, O(1) best
>         node = self.root
>         for c in word + '$':                      # the '$' step separates "tar" from "tarot"
>             node = node.links[self._index(c)]
>             if node is None:
>                 return False
>         return True
>
>     def insert_count(self, word):                 # recursive: O(M) time, O(M) aux
>         self._insert_count(self.root, word + '$', 0)
>
>     def _insert_count(self, node, key, k):
>         node.data = (node.data or 0) + 1          # words passing through this node
>         if k == len(key):
>             return
>         i = self._index(key[k])
>         if node.links[i] is None:
>             node.links[i] = Node()
>         self._insert_count(node.links[i], key, k + 1)
>
>     def count_prefix(self, p):                    # applied P2: O(m)
>         node = self.root
>         for c in p:
>             node = node.links[self._index(c)]
>             if node is None:
>                 return 0
>         return node.data
>
>     def sorted_words(self):                       # in-order DFS: O(T)
>         out = []
>         self._collect(self.root, [], out)
>         return out
>
>     def _collect(self, node, path, out):
>         for i, child in enumerate(node.links):    # '$' first => "app" before "apple"
>             if child is None:
>                 continue
>             if i == 0:
>                 out.append(''.join(path))
>             else:
>                 path.append(chr(i - 1 + 97))
>                 self._collect(child, path, out)
>                 path.pop()
> ```
> **Expected output:** after inserting `taco, taro, tarot, coco, chobo, app, apple` ➔ `search("tar")` is `False`, `sorted_words()` is `['app', 'apple', 'chobo', 'coco', 'taco', 'taro', 'tarot']`; with `insert_count` over `baby, bank, bit` ➔ `count_prefix("b") == 3`, `count_prefix("ba") == 2`.
> 💡 **Common Mistake:** **Building the path with `prefix + c` strings** ➔ each concatenation copies $O(M)$ characters, turning an $O(T)$ traversal into $O(TM)$ — the lecture's "needless inefficiency". Append/pop one shared list.

## ⚖️ Complexity
| Operation | Time | Aux space | Note |
| :--- | :--- | :--- | :--- |
| Insert one word | $O(M)$ | $O(1)$ iterative · $O(M)$ recursive | $\le M+1$ new nodes ⟹ $O(M)$ **space added** |
| Search | best $O(1)$ · worst $O(M)$ | $O(1)$ iterative | $M=$ **query** length, $N$ never appears |
| Build $N$ words | $O(T)=O(NM)$ | $O(T)$ nodes | each node holds a $k$-slot array |
| Sorted listing | $O(T)$ | $O(M)$ stack $+$ output | in-order, `$` first |
| Prefix count (P2) | $O(m)$ | $O(1)$ | counter maintained during insert |
| Predecessor (P5) | $O(m+n)$ | $O(1)$ | $n=$ length of the answer |

## ⚖️ Core Decision Matrix
$N$ strings, length $M$; one string comparison costs $O(M)$.

| Structure | Build | Search | Prefix / ordered queries | Trade-off |
| :--- | :--- | :--- | :--- | :--- |
| Sorted array $+$ [[Binary Search]] | $O(MN\log N)$ merge · $O(MN)$ [[Radix Sort\|radix]] | $O(M\log N)$ | yes, by range | $\log N$ comparisons, each $O(M)$ |
| [[Binary Search Tree (BST)\|BST]] / AVL | $O(MN\log N)$ balanced | $O(M\log N)$ | yes | same $O(M)$-per-comparison tax |
| [[Hash Table]] | $O(MN)$ expected | $O(M)$ expected | **no** — hashing destroys order and prefixes | collisions ⟹ not deterministic; can be faster in practice |
| **Trie** | $O(T)=O(MN)$ | $O(M)$ **deterministic** | **yes** — prefix $=$ a node, in-order $=$ sorted | wasted `None` slots in every node |

> [!NOTE] **When It Flips:** need only exact membership and memory is tight ➔ [[Hash Table]]. The query mentions a **prefix**, an **order** (sorted, predecessor, lexicographic $k$-th), or demands a **worst-case** bound ➔ trie.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — P5 predecessor of `candelabra`
Trie of `canada, canal, candid, candy, cart`. `ancestor` $=$ deepest node with a child $<$ the character being followed.

| Step | Char | Node's children | Child $<$ char? | `ancestor` / `ancestor_child` | `answer` |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | `c` | root: `c` | no | — | `c` |
| 2 | `a` | `c`: `a` | no | — | `ca` |
| 3 | `n` | `ca`: `n`,`r` | no | — | `can` |
| 4 | `d` | `can`: `a`,`d` | **`a` $<$ `d`** | **`can` / `a`** | `cand` |
| 5 | `e` | `cand`: `i`,`y` | no | `can` / `a` | no `e` child ⟹ **break** |
| 6 | back up | pop to `can` | — | — | `can` $\to$ `cana` |
| 7 | greatest path | `cana`: `d`,`l` ⟹ `l`, then `$` | — | — | `canal` |

**Final Extracted Output:** `canal`. `cand` is not stored as an `ancestor` because both its children exceed `e`. Query `ba` on {`aaa, aba, baa`} returns `aba`; query `baa` returns itself.

## ⚠️ Common Mistakes
- 💡 **Forgetting the `$` edge in the height** ➔ height is $M+1$, not $M$.
- 💡 **"Leaves $=N$"** ➔ leaves $\le N$; duplicates share one `$` leaf — exactly the fact P1 exploits.
- 💡 **Quoting search as $O(\log N)$ or $O(M\log N)$** ➔ a trie never compares whole strings; its cost depends on the **query** length only.
- 💡 **Counting a whole subtree per prefix query** ➔ $O(T)$; push the count into the node at insert time (P2).

## 🧠 Active Recall
> [!FAQ]- Why does a trie need `$`, and why put it at `links[0]`?
> > [!SUCCESS]- Answer
> > - **Short answer:** `$` marks **word end** so a stored prefix is not mistaken for a word; slot $0$ makes the in-order traversal emit words in sorted order.
> > - **Why:** **Membership** ➔ after inserting only `apple`, the walk `a-p-p` succeeds, so `app` would be "found"; requiring the `$` step separates the word `app$` from the prefix `app`. **Ordering** ➔ `$` precedes every letter, so `app` is emitted before `apple`, matching `sorted(["apple","app"])`.

> [!FAQ]- A sorted array also supports prefix queries. Why is a trie's search $O(M)$ but binary search $O(M\log N)$?
> > [!SUCCESS]- Answer
> > - **Short answer:** binary search makes $\log N$ whole-string comparisons, each $O(M)$; a trie reads each query character **once**, with an $O(1)$ array jump per character.
> > - **Why:** **Comparison model** ➔ every probe restarts from character $0$ of the key. **Trie** ➔ the path to depth $d$ *is* the shared prefix, so nothing is re-read and $N$ vanishes from the bound. **Price** ➔ $O(T)$ nodes each holding $k+1$ slots ➔ §3.

> [!FAQ]- P2 asks for "number of words with prefix $p$" in $O(m)$ without changing build cost. What goes in the payload, and when is it updated?
> > [!SUCCESS]- Answer
> > - **Short answer:** an integer counter, incremented on **every node visited or created** during insert; the query returns the counter of the node reached by $p$.
> > - **Why:** **Invariant** ➔ `node.data` $=$ number of inserted words whose path passes through `node` $=$ words with that node's prefix. **Cost** ➔ one extra $O(1)$ update per insert step ⟹ build stays $O(T)$, space stays $O(T)$. **The rejected design** ➔ counting `$` leaves under the node is $O(\text{subtree})$, up to $O(T)$.
