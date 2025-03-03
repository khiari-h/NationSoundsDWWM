# Procédures de Maintenance

## Introduction

Ce document détaille les procédures de maintenance pour l'application NationSounds. Les procédures décrites ici visent à garantir la stabilité, la sécurité et les performances optimales de l'application au fil du temps. Elles définissent les tâches de maintenance préventive et corrective, ainsi que les responsabilités associées.

## Calendrier de Maintenance

### Maintenance quotidienne
- Vérification des logs système et applicatifs
- Surveillance des alertes et résolution des problèmes identifiés
- Vérification de la disponibilité des services

### Maintenance hebdomadaire
- Analyse des performances de l'application
- Vérification de l'intégrité des sauvegardes
- Rotation des logs anciens

### Maintenance mensuelle
- Application des mises à jour de sécurité non critiques
- Nettoyage des données temporaires et des caches
- Revue des métriques de performance
- Rapport de santé du système

### Maintenance trimestrielle
- Audit de sécurité complet
- Test de restauration des sauvegardes
- Optimisation des bases de données
- Revue et mise à jour de la documentation technique

### Maintenance annuelle
- Évaluation complète de l'infrastructure
- Test de reprise après sinistre
- Revue des technologies utilisées et planification des mises à niveau majeures
- Audit des accès et permissions

## Gestion des Mises à Jour

### Typologie des mises à jour

| Type de mise à jour | Description | Fréquence | Fenêtre de maintenance |
|---------------------|-------------|-----------|------------------------|
| **Critique** | Corrections de failles de sécurité graves | Dès disponibilité | Immédiate |
| **Majeure** | Nouvelles fonctionnalités, améliorations importantes | Trimestrielle | Weekend planifié |
| **Mineure** | Corrections de bugs, petites améliorations | Mensuelle | Nuit (22h-5h) |
| **Dépendances** | Mise à jour des bibliothèques et frameworks | Mensuelle | Nuit (22h-5h) |

### Processus de mise à jour

1. **Préparation**
   - Évaluation de l'impact potentiel
   - Création d'un plan de déploiement
   - Vérification des sauvegardes récentes
   - Communication aux parties prenantes

2. **Test**
   - Déploiement en environnement de test
   - Exécution des tests automatisés
   - Test manuel des fonctionnalités impactées
   - Validation de la performance

3. **Déploiement**
   - Création d'une sauvegarde pré-déploiement
   - Déploiement selon le processus établi dans le [Guide de Déploiement](./deployment-guide-backend.md)
   - Vérification post-déploiement
   - Surveillance des métriques clés

4. **Rollback (si nécessaire)**
   - Décision de rollback basée sur les critères prédéfinis
   - Exécution du script de rollback
   - Vérification du retour à l'état stable
   - Analyse post-mortem de l'échec

### Plan de communication

Pour chaque type de mise à jour, un plan de communication doit être établi :

| Type de mise à jour | Préavis | Destinataires | Canaux |
|---------------------|---------|---------------|--------|
| **Critique** | ASAP | Équipe technique, Management | Slack, Email, SMS |
| **Majeure** | 2 semaines | Tous les utilisateurs, Équipe technique, Management | Email, Site web, In-app |
| **Mineure** | 48 heures | Équipe technique | Slack, Email |
| **Dépendances** | 24 heures | Équipe technique | Slack |

## Gestion des Sauvegardes

### Stratégie de sauvegarde

#### Base de données
- **Sauvegarde complète** : Quotidienne (1h00)
- **Sauvegarde différentielle** : Toutes les 6 heures
- **Sauvegarde des logs de transactions** : Toutes les heures
- **Retention** : 30 jours pour les sauvegardes quotidiennes, 7 jours pour les différentielles, 24 heures pour les logs

#### Fichiers utilisateurs
- **Sauvegarde complète** : Quotidienne (3h00)
- **Sauvegarde incrémentale** : Quotidienne (15h00)
- **Retention** : 90 jours

#### Configuration système
- **Sauvegarde complète** : Après chaque modification significative
- **Sauvegarde automatique** : Hebdomadaire (Dimanche 2h00)
- **Retention** : 1 an

### Stockage des sauvegardes

- **Stockage primaire** : Serveur de backup dédié sur site différent
- **Stockage secondaire** : Stockage cloud chiffré (AWS S3 avec classe Glacier pour les archives)
- **Stockage hors ligne** : Disque dur externe sécurisé (mensuel)

