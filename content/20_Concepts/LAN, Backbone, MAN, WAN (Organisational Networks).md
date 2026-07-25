---
unit: FIT1047
domain: F
week: 8
parent: "[[Computer Networks (Components and Types)]]"
tags: [CS/Networks]
aliases: [Backbone Network, Dedicated Circuits, Metro Ethernet, VPN]
---
# [[LAN, Backbone, MAN, WAN (Organisational Networks)]]

**Context:** [[FIT1047_MOC]] · how an ORGANISATION assembles networks at every scale — deepens the reach ladder from [[Computer Networks (Components and Types)]] with ownership, technology and the WAN buy-vs-lease decision

> [!abstract] Quick Revision
> - **🎯 Objective:** LAN (floor/building, owned, switched Ethernet/WiFi) → backbone (campus, owned, fibre) → MAN/WAN (cities+, **leased** from carriers).
> - **📦 Core Components:** access/distribution/core layer architecture ➔ WAN options: dedicated circuits vs packet-switched carrier vs VPN-over-Internet.
> - **⚡ Key Constraint:** the WAN trade-off triangle — dedicated (guaranteed, dear) vs carrier packet-switched (shared, simpler) vs VPN (cheapest, no guarantees).

## 📝 Core
- **LANs** ➔ switched Ethernet or [[WiFi (802.11, CSMA-CA, Topologies)|WiFi]]; end-user + server access; ≤ ~100 m; fully owned/operated; similar devices grouped.
- **Backbones** ➔ high-speed links BETWEEN LANs (floors, buildings); owned; fibre physical layer + switches/routers; gateway to MANs/WANs/Internet.
- **Hierarchy (lecture architecture)** ➔ floor Ethernet switch (**access layer**) → building distribution switch (**distribution layer**) → precinct switch/router (**core layer**).
- **Why lease WANs** ➔ cables over public land need licences; carriers (Telstra, Optus) amortise them across customers — build-your-own rarely rational.

### The three WAN options
| Option | Mechanism | Properties |
| :-- | :-- | :-- |
| **dedicated circuits** | leased full-duplex point-to-point (T-carrier, SONET, Metro Ethernet), flat monthly fee | guaranteed bandwidth + latency; your routers at each end |
| **packet-switched WAN** | carrier's shared packet network via a point-of-presence (POP) | shares circuits with other customers; increasingly plain Ethernet (no special kit, common expertise) |
| **VPN over Internet** | software "virtual NIC"; packets **encapsulated + encrypted**, tunnelled gateway-to-gateway | available everywhere, cheap, flexible — but NO performance guarantees, slower than dedicated |

- **VPN mechanics** ➔ `Hello!` → VPN gateway encrypts/encapsulates (`$U1&x#3`) → travels the public Internet inside the **tunnel** → far gateway unpacks → delivers into the remote LAN as if local.

## ⚠️ Common Mistakes
- 💡 **MAN ≈ WAN** ➔ the lecture treats them as the same idea at different distances — don't invent extra differences.
- 💡 **"Private" in VPN is cryptographic, not physical** ➔ the bits ride the public Internet; privacy comes from encryption + encapsulation only.
- 💡 **Why not just the Internet?** ➔ the stock answer triple: security, reliability, performance — VPN patches the first, never the last two.

## 🧠 Active Recall
> [!FAQ]- A company connects Melbourne and Penang offices. Walk the three options and what each buys.
> > [!SUCCESS]- Answer
> > - **Short answer:** Dedicated leased circuit (guaranteed bandwidth/latency, highest cost) · carrier packet-switched service via POPs (shared, moderate) · VPN over each office's Internet link (cheapest, zero guarantees).
> > - **Why:** **Pay for certainty** ➔ the options price exactly one thing — how much performance is contractually yours.

> [!FAQ]- Sketch the access/distribution/core hierarchy and place switch vs router at each level.
> > [!SUCCESS]- Answer
> > - **Short answer:** Floor switches (access) → building distribution switches → precinct core switches/routers toward WAN/Internet.
> > - **Why:** **Aggregate then route** ➔ cheap layer-2 fan-out at the edge; layer-3 intelligence concentrated where networks meet ([[Switched Ethernet (Switches, Forwarding, LAN Design)|switch vs router]]).
