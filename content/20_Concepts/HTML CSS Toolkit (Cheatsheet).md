---
parent: "[[WebDev_Roadmap_MOC]]"
tags: [WebDev/HTML, WebDev/CSS, WebDev/Layout, WebDev/Responsive]
type: cheatsheet
aliases: [HTML CSS Cheatsheet, HTML Cheatsheet, CSS Cheatsheet, Flexbox Grid cheatsheet, web fundamentals cheatsheet]
---
# [[HTML & CSS Toolkit (Cheatsheet)]]

**Context:** Full-Stack Roadmap Chapters 1–5 in one place — HTML structure (Ch 1–3) → CSS styling (Ch 4) → layout & responsive (Ch 5) · covers everything needed to build a styled, responsive, multi-page static site before JavaScript begins.
**Read protocol:** scan tables → attempt the practice blank → re-read only the section where you failed.

> [!abstract] Quick Revision
> - **🎯 Objective:** build a complete, responsive, multi-page website from scratch ➔ semantic HTML structure + CSS styling + Flexbox/Grid layout + mobile-first media queries.
> - **⚡ Key Constraint:** the **box model** is the root of 80% of CSS confusion — `width` means *content* width by default (padding + border added on top); always start with `* { box-sizing: border-box; }`. Second biggest source of bugs: **specificity** — an ID beats a class beats an element selector, and the browser silently picks the winner with no error.

## 🌐 How the web works (mental model)
| Concept | One-liner | Gotcha |
| :--- | :--- | :--- |
| **Client / Server** | browser asks (request) → server answers (response) | your HTML/CSS/JS runs on the **client** (browser) |
| **HTTP** | the protocol for requests; methods: GET / POST / PUT / DELETE | status codes: 200 OK · 404 Not Found · 401 ≠ 403 |
| **DNS** | turns `example.com` → IP address `93.184.216.34` | the internet's phone book |
| **Frontend / Backend** | code in the browser / code on the server | full-stack = both |
| **Rendering** | browser reads HTML top→down, builds a tree (DOM), paints pixels | CSS loads in `<head>` so styles apply before the page paints |

## 🏗️ HTML page skeleton (every page starts here)
```html
<!DOCTYPE html>                        <!-- 1. declaration: "this is modern HTML" -->
<html>
  <head>                               <!-- 2. metadata — NOT visible on page -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tab Title</title>           <!-- browser tab + search results -->
    <link rel="stylesheet" href="styles.css">   <!-- external CSS -->
  </head>
  <body>                               <!-- 3. everything the user SEES -->
    ...
  </body>
</html>
```
- `<!DOCTYPE html>` — always first line; no closing tag.
- `<meta viewport>` — **required** for mobile; without it, phones render at 980px and zoom out.
- `<link>` loads an external stylesheet — the standard for all real projects.

## 📝 HTML elements — content structure
| Element | Micro-syntax | Job / gotcha |
| :--- | :--- | :--- |
| **Headings** | `<h1>` – `<h6>` | hierarchy, not size; **never skip levels** (h1→h3 is wrong); one `<h1>` per page |
| **Paragraph** | `<p>text</p>` | block-level; browser adds margin above/below automatically |
| **Link** | `<a href="url">text</a>` | `href` can be absolute (`https://…`) or relative (`about.html`) |
| **Image** | `<img src="path" alt="desc" width="400">` | **no closing tag**; `alt` is required (accessibility + SEO); `src` is relative or URL |
| **Line break** | `<br>` | no closing tag; use for addresses/poems — separate ideas = separate `<p>` |
| **Comment** | `<!-- text -->` | browser ignores it; notes to yourself |
| **Entity** | `&copy;` → © · `&amp;` → & · `&lt;` → < | escape special characters |

## 📋 Lists
| Type | Micro-syntax | When |
| :--- | :--- | :--- |
| **Unordered** | `<ul><li>Item</li></ul>` | bullets — order doesn't matter (ingredients) |
| **Ordered** | `<ol><li>Step</li></ol>` | numbered — sequence matters (cooking steps); browser auto-numbers |
| **Nested** | inner `<ul>`/`<ol>` goes *inside* a `<li>`, before its `</li>` | sub-items; browser changes bullet style per depth |

