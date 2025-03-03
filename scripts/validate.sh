#!/bin/bash

# Script de validation de déploiement NationSounds

FRONTEND_URL="http://localhost:3000"
BACKEND_URL="http://localhost:8000/api/health"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

check_frontend() {
    log "Vérification frontend..."
    if curl -s --head "$FRONTEND_URL" | grep "200 OK" > /dev/null; then
        log "Frontend OK"
        return 0
    else
        log "Erreur : Frontend non accessible"
        return 1
    fi
}

check_backend() {
    log "Vérification backend..."
    if curl -s "$BACKEND_URL" | grep "OK" > /dev/null; then
        log "Backend OK"
        return 0
    else
        log "Erreur : Backend non accessible"
        return 1
    }
}

main() {
    check_frontend
    FRONTEND_STATUS=$?
    
    check_backend
    BACKEND_STATUS=$?
    
    if [ $FRONTEND_STATUS -eq 0 ] && [ $BACKEND_STATUS -eq 0 ]; then
        log "Validation du déploiement réussie"
        exit 0
    else
        log "Échec de la validation du déploiement"
        exit 1
    fi
}

main