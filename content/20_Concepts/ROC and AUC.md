---
unit: FIT2086
week: 7
source: [lecture]
domain: [E, D]
parent: "[[Classification Evaluation (Confusion Matrix and Metrics)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [AUC, ROC, ROC Curve, Area Under the Curve, Receiver Operating Characteristic, Detection Threshold, Threshold]
---
# [[ROC and AUC]]

**Context:** [[FIT2086_MOC]] · the metric that scores a classifier at **every** threshold at once, instead of freezing it at $\tfrac12$ · one layer above the single confusion matrix of [[Classification Evaluation (Confusion Matrix and Metrics)]] · applied to the probabilities produced by [[Logistic Regression]] · the *ranking* counterpart to the *calibration* measure [[Logarithmic Loss]]

> [!abstract] Quick Revision
> - **🎯 Objective:** sweep the detection threshold $T$ from $0$ to $1$ ➔ trace $(\text{TPR}(T),\text{TNR}(T))$ as a **ROC curve** ➔ the area under it is the **AUC**, a threshold-free score.
> - **📦 Core Components:** small $T$ ➔ high sensitivity, more false positives | large $T$ ➔ high specificity, more false negatives | $\text{AUC}=1$ perfect · $\tfrac12$ random · $0$ perfectly wrong.
> - **⚡ Key Constraint:** AUC scores only the **ranking** of the predicted probabilities — a model can rank perfectly ($\text{AUC}=1$) while every probability it reports is badly calibrated.

## 📝 How It Works
### 1. The Detection Threshold
- **Definition** ➔ choose $T\in(0,1)$ and set $\hat y'_i=1$ whenever $\mathbb{P}(Y'_i=1\mid x'_{i,1},\dots,x'_{i,p})\ge T$, otherwise $\hat y'_i=0$.
- **The default is a choice** ➔ classifying by "whichever class is more likely" is exactly $T=\tfrac12$ ⟹ the argmax rule is one point on a whole family of rules.
- **Each $T$ is a different classifier** ➔ it produces its own confusion matrix, and therefore its own $\text{TPR}(T)$ and $\text{TNR}(T)$.

### 2. The Sensitivity–Specificity Trade-off
- **Small $T$** ➔ almost everyone is called positive ➔ **sensitivity rises**, and the price is **more false positives** (specificity falls).
- **Large $T$** ➔ only confident cases are called positive ➔ **specificity rises**, and the price is **more false negatives** (sensitivity falls).
- **No free lunch** ➔ high sensitivity is always bought at the expense of specificity and vice versa ⟹ a single confusion matrix reports one arbitrary point on this trade-off.
- **Degenerate ends** ➔ $T\to0$ gives $\text{TPR}=1,\text{TNR}=0$; $T\to1$ gives $\text{TPR}=0,\text{TNR}=1$ — the two corners every ROC curve joins.

### 3. The ROC Curve
- **Construction** ➔ vary $T$ across $(0,1)$, plot **sensitivity** against **$1-$specificity** ➔ the *receiver operating characteristic*.
- **Equivalent axes** ➔ the lecture plots sensitivity against **specificity with its axis reversed** — the same curve, drawn right-to-left.
- **Reading the plot** ➔ the ideal classifier hugs the **top-left** corner (all positives caught with no false alarms); the **diagonal** is random guessing.
- **What it fixes** ➔ it removes the analyst's arbitrary choice of $T$ from the comparison of two models.

### 4. AUC — the Area Under That Curve
- **Definition** ➔ the area under the ROC curve; **bigger area = better classifier**.
- **Bounds and landmarks** ➔ $\text{AUC}=1$ perfect classification is achievable · $\text{AUC}=\tfrac12$ no better than a random guess · $\text{AUC}=0$ perfect **mis**classification (the model is right about everything, with the labels flipped).
- **Probabilistic interpretation** ➔ assuming no tied scores, $\text{AUC}=p$ means that for a randomly drawn true positive $i$ and a randomly drawn true negative $k$:
$$
\mathbb{P}\big[\mathbb{P}(Y'_i=1\mid \mathbf{x}'_i)>\mathbb{P}(Y'_k=1\mid \mathbf{x}'_k)\big]=p
$$
- **Plain reading** ➔ AUC is the probability that the model scores a **randomly chosen positive above a randomly chosen negative** ⟹ it is a measure of **ranking quality**, indifferent to the absolute probability values.
- **Hand computation** ➔ over all $n_1\times n_0$ positive–negative pairs, count $1$ for each correctly ordered pair, $\tfrac12$ for each tie, $0$ otherwise, then divide by the number of pairs.

## ⚖️ Core Decision Matrix
| Measure | What it scores | Threshold needed? | Blind to |
| :--- | :--- | :--- | :--- |
| **Classification accuracy** | labels at one operating point | yes ($T=\tfrac12$) | the trade-off at every other $T$; class imbalance |
| **Sensitivity / specificity** | the two error types separately at one $T$ | yes | how the pair moves as $T$ changes |
| **AUC** | the **ranking** across all $T$ | **no** | calibration — the actual probability values |
| **[[Logarithmic Loss]]** | the **probability values** themselves | no | nothing about ranking, but heavily punishes confident errors |

