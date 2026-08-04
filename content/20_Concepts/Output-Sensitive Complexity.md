---
unit: FIT2004
domain: A
week: 1
source: [lecture]
parent: "[[Algorithmic Complexity]]"
tags:
  - CS/Algorithms
  - CS/Complexity
aliases:
  - output-sensitive
  - range reporting
  - output size W
---
# [[Output-Sensitive Complexity]]

**Context:** [[FIT2004_MOC]] · a bound that names the **output size** alongside the input size — the Week 1 range-reporting example that separates [[Linear Search]] from [[Binary Search]] + scan

> [!abstract] Quick Revision
> - **🎯 Objective:** when an algorithm must **emit** $W$ items, quote $\Theta(f(N)+W)$ ➔ the search term and the reporting term are **separate** and neither absorbs the other.
> - **⚡ Key Constraint:** $W$ is a **free parameter**, not a constant — dropping it is the mark-loss; $O(\log N)$ for a range report is simply **false**.

## 📝 Core
### 1. The problem shape
- **Setup** ➔ sorted array of $N$ integers, bounds $X<Y$; print every element strictly between them. Let $W$ be **how many are printed**.
- **Why $W$ must appear** ➔ printing is work: $W$ outputs cost $\Theta(W)$ regardless of how cleverly they were found.
- **Two free parameters** ➔ $N$ and $W$ can grow independently ($0\le W\le N$), so by the free-parameter rule in [[Algorithmic Complexity]] **both** belong in the bound.

### 2. The two algorithms
- **Algo 1 — linear scan** ➔ walk index $0\to N-1$, test each against $(X,Y)$, print on a hit ➔ $\Theta(N)$ scanning $+\ \Theta(W)$ printing $=\Theta(N+W)=\Theta(N)$ (since $W\le N$).
- **Algo 2 — binary search then scan** ➔ [[Binary Search]] for the **smallest element $>X$** ($\Theta(\log N)$), then scan forward printing until an element $\ge Y$ is reached ($\Theta(W)$) ➔ $\Theta(\log N+W)$.
- **Where the win is** ➔ Algo 2 never touches the $N-W$ out-of-range elements to the left of $X$; Algo 1 touches all of them.

### 3. Optimality and the flip point
- **Lower bound** ➔ any correct algorithm is $\Omega(W)$ (it must emit $W$ items) and $\Omega(\log N)$ (comparison-based location in a sorted array) ⟹ Algo 2 is **optimal**, its $O$ meets the problem's $\Omega$.
- **When it flips** ➔ at $W=\Theta(N)$ (most of the array in range) both are $\Theta(N)$ and the binary search buys nothing; the gap is largest when $W=\Theta(1)$ — $\Theta(\log N)$ vs $\Theta(N)$.
- **Generalises** ➔ the same accounting governs any *reporting* problem (all pairs within distance $d$, all matches of a pattern); asymptotic effort is split into **locate** $+$ **report**.

## ⚠️ Common Mistakes
- 💡 **Quoting Algo 2 as $O(\log N)$** ➔ ignores the print loop; the answer is $\Theta(\log N+W)$ and the missing term is exactly what is being tested.
- 💡 **Absorbing $W$ into $N$ "because $W\le N$"** ➔ legal for Algo 1 (where $\Theta(N+W)=\Theta(N)$), **fatal** for Algo 2 — collapsing $\Theta(\log N+W)$ to $\Theta(N)$ discards the whole point of the algorithm.
- 💡 **Binary-searching for $X$ itself** ➔ $X$ need not be present; search for the **first element greater than $X$** (a boundary/predecessor search), or the scan starts in the wrong place.

## 🧠 Active Recall
> [!FAQ]- Both algorithms print the same $W$ values, yet only one is called optimal. On what grounds?
> - **Hint:** Compare each upper bound against the problem's lower bound, not against each other.
> > [!SUCCESS]- Answer
> > - **Short answer:** The problem is $\Omega(\log N+W)$ — you must locate the boundary and you must emit $W$ items. Algo 2 achieves $O(\log N+W)$, matching it; Algo 1's $\Theta(N)$ does not.
> > - **Why:** **Optimal means $O$ meets $\Omega$** ➔ per [[Big-O Notation]], a $\Theta$ that coincides with the problem's intrinsic lower bound cannot be improved by any algorithm; Algo 1 wastes $\Theta(N-W)$ comparisons on elements it can prove are out of range.

> [!FAQ]- Why is $W$ allowed in an asymptotic bound at all, when a capped parameter like $arr[i]<2^{32}$ is not?
> - **Hint:** What can grow without limit as the instance grows?
> > [!SUCCESS]- Answer
> > - **Short answer:** $W$ is unbounded — it ranges over $0..N$ and grows with the instance — so it is a legitimate free parameter; a **capped** quantity contributes $\Theta(1)$ and is discarded by $\Theta$.
> > - **Why:** **Asymptotics describe growth** ➔ [[Algorithmic Complexity]]'s rule is to list which parameters may grow *before* quoting a bound; $W$ passes that test, $2^{32}$ does not.
