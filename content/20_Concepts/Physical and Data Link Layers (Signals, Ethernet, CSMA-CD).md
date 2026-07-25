---
unit: FIT1047
domain: F
week: [7, 9]
parent: "[[Internet Model (Layers, Protocols, Encapsulation)]]"
tags: [CS/Networks]
aliases: [Physical Layer, Data Link Layer, Ethernet, CSMA/CD, Manchester Encoding]
---
# [[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]]

**Context:** [[FIT1047_MOC]] · the bottom two layers, implemented together on the **NIC** — bits become signals (physical), signals become governed frames (data link)

> [!abstract] Quick Revision
> - **🎯 Objective:** physical = transmit bits as digital (voltage square waves) or analog (modulated waves) signals; data link = **M**edia **A**ccess **C**ontrol + frames + error detection + MAC addresses.
> - **📦 Core Components:** encodings (unipolar/NRZ/NRZI/Manchester) ➔ modulations (frequency/amplitude/phase) ➔ Ethernet CSMA/CD.
> - **⚡ Key Constraint:** CSMA/CD's three parts — sense before sending, shared medium, jam + random wait on collision — recite all three.

## 📝 Core
### 1. Physical Layer
- **NIC** ➔ implements physical AND data link layers: socket/antenna, framing, error detection, encoding/modulation; on-board or USB/PCIe.
- **Media** ➔ electrical signals in copper (UTP most common, STP, coax legacy), light in optical fibre, radio through space.
- **Cable standards** ➔ 10BASE-T (10 Mbps, cat 3/5) → 100BASE-T (cat 5) → 1000BASE-T (cat 5e/6) → 10GbE (cat 5e–7 or fibre) → 40GbE (fibre).
- **Digital encodings** ➔ voltage square waves: *unipolar* (+3 V/0 V) · *NRZ* (±3 V) · *NRZI* (invert on 1) · **Manchester** (transition mid-bit: low→high vs high→low — self-clocking).
- **Analog modulation** ➔ vary a sinusoid's **frequency** (FSK), **amplitude** (ASK), or **phase** (PSK); combining e.g. 4 amplitudes × 2 phases = 8 symbols ⟹ 3 bits/symbol — $3\times$ the data rate. Most networks combine AM+PM.

### 2. Data Link Layer
- **Duties** ➔ control access to the physical medium (MAC), frames↔signals, error detection, interface up to Network layer, identify interfaces via **MAC addresses**.
- **Contention-based MAC** ➔ anyone transmits anytime ⟹ **collisions** damage packets ⟹ carrier-sense + detect + retransmit.
- **Ethernet (IEEE 802.3)** ➔ THE LAN technology since 1973/1980; originally 10 Mbps shared coax bus, now switched 100 Mbps–1 Gbps UTP, fibre to 100 Gbps.
- **CSMA/CD** ➔ **C**arrier **S**ense (listen first) + **M**ultiple **A**ccess (shared medium) + **C**ollision **D**etection (jam signal, random backoff, retransmit).
- **Hub trap** ➔ a hub repeats every signal to all ports: physical star, **logical shared bus** — still one collision domain.
- **Shared-Ethernet problems** ➔ half-duplex, everything broadcast to everyone, CSMA/CD bounds network size ⟹ solved by **switches** (true logical star, next lectures).

## ⚠️ Common Mistakes
- 💡 **MAC has two meanings here** ➔ Media Access Control (the mechanism) and MAC address (the identifier) — expand the acronym the exam asks about.
- 💡 **Physical vs logical topology** ➔ hub wiring LOOKS like a star but behaves as a bus; the collision domain follows the logical shape.
- 💡 **More symbols ≠ more Hz** ➔ AM+PM packs more bits per symbol on the same wave — rate rises without new spectrum.

## 🧠 Active Recall
> [!FAQ]- Walk through CSMA/CD when two devices transmit simultaneously.
> > [!SUCCESS]- Answer
> > - **Short answer:** Both sensed silence and sent; signals overlap → each detects a foreign signal → transmits a jam signal so ALL devices notice → each waits a *random* time → retransmits.
> > - **Why:** **Random backoff breaks symmetry** ➔ identical waits would re-collide forever.

> [!FAQ]- Why is Manchester encoding worth halving the symbol efficiency?
> > [!SUCCESS]- Answer
> > - **Short answer:** The guaranteed mid-bit transition carries the clock with the data — receiver never drifts on long runs of 0s or 1s.
> > - **Why:** **Self-clocking** ➔ NRZ's flat stretches give no timing edges; Manchester trades bandwidth for synchronisation.
