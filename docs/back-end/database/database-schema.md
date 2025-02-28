# Database Schema

## Tables

### admin_users
| Colonne | Type | Attributs |
|---------|------|-----------|
| id | bigint | unsigned, auto_increment, primary key |
| name | varchar(255) | not null |
| email | varchar(255) | not null, unique |
| password | varchar(255) | not null |
| remember_token | varchar(100) | nullable |
| created_at | timestamp | nullable |
| updated_at | timestamp | nullable |

### artists
| Colonne | Type | Attributs |
|---------|------|-----------|
| id | bigint | unsigned, auto_increment, primary key |
| name | varchar(255) | not null |
| description | text | nullable |
| image_url | varchar(255) | nullable |
| genre | varchar(255) | nullable |
| created_at | timestamp | nullable |
| updated_at | timestamp | nullable |

### concerts
| Colonne | Type | Attributs |
|---------|------|-----------|
| id | bigint | unsigned, auto_increment, primary key |
| name | varchar(255) | not null |
| description | text | nullable |
| image_url | varchar(255) | nullable |
| date | date | not null |
| start_time | time | not null |
| end_time | time | not null |
| venue | varchar(255) | not null |
| type | varchar(255) | nullable |
| created_at | timestamp | nullable |
| updated_at | timestamp | nullable |

### concert_artist
| Colonne | Type | Attributs |
|---------|------|-----------|
| concert_id | bigint | unsigned, foreign key (concerts.id), not null |
| artist_id | bigint | unsigned, foreign key (artists.id), not null |
| is_headliner | boolean | default: false |
| performance_order | integer | default: 0 |

*Primary Key: (concert_id, artist_id)*

### meetings
| Colonne | Type | Attributs |
|---------|------|-----------|
| id | bigint | unsigned, auto_increment, primary key |
| artist_id | bigint | unsigned, foreign key (artists.id), not null |
| title | varchar(255) | not null |
| description | text | nullable |
| date | date | not null |
| start_time | time | not null |
| end_time | time | not null |
| venue | varchar(255) | not null |
| type | varchar(255) | nullable |
| created_at | timestamp | nullable |
| updated_at | timestamp | nullable |

### news
| Colonne | Type | Attributs |
|---------|------|-----------|
| id | bigint | unsigned, auto_increment, primary key |
| title | varchar(255) | not null |
| description | text | not null |
| category | varchar(255) | nullable |
| importance | tinyint | default: 0 (0=Faible, 1=Moyenne, 2=Haute) |
| created_at | timestamp | nullable |
| updated_at | timestamp | nullable |

### partners
| Colonne | Type | Attributs |
|---------|------|-----------|
| id | bigint | unsigned, auto_increment, primary key |
| name | varchar(255) | not null |
| description | text | nullable |
| logo_url | varchar(255) | nullable |
| website_url | varchar(255) | nullable |
| category | varchar(255) | nullable |
| created_at | timestamp | nullable |
| updated_at | timestamp | nullable |

### subscribers
| Colonne | Type | Attributs |
|---------|------|-----------|
| id | bigint | unsigned, auto_increment, primary key |
| first_name | varchar(255) | not null |
| last_name | varchar(255) | not null |
| email | varchar(255) | not null, unique |
| created_at | timestamp | nullable |
| updated_at | timestamp | nullable |

## Relations

### One-to-Many
- **artists** → **meetings**: Un artiste peut avoir plusieurs rencontres

### Many-to-Many
- **concerts** ↔ **artists** (via **concert_artist**): Un concert peut avoir plusieurs artistes et un artiste peut participer à plusieurs concerts

## Contraintes

- Clé étrangère `artist_id` dans `meetings` référence `id` dans `artists`
- Clés étrangères `concert_id` et `artist_id` dans `concert_artist` référencent respectivement `id` dans `concerts` et `artists`
- La suppression d'un concert ou d'un artiste entraîne la suppression des entrées correspondantes dans la table `concert_artist` (cascade)