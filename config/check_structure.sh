#!/usr/bin/env bash
#
###################
# Script  bash
#
# Script       : 
# Script name  : check_structure.sh
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
# PROJET_DIR="$HOME/Projets/Essence_de_Vie"
PROJET_DIR="/home/thierry63/kDrive/Essence_de_Vie/"
DATE=$(date +"%Y-%m-%d %H:%M")

clear

# === En-tête du rapport ===
echo "🔍 Rapport de vérification des fichiers – Essence de Vie"
echo "📅 Date : $DATE"
echo ""

# === Fonction de vérification d'un fichier ===
check_file() {
    local path=$1
    if [ -f "$path" ]; then
        echo "[✅] Fichier présent : $path"
        return 0
    else
        echo "[❌] Fichier absent : $path"
        return 1
    fi
}

# === Liste complète des fichiers attendus ===
FICHIERS_ATTENDUS=(
    "$PROJET_DIR/README.md"
    "$PROJET_DIR/.gitignore"
    "$PROJET_DIR/SUMMARY.md"
    "$PROJET_DIR/structure.md"

    "$PROJET_DIR/public/README.md"
    "$PROJET_DIR/public/manifeste/essence-de-vie.md"
    "$PROJET_DIR/public/manifeste/trm-en-quelques-lignes.md"

    "$PROJET_DIR/public/docs/idee-centrale.md"
    "$PROJET_DIR/public/docs/pourquoi-ca-me-tient-a-coeur.md"
    "$PROJET_DIR/public/docs/qu-est-ce-que-trm.md"
    "$PROJET_DIR/public/docs/monnaie-bien-commun.md"
    "$PROJET_DIR/public/docs/pas-duniter-g1.md"
    "$PROJET_DIR/public/docs/systeme-existence-physique.md"
    "$PROJET_DIR/public/docs/faq.md"

    "$PROJET_DIR/public/ateliers/atelier-intro.md"
    "$PROJET_DIR/public/ateliers/jeu-donne-ma-part.md"

    "$PROJET_DIR/public/supports/slides-intro.md"
    "$PROJET_DIR/public/supports/frise-histoire-monnaie.md"

    "$PROJET_DIR/public/annexes/lexique.md"
    "$PROJET_DIR/public/annexes/liens-ressources.md"

    "$PROJET_DIR/prive/discussions/introduction.md"
    "$PROJET_DIR/prive/contacts.csv"

    "$PROJET_DIR/travail/notes/reflexion_trm.md"
    "$PROJET_DIR/travail/scripts/decrypt.sh"

    "$PROJET_DIR/config/rsnapshot.conf"
    "$PROJET_DIR/config/backup.sh"
    "$PROJET_DIR/config/generate_summary.sh"
)

# === Vérification ===
echo "🔎 Vérification des fichiers..."
echo ""
MISSING=0

for file in "${FICHIERS_ATTENDUS[@]}"; do
    check_file "$file"
    if [ $? -ne 0 ]; then
        MISSING=$((MISSING + 1))
    fi
done

# === Bilan final ===
echo ""
echo "📊 Bilan de la structure"
echo "- Nombre total de fichiers attendus : ${#FICHIERS_ATTENDUS[@]}"
echo "- Fichiers présents : $((${#FICHIERS_ATTENDUS[@]} - $MISSING))"
echo "- Fichiers absents : $MISSING"

if [ $MISSING -eq 0 ]; then
    echo "🟢 Tout semble en ordre !"
else
    echo "🔴 Certains fichiers sont absents. Tu peux les créer."
fi

echo ""
echo "💡 Prochaines étapes possibles :"
echo "   • Lancer 'make summary' pour mettre à jour le sommaire"
echo "   • Lancer 'make backup' pour sauvegarder l'état actuel"
echo "   • Remplir les fichiers vides avec ton contenu"