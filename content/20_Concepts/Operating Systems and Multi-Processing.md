---
unit: FIT1047
week: 5
parent: "[[Von Neumann Architecture and Programs]]"
tags: [CS/Systems, CS/OS]
aliases: [Operating Systems, Timesharing, Process States, Kernel Mode, System Calls]
---
# [[Operating Systems and Multi-Processing]]

**Context:** [[FIT1047_MOC]] · the abstraction layer between hardware and software (LO4) · how ONE CPU fakes hundreds of parallel processes · protection via [[Virtual Memory (MMU and Paging)]] · timer interrupts from [[CPU-IO Communication (Memory-Mapped, Polling, Interrupts, DMA)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** the **kernel** manages processes, memory, and I/O ➔ virtualises each resource so every process believes it owns the machine.
> - **📦 Core Components:** abstraction ➔ timesharing (Running/Ready/Blocked) ➔ user vs kernel mode ➔ system calls ➔ timer interrupts.
> - **⚡ Key Constraint:** the state cycle — Running →(timer) Ready →(scheduled) Running →(I/O wait) Blocked →(I/O done) Ready — hand-traceable and examined.

## 📝 Core
### 1. What an OS Is
- **Abstraction layer** ➔ hardware ↔ OS ↔ applications; "probably the most important concept in IT": hide complexity, expose clean interfaces (Python `print` needs no printing knowledge).
- **History** ➔ first OSs = subroutine libraries, one program, full hardware access; UNIX pioneered multi-process + memory/file protection; Linux (free UNIX), macOS (BSD UNIX), Windows (influenced).
- **Kernel's three managements** ➔ **process**, **memory**, **I/O** *(lecture list; the unit LO says process/memory/file — cite whichever the question names)*.
- **Virtualisation** ➔ each process gets a virtual CPU (timesharing), virtual memory ([[Virtual Memory (MMU and Paging)]]), virtual devices (library calls) — write code as if you own the machine.

### 2. Timesharing (one CPU, many processes)
- **A process = a running program**; CPU executes one instruction at a time ⟹ the kernel **switches rapidly** between processes — fast + frequent switching = illusion of concurrency.
- **Process states** ➔ **Running** (has the CPU) · **Ready** (wants the CPU) · **Blocked** (waiting on I/O — not schedulable).

### 3. Staying in Control
- **Kernel mode** ➔ unrestricted, full hardware access; the OS (and every interrupt handler) runs here; any interrupt switches to kernel mode.
- **User mode** ➔ restricted instruction subset — no I/O instructions; all applications live here.
- **System call** ➔ user program asks the OS (special instruction) ⟹ controlled switch to kernel mode — the ONLY door to I/O.
- **Timer** ➔ APIC timer interrupts (e.g. every ms) yank control back to the kernel so it can preempt and reschedule — no process can hog the CPU.

## 📊 Exam Execution Trace — Media Player (MP) vs Web Browser (WB), lecture example
| Time | MP | WB | Event |
| :-- | :-- | :-- | :-- |
| 1–3 | Running | Ready | MP computing; at $t{=}3$ MP initiates I/O |
| 4–5 | **Blocked** | Running | switch to WB while MP waits |
| 6–7 | Ready | Running | MP's I/O finished — ready, not yet scheduled |
| 8–9 | Running | Ready | switch back to MP |
| 10 | Ready | Running | timer switch to WB |

## ⚠️ Common Mistakes
- 💡 **Blocked ≠ Ready** ➔ Blocked waits on I/O (unschedulable); Ready waits only for CPU time — the trace above lives on this distinction.
- 💡 **User programs can't do I/O directly** ➔ they *must* system-call; "the program reads the disk" is shorthand for "asks the kernel to".
- 💡 **Preemption needs hardware** ➔ without timer interrupts a loop `while True: pass` would own the CPU forever.

## 🧠 Active Recall
> [!FAQ]- Explain how the illusion of concurrency is created and what breaks if the timer interrupt disappears.
> > [!SUCCESS]- Answer
> > - **Short answer:** Kernel switches processes rapidly (timesharing); frequency makes it invisible. Without timer interrupts, a non-yielding process runs forever — cooperative-only scheduling.
> > - **Why:** **Interrupt ⟹ kernel mode** ➔ the millisecond tick guarantees the scheduler regains control regardless of user code.

> [!FAQ]- Trace the mode switches when a user program saves a file.
> > [!SUCCESS]- Answer
> > - **Short answer:** User mode → system call (special instruction) → kernel mode: OS validates + performs I/O → return → user mode; process may sit Blocked while the disk works.
> > - **Why:** **Privilege separation** ➔ I/O instructions are kernel-only, so protection is enforced by the CPU itself, not by convention.
