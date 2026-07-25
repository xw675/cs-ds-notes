---
unit: FIT1047
week: 8
parent: "[[WiFi (802.11, CSMA-CA, Topologies)]]"
tags: [CS/Networks, CS/Security]
aliases: [WEP, WPA2, Open WiFi, 802.11i]
---
# [[WiFi Security (WEP, WPA2)]]

**Context:** [[FIT1047_MOC]] · why radio changes the security game — and the data-link-layer encryption ladder · first taste of the security half (SSL/TLS, VPN in later lectures)

> [!abstract] Quick Revision
> - **🎯 Objective:** radio leaves the building ⟹ you cannot restrict the physical layer ⟹ encrypt at the data link layer (or higher).
> - **📦 Core Components:** open WiFi (capture-anything demo) ➔ WEP (shared static key — broken) ➔ WPA/WPA2 (802.11i: per-packet keys, AES, PSK vs Enterprise).
> - **⚡ Key Constraint:** browser-login hotspots are still **open WiFi** — the web login is application-layer; every frame remains capturable in the air.

## 📝 Core
- **The threat** ➔ radio penetrates walls and leaves the campus; thicker walls and directional antennas don't fix it (visitors exist) ⟹ eavesdropping is trivial by design.
- **Open WiFi** ➔ no authentication, no encryption; the lecture demo captures another user's traffic without any login — hotspot users must bring their own protection (VPN, TLS-encrypted services).
- **Defence principle** ➔ if the physical layer can't be restricted, encrypt above it: data link layer (this note) or network/transport/application layers (VPN, SSL/TLS — later lectures).
- **WEP** ➔ *Wired Equivalent Privacy*: one shared static key (40/128-bit) between NIC and AP encrypting everything — **very easy to crack**; historical only.
- **WPA/WPA2 (802.11i)** ➔ longer keys, **changed per packet**, strong AES encryption; two modes — **PSK** (pre-shared key, personal) and **Enterprise (802.1X)** with an authentication server. Still breakable, especially PSK with weak passwords.

## ⚖️ Core Decision Matrix
| | Open | WEP | WPA2-PSK | WPA2-Enterprise |
| :-- | :-- | :-- | :-- | :-- |
| authentication | none | shared key | pre-shared key | 802.1X auth server |
| encryption | none | static key (40/128-bit) | AES, per-packet keys | AES, per-packet keys |
| security | zero — capture at will | broken in minutes | good unless weak password | strongest of the four |

## ⚠️ Common Mistakes
- 💡 **"Login page" ≠ secure** ➔ captive-portal hotspots authenticate at the application layer; the radio frames stay unencrypted — classic exam trap.
- 💡 **WEP's flaw is the STATIC shared key** ➔ every frame under one unchanging key gives cryptanalysis unlimited samples; WPA2's per-packet keys remove exactly that.
- 💡 **PSK strength = password strength** ➔ AES doesn't save a guessable passphrase; Enterprise moves trust to a server instead.

## 🧠 Active Recall
> [!FAQ]- Why can't WiFi security be solved the way wired LAN security is (control the sockets)?
> > [!SUCCESS]- Answer
> > - **Short answer:** The wired physical layer is access-controlled by walls and sockets; radio waves ignore both ⟹ anyone in range owns layer 1, so protection must move up to encryption.
> > - **Why:** **Layer substitution** ➔ WEP/WPA re-create the "wire's" privacy at layer 2 — the name *Wired Equivalent Privacy* states the design goal.

> [!FAQ]- Rank open / WEP / WPA2-PSK / WPA2-Enterprise and justify each step up.
> > [!SUCCESS]- Answer
> > - **Short answer:** Open (nothing) < WEP (static shared key, crackable) < WPA2-PSK (AES + per-packet keys, password-limited) < WPA2-Enterprise (adds per-user 802.1X authentication).
> > - **Why:** **Key management is the ladder** ➔ each step improves how keys are issued, rotated and authenticated, not just the cipher.
