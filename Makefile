# === Makefile – Essence de Vie ===
# Un outil pour gérer facilement ton projet autour de la TRM

# === Variables ===
PROJET_DIR     := $(HOME)/kDrive/Essence-de-Vie
PUBLIC_DIR     := $(PROJET_DIR)/public
MANIFESTE_DIR  := $(PUBLIC_DIR)/manifeste
DOCS_DIR       := $(PUBLIC_DIR)/docs
SUPPORTS_DIR   := $(PUBLIC_DIR)/supports
ATELIERS_DIR   := $(PUBLIC_DIR)/ateliers
ANNEXES_DIR    := $(PUBLIC_DIR)/annexes
SUMMARY_FILE   := $(PROJET_DIR)/SUMMARY.md

DATE           := $(shell date +"%Y%m%d")
GPG_CIPHER     := AES256
ARCHIVE_DIR    := $(PROJET_DIR)/archives_chiffrées
BACKUP_FILE    := $(ARCHIVE_DIR)/backup_$(DATE).tar.bz2.cpt

# === Cibles principales ===
.PHONY: all setup summary backup publish clean

all: summary backup

# === Initialisation ===
setup:
	@echo "[+] Création des dossiers si nécessaire..."
	mkdir -p $(PUBLIC_DIR) $(DOCS_DIR) $(SUPPORTS_DIR) $(ATELIERS_DIR) $(ANNEXES_DIR) $(ARCHIVE_DIR)

# === Génération du sommaire ===
summary:
	@echo "[+] Génération du fichier SUMMARY.md..."
	bash $(PROJET_DIR)/config/generate_summary.sh

# === Sauvegarde locale chiffrée ===
backup: setup
	@echo "[+] Sauvegarde quotidienne en cours..."
	tar -cjf - -C $(PROJET_DIR) public docs manifeste supports annexes | \
	gpg --symmetric --cipher-algo $(GPG_CIPHER) -o $(BACKUP_FILE)

# === Nettoyage des anciens backups ===
clean:
	@echo "[+] Nettoyage des anciens backups (> 30 jours)"
	find $(ARCHIVE_DIR) -name "*.cpt" -mtime +30 -exec rm {} \;

# === Publication sur GitHub (exemple) ===
publish:
	@echo "[+] Mise à jour du dépôt GitHub..."
	cd $(PROJET_DIR) && git add . && git commit -m "mise à jour auto $(DATE)" && git push origin main

# === Vérification de la licence ===
license-check:
	@echo "[+] Vérification de la licence GPL dans les fichiers..."
	bash $(PROJET_DIR)/config/license-check.sh

# === Vérification de la configuration ===
test:
	@echo "[TEST] Vérification des répertoires..."
	@test -d $(PROJET_DIR) && echo "✔ PROJET_DIR ok" || echo "✘ PROJET_DIR manquant"
	@test -d $(DOCS_DIR) && echo "✔ DOCS_DIR ok" || echo "✘ DOCS_DIR manquant"
	@test -d $(SUPPORTS_DIR) && echo "✔ SUPPORTS_DIR ok" || echo "✘ SUPPORTS_DIR manquant"
	@test -d $(ATELIERS_DIR) && echo "✔ ATELIERS_DIR ok" || echo "✘ ATELIERS_DIR manquant"
	@test -d $(ANNEXES_DIR) && echo "✔ ANNEXES_DIR ok" || echo "✘ ANNEXES_DIR manquant"

	@echo "[TEST] Fichiers Markdown présents :"
	@find $(PROJET_DIR) -type f -name "*.md" | sort

	@echo "[TEST] Vérification du script generate_summary.sh..."
	@test -x $(PROJET_DIR)/config/generate_summary.sh && echo "✔ Script exécutable" || echo "✘ Script non exécutable"