### Procédure de vérification

1. **Vérification automatique**
   - Contrôle d'intégrité après chaque sauvegarde
   - Rapport quotidien des statuts de sauvegarde
   - Alerte en cas d'échec

2. **Vérification manuelle**
   - Test mensuel de restauration partielle
   - Test trimestriel de restauration complète
   - Documentation des résultats des tests

### Procédure de restauration

#### Restauration complète

```bash
#!/bin/bash
# full_restore.sh - Script de restauration complète

# 1. Arrêter les services
systemctl stop nginx
systemctl stop php-fpm
systemctl stop mysql

# 2. Restaurer la base de données
mysql_restore() {
    echo "Restauration de la base de données à partir de $1"
    gunzip < $1 | mysql -u root -p$DB_PASSWORD
}

# 3. Restaurer les fichiers
file_restore() {
    echo "Restauration des fichiers à partir de $1"
    tar -xzf $1 -C /var/www/nationsounds
}

# 4. Restaurer la configuration
config_restore() {
    echo "Restauration de la configuration à partir de $1"
    tar -xzf $1 -C /etc
}

# 5. Vérification
verify_restore() {
    echo "Vérification de la restauration..."
    # Vérifier que les tables existent
    mysql -u root -p$DB_PASSWORD -e "SHOW TABLES FROM nationsounds;"
    
    # Vérifier que les fichiers essentiels existent
    ls -la /var/www/nationsounds/public
    
    # Vérifier les permissions
    find /var/www/nationsounds -type f -name "*.php" -exec ls -la {} \;
}

# 6. Redémarrer les services
start_services() {
    echo "Redémarrage des services..."
    systemctl start mysql
    systemctl start php-fpm
    systemctl start nginx
    
    # Vérifier que les services sont actifs
    systemctl status mysql
    systemctl status php-fpm
    systemctl status nginx
}

# Exécution principale
mysql_restore $1
file_restore $2
config_restore $3
verify_restore
start_services
```

#### Restauration partielle (base de données uniquement)

```bash
#!/bin/bash
# db_restore.sh - Script de restauration de la base de données

DB_NAME="nationsounds"
DB_USER="nationsounds_user"
DB_PASS="password" # À externaliser en variable d'environnement

# 1. Restaurer la base de données
echo "Restauration de la base de données à partir de $1"
gunzip < $1 | mysql -u $DB_USER -p$DB_PASS $DB_NAME

# 2. Vérifier la restauration
echo "Vérification de la restauration..."
mysql -u $DB_USER -p$DB_PASS -e "SELECT COUNT(*) FROM users;" $DB_NAME
mysql -u $DB_USER -p$DB_PASS -e "SELECT COUNT(*) FROM concerts;" $DB_NAME
mysql -u $DB_USER -p$DB_PASS -e "SELECT COUNT(*) FROM artists;" $DB_NAME

echo "Restauration terminée."
```

## Gestion des Logs

### Politique de logging

#### Types de logs
- **Logs système** : Logs du serveur, système d'exploitation
- **Logs applicatifs** : Logs de l'application Laravel
- **Logs d'accès** : Logs du serveur web
- **Logs de sécurité** : Tentatives d'authentification, actions administratives

#### Niveaux de logs
- **DEBUG** : Informations détaillées, utiles en développement
- **INFO** : Information générale sur les opérations réussies
- **WARNING** : Situations non critiques mais nécessitant attention
- **ERROR** : Erreurs qui n'empêchent pas l'application de fonctionner
- **CRITICAL** : Erreurs critiques nécessitant intervention immédiate

### Configuration de la rotation des logs

Configuration `logrotate` pour les logs de l'application :

```
/var/log/nationsounds/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 www-data www-data
    sharedscripts
    postrotate
        systemctl reload php8.1-fpm
    endscript
}
```

Configuration pour les logs de base de données :

```
/var/log/mysql/*.log {
    weekly
    rotate 8
    missingok
    create 0640 mysql mysql
    compress
    delaycompress
    postrotate
        systemctl reload mysql
    endscript
}
```

### Centralisation et Analyse

Utilisation d'ELK Stack (Elasticsearch, Logstash, Kibana) pour la centralisation et l'analyse des logs :