⚠️ Only `<li>` belongs directly inside `<ul>`/`<ol>` — raw text or `<p>` inside the list container is invalid.

## ✏️ Inline formatting
| Element | Renders as | Semantic meaning |
| :--- | :--- | :--- |
| `<strong>` | **bold** | important — screen readers stress it |
| `<em>` | *italic* | emphasis — like vocal stress |
| `<code>` | `monospace` | code, filenames, commands |
| `<sub>` / `<sup>` | H₂O / x² | subscript / superscript |
| `<b>` / `<i>` | bold / italic | **no** semantic meaning — use `<strong>`/`<em>` by default |

## 📮 Forms (gateway to interactivity)
| Element / Attribute | Micro-syntax | Job / gotcha |
| :--- | :--- | :--- |
| **Container** | `<form>` | groups inputs; later add `action="url"` `method="POST"` for backend |
| **Text** | `<input type="text" id="x" name="x">` | single-line; `name` = key sent to server |
| **Email / Number / Date / Password / URL** | `<input type="email">` etc. | browser validates format + shows correct mobile keyboard — free |
| **Radio** | `<input type="radio" name="group" value="v">` | pick one; **same `name`** = same group |
| **Checkbox** | `<input type="checkbox" name="x" value="v">` | pick many; can share a `name` |
| **Dropdown** | `<select name="x"><option value="v">Label</option></select>` | always set `value` explicitly (display text ≠ sent value) |
| **Textarea** | `<textarea name="x" rows="5" cols="40"></textarea>` | multi-line; has a closing tag (unlike `<input>`) |
| **Label** | `<label for="id">Text</label>` | `for` links to input's `id`; **always include** — accessibility + click-to-focus |
| **Submit** | `<button type="submit">Go</button>` | triggers form submission |
| **Validation** | `required` · `min="1"` · `max="100"` · `placeholder="hint"` | client-side; browser blocks submit if invalid |

## 📊 Tables
```html
<table>
  <thead><tr><th>Name</th><th>Score</th></tr></thead>   <!-- header row -->
  <tbody><tr><td>Aisyah</td><td>85</td></tr></tbody>    <!-- data rows -->
  <tfoot><tr><td>Average</td><td>79</td></tr></tfoot>   <!-- summary row -->
</table>
```
- `<th>` = header cell (bold, centered) · `<td>` = data cell.
- `<thead>`/`<tbody>`/`<tfoot>` — accessibility, CSS targeting, sticky headers, print repetition.
- ⚠️ **Never use tables for page layout** — use CSS Grid/Flexbox.

## 🏛️ Semantic structure
| Element | Meaning | Rule |
| :--- | :--- | :--- |
| `<header>` | site/page intro | logo, title, tagline |
| `<nav>` | navigation links | menus, breadcrumbs |
| `<main>` | primary content | **one per page** |
| `<article>` | self-contained content | blog post, product card — "makes sense in an email?" |
| `<section>` | thematic grouping | chapter within an article; doesn't stand alone |
| `<aside>` | tangential content | sidebar, related links |
| `<footer>` | closing content | copyright, contact, sitemap |
| `<div>` | generic box — **no meaning** | use only when no semantic element fits; for CSS grouping |

```
┌─── <header> ────────────────────────────┐
├─── <nav> ───────────────────────────────┤
├─── <main> ──────────────┬── <aside> ────┤
│  <section>              │  sidebar      │
│    <article> … </article>│              │
│  </section>             │              │
├─────────────────────────┴──────────────┤
└─── <footer> ────────────────────────────┘
```

## 🎨 CSS — how to add styles
| Method | Syntax | When |
| :--- | :--- | :--- |
| **External** (✅ use this) | `<link rel="stylesheet" href="styles.css">` in `<head>` | every real project — one file styles the whole site |
| **Internal** | `<style>…</style>` in `<head>` | single-page experiments |
| **Inline** (❌ avoid) | `<p style="color:red;">` | one-off test only; can't reuse |

## 🎯 Selectors
| Selector | Syntax | Targets |
| :--- | :--- | :--- |
| Element | `p` | all `<p>` |
| Class | `.card` | all `class="card"` — **primary styling tool** |
| ID | `#logo` | one `id="logo"` — prefer classes for styling |
| Descendant | `nav a` | `<a>` inside `<nav>` only |
| Group | `h1, h2, h3` | all three — same rule |
| Element+Class | `p.intro` | only `<p class="intro">` |
| Attribute | `input[type="email"]` | inputs of that type |
| Pseudo-class | `a:hover` · `input:focus` · `li:first-child` · `li:last-child` · `li:nth-child(2)` | element **state** or **position** |

