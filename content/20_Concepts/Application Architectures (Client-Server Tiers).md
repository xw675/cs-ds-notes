---
unit: FIT1047
domain: [B, F]
week: 6
parent: "[[Computer Networks (Components and Types)]]"
tags: [CS/Networks, SWE/Design]
aliases: [Client-Server, Thin Client, Multi-Tier, Peer-to-Peer]
---
# [[Application Architectures (Client-Server Tiers)]]

**Context:** [[FIT1047_MOC]] · who does which of the FOUR functions — that single question generates every architecture · echoes tier thinking you'll meet again in [[Von Neumann Architecture and Programs|abstraction]] and later web dev

> [!abstract] Quick Revision
> - **🎯 Objective:** split four functions between client and server ➔ **presentation** (UI) · **application/business logic** (what it does) · **data access** (how data is managed) · **data storage** (where it lives).
> - **⚡ Key Constraint:** each architecture = one particular split; know the split AND its characteristic problem.

## ⚖️ Core Decision Matrix
| Architecture | Client holds | Server holds | Characteristic issue |
| :-- | :-- | :-- | :-- |
| server-based ("dumb" terminal) | — (sends keystrokes) | all four | server bottleneck; lumpy, expensive upgrades |
| client-based | presentation + logic + data access | storage | ALL data travels back and forth |
| client-server | presentation + logic | data access + storage | balanced load — the classic |
| thin client | presentation only | logic + data access + storage | only the server needs updating ✔ |
| multi-tier | presentation | logic on one server tier, data on another | more moving parts, best scaling |
| peer-to-peer | every node holds all four | (no dedicated server) | each computer is client AND server |

## ⚠️ Common Mistakes
- 💡 **"Thin" describes the CLIENT** ➔ thin client = client does presentation only; students invert it under pressure.
- 💡 **P2P isn't serverless magic** ➔ every peer runs server duties locally — data access logic reaching across to other peers' storage.

## 🧠 Active Recall
> [!FAQ]- Name the four application functions and assign them for thin-client vs client-server architectures.
> > [!SUCCESS]- Answer
> > - **Short answer:** Presentation, application/business logic, data access, data storage; thin client keeps only presentation on the client, client-server keeps presentation + logic client-side.
> > - **Why:** **Update economics** ➔ the further logic sits server-side, the fewer machines an upgrade must touch — the thin client's selling point.

> [!FAQ]- Why did "dumb terminal" architectures die, and which of their problems does multi-tier solve?
> > [!SUCCESS]- Answer
> > - **Short answer:** The single server became a bottleneck with lumpy upgrade costs; multi-tier spreads logic and data over separate server tiers that scale independently.
> > - **Why:** **Load distribution** ➔ tiers isolate the scaling dimension that's actually saturated (compute vs storage).