> [!NOTE] **When It Flips:** AUC is the right comparison when the operating threshold is **not yet fixed** or the classes are imbalanced. Once the deployment threshold is decided by real error costs, sensitivity and specificity **at that $T$** are what matter — a higher-AUC model can still be the worse choice at your specific operating point.

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise — AUC by hand from a ranked score list
**Problem:** eight test individuals, sorted by predicted $\mathbb{P}(Y=1)$. Compute the AUC for each case.

| Case | $Y$ values in score order (scores $0.12,0.25,0.28,\cdot,0.48,0.56,0.81,0.93$) |
| :--- | :--- |
| **1** | $0,0,0,0\ \lvert\ 1,1,1,1$ — the fourth score is $0.45$ |
| **2** | $0,0,0,\mathbf{0}\ \lvert\ 1,1,1,1$ — the fourth score is $\mathbf{0.75}$ |

$$
\begin{aligned}
\text{Case 1: } &\text{every positive outscores every negative} \Rightarrow \text{AUC}=1 \\
&\text{any rule } \mathbb{P}(Y=1)>T,\ 0.45<T<0.48 \text{ separates the classes perfectly} \\
\text{Case 2: } &\text{3 of the 4 negatives are beaten by all 4 positives} \Rightarrow 3/4 \text{ of pairs score } 1 \\
&\text{the negative at } 0.75 \text{ beats } 0.48 \text{ and } 0.56, \text{ loses to } 0.81 \text{ and } 0.93 \Rightarrow \tfrac12 \\
\text{AUC} &= \tfrac34\cdot1+\tfrac14\cdot\tfrac12=0.75+0.125=0.875
\end{aligned}
$$
**Final Extracted Output:** Case 1 $\text{AUC}=1$; Case 2 $\text{AUC}=0.875$. Equivalently, $14$ of the $4\times4=16$ positive–negative pairs are correctly ordered, and $14/16=0.875$ — **one badly ranked negative** costs $0.125$ of AUC.

## ⚠️ Common Mistakes
- 💡 **Treating $\text{AUC}=0$ as "useless"** ➔ useless is $\tfrac12$; an AUC of $0$ is a **perfectly informative** model with its labels inverted, and flipping them gives $\text{AUC}=1$.
- 💡 **Reading AUC as an accuracy** ➔ it is a probability about **pairs**, not about individuals; a model can have $\text{AUC}=0.9$ and terrible accuracy at $T=\tfrac12$ if the scores are shifted.
- 💡 **Quoting sensitivity without its threshold** ➔ sensitivity and specificity are meaningless without the $T$ that produced them, because both are functions $\text{TPR}(T)$, $\text{TNR}(T)$.
- 💡 **Choosing $T=\tfrac12$ by default in a costly-error setting** ➔ $\tfrac12$ optimises the count of mistakes, not their **cost**; move $T$ toward the error you can afford.

## 🧠 Active Recall
> [!FAQ]- Why is AUC preferred to classification accuracy when comparing two classifiers?
> - **Hint:** What does accuracy silently fix?
> > [!SUCCESS]- Answer
> > - **Short answer:** Accuracy scores one arbitrary operating point ($T=\tfrac12$); AUC integrates over **every** threshold, so it compares the models rather than the analyst's threshold choice.
> > - **Why:** **Threshold-free** ➔ each $T$ yields a different confusion matrix and hence a different accuracy ⟹ a model can win at $T=\tfrac12$ and lose everywhere else. AUC also survives class imbalance, where a majority-class classifier posts a high accuracy with $\text{AUC}=\tfrac12$.

> [!FAQ]- A model has $\text{AUC}=1$ but its predicted probabilities are all between $0.90$ and $0.99$. What is wrong, and which measure exposes it?
> - **Hint:** Ranking versus values.
> > [!SUCCESS]- Answer
> > - **Short answer:** Nothing is wrong with its **ranking** — it orders every positive above every negative — but its probabilities are badly **calibrated**, claiming near-certainty for the negatives too. [[Logarithmic Loss]] exposes it; AUC cannot.
> > - **Why:** **AUC is order-invariant** ➔ any monotone transformation of the scores leaves the AUC unchanged, so it is blind to the values themselves; log-loss scores $-\log\hat p$ on the true class and punishes confident errors heavily.

> [!FAQ]- You lower $T$ from $0.5$ to $0.2$ on a cancer screening test. State the direction of both error types and justify the move.
> > [!SUCCESS]- Answer
> > - **Short answer:** Sensitivity rises and false negatives fall; specificity falls and false positives rise. For screening this is the right trade — a missed cancer is far costlier than a follow-up test on a healthy patient.
> > - **Why:** **Threshold monotonicity** ➔ lowering $T$ moves individuals from $\hat y=0$ to $\hat y=1$ only, so $\text{TP}$ and $\text{FP}$ can only increase and $\text{FN}$, $\text{TN}$ can only decrease ⟹ $\text{TPR}\uparrow$, $\text{TNR}\downarrow$, tracing the ROC curve up and to the right.