```yaml
# Exemple de configuration Logstash pour collecter les logs Laravel
input {
  file {
    path => "/var/log/nationsounds/laravel.log"
    type => "laravel"
    start_position => "beginning"
  }
}

filter {
  if [type] == "laravel" {
    grok {
      match => { "message" => "\[%{TIMESTAMP_ISO8601:timestamp}\] %{WORD:env}\.%{LOGLEVEL:log_level}: %{GREEDYDATA:log_message}" }
    }
    date {
      match => [ "timestamp", "ISO8601" ]
    }
  }
}

output {
  elasticsearch {
    hosts => ["elasticsearch:9200"]
    index => "nationsounds-logs-%{+YYYY.MM.dd}"
  }
}
```

## Maintenance de la Base de Données

### Optimisations régulières

#### Hebdomadaire
- Analyse des tables pour les index manquants
- Mise à jour des statistiques

```sql
-- Analyser les tables
ANALYZE TABLE users, concerts, artists, bookings;

-- Identifier les requêtes lentes
SELECT * FROM mysql.slow_log WHERE query_time > 1 ORDER BY query_time DESC LIMIT 10;
```

#### Mensuelle
- Optimisation des tables
- Vérification de la fragmentation

```sql
-- Optimiser les tables
OPTIMIZE TABLE users, concerts, artists, bookings;

-- Vérifier la fragmentation des données
SELECT table_name, engine, table_rows, data_length, index_length, 
       data_free, (data_free/(data_length+index_length))*100 AS fragmentation
FROM information_schema.tables
WHERE table_schema = 'nationsounds' AND data_free > 0;
```

### Nettoyage des données

- Archivage des données anciennes (> 2 ans)
- Suppression des données temporaires et sessions expirées
- Purge des logs de transactions anciens

```sql
-- Archiver les données anciennes
CREATE TABLE concerts_archive LIKE concerts;
INSERT INTO concerts_archive SELECT * FROM concerts WHERE concert_date < DATE_SUB(NOW(), INTERVAL 2 YEAR);
DELETE FROM concerts WHERE concert_date < DATE_SUB(NOW(), INTERVAL 2 YEAR);

-- Nettoyer les sessions
DELETE FROM sessions WHERE last_activity < UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY));

-- Purger les logs temporaires
TRUNCATE TABLE job_batches;
DELETE FROM jobs WHERE created_at < DATE_SUB(NOW(), INTERVAL 7 DAY);
```

## Gestion des Capacités

### Surveillance de la capacité

- Suivi de l'utilisation des ressources (CPU, mémoire, disque, réseau)
- Prévision des besoins futurs basée sur les tendances
- Identification des goulots d'étranglement potentiels

### Planification de la capacité

Établir des seuils pour déclencher des augmentations de capacité :

| Ressource | Seuil d'alerte | Seuil critique | Action |
|-----------|----------------|----------------|--------|
| **CPU** | Utilisation > 70% pendant 1h | Utilisation > 85% pendant 15min | Augmenter les vCPU |
| **Mémoire** | Utilisation > 80% pendant 1h | Utilisation > 90% pendant 15min | Augmenter la RAM |
| **Disque** | Utilisation > 75% | Utilisation > 90% | Ajouter de l'espace de stockage |
| **Base de données** | Connections > 80% du max | Connections > 90% du max | Optimiser ou scaler |

### Procédure de scaling

```bash
#!/bin/bash
# scaling_procedure.sh - Script d'augmentation des ressources serveur

# 1. Créer un snapshot avant modification
echo "Création d'un snapshot de l'instance..."
aws ec2 create-snapshot --volume-id $VOLUME_ID --description "Pre-scaling snapshot"

# 2. Modifier le type d'instance (pour une ressource AWS EC2)
echo "Modification du type d'instance..."
aws ec2 stop-instances --instance-ids $INSTANCE_ID
aws ec2 modify-instance-attribute --instance-id $INSTANCE_ID --instance-type $NEW_INSTANCE_TYPE
aws ec2 start-instances --instance-ids $INSTANCE_ID

# 3. Vérifier l'état après scaling
echo "Vérification de l'état post-scaling..."
aws ec2 describe-instance-status --instance-ids $INSTANCE_ID

# 4. Notification
echo "Envoi d'une notification..."
curl -X POST -H 'Content-type: application/json' --data '{
    "text": "Scaling effectué : Instance $INSTANCE_ID mise à jour vers $NEW_INSTANCE_TYPE"
}' $SLACK_WEBHOOK
```

## Procédures de Mise à Niveau Majeures

### Mise à niveau de Framework (Laravel)

