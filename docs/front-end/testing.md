# Documentation des Tests Frontend

Ce document décrit l'approche de test utilisée pour le frontend du projet, couvrant les tests unitaires (avec Jest et React Testing Library) et les tests End-to-End (E2E) avec Cypress.

## Organisation des Tests Frontend

Les tests sont organisés en deux sections principales :
- Tests Unitaires (Jest/React Testing Library)
- Tests End-to-End (Cypress)

## Tests Frontend

### Tests Unitaires (Jest/React Testing Library)

Les tests unitaires frontend vérifient le bon fonctionnement des composants React individuels, principalement à l'aide de Jest et React Testing Library.

#### Structure des tests unitaires frontend

frontend/ └── src/ └── tests/ ├── atoms/ │ └── ... (tests des composants atomiques) ├── molecules/ │ ├── Accordion.test.js │ ├── CTASection.test.js │ ├── InfoCard.test.js │ ├── NavItem.test.js │ ├── NewsCard.test.js │ └── PartnersCard.test.js ├── organisms/ │ └── ... (tests des organismes) └── ... (autres dossiers de tests)

markdown
Copier
Modifier

#### Exemples de tests unitaires

Ces tests vérifient le rendu correct des composants et leurs interactions :
- Tests de rendu des composants
- Tests des props et états
- Tests des événements utilisateur (clics, soumissions de formulaires)
- Tests des comportements conditionnels

### Tests End-to-End (Cypress)

Les tests E2E avec Cypress simulent les interactions réelles des utilisateurs avec l'application complète.

#### Structure des tests E2E

test-main/ └── frontend/ └── cypress/ └── e2e/ ├── AdminDashboard.cy.js ├── AdminLogin.cy.js ├── ConcertManagement.cy.js ├── ConcertPage.cy.js ├── HomePage.cy.js ├── MeetingManagement.cy.js ├── NewsManagement.cy.js ├── NewsPage.cy.js ├── PartnersPage.cy.js └── ProgrammingPage.cy.js

markdown
Copier
Modifier

#### Types de tests E2E

##### Tests des pages publiques
Ces tests vérifient le bon fonctionnement des pages accessibles au public :
- `HomePage.cy.js` - Tests de la page d'accueil
- `ConcertPage.cy.js` - Tests des pages de détails des concerts
- `NewsPage.cy.js` - Tests de la page des actualités
- `PartnersPage.cy.js` - Tests de la page des partenaires
- `ProgrammingPage.cy.js` - Tests de la page de programmation

##### Tests de l'interface d'administration
Ces tests vérifient le bon fonctionnement de l'interface d'administration :
- `AdminLogin.cy.js` - Tests de l'authentification administrateur
- `AdminDashboard.cy.js` - Tests du tableau de bord admin
- `ConcertManagement.cy.js` - Tests de la gestion des concerts
- `MeetingManagement.cy.js` - Tests de la gestion des rencontres
- `NewsManagement.cy.js` - Tests de la gestion des actualités

### Exécution des tests frontend

#### Tests unitaires

```bash
# Exécuter tous les tests unitaires
npm test

# Exécuter les tests avec watch mode
npm test -- --watch

# Exécuter les tests d'un composant spécifique
npm test -- Accordion.test.js
Tests E2E
bash
Copier
Modifier
# Ouvrir Cypress en mode interactif
npm run cypress:open

# Exécuter tous les tests en mode headless
npm run cypress:run

# Exécuter un test spécifique
npm run cypress:run -- --spec "cypress/e2e/HomePage.cy.js"
Bonnes pratiques
Organisation des tests
Nommage des fichiers de test : Le nom du fichier doit correspondre au composant testé, suivi de .test.js (frontend)
Structure des dossiers : Les tests doivent suivre la même structure que le code source
Écriture des tests
Principe AAA (Arrange, Act, Assert) : organiser les tests en ces trois sections
Tests indépendants : Chaque test doit être indépendant des autres
Mocks et stubs : Utiliser des mocks pour isoler le code testé des dépendances externes
Couverture de code
L'objectif est d'avoir une couverture de test complète pour les aspects critiques :

Fonctionnalités principales et flux utilisateur
Points d'intégration
Logique métier complexe
Gestion des erreurs
Intégration continue
Les tests sont exécutés automatiquement lors de chaque commit/push pour assurer la stabilité continue du code.

kotlin
Copier
Modifier

Cela centralise les tests Frontend dans un seul fichier et rend la documentation claire et bien st