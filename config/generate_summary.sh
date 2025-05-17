#!/usr/bin/env bash
#
###################
# Script  bash
#
# Script       : 
# Script name  : generate_summary.sh
# Creation     : 14-05-2025
# Modification : 14-05-2025
# Last change  : 14-05-2025
# Reason       : 
# Author       : TS
#
# Todo :
#
#
#
#
#
# Modif :
#
#
#
#
#
# Notes :
#
#
#
#
#
#################
#
#set -xv

# === Configuration ===
PROJET_DIR="$HOME/kDrive/Essence_de_Vie"
PUBLIC_DIR="$PROJET_DIR/public"
MANIFESTE_DIR="$PUBLIC_DIR/manifeste"
DOCS_DIR="$PUBLIC_DIR/docs"
SUPPORTS_DIR="$PUBLIC_DIR/supports"
ATELIERS_DIR="$PUBLIC_DIR/ateliers"
ANNEXES_DIR="$PUBLIC_DIR/annexes"
SUMMARY_FILE="$PROJET_DIR/SUMMARY.md"

# === Supprimer l'ancien sommaire ===
rm -f "${SUMMARY_FILE:?}" && touch "${SUMMARY_FILE}"

# === License ===
echo "<!-- Fichier : docs/idee-centrale.md -->" >> "$SUMMARY_FILE"
echo "<!-- Publié sous GNU GPL v3 -->" >> "$SUMMARY_FILE"

echo >> "$SUMMARY_FILE"
echo >> "$SUMMARY_FILE"

echo "# 🌱 Sommaire – Essence de Vie" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

# === Fonction pour ajouter un dossier au sommaire ===
add_section() {
    local section_title=$1
    local folder_path=$2

    # Debug: Check if folder exists
    if [ ! -d "$folder_path" ]; then
        echo "Error: Folder not found: $folder_path"
        return
    fi

    echo "## $section_title" >> "$SUMMARY_FILE"
    echo "" >> "$SUMMARY_FILE"

    find "$folder_path" -type f -name "*.md" 2>/dev/null | sort | while read file; do
        if [ -z "$file" ]; then
            continue # Skip empty file names
        fi
        title=$(grep -m 1 '^# ' "$file" | sed 's/# //')
        if [ -n "$title" ]; then
            relative_path=$(realpath --relative-to="$PROJET_DIR" "$file")
            echo "- [$title](./$relative_path)" >> "$SUMMARY_FILE"
        fi
    done

    echo "" >> "$SUMMARY_FILE"
}

# === Génération du sommaire ===
echo "- [Introduction](README.md)" >> "$SUMMARY_FILE"
echo "- [Structure du projet](structure.md)" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

add_section "Manifeste & Textes clés" "$MANIFESTE_DIR"
add_section "Documentation TRM & Réflexions" "$DOCS_DIR"
add_section "Supports visuels" "$SUPPORTS_DIR"
add_section "Ateliers & Jeux" "$ATELIERS_DIR"
add_section "Annexes & Ressources" "$ANNEXES_DIR"

echo ""
echo "✅ SUMMARY.md généré dans : $SUMMARY_FILE"
