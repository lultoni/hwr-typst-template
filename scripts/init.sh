#!/usr/bin/env bash
# =============================================================================
# HWR Berlin Typst Template — Projekt-Setup
# =============================================================================
# Dieses Skript erstellt alle Dateien und Ordner für deine Arbeit.
#
# Aufruf — drei Wege:
#
#   1. Aus dem heruntergeladenen Template-Ordner:
#        bash scripts/init.sh
#
#   2. Von irgendwo (fragt nach Zielordner):
#        bash scripts/init.sh
#
#   3. Direkt aus dem Web (macOS/Linux):
#        bash <(curl -fsSL https://raw.githubusercontent.com/lultoni/hwr-typst-template/main/scripts/init.sh)
#
# Das Skript fragt dich nach deinen Daten und erstellt dann
# einen neuen Projektordner mit allen nötigen Dateien.
# =============================================================================

set -e

# --- Farben für lesbarere Ausgabe -------------------------------------------
BOLD="\033[1m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

# --- Erkennen ob Script als Datei oder via Pipe (curl) läuft ----------------
# Bei bash <(curl ...) ist BASH_SOURCE[0] kein echter Dateipfad (/dev/fd/...).
# In diesem Fall fragen wir den User wo das Projekt erstellt werden soll.
SCRIPT_IS_FILE=false
if [[ -f "${BASH_SOURCE[0]:-}" ]]; then
  SCRIPT_IS_FILE=true
fi

# Zielverzeichnis (wo der neue Projektordner erstellt wird) — wird in collect_input gesetzt
TARGET_ROOT=""

# =============================================================================
# Hilfsfunktionen
# =============================================================================

print_header() {
  echo ""
  echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo -e "${BOLD}  HWR Berlin Typst Template — Neues Projekt erstellen${RESET}"
  echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo ""
}

ask() {
  local prompt="$1"
  local default="$2"
  local answer
  if [ -n "$default" ]; then
    read -rp "$(echo -e "${CYAN}?${RESET} $prompt [${default}]: ")" answer </dev/tty
    echo "${answer:-$default}"
  else
    read -rp "$(echo -e "${CYAN}?${RESET} $prompt: ")" answer </dev/tty
    echo "$answer"
  fi
}

# ask_choice: schreibt Menü direkt auf /dev/tty, gibt Ergebnis via CHOICE_RESULT zurück.
# Aufruf: ask_choice "Prompt" default "Option1" "Option2" ...
# Ergebnis: $CHOICE_RESULT enthält den gewählten Options-String.
CHOICE_RESULT=""
ask_choice() {
  local prompt="$1"
  local default="$2"
  shift 2
  local options=("$@")
  echo -e "${CYAN}?${RESET} $prompt" >/dev/tty
  for i in "${!options[@]}"; do
    local num=$((i + 1))
    if [ "$num" = "$default" ]; then
      echo -e "  ${BOLD}[$num]${RESET} ${options[$i]}  ${YELLOW}← Standard${RESET}" >/dev/tty
    else
      echo "  [$num] ${options[$i]}" >/dev/tty
    fi
  done
  local answer
  read -rp "$(echo -e "${CYAN}  Deine Wahl${RESET} [${default}]: ")" answer </dev/tty
  answer="${answer:-$default}"
  if ! [[ "$answer" =~ ^[0-9]+$ ]] || [ "$answer" -lt 1 ] || [ "$answer" -gt "${#options[@]}" ]; then
    answer="$default"
  fi
  CHOICE_RESULT="${options[$((answer - 1))]}"
}

ok()   { echo -e "  ${GREEN}✓${RESET} $1"; }
info() { echo -e "  ${CYAN}→${RESET} $1"; }
warn() { echo -e "  ${YELLOW}!${RESET} $1"; }

# =============================================================================
# Eingabe sammeln
# =============================================================================

