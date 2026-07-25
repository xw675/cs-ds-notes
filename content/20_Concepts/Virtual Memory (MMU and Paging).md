---
unit: FIT1047
week: 5
parent: "[[Operating Systems and Multi-Processing]]"
tags: [CS/Systems, CS/OS]
aliases: [Virtual Memory, MMU, Page Fault, Swapping]
---
# [[Virtual Memory (MMU and Paging)]]

**Context:** [[FIT1047_MOC]] · one mechanism, two payoffs: **memory safety** between processes and **more memory than RAM** · hardware+software split (MMU + kernel) · extends the swapping idea from [[Memory and the Memory Hierarchy]]

> [!abstract] Quick Revision
> - **🎯 Objective:** each process gets its own **virtual address space**; the OS + **MMU** map virtual → physical addresses ➔ no process can touch another's memory.
> - **📦 Core Components:** virtual addresses ➔ MMU translation + ownership check ➔ page fault interrupt ➔ swap blocks to/from disk.
> - **⚡ Key Constraint:** the MMU checks EVERY access; a foreign address triggers an interrupt (OS kills the process); an on-disk block triggers a **page fault** (OS swaps it in).

## 📝 Core
### 1. Safety (why the browser's passwords survive)
- **Threat model** ➔ nothing physical stops the media player reading the browser's RAM — virtual memory is the mechanism that does.
- **Per-process address spaces** ➔ programs use **virtual addresses** (both processes can happily use `0000`–…); the OS maps each to disjoint **physical** RAM.
- **The mapping is invisible** ➔ processes never see physical addresses; same virtual `A300` in two processes → different RAM.

### 2. The Machinery (OS + MMU)
- **Allocation flow** ➔ process requests memory via [[Operating Systems and Multi-Processing|system call]] → OS programs the mapping into the **MMU** (hardware) → returns a virtual start address.
- **Every `Load 1A20`** ➔ MMU translates virtual → physical on the fly AND checks the physical block belongs to this process; violation ⟹ interrupt ⟹ OS shuts the process down.
- **Division of labour** ➔ MMU does per-access speed-critical work in hardware; the OS does policy (who owns what) in software.

### 3. More Memory Than RAM
- **Overcommit** ➔ 8–16 GB RAM can't hold all processes' code+data ➔ park unused blocks on disk.
- **Page fault path** ➔ process touches a swapped-out block → MMU raises the fault interrupt → OS evicts some other block to disk, loads the needed one, resumes the process — transparent to the program.
- **Performance cliff** ➔ works well only while swapping is rare; constant faulting (thrashing) hits [[Memory and the Memory Hierarchy|disk speeds]], ~$1000\times$ slower.

## ⚠️ Common Mistakes
- 💡 **Two jobs, one mechanism** ➔ exam answers often give only safety OR only overcommit; virtual memory delivers both through the same MMU mapping.
- 💡 **Page fault ≠ crash** ➔ it's a *normal* interrupt the OS services by swapping; an ownership violation is the fatal one.
- 💡 **Swapping direction** ➔ cache pulls hot data toward the CPU; swapping pushes cold data out to disk — keep the arrows straight.

## 🧠 Active Recall
> [!FAQ]- Two processes both `Load A300`. Explain why they read different values and name every component involved.
> > [!SUCCESS]- Answer
> > - **Short answer:** `A300` is virtual; the MMU holds a per-process mapping set up by the OS, translating to different physical addresses.
> > - **Why:** **Per-access translation** ➔ isolation is enforced on every single memory reference in hardware, not by compile-time checks.

> [!FAQ]- Walk the full page-fault sequence from `Load X` to the instruction completing.
> > [!SUCCESS]- Answer
> > - **Short answer:** MMU finds X's block not in RAM → interrupt → kernel mode → OS writes a victim block to disk, reads X's block into the freed RAM, updates the MMU → process resumes and the `Load` retries successfully.
> > - **Why:** **Hardware detects, software decides** ➔ the MMU can only signal; eviction choice and disk traffic are kernel policy.
