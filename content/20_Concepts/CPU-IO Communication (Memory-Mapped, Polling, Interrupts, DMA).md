---
unit: FIT1047
week: 5
parent: "[[Motherboard and IO Interfaces]]"
tags: [CS/Systems, CS/Architecture]
aliases: [Memory-Mapped IO, Port-Mapped IO, Polling, Interrupts, DMA]
---
# [[CPU-IO Communication (Memory-Mapped, Polling, Interrupts, DMA)]]

**Context:** [[FIT1047_MOC]] · two exam questions in one note: **WHERE** the CPU talks to devices (memory- vs port-mapped) and **WHEN** (polling vs interrupts vs DMA) · devices are ~$10^6\times$ slower than the CPU — everything follows from that

> [!abstract] Quick Revision
> - **🎯 Objective:** devices expose **their own registers** ➔ CPU reaches them via mapped memory addresses or ports ➔ timing solved by poll / interrupt / DMA.
> - **📦 Core Components:** device registers ➔ address mapping ➔ notification strategy ➔ interrupt handler + context switch.
> - **⚡ Key Constraint:** interrupts are checked **before each fetch-decode-execute**; handlers must restore CPU state exactly (context switch — shadow registers or careful software).

## 📝 Core
### 1. WHERE: reaching device registers
- **Device registers live in the device** ➔ e.g. keyboard register holds the pressed key; CPU both reads (ready? success?) and writes (calibrate, on/off).
- **Memory-mapped I/O** ➔ register gets a memory address: `Load A000` reads the keyboard, `Store A100` prints. No new instructions, simple — but eats address space and buggy programs can poke devices.
- **Port-mapped I/O** ➔ separate address space ("ports") + dedicated ISA instructions (`Input A000` vs `Load A000`). Early PCs: 1 MB addressable but only 640 kB usable (rest partly I/O); modern 64-bit machines just memory-map; tiny microcontrollers may still use ports.

### 2. WHEN: notification strategies
- **Programmed/polling I/O** ➔ the program loops checking each device (`canRead()/canWrite()`); simple, programmer controls rates, no hardware — but code becomes I/O-driven and the CPU burns power constantly; niche: embedded systems.
- **Interrupts** ➔ device raises a signal wire; CPU checks *before every fetch*; if raised, runs the **interrupt handler** then resumes. Separation of concerns: main program and handler are separate code.
- **Context switch** ➔ handler must leave the CPU exactly as found: hardware **shadow registers** (switch register files) or software save/restore.
- **IRQ history** ➔ original PC: 15 IRQ lines, manual configuration, conflicts, sharing; modern **APIC**: in-CPU, many IRQs, priorities, high-resolution timers (millisecond ticks — the [[Operating Systems and Multi-Processing|timesharing]] heartbeat).
- **DMA** ➔ interrupts still route all data *through the CPU*; a **DMA controller** transfers device↔RAM directly (disk→RAM, RAM→GPU) while the CPU works — sharing the bus, so only one master transfers at a time.

## ⚖️ Core Decision Matrix
| Strategy | CPU cost | Hardware needed | Best for |
| :-- | :-- | :-- | :-- |
| polling | CPU always busy checking | none | embedded, fixed loops, full control |
| interrupts | near-zero until event | IRQ lines / APIC | keyboards, network — sporadic events |
| DMA | freed even during transfer | DMA controller | bulk data: disk, graphics, audio |

## ⚠️ Common Mistakes
- 💡 **Memory-mapped costs addresses** ➔ the classic disadvantage pair: reduced addressable memory + accidental device access from buggy code.
- 💡 **Interrupt timing** ➔ checked between instructions, never mid-instruction — an instruction always completes.
- 💡 **DMA shares the bus** ➔ CPU and DMA controller can't both transfer simultaneously; "CPU is free" means free to compute, not free to use the bus.

## 🧠 Active Recall
> [!FAQ]- A key is pressed. Walk the full interrupt path from wire to resumed program.
> > [!SUCCESS]- Answer
> > - **Short answer:** Keyboard raises IRQ → CPU finishes current instruction → detects signal pre-fetch → switches to handler (context saved) → handler reads the mapped register → restores state → resumes exactly where interrupted.
> > - **Why:** **State invariance** ➔ shadow registers or save/restore make the interruption invisible to the running program.

> [!FAQ]- Why does a disk read use DMA while a keyboard uses plain interrupts?
> > [!SUCCESS]- Answer
> > - **Short answer:** Disk moves bulk data (MBs) — routing every byte through the CPU wastes it; a keystroke is one value — an interrupt + one register read is cheapest.
> > - **Why:** **Transfer volume decides** ➔ DMA's setup overhead only pays off when the payload is large.
