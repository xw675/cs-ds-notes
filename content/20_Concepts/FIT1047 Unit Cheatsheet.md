---
unit: FIT1047
parent: "[[FIT1047_MOC]]"
tags: [CS/Systems, CS/Networks, CS/Security]
type: cheatsheet
aliases: [FIT1047 Exam Crib, Systems Cheatsheet]
---
# [[FIT1047 Unit Cheatsheet]]

**Context:** [[FIT1047_MOC]] · the WHOLE unit in one re-read — systems (W1–5) → networks (W6–9) → security (W10–12). Hand-execution skills first; links only for depth.

> [!abstract] Quick Revision
> - **🎯 Objective:** every assessed skill is a hand procedure ➔ convert, simplify, trace, subnet, match goal→mechanism.
> - **⚡ Key Constraint:** the unit's marks live in EXACT constants — SkipCond $000/400/800$, K-map order $00,01,11,10$, channels $1/6/11$, $\times 8$ bits↔bytes, $\frac{n(n-1)}{2}$ keys.

## 1️⃣ Data Representation (W1)
- **Positional value** ➔ digit × base$^{\text{position}}$; dec→bin by repeated ÷2 (remainders bottom-up); bin↔hex by 4-bit groups **from the RIGHT**.
- **$n$ bits** ➔ $2^n$ values, max $2^n-1$ (zero takes a slot); always subscript the base ($101_2 \neq 101_{16}$).
- **Two's complement negate** ➔ flip all bits, add 1 (involution — do it twice to decode). Range asymmetric: $-2^{n-1}\dots 2^{n-1}-1$.
- **Overflow rule** ➔ same-sign operands, opposite-sign result ⟹ overflow. The **discarded carry is NOT the test** ($(-1)+(-2)$ discards a carry, correct).
- **IEEE 754 double** ➔ 1 sign + 11-bit exponent (**excess-$K$ bias, not 2C**) + 52-bit fraction of normalised $1.xxx \times 2^e$; $0.1_{10}$ has no exact form ⟹ never `==` floats.
- **ASCII** ➔ 7-bit, 128 chars; Unicode assigns **codepoints**, UTF-8/16 decide bytes (variable-length — byte count ≠ char count).

## 2️⃣ Boolean Logic → Circuits (W2–3)
- **Laws** ➔ commutative · associative · idempotent · complement · identity · null · absorption · distributive (**TWO** directions, unlike numbers) · De Morgan ($\overline{XY} = \overline{X}+\overline{Y}$ — bar extent matters: $\overline{X}Y \neq \overline{XY}$).
- **SOP extraction** ➔ one AND-product per **$F=1$ row**, complement the **0-variables** in that row, OR products. Correct but non-minimal ➔ K-map next.
- **K-map procedure** ➔ Gray-code columns $00,01,\mathbf{11},\mathbf{10}$ → circle **maximal** power-of-2 groups of 1s (wrap-around legal) → per group drop every variable that varies inside it. Two 2-groups where a 4-group fits = marked down.
- **Combinational blocks** ➔ half adder = XOR (sum) + AND (carry); full adder = + carry-IN; ripple = chained full adders. Decoder activates 1-of-$2^n$; MUX selects; **ALU computes ALL ops in parallel, MUX picks** by op-code.
- **Sequential** ➔ SR latch: $S{=}R{=}0$ hold (**the hold row IS the memory**), $S{=}R{=}1$ forbidden; D flip-flop = clocked; $n$ flip-flops = register.

## 3️⃣ Architecture & MARIE (W3–4)
- **Von Neumann** ➔ CPU (ALU + registers + control) + memory + I/O; **stored program** = code and data share one addressed memory — same word is instruction OR number by how execution reaches it.
- **Fetch (ALWAYS 4 steps)** ➔ $MAR \leftarrow PC$ · $MBR \leftarrow M[MAR]$ · $IR \leftarrow MBR$ · $PC \leftarrow PC+1$ (**PC increments in fetch** — Jump then overwrites it). Decode 5–6 vary per instruction. **MBR is the only door to memory.**
- **Clock ≠ speed** ➔ GHz counts cycles; one instruction = several cycles (Add ≈ 7).

