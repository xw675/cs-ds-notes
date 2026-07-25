---
unit: FIT1047
week: 5
parent: "[[Motherboard and IO Interfaces]]"
tags: [CS/Systems, CS/Architecture]
aliases: [Boot, BIOS, UEFI, POST]
---
# [[The Boot Process]]

**Context:** [[FIT1047_MOC]] · from power button to GUI — solving the chicken-and-egg of volatile RAM · **A2 "boot process" topic** · hands off to [[Operating Systems and Multi-Processing]]

> [!abstract] Quick Revision
> - **🎯 Objective:** RAM is volatile ➔ boot code must live in **ROM** ➔ chain: power-good → CPU reset → ROM code → POST → hardware init → find OS (boot sector) → load boot code → kernel → drivers → GUI.
> - **⚡ Key Constraint:** each stage loads the NEXT, bigger stage — a bootstrap chain; know the 12 steps in order.

## 📝 Core
- **The problem** ➔ programs run from RAM, RAM loses everything without power ⟹ where does the FIRST program come from, and what does it do?
- **ROM** ➔ read-only, **non-volatile**, small (8 kB original PC → ~16 MB today); holds code to load further boot code from disk/SSD/SD/network + system-settings UI (boot order).

## 📊 Exam Execution Trace — the PC boot sequence
| Step | Event |
| :-- | :-- |
| 1–3 | Power on → "power good" signal to motherboard → CPU reset, clock oscillator starts |
| 4 | Reset vector: CPU executes first instruction **from ROM** |
| 5 | **POST** (Power-On Self Test): check RAM/CPU/GPU…, beep codes on failure |
| 6–7 | Init video (boot messages), then other hardware (disks, network, sound) |
| 8 | Find the OS: search configured order (disk/USB/DVD/network); on disks, boot code sits in the **boot sector** |
| 9 | Load OS boot code into RAM → jump to it |
| 10–11 | Boot code loads the **kernel** → kernel initialises drivers → loads rest of OS |
| 12 | GUI starts — ready to use |

## ⚖️ Core Decision Matrix — BIOS vs UEFI
| Aspect | BIOS (original PC) | UEFI (modern) |
| :-- | :-- | :-- |
| disk size limit | ≤ 2.2 TB | none |
| CPU mode | 16-bit, slow | full 32/64-bit, fast |
| interface | text-only config | graphical UI |
| network | none | built-in drivers, full remote control |
| security | none | authenticated drivers/OS only (secure boot) |

- **Non-PC systems** ➔ Raspberry Pi boots from ROM code executed by the **GPU**; some microcontrollers never "boot" — code runs from non-volatile memory directly.

## ⚠️ Common Mistakes
- 💡 **ROM starts it, RAM runs it** ➔ the ROM only bootstraps; the OS executes from RAM — "the OS is in ROM" is a classic wrong answer.
- 💡 **POST before OS search** ➔ hardware must be verified before anything is loaded; beep codes exist because video may not work yet.

## 🧠 Active Recall
> [!FAQ]- Why can't a computer boot from RAM alone, and how does the ROM solve it?
> > [!SUCCESS]- Answer
> > - **Short answer:** RAM is volatile — empty at power-on; ROM is non-volatile and wired to the CPU's reset vector, providing the first instructions.
> > - **Why:** **Bootstrap chain** ➔ tiny ROM code loads bigger boot code, which loads the kernel — each stage just capable enough to fetch the next.

> [!FAQ]- Give three concrete UEFI advantages over BIOS and the security feature's purpose.
> > [!SUCCESS]- Answer
> > - **Short answer:** >2.2 TB disks, full-speed 32/64-bit execution, GUI + network remote control; secure boot loads only authenticated drivers/OS.
> > - **Why:** **Firmware as attack surface** ➔ pre-OS code owns the machine, so verifying signatures blocks boot-level malware.
