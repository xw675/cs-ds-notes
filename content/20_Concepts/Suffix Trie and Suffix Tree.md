---
unit: FIT2004
week: 9
source: [lecture, applied]
domain: A
parent: "[[Trie]]"
tags: [CS/DataStructures, CS/Algorithms]
aliases: [Suffix Trie, Suffix Tree, Compressed Suffix Trie]
---
# [[Suffix Trie and Suffix Tree]]

**Context:** [[FIT2004_MOC]] · a [[Trie]] of the $n+1$ suffixes of **one** string instead of $N$ words — every **substring** becomes a root path · **PT-03**'s drawing-and-counting subject
**Parent Framework:** [[Trie]]

> [!abstract] Quick Revision
> - **🎯 Objective:** insert every suffix of `S$` ➔ **substring $=$ prefix of a suffix**, so substring queries are trie walks; compress every one-child chain into one `[start,end]` edge ➔ $\Theta(n)$ nodes.
> - **📦 Core Components:** [[Trie]] of suffixes ➔ $\Theta(n^{2})$ worst space | suffix tree ➔ $n+1$ leaves, every internal node branches, $\le2n+1$ nodes, $\Theta(n)$ space **only with index labels** | both $O(n^{2})$ to build naively.
> - **⚡ Key Constraint:** PT-03 counts die on three omissions — **the root is a node**, **`$` alone is a suffix**, **every suffix ends in `$`**. The lecture's own `apple` slides drop the lone `$`.

## 📝 How It Works
### 1. The Suffix Trie — Same Trie, Different Input
- **Input** ➔ `S$` of length $n+1$ has $n+1$ suffixes: `apple$, pple$, ple$, le$, e$, $`. Insert each exactly as a word ➔ [[Trie]] §2.
- **Substring $=$ prefix of a suffix** *(equivalently suffix of a prefix)* ➔ every substring is spelled by **exactly one** root path, and two equal substrings end at the **same** node.
- **Substring search** ➔ walk the pattern from the root, no `$` at the end ⟹ $O(m)$.
- **Occurrences of a substring** ➔ number of **leaves** below its node (each leaf is one suffix that starts with it).
- **Longest repeated substring** ➔ the **deepest node with $\ge2$ children** (two suffixes share it as a prefix). `banana` ➔ `ana`.
- **Build** ➔ $n+1$ suffixes, longest $n+1$ characters ⟹ $O(n^{2})$ time; space $O(n^{2})$ nodes worst case.

### 2. PT-03 Counting Formulas
$n=\lvert S\rvert$ (no `$`) · $D=$ number of **distinct non-empty substrings** of $S$ · inner node $=$ node with children (root included) · height $=$ edges root ➔ deepest leaf.

| Quantity | Suffix trie | Suffix tree | Why |
| :--- | :--- | :--- | :--- |
| Leaves | $n+1$ | $n+1$ | one `$`-leaf per suffix; compression never merges leaves |
| Inner nodes | $D+1$ | $1$ (all distinct) … $n$ (all same) | trie: root $+$ one node per distinct substring of $S$ · tree: root $+$ branching nodes |
| Total nodes | $D+n+2$ | $n+2$ … $2n+1$ | add the two rows above |
| Height | $n+1$ | $1$ … $n$ | trie: the whole of `S$` · tree: count compressed edges |
| $\sum$ edge lengths | $D+n+1$ | $D+n+1$ | compression keeps every character, only drops nodes |

- **Distinct substrings of $S$** ➔ trie: nodes $-$ root $-$ the $n+1$ `$` nodes $=D$ · tree: $\sum(\text{end}-\text{start}+1)-(n+1)$. Counting *all* non-root nodes gives the distinct substrings of `S$` instead — `ABCD$` gives $15$, of which $10$ belong to `ABCD`.
- **The extremes flip between the two structures** ➔ the suffix **trie** is smallest on `aaaa` ($D=n$ ⟹ $2n+2$ nodes) and largest on all-distinct characters ($D=\tfrac{n(n+1)}{2}$ ⟹ $\Theta(n^{2})$); the suffix **tree** is smallest on all-distinct ($n+2$ nodes, height $1$) and largest on `aaaa` ($2n+1$ nodes, height $n$).

