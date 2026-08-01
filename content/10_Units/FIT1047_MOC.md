---
unit: FIT1047
type: MOC
tags:
  - 2025/S2
---
# 📘 FIT1047: Introduction to Computer Systems, Networks and Security

> [!INFO] Map of Content
> Index for **FIT1047 (Malaysia campus)**. Hand-execution unit: number conversions, logic circuits, MARIE assembly traces are the assessed skills — every applied note carries a write-from-blank element.

## 📊 Assessment Map
- **Assignment 1 (15%)** ➔ Foundations: Binary Number System (W1) + Boolean Logic Circuit (W2).
- **Assignment 2 (30%)** ➔ Programming Interview: Assembly Programming (W3–4), Computer Architecture (W3–4), Motherboard & Boot (W5), OS (W5).
- **Assignment 3 (30%)** ➔ Networks
- **Assignment 4 (25%)** ➔ Security
- **LO1 (W1–2):** number representations + Boolean algebra → logic circuits · **LO2:** hardware/software architectures · **LO3:** MARIE assembly · **LO4:** OS functions.

## 🧰 Unit Cheatsheet

- 📌 [[FIT1047 Unit Cheatsheet]] —systems → networks → security in one re-read

## 📅 Knowledge Index

### Week 1 — Data Representation (Foundations of Computing)
- [[Computer Fundamentals (Bits, Bytes, Words)]] -> Parent Framework: [[FIT1047_MOC]]
- [[Number Systems (Binary and Hexadecimal)]] -> Parent Framework: [[Computer Fundamentals (Bits, Bytes, Words)]]
- [[Signed Integer Representation (Two's Complement)]] -> Parent Framework: [[Number Systems (Binary and Hexadecimal)]]
- [[Floating Point Numbers (IEEE 754)]] -> Parent Framework: [[Number Systems (Binary and Hexadecimal)]]
- [[Text Encoding (ASCII and Unicode)]] -> Parent Framework: [[Computer Fundamentals (Bits, Bytes, Words)]]
- [[Transistors and Logic Gates]] -> Parent Framework: [[Computer Fundamentals (Bits, Bytes, Words)]]

### Week 2 — Boolean Logic & Circuits
- [[Boolean Algebra Laws]] -> Parent Framework: [[Logical Connectives]] *(Smart Merged: FIT1058 logic + FIT1047 circuit notation, precedence, why-simplify)*
- [[Sum-of-Products (Functions to Circuits)]] -> Parent Framework: [[Boolean Algebra Laws]]
- [[Karnaugh Maps]] -> Parent Framework: [[Sum-of-Products (Functions to Circuits)]]
- [[Transistors and Logic Gates]] -> Parent Framework: [[Computer Fundamentals (Bits, Bytes, Words)]] *(extended in Week 2: NAND + universal gates)*

### Week 3 — Circuits with Memory, Architecture & MARIE
- [[Combinational Circuits (Adders, Decoders, MUX, ALU)]] -> Parent Framework: [[Transistors and Logic Gates]]
- [[Sequential Circuits (Latches, Flip-Flops, Registers)]] -> Parent Framework: [[Combinational Circuits (Adders, Decoders, MUX, ALU)]]
- [[Von Neumann Architecture and Programs]] -> Parent Framework: [[Computer Fundamentals (Bits, Bytes, Words)]]
- [[Fetch-Decode-Execute and RTL (Control)]] -> Parent Framework: [[Von Neumann Architecture and Programs]]
- [[MARIE Assembly (Instruction Set and Patterns)]] -> Parent Framework: [[Von Neumann Architecture and Programs]]

### Week 4 — Indirect Addressing, Subroutines & Memory
- [[MARIE Assembly (Instruction Set and Patterns)]] -> Parent Framework: [[Von Neumann Architecture and Programs]] *(extended in Week 4: LoadI/StoreI/AddI/JnS/JumpI + Adr/HEX directives)*
- [[MARIE Patterns (Indirect Addressing, Arrays, Subroutines)]] -> Parent Framework: [[MARIE Assembly (Instruction Set and Patterns)]]
- [[Memory and the Memory Hierarchy]] -> Parent Framework: [[Von Neumann Architecture and Programs]]

### Week 5 — Motherboard, I/O, Boot & Operating Systems (A2 material complete)
- [[Motherboard and IO Interfaces]] -> Parent Framework: [[Von Neumann Architecture and Programs]]
- [[CPU-IO Communication (Memory-Mapped, Polling, Interrupts, DMA)]] -> Parent Framework: [[Motherboard and IO Interfaces]]
- [[The Boot Process]] -> Parent Framework: [[Motherboard and IO Interfaces]]
- [[Operating Systems and Multi-Processing]] -> Parent Framework: [[Von Neumann Architecture and Programs]]
- [[Virtual Memory (MMU and Paging)]] -> Parent Framework: [[Operating Systems and Multi-Processing]]

### Week 6 — Networks I: Layers & Application Protocols (LO5–6 begin)
- [[Computer Networks (Components and Types)]] -> Parent Framework: [[FIT1047_MOC]]
- [[Internet Model (Layers, Protocols, Encapsulation)]] -> Parent Framework: [[Computer Networks (Components and Types)]]
- [[Application Architectures (Client-Server Tiers)]] -> Parent Framework: [[Computer Networks (Components and Types)]]
- [[World Wide Web (HTTP and HTML)]] -> Parent Framework: [[Internet Model (Layers, Protocols, Encapsulation)]]
- [[Electronic Mail (SMTP, POP, IMAP, MIME)]] -> Parent Framework: [[Internet Model (Layers, Protocols, Encapsulation)]]

### Week 7 — Networks II: The Four Lower Layers & Addressing
- [[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]] -> Parent Framework: [[Internet Model (Layers, Protocols, Encapsulation)]]
- [[Network Addresses (URL, Port, IP, MAC)]] -> Parent Framework: [[Internet Model (Layers, Protocols, Encapsulation)]]
- [[Address Resolution (DNS and ARP)]] -> Parent Framework: [[Network Addresses (URL, Port, IP, MAC)]]
- [[Network Layer (Routing and Routing Tables)]] -> Parent Framework: [[Internet Model (Layers, Protocols, Encapsulation)]]
- [[Transport Layer (TCP and UDP)]] -> Parent Framework: [[Internet Model (Layers, Protocols, Encapsulation)]]

### Week 8 — Networks III: Switched Ethernet, WiFi & Organisational Networks
- [[Switched Ethernet (Switches, Forwarding, LAN Design)]] -> Parent Framework: [[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]]
- [[WiFi (802.11, CSMA-CA, Topologies)]] -> Parent Framework: [[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]]
- [[WiFi Security (WEP, WPA2)]] -> Parent Framework: [[WiFi (802.11, CSMA-CA, Topologies)]] *(seeds the security half)*
- [[LAN, Backbone, MAN, WAN (Organisational Networks)]] -> Parent Framework: [[Computer Networks (Components and Types)]]

### Week 9 — The Internet: Structure, Access, Delivery & Society
- [[Internet Structure and Governance]] -> Parent Framework: [[Computer Networks (Components and Types)]]  *(AS, BGP, IXP, peering/transit, governance)*
- [[Internet Access Technologies]] -> Parent Framework: [[Internet Structure and Governance]]
- [[CDNs, Load Balancing and Caching]] -> Parent Framework: [[Internet Structure and Governance]]
- [[Internet of Things (IoT)]] -> Parent Framework: [[Internet Structure and Governance]]
- [[Net Neutrality and Internet Policy]] -> Parent Framework: [[Internet Structure and Governance]]
- *(Week 7 recap in the workshop — line-coding/modulation — is already covered by [[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]]; interior routing (RIP/OSPF) by [[Network Layer (Routing and Routing Tables)]].)*

### Week 10 — Security I: Cryptography & Secure-Channel Protocols (LO7)
- [[Information Security and Cryptography]] -> Parent Framework: [[FIT1047_MOC]]  *(hub: security goals + three algorithm families)*
- [[Symmetric Cryptography]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Public Key Cryptography]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Cryptographic Hash Functions]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Key Establishment and Diffie-Hellman]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Authentication, Certificates and PKI]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Secure Channels - TLS and VPNs]] -> Parent Framework: [[Information Security and Cryptography]]
- *(Cross-links to FIT1058 number theory: [[Diffie-Hellman Key Agreement]], [[Cryptosystem]], [[One-Way Function]], [[Modular Exponentiation]], [[Euler Totient Function]], [[Prime Number]], [[Primitive Root]] — the maths behind RSA/DH lives there, not duplicated here.)*

