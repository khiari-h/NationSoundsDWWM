# Monitoring et Alerting

## Introduction

Ce document détaille la stratégie de monitoring et d'alerting mise en place pour l'application NationSounds. L'objectif est de garantir une haute disponibilité du service, d'identifier rapidement les problèmes potentiels et de permettre une résolution proactive des incidents avant qu'ils n'affectent les utilisateurs.

## Architecture de Monitoring

### Vue d'ensemble

Notre architecture de monitoring repose sur plusieurs niveaux de surveillance :

1. **Monitoring système** : Surveillance des ressources serveur (CPU, mémoire, disque, réseau)
2. **Monitoring applicatif** : Surveillance des performances et comportements de l'application
3. **Monitoring utilisateur** : Mesure de l'expérience utilisateur réelle
4. **Monitoring de sécurité** : Détection des menaces et comportements suspects

```
┌─────────────────────┐     ┌──────────────────┐     ┌───────────────────┐
│ Collecte de Données │────▶│  Traitement et   │────▶│  Visualisation &  │
│                     │     │  Agrégation      │     │  Alerting         │
└─────────────────────┘     └──────────────────┘     └───────────────────┘
         ▲                           ▲                         │
         │                           │                         │
         │                           │                         ▼
┌─────────────────────┐     ┌──────────────────┐     ┌───────────────────┐
│ Agents & Exporters  │     │   Stockage des   │     │ Réponse & Remède  │
│                     │     │   Métriques      │     │                   │
└─────────────────────┘     └──────────────────┘     └───────────────────┘
```

### Outils de Monitoring

#### Sentry
- **Objectif** : Monitoring d'erreurs et d'exceptions dans l'application
- **Composants surveillés** : Backend (Laravel), Frontend (React)
- **Métriques clés** : Taux d'erreurs, temps de réponse, transactions

#### New Relic
- **Objectif** : Surveillance des performances applicatives (APM)
- **Composants surveillés** : Backend, Base de données, API
- **Métriques clés** : Latence des requêtes, débit, utilisation des ressources, traçage distribué

#### Uptime Robot
- **Objectif** : Surveillance de la disponibilité et temps de réponse externe
- **Composants surveillés** : Points de terminaison API, site web frontend
- **Métriques clés** : Disponibilité (uptime), temps de réponse, codes de statut HTTP

#### Prometheus & Grafana (optionnel)
- **Objectif** : Stockage de métriques à long terme et visualisations personnalisées
- **Composants surveillés** : Infrastructure, application, bases de données
- **Métriques clés** : Personnalisables selon les besoins spécifiques du projet

## Configuration des Outils

### Sentry

#### Installation
```bash
# Installation du SDK Laravel
composer require sentry/sentry-laravel

# Publication de la configuration
php artisan sentry:publish --dsn=https://your-sentry-dsn@sentry.io/project-id
```

#### Configuration
Dans le fichier `.env` :
```
SENTRY_LARAVEL_DSN=https://your-sentry-dsn@sentry.io/project-id
SENTRY_TRACES_SAMPLE_RATE=1.0
SENTRY_ENVIRONMENT=production
```

Dans le fichier `app/Exceptions/Handler.php` :
```php
public function report(Throwable $exception)
{
    if (app()->bound('sentry') && $this->shouldReport($exception)) {
        app('sentry')->captureException($exception);
    }

    parent::report($exception);
}
```

Configuration Frontend (React) :
```javascript
import * as Sentry from '@sentry/react';

Sentry.init({
  dsn: "https://your-sentry-dsn@sentry.io/project-id",
  integrations: [new Sentry.BrowserTracing()],
  tracesSampleRate: 1.0,
  environment: 'production',
});
```

### New Relic

#### Installation
```bash
# Téléchargement et installation de l'agent
curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash

# Installation de APM
NEW_RELIC_API_KEY=<YOUR_API_KEY> NEW_RELIC_ACCOUNT_ID=<YOUR_ACCOUNT_ID> \
  /usr/local/bin/newrelic install -n php-agent-installer
```

