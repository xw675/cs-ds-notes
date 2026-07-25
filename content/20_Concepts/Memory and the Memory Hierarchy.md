---
unit: FIT1047
week: 4
parent: "[[Von Neumann Architecture and Programs]]"
tags: [CS/Systems, CS/Architecture]
aliases: [RAM, Memory Hierarchy, Caching, Swapping]
---
# [[Memory and the Memory Hierarchy]]

**Context:** [[FIT1047_MOC]] · how memory is addressed and why it's the performance bottleneck · registers from [[Sequential Circuits (Latches, Flip-Flops, Registers)]] · MUX addressing from [[Combinational Circuits (Adders, Decoders, MUX, ALU)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** memory = addressed boxes whose interpretation belongs to the PROGRAM ➔ $n$ address bits reach $2^n$ locations ➔ hierarchy trades speed for size (registers → caches → RAM → disk → network).
> - **📦 Core Components:** byte- vs word-addressable ➔ RAM (random access) ➔ cache (recently-used + prefetch) ➔ swapping (RAM's overflow to disk).
> - **⚡ Key Constraint:** RAM is up to $100\times$ slower than registers — caching exists because programs reuse and neighbour-access data; a cache miss can cost $100\times$.

## 📝 Core
### 1. Addressing
- **Interpretation is the program's job** ➔ neither memory nor CPU knows if a word is a number, char, pixel or instruction ([[Von Neumann Architecture and Programs|stored program]]).
- **Byte-addressable** ➔ one address per byte (most architectures); **word-addressable** ➔ one address per word (MARIE: 16-bit words).
- **Capacity formula** ➔ $n$ address bits ⟹ $2^n$ locations. **MARIE worked example:** $12$-bit addresses ⟹ $2^{12}=4096$ words $\times$ 2 bytes $= 8192$ bytes $= 8$ KiB.
- **RAM = random access** ➔ any address, any order, same cost — unlike tape/disk whose heads must move.
- **RAM module internals** ➔ chips arranged in rows × columns; an address splits into (row, column, byte-within-chip) fields, each decoded by a MUX — lecture module: $64 \times 2^{14}$ bits $= 1$ Mbit, 17-bit addresses split 3+3+11.

### 2. The Bottleneck and the Cache
- **Problem** ➔ `Load 1A0 / Add 1A0 / Store 1A0` touches the same address thrice; waiting on RAM each time stalls the CPU.
- **Cache** ➔ memory *inside the CPU* between registers and RAM: faster than RAM, slower than registers; smaller than RAM, larger than registers; keeps **recently used** values close.
- **Transparent** ➔ same `Load 1A0` — hardware serves it from cache when possible; stores may go cache-only (write-back) or cache+RAM (write-through) or RAM-only.
- **Prefetch trick** ➔ programs walk consecutive addresses (text scan, image pixels, [[MARIE Patterns (Indirect Addressing, Arrays, Subroutines)|array loops]]) ⟹ a miss loads the *next few* values too; eviction discards oldest.
- **Why it's tricky** ➔ cache misses make identical code up to $100\times$ slower; performance depends on the cache architecture; code itself is cached too (it lives in RAM).

### 3. Swapping (the other direction)
- **Not enough RAM?** ➔ write unused RAM regions to disk, read back on demand — the *opposite* of caching; hardware + OS implement it (virtual memory, Week 5).

## ⚖️ Core Decision Matrix — the hierarchy (lecture table)
| Level | Speed vs registers | Size | Where |
| :-- | :-- | :-- | :-- |
| Registers | $1\times$ (in-cycle) | a few words | inside CPU |
| L1 cache | $3$–$5\times$ slower | ~100 KB | inside CPU |
| L2/L3 cache | $25$–$50\times$ slower | ~1–8 MB | in/near CPU |
| RAM | $50$–$100\times$ slower | GBs | main bus |
| Disk/SSD | ~$1000\times$ slower | TBs | external |
| Network | $10^4\times$–∞ | ? | external |

## ✍️ Practice 
> [!QUESTION]- An architecture has 20-bit addresses and is byte-addressable. (a) How much memory can it address? (b) Same bits but word-addressable with 32-bit words — now how much? (c) Why does the array-sum loop from [[MARIE Patterns (Indirect Addressing, Arrays, Subroutines)]] run cache-friendly?
> > [!SUCCESS]- Answer
> > - (a) $2^{20}$ bytes $= 1$ MiB. (b) $2^{20}$ words $\times 4$ B $= 4$ MiB. (c) It touches consecutive addresses ⟹ each miss prefetches the following elements — sequential access is the cache's best case.
> > - **Key move:** capacity $=$ $2^{\text{address bits}} \times$ (bytes per location) — addressability changes the multiplier, not the exponent.

## ⚠️ Common Mistakes
- 💡 **Word- vs byte-addressable changes capacity** ➔ same address width, different total bytes; MARIE's 8 KiB needs BOTH facts ($2^{12}$ AND 2-byte words).
- 💡 **Caching ≠ swapping** ➔ cache pulls hot data *toward* the CPU; swapping pushes cold data *away* to disk — opposite directions, both transparent.
- 💡 **"Random access" is about order-independence** ➔ not randomness; the contrast class is sequential media (tape, disk head travel).
