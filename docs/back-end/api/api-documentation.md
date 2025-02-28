# Documentation de l'API

## Aperçu

Cette API permet de gérer un système d'événements musicaux ou culturels, avec des fonctionnalités pour gérer les artistes, les concerts, les rencontres avec les artistes, les partenaires, les actualités et les abonnés.

## Base URL

```
https://api.example.com/api
```

## Authentification

L'API utilise Laravel Sanctum pour l'authentification. Pour les endpoints protégés (admin), vous devez inclure un token Bearer dans les en-têtes de vos requêtes.

```
Authorization: Bearer YOUR_API_TOKEN
```

Pour obtenir un token, utilisez l'endpoint d'authentification.

### Obtenir un token d'authentification

**Endpoint**: `POST /login`

**Corps de la requête**:
```json
{
  "email": "admin@example.com",
  "password": "votre_mot_de_passe"
}
```

**Réponse réussie (200 OK)**:
```json
{
  "token": "YOUR_API_TOKEN",
  "admin": {
    "id": 1,
    "name": "Admin",
    "email": "admin@example.com"
  }
}
```

**Réponse erreur (401 Unauthorized)**:
```json
{
  "message": "Les informations d'identification sont incorrectes."
}
```

### Vérifier la validité du token

**Endpoint**: `GET /admin/verify-token`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Réponse réussie (200 OK)**:
```json
{
  "valid": true
}
```

### Se déconnecter (Supprimer le token)

**Endpoint**: `POST /admin/logout`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Réponse réussie (200 OK)**:
```json
{
  "message": "Déconnexion réussie"
}
```

## Endpoints Publics

### Artistes

#### Obtenir tous les artistes

**Endpoint**: `GET /artists`

**Réponse réussie (200 OK)**:
```json
[
  {
    "id": 1,
    "name": "Artiste 1",
    "description": "Description de l'artiste 1",
    "image_url": "https://example.com/artist1.jpg",
    "genre": "Rock",
    "created_at": "2025-02-26T12:00:00.000000Z",
    "updated_at": "2025-02-26T12:00:00.000000Z"
  },
  {
    "id": 2,
    "name": "Artiste 2",
    "description": "Description de l'artiste 2",
    "image_url": "https://example.com/artist2.jpg",
    "genre": "Pop",
    "created_at": "2025-02-26T12:00:00.000000Z",
    "updated_at": "2025-02-26T12:00:00.000000Z"
  }
]
```

#### Obtenir un artiste spécifique

**Endpoint**: `GET /artists/{artist_id}`

**Réponse réussie (200 OK)**:
```json
{
  "id": 1,
  "name": "Artiste 1",
  "description": "Description de l'artiste 1",
  "image_url": "https://example.com/artist1.jpg",
  "genre": "Rock",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:00:00.000000Z",
  "concerts": [
    {
      "id": 1,
      "name": "Concert 1",
      "description": "Description du concert 1",
      "pivot": {
        "artist_id": 1,
        "concert_id": 1,
        "is_headliner": true,
        "performance_order": 1
      }
    }
  ],
  "meetings": [
    {
      "id": 1,
      "artist_id": 1,
      "title": "Rencontre avec Artiste 1",
      "description": "Description de la rencontre",
      "date": "2025-06-01",
      "start_time": "15:00:00",
      "end_time": "16:00:00",
      "venue": "Hall principal",
      "type": "Dédicace"
    }
  ]
}
```

### Concerts

#### Obtenir tous les concerts

**Endpoint**: `GET /concerts`

**Réponse réussie (200 OK)**:
```json
[
  {
    "id": 1,
    "name": "Concert 1",
    "description": "Description du concert 1",
    "image_url": "https://example.com/concert1.jpg",
    "date": "2025-06-01",
    "start_time": "19:00:00",
    "end_time": "23:00:00",
    "venue": "Salle 1",
    "type": "Rock",
    "created_at": "2025-02-26T12:00:00.000000Z",
    "updated_at": "2025-02-26T12:00:00.000000Z",
    "artists": [
      {
        "id": 1,
        "name": "Artiste 1",
        "pivot": {
          "concert_id": 1,
          "artist_id": 1,
          "is_headliner": true,
          "performance_order": 1
        }
      }
    ]
  }
]
```

#### Obtenir un concert spécifique

**Endpoint**: `GET /concerts/{concert_id}`

**Réponse réussie (200 OK)**:
```json
{
  "id": 1,
  "name": "Concert 1",
  "description": "Description du concert 1",
  "image_url": "https://example.com/concert1.jpg",
  "date": "2025-06-01",
  "start_time": "19:00:00",
  "end_time": "23:00:00",
  "venue": "Salle 1",
  "type": "Rock",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:00:00.000000Z",
  "artists": [
    {
      "id": 1,
      "name": "Artiste 1",
      "description": "Description de l'artiste 1",
      "image_url": "https://example.com/artist1.jpg",
      "genre": "Rock",
      "pivot": {
        "concert_id": 1,
        "artist_id": 1,
        "is_headliner": true,
        "performance_order": 1
      }
    }
  ]
}
```

