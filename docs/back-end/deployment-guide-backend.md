Je vais adapter le guide de déploiement backend de manière similaire au frontend, en mettant l'accent sur les spécificités de Laravel et MySQL.
Voici le guide détaillé :
markdownCopy# Guide de Déploiement Backend - NationSounds

## Prérequis Techniques

### Environnement Serveur
- PHP : 8.2+ (PHP-FPM recommandé)
- Composer : 2.x
- MySQL : 8.0+
- Laravel : 10.x
- Extension PHP requises :
  - `php-mysql`
  - `php-xml`
  - `php-mbstring`
  - `php-tokenizer`
  - `php-curl`

## Configuration de l'Environnement

### Variables d'Environnement
Créer un fichier `.env.production` avec :
```bash
APP_NAME=NationSounds
APP_ENV=production
APP_KEY=base64:votre_clé_générée
APP_DEBUG=false
APP_URL=https://api.nationsounds.com

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=nationsounds_prod
DB_USERNAME=nationsounds_user
DB_PASSWORD=mot_de_passe_sécurisé

# Configuration Sanctum
SANCTUM_STATEFUL_DOMAINS=frontend.nationsounds.com
SESSION_DOMAIN=.nationsounds.com

# Logging et monitoring
LOG_CHANNEL=daily
LOG_LEVEL=error

# Sentry
SENTRY_LARAVEL_DSN=votre_dsn_sentry
Installation des Dépendances
bashCopy# Installation des dépendances Composer
composer install --no-dev --optimize-autoloader

# Installation des dépendances Node (pour compilation assets)
npm ci
npm run production
Processus de Déploiement
Préparation Initiale
bashCopy# Générer la clé d'application
php artisan key:generate --show

# Nettoyer et optimiser
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# Optimisations
php artisan config:cache
php artisan route:cache
php artisan view:cache
Migrations et Seeds
bashCopy# Migrations en production
php artisan migrate --force

# Seeds optionnels
php artisan db:seed --force
Configuration Nginx
nginxCopyserver {
    listen 80;
    server_name api.nationsounds.com;
    root /var/www/nationsounds-backend/public;

    index index.php;
    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    # Sécurité : Headers
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";
}
Sécurité
Configuration Laravel
phpCopy// config/app.php
'debug' => env('APP_DEBUG', false),

// config/cors.php
'paths' => ['api/*'],
'allowed_methods' => ['*'],
'allowed_origins' => ['https://frontend.nationsounds.com'],
Pare-feu et Restrictions
bashCopy# Configuration UFW
sudo ufw allow 'Nginx Full'
sudo ufw enable

# Désactiver les fonctions PHP sensibles
# Dans php.ini
disable_functions = exec,passthru,shell_exec,system,proc_open,popen
Monitoring et Logging
Sentry
bashCopy# Installation du SDK Laravel
composer require sentry/sentry-laravel

# Publication de la configuration
php artisan sentry:publish --dsn
Configuration des Logs
phpCopy// config/logging.php
'channels' => [
    'daily' => [
        'driver' => 'daily',
        'path' => storage_path('logs/laravel.log'),
        'level' => 'error',
        'days' => 14,
    ],
],
Maintenance
Mises à jour
bashCopy# Mettre à jour Composer
composer update --no-dev

# Mettre à jour la base de données
php artisan migrate

# Nettoyer le cache
php artisan optimize:clear
Supervision des Processus
bashCopy# Installation de Supervisor
sudo apt-get install supervisor

# Configuration pour les queues Laravel
[program:nationsounds-queue]
process_name=%(program_name)s_%(process_num)02d
command=php /var/www/nationsounds-backend/artisan queue:work --sleep=3 --tries=3
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
user=www-data
numprocs=2
redirect_stderr=true
stdout_logfile=/var/www/nationsounds-backend/storage/logs/queue.log
Rollback et Restauration
Script de Rollback
bashCopy#!/bin/bash
DEPLOY_DIR="/var/www/nationsounds-backend"
BACKUP_DIR="/var/www/backups/backend"

# Restaurer la dernière version
cp -R $BACKUP_DIR/latest/* $DEPLOY_DIR

# Réappliquer les migrations
php artisan migrate
Bonnes Pratiques

Toujours tester sur un environnement de staging
Utiliser des variables d'environnement
Maintenir à jour les dépendances
Surveiller les performances et la sécurité