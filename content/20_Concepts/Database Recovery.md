---
unit: FIT2094
week: 7
parent: "[[Database Transaction]]"
tags: [CS/Databases, SWE/Design]
aliases: [Recovery, Transaction Log, Checkpoint, REDO, UNDO, Forward Recovery]
---
# [[Database Recovery]]

**Context:** [[FIT2094_MOC]] · restores a consistent state after failure · underwrites the **Atomicity** & **Durability** of [[ACID Properties|ACID]] · driven by the transaction log
**Parent Framework:** [[Database Transaction]]

> [!abstract] Quick Revision
> - **🎯 Objective:** return the DB to a consistent state after a crash ➔ replay/undo work from the transaction log.
> - **📦 Core Components:** transaction log ➔ before/after images | checkpoint ➔ recovery start point | REDO committed / UNDO uncommitted.
> - **⚡ Key Constraint:** which transactions to REDO vs UNDO depends on the **write policy** and whether each transaction had COMMITted at crash time.

## 📝 Core
### 1. Failures & Log
- **Soft crash** ➔ memory lost, disk intact ➔ recover from log (UNDO/REDO).
- **Hard crash** ➔ disk damaged/unreadable ➔ restore backup + forward recovery.
- **Transaction log (journal)** ➔ records every modifying op: start/end markers, op type (INSERT/UPDATE/DELETE), table+row, **before and after values**, prev/next pointers.

### 2. Checkpointing
- **Purpose** ➔ mark a point where the DB is known consistent, so recovery starts there not at log start.
- **Process** ➔ pause new transactions → force-write committed changes to disk → write checkpoint record → resume.

### 3. Write Policies
- **Write-through** ➔ DB updated **immediately** (before COMMIT) ➔ crash needs **UNDO** (before-images) + **REDO** (after-images).
- **Deferred-write** ➔ DB updated **only after** COMMIT ➔ crash needs **REDO only**; simpler, some performance trade-off.

### 4. Hard-Crash / Forward Recovery
- **Steps** ➔ replace disk → reload last backup → REDO committed transactions from the log → forward-recover to pre-crash state.
- **Backups** ➔ full copies, often daily (after close of business); keep on-site (fast) + off-site (disaster).

## ⚖️ Core Decision Matrix
| Policy | DB written | On soft crash |
| :--- | :--- | :--- |
| **Write-through** | immediately, before COMMIT | UNDO uncommitted (newest→oldest) **+** REDO committed (oldest→newest) |
| **Deferred-write** | only after COMMIT | REDO committed only |

> [!NOTE] **When It Flips:** deferred-write never has uncommitted data on disk, so it needs **no UNDO** — the write policy alone determines whether before-images are ever replayed.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Write-through DB. At the soft crash, T1 had COMMITted, T2 had not. Which recovery actions?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{T2 (uncommitted)} &\Rightarrow \text{UNDO using before-images, newest}\to\text{oldest} \\
\text{T1 (committed)} &\Rightarrow \text{REDO using after-images, oldest}\to\text{newest}
\end{aligned}
$$
**Final Extracted Output:** UNDO T2 to erase its partial writes; REDO T1 to guarantee its durability.

## 🧠 Active Recall
> [!FAQ]- Why does deferred-write recovery need no UNDO list, while write-through needs both?
> - **Hint:** Uncommitted data on disk or not.
> > [!SUCCESS]- Answer
> > - **Short answer:** Deferred-write only writes to disk *after* COMMIT, so the disk never holds uncommitted changes to undo; write-through writes before COMMIT, so a crash can leave partial writes needing UNDO.
> > - **Why:** **Timing of the write** ➔ before-images are only needed when uncommitted data may already be on disk.

> [!FAQ]- What does a checkpoint achieve for recovery time?
> - **Hint:** Bounded log scan.
> > [!SUCCESS]- Answer
> > - **Short answer:** It marks a known-consistent point with committed changes flushed, so recovery replays only from the last checkpoint, not the whole log.
> > - **Why:** **Force-write + marker** ➔ everything before the checkpoint is already safely on disk.
