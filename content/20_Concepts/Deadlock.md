---
unit: FIT2094
domain: C
week: 7
parent: "[[Concurrency Control and Locking]]"
tags: [CS/Databases, SWE/Design]
aliases: [Deadlock, Deadly Embrace, Wait-For Graph]
---
# [[Deadlock]]

**Context:** [[FIT2094_MOC]] · the failure mode of [[Concurrency Control and Locking|locking]] · two transactions each hold what the other needs · resolved by prevention, avoidance, or detection

> [!abstract] Quick Revision
> - **🎯 Objective:** two+ transactions wait forever on each other's locks ➔ break the cycle by prevention, avoidance, or detection+recovery.
> - **⚡ Key Constraint:** a cyclic wait (T1 holds A wants B; T2 holds B wants A) halts both indefinitely — the "deadly embrace".

## 📝 Core
- **Definition** ➔ transactions blocked in a **cycle** of lock-waits, none able to proceed (deadly embrace).
- **Prevention** ➔ if granting a lock *would* deadlock, roll the transaction back **before** it waits; simple but adds overhead.
- **Avoidance** ➔ request **all** locks upfront; if not all available, release held locks and retry later; fewer deadlocks, less concurrency.
- **Detection + recovery** ➔ Lock Manager periodically finds cycles in a **Wait-For Graph**; abort a **victim** (winner continues).
- **Victim choice** ➔ prefer aborting transactions that made few changes, sit in multiple cycles, or run under lower-privilege roles; avoid long, heavily-modified ones.

## ⚖️ Core Decision Matrix
| Approach | When it acts | Cost |
| :--- | :--- | :--- |
| **Prevention** | before waiting (abort early) | overhead from premature rollbacks |
| **Avoidance** | at lock-request time (all-or-release) | reduced concurrency |
| **Detection + recovery** | after the cycle forms | victim rollback + graph scanning |

## ⚠️ Common Mistakes
- 💡 **Detection is reactive** ➔ it lets the deadlock happen, then rolls back a victim — throughput cost is the aborted work, not upfront blocking.
- 💡 **Victim ≠ random** ➔ the DBMS optimises which transaction to sacrifice (least work lost), so a small transaction may be aborted to save a large one.

## 🧠 Active Recall
> [!FAQ]- Distinguish deadlock prevention from detection-and-recovery, and name the structure detection uses.
> > [!SUCCESS]- Answer
> > - **Short answer:** Prevention rolls a transaction back *before* it can wait into a cycle; detection lets cycles form, spots them in a **Wait-For Graph**, then aborts a victim.
> > - **Why:** **Proactive vs reactive** ➔ prevention/avoidance stop the cycle arising; detection tolerates it and recovers by victim selection.
