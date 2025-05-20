#!/usr/bin/env bash
#
###################
# Script  bash
#
# Script       : 
# Script name  : check_license.sh
# Creation     : 15-05-2025
# Modification : 15-05-2025
# Last change  : 15-05-2025
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

# /bin/date -d 'now'

PROJET_DIR="$HOME/kDrive/Essence-de-Vie"

nombre_fichiers=0

echo

# Recherche les fichiers Markdown sans mention de licence
find "$PROJET_DIR" -type f -name "*.md" | while read -r file; do
    if ! grep -q "GNU GPL v3" "$file"; then
        echo "[⚠️] $file — Pas de mention de licence"
        # shellcheck disable=SC2030
        nombre_fichiers=1
    fi
done

# shellcheck disable=SC2031
if [[ "$nombre_fichiers" -eq 0 ]] ; then
    echo "[🌱] — Mention de licence GNU GPL v3 dans tous les fichiers markdown."
fi

echo

# /bin/date -d 'now'

exit


