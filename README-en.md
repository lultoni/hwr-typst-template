# HWR Berlin — Typst Template

**Deutsch:** → [README.md](README.md)

A community-built Typst template for scientific papers at HWR Berlin (Berlin School of Economics and Law), primarily targeting students in the *Wirtschaftsinformatik* (Business Informatics) programme. It automates cover pages, tables of contents, abbreviation lists, the statutory declaration, and more — all conforming to the HWR formatting guidelines as of January 2025.

---

Automatic formatting for Praxistransferberichte, Haus-/Studien- und Bachelorarbeiten at HWR Berlin.
Compliant with the HWR guidelines **as of January 2025** — for all cohorts.

You focus on the content. The template handles the rest:
- Cover page with all required fields
- Table of contents, list of abbreviations, list of figures/tables
- Page numbering (Roman → Arabic, automatic switch)
- Statutory declaration with 2025 AI clause
- AI tools register (when AI tools were used)

> **Something not working?** → [Common Issues](#common-issues)

---

## What is Typst?

Typst is a writing tool — similar to Word, but you write in plain text files (`.typ`) instead of a graphical editor. The template then automatically handles all formatting. You compile the finished files to PDF with a single click or command.

**Advantage:** No manual formatting work, no fighting with page breaks, no style conflicts — and the PDF renders in milliseconds.

**Typst reference and documentation** → [typst.app/docs](https://typst.app/docs)

---

## Step 1: Install Typst

The template requires **Typst 0.13.1 or newer**.

### macOS

1. Open Terminal (Applications → Utilities → Terminal)
2. Type:
   ```
   brew install typst
   ```
   If `brew` is not installed: [https://brew.sh](https://brew.sh) — copy the install command from there, run it, then run `brew install typst` again.

### Windows

1. Open PowerShell (Start menu → search for "PowerShell")
2. Type:
   ```
   winget install --id Typst.Typst
   ```
   Alternatively: download the Windows installer at [typst.app/download](https://typst.app/download).

### Linux

```bash
# Ubuntu/Debian:
sudo snap install typst

# Arch:
sudo pacman -S typst

# Or via cargo:
cargo install typst-cli
```

### Verify the installation

After installing, run in the terminal:
```
typst --version
```
→ A version number should appear (e.g. `typst 0.14.2`). An `(unknown hash)` suffix can be ignored.

---

## Step 2: Install the font

The template uses **Times New Roman** (required by HWR).

- **Windows/macOS:** Already pre-installed — no action needed.
- **Linux:** In the terminal:
  ```bash
  sudo apt install ttf-mscorefonts-installer   # Ubuntu/Debian
  # or:
  sudo apt install fonts-liberation
  ```

---

## Step 3: Set up a project — two options

### Option A — Typst Universe (one command)

Run the following command in the terminal (in the directory where you want your project folder):
```bash
typst init @preview/easy-wi-hwr:0.1.1 my-paper
```
→ `my-paper` is the folder name and can be changed.

This instantly creates a ready-to-use project folder with a pre-filled `main.typ`.

### Option B — Interactive setup script (optional, for beginners)

The script asks you all the questions and creates a fully pre-filled `main.typ` with your data.
You can run it locally after downloading the ZIP:

On the GitHub page: **Code → Download ZIP** → unzip, then:
```bash
# Open a terminal in the unzipped folder, then:
bash scripts/init.sh
```

The script asks you step by step:
- Where should the project be created?
- Project folder name
- Type of paper (PTB, Hausarbeit, Bachelorarbeit, …)
- Your name and student ID
- Title, supervisor, company, field of study, cohort
- Desired number of chapters

At the end you have a ready-to-use project folder with a pre-filled `main.typ`.

> **Note:** Briefly review the script before running it: [scripts/init.sh](https://github.com/lultoni/hwr-typst-template/blob/b896349435398df149f88e27f6cb3fd92a3883e2/scripts/init.sh)

---

## Step 4: Writing

Open the project folder in a text editor. Recommended: **VS Code** (free, [code.visualstudio.com](https://code.visualstudio.com)) with the **Tinymist** extension for syntax highlighting, but any text editor works.

```
my-paper/
├── main.typ            ← your metadata (title, name, …) — this is where you configure
├── refs.bib            ← your references
├── kapitel/
│   ├── 01_einleitung.typ   ← write here
│   ├── 02_theoretische_grundlagen.typ
│   └── ...
└── anhang/
    └── beispiel.typ        ← appendix template
```

**Writing in chapter files:**
```typst
= Introduction

Here begins the text of the first chapter.

== Background

*Bold* and _italic_ work like this.

Footnote#footnote[Footnote text goes here.] inline in the text.

Citation: According to @mustermann2024...

Abbreviation on first use: #abk("AI")
```

**Abbreviations** work fully automatically:
- First use: `#abk("AI")` → outputs "Artificial Intelligence (AI)"
- All subsequent uses: `#abk("AI")` → outputs "AI"
- The list of abbreviations is created automatically

You define abbreviations once in `main.typ`:
```typst
abbreviations: (
  "AI":  "Artificial Intelligence",
  "HWR": "Berlin School of Economics and Law",
  "ERP": "Enterprise Resource Planning",
),
```

**Alternative: Everything in one file** — you can also work without separate chapter files. Leave `chapters:` empty and write all your text directly in `main.typ` after the settings block. Insert `#pagebreak()` between chapters so each starts on a new page (with `chapters:` this happens automatically):

```typst
#show: hwr.with(
  doc-type: "ptb-1",
  title: "My Title",
  // ... remaining settings ...
)

= Introduction

My text starts directly in main.typ.

#pagebreak()
= Background

Second chapter...
```

For shorter papers (e.g. Hausarbeiten) this is often simpler. For longer work, separate files in `kapitel/` are recommended.

---

## Step 5: Create the PDF

```bash
# In your project folder (e.g. cd my-paper):

# Compile once:
typst compile main.typ

# With live compilation (updates on every save):
typst watch main.typ
# Stop: Ctrl+C
```

The finished PDF is placed right next to `main.typ`.

### VS Code + Tinymist

Tinymist provides syntax highlighting and autocomplete for `.typ` files. You can also compile directly from VS Code — Tinymist shows a live preview in the editor window.

---

## References

References go in the `refs.bib` file. Format examples (Citavi, Zotero, or Google Scholar can export these files automatically):

```bibtex
@book{mustermann2024,
  author    = {Mustermann, Max},
  title     = {Book Title},
  year      = {2024},
  publisher = {Publisher},
}

@online{source2024,
  author  = {Author, Firstname},
  title   = {Website Title},
  year    = {2024},
  url     = {https://example.com},
  urldate = {2024-01-01},
}
```

Cite in the text with `@key`, e.g. `@mustermann2024`.

---

## AI Tools (required if AI was used)

If you used AI tools such as ChatGPT, Copilot, or DeepL, you must declare this per HWR §3.8.
In `main.typ`:

```typst
ai-tools: (
  (
    tool:     "ChatGPT 4o",
    usage:    "Text suggestions, marked in the text",
    chapters: "Chapter 1, p. 3",
    remarks:  "Prompts: see Appendix 1",  // also "bemerkungen:" works
  ),
  (
    tool:     "DeepL Translator",
    usage:    "Translation of English source passages",
    chapters: "Entire paper",
  ),
),
```

The AI tools register is automatically inserted as the last appendix item. With `ai-tools: ()` no register appears.

---

## Group Work

Simply add more authors:

```typst
authors: (
  (name: "Max Mustermann", matrikel: "12345678"),
  (name: "Lisa Müller",    matrikel: "87654321"),
),
```

The statutory declaration automatically switches to "We declare…" and both authors receive a signature field.

**Only one representative signature** (e.g. for digital submission on behalf of the group — please clarify with your examiner):

```typst
group-signature: false,  // only the first author signs
```

The template then shows a yellow notice in the PDF reminding you to clarify this with your examiner.

---

## Digital Signature (optional)

Instead of an empty line for a handwritten signature, you can embed an image of your signature:

1. Sign on white paper, scan or photograph it
2. Save as PNG or SVG under `images/` in your project folder
3. Add to the author entry in `main.typ`:

```typst
authors: (
  (name: "Max Mustermann", matrikel: "12345678", signature: image("images/signature_max.png")),
),
```

The image then appears automatically in the signature field of the statutory declaration.

---

## Confidentiality Notice

If parts of the paper are confidential (§3.2.1):

```typst
// Entire paper confidential:
confidential: true,

// Only specific chapters:
confidential: (
  chapters: (
    (number: "3", title: "Methodology"),
    (number: "4", title: "Results"),
  ),
  filename: "PTB_Mustermann_public.pdf",  // optional
),
```

The required text is inserted automatically and appears before the cover page.

---

## English Papers

```typst
lang: "en",
citation-style: "harvard-anglia-ruskin-university",
```

All index headings, the statutory declaration, and the AI tools register switch to English automatically. The Harvard CSL file (Anglia Ruskin University) is included in the template and loaded automatically — no manual download needed (HWR §6).

---

## Good to Know

**Citation style:** Default is APA (for German-language papers). For English papers: `citation-style: "harvard-anglia-ruskin-university"` — the CSL file is included. If your supervisor requires a different style, you can download a `.csl` file from the [Zotero Style Repository](https://www.zotero.org/styles) and include it via `read()`:
```typst
citation-style: read("my-style.csl"),
```
`read()` is resolved in `main.typ` — the path is relative to `main.typ`.

**The list of abbreviations appears automatically**, but only if:
- Abbreviations are entered in `abbreviations:`, AND
- `#abk("XY")` is used at least once in the text

Unused abbreviations do not appear in the list.

**List of figures and list of tables** appear only from 5 entries onwards (HWR requirement). The template checks this automatically.

**Submission as Word + PDF:** HWR requires both formats. The template only generates PDF. The Word version must be created separately (e.g. via Pandoc or copy-paste).

---

## All Parameters at a Glance

### Required Fields

| Parameter | Description |
|---|---|
| `doc-type` | Type of paper: `"ptb-1"`, `"ptb-2"`, `"ptb-3"`, `"hausarbeit"`, `"studienarbeit"`, `"bachelorarbeit"` |
| `title` | Paper title |
| `authors` | Array: `((name: "...", matrikel: "..."),)` |

### Required Depending on Document Type

| Parameter | Required for | Description |
|---|---|---|
| `supervisor` | All except Bachelorarbeit | Supervising examiner with title |
| `company` | All except Bachelorarbeit | Name of training company |
| `first-examiner` | Bachelorarbeit | First examiner with title |
| `second-examiner` | Bachelorarbeit | Second examiner with title |

### Optional Fields

| Parameter | Default | Description |
|---|---|---|
| `lang` | `"de"` | Document language — `"de"` or `"en"` |
| `field-of-study` | `"Wirtschaftsinformatik"` | Field of study |
| `cohort` | — | Study cohort, e.g. `"2024"` |
| `semester` | — | Study semester, e.g. `"3"` |
| `date` | `auto` | Submission date; `auto` = today's date, or manual: `"15 March 2026"` |
| `abstract` | `none` | Abstract before the table of contents |
| `confidential` | `none` | Confidentiality notice — `none`, `true`, or `(chapters: (...), filename: ...)` |
| `abbreviations` | `(:)` | Abbreviations as a dictionary |
| `glossary` | `()` | Glossary entries for technical terms (without their own abbreviation) |
| `ai-tools` | `()` | AI tools register entries — `(tool, usage, chapters, remarks?)` |
| `chapters` | `()` | Chapter files via `include()` in desired order |
| `appendix` | `()` | Appendix entries: `(title: "...", content: include(...))` |
| `show-appendix-toc` | `false` | `true` = optional appendix table of contents before the appendix entries (HWR §3.10) |
| `bibliography` | — | `bibliography("refs.bib")` — title is set automatically |
| `citation-style` | `"apa"` | Citation style: `"apa"` (DE), `"harvard-anglia-ruskin-university"` (EN, included), or `read("file.csl")` |
| `heading-depth` | `4` | TOC depth 1–4 (max. 4 per HWR) |
| `declaration-lang` | `auto` | Language of the statutory declaration — `auto` follows `lang`, `"de"` always German |
| `city` | `"Berlin"` | City in the signature field of the statutory declaration |
| `group-signature` | `auto` | `auto`/`true` = all authors sign; `false` = only first author |

### Fields in the `authors` Array

| Field | Required | Description |
|---|---|---|
| `name` | Yes | Full name |
| `matrikel` | Yes | Student ID number |
| `signature` | No | Signature image as content, e.g. `image("images/signature.png")` |

---

## Common Issues

| Problem | Solution |
|---|---|
| `doc-type "..." is invalid` | Value must be exactly `"ptb-1"`, `"ptb-2"`, `"ptb-3"`, `"hausarbeit"`, `"studienarbeit"`, or `"bachelorarbeit"` |
| `supervisor is required for...` | For all types except `"bachelorarbeit"`, `supervisor:` and `company:` must be set |
| `authors must be an array of dicts` | `authors:` must be an array: `authors: ((name: "...", matrikel: "..."),)` — don't forget the comma after the closing parenthesis for a single author! |
| `chapters entries must use include()` | Do not use string paths. Correct: `chapters: (include("kapitel/01.typ"),)` instead of `chapters: ("kapitel/01.typ",)` |
| Times New Roman missing (Linux) | `sudo apt install ttf-mscorefonts-installer` |
| Abbreviation not appearing in list | `#abk("XY")` must be used in the text — only used abbreviations appear |
| AI tools register missing | `ai-tools:` needs at least one entry; with `ai-tools: ()` no register appears |
| List of figures missing | Appears only from 5 figures onwards (HWR requirement) |
| Chapter not appearing in PDF | Check that the file is listed in the `chapters:` list in `main.typ` |
| Import error with `include()` | Paths in `chapters:` are relative to `main.typ` — `include("kapitel/01_einleitung.typ")` |
| `signature muss image-Content sein` | Use `signature: image("images/sig.png")` instead of `signature: "images/sig.png"` |
| All pages doubled / strange formatting | Only one `#show: hwr.with(...)` block per file — no second `#show:` and no text before it |

---

## License

MIT — see LICENSE
