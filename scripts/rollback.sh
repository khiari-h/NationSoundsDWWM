#!/bin/bash

# Script de rollback NationSounds

PROJECT_ROOT=$(dirname "$0")/..
BACKUP_DIR="$PROJECT_ROOT/backups"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Restaurer une version précédente
rollback() {
    log "Recherche du dernier point de restauration..."
    
    # Récupérer le dernier backup
    LATEST_BACKUP=$(ls -t "$BACKUP_DIR" | head -1)
    
    if [ -z "$LATEST_BACKUP" ]; then
        log "Aucun backup trouvé"
        exit 1
    fi
    
    log "Restauration du backup : $LATEST_BACKUP"
    
    # Restauration frontend
    tar -xzf "$BACKUP_DIR/$LATEST_BACKUP/frontend.tar.gz" -C "$PROJECT_ROOT/frontend"
    
    # Restauration backend
    tar -xzf "$BACKUP_DIR/$LATEST_BACKUP/backend.tar.gz" -C "$PROJECT_ROOT/backend"
    
    # Restauration base de données
    mysql -u root -p database_name < "$BACKUP_DIR/$LATEST_BACKUP/database.sql"
    
    log "Rollback terminé"
}

rollback