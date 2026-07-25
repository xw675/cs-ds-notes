---
unit: FIT1047
week: 6
parent: "[[FIT1047_MOC]]"
tags: [CS/Networks]
aliases: [LAN, WAN, Clients and Servers, Transmission Rate]
---
# [[Computer Networks (Components and Types)]]

**Context:** [[FIT1047_MOC]] · the networks half begins (LO5–6) · vocabulary + the one calculation that recurs: transfer time from data size ÷ rate

> [!abstract] Quick Revision
> - **🎯 Objective:** four components ➔ **client** (user access) · **server** (stores data/software for clients) · **switch** (connects computers within a LAN) · **router** (connects two or more networks).
> - **⚡ Key Constraint:** transfer-time arithmetic — mind **GByte vs Gbit** ($\times 8$) and the unit ladder M→G→T.

## 📝 Core
- **Network types by reach** ➔ **LAN** (room/building; clients+servers sharing a circuit) → **BN** backbone (< few km; high-speed LAN interconnect) → **MAN** (> few km, across locations) → **WAN** (same idea, longer distances).
- **The Internet** ➔ a *network of networks* — millions of networks, billions of devices, glued by one standard protocol set ([[Internet Model (Layers, Protocols, Encapsulation)]]).
- **Key metric** ➔ data transmission rate in bits/second: ~1 Mbps home upload · 50–500 Mbps WLAN · 1 Gbps LAN · 10 Gbps backbone · Tbps optical fibre.

## 📊 Applied Exercise — lecture calculation (50 GB movie)
$$
\begin{aligned}
50 \text{ GByte} &= 400 \text{ Gbit} = 400\,000 \text{ Mbit} \\
\text{ADSL } 1 \text{ Mbps} &: 400\,000 \text{ s} \approx 4\text{ d }15\text{ h} \\
\text{NBN } 50 \text{ Mbps} &: 8\,000 \text{ s} \approx 2\text{ h }13\text{ m} \qquad
\text{LAN } 1 \text{ Gbps} : 400 \text{ s} = 6\text{ m }40\text{ s}
\end{aligned}
$$

## ⚠️ Common Mistakes
- 💡 **Bytes ≠ bits** ➔ rates are in *bits*/s, file sizes in *bytes* — forgetting ×8 is the classic mark-loss.
- 💡 **Switch vs router** ➔ switch joins computers *inside* one LAN; router joins *networks* — the boundary word decides.

## 🧠 Active Recall
> [!FAQ]- Define the four network components and place them in the LAN/BN/MAN/WAN ladder.
> > [!SUCCESS]- Answer
> > - **Short answer:** Client = user access; server = shared data/software; switch = intra-LAN connector; router = inter-network connector; reach ladder LAN → BN → MAN → WAN by distance.
> > - **Why:** **Internet = network of networks** ➔ routers are precisely the glue points between the ladder's rungs.

> [!FAQ]- How long does a 10 GB file take at 100 Mbps? Show the unit chain.
> > [!SUCCESS]- Answer
> > - **Short answer:** $10$ GB $= 80$ Gbit $= 80\,000$ Mbit ÷ $100$ Mbps $= 800$ s ≈ $13$ min $20$ s.
> > - **Why:** **bits ÷ bits/s** ➔ convert bytes→bits first, then divide by the rate; keep units visible at every step.
