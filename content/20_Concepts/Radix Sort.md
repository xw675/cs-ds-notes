---
unit: FIT2004
domain: A
week: [2, 3]
source: [lecture, applied]
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
- **Lecture notation map — memorise both** ➔ this note's $K$ (columns) is the lecture's $c$; this note's $M$ (base) is the lecture's $b$; the lecture reserves $M$ for the **largest item**. In lecture symbols: $c=\lfloor\log_b M\rfloor+1$, time $O(cN+cb)$, auxiliary $O(N+b)$.
- **Digit extraction is arithmetic, not string slicing** ➔ column $j$ (counting from $0$ at the least significant end) of key $x$ is $\lfloor x / b^{j}\rfloor \bmod b$ ⟹ $O(1)$ per digit, no conversion to text.

### 2. Least-Significant-Digit Order + Stability
- **Pass order** ➔ sort on column $K$ (rightmost), then $K{-}1$, … , then column $1$ ⟹ after pass $j$ the list is correctly sorted on the last $j$ digits.
- **Stability carries the earlier work** ➔ when column $j$ ties, a stable subsort preserves the previous pass's order, which is exactly the ordering on the lower-significance digits ⟹ the invariant is maintained.
- **Unstable ⟹ catastrophe** ➔ with $200$ before $291$ from pass 2, an unstable hundreds pass may emit $291$ before $200$; both have hundreds digit $2$, so nothing later repairs it.

### 3. Choosing the Base — Where Linearity Comes From
- **The base is a free design parameter** ➔ nothing forces $b=10$; you pick $b$, and that choice alone decides whether the sort is linear.
- **Raise $b$ up to $N$** ➔ the per-pass cost is $\Theta(N+b)$, so any $b\le N$ leaves it at $\Theta(N)$ ⟹ total $\Theta(cN)$. Choosing $b=N$ is the standard move because it buys the **smallest** $c$ at no asymptotic cost.
- **Never let $b>N$** ➔ the count array of size $b$ then **dominates** the $N$ items, the per-pass cost becomes $\Theta(b)$, and the sort is no longer linear in $N$ — it is linear in the *base* you chose.
- **The linearity theorem** ➔ with $b=N$, $c=\lfloor\log_N M\rfloor+1$; so if the largest item satisfies $M=O(N^{d})$ for a **constant** $d$, then $c=O(d)=\Theta(1)$ and radix sort runs in $\Theta(N)$.
$$
b=N,\quad M=O(N^{d}) \;\Longrightarrow\; c=\log_N M = \Theta(d) \;\Longrightarrow\; T=\Theta(cN+cb)=\Theta(N)
$$
- **Where it stops being linear** ➔ $M$ super-polynomial in $N$ ($M=N^{N}$, $M=N!$) makes $c$ grow with $N$ — the distinct-keys argument of the "When It Flips" note, reached from the base side.
- **$b=N$ is the asymptotic rule, NOT the constant-factor optimum** `[D]` ➔ for $N$ integers of $W$ bits, $c=W/\log_2 b$ and the operation count is
$$
f(b)=\frac{W}{\log_2 b}\,(N+b)
$$
which is minimised well below $N$: at $W=64,\ N=10^{6}$ the minimum sits near $b\approx95{,}536$, so the practical choice is $b=2^{16}=65536$ — the nearest power of two whose exponent **divides** the word width, giving exactly $c=4$ passes.
- **Powers of two win twice** ➔ a base of $2^{t}$ makes digit extraction a **shift and mask** instead of a division, and choosing $t \mid W$ avoids a ragged final column; measured timings degrade sharply for $b=2^{20}$ and $2^{24}$ because $20$ and $24$ do not divide $64$.

### 4. Ragged Keys
- **Unequal lengths break the column grid** ➔ `banhammer` and `kappa` have no common $K$.
- **Pad to a common width** ➔ insert a filler symbol that sorts **below** every real symbol; numbers pad with leading zeros (right-aligned), strings pad with spaces.
- **Alignment decides the order semantics** ➔ right-aligned padding gives numeric order; left-aligned padding gives lexicographic order — choose deliberately, they differ.