### 3. The Suffix Tree — Compress, Then Store Indices
- **Compression** ➔ merge every chain of one-child nodes into one edge ⟹ every internal node except possibly the root has $\ge2$ children. **Exam method:** draw the suffix trie, then compress.
- **Labels must be `[start,end]` indices** ➔ storing the substring text on edges keeps $O(n^{2})$ space (*"we still store the characters all"*). Edges are contiguous runs of `S$`, so two integers suffice: `apple$` $=$ `[0,5]`, `p` $=$ `[1,1]`, `ple$` $=$ `[2,5]`.
- **Prep notation `(i, l)`** ➔ the prep sheet labels the **child node** with a **1-based start** and a **length** instead of the lecture's 0-based `[start,end]` edge: `(i, l)` $\equiv$ `[i-1, i+l-2]`. `apple$`: `p` `[1,1]` $=$ `(2,1)`, `ple$` `[2,5]` $=$ `(3,4)`. Any occurrence of the text is a valid label; state which convention you use.
- **$O(n)$ nodes** ➔ $n+1$ leaves; a tree whose internal nodes all branch has $\le$ (leaves $-1$) internal nodes ⟹ $\le2n+1$ total. The lecture's version: $O(n+\tfrac{n}{2}+\tfrac{n}{4}+\dots+1)=O(n)$ ➔ [[Geometric Series]].
- **Build time is still $O(n^{2})$** ➔ every suffix is still inserted character by character; compression saves **space**, not time.
- **Compression stays $O(n)$ only if done carefully** ➔ re-slicing strings or copying labels per node reintroduces $O(n^{2})$ — the lecture's "bad practice" warning.

> [!example]- `apple$` suffix tree — leaf $=$ suffix start index
> ```mermaid
> graph TD
>   R((root)) -->|"apple$ [0,5]"| L0((0))
>   R -->|"p [1,1]"| P((p))
>   P -->|"le$ [3,5]"| L2((2))
>   P -->|"ple$ [2,5]"| L1((1))
>   R -->|"le$ [3,5]"| L3((3))
>   R -->|"e$ [4,5]"| L4((4))
>   R -->|"$ [5,5]"| L5((5))
> ```

### 4. Applied Problems — Think in the Trie, Answer in the Tree
- **P3 distinct substrings in $O(n)$** ➔ trie answer counts non-`$` nodes, $O(n^{2})$; each tree node absorbs exactly as many trie nodes as its edge has characters ⟹ one $O(n)$ traversal summing `end-start+1` ➔ §2.
- **P4 longest common substring in $O(n+m)$** ➔ build the tree of `s1#s2$` (`#` stops a match straddling both strings). `#` occurs once ⟹ it never repeats ⟹ it appears only on **leaf** edges. Leaf containing `#` ⟹ a suffix starting in $s_1$, else $s_2$. Post-order: set flags $f_1,f_2$ from the leaves upward; answer $=$ deepest (by string depth) internal node with **both** flags. Same shape as longest repeated substring, restricted to cross-string repeats.
- **P6 fewest substrings of $S$ concatenating to $T$, $O(n+m)$** ➔ **greedy**: walk $T$ down the tree of $S$ until it cannot extend, cut, restart at the root from the failing character. `ABCCBA`, `CBAABCA` ⟹ `CBA` $+$ `ABC` $+$ `A` $=3$. **Why greedy is safe** ➔ a suffix of a substring is a substring, so greedy's $i$-th cut is never left of any solution's $i$-th cut (stays ahead ➔ [[Greedy Algorithm]]). **The count is unique, the pieces are not** ➔ `ABBA`, `ABA`: `AB`$+$`A` or `A`$+$`BA`.
- **P8 shortest unique substring in $O(n)$** ➔ unique $\iff$ exactly one leaf below. Shallowest **candidate** $=$ node with a leaf child whose edge is more than just `$`; answer length $=$ its string depth $+1$ (an internal node is repeated by definition). `cababac` ⟹ `ca`, `ac`.
- **P9 shortest absent string in $O(n)$** ➔ shallowest point missing some alphabet character as a continuation ⟹ its string $+$ that character. Positions **inside** an edge have one continuation only. `AAABABBBA` over {`A,B`} ⟹ `BAA`.
- **P13 suffix-trie size is $\Omega(n^{2})$** `[D]` ➔ a De Bruijn sequence has $\binom{n+1}{2}-O(n\log n)$ distinct substrings, one node each ⟹ the $O(n^{2})$ bound is tight.

