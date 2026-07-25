---
unit: FIT1047
domain: F
week: 8
parent: "[[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]]"
tags: [CS/Networks]
aliases: [WiFi, 802.11, CSMA/CA, Hidden Node, BSS, ESS]
---
# [[WiFi (802.11, CSMA-CA, Topologies)]]

**Context:** [[FIT1047_MOC]] · wireless Ethernet (IEEE 802.11) — same layers, harder physics · security split into [[WiFi Security (WEP, WPA2)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** WLAN NICs ↔ **Access Points** ↔ wired LAN; medium is shared radio ⟹ **CSMA/CA** (Avoidance — you often CAN'T detect wireless collisions).
> - **📦 Core Components:** 2.4/5 GHz channels ➔ hidden node problem ➔ stop-and-wait ARQ ➔ BSS → ESS topologies ➔ placement/attenuation.
> - **⚡ Key Constraint:** 2.4 GHz channels are 22 MHz wide but 5 MHz apart ⟹ **only 1, 6, 11 don't overlap** — the neighbour-channel puzzle is a standing exam item.

## 📝 Core
### 1. Basics (802.11)
- **Why WiFi** ➔ no cables (heritage buildings, rentals), flexible access, mobility (hospitals).
- **Standards ladder** ➔ 802.11a/b (1997–99) → g (2003, 54 Mbps) → n (2009) → ac (2013) → ax (2021); 5 GHz standards: more + wider channels (80 vs 20 MHz), up to ~1.73 Gbps, but shorter range ⟹ mesh systems.
- **Frequencies** ➔ 2.4 GHz and/or 5 GHz; higher frequency = more bandwidth but stronger **attenuation** (walls halve signal per 3 dB; worse at 5 GHz).

### 2. CSMA/CA and the Hidden Node
- **CA not CD** ➔ Carrier Sense, Multiple Access, Collision **Avoidance** — contrast Ethernet's Detection ([[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)|802.3]]).
- **Hidden node problem** ➔ two clients both in AP range but out of EACH OTHER's range: neither senses the other ⟹ collisions at the AP that the senders can't detect.
- **Fixes** ➔ **stop-and-wait ARQ** (every frame ACKed before the next) + controlled access via the AP.

### 3. Topologies
- **Independent BSS (ad hoc)** ➔ devices talk directly; rarely used now.
- **Infrastructure BSS** ➔ all traffic via one AP wired into the LAN — the normal case.
- **ESS** ➔ multiple overlapping BSSs; APs forward via the wired distribution system; devices **roam** between APs seeing one layer-2 network. (Roaming *between* ESSs needs higher-layer help, e.g. Mobile IP.)
- **Planning** ➔ tile coverage with minimal overlap, assign non-interfering channels (the 1/6/11 tessellation in the lecture's 150 m × 100 m example).

### 4. Performance rules
- **AP placement** ➔ high/ceiling-mounted, few walls, never in a closet; kill interferers (Bluetooth, microwaves, cordless phones); directional antennas where needed.
- **NEVER put a server on WiFi** ➔ all traffic passes the AP on a shared medium ⟹ a WiFi server DOUBLES the radio traffic and waits between frames; servers belong on wired Ethernet.

## ⚠️ Common Mistakes
- 💡 **Why CA, not CD** ➔ a transmitting radio can't hear a distant collision (hidden node) — detection is physically unreliable, so avoid + ACK instead.
- 💡 **13 channels ≠ 13 usable** ➔ overlap leaves three clean choices at 2.4 GHz (1, 6, 11); adjacent-number channels interfere WORSE than same-channel sharing in some layouts.
- 💡 **5 GHz trade** ➔ faster + cleaner spectrum, but attenuates harder — more APs, not fewer.

## 🧠 Active Recall
> [!FAQ]- Explain the hidden node problem and the two 802.11 countermeasures.
> > [!SUCCESS]- Answer
> > - **Short answer:** Nodes A and C both reach AP B but not each other ⟹ simultaneous sends collide at B undetected; countered by stop-and-wait ARQ (per-frame ACKs expose losses) and AP-controlled access.
> > - **Why:** **Detection needs shared hearing** ➔ CSMA/CD assumes every sender hears every collision — false on radio, hence Avoidance.

> [!FAQ]- Three neighbours run channels 1, 6, 6; you're on 11. Who must move, and to what?
> > [!SUCCESS]- Answer
> > - **Short answer:** One of the channel-6 pair moves — but the only non-overlapping options are 1, 6, 11, all taken ⟹ the two 6s must share, or the mover picks whichever of 1/6/11 is most distant physically.
> > - **Why:** **Three-colour constraint** ➔ 2.4 GHz gives exactly three orthogonal channels; beyond three overlapping cells, sharing is unavoidable — plan geometry, not just numbers.
