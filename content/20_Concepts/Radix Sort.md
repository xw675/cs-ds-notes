---
unit: FIT2004
domain: A
week: 2
source: [lecture]
parent: "[[Counting Sort]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity]
aliases: [LSD Radix Sort]
---
# [[Radix Sort]]

**Context:** [[FIT2004_MOC]] · the fix for [[Counting Sort]]'s $M$ blow-up — stop treating the key as one huge number, treat it as $K$ narrow **columns** · still non-comparison, so the $\Omega(N\log N)$ floor in [[Sorting Problem]] does not bind

> [!abstract] Quick Revision
> - **🎯 Objective:** run a **stable** [[Counting Sort]] once per digit column, **least-significant first** ➔ $\Theta(KN+KM)$, beating [[Merge Sort]]'s $\Theta(kN\log N)$ for fixed-width keys.
> - **📦 Core Components:** $N$ items $\times$ $K$ columns | base $M$ (digits $10$ · bits $2$ · letters $26$) | stable subsort per column.
> - **⚡ Key Constraint:** the subsort **must be stable** — an unstable column pass destroys all order won by the previous passes, and the output is wrong, not merely unsorted.

## 📝 How It Works
### 1. The Reframing
- **Key as a grid** ➔ lay the $N$ items as rows, their digits as $K$ columns; the rightmost column is **least significant**, the leftmost **most significant**.
- **Why $M$ collapses** ➔ each column holds only base-$M$ symbols, so every subsort sees $M=10$ (decimal), $2$ (binary), $26$ (alphabet) — never the $981$ or $2^{32}$ that ruined plain [[Counting Sort]].
- **$K$ is a length, not a count** ➔ $K=\lceil\log_M(\text{largest key})\rceil$ ⟹ raising the base **shrinks** $K$ but grows $M$; the trade is the design decision the exam asks about.

### 2. Least-Significant-Digit Order + Stability
- **Pass order** ➔ sort on column $K$ (rightmost), then $K{-}1$, … , then column $1$ ⟹ after pass $j$ the list is correctly sorted on the last $j$ digits.
- **Stability carries the earlier work** ➔ when column $j$ ties, a stable subsort preserves the previous pass's order, which is exactly the ordering on the lower-significance digits ⟹ the invariant is maintained.
- **Unstable ⟹ catastrophe** ➔ with $200$ before $291$ from pass 2, an unstable hundreds pass may emit $291$ before $200$; both have hundreds digit $2$, so nothing later repairs it.

### 3. Ragged Keys
- **Unequal lengths break the column grid** ➔ `banhammer` and `kappa` have no common $K$.
- **Pad to a common width** ➔ insert a filler symbol that sorts **below** every real symbol; numbers pad with leading zeros (right-aligned), strings pad with spaces.
- **Alignment decides the order semantics** ➔ right-aligned padding gives numeric order; left-aligned padding gives lexicographic order — choose deliberately, they differ.

## ⚙️ Core Implementation
### 🔹 LSD radix sort over base $M$
> [!code]- `radix_sort` — stable counting subsort per column, raw index manipulation
> ```python
> def radix_sort(my_list, base=10):
>     if len(my_list) == 0:
>         return my_list
>     maximum = my_list[0]
>     for i in range(1, len(my_list)):
>         if my_list[i] > maximum:
>             maximum = my_list[i]
>     exp = 1                                   # column selector: 1, base, base^2, ...
>     while maximum // exp > 0:                 # K iterations
>         my_list = counting_pass(my_list, exp, base)
>         exp = exp * base
>     return my_list
>
> def counting_pass(my_list, exp, base):
>     count = [0] * base
>     for i in range(len(my_list)):
>         digit = (my_list[i] // exp) % base
>         count[digit] += 1
>     position = [0] * base                     # prefix sum -> block start of each digit
>     for d in range(1, base):
>         position[d] = position[d - 1] + count[d - 1]
>     output = [0] * len(my_list)
>     for i in range(len(my_list)):             # INPUT ORDER => stable
>         digit = (my_list[i] // exp) % base
>         output[position[digit]] = my_list[i]
>         position[digit] += 1
>     return output
> ```
> 💡 **Common Mistake:** **Iterating the placement loop backwards or reusing `count` as `position`** ➔ silently makes the pass unstable; the first column still looks right, so the bug only surfaces on multi-digit input.

## ⚖️ Core Decision Matrix
| Algorithm | Time | Auxiliary space | Stable | Selection rule |
| :--- | :--- | :--- | :--- | :--- |
| [[Counting Sort]] | $\Theta(N+M)$ | $\Theta(M{+}N)$ | engineered | keys are integers with $M\ll N$ |
| **Radix Sort** | $\Theta(KN+KM)\approx\Theta(KN)$ | $\Theta(M+N)\approx\Theta(N)$ | **required** | keys decompose into $K$ narrow columns, $K$ small/fixed |
| [[Merge Sort]] | $\Theta(N\log N)\cdot O(k)$ | $\Theta(N)$ | yes | keys not integer-decomposable, or $K$ grows with $N$ |
| [[Quick Sort]] | $\Theta(N\log N)$ avg, $\Theta(N^2)$ worst | $O(\log N)$ | no | in-place matters more than the guarantee |