collect_input() {
  print_header

  echo "  Beantworte ein paar kurze Fragen — danach erstellt das Skript"
  echo "  alle Dateien für dich. Du kannst alles später in main.typ ändern."
  echo ""

  # --- Zielordner bestimmen --------------------------------------------------
  local default_root
  default_root="$(pwd)"

  echo -e "  ${BOLD}Wo soll der Projektordner erstellt werden?${RESET}"
  echo -e "  Aktuelles Verzeichnis: ${CYAN}${default_root}${RESET}"
  echo ""
  local target_input
  read -rp "$(echo -e "${CYAN}?${RESET} Pfad eingeben oder Enter für aktuelles Verzeichnis: ")" target_input </dev/tty
  if [ -z "$target_input" ]; then
    TARGET_ROOT="$default_root"
  else
    # ~ expandieren
    target_input="${target_input/#\~/$HOME}"
    TARGET_ROOT="$target_input"
  fi

  # Prüfen ob Zielordner existiert
  if [ ! -d "$TARGET_ROOT" ]; then
    echo ""
    echo -e "  ${RED}Fehler:${RESET} Der Ordner '${TARGET_ROOT}' existiert nicht."
    echo "  Bitte zuerst diesen Ordner erstellen, dann das Script nochmal starten."
    exit 1
  fi

  TARGET_ROOT="$(cd "$TARGET_ROOT" && pwd)"
  echo ""

  # --- Projektordner-Name ----------------------------------------------------
  PROJECT_NAME=$(ask "Name des Projektordners (nur Buchstaben, Zahlen, Bindestriche)" "meine-arbeit")
  # Leerzeichen durch Bindestriche ersetzen, Sonderzeichen entfernen
  PROJECT_NAME=$(echo "$PROJECT_NAME" | tr ' ' '-' | tr -cd 'a-zA-Z0-9_-')
  [ -z "$PROJECT_NAME" ] && PROJECT_NAME="meine-arbeit"

  # Prüfen ob Ordner schon existiert
  if [ -d "$TARGET_ROOT/$PROJECT_NAME" ]; then
    echo ""
    echo -e "  ${RED}Fehler:${RESET} Der Ordner '$PROJECT_NAME' existiert bereits in '${TARGET_ROOT}'."
    echo "  Wähle einen anderen Namen oder lösche den bestehenden Ordner."
    exit 1
  fi

  TARGET_DIR="$TARGET_ROOT/$PROJECT_NAME"
  echo ""

  # --- Art der Arbeit --------------------------------------------------------
  ask_choice \
    "Was schreibst du?" "1" \
    "Praxistransferbericht I  (ptb-1)" \
    "Praxistransferbericht II (ptb-2)" \
    "Praxistransferbericht III (ptb-3)" \
    "Hausarbeit" \
    "Studienarbeit" \
    "Bachelorarbeit"
  DOC_TYPE_LABEL="$CHOICE_RESULT"

  case "$DOC_TYPE_LABEL" in
    *"ptb-1"*)         DOC_TYPE="ptb-1" ;;
    *"ptb-2"*)         DOC_TYPE="ptb-2" ;;
    *"ptb-3"*)         DOC_TYPE="ptb-3" ;;
    *"Hausarbeit"*)    DOC_TYPE="hausarbeit" ;;
    *"Studienarbeit"*) DOC_TYPE="studienarbeit" ;;
    *"Bachelorarbeit"*)DOC_TYPE="bachelorarbeit" ;;
    *)                 DOC_TYPE="ptb-1" ;;
  esac

  echo ""

  # --- Persönliche Daten -----------------------------------------------------
  AUTHOR_NAME=$(ask "Dein vollständiger Name" "Max Mustermann")
  MATRIKEL=$(ask "Deine Matrikelnummer" "12345678")
  TITLE=$(ask "Arbeitstitel (kann später geändert werden)" "Titel meiner Arbeit")
  echo ""

  # --- Bedingt: Betreuer oder Gutachter --------------------------------------
  if [ "$DOC_TYPE" = "bachelorarbeit" ]; then
    FIRST_EXAMINER=$(ask "Erstgutachter/in (mit Titel, z.B. Prof. Dr. ...)" "Prof. Dr. Vorname Name")
    SECOND_EXAMINER=$(ask "Zweitgutachter/in (mit Titel)" "Prof. Dr. Vorname Name")
    COMPANY=""
    SUPERVISOR=""
  else
    SUPERVISOR=$(ask "Betreuende/r Prüfer/in (mit Titel, z.B. Prof. Dr. ...)" "Prof. Dr. Vorname Name")
    COMPANY=$(ask "Name deines Ausbildungsbetriebs" "Muster GmbH")
    FIRST_EXAMINER=""
    SECOND_EXAMINER=""
  fi

  echo ""

  # --- Optionale Felder ------------------------------------------------------
  FIELD=$(ask "Fachrichtung" "Wirtschaftsinformatik")
  COHORT=$(ask "Studienjahrgang (z.B. 2024, Enter zum Überspringen)" "")
  SEMESTER=$(ask "Studienhalbjahr (z.B. 3, Enter zum Überspringen)" "")
  echo ""

  # --- Anzahl Kapitel --------------------------------------------------------
  NUM_CHAPTERS=$(ask "Wie viele Kapitel soll die Vorlage erstellen?" "5")
  if ! [[ "$NUM_CHAPTERS" =~ ^[0-9]+$ ]] || [ "$NUM_CHAPTERS" -lt 1 ] || [ "$NUM_CHAPTERS" -gt 20 ]; then
    NUM_CHAPTERS=5
  fi

  echo ""
  echo -e "${BOLD}  Alles klar — Dateien werden jetzt erstellt in:${RESET}"
  echo -e "  ${CYAN}${TARGET_DIR}${RESET}"
  echo ""
}