| MARIE essentials | Payload |
| :-- | :-- |
| word format | 4-bit opcode + 12-bit address, 16-bit word; **AC is the only working register** |
| SkipCond constants | $000{:}\ AC{<}0$ · $400{:}\ AC{=}0$ · $800{:}\ AC{>}0$ — skips exactly ONE instruction (pair with `Jump`) |
| indirect | `LoadI/StoreI/AddI` = $M[M[X]]$ pointer deref |
| subroutine | `JnS X` stores return PC **at X itself**, jumps to $X{+}1$ ⟹ subroutine starts `HEX 0`; return = `JumpI X`; **no stack ⟹ no recursion** |
| directives | `DEC` = value · `Adr` = address (pointer) · never in the execution path |
| pointer walk | `Load ptr / Add One / Store ptr` — 3 instructions, forget `Store` ⟹ infinite loop on element 0 |

## 4️⃣ Memory, I/O, Boot, OS (W4–5)
- **Hierarchy** ➔ registers → caches → RAM ($100\times$ slower than registers) → disk → network; **cache pulls hot data toward CPU, swap pushes cold data to disk** — opposite arrows.
- **Addressability** ➔ $n$ address bits reach $2^n$ locations; capacity needs BOTH facts (MARIE: $2^{12}$ words × 2 bytes = 8 KiB).
- **CPU↔device** ➔ memory-mapped registers (cost: address space + buggy-code hazard) · polling · **interrupts checked between instructions, before each fetch** · DMA (CPU free to compute, NOT free to use the shared bus).
- **Boot chain** ➔ power-good → CPU reset → **ROM** code → POST (before OS search — beep codes because video may not work) → hardware init → boot sector → boot code → kernel → drivers → GUI. ROM bootstraps; OS runs from RAM.
- **OS state cycle (hand-traceable)** ➔ Running →(timer) Ready →(scheduled) Running →(I/O wait) **Blocked** →(I/O done) Ready. Blocked waits on I/O, Ready waits on CPU only. User programs **must system-call** for I/O; preemption needs timer interrupts.
- **Virtual memory** ➔ MMU checks EVERY access: foreign address ⟹ fatal interrupt; on-disk page ⟹ **page fault** (normal, OS swaps in). One mechanism, two jobs: protection + overcommit.

## 5️⃣ Networks (W6–9)
- **Five layers** ➔ Application → Transport → Network → Data Link → Physical; **protocols run horizontally** (peer↔peer), **interfaces vertically**; PDUs: segment / packet / frame per layer; routers unwrap only to layer 3.

