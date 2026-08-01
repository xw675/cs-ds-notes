# 🎓 CS × DS Knowledge Vault

**Live site:** https://xw675.github.io/monash-cs-notes/

Exam-ready study notes for a Monash University CS + Data Science, published from my Obsidian vault with [Quartz 4](https://quartz.jzhao.xyz).

Covers six first-year units — **FIT1058** (Foundations of Computing), **FIT1043** (Intro to Data Science), **FIT1047** (Computer Systems, Networks & Security), **FIT1008** (Fundamentals of Algorithms), **FIT2094** (Databases), **FIT2099** (Object Oriented Design) — as ~370 interlinked atomic notes with unit cheatsheets, toolkit cheatsheets, LaTeX math, Mermaid UML diagrams, full-text search, backlinks, and a graph view.

## How it works

```
Obsidian vault (source of truth)
        │  ./sync-content.sh
        ▼
content/            10_Units · 20_Concepts · 90_Attachments
        │  git push → GitHub Actions
        ▼
quartz build        markdown → static HTML (wikilinks, KaTeX, Mermaid)
        ▼
GitHub Pages        static files, no server
```

Notes are written and maintained in Obsidian. This repo holds a synced copy of the published folders plus the Quartz generator; nothing here is edited by hand except `content/index.md` (the homepage) and configuration.

## Repo layout

| Path | What it is |
| --- | --- |
| `content/` | Published notes (synced from vault — do not edit directly) |
| `content/index.md` | Homepage (hand-written, survives sync) |
| `quartz/` | Quartz static site generator (TypeScript) |
| `quartz.config.ts` | Site title, theme, plugins |
| `sync-content.sh` | Copies vault folders in + normalizes math fences |
| `.github/workflows/deploy.yml` | Build + deploy on every push to `main` |

## Local patches to Quartz

`quartz/` is upstream Quartz with one deliberate change — **re-apply it after any upstream merge**:

| File | Change | Why |
| --- | --- | --- |
| `quartz/plugins/transformers/ofm.ts` | `commentRegex` skips fenced and inline code | Upstream strips `%%…%%` with a raw-text regex that ignores code blocks, so a literal `%%` (R's modulo, the Lex/Yacc section separator) pairs with an unrelated `%%` elsewhere in the file and silently deletes everything between. Obsidian itself does not treat `%%` in code as a comment. |

## Publishing an update

```bash
./sync-content.sh    # pull latest notes from the vault
git add -A && git commit -m "update notes" && git push
```

The GitHub Action rebuilds and redeploys automatically (~2 min).

## Local preview

```bash
npm ci               # first time only
npx quartz build --serve
# → http://localhost:8080
```

## Local modifications to stock Quartz

Two deviations from upstream Quartz v4.5.2, both required for this vault:

1. **Math fence normalization** (`sync-content.sh`) — Obsidian accepts compact `$$\begin{aligned}` / `\end{aligned}$$` fences on shared lines; Quartz's stricter markdown parser (micromark) discards content after an opening `$$` and misses closers at line ends, which silently swallowed entire pages into one broken KaTeX block. The sync script splits multi-line display-math fences onto their own lines; single-line `$$x = 1$$` equations are left untouched.

2. **Mermaid `<<annotation>>` fix** (`quartz/components/scripts/mermaid.inline.ts`) — upstream restores diagram source via `node.innerHTML`, so the browser parses `<<interface>>` as an HTML tag and mangles it to `<>`, breaking every class diagram with UML annotations. Patched to `node.textContent`, which preserves the source literally.
