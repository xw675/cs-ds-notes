---
unit: FIT1047
domain: [F, D]
week: 2
parent: "[[Boolean Algebra Laws]]"
tags: [CS/Systems, Math/Logic]
aliases: [SOP, Minterms, Sum of Products]
---
# [[Sum-of-Products (Functions to Circuits)]]

**Context:** [[FIT1047_MOC]] · truth table ➔ expression ➔ gate circuit, systematically · output feeds [[Karnaugh Maps]] for minimisation · gates from [[Transistors and Logic Gates]]

> [!abstract] Quick Revision
> - **🎯 Objective:** read the **rows where $F=1$** ➔ one AND-product per row (complement the 0-variables) ➔ OR the products together ➔ build the circuit gate-for-gate.
> - **⚡ Key Constraint:** SOP is correct but usually NOT minimal — simplification ([[Karnaugh Maps]]) comes after extraction.

## 📝 Core
- **Truth table = the function** ➔ a truth table *uniquely defines* a Boolean function; SOP answers "how do I get an expression back out?"
- **Product (minterm)** ➔ for each row with $F=1$, AND all variables, overlining those that are $0$ in that row: row $X{=}0,Y{=}1,Z{=}0 \Rightarrow \overline{X}Y\overline{Z}$.
- **Sum** ➔ OR every product: the expression is TRUE exactly on the selected rows — by construction it reproduces the table.
- **Circuit recipe** ➔ one NOT per complemented input ➔ one AND gate per product ➔ one OR gate collecting all products; fully mechanical.
- **Equivalence** ➔ different-looking expressions from the same table are equivalent; verify via [[Boolean Algebra Laws]] or the table itself.

## 📊 Applied Exercise — lecture table
Rows where $F(X,Y,Z)=1$: $010,\,011,\,100,\,110,\,111$.
$$
\begin{aligned}
F(X,Y,Z) &= \overline{X}Y\overline{Z} + \overline{X}YZ + X\overline{Y}\,\overline{Z} + XY\overline{Z} + XYZ \\
&\;\text{(5 products ⟹ 5 AND gates + 1 five-input OR — correct, not minimal)}
\end{aligned}
$$
**Final Extracted Output:** valid SOP; [[Karnaugh Maps]] reduces the same table to $Y + X\overline{Z}$.

## ✍️ Practice 
> [!QUESTION]- $G(A,B)$ is $1$ exactly when the inputs differ (rows $01$ and $10$). Extract the SOP and name the function.
> > [!SUCCESS]- Answer
> > - $G = \overline{A}B + A\overline{B}$ — this is XOR ([[Exclusive-or]]).
> > - Circuit: two NOTs, two 2-input ANDs, one OR.
> > - **Key move:** complement exactly the variables that read $0$ in each selected row.

## ⚠️ Common Mistakes
- 💡 **Products come only from 1-rows** ➔ using 0-rows builds the complement $\overline{F}$ (that's the product-of-sums path instead).
- 💡 **Complement the 0s, not the 1s** ➔ the product must evaluate to 1 on its row; a bar on the wrong variable kills the row.
