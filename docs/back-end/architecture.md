# Architecture

## Vue d'ensemble

Ce document décrit l'architecture globale de l'application, ses composants principaux et l'organisation du code. L'application est construite selon une architecture MVC (Modèle-Vue-Contrôleur) avec une API RESTful pour permettre la communication entre le backend et le frontend.

## Structure de l'application

### Backend (Laravel)

L'application backend est développée avec Laravel, un framework PHP robuste qui suit le pattern MVC.

#### Organisation des dossiers principaux

```
app/
├── Http/
│   ├── Controllers/      # Contrôleurs REST pour chaque entité
│   ├── Middleware/       # Middleware pour l'authentification et autres
├── Models/               # Modèles Eloquent pour chaque entité
├── Providers/            # Service providers Laravel

database/
├── backup/               # Sauvegardes de bases de données
└── factories/            # Factories pour la base de données
└── initial_data/         # Sauvegarde la base de données initiale
├── migrations/           # Migrations de base de données
└── seeders/              # Seeders pour les données initiales
routes/
├── api.php               # Définitions des routes API
└── web.php               # Routes web (si applicables)
```

### Frontend (Architecture Atomic Design)

Le frontend est organisé selon les principes du Atomic Design, avec une structure modulaire qui favorise la réutilisation des composants.

#### Organisation des dossiers principaux

```
src/
├── atoms/                # Composants de base (boutons, inputs, etc.)
├── molecules/            # Composants composés d'atomes (formulaires, cartes, etc.)
├── organisms/            # Sections complètes composées de molécules
├── templates/            # Mises en page sans contenu spécifique
├── pages/                # Pages complètes de l'application
│   └── admin/            # Section administration
└── services/             # Services pour les appels API et la logique métier
```

## Base de données

La base de données est relationnelle et suit une conception normalisée. Les principales entités sont:

- **AdminUsers**: Utilisateurs administrateurs
- **Artists**: Artistes participant aux événements
- **Concerts**: Événements musicaux
- **Meetings**: Rencontres avec les artistes
- **News**: Actualités et annonces
- **Partners**: Partenaires de l'événement
- **Subscribers**: Abonnés à la newsletter

### Schéma de base de données

Le schéma détaillé est disponible dans le fichier [Database Schema](./database-schema.md).

## Flux de données et interactions

### Flux d'authentification

1. L'utilisateur soumet ses identifiants via le frontend
2. Le contrôleur AuthController valide les informations
3. Si valides, un token d'authentification est généré et renvoyé
4. Le frontend stocke le token et l'inclut dans les requêtes suivantes
5. Le middleware vérifie le token pour les routes protégées

### Flux CRUD standard

1. Le frontend envoie une requête à l'API (GET, POST, PUT, DELETE)
2. Le middleware vérifie l'authentification (si nécessaire)
3. Le contrôleur approprié traite la requête
4. Le contrôleur valide les données d'entrée (si nécessaire)
5. Le contrôleur interagit avec les modèles pour effectuer les opérations de base de données
6. Le contrôleur renvoie une réponse JSON

## Patterns et principes

### Patterns de conception utilisés

- **Repository Pattern**: Séparation des préoccupations pour l'accès aux données
- **Dependency Injection**: Utilisation des conteneurs d'injection de dépendances de Laravel
- **Active Record**: Modèles Eloquent qui encapsulent l'accès à la base de données
- **Atomic Design**: Organisation modulaire et hiérarchique des composants frontend

### Principes SOLID

- **Single Responsibility**: Chaque classe a une seule responsabilité
- **Open/Closed**: Extension sans modification des comportements existants
- **Liskov Substitution**: Les classes dérivées peuvent se substituer à leurs classes de base
- **Interface Segregation**: Interfaces spécifiques plutôt que génériques
- **Dependency Inversion**: Dépendance envers les abstractions, non les implémentations

## Technologies utilisées

### Backend

- **Laravel**: Framework PHP pour le développement de l'API
- **Sanctum**: Système d'authentification par token
- **MySQL/MariaDB**: Base de données relationnelle
- **Composer**: Gestionnaire de dépendances PHP

### Frontend

- **JavaScript/TypeScript**: Langages de programmation frontend
- **React/Vue/Angular**: Framework frontend (à préciser selon votre choix)
- **Axios**: Client HTTP pour les requêtes API
- **Atomic Design**: Méthodologie d'organisation des composants

## API

L'API suit les principes REST et utilise le format JSON pour les échanges de données. 

La documentation complète de l'API est disponible dans le fichier [API Documentation](./api-documentation.md).

## Environnements

### Développement

- Environnement local avec serveur de développement Laravel
- Variables d'environnement via fichier `.env`
- Base de données locale

### Production

- Serveur web sécurisé (Nginx/Apache)
- Base de données optimisée et sécurisée
- Variables d'environnement définies au niveau du serveur
- HTTPS obligatoire

## Scalabilité et performance

- **Mise en cache**: Implémentation de caching pour les réponses API fréquemment demandées
- **Optimisation des requêtes**: Utilisation de eager loading pour éviter le problème N+1
- **Pagination**: Implémentation de pagination pour les grandes collections de données

## Documentation complémentaire

- [Database Schema](./database-schema.md): Schéma détaillé de la base de données
- [API Documentation](./api-documentation.md): Documentation complète de l'API
- [Security Guidelines](./security-guidelines.md): Directives de sécurité
- [Testing](./testing.md): Stratégies et approches de test