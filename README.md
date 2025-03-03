# NationSounds

## Table des matières

- [Aperçu](#aperçu)
- [Technologies](#technologies)
- [Architecture](#architecture)
- [Veille Technologique](#veille-technologique)
- [DevOps et Déploiement](#devops-et-déploiement)
- [Documentation](#documentation)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Tests](#tests)
- [Contribution](#contribution)
- [Licence](#licence)
- [Contact](#contact)

## Aperçu

NationSounds est une plateforme de gestion d'événements de festival de musique permettant aux utilisateurs de :

- Consulter les concerts et événements
- Obtenir des informations sur les artistes
- Visualiser une carte interactive du festival
- Suivre les concerts en temps réel
- S'inscrire à la newsletter

## Technologies

### Frontend
- React.js (Atomic Design)
- Cypress (Tests E2E)
- Jest (Tests unitaires)

### Backend
- Laravel (PHP)
- MySQL
- API RESTful 
- Laravel Sanctum (Authentification)

### Environnement
- Node.js 20.11.1
- Design responsive

## Architecture

### Frontend
- **Atoms** : Composants de base
- **Molecules** : Combinaisons d'atomes
- **Organisms** : Assemblages complexes
- **Templates** : Structures de pages
- **Pages** : Vues complètes

### Backend
- Architecture MVC
- **Modèles** : Entités de données
- **Contrôleurs** : Logique métier
- **Middleware** : Authentification

## Veille Technologique

### Objectifs
- Suivre les évolutions des technologies utilisées
- Maintenir la sécurité et les performances
- Anticiper les mises à jour majeures

### Outils de Veille
- Dependabot
- GitHub Alerts
- Flux RSS spécialisés
- Newsletters techniques
  - JavaScript Weekly
  - PHP Weekly
  - Security Updates

### Stratégie
- Revue mensuelle des dépendances
- Analyse des changements de versions
- Évaluation des impacts potentiels
- Tests de compatibilité

## DevOps et Déploiement

### Pipeline CI/CD
- Plateforme : GitHub Actions
- Étapes automatisées :
  1. Build
  2. Tests unitaires
  3. Tests E2E
  4. Analyse de sécurité
  5. Déploiement conditionnel

### Environnements
- Développement
- Staging 
- Production

### Stratégie de Déploiement
- Déploiement automatisé
- Rollback en cas d'échec
- Monitoring des performances
- Gestion des credentials

### Outils de Monitoring
- Sentry (suivi des erreurs)
- New Relic (performances)
- Uptime Robot (disponibilité)

## Documentation

La documentation complète du projet est disponible dans les fichiers suivants :

- [Architecture](./docs/architecture.md) - Vue d'ensemble de l'architecture du projet
- [Guide de Déploiement Backend](./docs/deployment-guide-backend.md) - Instructions détaillées pour le déploiement
- [Directives de Sécurité](./docs/security-guidelines.md) - Pratiques et directives de sécurité
- [Politique de Sécurité](./SECURITY.md) - Politique de sécurité et reporting des vulnérabilités
- [Tests](./docs/testing.md) - Stratégies et approches de test
- [Monitoring et Alerting](./docs/monitoring.md) - Configuration des outils de monitoring
- [Procédures de Maintenance](./docs/maintenance-procedures.md) - Procédures détaillées de maintenance
- [Guide de Contribution](./docs/contribution-guide.md) - Guide pour les contributeurs

## Prérequis

- Node.js 20.11.1+
- npm
- PHP 8.1+
- Composer
- MySQL 8.0+
- Git

## Installation

### Clonage
```bash
git clone https://github.com/votre-username/NationSounds.git
cd NationSounds
```

### Dépendances
```bash
# Frontend
cd frontend
npm install

# Backend
cd backend
composer install
npm install
```

### Configuration
```bash
# Créer les fichiers .env
cp frontend/.env.example frontend/.env
cp backend/.env.example backend/.env

# Configurer les variables d'environnement selon votre environnement

# Migrer la base de données
cd backend
php artisan migrate --seed
```

## Tests

### Frontend
```bash
# Tests unitaires
npm run test

# Tests E2E
npx cypress run
```

### Backend
```bash
# Tous les tests
php artisan test

# Tests spécifiques
php artisan test --group=models
```

## Contribution

Pour contribuer au projet, veuillez consulter notre [Guide de Contribution](./docs/contribution-guide.md) qui détaille le processus complet.

En résumé :
- Fork du projet
- Créer une branche (feature/ma-fonctionnalite)
- Commiter les modifications
- Pousser la branche
- Ouvrir une Pull Request

## Licence

Ce projet est sous licence libre classique. Vous êtes libre de l'utiliser, le modifier, et le distribuer sous les conditions de cette licence.

## Contact

Pour toute question ou support, vous pouvez contacter Hamdane KHIARI.