#### Configuration
Dans le fichier `newrelic.ini` :
```ini
newrelic.appname = "NationSounds"
newrelic.license = "your-license-key"
newrelic.framework = "laravel"
newrelic.framework.drupal.modules = true
newrelic.browser_monitoring.auto_instrument = true
newrelic.transaction_tracer.record_sql = "obfuscated"
```

### Uptime Robot

#### Configuration
1. Créer un compte sur [Uptime Robot](https://uptimerobot.com/)
2. Ajouter les moniteurs suivants :
   - Monitor Type: HTTP(s)
   - URL: https://api.nationsounds.com/health
   - Monitoring Interval: 5 minutes
   - Alert Contact: équipe technique (email et Slack)

Répéter pour les endpoints importants :
- Site principal: https://nationsounds.com
- API: https://api.nationsounds.com/api/v1/status
- Backoffice: https://admin.nationsounds.com

## Stratégie d'Alerting

### Niveaux d'Alerte

| Niveau | Description | Délai de réponse | Canal de notification |
|--------|-------------|------------------|----------------------|
| **Critique** | Incident affectant tous les utilisateurs | Immédiat (24/7) | SMS, Appel, Slack, Email |
| **Élevé** | Incident affectant une fonctionnalité majeure | < 30 minutes | Slack, Email |
| **Moyen** | Performance dégradée | < 2 heures | Slack, Email |
| **Faible** | Anomalie mineure | Jour ouvré suivant | Email |

### Matrice d'Alerte

| Métrique | Seuil Critique | Seuil Élevé | Seuil Moyen | Seuil Faible |
|----------|----------------|-------------|-------------|--------------|
| Uptime | < 99.5% | < 99.9% | < 99.95% | < 99.99% |
| Temps de réponse API | > 1000ms | > 500ms | > 300ms | > 200ms |
| Taux d'erreur | > 5% | > 2% | > 1% | > 0.5% |
| Utilisation CPU | > 90% | > 80% | > 70% | > 60% |
| Utilisation mémoire | > 90% | > 80% | > 70% | > 60% |
| Espace disque disponible | < 5% | < 10% | < 20% | < 30% |

## Scripts d'Alerte

### Script de monitoring santé API

```bash
#!/bin/bash
# health_check.sh - Vérifie la santé de l'API et envoie des alertes

API_URL="https://api.nationsounds.com/health"
SLACK_WEBHOOK="https://hooks.slack.com/services/XXX/YYY/ZZZ"

response=$(curl -s -o /dev/null -w "%{http_code}" $API_URL)

if [ $response -ne 200 ]; then
    # Enregistrer dans les logs
    echo "$(date) - L'API est indisponible (code: $response)" >> /var/log/nationsounds/health.log
    
    # Envoyer une alerte Slack
    curl -X POST -H 'Content-type: application/json' --data '{
        "text": "🚨 ALERTE: L'API NationSounds est indisponible (code: '"$response"')!"
    }' $SLACK_WEBHOOK
    
    # Envoyer un email
    echo "L'API NationSounds est indisponible (code: $response)!" | mail -s "ALERTE: API NationSounds indisponible" tech-alert@nationsounds.com
fi
```

### Script d'alerte utilisation ressources

```bash
#!/bin/bash
# resource_monitor.sh - Surveille les ressources serveur

SLACK_WEBHOOK="https://hooks.slack.com/services/XXX/YYY/ZZZ"
LOG_FILE="/var/log/nationsounds/resource.log"

# Vérifier l'utilisation CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
cpu_threshold=80

# Vérifier l'utilisation mémoire
mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
mem_threshold=80

# Vérifier l'espace disque
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
disk_threshold=80

# Logger les valeurs
echo "$(date) - CPU: $cpu_usage%, MEM: $mem_usage%, DISK: $disk_usage%" >> $LOG_FILE

# Vérifier les seuils et alerter si nécessaire
if (( $(echo "$cpu_usage > $cpu_threshold" | bc -l) )); then
    curl -X POST -H 'Content-type: application/json' --data '{
        "text": "🚨 ALERTE: Utilisation CPU élevée: '"$cpu_usage"'%"
    }' $SLACK_WEBHOOK
fi

if (( $(echo "$mem_usage > $mem_threshold" | bc -l) )); then
    curl -X POST -H 'Content-type: application/json' --data '{
        "text": "🚨 ALERTE: Utilisation mémoire élevée: '"$mem_usage"'%"
    }' $SLACK_WEBHOOK
fi

if (( $(echo "$disk_usage > $disk_threshold" | bc -l) )); then
    curl -X POST -H 'Content-type: application/json' --data '{
        "text": "🚨 ALERTE: Espace disque faible: '"$disk_usage"'%"
    }' $SLACK_WEBHOOK
fi
```

## Tableaux de Bord (Dashboards)

### Dashboard Principal
Un dashboard consolidé accessible à l'équipe technique présentant :
- Disponibilité du service en temps réel
- Temps de réponse moyen des API
- Taux d'erreur global
- Utilisation des ressources serveur
- Nombre de sessions utilisateurs actives

### Dashboard Performance
Destiné à l'équipe dev/DevOps pour l'optimisation :
- Temps de réponse par endpoint API
- Temps d'exécution des requêtes SQL les plus lentes
- Utilisation du cache et taux de hit/miss
- Performance de chargement frontend

### Dashboard Métier
Pour les parties prenantes non techniques :
- Nombre d'utilisateurs actifs
- Taux de conversion
- Temps de session moyen
- Fonctionnalités les plus utilisées

## Procédures d'Intervention

### Processus d'Escalade

1. **Niveau 1** : Alerte reçue par l'équipe support technique
   - Analyse initiale et résolution si possible
   - Escalade au niveau 2 si non résolu en 15 minutes

2. **Niveau 2** : Prise en charge par l'équipe développement
   - Analyse approfondie et application des correctifs
   - Escalade au niveau 3 si non résolu en 30 minutes

3. **Niveau 3** : Intervention de l'architecte système et du responsable technique
   - Mobilisation de ressources supplémentaires si nécessaire
   - Communication aux parties prenantes

### Runbook d'Intervention

#### Indisponibilité API
1. Vérifier l'état des serveurs d'application
2. Contrôler les logs d'erreur récents
3. Vérifier la connexion à la base de données
4. Redémarrer les services web si nécessaire
5. Vérifier les ressources système (CPU, mémoire, disque)
6. Basculer sur l'infrastructure de secours si disponible

#### Performance Dégradée
1. Identifier les requêtes lentes dans les logs
2. Vérifier les pics d'utilisation des ressources
3. Analyser les métriques Sentry/New Relic pour les goulots d'étranglement
4. Optimiser les requêtes problématiques
5. Augmenter temporairement les ressources si nécessaire

#### Erreurs Applicatives
1. Analyser les erreurs dans Sentry
2. Reproduire le problème en environnement de test
3. Appliquer un correctif temporaire si possible
4. Développer et déployer un correctif permanent
5. Vérifier la résolution à l'aide des métriques

## Maintenance et Amélioration Continue

### Revue Périodique
- Analyse mensuelle des performances et incidents
- Ajustement des seuils d'alerte selon les résultats
- Mise à jour des runbooks et procédures

### Tests de Charge Réguliers
- Simulation trimestrielle de pics de trafic
- Vérification de la résilience du système
- Identification proactive des points faibles

### Cycle d'Amélioration
```
┌───────────────┐     ┌───────────────┐     ┌───────────────┐
│   Collecter   │────▶│   Analyser    │────▶│  Implémenter  │
│  les données  │     │  les données  │     │des améliorations│
└───────────────┘     └───────────────┘     └───────────────┘
        ▲                                           │
        └───────────────────────────────────────────┘
```

## Conclusion

Cette stratégie de monitoring et d'alerting vise à garantir une expérience utilisateur optimale pour l'application NationSounds, en permettant une détection rapide et une résolution efficace des problèmes. La combinaison d'outils spécialisés, de seuils d'alerte bien définis et de procédures d'intervention structurées assure la stabilité et la performance de la plateforme.