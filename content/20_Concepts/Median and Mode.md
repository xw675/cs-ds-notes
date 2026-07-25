---
unit: FIT1058
week: 10
parent: "[[Random Variable]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Median and Mode]]

**Context:** [[FIT1058_MOC]] · two further measures of location for a [[Random Variable]] · median = "middle" of the distribution, mode = most likely value · contrast with [[Expectation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** median = middle, mode = most likely value ➔ location measures beside [[Expectation|mean]].
> - **📦 Core Components:** median (half mass each side) ➔ mode ($\arg\max\mathrm{Pr}$).
> - **⚡ Key Constraint:** median is outlier-robust but has **no linearity**; all three locate, none spread.

## 📝 Core
### 1. The Measures
- **Median** ➔ $m$ with $\mathrm{Pr}(X\le m)\ge\tfrac12$ **and** $\mathrm{Pr}(X\ge m)\ge\tfrac12$.
- **Mode** ➔ value $g$ maximising $\mathrm{Pr}(X=g)$ (may be non-unique).
- **Location** ➔ both are location measures, like [[Expectation]].

### 2. Median Subtleties
- **≠ mid-range** ➔ mid-range $\tfrac{\min+\max}{2}$ ignores probabilities; median uses the whole distribution.
- **Gap** ➔ may fall between values (fair die → 3.5 by symmetry).

### 3. Mode Bounds, Doesn't Locate
- **Upper bound** ➔ $\mathrm{Pr}(X=\text{mode})$ bounds every value's probability.
- **Can be far** ➔ from mean/median (though clustered for well-behaved distributions).

**Key identities:**

$$\text{median } m:\ \mathrm{Pr}(X\le m)\ge\tfrac12 \text{ and } \mathrm{Pr}(X\ge m)\ge\tfrac12$$
$$\text{mode } g = \arg\max_k \mathrm{Pr}(X=k)$$

## ⚖️ Core Decision Matrix
| Measure | Definition | Property |
| :--- | :--- | :--- |
| mean ([[Expectation]]) | weighted average | linear, outlier-sensitive |
| median | half mass each side | robust, no linearity |
| mode | most likely value | bounds probabilities |
| all three | location | none measures spread |

> [!NOTE] **When It Flips:** median is robust to outliers ($1,2,3,4,90$: median 3, mean 20) but has **no linearity**, so expectation is preferred for arithmetic. Spread needs [[Variance and Standard Deviation]], not location.

## 📊 Exam Execution Trace

### Manual Execution Trace
Scrabble points CDF:

| Step / State | $k$ | $\mathrm{Pr}(X=k)$ | $\mathrm{Pr}(X\le k)$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | 0 | 0.02 | 0.02 |
| 2 | 1 | 0.68 | 0.70 ≥½ |
| 3 | ≥2 | 0.30 | 1.00 |

## ⚠️ Common Mistakes
- 💡 **Median ≠ mid-range** ➔ mid-range ignores all probabilities; the median's balance point need not be halfway between extremes.

## 🧠 Active Recall
> [!FAQ]- Define the median and contrast it with the mid-range and the mean.
> - **Hint:** Balance point, robust.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(X\le m)\ge\tfrac12$ and $\mathrm{Pr}(X\ge m)\ge\tfrac12$; mid-range ignores probabilities; median is outlier-robust.
> > - **Why:** **No linearity** ➔ median of $X+Y$ ≠ sum of medians, so mean preferred for arithmetic.

> [!FAQ]- What is the mode, and what does its probability tell you?
> - **Hint:** Argmax + upper bound.
> > [!SUCCESS]- Answer
> > - **Short answer:** The most likely value; $\mathrm{Pr}(X=\text{mode})$ upper-bounds all others.
> > - **Why:** **Shape-blind** ➔ says nothing else; the mode can be far from mean/median.
