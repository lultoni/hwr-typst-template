# IMPL — Implementierungserkenntnisse

Diese Datei dokumentiert technische Implementierungsentscheidungen und kritische Code-Patterns für das Template. Sie erklärt das WIE — die Anforderungen (WAS) stehen in `formatting.md`, `structure.md` etc.

## Package-Entscheidungen

| Feature | Gewähltes Package | Begründung |
|---|---|---|
| Lokalisierung | `@preview/linguify` | Einzige stabile DE/EN-Option in Typst; von clean-hwr etabliert |
| Glossar | `@preview/glossarium` | Etabliertes Paket; first-use-Expansion eingebaut |
| Abkürzungen | Eigene `abk()`-Implementierung | ptb-Pattern ist einfacher für User; kein Seitennachweis (HWR-konform, STR-41) |
| Bibliographie | APA als Default (Typst built-in) | APA für DE, Harvard Anglia Ruskin für EN; beliebige `.csl`-Datei konfigurierbar |
| Wortzählung | wordometer — **nicht in v1.0** | Nice-to-have; v1.1-Kandidat |

## Kritische Patterns (Anti-Regression)

### 1. Abbreviation Tracking

Erste Verwendung: `#abk("KI", "Künstliche Intelligenz")` → expandiert zu "Künstliche Intelligenz (KI)".
Weitere Verwendungen: `#abk("KI")` → gibt nur "KI" aus.

Mechanismus: `state("abk-dict")` speichert Definitionen; `query(selector(<abk>).before(here()))` prüft ob das Label schon vorkommt. Wichtig: Label `[#metadata(key) #label("abk")]` muss **vor** dem heading stehen — inline-Labels in Heading-Content sind nicht erlaubt.

### 2. Bedingte Verzeichnisse

```typst
let figs = query(figure.where(kind: image))
let tabs = query(figure.where(kind: table))
if figs.len() >= 5 { /* Abbildungsverzeichnis */ }
if tabs.len() >= 5 { /* Tabellenverzeichnis */ }
```

Schwellenwert ≥5 aus STR-05/06. Dieser Check läuft im `context`-Block da `query()` kontextabhängig ist.

### 3. Seitennummerierungs-Zustand

Sequenz: `none` (Sperrvermerk) → `none` sichtbar / counter bei I (Deckblatt) → `"I"` (Verzeichnisse) → `"1"` (Haupttext).

```typst
// Bei erster Textseite:
counter(page).update(1)
set page(numbering: "1")
```

Das Deckblatt wird in der römischen Zählung mitgezählt (FMT-30), ist aber nicht sichtbar — `numbering: none` mit manuellem `counter(page).update(1)` löst das.

### 4. Lokalisierung mit linguify

```typst
// Initialisierung (einmalig in lib.typ):
set-database(eval(load-ftl-data("./l10n", ("de","en"))))
// NICHT: show: set-database.with(...) — das funktioniert nicht
```

FTL-Multiline-Werte brauchen 4+ Leerzeichen Einrückung für Fortsetzungszeilen. Selektoren (`{ $var -> ... }`) brauchen 8+ Leerzeichen.

### 5. Chapter imports

`include()` muss in `main.typ` aufgerufen werden (nicht in `lib.typ`), weil Typst Pfade relativ zur aufrufenden Datei auflöst. `chapters:` erhält bereits evaluierten Typst-Content, keine Dateinamen-Strings.

### 6. Compile-Befehl

```bash
typst compile --root . template/main.typ
```

`--root .` ist nötig für Cross-Directory-Imports (z.B. `../../lib.typ` aus `template/kapitel/`). Ohne `--root .` schlägt der Import fehl.

### 7. Anhang-Nummerierung

Arabische Zahlen (1, 2, 3…) — kein Buchstaben-System. Kein 26-Eintrags-Limit. Konsistent mit Seiten- und Kapitel-Nummerierung. Entscheidung: `[DECIDED]`.

## Ehrenwörtliche Erklärung: Pflichttext-Quelle

Vollständiger Pflichttext (DE + EN, Singular + Plural) in `l10n/de.ftl` und `l10n/en.ftl`. Linguify rendert automatisch die richtige Variante basierend auf Autorenanzahl. Text §3.11-konform inkl. 2025-KI-Klausel.
