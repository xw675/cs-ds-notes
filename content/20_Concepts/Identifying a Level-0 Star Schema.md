---
unit: FIT3003
week: 8
source: [lecture, slides, applied]
domain: C
parent: "[[Levels of Aggregation]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Level-0 Test, Star Schemas with No Aggregation, Transaction Level, Purchase Order Case Study]
---
# [[Identifying a Level-0 Star Schema]]

**Context:** [[FIT3003_MOC]] · the chapter's declared trap — deciding whether a drafted star schema is really unaggregated ➔ [[Levels of Aggregation]], [[Star Schema]], [[Entity Relationship Diagram (ERD)]]
**Parent Framework:** [[Levels of Aggregation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** Level-0 is decided **on the E/R diagram, not on the star** ➔ find the entity the fact measure counts or sums, and the schema is Level-0 only when a dimension pins **every** row of that entity.
> - **📦 Core Components:** **transaction $=$ the m–m relationship** in the E/R diagram | **fact measure focus** ➔ which entity the measure is computed over.
> - **⚡ Key Constraint:** having the lowest-level dimensions does **not** guarantee an unaggregated measure — the Purchase Order star with Customer and Order Date dimensions still aggregates, because one date carries many orders.

## 📝 How It Works
### 1. The test
- **Step 1 — locate the transaction** ➔ in the operational E/R diagram, a transaction is normally the **m–m relationship**; `ORDERLINE` between `PURCHASEORDER` and `ITEM`, `LABACTIVITIES` between `STUDENT` and `COMPUTER`.
- **Step 2 — read the measure's focus** ➔ `Total_Order_Quantity` and `Total_Order_Cost` are computed from `OrderPrice` and `Quantity`, which live in `ORDERLINE` ⟹ the focus is the **order line**; `Num_of_PurchaseOrders` counts rows of `PURCHASEORDER` ⟹ the focus is the **order**.
- **Step 3 — ask whether one fact row $=$ one focus row** ➔ if any dimension key can repeat across several focus rows, the measure is still an aggregate and the schema is **not** Level-0.
- **The verdict test** *(Lab 8a)* ➔ "how do I know my Level-0 is right?" — **check the aggregation level of the fact measure**: Level-0 is the highest granularity, where **no** aggregation remains. Level-1 upward has no unique right answer; Level-0 does.
- **The date loophole** *(Lab 8a)* ➔ a $\text{DateDIM}$ keyed on an Oracle `date` hides hours, minutes and seconds, so two orders one customer places on one day still collapse — store the **full date and time** in the dimension, or the "Level-0" schema is silently Level-1.
- **Step 4 — replace, do not merely add** ➔ promote the offending dimension to the entity that identifies the focus ➔ [[Levels of Aggregation]].

### 2. Purchase Order — walking the ladder down
- **Source E/R** ➔ $\text{CUSTOMER} \, 1\!-\!m \, \text{PURCHASEORDER} \, 1\!-\!m \, \text{ORDERLINE} \, m\!-\!1 \, \text{ITEM} \, m\!-\!1 \, \text{PRODUCT}$; `ORDERLINE` is the m–m associative entity carrying `OrderPrice` and `Quantity`.
- **Level-2** ➔ $\text{PurchaseOrderFACT}(\underline{\text{Postcode}^{*}, \text{SeasonID}^{*}, \text{OrderingMethod}^{*}}, \text{TotalOrderQuantity}, \text{TotalOrderCost})$ — Season is a coarse time bucket.
- **Level-1** ➔ replace $\text{SeasonDIM}$ with $\text{OrderDateDIM}$; Order Date and Ordering Method are now **at their finest** and cannot be broken down further, so the next move must target Location.
- **Not-yet-Level-0** ➔ replace $\text{LocationDIM}$(Postcode) with $\text{CustomerDIM}$(CustID). Still aggregated: **Order Date is not a candidate key** of `PURCHASEORDER`, so one customer can raise several orders on one date.
- **Level-0 core** ➔ $\text{PurchaseOrderDIM}$(OrderID, absorbing Order Date and Ordering Method) **and** $\text{ItemDIM}$(ItemID), because one order still spans many order lines. Both are mandatory.
- **Four legal Level-0 schemas** ➔ the minimal one (Purchase Order $+$ Item), the fullest (adding **both** Customer and Product), or either optional dimension alone.

### 3. Changing the measure changes the Level-0 core
- **`Num_of_PurchaseOrders`** ➔ the counting happens in `PURCHASEORDER`, not `ORDERLINE`, so the transaction focus moves **up** one entity.
- **Its Level-0** ➔ $\text{PurchaseOrderFACT}(\underline{\text{CustID}^{*}, \text{OrderID}^{*}}, \text{Num\_of\_PurchaseOrders})$; `ORDERLINE` and `ITEM` drop out of the star's core and become a snowflake chain hanging off $\text{PurchaseOrderDIM}$ ➔ [[Snowflake Schema]].
- **Two schemas that look alike are not alike** ➔ both drafts carry Location, Season and Ordering Method dimensions; only the **focus of the fact measure in the transaction** distinguishes them.

## 🗂️ Schema
$$\text{PurchaseOrderFACT}_{\text{L0,min}}(\underline{\text{OrderID}^{*}, \text{ItemID}^{*}}, \text{TotalOrderQuantity}, \text{TotalOrderCost})$$
$$\text{PurchaseOrderFACT}_{\text{L0,full}}(\underline{\text{CustID}^{*}, \text{OrderID}^{*}, \text{ItemID}^{*}, \text{ProductID}^{*}}, \text{TotalOrderQuantity}, \text{TotalOrderCost})$$
$$\text{PurchaseOrderFACT}_{\text{count}}(\underline{\text{CustID}^{*}, \text{OrderID}^{*}}, \text{Num\_of\_PurchaseOrders})$$
- **Dimension absorption** ➔ $\text{PurchaseOrderDIM}(\underline{\text{OrderID}}, \text{OrderDate}, \text{PayMethod}, \text{OrderingMethod})$ replaces $\text{OrderDateDIM}$ **and** $\text{OrderingMethodDIM}$ at once — lowering the level removed a dimension.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — is this draft Level-0?
| Draft dimensions | Focus entity of the measure | Can a key combination repeat? | Verdict |
| :--- | :--- | :--- | :--- |
| Location, Season, Ordering Method | `ORDERLINE` | yes — a season holds months of orders | Level-2 |
| Location, Order Date, Ordering Method | `ORDERLINE` | yes — many orders share a date | Level-1 |
| Customer, Order Date, Ordering Method | `ORDERLINE` | yes — one customer, several orders per day | **not** Level-0 |
| Customer, Purchase Order | `ORDERLINE` | yes — one order, many order lines | **not** Level-0 |
| Purchase Order, Item | `ORDERLINE` | no — one row per order line | **Level-0** |
| Customer, Purchase Order | `PURCHASEORDER` | no — one row per order | **Level-0** for `Num_of_PurchaseOrders` |

- **Reading the table** ➔ rows 4 and 6 carry the *same* dimensions and disagree; the deciding column is the **focus entity**, which is read from where the measure's source attributes live.

### Applied Exercise — promote a draft to Level-0
**Problem:** a draft star is $\text{SalesFACT}(\underline{\text{Postcode}^{*}, \text{MonthID}^{*}}, \text{Total\_Sales})$ over an E/R diagram $\text{CUSTOMER} \, 1\!-\!m \, \text{SALE} \, 1\!-\!m \, \text{SALELINE} \, m\!-\!1 \, \text{PRODUCT}$, with `LinePrice` stored in `SALELINE`. Give the Level-0 schema.
$$
\begin{aligned}
\text{focus} &= \text{SALELINE} \quad (\text{`LinePrice` lives there}) \\
\text{identifier of one SALELINE} &= (\text{SaleID}, \text{ProductID}) \\
\Rightarrow \text{Level-0 core} &= \{\text{SaleDIM}, \text{ProductDIM}\}
\end{aligned}
$$
**Final Extracted Output:** $\text{SalesFACT}_{\text{L0}}(\underline{\text{SaleID}^{*}, \text{ProductID}^{*}}, \text{Total\_Sales})$, with $\text{CustomerDIM}$ optional; $\text{MonthID}$ disappears because `SaleDate` is absorbed into $\text{SaleDIM}$.

## ⚠️ Common Mistakes
- 💡 **Assuming finest dimensions $\Rightarrow$ Level-0** ➔ the chapter's whole point; Customer $+$ Order Date is as fine as the *dimensions* get and the measure is still summed over many order lines.
- 💡 **Skipping the E/R diagram** ➔ the focus entity cannot be read off the star; without the source model the level is a guess.
- 💡 **Reusing one Level-0 answer for a different measure** ➔ swapping `Total_Order_Cost` for `Num_of_PurchaseOrders` moves the focus up one entity and changes the whole core.

## 🧠 Active Recall
> [!FAQ]- A star schema has no aggregate function in its build SQL and uses the most detailed dimensions available. Is it Level-0?
> > [!SUCCESS]- Answer
> > - **Short answer:** not necessarily — check the **transaction entity** in the E/R diagram first.
> > - **Why:** **Level-0 means one fact row per transaction record** ➔ the transaction is the m–m relationship (`ORDERLINE`), so unless a dimension key identifies an individual order line, several source rows still collapse into one fact row. **Absence of `sum`/`count` proves nothing** ➔ the aggregation may have happened upstream in a TempFact. **The fix is replacement** ➔ promote the dimension to the entity that identifies the focus, which is why $\text{PurchaseOrderDIM}$ and $\text{ItemDIM}$ are the mandatory core ➔ [[Levels of Aggregation]].
