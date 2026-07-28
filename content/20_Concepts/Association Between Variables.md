---
unit: [FIT1043, FIT2086]
domain: G
week: [0, 2, 4]
source: [lecture, applied, lab]
parent: "[[Measures of Centrality]]"
tags: [DataScience/Statistics, DataScience/Visualisation]
aliases: [Correlation, Pearson Correlation, Association, Scatter Plot, cor, feature screening]
---
# [[Association Between Variables]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · is there a relationship between two variables? · method depends on the [[Types of Data (Numeric and Categorical)|type pair]] · Pearson via [[Data Auditing in Pandas|df.corr()]]
**FIT2086 framing:** Pearson correlation $R(\mathbf{x},\mathbf{y})=\dfrac{\sum_j (x_j-\bar x)(y_j-\bar y)}{n\,s(\mathbf{x})\,s(\mathbf{y})}\in[-1,1]$ measures **linear** association only — $R\approx 0$ does **not** imply independence ($y=x^2$ and points on a circle both give $R\approx 0$ despite deterministic association); and correlation $\neq$ causation.

> [!abstract] Quick Revision
> - **🎯 Objective:** detect a relationship between two variables ➔ pick the tool by the variable-type pair.
> - **📦 Core Components:** cont–cont → scatter + Pearson $r$ | cat–cat → side-by-side bars | cat–num → side-by-side boxplots.
> - **⚡ Key Constraint:** Pearson $r$ measures **linear** association only — $r\approx0$ can still hide a strong non-linear relationship; and correlation $\neq$ causation.

## 📝 How It Works
### 1. Two Continuous Variables
- **Pearson correlation** ➔ measures **linear** association; $-1 \le r \le 1$ (−1 perfectly negative, +1 perfectly positive, 0 = no *linear* association).
- **Scatter plot** ➔ plot $x$ vs $y$ to see the relationship; combine with $r$ for strength + shape.
- **Non-linear blind spot** ➔ $y=x^2+\text{noise}$ gives $r\approx0$ though clearly associated; a deterministic curve can give $r=0$.

### 2. Two Categorical Variables
- **Side-by-side bar graphs** ➔ compare each category's distribution; if the bar shapes differ across groups, a possible association (e.g. cancer frequency vs ethnicity — if unchanged, unlikely associated).
- **Contingency table** ➔ `table(a, b)` quantifies the same comparison; association shows as a category's split departing from the overall base rate (mechanics ➔ [[Categorical Summaries and Cross-Tabulation in R]]).

### 3. Categorical + Numeric
- **Side-by-side boxplots** ➔ split the numeric variable by category and compare boxplots; different distributions ⇒ association (e.g. price varies with number of rooms, but not much between two suburbs).

## ⚖️ Core Decision Matrix
| Variable pair | Visualisation | Quantify |
| :--- | :--- | :--- |
| **continuous × continuous** | scatter plot | Pearson $r$ |
| **categorical × categorical** | side-by-side bars | compare distributions |
| **categorical × numeric** | side-by-side boxplots | compare group boxplots |

> [!NOTE] **When It Flips:** $r$ near $\pm1$ tightens the scatter toward a line (e.g. $r\approx0.9$ vs $0.44$); but $r$ only sees *linear* trend, so always **plot** as well as compute.

## 🔧 Screening many predictors in R *(FIT2086 studio — `wine.csv`)*
```r
wine <- read.csv("wine.csv")
wine_corr = c()
for (i in 1:11)                                   # columns 1..11 are the attributes
{
  wine_corr[i] = cor(wine[,i], wine$quality)
  cat("Correlation between", names(wine)[i], "and quality = ", wine_corr[i], "\n")
}
cat("Variable with maximum correlation is:", names(wine)[which.max(abs(wine_corr))], "\n")
```
**Expected output** ($n=4898$ wines):

| attribute                                       | $r$ with `quality` | reading                             |
| :---------------------------------------------- | -----------------: | :---------------------------------- |
| **alcohol**                                     |           $+0.436$ | **strongest** — the one real signal |
| density                                         |           $-0.307$ | moderate negative                   |
| chlorides                                       |           $-0.210$ | weak negative                       |
| volatile acidity                                |           $-0.195$ | weak negative                       |
| total sulfur dioxide                            |           $-0.175$ | weak negative                       |
| fixed acidity · residual sugar · pH · sulphates |           $r<0.12$ | negligible                          |
| citric acid · free sulfur dioxide               |           $r<0.01$ | **no** linear association           |


- **`which.max(abs(...))` not `which.max(...)`** ➔ a strong **negative** association is just as informative as a positive one; taking the absolute value first is what makes the screen correct.
- **Building a vector in a loop** ➔ `wine_corr = c()` creates an empty vector that grows by index assignment; `names(wine)[i]` recovers the $i$-th column's name for the printout.
- **What this screen is for** ➔ ranking candidate predictors *before* modelling ➔ but a near-zero $r$ only rules out a **linear** relationship, so a variable dismissed here can still matter in a non-linear model.

## ⚠️ Common Mistakes
- 💡 **Correlation ≠ causation** ➔ a strong $r$ never proves one variable causes the other.
- 💡 **$r=0$ ≠ no relationship** ➔ it means no *linear* relationship; a scatter may reveal a clear curve (e.g. $y=x^2$).
- 💡 **Ranking predictors by signed $r$** ➔ use `which.max(abs(r))`; the strongest association can be negative, and a signed sort silently buries it.

## 🧠 Active Recall
> [!FAQ]- Data with $y=x^2+\text{noise}$ has $r\approx0$ — is $x$ associated with $y$? What does this teach?
> - **Hint:** Linear-only measure.
> > [!SUCCESS]- Answer
> > - **Short answer:** Yes — they are clearly associated, but *non-linearly*, so Pearson $r\approx0$; always plot the data, don't rely on $r$ alone.
> > - **Why:** **Linear scope** ➔ Pearson captures only straight-line association; symmetric curves cancel to $r\approx0$.

> [!FAQ]- Which visualisation detects association for each variable-type pair?
> - **Hint:** Match tool to types.
> > [!SUCCESS]- Answer
> > - **Short answer:** cont–cont → scatter plot (+ Pearson $r$); cat–cat → side-by-side bar graphs; cat–num → side-by-side boxplots.
> > - **Why:** **Distribution comparison** ➔ association shows as differing distributions across groups, or a trend in the scatter.