# =============================================================================
# Dateien erstellen
# =============================================================================

create_files() {
  mkdir -p "$TARGET_DIR/kapitel"
  mkdir -p "$TARGET_DIR/anhang"
  ok "Projektordner erstellt: $PROJECT_NAME/"
  ok "Unterordner kapitel/ und anhang/ erstellt"

  # --- refs.bib ---------------------------------------------------------------
  cat > "$TARGET_DIR/refs.bib" << 'BIBTEX'
% refs.bib — Literaturverzeichnis
%
% Trage hier deine Quellen ein.
% Im Text zitierst du mit @Schlüssel, z.B.: Laut @mustermann2024 gilt...
%
% Tipp: Citavi, Zotero und Google Scholar können .bib-Dateien exportieren.
%       Das spart viel manuelle Arbeit.

@book{mustermann2024,
  author    = {Mustermann, Max},
  title     = {Titel des Buches},
  year      = {2024},
  publisher = {Verlag},
  address   = {Stadt},
}

@article{mueller2023,
  author  = {Müller, Lisa},
  title   = {Titel des Aufsatzes},
  journal = {Name der Zeitschrift},
  year    = {2023},
  volume  = {1},
  number  = {1},
  pages   = {1--10},
}

@online{quelle2024,
  author  = {Autor, Vorname},
  title   = {Titel der Webseite},
  year    = {2024},
  url     = {https://example.com},
  urldate = {2024-01-01},
}
BIBTEX
  ok "refs.bib erstellt  (Quellen hier eintragen)"

  # --- Kapitel-Dateien --------------------------------------------------------
  local chapter_names=(
    "Einleitung"
    "Theoretische Grundlagen"
    "Methodik"
    "Ergebnisse"
    "Diskussion"
    "Fazit und Ausblick"
    "Kapitel 7" "Kapitel 8" "Kapitel 9" "Kapitel 10"
    "Kapitel 11" "Kapitel 12" "Kapitel 13" "Kapitel 14" "Kapitel 15"
    "Kapitel 16" "Kapitel 17" "Kapitel 18" "Kapitel 19" "Kapitel 20"
  )

  CHAPTER_INCLUDES=""
  for i in $(seq 1 "$NUM_CHAPTERS"); do
    local padded
    padded=$(printf "%02d" "$i")
    local name="${chapter_names[$((i-1))]}"
    # Dateiname: lowercase, Leerzeichen → Unterstrich, nur a-z0-9_
    local slug
    slug=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr -cd 'a-z0-9_')
    local filename="${padded}_${slug}.typ"

    cat > "$TARGET_DIR/kapitel/$filename" << KAPITEL
// kapitel/$filename — $name
//
// Schreibe hier deinen Text. Ein paar Tipps:
//
//   Überschrift 1. Ebene:   = Überschrift
//   Überschrift 2. Ebene:  == Unterabschnitt
//   Überschrift 3. Ebene: === Unterunterabschnitt
//
//   Fettschrift:   *Wort*
//   Kursiv:        _Wort_
//   Fußnote:       Text#footnote[Hier steht die Fußnote.]
//   Zitat im Text: Laut @mustermann2024 gilt...  oder  @mustermann2024[S. 42]
//   Abkürzung:     #abk("KI")  → beim 1. Mal "Künstliche Intelligenz (KI)"

= $name

Schreibe hier deinen Text für Kapitel $i.

== Erster Unterabschnitt

Text...

== Zweiter Unterabschnitt

Text...

KAPITEL
    ok "kapitel/$filename"
    CHAPTER_INCLUDES="${CHAPTER_INCLUDES}    include(\"kapitel/${filename}\"),
"
  done

  # --- Anhang-Beispieldatei ---------------------------------------------------
  cat > "$TARGET_DIR/anhang/beispiel.typ" << 'ANHANG'
// anhang/beispiel.typ
//
// Schreibe hier den Inhalt dieses Anhang-Eintrags.
// Du kannst diese Datei umbenennen und weitere anlegen
// (z.B. anhang/interviewleitfaden.typ, anhang/rohdaten.typ).
//
// Mögliche Inhalte:
//   Text und Listen:   einfach schreiben wie in den Kapiteln
//   Tabelle:           #figure(table(...), caption: [...])
//   Bild:              #figure(image("anhang/datei.png"), caption: [...])

*Anhang-Inhalt*

Hier steht der Inhalt. Das kann Text, Tabellen oder Bilder sein.
ANHANG
  ok "anhang/beispiel.typ  (Inhalt nach Bedarf anpassen)"

  # --- main.typ generieren ----------------------------------------------------
  _generate_main_typ
  ok "main.typ  ← hier fängst du an"

  echo ""
}