> [!NOTE] **When It Flips:** radix beats [[Merge Sort]] while $K < \log_2 N$. Fixed-width keys ($32$-bit ints, $K{=}10$ decimal digits) ⟹ $K$ is a **constant** ⟹ $\Theta(N)$. Distinct keys force $K\ge\log_M N$, so the advantage shrinks exactly when the keys become long — and raising base $M$ buys $K$ down at $\Theta(KM)$ time and $\Theta(M)$ space.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
`[200, 151, 291, 981, 369, 421, 671]`, base $10$, $K=3$, LSD first. Digit sorted on is **bold**.

| Pass | Column | Digits read | List after the pass |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | `200 151 291 981 369 421 671` |
| 1 | units | $0,1,1,1,9,1,1$ | `200 151 291 981 421 671 369` |
| 2 | tens | $0,5,9,8,2,7,6$ | `200 421 151 369 671 981 291` |
| 3 | hundreds | $2,4,1,3,6,9,2$ | `151 200 291 369 421 671 981` |

**Stability check on pass 3:** $200$ and $291$ both have hundreds digit $2$; pass 2 left $200$ before $291$, and the stable subsort keeps it ⟹ correct. An unstable pass could emit `151 291 200 …` — wrong final answer.

### Applied Exercise
**Problem:** Derive radix sort's time and auxiliary space from [[Counting Sort]]'s $\Theta(N+M)$, then specialise to base-$10$ integers.
$$
\begin{aligned}
T &= \underbrace{K}_{\text{columns}}\times\underbrace{\Theta(N+M)}_{\text{one stable counting sort}} = \Theta(KN+KM) \\
S &= \underbrace{\Theta(KN)}_{\text{input, }K\text{ symbols per item}} + \underbrace{\Theta(M+N)}_{\text{one subsort, reused}} = \Theta(KN+M+N) \\
M=10 \;&\Rightarrow\; T=\Theta(KN),\quad S=\Theta(KN),\quad S_{\text{aux}}=\Theta(M+N)=\Theta(N)
\end{aligned}
$$
**Final Extracted Output:** $\Theta(KN+KM)$ time, $\Theta(KN+M+N)$ total space, $\Theta(M+N)$ **auxiliary** — auxiliary carries **no $K$**, because the same count/position/output arrays are reused every pass rather than allocated per column.

## ⚠️ Common Mistakes
- 💡 **Multiplying $K$ into the auxiliary space** ➔ the subsort arrays are reused across passes ⟹ auxiliary is $\Theta(M+N)$; only the *input* carries the $K$ factor.
- 💡 **Reusing the two meanings of $M$** ➔ in [[Counting Sort]] $M$ is the **maximum key**; in radix sort $M$ is the **base** (number of distinct symbols per column). Name which one you mean before quoting a bound.
- 💡 **Calling radix sort $\Theta(N)$ with no conditions** ➔ true only once you state that $K$ and $M$ are **capped**; for distinct keys $K=\Omega(\log_M N)$, which recovers $\Theta(N\log N)$.

## 🧠 Active Recall
> [!FAQ]- Why must radix sort's per-column subsort be stable, and why is LSD order the one that needs it?
> - **Hint:** Ask what the previous passes have already established when a tie occurs.
> > [!SUCCESS]- Answer
> > - **Short answer:** Ties on the current digit must fall back on the order from the lower-significance passes — stability is precisely that fallback.
> > - **Why:** **Invariant** ➔ after pass $j$ the list is sorted on the last $j$ digits; a stable pass $j{+}1$ preserves that order within each new digit group, so the invariant extends. An unstable pass discards it and no later pass can recover it.

> [!FAQ]- Radix sort is $\Theta(KN)$ and merge sort $\Theta(N\log N)$ — is radix sort therefore always better?
> - **Hint:** Ask how small $K$ can be when all $N$ keys are distinct.
> > [!SUCCESS]- Answer
> > - **Short answer:** No — $N$ distinct base-$M$ keys need $K\ge\log_M N$, so $\Theta(KN)$ degenerates to $\Theta(N\log N)$.
> > - **Why:** **$K$ is only constant when the key width is capped** ➔ fixed-width $32$-bit integers give $K=\Theta(1)$ and a genuine $\Theta(N)$; unbounded keys do not, and radix additionally requires integer-decomposable keys where [[Merge Sort]] accepts any orderable type.

> [!FAQ]- You may raise the base from $10$ to $100$. State the effect on every term of the complexity, and when it is worth it.
> - **Hint:** $K$ and $M$ move in opposite directions.
> > [!SUCCESS]- Answer
> > - **Short answer:** $K$ halves, $M$ goes $10\to100$ ⟹ time $\Theta(KN+KM)$ trades fewer passes for a bigger count array; worth it while $M\ll N$.
> > - **Why:** **$K=\lceil\log_M(\text{max key})\rceil$** ➔ squaring the base halves the column count, but the $\Theta(KM)$ term and the $\Theta(M)$ auxiliary grow; once $M$ approaches $N$ the per-pass count array dominates and the saving vanishes.