**Specificity** (who wins when rules conflict): inline style > ID > class/pseudo-class/attribute > element. Equal specificity → last rule wins. DevTools Styles panel shows crossed-out lines for overridden rules.

## 🎨 Colors & backgrounds
| Format | Example | Notes |
| :--- | :--- | :--- |
| Named | `tomato`, `navy`, `teal` | ~140 names; prototyping |
| Hex | `#2c3e50`, `#fff` | most common; 6-digit (RRGGBB) or 3-digit shorthand |
| RGB | `rgb(44, 62, 80)` | decimal equivalent of hex |
| RGBA | `rgba(0, 0, 0, 0.5)` | adds transparency (0 = invisible, 1 = solid) |
| `background-color` | `#f5f5f5` | fills the padding area too |
| `background-image` | `url('img.jpg')` | `background-size: cover` fills the box (hero images) |

## 🔤 Typography
| Property | Job | Common values |
| :--- | :--- | :--- |
| `font-family` | typeface + fallback chain | `'Segoe UI', Tahoma, sans-serif` — always end with generic |
| `font-size` | text size | `16px`, `1.2rem`, `2em` |
| `font-weight` | thickness | `normal` (400), `bold` (700) |
| `line-height` | vertical space between lines | `1.5`–`1.8` for body text |
| `color` | text color | `#333` (dark grey > pure black for readability) |
| `text-align` | horizontal alignment | `left`, `center`, `right` |
| `text-decoration` | underline etc. | `none` (remove link underline), `underline` |
| `letter-spacing` | space between characters | `-0.5px` for tight headings |

## 📦 The Box Model (the single most important CSS concept)
```
┌─────────────── MARGIN ────────────────┐   transparent — pushes others away
│  ┌─────────── BORDER ──────────────┐  │   visible edge
│  │  ┌─────── PADDING ──────────┐  │  │   inside the box — bg color fills it
│  │  │       CONTENT             │  │  │   text / image
│  │  │   width × height          │  │  │
│  │  └──────────────────────────┘  │  │
│  └────────────────────────────────┘  │
└──────────────────────────────────────┘
```

| Property | Micro-syntax | Gotcha |
| :--- | :--- | :--- |
| `width` / `height` | `300px`, `90%`, `auto` | default = content width only; `border-box` makes it total width |
| `padding` | `20px` (all) · `10px 20px` (TB, LR) · `10px 20px 30px 40px` (T R B L ↻) | inside the box; bg color fills it |
| `border` | `1px solid #ddd` · `border-radius: 8px` | visible edge; radius = rounded corners |
| `margin` | same shorthand as padding · `0 auto` centers a block with `max-width` | outside the box; transparent |
| `box-sizing` | `* { box-sizing: border-box; }` | **always add** — makes `width` include padding + border |

**Shorthand order** (clockwise from top): Top → Right → Bottom → Left. Same for `padding` and `margin`.

**Centering a block:** `max-width: 800px; margin: 0 auto;` — must have a `width` or `max-width` set, or `auto` does nothing.

## 📐 Units
| Unit | Meaning | Use for |
| :--- | :--- | :--- |
| `px` | fixed pixels | borders, small spacing, exact sizes |
| `%` | percentage of parent | fluid widths (`width: 90%`) |
| `em` | relative to element's font-size | spacing that scales with text |
| `rem` | relative to root (`<html>`) font-size | font sizes — most predictable |
| `vh` / `vw` | % of viewport height / width | full-screen sections (`height: 100vh`) |
| `fr` | fractional unit (Grid only) | divide available space (`1fr 1fr 1fr` = 3 equal cols) |

**Practical rule:** `rem` for font sizes, `px` for borders and fine details, `%` + `max-width` for containers, `fr` for Grid columns.

## 💪 Flexbox (1D layout — row OR column)
```css
.container {
    display: flex;              /* activates Flexbox */
    flex-direction: row;        /* default: horizontal; column = vertical */
    justify-content: center;    /* distribute along MAIN axis */
    align-items: center;        /* align along CROSS axis */
    flex-wrap: wrap;            /* allow wrapping to next line */
    gap: 20px;                  /* space between items */
}
```