| Layer | Identity | Protocols / payload |
| :-- | :-- | :-- |
| Application | URL | HTTP (request line/headers ⟶ status/headers/body; each `<img>` = new GET) · SMTP→SMTP→POP/IMAP; MIME base64s binary; **envelope (`MAIL FROM`) ≠ header (`From:`)** — the spoofing gap |
| Transport | port | TCP: 3-way open, 4-way close (full-duplex ⟹ FIN each way), ARQ on **seq = bytes sent / ack = bytes received**; UDP: connectionless — correct choice for live media |
| Network | IP | routing table → next hop or default gateway; each router plans ONE hop. Distance vector = share tables, fewest hops (RIP, 15-hop cap) vs link state = share link quality, fastest path (OSPF). **Interior: RIP/OSPF · exterior: BGP only** |
| Data Link | MAC (LAN-scoped) | Ethernet CSMA/**CD** (sense · shared medium · jam + random wait) vs WiFi CSMA/**CA** (can't detect radio collisions — hidden node); crossing a router swaps frames/MACs, never IPs |
| Physical | — | digital encodings (NRZ, Manchester) vs modulation (freq/amp/phase — more bits per symbol without new Hz) |

- **Address arithmetic** ➔ $/26$ = first 26 bits network+subnet, $32-26=6$ host bits; same-subnet test = prefix compare. Transfer time: **rates in bits/s, sizes in Bytes — ×8**.
- **Resolution: TWO steps** ➔ DNS name→IP once (iterative = client walks, recursive = server walks — same answer, different walker); ARP IP→MAC per LAN, broadcast by necessity.
- **Devices** ➔ switch = layer-2 inside a LAN, learns table from **sender** MACs, floods when unknown (empty table ⟹ behaves as hub); router = joins networks. Hub looks star, behaves bus.
- **WiFi** ➔ 2.4 GHz: 22 MHz-wide channels 5 MHz apart ⟹ only **1, 6, 11** clean; 5 GHz faster but attenuates ⟹ MORE APs. BSS → ESS.
- **Organisation scale** ➔ LAN (owned) → backbone (owned fibre; access/distribution/core) → MAN/WAN (**leased**): dedicated circuit (guaranteed, dear) · carrier packet-switched (shared) · VPN (cheapest, **zero guarantees** — "private" is cryptographic only).
- **Internet structure** ➔ ASes exchange via border routers running BGP; **peering** (free, mutual, similar size) vs **transit** (paid, small→large). No one owns the Internet. Load balancing spreads within a data centre; **CDN also moves content near users**; only GET is cacheable.

## 6️⃣ Security (W8, W10–12)
| Goal | Mechanism (match EXACTLY) |
| :-- | :-- |
| confidentiality | encryption — AES (symmetric, fast; key distribution problem, $\frac{n(n-1)}{2}$ keys) |
| integrity in transit | **MAC (keyed)** — a bare hash is recomputable by the attacker; plain RSA is malleable too |
| authenticity / identity | certificates: CA signs (public key + identity); trust **moves** to the CA; valid cert ≠ safe site |
| non-repudiation | **asymmetric only** — a shared key can never prove WHICH side signed |
| key agreement | Diffie-Hellman — beats eavesdroppers, **not MITM** (no authentication ⟹ needs certificates); $g$ must be a primitive root |
| the full channel | TLS = DH + certificates + AES; usually **only the server** authenticated; VPN secures tunnel endpoints only — beyond the gateway traffic is clear |

- **Passwords** ➔ never cleartext; plain hash loses to rainbow tables ⟹ **per-user salted hash** (salt unique, not secret); login = re-hash and compare, never decrypt.
- **AuthN ≠ authZ** ➔ who you are (login, MFA — ≥2 of know/have/are; same-device "MFA" isn't) vs what you may do ([[Access Control]] — raw ACLs don't scale ⟹ tickets/Kerberos; SSO = concentrated risk).
- **WiFi security** ➔ open + captive portal is STILL open (login is application-layer; frames capturable); WEP broken by its **static shared key**; WPA2 = per-packet keys + AES; PSK strength = passphrase strength.
- **Attacks** ➔ virus needs a host, worm self-propagates; malware spreads without user interaction (Angler); anti-virus catches **known** only. Injection/XSS/buffer overflow share one root: **missing input sanitisation** + excess privilege.
- **Defence layers** ➔ firewall **filters** (stateless, perimeter-only, blind inside tunnels) → IDS detects/alerts → IPS **also blocks** → NGF proxies TLS (inspects apps but **breaks end-to-end** — single point holding plaintext). Perfect security impossible ⟹ manage residual risk (NIST RMF); controls = tech + people/process.
- **IoT/privacy** ➔ Mirai needed only **default credentials**; DNS (Dyn) was the target, IoT the weapon. Cookie banners = compliance, not protection; data minimisation serves privacy AND breach impact.

## ⚠️ Top Cross-Unit Traps
- 💡 **Byte ≠ word** ➔ byte fixed at 8 bits; word is architecture-defined.
- 💡 **$2^n$ values but max $2^n-1$** ➔ zero occupies a slot.
- 💡 **PC increments during fetch** ➔ trace it at step 4, not at execute.
- 💡 **Reliability lives in TCP** ➔ data link only discards bad frames; retransmission is transport's job.
- 💡 **Goal ≠ mechanism** ➔ encryption gives confidentiality, NOT integrity — the single most-tested security idea.
- 💡 **Hash function ≠ [[Hash Table]] hash** ➔ crypto wants irreversibility; bucketing wants cheap uniformity.
