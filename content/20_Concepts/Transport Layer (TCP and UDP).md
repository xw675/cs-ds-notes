---
unit: FIT1047
domain: F
week: 7
parent: "[[Internet Model (Layers, Protocols, Encapsulation)]]"
tags: [CS/Networks]
aliases: [TCP, UDP, Three-Way Handshake, ARQ, Sequence Numbers]
---
# [[Transport Layer (TCP and UDP)]]

**Context:** [[FIT1047_MOC]] · application-to-application communication — ports, segmentation, reliability · the layer that turns "packets may vanish" into "it always looks like a clean pipe"

> [!abstract] Quick Revision
> - **🎯 Objective:** transport identifies applications (ports), splits messages, and — in TCP — repairs the network's unreliability via **ARQ** (seq/ack numbers + retransmit-on-no-ACK).
> - **📦 Core Components:** TCP = connection-oriented + reliable (3-way open, 4-way close) · UDP = connectionless, compact, unreliable.
> - **⚡ Key Constraint:** the two numbers per TCP packet — **sequence** = bytes I've sent so far, **acknowledgement** = bytes I've received — everything (handshakes, loss recovery) is arithmetic on these.

## 📝 Core
### TCP (Transmission Control Protocol)
- **Connection-oriented** ➔ a virtual circuit: to the application it's a point-to-point **full-duplex** pipe; messages split into segments.
- **Reliable** ➔ errors detected/corrected; segments reassembled in order. Used by HTTP, SMTP, IMAP, SSH.
- **ARQ (Automatic Repeat reQuest)** ➔ data link *discards* bad frames and packets can vanish ⟹ receiver sends **ACK**s; sender retransmits anything unacknowledged within the timeout.
- **Open: 3-way handshake** ➔ client SYN (random seq $A$) → server SYN,ACK (ack $A{+}1$, random seq $B$) → client ACK (seq $A{+}1$, ack $B{+}1$).
- **Close: 4-way handshake** ➔ FIN → ACK → FIN → ACK (either side may start; FIN/ACK can combine into 3) — two FINs because **full-duplex**: each direction closes independently.
- **Tuning trade-offs** ➔ send rate (too fast overloads receiver/path) and segment size (too big forces IP fragmentation and raises error odds).

### UDP (User Datagram Protocol)
- **Connectionless** ➔ each datagram independent; arrival, order, and acknowledgement all unguaranteed.
- **Compact** ➔ ~8-byte header, minimal latency overhead — for short notifications, live video, VoIP, where a late retransmission is worthless anyway.

## 📊 Exam Execution Trace — lecture TCP session (seq | ack)
| Client → | ← Server | Phase |
| :-- | :-- | :-- |
| $3185 \mid 0$ SYN | | open |
| | $734 \mid 3186$ SYN, ACK | open |
| $3186 \mid 735$ ACK | | open complete |
| $3186 \mid 735$ "some data" · $3195 \mid 735$ "more data" | $735 \mid 3204$ "thanks!" | full-duplex data |
| | $3204 \mid 742$ ACK … FIN | close begins |
| $3205 \mid 743$ ACK · $742 \mid 3204$ ACK · $742 \mid 3205$ FIN exchange | | 4-way close |
**Read it as:** every ack = the other side's seq + bytes received; gaps ⟹ retransmission.

## ⚖️ Core Decision Matrix
| | TCP | UDP |
| :-- | :-- | :-- |
| connection | virtual circuit (handshakes) | none — independent datagrams |
| reliability | ARQ: ACKs, retransmit, reorder | none |
| overhead | headers + handshakes + state | ~8-byte header |
| fits | web, mail, SSH — completeness matters | streaming, VoIP, notifications — timeliness matters |

## ⚠️ Common Mistakes
- 💡 **Reliability lives HERE, not below** ➔ the data link only *discards* bad frames; TCP is what retransmits — layer-attribution questions hinge on this.
- 💡 **Four-way close because full-duplex** ➔ each direction carries its own FIN; "why not two messages?" is the standard exam probe.
- 💡 **UDP isn't broken TCP** ➔ for live media, retransmitted-late data is useless; unreliability is the correct engineering choice.

## 🧠 Active Recall
> [!FAQ]- Write the 3-way handshake with concrete numbers, starting from client seq $3185$ and server seq $734$.
> > [!SUCCESS]- Answer
> > - **Short answer:** SYN $3185\mid0$ → SYN,ACK $734 \mid 3186$ → ACK $3186 \mid 735$.
> > - **Why:** **Ack = other's seq + 1** ➔ each side proves receipt of the other's opening number, establishing both directions.

> [!FAQ]- A segment is lost mid-transfer. How does TCP notice and recover, and which fields drive it?
> > [!SUCCESS]- Answer
> > - **Short answer:** The receiver's ack number stops advancing; the sender's timeout expires without an ACK covering those bytes → retransmit from the last acknowledged byte.
> > - **Why:** **ARQ via byte counting** ➔ seq/ack are cumulative byte counters, so one number pinpoints exactly where the stream must resume.
