<?php

namespace Tests\Feature\Controllers;

use App\Models\Concert;
use App\Models\Artist;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class ConcertControllerTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test récupération de la liste des concerts (route publique)
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_index()
    {
        // Créer un concert de test dans la base de données
        $concert = Concert::factory()->create([
            'name' => 'Test Concert',
            'description' => 'Test Description',
            'venue' => 'Test Venue'
        ]);
    
        // Test direct du contrôleur
        $controller = app()->make(\App\Http\Controllers\ConcertController::class);
        $response = $controller->index();
    
        // Vérifier la réponse
        $responseData = json_decode($response->getContent(), true);
        
        // Vérifier qu'il y a au moins un élément dans la réponse
        $this->assertNotEmpty($responseData);
        
        // Vérifier que le concert créé est présent dans la réponse
        $found = false;
        foreach ($responseData as $item) {
            if ($item['id'] === $concert->id) {
                $found = true;
                $this->assertEquals('Test Concert', $item['name']);
                $this->assertEquals('Test Venue', $item['venue']);
                break;
            }
        }
        
        $this->assertTrue($found, "Le concert créé n'a pas été trouvé dans la réponse");
    }

    /**
     * Test création d'un nouveau concert
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_store()
    {
        // Créer un artiste pour le test
        $artist = Artist::factory()->create();

        // Données du nouveau concert
        $data = [
            'name' => 'Concert Test',
            'description' => 'Description du concert',
            'date' => now()->format('Y-m-d'),
            'start_time' => now()->format('H:i:s'),
            'end_time' => now()->addHours(2)->format('H:i:s'),
            'venue' => 'Salle Test',
            'type' => 'Type Test',
            'artists' => [
                [
                    'id' => $artist->id,
                    'is_headliner' => true,
                    'performance_order' => 1,
                ],
            ]
        ];

        // Test direct du contrôleur au lieu de la route
        $request = \Illuminate\Http\Request::create('/admin/concerts', 'POST', $data);
        $controller = app()->make(\App\Http\Controllers\ConcertController::class);
        $response = $controller->store($request);

        // Vérifier que le concert a été créé
        $responseData = json_decode($response->getContent(), true);
        $this->assertEquals(201, $response->getStatusCode());
        $this->assertEquals('Concert Test', $responseData['name']);
        $this->assertEquals('Salle Test', $responseData['venue']);
    }

    /**
     * Test affichage d'un concert spécifique
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_show()
    {
        // Créer un concert de test
        $concert = Concert::factory()->create();

        // Test direct du contrôleur au lieu de la route
        $controller = app()->make(\App\Http\Controllers\ConcertController::class);
        $response = $controller->show($concert);

        // Vérifier que la réponse est correcte
        $responseData = json_decode($response->getContent(), true);
        $this->assertEquals($concert->id, $responseData['id']);
        $this->assertEquals($concert->name, $responseData['name']);
    }

    /**
     * Test mise à jour d'un concert existant
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_update()
    {
        // Créer un concert et un artiste pour le test
        $concert = Concert::factory()->create();
        $artist = Artist::factory()->create();

        // Données de mise à jour
        $data = [
            'name' => 'Concert Mis à Jour',
            'description' => 'Nouvelle description',
            'date' => now()->format('Y-m-d'),
            'start_time' => now()->format('H:i:s'),
            'end_time' => now()->addHours(2)->format('H:i:s'),
            'venue' => 'Salle Mise à Jour',
            'type' => 'Type Mis à Jour',
            'artists' => [
                [
                    'id' => $artist->id,
                    'is_headliner' => false,
                    'performance_order' => 2,
                ],
            ]
        ];

        // Test direct du contrôleur au lieu de la route
        $request = \Illuminate\Http\Request::create("/admin/concerts/{$concert->id}", 'PUT', $data);
        $controller = app()->make(\App\Http\Controllers\ConcertController::class);
        $response = $controller->update($request, $concert);

        // Vérifier que le concert a été mis à jour
        $responseData = json_decode($response->getContent(), true);
        $this->assertEquals(200, $response->getStatusCode());
        $this->assertEquals('Concert Mis à Jour', $responseData['name']);
        $this->assertEquals('Salle Mise à Jour', $responseData['venue']);
    }

    /**
     * Test suppression d'un concert
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_destroy()
    {
        // Créer un concert de test
        $concert = Concert::factory()->create();

        // Test direct du contrôleur au lieu de la route
        $controller = app()->make(\App\Http\Controllers\ConcertController::class);
        $response = $controller->destroy($concert);

        // Vérifier que le concert a été supprimé
        $this->assertEquals(204, $response->getStatusCode());
        $this->assertModelMissing($concert);
    }
}