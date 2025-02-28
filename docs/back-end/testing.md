# Testing

## Introduction

Ce document décrit la stratégie de test pour l'application, les outils utilisés et les bonnes pratiques à suivre. Une couverture de test adéquate est essentielle pour assurer la qualité, la fiabilité et la maintenabilité de l'application.

## Types de tests

### Tests Unitaires

Les tests unitaires vérifient le bon fonctionnement des composants individuels (classes, méthodes, fonctions) de manière isolée.

**Cibles principales:**
- Modèles
- Services
- Helpers
- Validateurs

### Tests d'Intégration

Les tests d'intégration vérifient les interactions entre différents composants du système.

**Cibles principales:**
- Contrôleurs
- Interactions avec la base de données
- Middleware

### Tests Fonctionnels

Les tests fonctionnels vérifient que le système fonctionne selon les spécifications et exigences.

**Cibles principales:**
- Endpoints API
- Flux d'authentification
- Workflows CRUD complets

### Tests de Sécurité

Les tests de sécurité vérifient que l'application est protégée contre les vulnérabilités courantes.

**Cibles principales:**
- Authentification et autorisation
- Protection contre les injections
- Gestion des sessions et tokens

## Organisation des tests

### Structure des dossiers de test

```
tests/
├── Feature/                  # Tests fonctionnels et d'intégration
│   ├── Api/                  # Tests des endpoints API
│   │   ├── ArtistTest.php
│   │   ├── ConcertTest.php
│   │   └── ...
│   ├── Auth/                 # Tests d'authentification
│   │   └── LoginTest.php
│   └── ...
├── Unit/                     # Tests unitaires
│   ├── Models/               # Tests des modèles
│   │   ├── ArtistTest.php
│   │   ├── ConcertTest.php
│   │   └── ...
│   ├── Services/             # Tests des services
│   └── ...
└── TestCase.php              # Classe de base pour les tests
```

### Conventions de nommage

- Les classes de test doivent se terminer par `Test` (ex: `ArtistTest`)
- Les méthodes de test doivent commencer par `test_` ou utiliser l'annotation `@test`
- Les noms de méthodes doivent décrire clairement ce qui est testé et le résultat attendu
  - Ex: `test_can_create_artist_with_valid_data()`
  - Ex: `test_cannot_create_artist_without_name()`

## Outils et frameworks

### PHPUnit

PHPUnit est utilisé comme framework de test principal pour le backend Laravel.

**Configuration:**
- Fichier de configuration: `phpunit.xml`
- Database seeding avant les tests
- Environnement de test dédié

### Laravel Testing

Utilisation des fonctionnalités de test intégrées à Laravel:

- `RefreshDatabase` pour réinitialiser la base de données entre les tests
- Assertions HTTP pour vérifier les réponses API
- Helpers pour l'authentification et les requêtes

### Mocking

- Utilisation de Mockery pour créer des mocks
- PHPUnit pour les doubles de test
- Mocks pour les services externes et les connexions à la base de données lorsque nécessaire

## Bonnes pratiques

### Rédaction des tests

- **Principe AAA** (Arrange, Act, Assert):
  - Arrange: Préparer les données et l'état initial
  - Act: Exécuter l'action à tester
  - Assert: Vérifier les résultats

- **Tests autonomes**: Chaque test doit être indépendant et ne pas dépendre d'autres tests
- **Tests déterministes**: Les tests doivent toujours produire le même résultat pour les mêmes conditions
- **Tests lisibles**: Le code de test doit être clair et compréhensible

### Fixtures et Factory

- Utilisation des factories Laravel pour générer des données de test
- Création de fixtures réutilisables pour les scénarios communs
- Utilisation de données aléatoires pour les tests de robustesse

### Couverture de code

- Objectif: couverture de code minimale de 80% pour les composants critiques
- Attention particulière aux cas limites et aux chemins d'exécution alternatifs
- Génération de rapports de couverture pour identifier les zones non testées

## Exemples de tests

### Exemple de test unitaire (Modèle)

```php
use Tests\TestCase;
use App\Models\Artist;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ArtistTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_get_concerts_for_artist()
    {
        // Arrange
        $artist = Artist::factory()->create();
        $concerts = Concert::factory()->count(3)->create();
        
        $artist->concerts()->attach($concerts->pluck('id'), [
            'is_headliner' => true,
            'performance_order' => 1
        ]);

        // Act
        $artistConcerts = $artist->concerts;

        // Assert
        $this->assertCount(3, $artistConcerts);
        $this->assertTrue($artistConcerts->first()->pivot->is_headliner);
    }
}
```

### Exemple de test d'intégration (API)

```php
use Tests\TestCase;
use App\Models\AdminUser;
use Laravel\Sanctum\Sanctum;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ConcertApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_get_all_concerts()
    {
        // Arrange
        $concerts = Concert::factory()->count(3)->create();

        // Act
        $response = $this->getJson('/api/concerts');

        // Assert
        $response->assertStatus(200)
                 ->assertJsonCount(3);
    }

    public function test_admin_can_create_concert()
    {
        // Arrange
        Sanctum::actingAs(
            AdminUser::factory()->create(),
            ['*']
        );

        $concertData = [
            'name' => 'Test Concert',
            'description' => 'Test Description',
            'date' => '2025-06-15',
            'start_time' => '19:00:00',
            'end_time' => '23:00:00',
            'venue' => 'Test Venue',
            'type' => 'Rock'
        ];

        // Act
        $response = $this->postJson('/api/admin/concerts', $concertData);

        // Assert
        $response->assertStatus(201)
                 ->assertJsonFragment(['name' => 'Test Concert']);
                 
        $this->assertDatabaseHas('concerts', ['name' => 'Test Concert']);
    }
}
```

## Exécution des tests

### Commandes principales

- Exécuter tous les tests:
  ```
  php artisan test
  ```

- Exécuter un fichier de test spécifique:
  ```
  php artisan test --filter=ConcertApiTest
  ```

- Exécuter une méthode de test spécifique:
  ```
  php artisan test --filter=ConcertApiTest::test_admin_can_create_concert
  ```

### Environnement de test

- Base de données de test séparée (définie dans `.env.testing`)
- Configuration spécifique pour les tests (cache, files, etc.)
- Utilisation de SQLite en mémoire pour des tests plus rapides si possible

## Intégration continue (CI)

- Exécution automatique des tests à chaque commit/pull request
- Génération de rapports de couverture
- Échec du pipeline en cas d'échec des tests

## Stratégies de test spécifiques

### Tests de la base de données

- Vérification des migrations et des rollbacks
- Validation des contraintes et des relations
- Tests des requêtes complexes

### Tests des contrôleurs

- Validation des entrées et des sorties
- Gestion des erreurs et exceptions
- Vérification des autorisations

### Tests de sécurité

- Vérification de l'authentification
- Tests de validation des entrées
- Tests de protection contre les attaques courantes (CSRF, XSS)

## Maintenance et amélioration continue

- Revue régulière des tests existants
- Amélioration de la couverture des tests
- Mise à jour des tests en fonction des modifications du code
- Documentation des tests pour faciliter la maintenance