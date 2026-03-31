#!/usr/bin/env bash
# =============================================================================
# HWR Berlin Typst Template — Paket veröffentlichen
# =============================================================================
# Veröffentlicht eine neue Version des Pakets in typst/packages.
#
# Aufruf (aus dem Template-Repo-Wurzelverzeichnis oder scripts/):
#   bash scripts/publish.sh
#
# Optionale Umgebungsvariablen:
#   TYPST_PACKAGES_DIR   Pfad zum typst-packages-Fork (Standard: ../../typst-packages)
#
# Was das Skript macht:
#   1. Liest die Version aus typst.toml
#   2. Prüft, dass der Versionsordner noch nicht existiert
#   3. Synchronisiert den Fork: git pull upstream main
#   4. Erstellt packages/preview/easy-wi-hwr/{version}/
#   5. Kopiert lib.typ, typst.toml, README.md, LICENSE, thumbnail.png,
#      pages/, helper/, l10n/, template/
#   6. Räumt Duplikate/Artefakte auf (template/main.pdf, template/thumbnail.png,
#      alle .DS_Store-Dateien)
#   7. Erstellt einen neuen Branch easy-wi-hwr-{version}
#   8. Staged & committed mit "easy-wi-hwr:{version}"
#   9. Pusht den Branch zu origin (lultoni/packages)
#  10. Öffnet einen PR gegen typst/packages
# =============================================================================

set -euo pipefail

# =============================================================================
# Pfade
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
PACKAGES_DIR="${TYPST_PACKAGES_DIR:-$(cd "${SCRIPT_DIR}/../.." && pwd)/typst-packages}"

# =============================================================================
# Farben / Status-Ausgabe
# =============================================================================

# tput-basierte Farben, Fallback auf ANSI-Escape-Codes
if command -v tput &>/dev/null && tput colors &>/dev/null && [ "$(tput colors)" -ge 8 ]; then
  BOLD="$(tput bold)"
  GREEN="$(tput setaf 2)$(tput bold)"
  YELLOW="$(tput setaf 3)$(tput bold)"
  RED="$(tput setaf 1)$(tput bold)"
  CYAN="$(tput setaf 6)$(tput bold)"
  RESET="$(tput sgr0)"
else
  BOLD="\033[1m"
  GREEN="\033[1;32m"
  YELLOW="\033[1;33m"
  RED="\033[1;31m"
  CYAN="\033[1;36m"
  RESET="\033[0m"
fi

ok()   { echo -e "  ${GREEN}✓${RESET} $1"; }
info() { echo -e "  ${CYAN}→${RESET} $1"; }
warn() { echo -e "  ${YELLOW}!${RESET} $1"; }
die()  { echo -e "  ${RED}✗ Fehler:${RESET} $1" >&2; exit 1; }

print_header() {
  echo ""
  echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo -e "${BOLD}  HWR Berlin Typst Template — Paket veröffentlichen${RESET}"
  echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo ""
}

# =============================================================================
# Schritt 1 — Version aus typst.toml lesen
# =============================================================================

