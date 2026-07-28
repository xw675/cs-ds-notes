---
unit: FIT2086
domain: E
week: 1
source: [lecture]
parent: "[[FIT2086_MOC]]"
tags: [DataScience/Modelling, DataScience/Theory]
aliases: [modelling, statistical inference, population, sample, sampling, model checking, descriptive vs inferential, parameter, estimator]
---
# [[Statistical Modelling and Inference]]

**Context:** [[FIT2086_MOC]] · the **hub** of the unit — why we model data with [[Random Variables and Probability Distributions (FIT2086)|random variables]] and what we infer from a sample · frames every later technique (MLE, testing, regression)

> [!abstract] Quick Revision
> - **🎯 Objective:** treat observed data as a **sample** drawn from a **population** via a probability **model** with unknown **parameters** ➔ use the sample to **infer** those parameters (and hence the population).
> - **⚡ Key Constraint:** modelling data as **random does not mean the data is "truly random"** — the randomness usually encodes **which sample we happened to draw** or **which factors we failed to measure**, not caprice in reality.

## 📝 The pipeline: three elements, three operations
- **Population** ➔ a large collection of objects/items with measurable attributes; its true properties are what we ultimately want.
- **Sample** ➔ a finite number of recordings of attributes of items from the population, $\mathbf{y}=(y_1,\dots,y_n)$.
- **Model** ➔ a mathematical or algorithmic description of the population, **learned/inferred from the sample**; carries unknown **parameters** $\theta$.
- **Sampling** ➔ the act of data collection: recording finitely many attributes on finitely many objects, taken (usually) **at random** from the population.
- **Inference** ➔ short for *inductive* inference: fitting the model to the sample, i.e. moving **from the particular to the general**, plus quantifying how accurate that move is.
- **Model checking** ➔ examining **goodness-of-fit** and compatibility of the model with the sample — and by extension with the population. The step that closes the loop.

## 🧱 What a model is (and is not)
- **Neither correct nor incorrect — only more or less useful** ➔ one model aircraft captures the wing/body proportions, another the aerodynamics; the *purpose* decides which is better.
- **Modelling exposes ignorance** ➔ its value is surfacing what we know and don't know, driving us to find out the rest.
- **Model families toured** ➔ **classifier** (label from ✓/✗ examples) · **probabilistic classifier** (returns $P(\text{class}\mid x)$) · **regression** (predict a number; crudest version predicts the mean) · **clustering** (no labels — the "right" grouping depends on the attribute you care about).

## 🎲 Three sources of randomness
- **Measurement / experimental error** ➔ the recording instrument itself is noisy — repeated voltmeter readings of the *same* voltage differ.
- **Unmeasured factors** ➔ the variable is near-deterministic **given** other variables, but those were never recorded, so its variation *appears* random. Shower temperature is predictable if you know which other taps switched on; without that record it looks random. ➔ **things look random because we did not measure everything that affects them.**
- **Random sampling** ➔ the attribute is not random at all (a person's height), but **which individuals entered the sample** is — so the recorded values vary sample to sample.
- **Consequence** ➔ the random-variable framing captures **sampling variability**, not a claim that reality is indeterministic.

## 🔭 Descriptive vs inferential
- **Descriptive statistics** ➔ **summarise the sample in hand** — a statistic is *any* function $s(\mathbf{y})$ of the data (mean, [[Measures of Spread and Boxplots|variance]], [[Association Between Variables|correlation]]). Says nothing beyond the data.
- **Inferential statistics** ➔ **generalise from sample to population** — estimate parameters, quantify uncertainty, test hypotheses. This is the unit's focus.
- **Bridge** ➔ a good descriptive statistic often becomes an **estimator** of a population parameter (e.g. sample mean $\bar y$ estimates the population mean).
- **Input data types** ➔ categorical-nominal / categorical-ordinal / numeric-discrete / numeric-continuous, i.e. qualitative vs quantitative — see [[Types of Data (Numeric and Categorical)]]; the type dictates which model is admissible.

## 🧭 The modelling workflow
1. **Choose a model** ➔ a family of distributions $p(y\mid\theta)$ believed to fit the data-generating process.
2. **Fit / estimate** ➔ use the sample to estimate $\theta$ (later: maximum likelihood). *Lecture instance:* $\text{bp}=1.2\times\text{weight}+2.2+\text{error}$ — a linear relation with coefficients **learned from data** and an **error term treated as a random quantity**.
3. **Assess** ➔ goodness-of-fit and uncertainty in $\hat\theta$; a more flexible curve always fits the *sample* better but may **overfit** and describe the population worse (see [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]).
4. **Infer / predict** ➔ answer the scientific question or predict new observations.

**Why formal methods** ➔ objective parameter estimation (not eyeballing a line) · principled model **comparison** (is the extra complexity warranted?) · many variables at once (impossible by hand).

## ⚠️ Common Mistakes
- 💡 **Random ≠ meaningless** ➔ calling the data "random" is a modelling choice about **sampling and unmeasured factors**, not a claim that the quantity is unpredictable.
- 💡 **A statistic describes only the sample** ➔ $s(\mathbf{y})$ is a fact about your data; turning it into a claim about the **population** is inference and needs a model.
- 💡 **Sample ≠ population** ➔ conflating them ("the sample mean *is* the population mean") ignores sampling variability — the whole reason the unit exists.
- 💡 **"Fits better" ≠ "better model"** ➔ a more complex curve fits the *sample* more closely by construction; only model checking against the population settles it.
- 💡 **Representativeness is assumed, not guaranteed** ➔ the unit assumes data was collected randomly and representatively; in practice you must interrogate that assumption **before** modelling.

## 🧠 Active Recall
> [!FAQ]- Why do we model a person's height as a random variable when a person's height is not actually random?
> > [!SUCCESS]- Answer
> > - **Short answer:** the randomness models **which individuals landed in our sample**, not the measurement of any one person. From the large population we can only draw a small, random subset, so sample-to-sample the recorded heights differ.
> > - **Why:** **Sampling variability** ➔ the random-variable framing lets us quantify how estimates (like $\bar y$) would vary across repeated samples, which is exactly what inference about the population requires.

> [!FAQ]- Name the three sources of randomness and give the lecture's example of each.
> > [!SUCCESS]- Answer
> > - **Short answer:** **measurement error** (repeated voltmeter readings differ) · **unmeasured factors** (shower temperature fluctuating as unrecorded taps switch on/off) · **random sampling** (heights of 10 students drawn at random from the lecture theatre).
> > - **Why:** **Only the first is noise in the instrument** ➔ the second is determinism we cannot see because we did not record the driving variables; the third is variability in *which* items we observed. All three justify the same mathematical treatment: model the observation as a realisation of a random variable.

> [!FAQ]- A complex curve fits the blood-pressure data better than a straight line. Is it the better model? Justify.
> > [!SUCCESS]- Answer
> > - **Short answer:** not necessarily — better **sample** fit is guaranteed by extra flexibility and may be **overfitting**, i.e. modelling the sample's noise rather than the population's structure.
> > - **Why:** **Fit is measured on the sample, usefulness on the population** ➔ models are "more or less useful, never correct", so the decision is made by **model checking** / principled model comparison (formal method #2), not by residual size alone.