## ⚖️ Complexity
| Structure | Build (naive) | Space | Substring search | Distinct substrings |
| :--- | :--- | :--- | :--- | :--- |
| Suffix trie | $O(n^{2})$ | best $\Theta(n)$ · worst $\Theta(n^{2})$ nodes | $O(m)$ | $O(n^{2})$ node count |
| Suffix tree, text labels | $O(n^{2})$ | $O(n^{2})$ characters | $O(m)$ | — |
| Suffix tree, `[start,end]` labels | $O(n^{2})$ | $\Theta(n)$ | $O(m)$ | $O(n)$ edge-length sum |

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — `apple$`, trie built suffix by suffix, then compressed

| Suffix (start) | Already in trie | New trie nodes | Total nodes | Suffix-tree edge(s) |
| :--- | :--- | :--- | :--- | :--- |
| `apple$` (0) | — | $6$ | $7$ | root ➔ `[0,5]` leaf 0 |
| `pple$` (1) | — | $5$ | $12$ | becomes `[1,1]` ➔ `[2,5]` leaf 1 |
| `ple$` (2) | `p` | $3$ | $15$ | `p` now branches ➔ `[3,5]` leaf 2 |
| `le$` (3) | — | $3$ | $18$ | root ➔ `[3,5]` leaf 3 |
| `e$` (4) | — | $2$ | $20$ | root ➔ `[4,5]` leaf 4 |
| `$` (5) | — | $1$ | $\mathbf{21}$ | root ➔ `[5,5]` leaf 5 |

**Final Extracted Output:** trie $21$ nodes, $15$ inner, $6$ leaves, height $6$ · tree $8$ nodes, $2$ inner (root, `p`), $6$ leaves, height $2$. Check: $D=14$ ⟹ $D+n+2=21$ ✓; $\sum$ tree edge lengths $=6+1+4+3+3+2+1=20=D+n+1$ ✓.

### Applied Exercise — PT-03 counts for `banana`
**Problem:** give nodes, inner nodes, leaves and height of the suffix trie and suffix tree of `banana`, and its distinct substrings.
$$
\begin{aligned}
n &= 6,\quad D = 3+3+3+3+2+1 = 15 \quad (\text{distinct substrings of lengths } 1..6)\\
\text{trie: nodes} &= D+n+2 = 23,\quad \text{inner} = D+1 = 16,\quad \text{leaves} = n+1 = 7,\quad \text{height} = n+1 = 7\\
\text{tree edges} &: \texttt{banana\$},\ \texttt{\$},\ \texttt{a}\to\{\texttt{\$},\ \texttt{na}\to\{\texttt{\$},\texttt{na\$}\}\},\ \texttt{na}\to\{\texttt{\$},\texttt{na\$}\}\\
\text{tree: nodes} &= 11,\quad \text{inner} = 4\ (\text{root},\ \texttt{a},\ \texttt{ana},\ \texttt{na}),\quad \text{leaves} = 7,\quad \text{height} = 3
\end{aligned}
$$
**Final Extracted Output:** trie $23/16/7/7$, tree $11/4/7/3$; $\sum$ edge lengths $=22$ ⟹ $22-7=15$ distinct substrings ✓; longest repeated substring $=$ deepest inner node $=$ `ana`.