### Rencontres

#### Obtenir toutes les rencontres

**Endpoint**: `GET /meetings`

**Réponse réussie (200 OK)**:
```json
[
  {
    "id": 1,
    "artist_id": 1,
    "title": "Rencontre avec Artiste 1",
    "description": "Description de la rencontre avec Artiste 1",
    "date": "2025-06-01",
    "start_time": "15:00:00",
    "end_time": "16:00:00",
    "venue": "Hall principal",
    "type": "Dédicace",
    "created_at": "2025-02-26T12:00:00.000000Z",
    "updated_at": "2025-02-26T12:00:00.000000Z",
    "artist": {
      "id": 1,
      "name": "Artiste 1",
      "description": "Description de l'artiste 1",
      "image_url": "https://example.com/artist1.jpg",
      "genre": "Rock"
    }
  }
]
```

#### Obtenir une rencontre spécifique

**Endpoint**: `GET /meetings/{meeting_id}`

**Réponse réussie (200 OK)**:
```json
{
  "id": 1,
  "artist_id": 1,
  "title": "Rencontre avec Artiste 1",
  "description": "Description de la rencontre avec Artiste 1",
  "date": "2025-06-01",
  "start_time": "15:00:00",
  "end_time": "16:00:00",
  "venue": "Hall principal",
  "type": "Dédicace",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:00:00.000000Z",
  "artist": {
    "id": 1,
    "name": "Artiste 1",
    "description": "Description de l'artiste 1",
    "image_url": "https://example.com/artist1.jpg",
    "genre": "Rock"
  }
}
```

### Actualités

#### Obtenir toutes les actualités

**Endpoint**: `GET /news`

**Réponse réussie (200 OK)**:
```json
[
  {
    "id": 1,
    "title": "Ouverture de la billetterie",
    "description": "La billetterie pour l'événement est maintenant ouverte",
    "category": "Billetterie",
    "importance": "Haute",
    "created_at": "2025-02-26T12:00:00.000000Z",
    "updated_at": "2025-02-26T12:00:00.000000Z"
  },
  {
    "id": 2,
    "title": "Nouvel artiste confirmé",
    "description": "Un nouvel artiste vient de confirmer sa présence",
    "category": "Programmation",
    "importance": "Moyenne",
    "created_at": "2025-02-26T12:00:00.000000Z",
    "updated_at": "2025-02-26T12:00:00.000000Z"
  }
]
```

#### Obtenir une actualité spécifique

**Endpoint**: `GET /news/{news_id}`

**Réponse réussie (200 OK)**:
```json
{
  "id": 1,
  "title": "Ouverture de la billetterie",
  "description": "La billetterie pour l'événement est maintenant ouverte",
  "category": "Billetterie",
  "importance": "Haute",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:00:00.000000Z"
}
```

### Partenaires

#### Obtenir tous les partenaires

**Endpoint**: `GET /partners`

**Réponse réussie (200 OK)**:
```json
[
  {
    "id": 1,
    "name": "Partenaire 1",
    "description": "Description du partenaire 1",
    "logo_url": "https://example.com/partner1.jpg",
    "website_url": "https://partner1.com",
    "category": "Principal",
    "created_at": "2025-02-26T12:00:00.000000Z",
    "updated_at": "2025-02-26T12:00:00.000000Z"
  },
  {
    "id": 2,
    "name": "Partenaire 2",
    "description": "Description du partenaire 2",
    "logo_url": "https://example.com/partner2.jpg",
    "website_url": "https://partner2.com",
    "category": "Technique",
    "created_at": "2025-02-26T12:00:00.000000Z",
    "updated_at": "2025-02-26T12:00:00.000000Z"
  }
]
```

#### Obtenir un partenaire spécifique

**Endpoint**: `GET /partners/{partner_id}`

**Réponse réussie (200 OK)**:
```json
{
  "id": 1,
  "name": "Partenaire 1",
  "description": "Description du partenaire 1",
  "logo_url": "https://example.com/partner1.jpg",
  "website_url": "https://partner1.com",
  "category": "Principal",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:00:00.000000Z"
}
```

### Newsletter

#### S'abonner à la newsletter

**Endpoint**: `POST /newsletter/subscribe`

**Corps de la requête**:
```json
{
  "first_name": "John",
  "last_name": "Doe",
  "email": "john.doe@example.com"
}
```

**Réponse réussie (200 OK)**:
```json
{
  "message": "Inscription réussie!"
}
```

