# Security Guidelines

## Introduction

Ce document décrit les directives et pratiques de sécurité mises en place pour protéger l'application et ses données. Ces pratiques visent à minimiser les risques de sécurité et à assurer une expérience utilisateur sécurisée.

## Authentification et Autorisation

### Authentification Admin

- L'accès à la console d'administration est protégé par Laravel Sanctum
- Les tokens d'authentification sont générés de manière sécurisée
- Les sessions d'admin expirent après une période d'inactivité
- Les mots de passe sont stockés de façon sécurisée avec le hachage bcrypt

### Autorisation

- Middleware `auth:sanctum` pour protéger toutes les routes d'administration
- Middleware `admin` personnalisé pour restreindre l'accès aux seuls utilisateurs administrateurs
- Principe du moindre privilège : les administrateurs n'ont accès qu'aux fonctionnalités nécessaires

## Protection contre les attaques courantes

### Cross-Site Request Forgery (CSRF)

- Tous les formulaires incluent des tokens CSRF
- Middleware Laravel `VerifyCsrfToken` activé pour toutes les routes web
- Route dédiée pour obtenir un token CSRF pour les applications frontend

### Cross-Site Scripting (XSS)

- Laravel : Utilisation des outils classiques de Laravel pour protéger contre les attaques XSS. Cela inclut l’échappement des variables dans les réponses JSON et l’utilisation de la validation des données côté serveur.
- React : En React, les données insérées dans les composants JSX sont automatiquement échappées, ce qui empêche l'injection de code malveillant dans le DOM.

### SQL Injection

- Utilisation du Query Builder et Eloquent ORM de Laravel
- Toutes les entrées utilisateur sont validées et filtrées
- Paramètres liés utilisés pour toutes les requêtes SQL dynamiques

### API Security

- Tous les endpoints API sensibles nécessitent une authentification
- Rate limiting sur les endpoints d'authentification pour prévenir les attaques par force brute
- Validation stricte des entrées pour tous les endpoints API

## Gestion des données sensibles

- Aucune information sensible (mots de passe, tokens) n'est stockée en clair
- Les données sensibles ne sont pas enregistrées dans les logs
- Attribut `$hidden` utilisé dans les modèles pour masquer les données sensibles lors de la sérialisation

## Environnement et configuration

- Fichier `.env` correctement sécurisé et non commité dans le contrôle de version
- Utilisation de variables d'environnement pour les informations sensibles
- Configuration des en-têtes de sécurité (HSTS, Content-Security-Policy)

## Logging et surveillance

- Logging des tentatives d'authentification échouées
- Logging des actions d'administration critiques
- Surveillance des activités suspectes

## Mise à jour et maintenance

- Maintenir Laravel et ses dépendances à jour
- Appliquer rapidement les correctifs de sécurité
- Revue régulière des pratiques de sécurité

## Recommandations pour le déploiement

- Utiliser HTTPS pour toutes les communications
- Configurer les en-têtes de sécurité sur le serveur web
- Restreindre l'accès à la console d'administration par IP lorsque possible
- Mettre en place une stratégie de sauvegarde et de récupération

## Procédures de réponse aux incidents

1. Identification et isolation du problème
2. Évaluation de l'impact et de la portée
3. Mise en œuvre de mesures correctives
4. Documentation et rapport de l'incident
5. Révision des mesures de sécurité pour prévenir des incidents similaires

## Audits de sécurité

- Prévoir des audits de sécurité réguliers
- Effectuer des tests de pénétration périodiques
- Mettre à jour ce document après chaque audit ou changement significatifl