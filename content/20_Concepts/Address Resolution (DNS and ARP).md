---
unit: FIT1047
week: 7
parent: "[[Network Addresses (URL, Port, IP, MAC)]]"
tags: [CS/Networks]
aliases: [DNS, ARP, Iterative Lookup, Recursive Lookup]
---
# [[Address Resolution (DNS and ARP)]]

**Context:** [[FIT1047_MOC]] · translating BETWEEN the layer addresses — name→IP (DNS, application layer) and IP→MAC (ARP, data link layer) · addresses themselves in [[Network Addresses (URL, Port, IP, MAC)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** browsing `www.google.com.au` needs TWO resolutions ➔ DNS turns the name into $216.58.220.99$; at the destination LAN, ARP turns that IP into the MAC for frame delivery.
> - **⚡ Key Constraint:** iterative vs recursive DNS — WHO does the walking: the client (iterative, servers answer "ask X next") or the DNS server (recursive, often with ISP caching).

## 📝 Core
### DNS (Domain Name System) — name → IP
- **What** ➔ application-layer protocol over a **distributed database** of names; servers arranged in a hierarchy mirroring domain structure: root zone → TLD (`.au`, `.com`, `.edu`) → organisation (`monash`, `unimelb`) → host.
- **Iterative lookup** ➔ client asks root → "ask `.au`" → client asks TLD → "ask `edns-396.unimelb.edu.au`" → client asks that server → gets $124.47.170.46$ — the CLIENT follows each referral.
- **Recursive lookup** ➔ client asks one server (typically the ISP's) which does the whole walk itself and returns the final answer — enabling the **ISP cache** that answers repeat queries instantly.

### ARP (Address Resolution Protocol) — IP → MAC
- **The last-hop problem** ➔ the destination LAN's router holds a packet for $1.2.3.5$ but frames need a MAC.
- **Mechanism** ➔ **broadcast** "Who has $1.2.3.5$?" to the whole LAN; the owner replies with its MAC (`00:23:ae:e7:52:85`); sender frames and delivers.

## ⚖️ Core Decision Matrix
| | DNS | ARP |
| :-- | :-- | :-- |
| maps | domain name → IP | IP → MAC |
| layer | Application | Data Link |
| scope | global, hierarchical servers | one LAN, broadcast |
| caching | ISP/OS caches answers | per-host ARP cache |

## ⚠️ Common Mistakes
- 💡 **Two resolutions per page view** ➔ DNS once (name→IP), ARP at every LAN hop's end (IP→MAC) — answers claiming one mechanism does both lose the mark.
- 💡 **ARP is broadcast by necessity** ➔ you can't unicast to a MAC you don't yet know; the question IS the discovery.
- 💡 **Iterative ≠ recursive by answer quality** ➔ both end with the same IP; they differ in who performs the chain (client vs server).

## 🧠 Active Recall
> [!FAQ]- Trace every resolution step from typing `www.unimelb.edu.au` to the first frame arriving at the web server.
> > [!SUCCESS]- Answer
> > - **Short answer:** DNS (iterative: root → `.au` TLD → unimelb's server, or recursive via ISP cache) yields $124.47.170.46$ → packet routes there → destination router ARP-broadcasts "who has $124.47.170.46$?" → server replies with its MAC → frame delivered.
> > - **Why:** **Each layer resolves one hop of identity** ➔ names are for humans, IPs for global routing, MACs for local delivery.

> [!FAQ]- Why does the recursive model dominate consumer internet?
> > [!SUCCESS]- Answer
> > - **Short answer:** The ISP's resolver does the walking once and caches; thousands of customers reuse the answer with zero upstream queries.
> > - **Why:** **Shared cache economics** ➔ popular names hit cache almost always, cutting latency and root/TLD load.