_generate_main_typ() {
  local examiner_block=""
  local supervisor_block=""

  if [ "$DOC_TYPE" = "bachelorarbeit" ]; then
    examiner_block="  first-examiner:  \"${FIRST_EXAMINER}\",
  second-examiner: \"${SECOND_EXAMINER}\","
  else
    supervisor_block="  supervisor: \"${SUPERVISOR}\",
  company:    \"${COMPANY}\","
  fi

  local cohort_line=""
  [ -n "$COHORT" ]   && cohort_line="  cohort:   \"${COHORT}\","$'\n'
  local semester_line=""
  [ -n "$SEMESTER" ] && semester_line="  semester: \"${SEMESTER}\","$'\n'

  cat > "$TARGET_DIR/main.typ" << MAINTYP
// ============================================================
//  main.typ — Deine HWR-Arbeit
// ============================================================
//
//  Das ist die einzige Datei die du anfassen musst.
//  Deine Kapitel schreibst du in den Dateien unter kapitel/
//
//  PDF erstellen (Terminal, in diesem Ordner):
//    Einmalig:        typst compile main.typ
//    Live-Vorschau:   typst watch main.typ   (Beenden: Ctrl+C)
//
// ============================================================

#import "@preview/wi-hwr-berlin:0.1.0": hwr, abk

#show: hwr.with(

  // ── Was du schreibst ───────────────────────────────────
  doc-type: "${DOC_TYPE}",
  //  "ptb-1" / "ptb-2" / "ptb-3"   → Praxistransferbericht I/II/III
  //  "hausarbeit"                    → Hausarbeit
  //  "studienarbeit"                 → Studienarbeit
  //  "bachelorarbeit"                → Bachelorarbeit

  title: "${TITLE}",

  // ── Deine Daten ────────────────────────────────────────
  authors: (
    (name: "${AUTHOR_NAME}", matrikel: "${MATRIKEL}"),
    // Gruppenarbeit? Weitere Autoren so eintragen:
    // (name: "Lisa Müller", matrikel: "87654321"),
  ),

${supervisor_block}${examiner_block}

  // ── Studiengang ────────────────────────────────────────
  field-of-study: "${FIELD}",
${cohort_line}${semester_line}
  // ── Datum ──────────────────────────────────────────────
  date: auto,  // auto = heutiges Datum | oder z.B.: "15. März 2026"

  // ── Abkürzungen ────────────────────────────────────────
  // Trage hier ALLE Abkürzungen ein die du im Text verwendest.
  //
  // Im Text schreibst du dann: #abk("KI")
  //   → Beim ersten Vorkommen erscheint: "Künstliche Intelligenz (KI)"
  //   → Danach immer nur: "KI"
  //
  // Das Abkürzungsverzeichnis wird automatisch erstellt —
  // nur Abkürzungen die du wirklich verwendest erscheinen darin.
  abbreviations: (
    "HWR": "Hochschule für Wirtschaft und Recht Berlin",
    // Weitere Abkürzungen hier eintragen:
    // "KI":  "Künstliche Intelligenz",
    // "ERP": "Enterprise Resource Planning",
    // "API": "Application Programming Interface",
  ),

  // ── KI-Verzeichnis ─────────────────────────────────────
  // Hast du KI-Tools benutzt? → Hier eintragen (Pflicht laut §3.8).
  // Nicht benutzt? → Diese Zeilen so lassen (ai-tools: ()).
  ai-tools: (
    // (
    //   tool:     "ChatGPT 4o",
    //   usage:    "Textvorschläge, im Text gekennzeichnet",
    //   chapters: "Kapitel 1, S. 3",
    // ),
  ),

  // ── Abstract (optional) ────────────────────────────────
  // Entferne die // am Anfang um einen Abstract einzufügen.
  // abstract: [
  //   Schreibe hier deinen Abstract (ca. eine halbe Seite).
  // ],

  // ── Sperrvermerk (optional) ────────────────────────────
  // Nur nötig wenn Teile der Arbeit vertraulich sind.
  // confidential: true,                     // gesamte Arbeit sperren
  // confidential: (                         // nur bestimmte Kapitel:
  //   chapters: (
  //     (number: "3", title: "Methodik"),
  //   ),
  //   filename: "Arbeit_oeffentlich.pdf",   // optional
  // ),

  // ── Deine Kapitel ──────────────────────────────────────
  // Reihenfolge hier = Reihenfolge im PDF.
  chapters: (
${CHAPTER_INCLUDES}  ),

  // ── Anhang (optional) ──────────────────────────────────
  // Entferne die // um den Anhang zu aktivieren.
  // appendix: (
  //   (title: "Interviewleitfaden", content: include("anhang/beispiel.typ")),
  //   (title: "Screenshot",         content: image("anhang/screenshot.png")),
  // ),

  // ── Literaturverzeichnis ───────────────────────────────
  bibliography: bibliography("refs.bib"),
  citation-style: "apa",
  // Englische Arbeit? Dann: citation-style: "harvard-anglia-ruskin-university"

)
// ── Fertig mit den Einstellungen! ──────────────────────
// Deine Kapitel schreibst du in den Dateien unter kapitel/
// Diese Datei nicht weiter bearbeiten.
MAINTYP
}

