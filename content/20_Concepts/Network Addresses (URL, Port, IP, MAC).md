---
unit: FIT1047
domain: F
week: 7
parent: "[[Internet Model (Layers, Protocols, Encapsulation)]]"
tags: [CS/Networks]
aliases: [IP Address, MAC Address, Port Numbers, IPv6, Subnet Mask]
---
# [[Network Addresses (URL, Port, IP, MAC)]]

**Context:** [[FIT1047_MOC]] · one address type per layer — the table that organises half the networks exam · resolution between them in [[Address Resolution (DNS and ARP)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** URL (application) ➔ port (transport) ➔ IP (network) ➔ MAC (data link) — identity at each layer; an address identifies but does NOT route by itself.
> - **⚡ Key Constraint:** IPv4 structure — $130.194.66.43/26$ means first 26 bits = network+subnet, last 6 = host ⟹ same-subnet test by prefix comparison.

## ⚖️ Core Decision Matrix — one address per layer
| Layer | Address | Example | Identifies |
| :-- | :-- | :-- | :-- |
| Application | URL | `http://www.monash.edu` | a resource |
| Transport | port | $80$ (HTTP), $25$ (SMTP) | the application on a host |
| Network | IP | $130.194.66.43$ | a device across networks |
| Data Link | MAC | `00:23:ae:e7:52:85` | an interface within a LAN |

## 📝 Core
### IPv4
- **32 bits, dotted decimal** ➔ each dot-group = one byte: $130.194.66.43 = 10000010\,11000010\,01000010\,00101011$.
- **Hierarchy** ➔ network (e.g. Monash) | subnet (a LAN) | host — the split point given by the **subnet mask**: $/26$ ≡ $255.255.255.192$ (26 prefix bits, $2^6{-}2$-ish hosts).
- **Why hierarchy** ➔ a device can *see immediately* whether a destination shares its subnet (deliver directly) or not (send to the [[Network Layer (Routing and Routing Tables)|router]]).
- **Exhaustion** ➔ $2^{32} \approx 4.3$ billion, roughly half practically usable — new IPv4 blocks are gone.

### IPv6
- **128 bits** ➔ $2^{128} \approx 3.4 \times 10^{38}$ addresses — not $4\times$ IPv4 but astronomically more.
- **Deliberately "excessive"** ➔ the space buys clean hierarchy: IANA+RIR $/23$–$/32$ → ISP (9 bits) → organisation (16 bits, $/48$) → subnet (16 bits, $/64$) → interface ID (64 bits) ⟹ every organisation gets $>65{,}000$ LANs, assignment stays simple.

### Ports (application addressing)
- **Why** ➔ several browser windows share one IP; the port pairs each response with its connection.
- **Convention** ➔ **server ports fixed** ($80$ HTTP, $25$ SMTP), **client ports random**, one per connection ($57017, 57018, \dots$) — a connection is the 4-tuple (src IP:port, dst IP:port).

## ⚠️ Common Mistakes
- 💡 **Address ≠ route** ➔ knowing $216.58.220.99$ says nothing about how to reach it — that's routing/resolution's job.
- 💡 **$/26$ arithmetic** ➔ mask counts PREFIX bits; hosts get $32-26=6$ bits — reading it backwards wrecks subnet questions.
- 💡 **MAC is LAN-scoped** ➔ frames use MACs only within one subnet; crossing a router swaps frames (and MACs), never the IP.

## 🧠 Active Recall
> [!FAQ]- For $130.194.66.43/26$: give the binary, the subnet mask in dotted decimal, and how a peer decides if it's in the same subnet.
> > [!SUCCESS]- Answer
> > - **Short answer:** Mask $= 255.255.255.192$; compare the first 26 bits of both addresses — equal prefixes ⟹ same subnet ⟹ direct delivery, else ⟹ router.
> > - **Why:** **Prefix routing** ➔ hierarchical addresses make the local/remote decision a single masked comparison.

> [!FAQ]- Two browser tabs both fetch from port 80 of the same server — why don't the responses mix?
> > [!SUCCESS]- Answer
> > - **Short answer:** Each tab's connection uses a distinct random client port; the 4-tuple disambiguates.
> > - **Why:** **Transport-layer identity** ➔ ports address *applications/connections*, IP only addresses the machine.
