<?php
namespace Tests\Feature\Controllers;

use App\Models\Meeting;
use App\Models\Artist;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class MeetingControllerTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test récupération de la liste des rencontres
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_index_returns_all_meetings()
    {
        // Créer un artiste et des rencontres pour le test
        $artist = Artist::factory()->create();
        $meetings = Meeting::factory()->count(3)->create(['artist_id' => $artist->id]);

        // Test direct du contrôleur
        $controller = app()->make(\App\Http\Controllers\MeetingController::class);
        $response = $controller->index();

        // Vérifier la réponse
        $responseData = json_decode($response->getContent(), true);
        
        // Vérifier que les rencontres créées sont présentes dans la réponse
        // Au lieu de vérifier un nombre exact, vérifions que nos 3 meetings créés sont bien présents
        $foundCount = 0;
        foreach ($responseData as $item) {
            foreach ($meetings as $meeting) {
                if ($item['id'] === $meeting->id) {
                    $foundCount++;
                    break;
                }
            }
        }
        
        $this->assertEquals(3, $foundCount, "Les rencontres créées n'ont pas toutes été trouvées dans la réponse");
        
        // Vérifier la structure JSON
        $this->assertArrayHasKey('id', $responseData[0]);
        $this->assertArrayHasKey('title', $responseData[0]);
        $this->assertArrayHasKey('description', $responseData[0]);
        $this->assertArrayHasKey('date', $responseData[0]);
        $this->assertArrayHasKey('start_time', $responseData[0]);
        $this->assertArrayHasKey('end_time', $responseData[0]);
        $this->assertArrayHasKey('venue', $responseData[0]);
        $this->assertArrayHasKey('type', $responseData[0]);
        $this->assertArrayHasKey('artist', $responseData[0]);
    }

    /**
     * Test création d'une nouvelle rencontre
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_store_creates_new_meeting()
    {
        // Créer un artiste pour le test
        $artist = Artist::factory()->create();

        // Données de la nouvelle rencontre
        $data = [
            'artist_id' => $artist->id,
            'title' => 'Concert Test',
            'description' => 'Description de la rencontre',
            'date' => now()->toDateString(),
            'start_time' => '18:00:00',
            'end_time' => '20:00:00',
            'venue' => 'Salle Test',
            'type' => 'Concert',
        ];

        // Test direct du contrôleur
        $request = \Illuminate\Http\Request::create('/admin/meetings', 'POST', $data);
        $controller = app()->make(\App\Http\Controllers\MeetingController::class);
        $response = $controller->store($request);

        // Vérifier que la rencontre a été créée
        $responseData = json_decode($response->getContent(), true);
        $this->assertEquals(201, $response->getStatusCode());
        $this->assertEquals('Concert Test', $responseData['title']);
        $this->assertEquals($artist->id, $responseData['artist_id']);
        $this->assertEquals('Salle Test', $responseData['venue']);
        
        // Vérifier en base de données
        $this->assertDatabaseHas('meetings', [
            'title' => 'Concert Test',
            'artist_id' => $artist->id,
            'venue' => 'Salle Test'
        ]);
    }

    /**
     * Test affichage d'une rencontre spécifique
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_show_returns_single_meeting()
    {
        // Créer un artiste et une rencontre pour le test
        $artist = Artist::factory()->create();
        $meeting = Meeting::factory()->create(['artist_id' => $artist->id]);

        // Test direct du contrôleur
        $controller = app()->make(\App\Http\Controllers\MeetingController::class);
        $response = $controller->show($meeting);

        // Vérifier la réponse
        $responseData = json_decode($response->getContent(), true);
        $this->assertEquals($meeting->id, $responseData['id']);
        $this->assertEquals($meeting->title, $responseData['title']);
        
        // Vérifier la structure JSON
        $this->assertArrayHasKey('id', $responseData);
        $this->assertArrayHasKey('title', $responseData);
        $this->assertArrayHasKey('description', $responseData);
        $this->assertArrayHasKey('date', $responseData);
        $this->assertArrayHasKey('start_time', $responseData);
        $this->assertArrayHasKey('end_time', $responseData);
        $this->assertArrayHasKey('venue', $responseData);
        $this->assertArrayHasKey('type', $responseData);
        $this->assertArrayHasKey('artist', $responseData);
    }

    /**
     * Test mise à jour d'une rencontre
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_update_updates_meeting()
    {
        // Créer un artiste et une rencontre pour le test
        $artist = Artist::factory()->create();
        $meeting = Meeting::factory()->create(['artist_id' => $artist->id]);

        // Données de mise à jour
        $data = [
            'title' => 'Concert Mis à jour',
            'description' => 'Description mise à jour',
        ];

        // Test direct du contrôleur
        $request = \Illuminate\Http\Request::create("/admin/meetings/{$meeting->id}", 'PUT', $data);
        $controller = app()->make(\App\Http\Controllers\MeetingController::class);
        $response = $controller->update($request, $meeting);

        // Vérifier la réponse
        $responseData = json_decode($response->getContent(), true);
        $this->assertEquals(200, $response->getStatusCode());
        $this->assertEquals('Concert Mis à jour', $responseData['title']);
        $this->assertEquals('Description mise à jour', $responseData['description']);
        
        // Vérifier en base de données
        $this->assertDatabaseHas('meetings', [
            'id' => $meeting->id,
            'title' => 'Concert Mis à jour',
            'description' => 'Description mise à jour'
        ]);
    }

    /**
     * Test suppression d'une rencontre
     */
    #[\PHPUnit\Framework\Attributes\Test]
    public function test_destroy_deletes_meeting()
    {
        // Créer un artiste et une rencontre pour le test
        $artist = Artist::factory()->create();
        $meeting = Meeting::factory()->create(['artist_id' => $artist->id]);

        // Test direct du contrôleur
        $controller = app()->make(\App\Http\Controllers\MeetingController::class);
        $response = $controller->destroy($meeting);

        // Vérifier la réponse
        $this->assertEquals(204, $response->getStatusCode());
        
        // Vérifier que la rencontre a été supprimée
        $this->assertDatabaseMissing('meetings', ['id' => $meeting->id]);
    }
}