# =============================================================================
# Abschluss-Nachricht
# =============================================================================

print_done() {
  echo -e "${GREEN}${BOLD}  Fertig! Dein Projekt ist bereit.${RESET}"
  echo ""
  echo -e "${BOLD}  Dein Projektordner:${RESET} ${CYAN}${TARGET_DIR}/${RESET}"
  echo ""
  echo -e "${BOLD}  ─── So geht es weiter ───────────────────────────────${RESET}"
  echo ""
  echo -e "  ${BOLD}Schritt 1:${RESET} Öffne deinen Projektordner in VS Code"
  echo -e "    → VS Code (kostenlos): ${CYAN}https://code.visualstudio.com${RESET}"
  echo "    → Tinymist-Extension installieren (Syntax-Highlighting für .typ-Dateien)"
  echo -e "    → Dann ${CYAN}${TARGET_DIR}/main.typ${RESET} öffnen"
  echo "      → Deine Daten sind schon eingetragen — nur durchscrollen und prüfen"
  echo "      → Abkürzungen ergänzen im abbreviations:-Block"
  echo "      → KI-Tools eintragen wenn du welche verwendest"
  echo ""
  echo -e "  ${BOLD}Schritt 2:${RESET} Schreibe deine Kapitel"
  echo -e "    → z.B. ${CYAN}${TARGET_DIR}/kapitel/01_einleitung.typ${RESET} öffnen"
  echo "    → Formatierung ist automatisch — einfach drauflosschreiben"
  echo "    → Abkürzungen: #abk(\"KI\")"
  echo "    → Zitieren: @mustermann2024  (Quellen in refs.bib eintragen)"
  echo ""
  echo -e "  ${BOLD}Schritt 3:${RESET} PDF erstellen ${BOLD}(Terminal, im Projektordner):${RESET}"
  echo ""
  echo "    Einmalig:"
  echo -e "      ${CYAN}cd \"${TARGET_DIR}\" && typst compile main.typ${RESET}"
  echo ""
  echo "    Mit Live-Vorschau (aktualisiert bei jedem Speichern):"
  echo -e "      ${CYAN}cd \"${TARGET_DIR}\" && typst watch main.typ${RESET}"
  echo "    → Beenden: Ctrl+C"
  echo ""
  echo -e "  ${BOLD}Schritt 4:${RESET} Quellen in ${CYAN}${TARGET_DIR}/refs.bib${RESET} eintragen"
  echo "    → Tipp: Zotero oder Citavi können .bib-Dateien exportieren"
  echo ""
  echo -e "  ${BOLD}Alle Optionen und Einstellungen:${RESET} ${CYAN}https://github.com/lultoni/hwr-typst-template${RESET}"
  echo ""
  echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo ""
}

# =============================================================================
# Hauptprogramm
# =============================================================================
collect_input
create_files
print_done
