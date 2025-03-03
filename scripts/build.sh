#!/bin/bash

# Script de build NationSounds

PROJECT_ROOT=$(dirname "$0")/..
FRONTEND_DIR="$PROJECT_ROOT/frontend"
BACKEND_DIR="$PROJECT_ROOT/backend"
BUILD_DIR="$PROJECT_ROOT/build"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

prepare_build_directory() {
    mkdir -p "$BUILD_DIR"
    rm -rf "$BUILD_DIR"/*
}

build_frontend() {
    log "Construction frontend..."
    cd "$FRONTEND_DIR"
    npm install
    npm run build
    cp -r build "$BUILD_DIR/frontend"
}

build_backend() {
    log "Construction backend..."
    cd "$BACKEND_DIR"
    composer install --no-dev
    cp -r . "$BUILD_DIR/backend"
}

main() {
    prepare_build_directory
    build_frontend
    build_backend
    log "Build terminé dans $BUILD_DIR"
}

main