### Week 11 — Security II: Authentication, Access Control & Network Defence (LO7)
- [[User Authentication and Passwords]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Multi-Factor Authentication and Biometrics]] -> Parent Framework: [[User Authentication and Passwords]]
- [[Access Control]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Firewalls and Packet Filtering]] -> Parent Framework: [[Information Security and Cryptography]]
- [[IDS, IPS and Next-Generation Firewalls]] -> Parent Framework: [[Firewalls and Packet Filtering]]
- *(Cross-links: salted-hash storage → [[Cryptographic Hash Functions]]; login in kernel mode → [[Operating Systems and Multi-Processing]]; NGF TLS-proxy breaks end-to-end → [[Secure Channels - TLS and VPNs]].)*

### Week 12 — Security III: Threats, Vulnerabilities, Risk & Privacy (LO7)
- [[Malware and Attack Types]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Software Vulnerabilities (Injection, XSS, Buffer Overflow)]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Cybersecurity Case Studies]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Cybersecurity Risk Management]] -> Parent Framework: [[Information Security and Cryptography]]
- [[Privacy and Data Protection (FIT1047)]] -> Parent Framework: [[Information Security and Cryptography]]
- *(Cross-links: botnet/DDoS → [[Internet of Things (IoT)]]; buffer overflow return address → [[MARIE Patterns (Indirect Addressing, Arrays, Subroutines)]]; SQL injection → [[SQL SELECT and WHERE]]; privacy → [[Privacy, Confidentiality, and Security]], [[Personal Data and Privacy in Database Design]].)*

