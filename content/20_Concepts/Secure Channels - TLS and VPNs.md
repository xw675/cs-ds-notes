---
unit: FIT1047
week: 10
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security, CS/Networks, CS/Cryptography, Monash/CS_DS]
aliases: [TLS, SSL, HTTPS, Transport Layer Security, TLS handshake, TLS record, VPN, virtual private network, tunnel, IPSec, OpenVPN, WireGuard]
---
# [[Secure Channels - TLS and VPNs]]

**Context:** [[Information Security and Cryptography]] · two applied protocols that assemble the primitives into a **secure channel** · TLS = per-connection layer; VPN = network-level tunnel

> [!abstract] Quick Revision
> - **🎯 Objective:** combine [[Key Establishment and Diffie-Hellman|DH]] + [[Authentication, Certificates and PKI|certificates]] + [[Symmetric Cryptography|AES]] into a channel with **confidentiality + integrity + authenticity** ➔ **TLS** for a connection, **VPN** for a whole network path.
> - **⚡ Key Constraint:** both only secure **endpoint-to-endpoint** — TLS protects a connection (often **only the server** is authenticated); a **VPN** leaves traffic **in the clear beyond the tunnel endpoint**.

## 🌐 TLS — Transport Layer Security
- **Placement** ➔ a **security layer between TCP and the application** → **HTTPS = HTTP over TLS**; also protects Mail and other protocols, not just HTTP.
- **History** ➔ Netscape **SSL** → SSL 2.0 (1995) → SSL 3.0 (1996) → IETF **TLS 1.0** (RFC 5246, 1999) → current **TLS 1.3** (RFC 8446); all older versions should be **disabled**.
- **Goal** ➔ establish a **shared key** for **symmetric** encryption (confidentiality + integrity/authenticity), using **Diffie–Hellman** for the secret.
- **Sub-protocols** ➔
  - **Handshake** ➔ negotiate parameters, **optional authentication** (HTTPS usually authenticates **only the server**), establish shared key → yields a **session ID / session ticket**.
  - **Record** ➔ the actual secure transport; after **ChangeCipherSpec** messages, **all traffic is encrypted**.
  - **Alert** ➔ immediately **closes** a session.

## 🔒 VPN — Virtual Private Networks
- **Definition** ➔ logically connects a client (or network) to a remote network via an **encrypted tunnel** over the public Internet.
- **Properties** ➔ device gets a **different IP** and is **"logically" in the remote network**; the VPN **routes packets** between networks; tunnel protocols: **OpenVPN, WireGuard, IPSec** (+ proprietary).
- **Why use one** ➔ control access to a company network; **circumvent local filters / geo-blocking**; secure encryption + **mutual authentication**; protect the endpoint; reach internal-only resources.

## ⚠️ Common Mistakes
- 💡 **Tunnel ≠ end-to-end** ➔ a VPN secures **only between tunnel endpoints** (client ↔ gateway); traffic **behind** the endpoint (inside the internal network) is **still in clear**.
- 💡 **TLS often authenticates one side** ➔ in typical HTTPS **only the server** presents a certificate; the client is usually unauthenticated at the TLS layer.

## 🧠 Active Recall
> [!FAQ]- A VPN "encrypts your traffic" — is your data therefore encrypted end-to-end to the website you visit?
> > [!SUCCESS]- Answer
> > - **Short answer:** **No** — the VPN encrypts only the **tunnel** from your device to the **VPN gateway**; beyond that endpoint the packets travel onward and may be **in the clear** unless a separate layer (e.g. **TLS/HTTPS**) protects them.
> > - **Why:** **Endpoint-scoped security** ➔ VPN security is defined between tunnel endpoints; genuine end-to-end confidentiality to the site still relies on **TLS** on top of (or instead of) the VPN.
