---
unit: FIT1043
domain: E
week: 3
parent: "[[Data Science Process (Standard Value Chain)]]"
tags: [DataScience/DataSources]
aliases: [Open Data, Linked Open Data, LOD, Data Sources]
---
# [[Data Sources and Open Data]]

**Context:** [[FIT1043_MOC]] · the **Collection** stage of the [[Data Science Process (Standard Value Chain)|value chain]] · where data comes from · feeds [[Data Wrangling]] · new sources via [[APIs for Data Collection|APIs]]

> [!abstract] Quick Revision
> - **🎯 Objective:** find and combine data sources ➔ existing sources, creative multi-source use, and access to **new** sources.
> - **⚡ Key Constraint:** open data must be **machine-readable AND publicly available**; Linked Open Data adds value by **connecting** datasets.

## 📝 Core
### 1. The Data Landscape
- **Databases** ➔ relational (Oracle, MySQL, MariaDB, MS-SQL) holding CRM, loans, banking, HR/payroll.
- **Files** ➔ logs, spreadsheets, PDF, images, raw/formatted text.
- **Web & crowd** ➔ open data, REST APIs, web scraping; news, blogs, corporate, government, social media (GDELT).
- **IoT & mobile** ➔ utilities, vehicles, monitoring; phone location/browsing/usage/personal data.

### 2. Open Data (World Bank)
- **Definition** ➔ machine-readable, publicly available data; like oil it must be **"refined"** to realise value.
- **Benefits** ➔ **transparency** (track budgets, reduce corruption), **public-service improvement** (citizens engage), **innovation/economic value** (new data-driven products), **efficiency** (cheaper cross-ministry discovery). e.g. data.gov.au (30k+ datasets).
- **CSV** ➔ the common format; the separator may be comma, semicolon, colon, or tab (all called "CSV").

### 3. Linked Open Data (LOD)
- **Premise** ➔ data has more value when **connected** to other data.
- **Triples** ➔ subject–verb–object; e.g. **DBpedia** (extracted Wikipedia, ~3.4M concepts, ~1B triples) — lets sources be connected and queried.

## ⚠️ Common Mistakes
- 💡 **Open ≠ just public** ➔ it must be *machine-readable* too; a PDF of a table is public but not readily usable open data.
- 💡 **"CSV" hides its separator** ➔ always check the actual delimiter (tab/semicolon/colon) before parsing.

## 🧠 Active Recall
> [!FAQ]- Define open data and explain what Linked Open Data adds via triples.
> > [!SUCCESS]- Answer
> > - **Short answer:** Open data is machine-readable *and* publicly available; LOD connects datasets by encoding facts as subject–verb–object triples (e.g. DBpedia) so different sources can be linked and queried.
> > - **Why:** **Value from connection** ➔ triples give a shared structure that joins otherwise-isolated open datasets.
