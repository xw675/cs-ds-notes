---
unit: [FIT1043, FIT2086]
domain: E
week: [2, 8]
source: [lecture, applied, lab]
parent: "[[R Vectors]]"
tags: [DataScience/Tools, Tool/R]
type: pattern
aliases: [R Data Frame, data.frame, read.csv, aggregate, R wrangling, R Data Frames and I/O, logical referencing, stringsAsFactors, subsetting data frames]
---
# [[R Data Frames and IO]]

**Context:** [[FIT1043_MOC]] · R's table = bound [[R Vectors|vectors]] · the [[Data Wrangling|wrangling]]/exploration workhorse · R's answer to a [[Data Auditing in Pandas|pandas DataFrame]]
**Problem it solves:** build/read a data frame, audit it, extract/sort/merge/aggregate rows and columns, and write it back.

> [!abstract] Quick Revision
> - **🎯 Trigger:** tabular data in R ➔ data.frame(); audit with str/summary; slice with [row, col] and the $ operator.
> - **⚡ Key Constraint:** `df[i]` selects a **column**; a **row** needs the trailing comma `df[i, ]` — the comma placement changes everything.

## 🔧 Minimal Working Example
```r
names <- c("Bill","Ted","Henry","Joan"); ages <- c(76,82,104,78)
myTable <- data.frame(names, ages)
names(myTable) <- c("Names","Ages")   # rename columns
dim(myTable)      # [1] 4 2   (nrow=4, ncol=2)
str(myTable)      # column names + data types
summary(myTable)  # per-column summary stats
```
**Expected output:** a 4×2 table; `dim` → `4 2`; `str`/`summary` describe types and distributions.

- **Build / rename** ➔ `data.frame(v1, v2, …)`; `names(df) <- c(...)`.
- **Audit** ➔ `nrow` / `ncol` / `dim`; `str(df)` (types); `summary(df)`; `head(df)` / `tail(df)`; stats `min`/`mean`/`sd` on `df$col`.
- **Extract** ➔ column `df["Ages"]` or `df$Ages`; multiple `df[c("Names","Ages")]`; by index `df[2]`; row `df[1, ]`; cell `df[1,2]`; block `df[3:4, 2:3]`.
- **Sort** ➔ `df[order(df$Ages), ]` (asc) / `order(df$Ages, decreasing=TRUE)`; multi-key `order(df$Ages, df$Heights)`.
- **Combine** ➔ `merge(a, b, by="Names")` (join on key); `rbind(a, b)` (stack rows — same columns).
- **Aggregate** ➔ `aggregate(mtcars, by=list(cyl, vs), FUN=mean)` (group → summary).

## 🔀 Variations
- **I/O** ➔ `getwd()` / `setwd("D:/Folder")`; `write.csv(df, "F.csv")`; `df <- read.csv("F.csv", header=TRUE, stringsAsFactors=TRUE)` — `header` names the columns from line 1, `stringsAsFactors` makes text columns **categorical** (always pass it; see [[Categorical Summaries and Cross-Tabulation in R]]).
- **Libraries & datasets** ➔ `install.packages("moments")` once, then `library(moments)`; `data()` lists built-ins, `data(mtcars)` loads one; `head(df, 10)` overrides the default 6 rows; `View(df)` opens the RStudio spreadsheet viewer.

### Logical referencing — filtering rows by a condition
```r
heart <- read.csv("heart.csv", header = TRUE, stringsAsFactors = TRUE)
heart[heart$SEX == 0, "AGE"]                    # AGE column, rows where SEX is 0
heart[heart$CHOL < 150, c("SEX","CP")]          # two columns, rows meeting the condition
heart[heart$SEX == 0 & heart$CHOL < 150, ]      # AND — all columns, both conditions
heart[heart$SEX == 0 | heart$CHOL < 150, ]      # OR
```
- **Mechanism** ➔ `heart$SEX == 0` evaluates to a **logical vector** the length of the data frame; placing it in the row slot keeps every `TRUE` position ➔ conditions compose with `&` (AND) and `|` (OR), element-wise.
- **Row slot, column slot** ➔ the condition goes **before** the comma; the columns go after.

### Adding and deleting columns
```r
heart$AC <- heart$AGE / heart$CHOL   # ADD: assign to a name that doesn't exist yet
heart$AC <- NULL                     # DELETE: assign the special value NULL
```
- **Vectorised** ➔ the arithmetic runs element-wise over all rows at once; no loop needed.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Load `mtcars`, show its first rows, and the mean of every numeric column grouped by `cyl` and `vs`.
> > [!SUCCESS]- Reference solution
> > ```r
> > data(mtcars)
> > head(mtcars)
> > aggregate(mtcars, by = list(mtcars$cyl, mtcars$vs), FUN = mean)
> > ```
> > - **Key move:** `aggregate(..., by=list(...), FUN=mean)` is R's group-by-then-summarise.

> [!QUESTION]- Practice 2: From `heart.csv`, show `RESTECG` and `HD` for rows 10–50; then add a column `AC = AGE/CHOL`, inspect it, and remove it again.
> > [!SUCCESS]- Reference solution
> > ```r
> > heart <- read.csv("heart.csv", header = TRUE, stringsAsFactors = TRUE)
> > nrow(heart); ncol(heart)          # 303 rows, 14 columns
> > heart[10:50, c("RESTECG","HD")]
> > heart$AC <- heart$AGE / heart$CHOL
> > head(heart)
> > heart$AC <- NULL
> > ```
> > - **Key move:** `10:50` in the row slot is a **range of positions**; a *condition* in that same slot would be logical referencing. Deleting a column is `<- NULL`, not `rm()` (which removes whole objects from the workspace).

## ⚠️ Common Mistakes
- 💡 **Comma = row vs column** ➔ `df[2]` is column 2; `df[2, ]` is row 2; `df[2,3]` is one cell.
- 💡 **`=` vs `==` inside a filter** ➔ `heart[heart$SEX = 0, ]` is an error; comparison needs the double equals.
- 💡 **`setwd` before read/write** ➔ relative filenames resolve against the working directory; set it (or pass a full path) first.
- 💡 **`str` may show `Factor`** ➔ character columns can load as factors; check with `str()` before treating them as plain text.
