# BACKLOG — Zukünftige Features & Verbesserungen

Strukturierter Backlog für Versionsplanung nach v1.0. Alles hier ist bewusst NICHT in v1.0.

## v1.1 Candidates (rückwärtskompatible Ergänzungen)

| Feature | Beschreibung | Aufwand |
|---|---|---|
| `scripts/abk-scan.py` | Automatisches Finden und Ersetzen von Abkürzungen im Text via Python-Script. Template funktioniert vollständig ohne das Script. Details zum geplanten Funktionsumfang → `requirements/api-design.md` §3 (Weg 3). | Mittel |
| wordometer Integration | Wortzählung im kompilierten Dokument via `@preview/wordometer`. Nützlich um den vorgeschriebenen Umfang (STR-50–52) zu prüfen. | Klein |
| Abk.-Verzeichnis Autogenerierung | Abkürzungen aus `abbreviations:`-Dict und `#abk()`-Aufrufen automatisch zusammenführen ohne dass der User beides pflegt. | Mittel |

## v2.0 Candidates (Breaking Changes oder größere Erweiterungen)

| Feature | Beschreibung | Aufwand |
|---|---|---|
| Neue Dokumenttypen | Falls HWR neue Typen einführt (z.B. Masterarbeit). API-Breaking wenn `doc-type`-Werte ergänzt werden. | Mittel |
| Pandoc-Workflow-Hints | README-Sektion die erklärt wie man via Pandoc ein Word-Dokument aus dem Typst-Output erstellt (CNT-24 unterstützen ohne es ins Template zu bauen). | Klein |
| CI/CD-Integration | GitHub Actions Workflow für automatische PDF-Generierung und Release-Tagging. | Mittel |

## Implemented in v0.1

- **Unterschriften-Feld auf Ehrenwörtlicher Erklärung**: `group-signature` parameter (`auto`/`true` = alle Autoren, `false` = nur erster Autor) mit bilingualem Warnblock für Gruppenarbeiten.
- **Unterschriften-Bild**: Optionales `signature:`-Feld pro Autoren-Eintrag. Wenn angegeben, wird das Bild im Unterschriftsfeld gerendert. Beispiel-SVG: `template/images/signature_example.svg`.

## Offen / Diskutierbar

| Idee | Status | Notiz |
|---|---|---|
| Sperrvermerk: ungesperrte Version automatisch erzeugen | Offen | Typst hat kein natives "Seite-rausschneiden"-Feature. Würde separaten Build-Schritt brauchen. Aufwand vs. Nutzen unklar. |
| Mehrsprachige Abkürzungen (DE + EN gleichzeitig) | Offen | Edge-Case für bilinguale Arbeiten. Erstmal ignorieren. |
| Tabellenformatierung (FMT-46/47) via Template-Default | Offen | Typst-Default-Tabellen sind nicht HWR-konform. Template könnte default `set table(...)` setzen — aber bricht Flexibilität. |
| Beispiel-Kapitel-Dateien mitliefern | Offen | Würde Lernkurve senken (UX-09). Aber bindet Template an bestimmte Inhaltsstruktur. Besser im README dokumentieren. |

## Entschieden: Nicht im Template

| Feature | Entscheidung |
|---|---|
| Word-Export | Out-of-scope. User-Aufgabe. Richtlinien §3.1 verlangen Word+PDF — Typst erzeugt kein Word. |
| Ungesperrte Version PDF automatisch | Out-of-scope. Template kann keine Seiten selektiv rausschneiden. |