### 5. Optimising for Strings — the $\Theta(n)$ Algorithm *(applied Problem 4 — `[D, HD]`)*
- **Applied-sheet notation** ➔ $k$ $=$ number of strings · $\ell$ $=$ length of the **longest** string · $n=\sum_i \text{len}(S_i)$ $=$ **total characters**. The optimal bound is $\Theta(n)$ in *that* $n$ — do not read it as this note's item count.
- **Naive padding is $\Theta(\ell k)$** ➔ every string is scanned $\ell$ times regardless of its own length ⟹ pathological when lengths are skewed: $10^{6}$ strings of length $10$ plus **one** string of length $10^{6}$ costs $10^{12}$ operations, against $n\approx2\times10^{7}$ actual characters.
- **The fix — never look at a string before it has a character to contribute** ➔ a string of length $i$ only matters in the **final $i$ iterations** of an LSD sweep, so exclude it from every earlier pass.
- **Step 1 — counting-sort by length, ASCENDING** ➔ key $=\text{len}(S)$, range $\ell$ ⟹ $\Theta(\ell+k)$. Ascending is load-bearing: shorter strings must precede longer ones that **share a prefix** (`cat` before `cats`), which is exactly alphabetical order.
- **Step 2 — sweep columns $i=\ell$ down to $1$ with a live pointer** ➔ maintain $j$ such that $S[j\dots k]$ are the strings of length $\ge i$; on each decrement of $i$, decrement $j$ while $\text{len}(S[j-1])\ge i$ ⟹ strings enter the working window exactly when they acquire a character at position $i$, and never leave.
- **Step 3 — run the stable counting subsort on $S[j\dots k]$ only** ➔ base $26$, so no pass ever touches a non-existent character.
- **Why it totals $\Theta(n)$** ➔ string $S_i$ participates in exactly $\text{len}(S_i)$ passes ⟹ the work is $\sum_i \text{len}(S_i)=n$, plus the $\Theta(\ell+k)$ length sort ⟹ **optimal**, since every character must be read at least once.
- **Alignment decides the semantics, not the speed** ➔ this scheme is **left-aligned/lexicographic** (position $1$ is the first character); right-aligned padding is the *numeric* reading and is the wrong model for words ➔ §4.

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

### 🔹 $\Theta(n)$ radix sort for variable-length strings
> [!code]- `radix_sort_strings` — length sort, then a live-window sweep (applied Problem 4)
> ```python
> def radix_sort_strings(S):
>     # S: non-empty lowercase strings. n = SUM of all lengths.
>     k = len(S)
>     longest = 0
>     for i in range(k):
>         if len(S[i]) > longest:
>             longest = len(S[i])
>     S = counting_sort_by_length(S, longest)   # ASCENDING; O(longest + k)
>     j = k                                     # invariant: S[j..k-1] have length >= i
>     for i in range(longest, 0, -1):           # LSD sweep over character positions
>         while j > 0 and len(S[j - 1]) >= i:
>             j = j - 1                         # admit strings that now HAVE a char i
>         count = [0] * 26
>         for p in range(j, k):
>             count[ord(S[p][i - 1]) - 97] += 1
>         position = [0] * 26                   # prefix sum -> block starts
>         for c in range(1, 26):
>             position[c] = position[c - 1] + count[c - 1]
>         temp = [None] * (k - j)
>         for p in range(j, k):                 # INPUT ORDER => stable
>             d = ord(S[p][i - 1]) - 97
>             temp[position[d]] = S[p]
>             position[d] += 1
>         for p in range(j, k):                 # write the window back
>             S[p] = temp[p - j]
>     return S
> ```
> 💡 **Common Mistake:** **Sorting the lengths descending** ➔ then `cats` precedes `cat`, which is not alphabetical order. Ascending is what makes a shorter string win when it is a **prefix** of a longer one — the same rule that makes the pad symbol sort below every real character ➔ §4.

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
- 💡 **Sizing the count array from `max()`** ➔ that is [[Counting Sort]]'s rule; radix sizes it from the **base**. You still scan for `max` — but only to compute the **number of columns** $c=\lfloor\log_b M\rfloor+1$. Lecturer-flagged as the recurring code-review error.

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
