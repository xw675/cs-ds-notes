---
unit: FIT2094
week: 7
parent: "[[Database Transaction]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
aliases: [Concurrency, Locking, Shared Lock, Exclusive Lock, Two-Phase Locking, 2PL]
---
# [[Concurrency Control and Locking]]

**Context:** [[FIT2094_MOC]] · enforces the **Isolation** of [[ACID Properties|ACID]] · stops interleaved [[Database Transaction|transactions]] corrupting shared data
**Parent Framework:** [[Database Transaction]]

> [!abstract] Quick Revision
> - **🎯 Objective:** let multiple transactions interleave safely ➔ guard each data item with shared/exclusive locks under two-phase locking.
> - **📦 Core Components:** [[#2. Locks Shared S and Exclusive X|S/X locks]] ➔ granularity (db/table/page/row) | [[#3. Two-Phase Locking 2PL|2PL]] ➔ growing then shrinking.
> - **⚡ Key Constraint:** the **lost update** — interleaved reads then writes overwrite each other; serial execution avoids it but throttles throughput.

## 📝 Core
### 1. The Concurrency Problem (Lost Update)
- **Serial** ➔ finish T1 entirely before T2 ➔ guarantees isolation but **low throughput**.
- **Interleaved (non-serial)** ➔ alternate operations across transactions ➔ high throughput but **may break isolation**.
- **Lost update** ➔ two transactions read the same value, both compute from the stale copy, and the later commit overwrites the earlier — one update vanishes.

### 2. Locks — Shared (S) and Exclusive (X)
- **Lock** ➔ marks a data item temporarily unavailable to other transactions.
- **Shared (S)** ➔ read-only; **many** transactions may hold S on the same item at once.
- **Exclusive (X)** ➔ read+write; **only one** holder, and no other lock may coexist.
- **Granularity** ➔ database / table / page / row — finer = more concurrency, coarser = simpler.
- **Rule of thumb** ➔ READ ⟹ S, UPDATE ⟹ X; COMMIT/ROLLBACK releases **all** locks.

### 3. Two-Phase Locking (2PL)
- **Growing phase** ➔ acquire **all** needed locks (no release yet); once held, apply changes.
- **Shrinking phase** ➔ issue COMMIT/ROLLBACK, then release locks — never acquire after releasing.

## ⚖️ Core Decision Matrix
| Lock type | Grants | Coexists with | Requested by |
| :--- | :--- | :--- | :--- |
| **Shared (S)** | read only | other S locks | READ |
| **Exclusive (X)** | read + write | nothing | UPDATE |

> [!NOTE] **When It Flips:** an X request must wait until **every** other lock (S or X) on the item is released; multiple S locks are compatible, so readers never block readers — only a writer forces the wait.

## 📊 Exam Execution Trace

### 1. Lost Update (no locking)
| Time | Operation | X |
| :--- | :--- | :--- |
| **0 (Init)** | — | $5$ |
| 1 | T1 reads X; T2 reads X | $5$ |
| 2 | T1: $X{=}X{+}2$ | $7$ |
| 3 | T2: $X{=}X{+}5$ (from stale $5$) | $10$ |
| 4 | T1 commit | $7$ |
| 5 | T2 commit ⟹ **T1's update lost** | $10$ |

### 2. S/X Locking with 2PL
| Time | Txn | Op | A | B |
| :--- | :--- | :--- | :--- | :--- |
| 0 | T1 | READ A | S(T1) | — |
| 1 | T2 | READ A | S(T2) | — |
| 2 | T1 | UPDATE A | **T1 WAIT T2** | — |
| 3 | T2 | READ B | — | S(T2) |
| 4 | T2 | UPDATE B | — | X(T2) |
| 5 | T2 | COMMIT ⟹ releases; T1 gets | X(T1) | — |

**Final Extracted Output:** T1's X-lock on A is blocked until T2 commits and drops its S(A); only then does T1 acquire X(A).

## 🧠 Active Recall
> [!FAQ]- At time 2 T1 wants to UPDATE A but must wait — why, and when is it unblocked?
> - **Hint:** X needs all other locks released.
> > [!SUCCESS]- Answer
> > - **Short answer:** T1 needs an X-lock on A, but T2 still holds S(A); X is incompatible with any other lock, so T1 waits until T2 COMMITs (time 5) and releases.
> > - **Why:** **S-many, X-one** ➔ shared locks coexist, an exclusive lock demands sole possession.

> [!FAQ]- How does two-phase locking prevent the lost update?
> - **Hint:** Acquire-all-before-release.
> > [!SUCCESS]- Answer
> > - **Short answer:** Under 2PL a transaction takes an X-lock before writing and holds it (growing phase) until commit; the second transaction cannot read/write the item until the first releases, so no write is based on a stale value.
> > - **Why:** **Growing then shrinking** ➔ no lock is released while more are still being acquired, serialising the conflicting accesses.
