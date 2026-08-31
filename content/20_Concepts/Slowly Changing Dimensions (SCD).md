---
unit: FIT3003
week: [5, 6]
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [SCD, Temporal Data Warehousing, SCD Type 2, SCD Type 4, Slowly Changing Dimension]
---
# [[Slowly Changing Dimensions (SCD)]]

**Context:** [[FIT3003_MOC]] · [[Building Dimension Tables]] assumes a member's attributes never move — SCD is the answer when they do · *(captured from the W6 webinar recap of Chapter 6)*
**Parent Framework:** [[Star Schema]]

> [!abstract] Quick Revision
> - **🎯 Objective:** fold the **temporal (historical)** aspect of a dimension record into the warehouse ➔ a measure must be reportable against the attribute value that was true **at the time of the fact**, not the value true today.
> - **📦 Core Components:** **Types 0 / 1** ➔ no history at all | **Types 2 / 3 / 6** ➔ history kept **inside** the dimension | **Type 4** ➔ history split into a separate table (a [[Bridge Tables|bridge]] / weak entity).
> - **⚡ Key Constraint:** overwriting a changed attribute silently **re-prices the past** — every historic fact row is then reported at the current value.

## 📝 How It Works
### 1. The failure it fixes — Bookshop case study
- **Operational source** ➔ $\text{BOOK}(\underline{\text{BookID}}, \text{BookTitle}, \text{Author})$ joined to $\text{BOOKTRANSACTION}$, with price history held apart in $\text{BOOKPRICEHISTORY}(\underline{\text{BookID}^{*}, \text{StartDate}, \text{EndDate}}, \text{Price}, \text{Remarks})$.
- **The naive star** ➔ $\text{BookSalesFACT}(\underline{\text{TimeID}^{*}, \text{BranchID}^{*}, \text{BookID}^{*}}, \text{Number\_of\_Books\_Sold})$ with `Price` stored flat inside $\text{BookDIM}$.
- **Symptom** ➔ *Harry Potter 6* reports at $\$30.95$ in **every** month, even though it sold at $\$10.00$ during Mar2008 — the report is arithmetically correct and commercially wrong.
- **Open-ended sentinel** ➔ the current price row carries $\text{EndDate} = \text{Dec}9999$, so "the price now" is a range test, not a `max()`.

### 2. The type ladder
- **Type 0 — original** ➔ stores the **initial** value of the record and never touches it again.
- **Type 1 — latest** ➔ overwrites with the **latest** value. *Shared weakness of 0 and 1* ➔ neither records the history of changes at all.
- **Type 2 — versioned rows** ➔ history is **not** separated from the main dimension; new records keep being **added** to it, so $\text{BookDIM}$ gains $\text{StartDate}, \text{EndDate}, \text{Price}, \text{Remarks}, \text{CurrentFlag}$ and one book occupies many rows.
- **Type 3 — previous column** ➔ a simplification of Type 2 assuming the **complete history is not necessary**: one row per member, with `CurrentPrice` beside `PreviousPrice` (`Null` when the member never changed).
- **Type 4 — history table** ➔ a **new dimension** holds the full change history; $\text{BookDIM}$ keeps only the stable attributes and the price columns move to $\text{BookPriceDIM}$. The same book keeps **one** `BookID`.
- **Type 6 — 2 $+$ 3** ➔ no separate identifier for the same book, but the **entire history is kept** alongside `CurrentPrice` / `PreviousPrice`: $\text{BookDIM}(\underline{\text{BookID}}, \text{BookTitle}, \text{Author}, \text{StartDate}, \text{EndDate}, \text{CurrentPrice}, \text{PreviousPrice}, \text{Remarks}, \text{CurrentFlag})$.