## 🧭 Suggested Reading Order
*(read left→right within each week · **bold** = assessment-critical hand skill)*

- **W1 — data representation:** [[Computer Fundamentals (Bits, Bytes, Words)]] → **[[Number Systems (Binary and Hexadecimal)]]** *(A1)* → [[Signed Integer Representation (Two's Complement)]] → [[Floating Point Numbers (IEEE 754)]] → [[Text Encoding (ASCII and Unicode)]] → [[Transistors and Logic Gates]]
- **W2 — logic → circuits:** [[Boolean Algebra Laws]] → [[Sum-of-Products (Functions to Circuits)]] → **[[Karnaugh Maps]]** *(A1 simplification)* → [[Transistors and Logic Gates]] §Universality
- **W3 — architecture & MARIE:** [[Combinational Circuits (Adders, Decoders, MUX, ALU)]] → [[Sequential Circuits (Latches, Flip-Flops, Registers)]] → [[Von Neumann Architecture and Programs]] → **[[Fetch-Decode-Execute and RTL (Control)]]** *(A2 trace)* → **[[MARIE Assembly (Instruction Set and Patterns)]]** *(A2 writing)*
- **W4 — pointers & memory:** **[[MARIE Patterns (Indirect Addressing, Arrays, Subroutines)]]** *(A2 core)* → [[Memory and the Memory Hierarchy]]
- **W5 — board, boot, OS:** [[Motherboard and IO Interfaces]] → [[CPU-IO Communication (Memory-Mapped, Polling, Interrupts, DMA)]] → **[[The Boot Process]]** *(A2)* → **[[Operating Systems and Multi-Processing]]** *(A2 + LO4)* → [[Virtual Memory (MMU and Paging)]]
- **W6 — network stack & apps:** [[Computer Networks (Components and Types)]] → **[[Internet Model (Layers, Protocols, Encapsulation)]]** *(the networks framework)* → [[Application Architectures (Client-Server Tiers)]] → [[World Wide Web (HTTP and HTML)]] → [[Electronic Mail (SMTP, POP, IMAP, MIME)]]
- **W7 — lower layers & addressing:** [[Physical and Data Link Layers (Signals, Ethernet, CSMA-CD)]] → [[Network Addresses (URL, Port, IP, MAC)]] → [[Address Resolution (DNS and ARP)]] → [[Network Layer (Routing and Routing Tables)]] → [[Transport Layer (TCP and UDP)]]
- **W8 — LANs & WiFi:** [[Switched Ethernet (Switches, Forwarding, LAN Design)]] → [[WiFi (802.11, CSMA-CA, Topologies)]] → [[WiFi Security (WEP, WPA2)]] → [[LAN, Backbone, MAN, WAN (Organisational Networks)]]
- **W9 — the Internet at scale:** [[Internet Structure and Governance]] → [[Internet Access Technologies]] → [[CDNs, Load Balancing and Caching]] → [[Internet of Things (IoT)]] → [[Net Neutrality and Internet Policy]]
- **W10 — cryptography:** **[[Information Security and Cryptography]]** *(goal→mechanism spine)* → [[Symmetric Cryptography]] → [[Public Key Cryptography]] → [[Cryptographic Hash Functions]] → [[Key Establishment and Diffie-Hellman]] → [[Authentication, Certificates and PKI]] → [[Secure Channels - TLS and VPNs]]
- **W11 — auth & defence:** [[User Authentication and Passwords]] → [[Multi-Factor Authentication and Biometrics]] → [[Access Control]] → [[Firewalls and Packet Filtering]] → [[IDS, IPS and Next-Generation Firewalls]]
- **W12 — attacks, risk, privacy:** [[Malware and Attack Types]] → [[Software Vulnerabilities (Injection, XSS, Buffer Overflow)]] → [[Cybersecurity Case Studies]] → [[Cybersecurity Risk Management]] → [[Privacy and Data Protection (FIT1047)]]

## 🎯 Learning Outcomes (key skills per week)

- **W1** ➔ 
	- convert dec↔bin↔hex + add binary by hand 
	- negate via flip+1, range + overflow by sign rule 
	- normalise IEEE 754 + explain why $0.1$ is inexact 
	- decode ASCII hex, Unicode vs UTF-8 
	- switch → transistor → gate story
- **W2** ➔ 
	- build truth tables (precedence NOT>AND>OR) 
	- apply the Boolean laws to simplify/prove equivalence 
	- truth table → SOP → circuit 
	- minimise with a K-map (Gray code, maximal groups, wrap-around) 
	- NAND/NOR universality
- **W3** ➔ 
	- explain adders/decoder/MUX + compute-all-MUX-select ALU 
	- SR latch (hold row, forbidden $11$), D flip-flop, registers 
	- Von Neumann + stored program 
	- hand-trace fetch-decode-execute in RTL 
	- write MARIE with SkipCond+Jump idioms
- **W4** ➔ 
	- direct vs indirect addressing ($M[X]$ vs $M[M[X]]$) 
	- pointer-walk array loops, counter vs sentinel termination 
	- JnS/JumpI subroutines (`HEX 0` slot, no recursion) 
	- capacity from address width × addressability 
	- cache vs swap directions
- **W5** ➔ 
	- board components + interface trade-offs 
	- memory-mapped vs port I/O 
	- polling vs interrupts vs DMA 
	- the 12-step boot chain, BIOS vs UEFI 
	- Running/Ready/Blocked trace, user/kernel mode, system calls 
	- MMU isolation + page faults
- **W6** ➔ 
	- client/server/switch/router + reach ladder 
	- transfer time with $\times 8$ 
	- five layers + PDUs, protocol vs interface 
	- encapsulation both directions 
	- label a raw HTTP session 
	- email's three hops, POP vs IMAP, MIME
- **W7** ➔ 
	- digital encodings vs modulation 
	- CSMA/CD's three parts 
	- one address per layer
	- $/26$ subnet arithmetic
	- DNS (iterative vs recursive) + ARP broadcast 
	- per-hop routing, RIP vs OSPF 
	- TCP seq/ack lifecycle vs UDP
- **W8** ➔ 
	- switch learning/flood-when-unknown/store-and-forward 
	- switch vs hub vs router 
	- WiFi channels ($1/6/11$), CSMA/CA + hidden node, BSS/ESS 
	- rank open/WEP/WPA2-PSK/Enterprise 
	- owned LAN/backbone vs the leased WAN triangle
- **W9** ➔ 
	- AS + BGP, interior vs exterior routing 
	- peering vs transit, IXPs, tiers 
	- access technologies (ADSL/DSLAM, NBN/GPON, 4G/5G) 
	- load balancing vs caching vs CDN 
	- IoT security + Mirai/Dyn 
	- net-neutrality trade-offs
- **W10** ➔ 
	- match security goal → mechanism 
	- AES + its three weaknesses ($O(n^2)$ keys) 
	- RSA ops + key-length pairs 
	- hash properties + MAC-not-bare-hash 
	- DH exchange + discrete log, no authentication 
	- certificates/CA/revocation 
	- TLS + VPN endpoint limits
- **W11** ➔ 
	- three authentication factors 
	- salted-hash password storage 
	- MFA + biometric/token/app trade-offs, SIM swap 
	- ACL scaling wall → Kerberos/SSO 
	- firewall = filter-not-block + its limits 
	- IDS vs IPS, NGF TLS-proxy cost
- **W12** ➔ 
	- attack/malware taxonomy (virus vs worm vs trojan) 
	- four vulnerability classes + shared root cause (unchecked input) 
	- case-study lesson: exposure + insecure defaults 
	- residual risk + NIST RMF · profiling, PETs, data minimisation
