---
unit: FIT1047
week: 5
parent: "[[Von Neumann Architecture and Programs]]"
tags: [CS/Systems, CS/Hardware]
aliases: [Motherboard, Computer Deconstruction, IO Interfaces, USB]
---
# [[Motherboard and IO Interfaces]]

**Context:** [[FIT1047_MOC]] · the physical machine — what's actually on the board — and how devices plug in · abstract counterpart: [[Von Neumann Architecture and Programs]] · **A2 "motherboard" topic**

> [!abstract] Quick Revision
> - **🎯 Objective:** name the board components (CPU+cooling, RAM, GPU, ROM, clock oscillator, PSU, PCI slots, disks) ➔ map each to its Von Neumann role.
> - **⚡ Key Constraint:** I/O interfaces are trade-offs — no standard wins convenience, speed, cost AND compatibility at once; that's WHY USB/PCIe/HDMI coexist.

## 📝 Core
- **Under the hood** ➔ CPU (+ cooling + fan) · RAM modules · GPU · **ROM** (holds the [[The Boot Process|boot firmware]]) · clock oscillator ([[Fetch-Decode-Execute and RTL (Control)|the clock]]) · power supply · PCI expansion ports · hard disk/DVD.
- **I/O landscape** ➔ inputs (keyboard, touch, mic, camera, GPS, accelerometer, LIDAR…), outputs (screen, printer, audio, vibration…), plus storage (HDD/SSD/SD) and network devices (WiFi, 4G/5G, Ethernet, Bluetooth) — all "I/O" to the CPU.
- **Interfaces** ➔ devices connect via standardised connectors + protocols, internal or external: USB, PCIe, HDMI…
- **Why many standards** ➔ competing goals: *convenience* (robust plug) vs *speed* (keyboard needs little, GPU needs enormous bandwidth) vs *cost* ($5 USB stick vs $1000 graphics card) vs *compatibility* (across machines and years).

## ⚠️ Common Mistakes
- 💡 **ROM ≠ RAM on the board** ➔ ROM is tiny, non-volatile, read-only (boot code); RAM is large, volatile, working memory — mixing them up breaks every boot-process answer.

## 🧠 Active Recall
> [!FAQ]- Why do multiple I/O interface standards coexist instead of one universal connector?
> > [!SUCCESS]- Answer
> > - **Short answer:** Interfaces optimise different corners of convenience/speed/cost/compatibility — a GPU link and a keyboard link have opposite requirements.
> > - **Why:** **Engineering trade-off** ➔ maximal bandwidth needs expensive wide parallel links (PCIe); cheap robust ubiquity needs simple serial ones (USB).

> [!FAQ]- Point to each Von Neumann component on a physical motherboard.
> > [!SUCCESS]- Answer
> > - **Short answer:** CPU socket = ALU+registers+control; RAM slots = memory; PCI/USB/SATA = I/O; buses are the board traces between them; ROM sits aside holding firmware.
> > - **Why:** **Abstract→physical mapping** ➔ the diagram and the board are the same architecture at two abstraction levels.
