# NationSounds

NationSounds est un projet de festival de musique qui offre des informations complètes sur les concerts, les rencontres avec les artistes, ainsi que les informations pratiques sur le festival. Il comprend également une carte interactive pour se repérer, avec la localisation des scènes et les concerts en cours.

## Table des matières

- [Aperçu](#aperçu)
- [Technologies utilisées](#technologies-utilisées)
- [Architecture](#architecture)
- [Documentation technique](#documentation-technique)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Démarrage](#démarrage)
- [Tests](#tests)
- [Déploiement](#déploiement)
- [Contributions](#contributions)
- [Licence](#licence)
- [Contact](#contact)

## Aperçu

NationSounds est une plateforme dédiée à la gestion et à la présentation des événements d'un festival de musique. Elle permet aux utilisateurs de :

- Consulter les concerts et événements à venir.
- Obtenir des informations sur les artistes et les rencontres.
- Visualiser une carte du festival pour se repérer.
- Voir en temps réel les concerts en cours.
- S'inscrire à la newsletter pour rester informé.

L'application dispose également d'une interface d'administration complète permettant de gérer l'ensemble du contenu.

## Technologies utilisées

- **Front-end** : 
  - React.js avec architecture Atomic Design
  - Cypress pour les tests E2E
  - Jest pour les tests unitaires
- **Back-end** : 
  - Laravel (PHP)
  - MySQL
  - API RESTful avec Laravel Sanctum pour l'authentification
- **CI/CD** : Pipeline d'intégration et déploiement continu
- **Node.js** : Version 20.11.1
- **Environnement** : Responsive design pour interfaces desktop et mobile

## Architecture

L'application suit une architecture moderne et modulaire :

- **Frontend** : Architecture Atomic Design avec une séparation claire entre :
  - Atoms (composants de base)
  - Molecules (combinaisons d'atomes)
  - Organisms (assemblages complexes)
  - Templates (structures de pages)
  - Pages (vues complètes de l'application)

- **Backend** : Architecture MVC (Modèle-Vue-Contrôleur) avec Laravel :
  - Modèles : Représentent les entités de données (Artists, Concerts, Meetings, etc.)
  - Contrôleurs : Gèrent la logique métier et les requêtes API
  - Middleware : Gère l'authentification et les autorisations

Pour plus de détails, consultez la [documentation d'architecture](./documentation/Architecture.md).

## Documentation technique

Une documentation complète est disponible dans le dossier `documentation/` :

- [Architecture](./documentation/Architecture.md) - Détails sur l'architecture globale du projet
- [API Documentation](./documentation/api-documentation.md) - Documentation complète de l'API REST
- [Database Schema](./documentation/database-schema.md) - Schéma et structure de la base de données
- [Components Documentation](./documentation/components-documentation.md) - Documentation des composants frontend
- [Security Guidelines](./documentation/security-guidelines.md) - Directives de sécurité
- [Testing](./documentation/testing.md) - Stratégies et approches de test

## Prérequis

Avant de commencer, assurez-vous d'avoir installé les éléments suivants :

- **Node.js** : Version 20.11.1 ou supérieure
- **npm** : Inclus avec Node.js
- **PHP** : Version 8.1 ou supérieure
- **Composer** : Gestionnaire de dépendances PHP
- **MySQL** : Version 8.0 ou supérieure
- **Git** : Pour cloner le dépôt

## Installation

1. **Cloner le dépôt**

   ```bash
   git clone https://github.com/yourusername/NationSounds.git
   cd NationSounds
   ```

2. **Installer les dépendances**

   Pour le front-end (React) :
   ```bash
   cd frontend
   npm install
   ```

   Pour le back-end (Laravel) :
   ```bash
   cd backend
   composer install
   npm install
   ```

3. **Configurer les variables d'environnement**

   Créez un fichier `.env` dans les répertoires frontend et backend à partir des exemples `.env.example` et configurez les variables nécessaires (base de données, API, etc.).

4. **Initialisation de la Base de Données**

   Assurez-vous que vous avez configuré votre base de données dans le fichier `.env` du répertoire backend. Ensuite, utilisez les commandes de migration Laravel pour créer les tables :

   ```bash
   php artisan migrate
   php artisan db:seed
   ```

## Démarrage

**Front-end**
```bash
cd frontend
npm start
```

**Back-end**
```bash
cd backend
php artisan serve
```

Les applications front-end et back-end devraient maintenant être accessibles via http://localhost:3000 pour le front-end et http://localhost:8000 pour le back-end.

## Tests

### Tests Frontend

#### Tests Unitaires (Jest)
```bash
cd frontend
npm run test
```

#### Tests End-to-End (Cypress)
Pour lancer Cypress en mode interactif :
```bash
cd frontend
npx cypress open
```

Pour exécuter Cypress en mode headless (sans interface graphique) :
```bash
cd frontend
npx cypress run
```

### Tests Backend (PHPUnit)

Pour exécuter tous les tests backend :
```bash
cd backend
php artisan test
```

Pour exécuter un groupe spécifique de tests :
```bash
php artisan test --group=models
```

Pour plus de détails sur les tests, consultez la [documentation des tests](./documentation/testing.md).

## Déploiement

Le projet utilise une pipeline CI/CD pour le déploiement automatisé. Assurez-vous que toutes les configurations CI/CD sont correctement définies dans les workflows GitHub Actions ou dans un autre outil d'intégration continue que vous utilisez.

## Contributions

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet.
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/your-feature`).
3. Commitez vos modifications (`git commit -m 'Add some feature'`).
4. Poussez vers la branche (`git push origin feature/your-feature`).
5. Ouvrez une Pull Request.

Assurez-vous de suivre les conventions de code et d'ajouter des tests pour les nouvelles fonctionnalités.

## Licence

Ce projet est sous licence libre classique. Vous êtes libre de l'utiliser, le modifier, et le distribuer sous les conditions de cette licence.

## Contact

Pour toute question ou support, vous pouvez contacter Hamdane KHIARI.