## ⚠️ Common Mistakes
- 💡 **Dropping the lone `$` suffix** ➔ one leaf short, every count off by one — the lecture's `apple` slide shows $5$ leaves where there are $6$.
- 💡 **Routing a suffix into another suffix's path** ➔ creates a cycle — the lecture's first `apple` attempt. Every node has one parent; sharing happens only along a common prefix **from the root** (`ple$` reuses the root's `p` child, nothing deeper).
- 💡 **"A suffix tree is $O(n)$ space" with text labels** ➔ only `[start,end]` indices make it $\Theta(n)$.
- 💡 **"A suffix tree builds in $O(n)$"** ➔ naive insertion is $O(n^{2})$; linear construction needs Ukkonen, which this unit does not teach.
- 💡 **Mixing the two label conventions** ➔ `(4,4)` is start $4$, length $4$ (prep, 1-based); `[4,4]` is one character at 0-based index $4$ (lecture). Same digits, different substrings.
- 💡 **Counting all non-root nodes as distinct substrings** ➔ that includes the $n+1$ `$`-terminated ones; subtract them.

## 🧠 Active Recall
> [!FAQ]- Why does compression reduce a suffix trie to $O(n)$ nodes, and why does it NOT reduce build time?
> > [!SUCCESS]- Answer
> > - **Short answer:** after compression every internal node branches, so internal nodes $<$ leaves $=n+1$ ⟹ $\le2n+1$ nodes; but each suffix is still inserted character by character ⟹ $O(n^{2})$ time.
> > - **Why:** **Counting** ➔ a tree in which every internal node has $\ge2$ children has at most leaves $-1$ internal nodes. **Space needs indices too** ➔ $O(n)$ nodes with $O(n)$-length text labels is still $O(n^{2})$; `[start,end]` makes each edge $O(1)$. **Time** ➔ insertion walks $n+1$ suffixes of length up to $n+1$; only Ukkonen avoids it.

> [!FAQ]- PT-03: which string minimises the suffix trie, and which minimises the suffix tree?
> - **Hint:** $D$ drives the trie; repetition drives the tree's branching.
> > [!SUCCESS]- Answer
> > - **Short answer:** the trie is smallest for **one repeated character** (`aaaa`, $2n+2$ nodes); the tree is smallest for **all-distinct characters** (`abcd`, $n+2$ nodes, height $1$).
> > - **Why:** **Trie** ➔ nodes $=D+n+2$, and $D$ is minimal ($=n$) when every length has one distinct substring, maximal ($\binom{n+1}{2}$) when all are distinct. **Tree** ➔ leaves are fixed at $n+1$, so only **branching** nodes vary; all-distinct suffixes share no prefix (root only), while `aaaa` branches at every `a^k` ⟹ $n$ inner nodes, $2n+1$ total.

> [!FAQ]- In P4 (`s1#s2$`), why can no internal node's edge contain `#`, and how does that tell you which string a leaf came from?
> > [!SUCCESS]- Answer
> > - **Short answer:** an internal node is a substring occurring $\ge2$ times; `#` occurs once, so any string containing it occurs once ⟹ `#` only appears on leaf edges. A leaf edge containing `#` is a suffix that starts in $s_1$.
> > - **Why:** **Branching $\Rightarrow$ repetition** ➔ two children $=$ two different suffixes sharing the path. **Leaf test in $O(1)$** ➔ the leaf's suffix starts in $s_1$ $\iff$ its start index $<\lvert s_1\rvert$, equivalently its edge `[start,end]` spans the position of `#`. **Flags propagate up** ➔ a node is a substring of $s_1$ (resp. $s_2$) iff some leaf below is; one post-order pass sets both flags, then take the deepest node with both.

> [!FAQ]- Prep P2/P3: draw the suffix trees of `ABAABA$` and `GATTACA$` with `(i, l)` labels, then give nodes / inner / leaves / height.
> > [!SUCCESS]- Answer
> > - **`ABAABA$`** ➔ root ➔ `A (1,1)` ➔ { `BA (2,2)` ➔ { `ABA$ (4,4)`, `$ (7,1)` }, `$ (7,1)`, `ABA$ (4,4)` } · `BA (2,2)` ➔ { `$ (7,1)`, `ABA$ (4,4)` } · `$ (7,1)` ⟹ $11$ nodes, $4$ inner, $7$ leaves, height $3$. Trie for comparison: $D=14$ ⟹ $22/15/7/7$.
> > - **`GATTACA$`** ➔ root ➔ `$ (8,1)` · `A (2,1)` ➔ { `$ (8,1)`, `CA$ (6,3)`, `TTACA$ (3,6)` } · `CA$ (6,3)` · `GATTACA$ (1,8)` · `T (3,1)` ➔ { `ACA$ (5,4)`, `TACA$ (4,5)` } ⟹ $11$ nodes, $3$ inner, $8$ leaves, height $2$. Trie: $D=25$ ⟹ $34/26/8/8$.
> > - **Why:** **Branch exactly where two suffixes diverge** ➔ `ABA$` and `A$` part after `A`; `ATTACA$`, `ACA$`, `A$` part after `A`. **Check** ➔ leaves $=n+1$, and $\sum l=D+n+1$ ($21$ and $33$).

> [!tip]- 🔭 Beyond the lecture *(not examinable this semester)*
> - **Suffix array** ➔ the suffix start IDs in sorted order: $O(n)$ space, substring search by [[Binary Search]] in $O(m\log n)$, longest repeated substring by comparing **adjacent** suffixes. Naive build $O(n^{2}\log n)$ (merge sort) or $O(n^{2})$ (radix); prefix doubling with $O(1)$ rank comparison reaches $O(n\log^{2}n)$. The 2026 S2 topic page marks the suffix-array lecture **not examinable**.
