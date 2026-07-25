---
unit: FIT1047
week: 6
parent: "[[Computer Networks (Components and Types)]]"
tags: [CS/Networks]
aliases: [Internet Model, Five Layers, Protocols, Encapsulation, PDU]
---
# [[Internet Model (Layers, Protocols, Encapsulation)]]

**Context:** [[FIT1047_MOC]] · THE framework of the networks half — every later protocol slots into one of these five layers · abstraction, same trick as [[Operating Systems and Multi-Processing|the OS]]

> [!abstract] Quick Revision
> - **🎯 Objective:** five layers, each with a job, an **interface** to the layer above/below, and a **protocol** to its peer on the other machine.
> - **📦 Core Components:** Application → Transport → Network → Data Link → Physical, each wrapping the message in its own PDU.
> - **⚡ Key Constraint:** protocols run HORIZONTALLY (peer layer ↔ peer layer), interfaces run VERTICALLY (layer ↔ adjacent layer) — mixing these up breaks every layer question.

## 📝 Core
### The Five Layers (Internet model)
| Layer | Job (lecture phrasing) | PDU | Example protocol |
| :-- | :-- | :-- | :-- |
| Application | manage user data | **Message** | HTTP ([[World Wide Web (HTTP and HTML)]]) |
| Transport | break into packets, make sure they arrive | **Segment** | TCP |
| Network | where should packets go? (routing) | **Packet** | IP |
| Data Link | computer-to-computer (one hop) | **Frame** | Ethernet |
| Physical | cables, Wi-Fi, fibre | **Bit** | — |

- **Why layers** ➔ wildly diverse hardware/software must interoperate ⟹ hierarchical abstraction with well-defined tasks + interfaces — "typical software engineering".
- **Encapsulation** ➔ going down the stack, each layer wraps the upper layer's PDU and adds its own header: Message → Segment → Packet → Frame → Bits; unwrapped in reverse on arrival.
- **Who climbs how high** ➔ end hosts run all five layers; a **switch** operates up to Data Link; a **router** up to Network — that's *why* routers can join different link technologies (Ethernet, fibre, ADSL, Wi-Fi).

## ⚠️ Common Mistakes
- 💡 **Protocol vs interface** ➔ protocol = peer-to-peer language across machines; interface = the service boundary between adjacent layers on ONE machine.
- 💡 **PDU names are per-layer** ➔ segment/packet/frame aren't synonyms; the exam asks exactly which layer calls it what.
- 💡 **Routers don't read Transport headers** ➔ a device only unwraps as far as its top layer.

## 🧠 Active Recall
> [!FAQ]- Trace a YouTube request from the browser down the stack and across a router — naming each PDU and where unwrapping stops.
> > [!SUCCESS]- Answer
> > - **Short answer:** HTTP Message → TCP Segment → IP Packet → Ethernet Frame → bits; the router unwraps to the Packet (Network layer), re-wraps in a NEW frame for the next link technology.
> > - **Why:** **Per-hop re-framing** ➔ Data Link is hop-scoped, Network is end-to-end — precisely the layer split's purpose.

> [!FAQ]- Why does the layered model let Wi-Fi, ADSL, Ethernet and fibre coexist in one connection?
> > [!SUCCESS]- Answer
> > - **Short answer:** Layers above Data Link never see link technology; each hop swaps the frame type while Packet and above pass through unchanged.
> > - **Why:** **Abstraction boundary** ➔ interfaces isolate change — swap a layer's implementation without touching the others.
