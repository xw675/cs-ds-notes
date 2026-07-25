---
unit: FIT1047
week: 11
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security, CS/Networks, Monash/CS_DS]
aliases: [firewall, packet filtering, stateful firewall, stateless firewall, network security, packet filter, security rules]
---
# [[Firewalls and Packet Filtering]]

**Context:** [[Information Security and Cryptography]] · "how to separate networks from each other?" · a **barrier** between a more-secure inside and a less-secure outside

> [!abstract] Quick Revision
> - **🎯 Objective:** a firewall is a **barrier that filters (not blocks) traffic** between an internal (more secure) and external (less secure, e.g. Internet) network per **security rules**, in both directions.
> - **⚡ Key Constraint:** basic packet filtering is **stateless** and blind to context/application → it can't stop app-layer attacks, spoofing, or traffic in **encrypted tunnels**, and is useless against **internal** attackers.

## 📝 What a firewall is
- **Barrier, not a wall** ➔ it **filters** traffic; it does **not** completely block it. Without it, devices are **visible and accessible** — and if vulnerable, hackable.
- **Security rules** ➔ define what passes and what is blocked, **in both directions** (in and out).

## 🔎 Packet filtering
- **Basic firewall** ➔ filters packets at the **Network layer (and above)**.
- **Filters on** ➔ **source/destination IP**, **protocol IDs**, **ports**, and (if **stateful**) the **current connection stage**. Uses a **static filtering rule set**.
- **Application detection** ➔ inspects the **first few bytes** of the TCP/UDP header to find the **application protocol + port** (HTTP:80, SMTP:25).
- **Default posture** ➔ **inside→out** usually allowed (e.g. **block SNMP UDP 161/162**); **outside→in** blocked unless **explicitly permitted**; non-conforming packets are **dropped**.

## ⚖️ Trade-offs
| Aspect | Advantage | Disadvantage |
| :--- | :--- | :--- |
| **Deployment** | Runs on routers/computers or as an appliance (e.g. with a **[[Secure Channels - TLS and VPNs\|VPN gateway]]**) | — |
| **Cost/speed** | Very **fast, efficient, cheap**; no user interaction | — |
| **Context** | — | Ignores **context/application processes**; vulnerable to **address spoofing** |
| **State** | — | Basic form is **stateless** → can't spot malicious packet **sequences** |
| **Coverage** | — | Weak if ports are open, traffic is in **encrypted tunnels**, or attacks are **app-layer** |
| **Scope** | — | No help against **internal attackers** or compromised inside devices; bypassed by **mobile/IoT** links |

## ⚠️ Common Mistakes
- 💡 **Filters ≠ blocks** ➔ a firewall selectively **permits** traffic per rules; describing it as "blocking all traffic" misses the point.
- 💡 **Perimeter-only** ➔ once an attacker is **inside** (or a device is compromised, or a phone/IoT link bypasses it), the firewall offers nothing → motivates [[IDS, IPS and Next-Generation Firewalls|IDS/IPS]] and [[Access Control]].

## 🧠 Active Recall
> [!FAQ]- Why can't a basic packet-filtering firewall stop an attack carried inside an HTTPS connection?
> > [!SUCCESS]- Answer
> > - **Short answer:** packet filtering inspects only **headers** (IP/port/protocol) and is **stateless** — the payload of an **encrypted tunnel** is opaque to it, so an app-layer attack over an allowed port (443) passes straight through.
> > - **Why:** **No content/context awareness** ➔ the firewall sees a permitted destination port and valid addresses; detecting the malicious payload needs **application-aware** inspection (an [[IDS, IPS and Next-Generation Firewalls|NGF/IPS]]), which brings its own trade-offs.
