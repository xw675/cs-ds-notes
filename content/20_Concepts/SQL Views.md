---
unit: FIT2094
week: 10
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [View, CREATE VIEW, Virtual Table]
---
# [[SQL Views]]

**Context:** [[FIT2094_MOC]] · a stored [[SQL SELECT and WHERE|SELECT]] treated as a virtual table · re-run on every reference · **banned in Assignment 2** (use subqueries instead)
**Problem it solves:** name a complex query once so it can be reused/queried like a table.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a complex query reused often, or column/row access to restrict ➔ define a view; query it like a table.
> - **⚡ Key Constraint:** a view stores the **query definition, not data** — each reference re-executes the underlying SELECT.

## 🔧 Minimal Working Example
```sql
CREATE OR REPLACE VIEW maxdaysout_view AS
    SELECT drone_id, MAX(rent_in_dt - rent_out_dt) AS maxdays
    FROM   drone.rental
    WHERE  rent_in_dt IS NOT NULL
    GROUP BY drone_id;

SELECT * FROM maxdaysout_view ORDER BY drone_id;   -- query it like a table
```
**Expected output:** each drone's longest rental duration; the view can be joined/filtered like any table.

- **Virtual table** ➔ an object holding a SELECT; no separate storage, always current.
- **Benefits** ➔ simplifies complex/nested queries; restricts visible columns/rows (access control).
- **Reusable** ➔ reference it inside other queries: `WHERE (drone_id, days) IN (SELECT drone_id, maxdays FROM maxdaysout_view)`.
- **Remove** ➔ `DROP VIEW maxdaysout_view;`.

## ⚠️ Common Mistakes
- 💡 **Not allowed in Assignment 2** ➔ replace a view with a nested or inline subquery ([[SQL Subquery Approaches (Nested, Correlated, Inline)|inline view in FROM]]) for assessed work.
- 💡 **No stored data** ➔ a view never caches results; heavy views re-run their full SELECT on every access.

## 🧠 Active Recall
> [!FAQ]- How does a view differ from a table, and when would you reach for one (outside A2)?
> > [!SUCCESS]- Answer
> > - **Short answer:** A view stores only a SELECT definition (virtual), re-run on each use; a table stores data. Use it to simplify repeated complex queries or to expose a restricted column/row subset.
> > - **Why:** **Definition not data** ➔ always reflects current base-table data; the trade-off is repeated execution cost.
