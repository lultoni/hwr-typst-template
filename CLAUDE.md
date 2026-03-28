# HWR Typst Template

A universal, public Typst template for academic papers at HWR Berlin (Wirtschaftsinformatik).
Complies with the HWR guidelines effective January 2025 (all cohorts).

## Project Goal

Create a clean, reusable template that any HWR student can use without formatting overhead.
Prio 1: `main.typ` is the only file the user touches — all formatting, numbering, indices,
and the AI tools register are fully automatic.

## Repository Structure

```
hwr-typst-template/
├── lib.typ                  # Main template entry point; public API: hwr(), abk(), gls(), glspl()
├── typst.toml               # Package metadata (version is source of truth)
├── template/                # Example/starter files for users
│   ├── main.typ             # Complete usage example with all parameters commented
│   ├── refs.bib             # Example bibliography
│   ├── kapitel/             # Example chapter files (01–05)
│   ├── anhang/              # Example appendix files (a, b, c)
│   └── images/              # Placeholder + signature_example.svg
├── pages/                   # Modular page components
│   ├── title_page.typ
│   ├── declaration.typ
│   ├── abstract.typ
│   ├── confidentiality.typ
│   ├── indices.typ
│   └── appendix.typ
├── helper/                  # Utility functions
│   ├── abbreviations.typ    # abk() — first-use expansion via state+query
│   └── date.typ             # format-date() — localized date formatting
├── l10n/                    # Localization (de/en)
│   ├── de.ftl
│   └── en.ftl
├── requirements/            # Structured requirements (FMT/STR/CNT/CIT/DOC/API/UX/IMPL)
├── hwr-richtlinien/         # HWR official guidelines (PDF, not committed)
└── .claude/                 # Claude Code configuration
```

## HWR Formatting Summary (2025)

Full details in `requirements/formatting.md`. Key values:
- Times New Roman 12pt, 1.5-line spacing, block justification, hyphenation
- Margins: 30mm top / 35mm right / 20mm bottom / 21mm left
- Page numbers: none (cover) → Roman I, II… (front matter) → Arabic 1, 2… (body + appendix + declaration)
- Indices only if ≥ 5 entries; declaration must include 2025 AI clause

## Document Types

`"ptb-1"` / `"ptb-2"` / `"ptb-3"` / `"hausarbeit"` / `"studienarbeit"` / `"bachelorarbeit"`

Details and conditional fields → `requirements/document-types.md`

## Agent Roles

### `analyze` — Research & Understanding
Questions about code, HWR guidelines, design decisions, comparing approaches.
- Read relevant files first; provide structured analysis; do NOT write code speculatively.

### `implement` — Feature Development
Writing Typst code, new page components, formatting rules, bug fixes.
- Check lib.typ + relevant pages/ before writing; verify HWR compliance; no personal data.

### `document` — Documentation
Updating README, CLAUDE.md, requirements/, inline comments, l10n sync.
- Run after implementation changes; ensure template/main.typ reflects all features.

### `review` — Quality & Compliance
HWR guideline compliance, no-personal-data check, consistency across files.
- Check all components against 2025 guidelines; verify both de/en l10n keys exist.

## Workflow

1. Identify which agent role applies before acting.
2. Read relevant existing files before implementing.
3. After significant changes: update docs, then commit with `/commit`.
4. Keep `requirements/` current: new constraints or decisions get a new ID in the right file.
5. Keep this file current: stale CLAUDE.md causes drift.

## Key Conventions

- Template parameters: kebab-case (`doc-type`, `field-of-study`, `first-examiner`)
- All user-facing strings: through l10n — never hardcoded DE/EN
- Example values: clearly fake data only (`"Max Mustermann"`, `"12345678"`, `"Muster GmbH"`)
- No real names, Matrikelnummern, or company names anywhere in the repo
- Appendix numbering: Arabic digits 1, 2, 3… (not A, B, C)
- `chapters:` takes `include()` content arrays in `main.typ` — paths resolve relative to `main.typ`

## Reference Materials (local, not committed)

- `reference-templates/clean-hwr-main/` — published HWR template (v0.2.0, MIT)
- `reference-templates/ptb-typst-template-main/` — student PTB example (reference only)
- `hwr-richtlinien/Richtlinien...2025.pdf` — official HWR guidelines PDF
