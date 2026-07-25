---
unit: FIT1047
week: 7
parent: "[[Internet Model (Layers, Protocols, Encapsulation)]]"
tags: [CS/Networks]
aliases: [Routing, Routing Tables, RIP, OSPF, Default Gateway]
---
# [[Network Layer (Routing and Routing Tables)]]

**Context:** [[FIT1047_MOC]] · how packets cross the network-of-networks — table lookups hop by hop · subnet membership decided in [[Network Addresses (URL, Port, IP, MAC)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** per packet: read destination IP → routing table → next router (or direct delivery) → else **default gateway** → else unroutable.
> - **📦 Core Components:** subnets ➔ routers (layer-3, one IP per interface) ➔ routing tables ➔ static vs dynamic (distance vector vs link state).
> - **⚡ Key Constraint:** distance vector (share *routing tables*, pick fewest hops — RIP) vs link state (share *connectivity/link quality*, pick fastest path — OSPF).

## 📝 Core
- **Subnet recap** ➔ all devices directly connected, sharing an address prefix ($/26$ etc.); in-subnet traffic goes direct, anything else goes to a router.
- **Routers** ➔ THE Internet infrastructure: layer-3 devices, one IP address per interface (≈ per connected subnet); forward by destination IP.
- **Table lookup per packet** ➔ destination in table? → forward to listed next router or deliver directly · not in table? → **default gateway** · no gateway? → packet unroutable.
- **Static routing** ➔ tables hand-written by the network manager; fine for small, stable networks.
- **Dynamic routing** ➔ routers exchange information and converge on tables themselves.
- **Distance vector** ➔ exchange distance-to-destination info, choose SHORTEST (hop count): **RIP** (max 15 hops — loop guard; whole-table updates; slow convergence ⟹ small networks), EIGRP, **BGP**.
- **Link state** ➔ exchange full connectivity + link-quality info, choose FASTEST route by metric (usually link speed): **OSPF**.

## 📊 Exam Execution Trace — lecture topology (routers A…K)
A packet for H arriving at router with table {H → G}: forwarded to G; G's table {H → H}: delivered. A destination absent from the table follows `default → C`; if C also lacks both entry and gateway, the packet dies. **Method:** at every router, ONE lookup, ONE hop decision — never a full path plan.

## ⚖️ Core Decision Matrix
| | distance vector | link state |
| :-- | :-- | :-- |
| exchanges | its routing table (distances) | connectivity + link quality of known network |
| optimises | fewest hops | fastest links |
| protocols | RIP (≤15 hops), EIGRP, BGP | OSPF |
| scale | small networks (RIP) | larger, faster convergence |

## ⚠️ Common Mistakes
- 💡 **Routers plan one hop, not the path** ➔ each router only knows "next router for this destination"; end-to-end routes emerge, they aren't computed anywhere.
- 💡 **RIP's 15-hop cap is a feature** ➔ it bounds count-to-infinity loops, and simultaneously confines RIP to small networks.
- 💡 **Shortest ≠ fastest** ➔ two hops over fibre beat one hop over ADSL; that's the whole link-state argument.

## 🧠 Active Recall
> [!FAQ]- A router receives a packet for an IP absent from its table. Walk the decision chain.
> > [!SUCCESS]- Answer
> > - **Short answer:** Table miss → forward to the configured default gateway; no default gateway → the packet cannot be routed (dropped).
> > - **Why:** **Default as aggregate** ➔ the gateway entry stands for "everything I don't know" — the reason edge routers survive with tiny tables.

> [!FAQ]- Contrast what RIP and OSPF routers actually SEND each other, and what each optimises.
> > [!SUCCESS]- Answer
> > - **Short answer:** RIP sends its whole routing table (distances in hops) → shortest hop-count wins; OSPF sends link-state (who's connected, link speeds) → fastest metric path wins.
> > - **Why:** **Information richness** ➔ knowing the map (link state) lets each router compute better routes than knowing neighbours' summaries (distance vector).
