<?php

namespace Tests\Feature\Controllers;

use App\Models\Artist;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ArtistControllerTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function index_returns_all_artists()
    {
        // Vider la table pour garantir un état propre
        Artist::query()->delete();
        
        // Création de 3 artistes en base de données
        Artist::factory()->count(3)->create();
    
        // Appel de la route publique /api/artists
        $response = $this->getJson('/api/artists');
    
        $response->assertStatus(200)
                 ->assertJsonCount(3)
                 ->assertJsonStructure([
                     '*' => ['id', 'name', 'description', 'image_url', 'genre']
                 ]);
    }
    

    /** @test */
    public function show_returns_single_artist_with_relations()
    {
        // Création d'un artiste
        $artist = Artist::factory()->create();

        // Appel de la route publique /api/artists/{artist}
        $response = $this->getJson("/api/artists/{$artist->id}");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'id', 
                     'name', 
                     'description', 
                     'image_url', 
                     'genre',
                     'concerts',  // Relations chargées
                     'meetings'   // Relations chargées
                 ]);
    }
}
