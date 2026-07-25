---
unit: FIT1047
week: 9
parent: "[[Computer Networks (Components and Types)]]"
tags: [CS/Networks, CS/Internet]
aliases: [network of networks, ISP, Autonomous System, AS, BGP, border router, IXP, Internet Exchange Point, peering, transit, Tier 1 ISP, RIR, APNIC, ICANN, IETF, ISOC, Internet governance]
---
# [[Internet Structure and Governance]]

**Context:** [[FIT1047_MOC]] · the Internet as a **network of networks** — how independent networks interconnect and who sets the rules · extends [[Network Layer (Routing and Routing Tables)|routing]] to the inter-network scale

> [!abstract] Quick Revision
> - **🎯 Objective:** the Internet = interconnected **Autonomous Systems** (mostly ISPs) that exchange traffic via **border routers** running **BGP** ➔ decentralised, no single owner.
> - **⚡ Key Constraint:** distinguish **interior** routing (inside one AS: RIP/OSPF/EIGRP, admin's choice) from **exterior** routing (**between** ASes: BGP only) — and **peering** (free, mutual) from **transit** (paid, smaller→larger ISP).

## 📝 Core
- **Network of networks** ➔ no central Internet; each participating network is owned/run by an organisation (ISP LANs, backbones), interconnected.
- **ISP (Internet Service Provider)** ➔ operates a network and sells access to end users (via [[Internet Access Technologies|NBN/ADSL/4G]]) or dedicated links; an ISP's network is **usually one Autonomous System**.
- **Autonomous System (AS)** ➔ a collection of IP networks + routers under **one organisation** with a **unique AS Number (ASN)**; the Internet is a network **of ASes**.
- **Border routers** ➔ connect one AS to another; enforce **traffic policy** (which networks' traffic to accept) and speak **BGP (Border Gateway Protocol)** — the single **exterior** routing protocol.
- **Interior vs exterior** ➔ **inside** an AS, admins pick any **interior** protocol (**RIP, OSPF, EIGRP**); **between** ASes, only **BGP** — see [[Network Layer (Routing and Routing Tables)]].
- **ASN allocation** ➔ ASNs (and IP ranges) are handed out by a **Regional Internet Registry (RIR)** — e.g. **APNIC** for Asia-Pacific.

## 🔀 How ISPs interconnect
- **Tiers** ➔ **Tier-1** = huge global WANs; **Tier-2/3** are smaller and buy upward. **Smaller ISP routes via a larger ISP.**
- **Transit** ➔ a smaller AS **pays** a transit provider (higher-tier ISP) for access to its infrastructure and the broader Internet. Tier-1s **charge** smaller ISPs to carry their traffic.
- **Peering** ➔ two ISPs agree to **accept each other's traffic without charge** (usually when similar size / similar traffic); **bilateral** or **multilateral** via an IXP.
- **IXP (Internet Exchange Point)** ➔ shared hardware (racks of high-speed switches + fibre) where many ISPs physically interconnect; often owned by a **consortium** of ISPs.

## 🏛️ Governance — *no single organisation governs the Internet*
- **ISOC (Internet Society)** ➔ umbrella for **IAB** (Architecture Board), **IETF** (Engineering Task Force — the standards/RFCs), **IESG** (steering), **IRTF** (research).
- **ICANN** ➔ Internet Corporation for Assigned Names and Numbers — manages **IP addresses and host names** (DNS root).
- **IGF** ➔ Internet Governance Forum — annual multi-stakeholder meetings.
- **ITU** ➔ International Telecommunication Union — mostly **hardware standards** (e.g. DSL).

## ⚠️ Common Mistakes
- 💡 **BGP is exterior-only** ➔ RIP/OSPF/EIGRP route *inside* an AS; **BGP** routes *between* ASes. Naming an interior protocol for inter-AS routing loses the mark.
- 💡 **Peering ≠ transit** ➔ **peering** is settlement-free and mutual; **transit** is a paid customer→provider relationship. Similar-sized ISPs peer; small ISPs buy transit.
- 💡 **"Who owns the Internet?"** ➔ *no one* — ASes are individually owned; standards come from many bodies (ISOC/IETF, ICANN, ITU…), not a single governor.

## 🧠 Active Recall
> [!FAQ]- Why do two Tier-1 ISPs peer for free while a small ISP pays for transit?
> > [!SUCCESS]- Answer
> > - **Short answer:** peering is worthwhile when both parties exchange **roughly equal** traffic, so settlement-free swapping benefits both; a small ISP sends/receives far less and **depends on** the larger network, so it buys **transit** to reach the rest of the Internet.
> > - **Why:** **Reciprocity vs dependence** ➔ peers connect as equals at an **IXP** (no charge); transit is an asymmetric customer→provider link (paid), reflecting who needs whom.
