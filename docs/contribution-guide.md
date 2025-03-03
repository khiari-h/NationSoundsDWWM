# Guide de Contribution

## Introduction

Bienvenue dans le guide de contribution du projet NationSounds ! Ce document a pour objectif de vous accompagner dans votre participation au développement du projet. Que vous soyez un contributeur régulier ou occasionnel, nous vous remercions de prendre le temps de contribuer à notre projet.

## Table des matières

- [Code de conduite](#code-de-conduite)
- [Comment contribuer](#comment-contribuer)
- [Workflow Git](#workflow-git)
- [Standards de code](#standards-de-code)
- [Soumettre une Pull Request](#soumettre-une-pull-request)
- [Processus de revue](#processus-de-revue)
- [Environnement de développement](#environnement-de-développement)
- [Communication](#communication)

## Code de conduite

Notre projet adopte un code de conduite que tous les contributeurs doivent respecter. En participant, vous êtes tenu d'en respecter les termes.

Nous nous engageons à créer un environnement accueillant et respectueux pour tous, indépendamment de l'âge, de l'origine, du handicap, de l'ethnicité, de l'identité de genre, du niveau d'expérience, de la nationalité ou de la religion.

## Comment contribuer

Vous pouvez contribuer au projet de plusieurs façons :

### 1. Signaler des bugs

Si vous découvrez un bug, veuillez créer une issue avec :
- Une description claire du problème
- Les étapes pour reproduire le bug
- Le comportement attendu vs observé
- Captures d'écran si applicable
- Informations sur votre environnement

### 2. Suggérer des améliorations

Pour suggérer une amélioration, créez une issue incluant :
- Une description claire de la fonctionnalité
- La motivation derrière cette suggestion
- Des exemples d'utilisation si possible

### 3. Contribuer au code

Pour contribuer directement au code :
1. Forker le dépôt
2. Créer une branche pour votre contribution
3. Développer votre fonctionnalité ou correction
4. Écrire ou mettre à jour les tests
5. S'assurer que le code respecte les standards
6. Soumettre une Pull Request

### 4. Améliorer la documentation

La documentation est cruciale pour notre projet. Vous pouvez contribuer en :
- Corrigeant des fautes
- Améliorant la clarté des explications
- Ajoutant des exemples
- Traduisant la documentation existante

## Workflow Git

Nous suivons un workflow Git basé sur les fonctionnalités (feature branches).

### 1. Forker le dépôt

Commencez par forker le dépôt principal sur GitHub.

### 2. Cloner votre fork

```bash
git clone https://github.com/votre-username/NationSounds.git
cd NationSounds
```

### 3. Ajouter le dépôt principal comme remote upstream

```bash
git remote add upstream https://github.com/organisation/NationSounds.git
```

### 4. Créer une branche pour votre contribution

Nommez votre branche selon le type de contribution :

```bash
git checkout -b feature/ma-nouvelle-fonctionnalite
```

Types de préfixes recommandés :
- `feature/` pour les nouvelles fonctionnalités
- `bugfix/` pour les corrections de bugs
- `docs/` pour les changements de documentation
- `test/` pour les ajouts ou modifications de tests
- `refactor/` pour les modifications de code sans ajout de fonctionnalité

### 5. Maintenir votre branche à jour

```bash
git checkout main
git pull upstream main
git checkout feature/ma-nouvelle-fonctionnalite
git rebase main
```

### Conventions de commit

Nous utilisons la convention de commit suivante :

```
<type>[scope optional]: <description>

[optional body]

[optional footer(s)]
```

Types courants :
- `feat`: Nouvelle fonctionnalité
- `fix`: Correction de bug
- `docs`: Changements de documentation
- `style`: Changements de formatage
- `refactor`: Refactorisation du code
- `test`: Ajout ou modification de tests
- `chore`: Changements de build ou d'outils

## Standards de code

### Principes généraux

- Le code doit être lisible et maintenable
- Suivre les conventions de nommage du projet
- Écrire du code auto-documenté
- Commenter le code lorsque nécessaire
- Respecter le principe DRY (Don't Repeat Yourself)
- Suivre les principes SOLID

### Backend (Laravel)

- Suivre les standards PSR et les conventions Laravel
- Utiliser le typage strict quand c'est possible
- Documenter les méthodes et classes avec PHPDoc

### Frontend (React)

- Respecter la structure Atomic Design
- Suivre les bonnes pratiques React
- Nommer les composants et fichiers de manière cohérente

## Soumettre une Pull Request

1. Poussez votre branche vers votre fork
```bash
git push origin feature/ma-nouvelle-fonctionnalite
```

2. Ouvrez une Pull Request depuis GitHub
3. Complétez le modèle de Pull Request fourni
4. Liez les issues pertinentes

### Contenu de la Pull Request

- Description claire des changements
- Liste des fonctionnalités ajoutées ou modifiées
- Liens vers les issues concernées
- Screenshots si applicable

## Processus de revue

Votre Pull Request sera examinée par au moins un membre de l'équipe principale.

### Critères de revue

Votre code sera évalué selon les critères suivants :
- Fonctionnalité
- Qualité du code
- Présence de tests
- Documentation à jour
- Performance
- Sécurité

### Feedback

Si des modifications sont demandées, veuillez les prendre en compte et mettre à jour votre Pull Request.

## Environnement de développement

### Prérequis

- PHP 8.1+
- Composer
- Node.js 20.11.1+
- npm
- MySQL 8.0+
- Git

### Installation

Les instructions détaillées d'installation sont disponibles dans le fichier README.md du projet.

## Communication

### Canaux de communication

- GitHub Issues : Pour les bugs et fonctionnalités
- Email : Pour les communications officielles
- Slack/Discord : Pour les discussions informelles

## Remerciements

Nous remercions tous les contributeurs qui aident à améliorer ce projet. Chaque contribution, qu'elle soit grande ou petite, est précieuse pour faire avancer le projet NationSounds.