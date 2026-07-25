---
unit: FIT2094
week: 7
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, SWE/Design]
aliases: [Transaction, COMMIT, ROLLBACK]
---
# [[Database Transaction]]

**Context:** [[FIT2094_MOC]] · groups [[SQL Sublanguages (DDL, DML, DCL)|DML]] into one logical unit · the frame for [[ACID Properties|ACID]], [[Concurrency Control and Locking|locking]] and [[Database Recovery|recovery]]

> [!abstract] Quick Revision
> - **🎯 Objective:** bundle several DML statements into one all-or-nothing unit ➔ COMMIT saves all, ROLLBACK undoes all.
> - **⚡ Key Constraint:** a mid-transaction state is **inconsistent**; a failure between steps must ROLLBACK the earlier ones — partial commit is never allowed.

## 📝 Core
- **Definition** ➔ a group of SQL operations executed **completely or not at all**.
- **COMMIT** ➔ save all changes permanently; **ROLLBACK** ➔ undo all changes since the last commit.
- **Scope** ➔ transaction control applies to INSERT/UPDATE/DELETE only (DDL auto-commits, see [[SQL Sublanguages (DDL, DML, DCL)]]).
- **Worked case (drone return)** ➔ (1) UPDATE `rental` return date/condition/`emp_no_in`, (2) UPDATE `drone` add flight time, (3) COMMIT — all three are **one** logical operation.

## ⚠️ Common Mistakes
- 💡 **No `COMMIT`/`ROLLBACK` for DDL** ➔ they apply only to DML; a `CREATE`/`ALTER` is already permanent.
- 💡 **Partial success = corruption** ➔ if step 2 fails after step 1 commits data, the drone shows returned with no flight time logged; ROLLBACK the whole unit instead.

## 🧠 Active Recall
> [!FAQ]- Why must a drone-return's two UPDATEs be one transaction rather than two independent statements?
> > [!SUCCESS]- Answer
> > - **Short answer:** They are all-or-nothing — if the flight-time update fails after the rental update, the rental update must be rolled back to avoid an inconsistent record.
> > - **Why:** **Atomicity** ➔ the DBMS treats the group as one unit; COMMIT publishes both, ROLLBACK discards both.