1. **Préparation**
   - Revue des notes de version et changements de l'API
   - Identification des dépendances à mettre à jour
   - Création d'une branche dédiée pour la mise à jour

2. **Test préliminaire**
   - Mise à jour en environnement de développement
   - Correction des incompatibilités
   - Exécution des tests automatisés

3. **Migration de données**
   - Sauvegarde complète de la base de données
   - Exécution des migrations Laravel
   - Vérification de l'intégrité des données

4. **Déploiement**
   - Déploiement en environnement de staging
   - Tests utilisateurs et validation
   - Planification d'une fenêtre de maintenance
   - Déploiement en production

5. **Vérification**
   - Surveillance intensive post-déploiement
   - Validation des fonctionnalités critiques
   - Communication du succès aux parties prenantes

### Mise à niveau de l'Infrastructure

1. **Évaluation**
   - Analyse des besoins actuels et futurs
   - Comparaison des options technologiques
   - Estimation des coûts et bénéfices

2. **Planification**
   - Conception de la nouvelle architecture
   - Création d'un plan de migration détaillé
   - Définition des critères de succès

3. **Implémentation**
   - Déploiement de la nouvelle infrastructure en parallèle
   - Migration progressive des composants
   - Tests de charges et de performance

4. **Basculement**
   - Planification d'une fenêtre de basculement
   - Procédure détaillée de migration
   - Plan de rollback en cas d'échec

5. **Optimisation**
   - Ajustements post-migration
   - Documentation de la nouvelle infrastructure
   - Formation de l'équipe technique

## Documentation et Formation

### Maintenance de la Documentation

- Revue trimestrielle de la documentation technique
- Mise à jour après chaque changement significatif
- Versionnement de la documentation

### Formation Continue

- Formation annuelle sur les procédures de maintenance
- Exercices de simulation d'incidents
- Partage des connaissances au sein de l'équipe

## Annexes

### Liste de Contrôle de Maintenance

#### Maintenance Quotidienne
- [ ] Vérification des logs d'erreur
- [ ] Vérification des sauvegardes
- [ ] Surveillance des métriques de performance
- [ ] Résolution des alertes actives

#### Maintenance Hebdomadaire
- [ ] Analyse des tendances de performance
- [ ] Revue des logs de sécurité
- [ ] Optimisation des requêtes lentes
- [ ] Vérification de l'espace disque disponible

#### Maintenance Mensuelle
- [ ] Application des mises à jour de sécurité
- [ ] Test de restauration des sauvegardes
- [ ] Nettoyage des données temporaires
- [ ] Revue des droits d'accès

### Contacts et Responsabilités

| Rôle | Responsabilité | Contact |
|------|----------------|---------|
| **Administrateur Système** | Maintenance serveurs, sauvegardes | admin@nationsounds.com |
| **Développeur Principal** | Maintenance application, déploiement | lead-dev@nationsounds.com |
| **DBA** | Maintenance base de données | dba@nationsounds.com |
| **Responsable Sécurité** | Audits, conformité | security@nationsounds.com |

### Modèles de Communication

#### Notification de Maintenance Planifiée

```
Objet: [MAINTENANCE] NationSounds - Maintenance planifiée le [DATE]

Cher utilisateur,

Nous vous informons qu'une maintenance planifiée de l'application NationSounds aura lieu le [DATE] de [HEURE DÉBUT] à [HEURE FIN].

Durant cette période, l'application pourrait être momentanément indisponible ou fonctionner en mode dégradé.

Nature des travaux : [DESCRIPTION BRÈVE]
Impact prévu : [IMPACT SUR LES UTILISATEURS]

Nous nous excusons pour la gêne occasionnée et vous remercions de votre compréhension.

L'équipe NationSounds
```

#### Rapport Post-Maintenance

```
Objet: [RAPPORT] Maintenance NationSounds du [DATE]

Résumé de la maintenance :
- Date et durée : [DATE], [DURÉE]
- Opérations effectuées : [LISTE DES OPÉRATIONS]
- Problèmes rencontrés : [PROBLÈMES ÉVENTUELS]
- Actions correctives : [ACTIONS PRISES]

Métriques post-maintenance :
- Temps de réponse : [AVANT] → [APRÈS]
- Utilisation ressources : [AVANT] → [APRÈS]
- Autres améliorations : [LISTE]

Prochaines étapes : [ACTIONS FUTURES PLANIFIÉES]

Équipe technique NationSounds
```