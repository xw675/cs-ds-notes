---
unit: FIT2094
domain: C
week: 7
parent: "[[Database Transaction]]"
tags: [CS/Databases, SWE/Design]
aliases: [ACID, Atomicity, Consistency, Isolation, Durability]
---
# [[ACID Properties]]

**Context:** [[FIT2094_MOC]] · the four guarantees a correct [[Database Transaction|transaction]] must satisfy · A/D from [[Database Recovery|recovery]], I from [[Concurrency Control and Locking|locking]]

> [!abstract] Quick Revision
> - **🎯 Objective:** the guarantees every transaction upholds ➔ Atomicity, Consistency, Isolation, Durability.
> - **⚡ Key Constraint:** these are *guarantees under failure/concurrency* — Isolation is enforced by locks, Atomicity+Durability by the transaction log.

## 📝 Core
- **Atomicity** ➔ all statements succeed or none do; a failed step triggers ROLLBACK so no partial change remains ("all or nothing").
- **Consistency** ➔ moves the DB from one valid state to another; PK/FK/CHECK/business rules hold *before and after* (may be momentarily broken *during*).
- **Isolation** ➔ concurrent transactions don't interfere; the DBMS locks data so one completes before another modifies it ("independent").
- **Durability** ➔ once COMMITted, changes survive crash/restart/power loss ("data is permanent").
- **Mnemonic** ➔ **A**ll-or-nothing · **C**orrect/consistent state · **I**ndependent · **D**ata permanent.

## ⚠️ Common Mistakes
- 💡 **Consistency is violated *mid*-transaction on purpose** ➔ e.g. $A{-}\$100$ before $B{+}\$100$ leaves money "missing"; the guarantee is only about the *committed* start and end states.
- 💡 **Isolation ≠ serial execution** ➔ interleaving is allowed; locks just make the *result* equivalent to some serial order.

## 🧠 Active Recall
> [!FAQ]- Map each ACID property to the mechanism that enforces it.
> > [!SUCCESS]- Answer
> > - **Short answer:** Atomicity & Durability ← transaction log (UNDO/REDO); Isolation ← locking (S/X, 2PL); Consistency ← constraints + the other three.
> > - **Why:** **Failure vs concurrency** ➔ the log handles crash recovery (A, D); locks handle interference (I); together they preserve valid state (C).
