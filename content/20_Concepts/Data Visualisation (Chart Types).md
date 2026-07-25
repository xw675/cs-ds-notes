---
unit: FIT1043
domain: G
week: 4
parent: "[[Types of Data (Numeric and Categorical)]]"
tags: [DataScience/Visualisation]
aliases: [Data Visualisation, Histogram, Bar Chart, Pie Chart, Motion Chart]
---
# [[Data Visualisation (Chart Types)]]

**Context:** [[FIT1043_MOC]] · picking a chart by [[Types of Data (Numeric and Categorical)|data type]] · a preliminary form of analysis · rendered in [[Plotting with Matplotlib (Pandas)|matplotlib]]

> [!abstract] Quick Revision
> - **🎯 Objective:** choose the chart that matches the data type ➔ numeric → histogram/boxplot; categorical → bar/pie/frequency table.
> - **📦 Core Components:** histogram (continuous) vs bar chart (categorical) | pie (≤6 categories) | motion chart (5-D).
> - **⚡ Key Constraint:** visualisation is *preliminary* — it gives a "feel" and reveals patterns, but a flat screen limits you to ~2 dimensions.

## 📝 How It Works
### 1. Purpose
- **Preliminary analysis** ➔ get a "feel" for the data; can quickly reveal patterns.
- **Dimension limit** ➔ paper/screen is 2-D; tricks push to 5–7 dims (colour/size/time), but readability drops.

### 2. Charts by Data Type
- **Numeric (discrete + continuous)** ➔ **histograms**, **box plots**, **motion charts**.
- **Categorical** ➔ **frequency tables** (a summary, not a graph), **bar graphs**, **pie charts**.
- **Bar chart** ➔ compares groups or shows change over time.
- **Pie chart** ➔ proportions of a whole; usable for **≤6 categories** (more becomes unreadable).

### 3. Histograms (bin continuous data)
- **Definition** ➔ a bar chart of bin counts for **continuous** data (bar charts alone are for categorical).
- **Bins** ➔ $K$ equally spaced bins of width $w = \dfrac{\max\{y\}-\min\{y\}}{K}$; bin count $v_k = \#\{y_j \in (\min\{y\}+(k-1)w,\ \min\{y\}+kw)\}$.
- **Choosing $K$** ➔ too few hides shape, too many looks ragged (e.g. 20 → 50 smoother → 100 ragged).

### 4. Motion Charts
- **What** ➔ interactive multi-dimensional viz (GapMinder, Hans Rosling; Google renamed them **bubble charts**).
- **Five dimensions** ➔ x-axis, y-axis, bubble **size**, bubble **colour**, and **time**.
- **Trade-off** ➔ + deep trends, good for exploration, intuitive; − not for static media, controls complex/overwhelming.

## ⚖️ Core Decision Matrix
| Data type | Charts | Note |
| :--- | :--- | :--- |
| **Numeric-continuous** | histogram, box plot | histogram needs binning |
| **Numeric (either)** | motion/bubble chart | multi-dimensional/time |
| **Categorical** | bar graph, frequency table | bar compares groups |
| **Categorical (proportions)** | pie chart | ≤6 categories only |

> [!NOTE] **When It Flips:** a **histogram** and a **bar chart** look alike but differ by data type — histograms bin *continuous* numeric data (bars touch, order matters), bar charts show *categorical* counts (bars separate, order free).

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Data spans $\min = 0$, $\max = 100$, using $K = 20$ bins. Bin width? Which bin holds $y = 47$?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
w &= \frac{\max-\min}{K} = \frac{100-0}{20} = 5 \\
\text{bin index} &= \left\lceil \frac{47-0}{5} \right\rceil = \lceil 9.4 \rceil = 10 \quad (\text{covers } 45\text{–}50)
\end{aligned}
$$
**Final Extracted Output:** width $5$; $y=47$ falls in bin 10 (the 45–50 interval).

## 🧠 Active Recall
> [!FAQ]- A histogram and a bar chart look identical — what actually distinguishes them?
> - **Hint:** Continuous vs categorical.
> > [!SUCCESS]- Answer
> > - **Short answer:** A histogram bins **continuous** numeric data (adjacent, ordered bins); a bar chart shows **categorical** counts (separate bars, no inherent order).
> > - **Why:** **Binning** ➔ histogram bars represent ranges $w=(\max-\min)/K$; bar-chart bars represent discrete categories.

> [!FAQ]- Why cap pie charts at ~6 categories, and what five dimensions can a motion chart show?
> - **Hint:** Readability + encoding channels.
> > [!SUCCESS]- Answer
> > - **Short answer:** Beyond ~6 sectors the eye can't compare relative sizes; a motion chart encodes x, y, bubble size, bubble colour, and time.
> > - **Why:** **Perceptual limits** ➔ too many sectors/dimensions overwhelm interpretation.
