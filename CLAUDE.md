# HWR Typst Template

A universal, public Typst template for academic papers at HWR Berlin (Wirtschaftsinformatik).
Complies with the HWR guidelines effective January 2025 (all cohorts).

## Project Goal

Create a clean, reusable template that any HWR student can use without formatting overhead.
Based on analysis of existing student templates and the official 2025 HWR guidelines.

## Repository Structure

```
hwr-typst-template/
├── lib.typ                  # Main template entry point
├── typst.toml               # Package metadata
├── template/                # Example/starter files for users
│   ├── main.typ             # Example document using the template
│   └── refs.bib             # Example bibliography
├── pages/                   # Modular page components
│   ├── title_page.typ
│   ├── declaration.typ
│   ├── abstract.typ
│   ├── confidentiality.typ
│   └── indices.typ
├── helper/                  # Utility functions
│   └── abbreviations.typ    # Smart abbreviation handling (first-use expansion)
├── l10n/                    # Localization (de/en)
│   ├── de.ftl
│   └── en.ftl
├── hwr-richtlinien/         # HWR official guidelines (PDF, not committed)
│   └── notice.md
├── .claude/                 # Claude Code configuration
│   └── settings.json
└── CLAUDE.md                # This file
```

## HWR Formatting Requirements (2025)

- **Font:** Times New Roman, 12pt (body text)
- **Footnotes/Captions:** 10pt
- **Spacing:** 1.5-line spacing
- **Justification:** Block (Blocksatz), with hyphenation
- **Margins:** 30mm top, 35mm right, 20mm bottom, 21mm left
- **Page numbering:**
  - Cover page: none
  - Front matter (TOC, abbreviations, indices): Roman (I, II, III…)
  - Main content: Arabic (1, 2, 3…)
- **Headings:** Numbered format 1 / 1.1 / 1.1.1 (max 4 levels in TOC)
- **Indices:** Figure/table indices only generated if ≥ 5 entries
- **Citation:** Harvard (Anglia Ruskin) for English; APA-style for German
- **Declaration:** Must include AI tool usage clause (2025 requirement)

## Document Types Supported

1. **PTB** (Praxistransferbericht) — dual study transfer report
2. **Seminararbeit** — seminar paper
3. **Studienarbeit** — study paper
4. **Bachelor-Thesis** — bachelor thesis

## Agent Roles

Each agent specializes in a domain. When processing a user prompt, determine which agent role applies:

### `analyze` — Deep Research & Analysis
Use for: questions about the codebase, HWR guidelines interpretation, design decisions,
comparing approaches, reading reference templates, understanding existing code.
- Always reads relevant files before answering
- Provides structured analysis with pros/cons
- Does NOT write code speculatively

### `implement` — Feature Development
Use for: writing new Typst template code, adding document type support, implementing
formatting rules, creating new page components.
- Follows existing code conventions (check lib.typ and pages/ before writing)
- Checks HWR guidelines compliance before finalizing
- Writes modular, reusable components
- Avoids personal data in any form

### `document` — Documentation Updates
Use for: updating README, adding usage examples, keeping CLAUDE.md current,
writing inline comments for complex Typst logic.
- Runs after significant implementation changes
- Ensures template/main.typ reflects all features
- Keeps l10n files in sync

### `review` — Quality & Compliance
Use for: verifying HWR guideline compliance, checking for personal data leakage,
code quality review, consistency checks across pages.
- Checks all page components against 2025 guidelines
- Verifies no personal data in committed files
- Ensures bilingual (de/en) support is maintained

## Workflow

1. **Before answering/implementing:** identify which agent role applies
2. **For implementation:** read relevant existing files first, then implement
3. **After significant changes:** run document agent pass, then commit
4. **Commit trigger:** ≥ 3 files changed OR any new feature complete
5. **Keep this file current:** When new agents, hooks, conventions, or patterns are established, update CLAUDE.md immediately. This file is the source of truth for working in this repo — stale instructions cause drift.
6. **Keep requirements/ current:** When new requirements emerge from user input, HWR guideline clarifications, or implementation discoveries, append them to the appropriate requirements/*.md file with a new ID. Never leave implied requirements undocumented.
7. **Keep .claude/settings.json current:** When workflow improvements are identified (new hook patterns, better routing rules, permission adjustments), update settings.json. Hooks should reflect the actual current workflow, not a snapshot of setup day.

## Key Conventions

- Template parameters use snake_case
- Localization keys match between `de.ftl` and `en.ftl`
- All user-facing strings go through l10n (no hardcoded German/English)
- Example values in template/main.typ use clearly fake data (e.g., "Max Mustermann")
- No real names, Matrikelnummern, or company names anywhere in the repo
- Abbreviation function auto-expands on first use, abbreviates thereafter

## Reference Materials (local, not committed)

- `reference-templates/clean-hwr-main/` — published HWR template (v0.2.0, MIT)
- `reference-templates/ptb-typst-template-main/` — student PTB template (contains real data, reference only)
- `hwr-richtlinien/Richtlinien...2025.pdf` — official HWR guidelines PDF