**Réponse erreur (422 Unprocessable Entity)**:
```json
{
  "message": "The given data was invalid.",
  "errors": {
    "email": [
      "The email has already been taken."
    ]
  }
}
```

## Endpoints Admin (Protégés)

Ces endpoints nécessitent un token d'authentification valide.

### Gestion des Concerts (Admin)

#### Créer un nouveau concert

**Endpoint**: `POST /admin/concerts`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Corps de la requête**:
```json
{
  "name": "Nouveau Concert",
  "description": "Description du concert",
  "image_url": "https://example.com/concert.jpg",
  "date": "2025-07-15",
  "start_time": "20:00:00",
  "end_time": "23:30:00",
  "venue": "Grande Salle",
  "type": "Festival",
  "artists": [
    {
      "id": 1,
      "is_headliner": true,
      "performance_order": 3
    },
    {
      "id": 2,
      "is_headliner": false,
      "performance_order": 1
    }
  ]
}
```

**Réponse réussie (201 Created)**:
```json
{
  "id": 3,
  "name": "Nouveau Concert",
  "description": "Description du concert",
  "image_url": "https://example.com/concert.jpg",
  "date": "2025-07-15",
  "start_time": "20:00:00",
  "end_time": "23:30:00",
  "venue": "Grande Salle",
  "type": "Festival",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:00:00.000000Z",
  "artists": [
    {
      "id": 1,
      "name": "Artiste 1",
      "pivot": {
        "concert_id": 3,
        "artist_id": 1,
        "is_headliner": true,
        "performance_order": 3
      }
    },
    {
      "id": 2,
      "name": "Artiste 2",
      "pivot": {
        "concert_id": 3,
        "artist_id": 2,
        "is_headliner": false,
        "performance_order": 1
      }
    }
  ]
}
```

#### Mettre à jour un concert

**Endpoint**: `PUT /admin/concerts/{concert_id}`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Corps de la requête**:
```json
{
  "name": "Concert Mis à Jour",
  "venue": "Nouvelle Salle",
  "artists": [
    {
      "id": 3,
      "is_headliner": true,
      "performance_order": 1
    }
  ]
}
```

**Réponse réussie (200 OK)**:
```json
{
  "id": 1,
  "name": "Concert Mis à Jour",
  "description": "Description du concert 1",
  "image_url": "https://example.com/concert1.jpg",
  "date": "2025-06-01",
  "start_time": "19:00:00",
  "end_time": "23:00:00",
  "venue": "Nouvelle Salle",
  "type": "Rock",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:30:00.000000Z",
  "artists": [
    {
      "id": 3,
      "name": "Artiste 3",
      "pivot": {
        "concert_id": 1,
        "artist_id": 3,
        "is_headliner": true,
        "performance_order": 1
      }
    }
  ]
}
```

#### Supprimer un concert

**Endpoint**: `DELETE /admin/concerts/{concert_id}`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Réponse réussie (204 No Content)**

### Gestion des Rencontres (Admin)

#### Créer une nouvelle rencontre

**Endpoint**: `POST /admin/meetings`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Corps de la requête**:
```json
{
  "artist_id": 2,
  "title": "Nouvelle Rencontre",
  "description": "Description de la rencontre",
  "date": "2025-07-16",
  "start_time": "14:00:00",
  "end_time": "15:30:00",
  "venue": "Espace Rencontre",
  "type": "Masterclass"
}
```

**Réponse réussie (201 Created)**:
```json
{
  "id": 3,
  "artist_id": 2,
  "title": "Nouvelle Rencontre",
  "description": "Description de la rencontre",
  "date": "2025-07-16",
  "start_time": "14:00:00",
  "end_time": "15:30:00",
  "venue": "Espace Rencontre",
  "type": "Masterclass",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:00:00.000000Z",
  "artist": {
    "id": 2,
    "name": "Artiste 2",
    "description": "Description de l'artiste 2",
    "image_url": "https://example.com/artist2.jpg",
    "genre": "Pop"
  }
}
```

#### Mettre à jour une rencontre

**Endpoint**: `PUT /admin/meetings/{meeting_id}`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Corps de la requête**:
```json
{
  "title": "Rencontre Mise à Jour",
  "venue": "Nouvel Espace",
  "type": "Questions/Réponses"
}
```

**Réponse réussie (200 OK)**:
```json
{
  "id": 1,
  "artist_id": 1,
  "title": "Rencontre Mise à Jour",
  "description": "Description de la rencontre avec Artiste 1",
  "date": "2025-06-01",
  "start_time": "15:00:00",
  "end_time": "16:00:00",
  "venue": "Nouvel Espace",
  "type": "Questions/Réponses",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:30:00.000000Z",
  "artist": {
    "id": 1,
    "name": "Artiste 1",
    "description": "Description de l'artiste 1",
    "image_url": "https://example.com/artist1.jpg",
    "genre": "Rock"
  }
}
```

