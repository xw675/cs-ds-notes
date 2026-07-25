---
unit: FIT1043
domain: E
week: 8
parent: "[[R for Data Science]]"
tags: [DataScience/Tools, DataScience/ML, Tool/R]
type: pattern
aliases: [lm, R linear regression, ctree, R decision tree]
---
# [[R Modelling (lm and Decision Trees)]]

**Context:** [[FIT1043_MOC]] · fit models in [[R for Data Science|R]] · R's `lm` = [[Linear and Polynomial Regression|linear regression]]; `ctree` = a [[Decision Trees and Regression Trees|decision tree]] · lab: `30_Projects/FIT1043_Labs/Week8-R-Solution.pdf`
**Problem it solves:** fit a linear model or a decision tree to a data frame, then read its parameters/structure.

> [!abstract] Quick Revision
> - **🎯 Trigger:** model a relationship in R ➔ lm(y ~ x) for regression; ctree(y ~ features) for a tree.
> - **⚡ Key Constraint:** the R **formula** is `response ~ predictor(s)` — the dependent variable goes on the **left** of `~`.

## 🔧 Minimal Working Example
```r
height <- c(151,174,138,186,128,136,179,163,152,131)
weight <- c(63,81,56,91,47,57,76,72,62,48)
fit <- lm(height ~ weight)     # fit: height = a0 + a1*weight
fit$coefficients[1]            # intercept a0  (61.38)
fit$coefficients[2]            # slope a1       (1.415)
summary(fit)                   # slope, std error, p-values, R-squared (0.9548)
```
**Expected output:** an intercept ≈ 61.38 and slope ≈ 1.415; `summary()` reports Multiple R-squared ≈ 0.955.

- **Fit** ➔ `fit <- lm(y ~ x)`; `~` reads "modelled by".
- **Parameters** ➔ `fit$coefficients[1]` = intercept, `[2]` = slope.
- **Diagnostics** ➔ `summary(fit)` → residuals, coefficient estimates, significance, and **R²** (fit quality).
- **Plot the line** ➔ `plot(x, y); abline(lm(y ~ x))` overlays the fitted line.

## 🔀 Variations
- **Decision tree (party package)** ➔
```r
install.packages("party"); library(party)
outputTree <- ctree(nativeSpeaker ~ age + shoeSize + score, data = inputData)
plot(outputTree)
```
- **Predict form** ➔ `lm(height ~ weight)` builds a model to predict `height` (response) from `weight` (predictor).

## ✍️ Practice 
> [!QUESTION]- Practice 1: Fit a linear model predicting `height` from `weight`, then print just the slope.
> > [!SUCCESS]- Reference solution
> > ```r
> > fit <- lm(height ~ weight)
> > fit$coefficients[2]     # the slope (a1)
> > ```
> > - **Key move:** response on the left of `~`; `coefficients[2]` is the slope, `[1]` the intercept.

## ⚠️ Common Mistakes
- 💡 **Formula direction** ➔ `lm(y ~ x)` predicts `y` from `x`; writing it backwards fits the wrong model.
- 💡 **`ctree` needs the `party` package** ➔ `install.packages("party")` once, then `library(party)` each session before calling `ctree`.