## ⚙️ Schema Layout
### 🔹 Type 4 — the shape the lecture builds
> [!code]- Mermaid `erDiagram` — history split out of `BookDIM`
> ```mermaid
> erDiagram
>   TIME_DIM      ||--o{ BOOK_SALES_FACT : qualifies
>   BRANCH_DIM    ||--o{ BOOK_SALES_FACT : qualifies
>   BOOK_DIM      ||--o{ BOOK_SALES_FACT : qualifies
>   BOOK_DIM      ||--o{ BOOK_PRICE_DIM  : "price over time"
>   BOOK_SALES_FACT {
>     VARCHAR2 TimeID FK
>     VARCHAR2 BranchID FK
>     VARCHAR2 BookID FK
>     NUMBER Number_of_Books_Sold
>   }
>   BOOK_DIM {
>     VARCHAR2 BookID PK
>     VARCHAR2 BookTitle
>     VARCHAR2 Author
>   }
>   BOOK_PRICE_DIM {
>     VARCHAR2 BookID PK
>     DATE StartDate PK
>     DATE EndDate PK
>     NUMBER Price
>     VARCHAR2 Remarks
>   }
> ```
> 💡 **Common Mistake:** **Minting a new `BookID` per price change** ➔ that is the Type 2 move; Type 4 exists precisely so the book keeps one identity and the fact's FK stays stable.

## ⚖️ Core Decision Matrix
| Type | Where history lives | Rows per member | Recovers the price at sale time? | Cost |
| :--- | :--- | :--- | :--- | :--- |
| 0 | nowhere — initial value frozen | 1 | ❌ | reports drift as reality moves |
| 1 | nowhere — overwritten | 1 | ❌ | the past is silently re-priced |
| 2 | in the dimension, as extra rows | many | ✅ full | dimension grows; needs `CurrentFlag` to find "now" |
| 3 | in the dimension, as extra **columns** | 1 | ⚠️ one step back only | anything older than the previous value is lost |
| 4 | in a **separate** dimension | 1 $+$ $n$ history rows | ✅ full | one more join per historic query |
| 6 | both (2 $+$ 3) | many | ✅ full $+$ fast "current" | widest dimension; two mechanisms to keep consistent |

> [!NOTE] **When It Flips:** Type 3 is enough only while "the previous value" is the whole business question. The moment a report must span more than one change — a book that went full price ➔ $20\%$ off ➔ half price ➔ full price — Types 2, 4 or 6 are the only correct answers.

## ⚠️ Common Mistakes
- 💡 **Treating Type 0 and Type 1 as different for reporting** ➔ they differ in *which* single value survives, not in whether history exists; both answer historic questions wrong.
- 💡 **Reading a Type 2 dimension without `CurrentFlag` or the date range** ➔ every join fans out to one row per version and the measure multiplies.
- 💡 **Calling Type 4's history table a plain dimension** ➔ its key is the composite $(\text{BookID}, \text{StartDate}, \text{EndDate})$; it is a weak-entity / bridge-shaped table hanging off the parent, not a second axis of the star.

## 🧠 Active Recall
> [!FAQ]- The fact already stores `TimeID`. Why can it not just look up the price for that month, instead of the warehouse carrying an SCD at all?
> > [!SUCCESS]- Answer
> > - **Short answer:** because a flat `Price` column in the dimension holds **one** value with no time attached — there is nothing for `TimeID` to be matched against.
> > - **Why:** **A dimension attribute is unqualified by time** ➔ $\text{BookDIM}.\text{Price}$ describes the book, not the book-on-a-date, so the join returns the same figure for every `TimeID`. **The temporal key must be stored** ➔ Types 2, 4 and 6 all work by introducing $(\text{StartDate}, \text{EndDate})$ so the sale month can fall **inside a range**. **Type 3 fakes it** ➔ `PreviousPrice` gives an ordering with no dates, so it can rank two values but never place a fact between them.

> [!FAQ]- Type 2 and Type 4 both keep the complete history. On what grounds does the design choose between them?
> > [!SUCCESS]- Answer
> > - **Short answer:** on whether the member is allowed to keep **one identifier** — Type 2 versions the dimension row, Type 4 leaves the row alone and versions a separate table.
> > - **Why:** **Type 2 changes what a dimension row means** ➔ a row is now a *version* of a book, so any query not filtering on `CurrentFlag` or a date range double-counts. **Type 4 preserves the star's grain** ➔ $\text{BookDIM}$ stays one row per book and the fact's FK never has to be re-pointed, at the price of an extra join whenever the historic attribute is actually needed. **Volatility decides** ➔ an attribute that changes constantly (price) is cheaper isolated in Type 4; one that changes rarely and is queried with everything else sits fine as Type 2 versions.
