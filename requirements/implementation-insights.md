# IMPL — Implementierungserkenntnisse aus Reference-Template-Analyse
> Quelle: Tiefenanalyse clean-hwr-main v0.2.0 und ptb-typst-template-main

## Compliance-Übersicht: Was welches Template richtig macht

| Anforderung | clean-hwr | ptb-typst | → Neue Template-Strategie |
|---|---|---|---|
| Font Times New Roman 12pt | ✗ TeX Gyre | ✓ | Hardcoded wie ptb |
| 1.5-Zeilenabstand | ✗ fehlt | ✓ `spacing: 1.5em` | Hardcoded wie ptb |
| Margins 30/35/20/21mm | ✗ fehlt | ✓ | Hardcoded wie ptb |
| KI-Erklärungsklausel | ✗ nicht vorhanden | ✓ vollständig | Volltext aus Richtlinien §3.11 |
| Abkürzungen auto-tracking | ✗ manuell | ✓ `query(<abk>)` | ptb-Ansatz übernehmen |
| Verzeichnisse ≥5-Check | ✗ manuell | ✓ `if figs.len() >= 5` | ptb-Ansatz übernehmen |
| Lokalisierung DE/EN | ✓ linguify | ✗ nur DE | clean-hwr-Ansatz übernehmen |
| Modulare Architektur | ✓ sehr gut | ◐ funktional | clean-hwr-Architektur als Basis |

**Fazit:** compliance-Rigor von ptb + Architektur-Eleganz von clean-hwr kombinieren.

## Kritische Patterns zum Übernehmen

### 1. Abbreviation Tracking (aus ptb — verzeichnisse.typ)
```typst
// State speichert alle definierten Abkürzungen
#let abk-dict = state("abk-dict", (:))

// Nutzung im Text
#let abk(key) = context {
  let past-uses = query(selector(<abk>).before(here())).filter(n => n.value == key)
  let is-first = past-uses.len() == 0
  // first-use: "Künstliche Intelligenz (KI)" → danach: "KI"
  [#metadata(key) <abk>]   // Label für query()
}

// Verzeichnis nur rendern wenn genutzt
context {
  let used = query(<abk>)
  if used.any(n => n.value in abkuerzungen.keys()) { ... }
}
```

### 2. Bedingte Verzeichnisse (aus ptb — verzeichnisse.typ)
```typst
let figs = query(figure.where(kind: image))
let tabs = query(figure.where(kind: table))
if figs.len() >= 5 { /* Abbildungsverzeichnis */ }
if tabs.len() >= 5 { /* Tabellenverzeichnis */ }
```

### 3. Custom Metadata Entries Mergen (aus clean-hwr — title_page.typ)
```typst
// Erlaubt User beliebige Felder an bestimmter Position einzufügen
let merge-entries(defaults, customs) = {
  let base = defaults
  for entry in customs {
    let idx = entry.at("index", default: base.len())
    base.insert(idx, (entry.key, entry.value))
  }
  base
}
```

### 4. Lokalisierung mit linguify .ftl (aus clean-hwr)
```
# l10n/de.ftl
declaration-text = { $author-count ->
    [one]   Ich erkläre ehrenwörtlich: ...
    *[other] Wir erklären ehrenwörtlich: ...
}
```
Pluralisierung automatisch — wichtig für Gruppenarbeiten.

### 5. Seitennummerierungs-Zustand (beide Templates)
```typst
// Sequenz: none → Römisch (I) → Arabisch (1)
// Deckblatt: in röm. Zählung aber nicht sichtbar
set page(numbering: none)         // Deckblatt sichtbar
counter(page).update(1)           // Zähler bei I starten
set page(numbering: "I")          // Verzeichnisse sichtbar
// ... dann bei erster Textseite:
counter(page).update(1)
set page(numbering: "1")          // Haupttext
```

## Was NICHT übernehmen

| Problem | Betroffenes Template | Warum |
|---|---|---|
| Font "TeX Gyre Termes" als Default | clean-hwr | HWR verlangt Times New Roman |
| `figure-index.enabled: false` als Default | clean-hwr | Muss automatisch per ≥5-Check entscheiden, nicht manuell |
| Signature-Bild-Hardpfad `../bilder/signatur.png` | ptb | Nicht portierbar |
| Hardcoded `lang: "de"` | ptb | Template soll DE/EN unterstützen |
| Kein Sperrvermerk | ptb | Pflicht als Option |

## Package-Entscheidungen

| Feature | Option A | Option B | Empfehlung |
|---|---|---|---|
| Lokalisierung | linguify (clean-hwr) | Hardcoded DE | **linguify** — für EN-Arbeiten nötig |
| Glossar | glossarium (clean-hwr) | Eigene Impl. | **glossarium** — etabliertes Paket |
| Abkürzungen | acrostiche (clean-hwr) | Eigene `abk()` (ptb) | **Eigene Impl.** — ptb-Pattern ist einfacher für User und HWR-konformer (kein Seitennachweis) |
| Wortzählung | wordometer (clean-hwr) | — | **wordometer** — optional, nice-to-have |
| Bibliographie | Eigene .csl | Standard APA | **APA** als Default, konfigurierbar |

## Vollständige Deklarations-Textvorlage (Pflicht, §3.11)
> Muss in l10n/de.ftl UND l10n/en.ftl (angepasst) vorhanden sein

```
Ich erkläre ehrenwörtlich:

dass ich die vorliegende Arbeit in allen Teilen selbstständig angefertigt und keine anderen
als die in der Arbeit angegebenen Quellen und Hilfsmittel benutzt habe, und dass die Arbeit
in gleicher oder ähnlicher Form in noch keiner anderen Prüfung vorgelegen hat. Sämtliche
wörtlichen oder sinngemäßen Übernahmen und Zitate, sowie alle Abschnitte, die mithilfe von
KI-basierten Tools entworfen, verfasst und/oder bearbeitet wurden, sind kenntlich gemacht
und nachgewiesen. Im Anhang meiner Arbeit habe ich sämtliche KI-basierte Hilfsmittel
angegeben. Diese sind mit Produktnamen und formulierten Eingaben (Prompts) in einem
KI-Verzeichnis ausgewiesen.

Ich bin mir bewusst, dass die Verwendung von Texten oder anderen Inhalten und Produkten,
die durch KI-basierte Tools generiert wurden, keine Garantie für deren Qualität darstellt.
Ich verantworte die Übernahme jeglicher von mir verwendeter maschinell generierter Passagen
vollumfänglich selbst und trage die Verantwortung für eventuell durch die KI generierte
fehlerhafte oder verzerrte Inhalte, fehlerhafte Referenzen, Verstöße gegen das Datenschutz-
und Urheberrecht oder Plagiate.
```