#### Supprimer une rencontre

**Endpoint**: `DELETE /admin/meetings/{meeting_id}`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Réponse réussie (204 No Content)**

### Gestion des Actualités (Admin)

#### Créer une nouvelle actualité

**Endpoint**: `POST /admin/news`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Corps de la requête**:
```json
{
  "title": "Nouvelle Actualité",
  "description": "Description de la nouvelle actualité",
  "category": "Événement",
  "importance": "Moyenne"
}
```

**Réponse réussie (201 Created)**:
```json
{
  "id": 4,
  "title": "Nouvelle Actualité",
  "description": "Description de la nouvelle actualité",
  "category": "Événement",
  "importance": "Moyenne",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:00:00.000000Z"
}
```

#### Mettre à jour une actualité

**Endpoint**: `PUT /admin/news/{news_id}`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Corps de la requête**:
```json
{
  "title": "Actualité Mise à Jour",
  "importance": "Haute"
}
```

**Réponse réussie (200 OK)**:
```json
{
  "id": 1,
  "title": "Actualité Mise à Jour",
  "description": "La billetterie pour l'événement est maintenant ouverte",
  "category": "Billetterie",
  "importance": "Haute",
  "created_at": "2025-02-26T12:00:00.000000Z",
  "updated_at": "2025-02-26T12:30:00.000000Z"
}
```

#### Supprimer une actualité

**Endpoint**: `DELETE /admin/news/{news_id}`

**Headers**:
```
Authorization: Bearer YOUR_API_TOKEN
```

**Réponse réussie (204 No Content)**

## Codes d'état

- **200 OK** - La requête a réussi
- **201 Created** - La ressource a été créée avec succès
- **204 No Content** - La requête a réussi mais il n'y a pas de contenu à renvoyer
- **400 Bad Request** - La requête est mal formée
- **401 Unauthorized** - Authentification requise
- **403 Forbidden** - Accès refusé
- **404 Not Found** - Ressource non trouvée
- **422 Unprocessable Entity** - Validation échouée
- **500 Internal Server Error** - Erreur serveur

## Erreurs de validation

Pour toutes les requêtes POST et PUT, si la validation échoue, la réponse sera au format :

```json
{
  "errors": {
    "field_name": [
      "Message d'erreur pour ce champ"
    ],
    "another_field": [
      "Message d'erreur pour l'autre champ"
    ]
  }
}
```

## Règles de validation

### Artistes
- `name`: Requis, chaîne de caractères, maximum 255 caractères
- `description`: Requis, chaîne de caractères
- `image_url`: Optionnel, chaîne de caractères
- `genre`: Optionnel, chaîne de caractères, maximum 100 caractères

### Concerts
- `name`: Requis, chaîne de caractères, maximum 255 caractères
- `description`: Requis, chaîne de caractères
- `image_url`: Optionnel, chaîne de caractères
- `date`: Requis, format date (YYYY-MM-DD)
- `start_time`: Requis, format heure (HH:MM:SS)
- `end_time`: Requis, format heure (HH:MM:SS)
- `venue`: Requis, chaîne de caractères, maximum 255 caractères
- `type`: Optionnel, chaîne de caractères, maximum 100 caractères
- `artists`: Optionnel, tableau d'artistes avec leurs informations

### Rencontres
- `artist_id`: Requis, ID existant dans la table artists
- `title`: Requis, chaîne de caractères, maximum 255 caractères
- `description`: Requis, chaîne de caractères
- `date`: Requis, format date (YYYY-MM-DD)
- `start_time`: Requis, format heure (HH:MM:SS)
- `end_time`: Requis, format heure (HH:MM:SS)
- `venue`: Requis, chaîne de caractères, maximum 255 caractères
- `type`: Requis, chaîne de caractères, maximum 100 caractères

### Actualités
- `title`: Requis, chaîne de caractères, maximum 255 caractères
- `description`: Requis, chaîne de caractères
- `category`: Requis, chaîne de caractères, maximum 100 caractères
- `importance`: Requis, une des valeurs suivantes : "Faible", "Moyenne", "Haute"

### Partenaires
- `name`: Requis, chaîne de caractères, maximum 255 caractères
- `description`: Requis, chaîne de caractères
- `logo_url`: Optionnel, chaîne de caractères
- `website_url`: Optionnel, URL valide
- `category`: Optionnel, chaîne de caractères, maximum 100 caractères

### Abonnement Newsletter
- `first_name`: Requis, chaîne de caractères, maximum 255 caractères
- `last_name`: Requis, chaîne de caractères, maximum 255 caractères
- `email`: Requis, email valide, unique dans la table subscribers