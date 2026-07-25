---
unit: FIT1043
week: 9
parent: "[[Data Sources and Open Data]]"
tags: [DataScience/DataManagement]
aliases: [Metadata, Data about Data, EXIF]
---
# [[Metadata]]

**Context:** [[FIT1043_MOC]] · one way to **characterise** a data set · makes a [[Data Sources and Open Data|data resource]] findable and usable · "data about data"

> [!abstract] Quick Revision
> - **🎯 Objective:** describe a data resource so it can be found, understood, and reused ➔ structured **data about data**.
> - **⚡ Key Constraint:** it must be **machine-processable** (structured), not just a human note — that's what enables discovery/interpretation.

## 📝 Core
- **Definition** ➔ structured information that describes, explains, locates, or otherwise makes it easier to retrieve/use/manage an information resource — **data about data**.
- **Descriptive** ➔ content for identification/retrieval (e.g. a book's title, author).
- **Structural** ➔ relationships and links (chapters in a book, elements in XML, containers in MPEG).
- **Administrative** ➔ management info (version number, archiving date, Digital Rights Management/DRM).
- **Why** ➔ facilitate **discovery**, judge **applicability**, enable **interpretation/reuse**, and clarify **ownership/restrictions**.
- **Examples** ➔ a book's catalogue record; **EXIF** data embedded in a photo; IPTC/USGS standards.

## ⚠️ Common Mistakes
- 💡 **Must be structured** ➔ metadata is machine-readable by design; free-form notes a computer can't parse don't do the job.
- 💡 **Three flavours, not one** ➔ describing content (descriptive) ≠ documenting structure (structural) ≠ managing lifecycle (administrative).

## 🧠 Active Recall
> [!FAQ]- Define metadata and classify: a book's author, its chapter list, and its archiving date.
> > [!SUCCESS]- Answer
> > - **Short answer:** Metadata is structured data about data that aids retrieval/use/management; author = **descriptive**, chapter list = **structural**, archiving date = **administrative**.
> > - **Why:** **Discovery/interpretation/management** ➔ each type serves a different purpose — finding, linking, or governing the resource.
