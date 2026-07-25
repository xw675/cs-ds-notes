---
unit: FIT1047
week: 8
parent: "[[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]]"
tags: [CS/Networks]
aliases: [Switches, Forwarding Table, Store and Forward, LAN Design]
---
# [[Switched Ethernet (Switches, Forwarding, LAN Design)]]

**Context:** [[FIT1047_MOC]] · the fix for every shared-Ethernet problem from [[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]] — true logical star, full duplex, no collisions · plus how real LANs are designed

> [!abstract] Quick Revision
> - **🎯 Objective:** a switch is a **layer-2 device** that reads frame MAC addresses and forwards ONLY to the destination socket — learning its forwarding table by watching sender addresses.
> - **📦 Core Components:** learn-by-observing ➔ flood-when-unknown ➔ store-and-forward buffering ➔ switch vs router ➔ design levers (standards, segmentation).
> - **⚡ Key Constraint:** an EMPTY forwarding table makes a switch behave exactly like a hub (flood to all except source) — the learning story is the exam story.

## 📝 Core
### 1. How a Switch Works
- **Logical star** ➔ point-to-point circuits per device; looks like a hub (4–24 UTP sockets) but the circuit is NOT shared.
- **Learning** ➔ every arriving frame's *sender* MAC gets recorded (MAC → socket); destination in table ⟹ deliver to that socket only; unknown ⟹ **flood** to all sockets except the source.
- **Full duplex** ➔ separate send/receive paths per device ⟹ **collisions impossible**; CSMA/CD becomes unnecessary.
- **Store and forward** ➔ two frames for the same destination at once? The switch buffers the second and forwards after the first — memory replaces collisions.
- **Consequence** ➔ switched Ethernet uses almost ALL available bandwidth simultaneously (A→B while C→D).
- **Multi-switch LANs** ➔ tables map MACs to the socket *toward* them — possibly another switch's uplink.

### 2. Switch vs Router (lecture table)
| | Switch | Router |
| :-- | :-- | :-- |
| connects | devices within one LAN | different LANs |
| address used | MAC | IP |
| delivery | direct to destination device | to destination device or next network |
| table | learned automatically from traffic | needs configuration / routing protocols |

### 3. LAN Design (best practice)
- **Standard kit** ➔ switched 1000BASE-T + Cat 6/6a (10 Gbps upgrade path); optic fibre where traffic is extreme or future-proofing pays.
- **Throughput thinking** ➔ find the **bottleneck** (congestion point ⟹ dropped packets); fix by (1) upgrading the standard (new NICs+switches, e.g. 16×100BASE-T + 2×1000BASE-T uplink ports for servers) or (2) **segmentation** — second server NIC, split into two LANs, router between them.

## ⚠️ Common Mistakes
- 💡 **Learning uses SENDER addresses** ➔ the table fills from who *talks*, not who is talked to; silent devices stay unknown and keep being flooded.
- 💡 **Switch ≠ hub despite looks** ➔ hub repeats blindly (one collision domain); switch forwards selectively (no collisions) — the W7↔W8 contrast question.
- 💡 **No collisions ≠ no queuing** ➔ two frames to one destination still serialise; store-and-forward hides it, latency shows it.

## 🧠 Active Recall
> [!FAQ]- A frame from A (socket 0) to new device D arrives at a fresh switch. Trace table growth over A→D, D→A, A→D again.
> > [!SUCCESS]- Answer
> > - **Short answer:** A→D: learn A=0, flood; D→A (say socket 3): learn D=3, deliver direct to 0; A→D: both known — direct to 3.
> > - **Why:** **Symmetric traffic teaches fastest** ➔ each direction's first frame registers its sender; two exchanges complete the pair.

> [!FAQ]- Your file server saturates its link on a 100BASE-T switched LAN. Give both remedies from the design lecture with their costs.
> > [!SUCCESS]- Answer
> > - **Short answer:** Upgrade the path (gigabit uplink ports/NIC/cabling to the server) or segment (second NIC / split LANs joined by a router) to parallelise paths.
> > - **Why:** **Bottleneck relief, not average speed** ➔ throughput rises by widening or multiplying the congested link only.