| `justify-content` | Visual (main axis →) |
| :--- | :--- |
| `flex-start` | `[A][B][C]·········` |
| `flex-end` | `·········[A][B][C]` |
| `center` | `····[A][B][C]····` |
| `space-between` | `[A]····[B]····[C]` |
| `space-evenly` | `···[A]···[B]···[C]···` |

| `align-items` | Effect (cross axis) |
| :--- | :--- |
| `stretch` | items fill container height (default) |
| `center` | vertically centered |
| `flex-start` / `flex-end` | top / bottom |

| Item property | Micro-syntax | Job |
| :--- | :--- | :--- |
| `flex-grow` | `flex-grow: 1` | absorb leftover space (default `0` = don't grow) |
| `flex-shrink` | `flex-shrink: 0` | prevent shrinking |
| `align-self` | `align-self: flex-end` | override `align-items` for one item |

**Center anything (holy grail):**
```css
.center { display: flex; justify-content: center; align-items: center; height: 100vh; }
```

**Navbar pattern:**
```css
nav { display: flex; justify-content: space-between; align-items: center; }
/* logo pushed left, links pushed right */
```

## 🔲 CSS Grid (2D layout — rows AND columns)
```css
.grid {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;     /* 3 equal columns */
    grid-template-rows: auto 1fr auto;       /* header / stretch / footer */
    gap: 20px;                               /* row + column gap */
}
```

| Pattern | Micro-syntax | Result |
| :--- | :--- | :--- |
| Equal columns | `grid-template-columns: 1fr 1fr 1fr` | 3 equal-width columns |
| Fixed + flex | `grid-template-columns: 200px 1fr` | sidebar 200px + fluid content |
| Repeat | `repeat(3, 1fr)` | shorthand for `1fr 1fr 1fr` |
| **Auto-responsive** | `repeat(auto-fit, minmax(250px, 1fr))` | as many cols as fit, min 250px — **responsive without media queries** |

### Flexbox vs. Grid — decision rule
| Scenario | Use |
| :--- | :--- |
| Row of items (navbar, toolbar, centering) | **Flexbox** |
| Card grid / image gallery / dashboard | **Grid** |
| Full page layout (header / sidebar / footer) | **Grid** |
| Items that wrap into rows | either — Flex `wrap` or Grid `auto-fit` |
| **One** dimension (row or column) | **Flexbox** |
| **Two** dimensions (rows AND columns) | **Grid** |

Most pages use **both**: Grid for the page skeleton, Flexbox for component internals.

## 📱 Responsive Design
| Tool | Micro-syntax | Job |
| :--- | :--- | :--- |
| **Viewport tag** | `<meta name="viewport" content="width=device-width, initial-scale=1.0">` | **required** — without it, mobile renders at 980px and zooms out |
| **Fluid container** | `width: 90%; max-width: 1000px; margin: 0 auto;` | adapts to screen, caps at max, centered |
| **Fluid images** | `img { max-width: 100%; height: auto; }` | prevents overflow |
| **Auto-fit grid** | `repeat(auto-fit, minmax(280px, 1fr))` | responsive grid, zero media queries |
| **Media query** | `@media (min-width: 768px) { … }` | apply CSS only above a width |

**Mobile-first** (standard practice): write base styles for the smallest screen → add complexity with `min-width` queries:
```css
/* Mobile (default) */
.card-grid { grid-template-columns: 1fr; }
nav { flex-direction: column; }

/* Tablet 768px+ */
@media (min-width: 768px) {
    .card-grid { grid-template-columns: 1fr 1fr; }
    nav { flex-direction: row; }
}

/* Desktop 1024px+ */
@media (min-width: 1024px) {
    .card-grid { grid-template-columns: 1fr 1fr 1fr; }
}
```

| Breakpoint | Width | Devices |
| :--- | :--- | :--- |
| Mobile | < 768px | phones |
| Tablet | 768px – 1023px | tablets, small laptops |
| Desktop | ≥ 1024px | laptops, monitors |

**DevTools responsive testing:** F12 → device toggle icon (Ctrl+Shift+M) → resize or pick a preset device.

## 🧰 CSS reset / starter (paste at top of every stylesheet)
```css
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

img {
    max-width: 100%;
    height: auto;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 16px;
    line-height: 1.6;
    color: #333;
}
```

## ✍️ Integration Practice
> [!QUESTION]- Practice 1: Build a responsive card grid — 6 cards with a title, image, and description. 1 column on mobile, 2 on tablet, 3 on desktop. Cards have rounded borders, padding, and a subtle shadow. Include viewport meta tag. (uses: semantic HTML + Grid `auto-fit` or media queries + box model + responsive images)
> > [!SUCCESS]- Reference solution
> > ```html
> > <!DOCTYPE html>
> > <html>
> > <head>
> >   <meta charset="UTF-8">
> >   <meta name="viewport" content="width=device-width, initial-scale=1.0">
> >   <title>Card Grid</title>
> >   <style>
> >     * { box-sizing: border-box; margin: 0; padding: 0; }
> >     body { font-family: Arial, sans-serif; background: #f5f5f5; padding: 30px; }
> >     .grid {
> >       display: grid;
> >       grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
> >       gap: 20px; max-width: 1000px; margin: 0 auto;
> >     }
> >     .card {
> >       background: white; border: 1px solid #ddd; border-radius: 8px;
> >       padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.08);
> >     }
> >     .card img { width: 100%; border-radius: 4px; margin-bottom: 12px; }
> >     .card h3 { margin-bottom: 8px; color: #2c3e50; }
> >   </style>
> > </head>
> > <body>
> >   <div class="grid">
> >     <div class="card">
> >       <img src="https://picsum.photos/seed/1/600/400" alt="Sample 1">
> >       <h3>Card Title</h3><p>Description text here.</p>
> >     </div>
> >     <!-- repeat 5 more cards -->
> >   </div>
> > </body>
> > </html>
> > ```
> > - **Key move:** `repeat(auto-fit, minmax(280px, 1fr))` handles all breakpoints in one line — no media queries needed. `box-shadow` adds depth without a heavier border.

> [!QUESTION]- Practice 2: Build a page with a Flexbox navbar (logo left, links right), a Grid main area (content + 250px sidebar), and a footer. Style the nav links to highlight on hover. Mobile: nav stacks vertically, sidebar disappears. (uses: Flexbox nav + Grid page layout + semantic elements + media query + pseudo-class)
> > [!SUCCESS]- Reference solution
> > ```html
> > <style>
> >   * { box-sizing: border-box; margin: 0; padding: 0; }
> >   body { font-family: sans-serif; min-height: 100vh;
> >          display: grid; grid-template-rows: auto auto 1fr auto; }
> >   header { background: #2c3e50; color: white; padding: 20px 30px; }
> >   nav { display: flex; flex-direction: column; gap: 8px;
> >         background: #34495e; padding: 10px 30px; }
> >   nav a { color: #ecf0f1; text-decoration: none; }
> >   nav a:hover { color: white; text-decoration: underline; }
> >   .page { display: grid; grid-template-columns: 1fr;
> >           gap: 20px; padding: 20px; max-width: 1100px;
> >           margin: 0 auto; width: 100%; }
> >   aside { background: #ecf0f1; padding: 20px; border-radius: 8px;
> >           display: none; }
> >   footer { background: #2c3e50; color: #bdc3c7;
> >            text-align: center; padding: 15px; }
> >   @media (min-width: 768px) {
> >     nav { flex-direction: row; gap: 20px; }
> >     .page { grid-template-columns: 1fr 250px; }
> >     aside { display: block; }
> >   }
> > </style>
> > <header><h1>My Site</h1></header>
> > <nav><a href="#">Home</a><a href="#">Blog</a><a href="#">About</a></nav>
> > <div class="page">
> >   <main><h2>Content</h2><p>Main area here.</p></main>
> >   <aside><h3>Sidebar</h3><p>Links, ads, etc.</p></aside>
> > </div>
> > <footer><p>&copy; 2026</p></footer>
> > ```
> > - **Key move:** outer `body` Grid handles vertical stacking (header/nav/content/footer with `1fr` on the content row to push the footer down); inner `.page` Grid handles the horizontal content + sidebar split. `display: none` + media query for the sidebar keeps mobile clean.

> [!QUESTION]- Practice 3: Build a styled registration form — name (required), email (required), password (required), age (number, min 13), country (dropdown, 4 options), terms checkbox (required), submit button. Style inputs with consistent width, focus glow, and a coloured button that darkens on hover. Wrap in semantic elements. (uses: form elements + validation attributes + label linking + CSS selectors + pseudo-classes + box model)
> > [!SUCCESS]- Reference solution
> > ```html
> > <main>
> > <h1>Register</h1>
> > <form>
> >   <label for="name">Full name</label>
> >   <input type="text" id="name" name="name" required>
> >   <label for="email">Email</label>
> >   <input type="email" id="email" name="email" required>
> >   <label for="pass">Password</label>
> >   <input type="password" id="pass" name="password" required>
> >   <label for="age">Age</label>
> >   <input type="number" id="age" name="age" min="13">
> >   <label for="country">Country</label>
> >   <select id="country" name="country">
> >     <option value="">-- Select --</option>
> >     <option value="MY">Malaysia</option>
> >     <option value="SG">Singapore</option>
> >     <option value="AU">Australia</option>
> >     <option value="ID">Indonesia</option>
> >   </select>
> >   <div class="checkbox-row">
> >     <input type="checkbox" id="terms" name="terms" required>
> >     <label for="terms">I agree to the terms</label>
> >   </div>
> >   <button type="submit">Register</button>
> > </form>
> > </main>
> > ```
> > ```css
> > form { max-width: 400px; background: white; padding: 32px;
> >        border-radius: 8px; border: 1px solid #ddd; }
> > label { display: block; margin-bottom: 4px; font-weight: bold; }
> > input[type="text"], input[type="email"], input[type="password"],
> > input[type="number"], select {
> >   width: 100%; padding: 10px; border: 1px solid #ccc;
> >   border-radius: 4px; margin-bottom: 16px; font-size: 1rem;
> > }
> > input:focus, select:focus {
> >   border-color: #2980b9; outline: none;
> >   box-shadow: 0 0 0 3px rgba(41,128,185,0.2);
> > }
> > button[type="submit"] {
> >   background: #2980b9; color: white; border: none;
> >   padding: 12px 24px; border-radius: 4px; cursor: pointer;
> > }
> > button[type="submit"]:hover { background: #1f6fa0; }
> > .checkbox-row { display: flex; align-items: center; gap: 8px;
> >                 margin-bottom: 16px; }
> > .checkbox-row label { display: inline; margin: 0; font-weight: normal; }
> > ```
> > - **Key move:** `label { display: block }` replaces `<br>` tags; attribute selector `input[type="email"]` targets specific types; `:focus` pseudo-class + `box-shadow` replaces the browser's default outline with a softer glow.

## ⚠️ Common Mistakes (top debugging targets)
- 💡 **Forgot `* { box-sizing: border-box; }`** ➔ `width: 300px` + `padding: 20px` + `border: 5px` = 350px actual. Boxes overflow everywhere.
- 💡 **Forgot viewport meta tag** ➔ page looks perfect on laptop, tiny text on phones.
- 💡 **Styles don't apply — no error shown** ➔ check in order: (1) typo in class name, (2) missing `<link>` to stylesheet, (3) specificity conflict (ID beats class), (4) browser cache (Ctrl+Shift+R to hard refresh).
- 💡 **`margin: 0 auto` doesn't center** ➔ the element has no `width` or `max-width` set — `auto` needs a constraint.
- 💡 **Images overflow their container** ➔ add global rule `img { max-width: 100%; height: auto; }`.
- 💡 **Headings used for size, not structure** ➔ `<h3>` after `<h1>` because you want smaller text → wrong; use CSS `font-size` to control appearance, headings define document outline.
- 💡 **`justify-content` vs `align-items` confusion** ➔ `justify` = main axis, `align` = cross axis. If `flex-direction: column`, main axis is *vertical* (swapped).
- 💡 **Radio buttons not grouped** ➔ each radio has a different `name` → they behave as independent checkboxes.
- 💡 **Missing `<label for="id">`** ➔ clicking the text doesn't focus the input; screen readers can't announce the field.
- 💡 **Desktop-first media queries** ➔ writing `max-width` queries that undo complexity → harder to maintain. Write mobile-first with `min-width` instead.
