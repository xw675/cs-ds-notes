---
unit: FIT2086
week: 9
source: [lecture]
domain: [D, E]
parent: "[[Decision Trees and Regression Trees]]"
tags: [DataScience/Modelling, DataScience/ML, Math/Probability]
aliases: [Growing a Decision Tree, Tree Learning, Likelihood Split, Split Purity, Tree Pruning, Pruning, K-fold CV for Trees, Forward Search for Trees]
---
# [[Decision Tree Learning (Likelihood Splits, Pruning, CV)]]

**Context:** [[FIT2086_MOC]] · how a [[Decision Trees and Regression Trees|decision tree]] is grown and sized · the split score is the Bernoulli NLL from [[Maximum Likelihood Estimation]] · sizing reuses [[Model Selection and Information Criteria (AIC, BIC)]] and [[Cross-Validation]] with $L$ as the complexity
**Parent Framework:** [[Decision Trees and Regression Trees]]

> [!abstract] Quick Revision
> - **🎯 Objective:** score a split by the **minimised NLL** of its leaves $\sum_\ell\big[-n_1\log\tfrac{n_1}{n}-n_0\log\tfrac{n_0}{n}\big]$ ➔ purer leaves = smaller NLL ➔ grow greedily, then size by IC or CV.
> - **📦 Core Components:** [[#2. What Makes a Good Split|split score]] ➔ Bernoulli NLL per leaf | [[#3. Forward Search|forward search]] ➔ greedy, stop when no split lowers the score | [[#4. Pruning and K-fold CV for Trees|prune]] ➔ grow big, cut back to the best $L$.
> - **⚠️ Key Constraint:** splitting can **never increase** the minimised NLL ⟹ NLL alone always grows the tree to $L=n$ (perfect fit, overfit) ⟹ the tree must be **penalised** (IC) or **cross-validated**.

## 📝 How It Works
### 1. Why Not Just Maximise the Likelihood
- **Perfect fit** ➔ if predictor values distinguish every observation, a large enough $L$ fits the training data **perfectly** ➔ overfits.
- **Model selection instead** ➔ score every tree by AIC, BIC, … or a CV error ➔ choose the **smallest** score ➔ trades goodness-of-fit against tree complexity.
- **Search is approximate** ➔ the number of possible trees is enormous even for moderate $p$ ⟹ greedy search, never exhaustive.

### 2. What Makes a Good Split
- **Setup** ➔ binary targets $\mathbf{y}=(y_1,\dots,y_n)$ in one leaf; $n_1=\sum_i y_i$ ones, $n_0=n-n_1$ zeros.
- **Leaf score** ➔ minimised Bernoulli NLL $-\log p(\mathbf{y}\mid\hat\theta)=-n_1\log\frac{n_1}{n}-n_0\log\frac{n_0}{n}$ (with $0\log0=0$).
- **Purity reading** ➔ **largest** at $n_1/n=\tfrac12$ (least pure) · **zero** at $n_1=0$ or $n_1=n$ (pure) · symmetric in $n_1\leftrightarrow n_0$ ➔ $n=20$: peaks at $20\log2\approx13.86$ when $n_1=10$.
- **Split score** ➔ **sum** the leaf NLLs; the best split has the **smallest** total.
- **Numeric predictor** ➔ search thresholds $c$: leaves $\{x_j<c\}$ and $\{x_j\ge c\}$ ➔ keep the $c$ giving the smallest total NLL.
- **Never worse** ➔ the unsplit fit is the special case $\hat\theta_{\text{left}}=\hat\theta_{\text{right}}$ of the split model ⟹ the split's **minimum** NLL $\le$ the parent's ⟹ likelihood guides **which** split, not **whether** to stop.

### 3. Forward Search
1. Start with one leaf (the root).
2. Try splitting on **every** predictor (every threshold) and compute the criterion score of each resulting tree.
3. If no split improves (lowers) the score ➔ **stop**.
4. Otherwise take the split giving the smallest score.
5. Go back to step 2.
- **Greedy** ➔ each step is locally best; an early bad split is never undone.

### 4. Pruning and K-fold CV for Trees
- **Pruning** ➔ grow a **large, overfitted** tree (forward search, splitting on whatever cuts NLL most) ➔ **prune back** subtrees (replace a subtree by one leaf) ➔ how far is set by an information criterion ➔ still approximate, but often **better than forward search**.
- **CV sizing** ➔ complexity parameter $=L$; input $L_{\max}$; for $i=1..m$: split into $K$ disjoint folds; for $k=1..K$: grow a tree with $\gg L_{\max}$ leaves on all folds except $k$ ➔ prune to $L=1,\dots,L_{\max}$ ➔ predict fold $k$ with all $L_{\max}$ pruned trees ➔ accumulate errors; average over the $m$ runs.
- **Choose** ➔ $L^*=\arg\min_{1\le L\le L_{\max}}\text{CV error}(L)$ ➔ **grow the final tree with $L^*$ leaves on all the data**.
- **Cost per run** ➔ $K$ big trees grown, $K\times L_{\max}$ pruned trees scored.

## 🧮 Proof Blueprint
- **Theorem** ➔ for a leaf with $n_1$ ones among $n$, $\min_\theta\{-\log p(\mathbf{y}\mid\theta)\}=-n_1\log\frac{n_1}{n}-n_0\log\frac{n_0}{n}$.
- **Strategy** ➔ write the iid Bernoulli likelihood, plug in the MLE $\hat\theta=n_1/n$ ([[Maximum Likelihood Estimation]]), take $-\log$.
- **Derivation Steps:**
$$
\begin{aligned}
p(\mathbf{y}\mid\theta) &= \prod_{i=1}^{n}\theta^{y_i}(1-\theta)^{1-y_i} = \theta^{n_1}(1-\theta)^{n_0} \\
\hat\theta &= \frac{n_1}{n} \quad\Rightarrow\quad p(\mathbf{y}\mid\hat\theta) = \left(\frac{n_1}{n}\right)^{n_1}\left(\frac{n_0}{n}\right)^{n_0} \\
-\log p(\mathbf{y}\mid\hat\theta) &= -n_1\log\frac{n_1}{n} - n_0\log\frac{n_0}{n}
\end{aligned}
$$
- **Q.E.D.** ➔ the leaf score is $n\times$ the entropy of the leaf's class proportions — the "purity" measure falls out of maximum likelihood.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Toy data, $n=10$, binary predictors $x_1,x_2$:

| $i$ | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
| :--- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| $y$ | 1 | 1 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 0 |
| $x_1$ | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 |
| $x_2$ | 1 | 1 | 0 | 1 | 1 | 0 | 0 | 0 | 1 | 0 |

| Step | Tree | Leaf $y$ values | $\hat\theta$ per leaf | Leaf NLLs | Total NLL |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | root | all 10 | $5/10$ | $-5\log\tfrac12-5\log\tfrac12$ | $6.9315$ |
| 1 | split $x_1$ | $x_1{=}0$: $(1,1,0,1,0)$ · $x_1{=}1$: $(0,0,1,1,0)$ | $3/5$ · $2/5$ | $3.3651+3.3651$ | $6.7302$ |
| 2 | split $x_2$ | $x_2{=}0$: $(0,0,0,1,0)$ · $x_2{=}1$: $(1,1,1,0,1)$ | $1/5$ · $4/5$ | $2.5020+2.5020$ | **$5.0040$** |

- **Verdict** ➔ $x_2$ gives much **purer** leaves ($1/5$, $4/5$ vs $3/5$, $2/5$) ⟹ split on $x_2$.

Greedy growth on 185 patients (leaf label $n_0/n_1$; score = the lecture's information criterion, lower is better):

| Step | Action | Leaves | Score | Kept? |
| :--- | :--- | :--- | :--- | :--- |
| 0 | root | $77/108$ | $175.13$ | — |
| 1 | split on Sex | M $53/7$ · F $24/101$ | $173.70$ | ✓ improves |
| 2 | split Female on Age $50$ | M $53/7$ · F$<50$ $3/78$ · F$\ge50$ $21/23$ | $172.10$ | ✓ improves |
| 3 | also split Male on Age $45$ | M$<45$ $23/3$ · M$\ge45$ $20/4$ · $3/78$ · $21/23$ | $174.20$ | ✗ worse ➔ stop |

### Applied Exercise
**Problem:** a leaf holds $n=10$ with $n_1=6$, $n_0=4$. Find $\hat\theta$ and the leaf NLL; is it purer than a $5/5$ leaf? Then compare split A (leaves $n_1{=}3,n_0{=}2$ and $n_1{=}2,n_0{=}3$) with split B ($1,4$ and $4,1$).
$$
\begin{aligned}
\hat\theta &= 6/10 = 0.6 \\
-\log p(\mathbf{y}\mid\hat\theta) &= -6\log0.6-4\log0.4 = 3.065+3.665 = 6.730 < 6.931 = 10\log2 \\
\text{A} &= 2\,(-3\log0.6-2\log0.4) = 2(3.365) = 6.730 \\
\text{B} &= 2\,(-1\log0.2-4\log0.8) = 2(2.502) = 5.004
\end{aligned}
$$
**Final Extracted Output:** $\hat\theta=0.6$, NLL $=6.730$ ⟹ **purer** than $5/5$; split **B** wins ($5.004<6.730$).

## ⚠️ Common Mistakes
- 💡 **Selecting the tree by training NLL** ➔ it only ever falls as $L$ grows; select by IC or CV error.
- 💡 **Averaging leaf NLLs** ➔ the split score is the **sum** over leaves (each already carries its own $n$).
- 💡 **Keeping a CV fold's tree as the answer** ➔ CV picks $L^*$; the final tree is regrown on **all** the data.

## 🧠 Active Recall
> [!FAQ]- Why can likelihood choose **which** split to make but not **when** to stop?
> > [!SUCCESS]- Answer
> > - **Short answer:** Every split weakly lowers the minimised NLL, so NLL alone would keep splitting to a perfect, overfitted tree; stopping needs a complexity penalty (IC) or held-out error (CV).
> > - **Why:** **Nested models** ➔ the parent leaf is the split model with $\hat\theta_{\text{left}}=\hat\theta_{\text{right}}$, so the split can only match or beat it on the training data.

> [!FAQ]- Trees A, B, C have $L=2,6,18$, training errors $0.28,0.18,0.05$, CV errors $0.31,0.21,0.29$. Which do you choose for prediction, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** **B** — smallest CV error ($0.21$); C's tiny training error is overfitting.
> > - **Why:** **CV estimates future error** ➔ training error always favours the largest $L$; CV error is U-shaped in $L$ and bottoms out at $L=6$.

> [!FAQ]- $K=5$, $L_{\max}=4$: how many pruned models are scored in one full $K$-fold run?
> > [!SUCCESS]- Answer
> > - **Short answer:** $5\times4=20$ pruned trees (from $5$ large trees, one per fold).
> > - **Why:** **Per fold** ➔ grow one big tree on the other $4$ folds, prune to $L=1,2,3,4$, predict the held-out fold with each ⟹ $L_{\max}$ models per fold $\times K$ folds.

> [!FAQ]- Why is pruning a grown tree often better than stopping forward search early?
> > [!SUCCESS]- Answer
> > - **Short answer:** Forward search stops at the first split that fails to improve the score, but a weak split can enable strong splits below it; growing big then pruning lets those deeper splits be seen before deciding.
> > - **Why:** **Greedy myopia** ➔ forward search judges one split at a time; pruning judges whole subtrees — both remain approximate searches.
