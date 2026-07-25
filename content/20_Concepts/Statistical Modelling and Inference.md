---
unit: FIT2086
week: 1
parent: "[[FIT2086_MOC]]"
tags: [DataScience/Modelling, DataScience/Theory]
aliases: [modelling, statistical inference, population, sample, sampling, descriptive vs inferential, parameter, estimator]
---
# [[Statistical Modelling and Inference]]

**Context:** [[FIT2086_MOC]] · the **hub** of the unit — why we model data with [[Random Variables and Probability Distributions (FIT2086)|random variables]] and what we infer from a sample · frames every later technique (MLE, testing, regression)

> [!abstract] Quick Revision
> - **🎯 Objective:** treat observed data as a **sample** drawn from a **population** via a probability **model** with unknown **parameters** ➔ use the sample to **infer** those parameters (and hence the population).
> - **⚡ Key Constraint:** modelling data as **random does not mean the data is "truly random"** — the randomness usually encodes **which sample we happened to draw**, not caprice in the measurement.

## 📝 The core vocabulary
- **Population** ➔ the entire collection of interest (often huge or hypothetical); its true properties are what we ultimately want.
- **Sample** ➔ the finite set of observations $\mathbf{y}=(y_1,\dots,y_n)$ we actually have.
- **Sampling** ➔ the process of drawing the sample from the population.
- **Model** ➔ a probability distribution (with unknown **parameters** $\theta$) assumed to have generated the data.
- **Inference** ➔ using the sample to draw conclusions about the population / the parameters $\theta$.

## 🎲 Two sources of randomness
- **Measurement / experiment error** ➔ the measurement itself is random each time (e.g. a dice roll; a noisy volt-meter reading). Models "experimental error".
- **Random sampling from a population** ➔ the measured quantity (e.g. a person's height) is **not** itself random, but **which individuals** we sampled is — so sample-to-sample the recorded values differ.
- **Key insight** ➔ modelling observations as random variables captures **sampling variability**, not a claim that reality is indeterministic.

## 🔭 Descriptive vs inferential
- **Descriptive statistics** ➔ **summarise the sample in hand** — a statistic is *any* function $s(\mathbf{y})$ of the data (mean, [[Measures of Spread and Boxplots|variance]], [[Association Between Variables|correlation]]). Says nothing beyond the data.
- **Inferential statistics** ➔ **generalise from sample to population** — estimate parameters, quantify uncertainty, test hypotheses. This is the unit's focus.
- **Bridge** ➔ a good descriptive statistic often becomes an **estimator** of a population parameter (e.g. sample mean $\bar y$ estimates the population mean).

## 🧭 The modelling workflow
1. **Choose a model** ➔ a family of distributions $p(y\mid\theta)$ believed to fit the data-generating process.
2. **Fit / estimate** ➔ use the sample to estimate $\theta$ (later: maximum likelihood).
3. **Assess** ➔ how well does the model fit? how uncertain is $\hat\theta$?
4. **Infer / predict** ➔ answer the scientific question or predict new observations.

## ⚠️ Common Mistakes
- 💡 **Random ≠ meaningless** ➔ calling the data "random" is a modelling choice about **sampling**, not a statement that the underlying quantity is unpredictable.
- 💡 **A statistic describes only the sample** ➔ $s(\mathbf{y})$ is a fact about your data; turning it into a claim about the **population** is inference and needs a model.
- 💡 **Sample ≠ population** ➔ conflating them ("the sample mean *is* the population mean") ignores sampling variability — the whole reason the unit exists.

## 🧠 Active Recall
> [!FAQ]- Why do we model a person's height as a random variable when a person's height is not actually random?
> > [!SUCCESS]- Answer
> > - **Short answer:** the randomness models **which individuals landed in our sample**, not the measurement of any one person. From the large population we can only draw a small, random subset, so sample-to-sample the recorded heights differ.
> > - **Why:** **Sampling variability** ➔ the random-variable framing lets us quantify how estimates (like $\bar y$) would vary across repeated samples, which is exactly what inference about the population requires.

> [!FAQ]- Distinguish descriptive from inferential statistics, and how they connect.
> > [!SUCCESS]- Answer
> > - **Short answer:** **descriptive** statistics summarise the sample via a function $s(\mathbf{y})$ (mean, variance, correlation) and make no claim beyond the data; **inferential** statistics use the sample + a model to draw conclusions about the **population** (estimation, uncertainty, testing).
> > - **Why:** **Statistic → estimator** ➔ a descriptive statistic becomes inferential when used to **estimate a population parameter**; the model supplies the link (and the uncertainty) between the sample summary and the population truth.
