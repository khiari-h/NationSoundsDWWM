#!/bin/bash

# Script de déploiement NationSounds
# Usage: ./deploy.sh [env]

# Paramètres
ENV=${1:-production}
PROJECT_ROOT=$(dirname "$0")/..
FRONTEND_DIR="$PROJECT_ROOT/frontend"
BACKEND_DIR="$PROJECT_ROOT/backend"

# Fonction de log
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Déploiement frontend React
deploy_frontend() {
    log "Déploiement frontend..."
    cd "$FRONTEND_DIR"
    npm install
    npm run build
}

# Déploiement backend Laravel
deploy_backend() {
    log "Déploiement backend..."
    cd "$BACKEND_DIR"
    composer install --no-dev
    php artisan key:generate
    php artisan config:clear
    php artisan migrate --force
}

# Démarrage des services
start_services() {
    log "Démarrage des services..."
    # Ajoutez ici vos commandes de démarrage (pm2, systemd, etc.)
}

# Fonction principale
main() {
    log "Début du déploiement pour l'environnement $ENV"
    
    deploy_frontend
    deploy_backend
    start_services
    
    log "Déploiement terminé avec succès"
}

# Exécution
main