step_read_version() {
  local toml="${TEMPLATE_DIR}/typst.toml"
  [ -f "$toml" ] || die "typst.toml nicht gefunden: ${toml}"

  VERSION="$(grep '^version' "$toml" | head -1 | sed 's/.*=[[:space:]]*"\([^"]*\)".*/\1/')"
  [ -n "$VERSION" ] || die "version-Zeile in typst.toml nicht gefunden oder leer."

  ok "Version aus typst.toml gelesen: ${CYAN}${VERSION}${RESET}"
}

# =============================================================================
# Schritt 2 — Prüfen, dass der Versionsordner noch nicht existiert
# =============================================================================

step_check_no_overwrite() {
  DEST_DIR="${PACKAGES_DIR}/packages/preview/easy-wi-hwr/${VERSION}"

  if [ -d "$DEST_DIR" ]; then
    die "Versionsordner existiert bereits: ${DEST_DIR}
  Bitte die Version in typst.toml erhöhen und erneut versuchen."
  fi

  ok "Versionsordner existiert noch nicht — OK"
}

# =============================================================================
# Schritt 3 — Fork synchronisieren: git pull upstream main
# =============================================================================

step_sync_fork() {
  [ -d "$PACKAGES_DIR" ] || die "typst-packages-Verzeichnis nicht gefunden: ${PACKAGES_DIR}
  Setze TYPST_PACKAGES_DIR auf den richtigen Pfad."

  info "Synchronisiere Fork mit upstream/main …"
  git -C "$PACKAGES_DIR" pull upstream main

  ok "Fork synchronisiert (upstream/main)"
}

# =============================================================================
# Schritt 4+5 — Verzeichnis erstellen und Dateien kopieren
# =============================================================================

step_copy_files() {
  mkdir -p "$DEST_DIR"
  ok "Versionsordner erstellt: packages/preview/easy-wi-hwr/${VERSION}/"

  local files=(
    lib.typ
    typst.toml
    README.md
    LICENSE
    thumbnail.png
  )
  local dirs=(
    pages
    helper
    l10n
    template
  )

  for f in "${files[@]}"; do
    local src="${TEMPLATE_DIR}/${f}"
    if [ -e "$src" ]; then
      cp "$src" "${DEST_DIR}/${f}"
      ok "Kopiert: ${f}"
    else
      warn "Nicht gefunden (übersprungen): ${f}"
    fi
  done

  for d in "${dirs[@]}"; do
    local src="${TEMPLATE_DIR}/${d}"
    if [ -d "$src" ]; then
      cp -r "$src" "${DEST_DIR}/${d}"
      ok "Kopiert: ${d}/"
    else
      warn "Nicht gefunden (übersprungen): ${d}/"
    fi
  done
}

# =============================================================================
# Schritt 6 — Artefakte / Duplikate entfernen
# =============================================================================

step_cleanup() {
  local removed=0

  # template/main.pdf — großes Build-Artefakt, gehört nicht ins Paket
  if [ -f "${DEST_DIR}/template/main.pdf" ]; then
    rm "${DEST_DIR}/template/main.pdf"
    ok "Entfernt: template/main.pdf  (Build-Artefakt)"
    removed=$((removed + 1))
  fi

  # template/thumbnail.png — Duplikat von thumbnail.png im Root
  if [ -f "${DEST_DIR}/template/thumbnail.png" ]; then
    rm "${DEST_DIR}/template/thumbnail.png"
    ok "Entfernt: template/thumbnail.png  (Duplikat)"
    removed=$((removed + 1))
  fi

  # Alle .DS_Store-Dateien (macOS-Metadaten)
  local ds_count=0
  while IFS= read -r -d '' f; do
    rm "$f"
    ds_count=$((ds_count + 1))
  done < <(find "$DEST_DIR" -name ".DS_Store" -print0 2>/dev/null)

  if [ "$ds_count" -gt 0 ]; then
    ok "Entfernt: ${ds_count} .DS_Store-Datei(en)"
    removed=$((removed + ds_count))
  fi

  if [ "$removed" -eq 0 ]; then
    info "Keine Artefakte gefunden — nichts zu entfernen"
  fi
}

# =============================================================================
# Schritt 7 — Neuen Branch erstellen
# =============================================================================

step_create_branch() {
  BRANCH="easy-wi-hwr-${VERSION}"

  # Sicherstellen, dass wir auf main sind und kein gleicher Branch existiert
  git -C "$PACKAGES_DIR" checkout main

  if git -C "$PACKAGES_DIR" show-ref --verify --quiet "refs/heads/${BRANCH}"; then
    die "Branch '${BRANCH}' existiert bereits im lokalen Repo.
  Bitte manuell löschen: git -C \"${PACKAGES_DIR}\" branch -D \"${BRANCH}\""
  fi

  git -C "$PACKAGES_DIR" checkout -b "$BRANCH"
  ok "Branch erstellt: ${BRANCH}"
}

# =============================================================================
# Schritt 8 — Staged und committed
# =============================================================================

step_commit() {
  local commit_msg="easy-wi-hwr:${VERSION}"

  git -C "$PACKAGES_DIR" add "${DEST_DIR}"
  git -C "$PACKAGES_DIR" commit -m "$commit_msg"

  ok "Commit erstellt: \"${commit_msg}\""
}

# =============================================================================
# Schritt 9 — Branch zu origin pushen
# =============================================================================

step_push() {
  git -C "$PACKAGES_DIR" push -u origin "$BRANCH"
  ok "Branch gepusht: origin/${BRANCH}"
}

# =============================================================================
# Schritt 10 — Pull Request erstellen
# =============================================================================

step_create_pr() {
  local title="easy-wi-hwr:${VERSION}"
  local pr_body
  pr_body="$(cat <<EOF
This is a submission for a new package version.

## Checklist

- [x] The submission follows the [submission guidelines](https://github.com/typst/packages?tab=readme-ov-file#submission-guidelines).
- [x] The package has a \`typst.toml\` with all required keys.
- [x] The package has a \`README.md\` with documentation.
- [x] Large files (PDFs) are excluded from the bundle.
- [x] Template contents can be used and distributed without restriction after normal modification.
EOF
)"

  info "Erstelle Pull Request gegen typst/packages …"

  PR_URL="$(
    GH_HOST=github.com gh pr create \
      --title "$title" \
      --head "lultoni:${BRANCH}" \
      --base main \
      --repo typst/packages \
      --body "$pr_body"
  )"

  ok "Pull Request erstellt"
}

# =============================================================================
# Abschluss-Nachricht
# =============================================================================

print_done() {
  echo ""
  echo -e "${GREEN}${BOLD}  Fertig! Version ${VERSION} wurde veröffentlicht.${RESET}"
  echo ""
  echo -e "${BOLD}  Pull Request:${RESET} ${CYAN}${PR_URL}${RESET}"
  echo ""
  echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo ""
}

# =============================================================================
# Hauptprogramm
# =============================================================================

print_header

info "Template-Repo:    ${TEMPLATE_DIR}"
info "Packages-Repo:    ${PACKAGES_DIR}"
echo ""

step_read_version
step_check_no_overwrite

echo ""
info "── Schritt 3: Fork synchronisieren ──────────────────────"
step_sync_fork

echo ""
info "── Schritt 4+5: Dateien kopieren ────────────────────────"
step_copy_files

echo ""
info "── Schritt 6: Artefakte aufräumen ───────────────────────"
step_cleanup

echo ""
info "── Schritt 7: Branch erstellen ──────────────────────────"
step_create_branch

echo ""
info "── Schritt 8: Commit erstellen ──────────────────────────"
step_commit

echo ""
info "── Schritt 9: Branch pushen ─────────────────────────────"
step_push

echo ""
info "── Schritt 10: Pull Request erstellen ───────────────────"
step_create_pr

print_done
