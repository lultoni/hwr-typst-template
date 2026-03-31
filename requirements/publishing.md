# PUB — Publishing to Typst Universe

Diese Datei dokumentiert den Veröffentlichungsprozess für das Template auf Typst Universe sowie alle Regeln und Constraints, die dabei gelernt wurden. Quelle: typst/packages CONTRIBUTING + direkte Erfahrung aus der v0.1.0-Submission.

## Two-Repo Workflow

| Repo | Zweck | Pfad |
|---|---|---|
| `lultoni/hwr-typst-template` | Development — hier wird normal gearbeitet | (this repo) |
| `lultoni/packages` (fork von `typst/packages`) | Publishing — hier landen Releases | `../typst-packages/` |

- Entwicklung läuft ausschließlich in `hwr-typst-template/`.
- Der Fork `lultoni/packages` ist ein reines Publish-Vehikel — keine Entwicklung dort.
- Jedes neue Release = neuer Ordner `packages/preview/easy-wi-hwr/{version}/` im Fork + neuer PR.
- `scripts/publish.sh` automatisiert das Kopieren und Vorbereiten des Release-Ordners.

## Release-Prozess (Schritt für Schritt)

| Schritt | Aktion |
|---|---|
| 1 | Entwicklung abschließen und Template lokal testen (`typst compile --root . template/main.typ`) |
| 2 | `version` in `typst.toml` bumpen (SemVer — Regeln: VER-01–07 in `ux-and-versioning.md`) |
| 3 | README aktualisieren — insbesondere `typst init @preview/easy-wi-hwr:X.Y.Z`-Beispiele |
| 4 | `bash scripts/publish.sh` aus dem Template-Root ausführen |
| 5 | PR im Fork öffnen (Titel: `easy-wi-hwr:X.Y.Z`) |
| 6 | Warten bis CI grün ist, dann auf Maintainer-Review warten |

## Typst Universe Submission Rules

### Package-Metadaten (`typst.toml`)

| ID | Regel | Wert / Beispiel | Quelle |
|---|---|---|---|
| PUB-01 | Package-Name: `{unique-part}-{descriptive-part}` | `easy-wi-hwr` ✓ | CONTRIBUTING |
| PUB-02 | Description: 40–60 Zeichen, endet mit Punkt, kein "A/An" am Anfang, kein "typst" | `"Paper template for HWR Berlin (Wirtschaftsinformatik)."` (54 Zeichen) ✓ | CONTRIBUTING |
| PUB-03 | `categories`: nur Werte aus der erlaubten Liste | `["thesis"]` ✓ | CONTRIBUTING |
| PUB-04 | `thumbnail` darf NICHT in `exclude` stehen — wird automatisch ausgeschlossen | Nicht in `exclude` eintragen | CONTRIBUTING |
| PUB-05 | `version` in `typst.toml` ist Source of Truth — muss vor jedem Publish gebumpt werden | VER-05 | CONTRIBUTING |

**Erlaubte `categories`-Werte:**
- Publication: `thesis`, `paper`, `poster`, `flyer`, `cv`, `presentation`, `book`, `report`
- Functional: `components`, `visualization`, `model`, `layout`, `text`, `languages`, `scripting`, `integration`, `utility`, `fun`

### Template-Entrypoint

| ID | Regel | Quelle |
|---|---|---|
| PUB-10 | Das Template muss ohne User-Änderungen out-of-the-box kompilieren | CONTRIBUTING |
| PUB-11 | Alle Imports in Template-Dateien müssen `@preview/easy-wi-hwr:x.y.z`-Style verwenden — niemals relative Pfade wie `../../lib.typ` | CONTRIBUTING |

### PR-Format

| ID | Regel | Beispiel |
|---|---|---|
| PUB-20 | PR-Titel: exakt `{package-name}:{version}` | `easy-wi-hwr:0.1.0` |
| PUB-21 | Einmal veröffentlichte Version-Ordner sind immutable — niemals nachträglich editieren | — |

## Dateien im Published Bundle

### Was wird ausgeschlossen (`exclude` in `typst.toml`)

| Pfad | Grund |
|---|---|
| `reference-templates/` | Private Analyse-Materialien |
| `hwr-richtlinien/` | HWR-interne PDFs |
| `.claude/` | Claude Code Konfiguration |
| `requirements/` | Interne Dev-Spezifikationen |
| `scripts/` | Dev-Tooling |
| `.github/` | CI-Workflows |
| `test-*/` | Alle Test-Projektordner (Glob) |

### Was `publish.sh` nach dem Kopieren entfernt

| Datei | Grund |
|---|---|
| `template/main.pdf` | Build-Artefakt |
| `template/thumbnail.png` | Duplikat des Root-Thumbnails |
| `.DS_Store` | macOS-Metadaten |

`CLAUDE.md`, `requirements/`, `scripts/` etc. werden gar nicht erst kopiert — `publish.sh` kopiert nur die explizit gelisteten Dateien/Ordner.

**Wichtig:** `thumbnail.png` darf weder im `exclude`-Feld noch durch `publish.sh` entfernt werden — es muss im veröffentlichten Bundle enthalten sein (PUB-04).

## Lessons Learned (v0.1.0 Submission)

| Problem | Ursache | Fix |
|---|---|---|
| Description zu lang (63 Zeichen) | Initiale Beschreibung überschritt 60-Zeichen-Limit | Auf 54 Zeichen gekürzt: `"Paper template for HWR Berlin (Wirtschaftsinformatik)."` |
| Falscher Package-Name in Kommentar (`@preview/hwr-berlin:0.1.0`) | Copy-Paste-Fehler in `lib.typ` | Auf `@preview/easy-wi-hwr:0.1.0` korrigiert |
| CI-Fehler: `unknown fields: ["dependencies"]` | `[dependencies]`-Sektion in `typst.toml` ist kein gültiges Universe-Manifest-Feld | Sektion entfernt — Typst löst `@preview/`-Imports zur Compile-Zeit automatisch auf |
| README-Warnung: Link auf `main`-Branch | `typst-package-check` warnt vor Links auf Default-Branch, die driften können | Permalink auf konkreten Commit-SHA ersetzt |
