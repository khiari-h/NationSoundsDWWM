# Documentation des Composants

Cette section documente l'organisation des composants dans le projet, en suivant une approche basée sur Atomic Design. Les composants sont organisés en plusieurs catégories, allant des éléments les plus simples (Atoms) aux structures les plus complexes (Pages et Templates).

## Structure des Composants

Les composants sont divisés en plusieurs niveaux selon leur complexité et leur rôle dans l'application :

### 1. Atoms

Les Atoms sont les éléments les plus fondamentaux de l'interface utilisateur. Ils représentent les blocs de construction de base, tels que les boutons, les images, ou les éléments de texte.

- **Button.jsx** : Un bouton générique, utilisé dans diverses parties de l'application.
- **Filter.jsx** : Un composant de filtre utilisé pour affiner les résultats affichés.
- **Image.jsx** : Un composant d'image générique.
- **Text.jsx** : Un composant de texte de base.

### 2. Molecules

Les Molecules sont des combinaisons de plusieurs Atoms. Elles forment des ensembles plus complexes qui réalisent une fonctionnalité spécifique.

- **Accordion.jsx** : Un composant accordéon permettant de cacher/montrer du contenu.
- **CTASection.jsx** : Une section d'appel à l'action, combinant texte et bouton.
- **InfoCard.jsx** : Une carte d'information combinant texte et image.
- **NavItem.jsx** : Un élément de navigation, utilisé dans les menus.
- **NewsCard.jsx** : Une carte d'actualités affichant un titre, une image, et un résumé.
- **PartnersCard.jsx** : Une carte présentant un partenaire, avec logo et description.
- **RegisterForm.jsx** : Un formulaire d'inscription.

### 3. Organisms

Les Organisms sont des assemblages complexes de Molecules et d'Atoms. Ils constituent des parties autonomes de l'interface utilisateur.

- **ConcertsOverview.jsx** : Une vue d'ensemble des concerts disponibles.
- **Footer.jsx** : Le pied de page de l'application, contenant le logo, la navigation, et d'autres éléments interactifs.
- **Header.jsx** : L'en-tête de l'application, contenant le logo, la navigation, et d'autres éléments interactifs.
- **HeroSection.jsx** : Une section héroïque en haut de la page d'accueil, contenant un texte accrocheur et une image.
- **Map.jsx** : Une carte interactive pour afficher des emplacements géographiques.
- **NewsAndUpdates.jsx** : Une section pour les dernières nouvelles et mises à jour.
- **PracticalInfo.jsx** : Une section pour les informations pratiques relatives aux événements.
- **ProgrammingOverview.jsx** : Une vue d'ensemble de la programmation, combinant plusieurs sous-sections.

**Sous-dossier ProgrammingOrganisms :**
- **ArtistMeeting.jsx** : Un organisme affichant les détails des rencontres avec des artistes.
- **ConcertProgramming.jsx** : Un organisme pour la programmation des concerts.

### 4. Pages

Les Pages sont des vues complètes qui regroupent plusieurs Organisms et Molecules pour former une page complète de l'application.

- **ConcertsDetailsPage.jsx** : Page détaillant un concert spécifique.
- **HomePage.jsx** : La page d'accueil de l'application.
- **NewsPage.jsx** : Page listant toutes les actualités.
- **PartnersPage.jsx** : Page présentant les partenaires de l'application.
- **ProgrammingPage.jsx** : Page détaillant la programmation des événements.

**Sous-dossier Admin :**
- **AdminDashboard.jsx** : Tableau de bord d'administration.
- **ConcertManagement.jsx** : Page de gestion des concerts.
- **MeetingManagement.jsx** : Page de gestion des rencontres.
- **NewsManagement.jsx** : Page de gestion des actualités.

**Sous-dossier Admin/Auth :**
- **AdminLogin.jsx** : Page de connexion à l'interface d'administration.

**Sous-dossier Admin/Components :**
- **AdminSidebar.jsx** : Barre latérale de navigation pour l'interface d'administration.

**Sous-dossier Legal :**
- Contient les pages de mentions légales et conditions d'utilisation.

### 5. Templates

Les Templates définissent la structure de base des Pages. Ils organisent les Organisms et Molecules de manière cohérente pour former des layouts réutilisables.

- **ConcertsDetailsPageTemplate.jsx** : Template pour les pages de détails des concerts.
- **HomePageTemplate.jsx** : Template pour la page d'accueil.
- **NewsPageTemplate.jsx** : Template pour la page des actualités.
- **PartnersPageTemplate.jsx** : Template pour la page des partenaires.
- **ProgrammingPageTemplate.jsx** : Template pour la page de programmation.

## Organisation des fichiers

La structure des fichiers suit l'architecture Atomic Design :

```
frontend/
└── src/
    └── component/
        ├── atoms/
        │   ├── Button.jsx
        │   ├── Filter.jsx
        │   ├── Image.jsx
        │   └── Text.jsx
        │
        ├── molecules/
        │   ├── Accordion.jsx
        │   ├── CTASection.jsx
        │   ├── InfoCard.jsx
        │   ├── NavItem.jsx
        │   ├── NewsCard.jsx
        │   ├── PartnersCard.jsx
        │   └── RegisterForm.jsx
        │
        ├── organisms/
        │   ├── ProgrammingOrganisms/
        │   │   ├── ArtistMeeting.jsx
        │   │   └── ConcertProgramming.jsx
        │   │
        │   ├── ConcertsOverview.jsx
        │   ├── Footer.jsx
        │   ├── Header.jsx
        │   ├── HeroSection.jsx
        │   ├── Map.jsx
        │   ├── NewsAndUpdates.jsx
        │   ├── PracticalInfo.jsx
        │   └── ProgrammingOverview.jsx
        │
        ├── pages/
        │   ├── admin/
        │   │   ├── auth/
        │   │   │   └── AdminLogin.jsx
        │   │   │
        │   │   ├── components/
        │   │   │   └── AdminSidebar.jsx
        │   │   │
        │   │   ├── AdminDashboard.jsx
        │   │   ├── ConcertManagement.jsx
        │   │   ├── MeetingManagement.jsx
        │   │   └── NewsManagement.jsx
        │   │
        │   ├── Legal/
        │   │   └── [pages mentions légales]
        │   │
        │   ├── ConcertsDetailsPage.jsx
        │   ├── HomePage.jsx
        │   ├── NewsPage.jsx
        │   ├── PartnersPage.jsx
        │   └── ProgrammingPage.jsx
        │
        └── templates/
            ├── ConcertsDetailsPageTemplate.jsx
            ├── HomePageTemplate.jsx
            ├── NewsPageTemplate.jsx
            ├── PartnersPageTemplate.jsx
            └── ProgrammingPageTemplate.jsx
```

Cette documentation donne une vue d'ensemble de la structure des composants de l'application. Pour plus de détails sur l'utilisation de chaque composant, vous pouvez consulter les fichiers correspondants dans le répertoire `src/component/`.