<?php
namespace Tests\Feature\Controllers;

use App\Models\News;
use App\Models\AdminUser;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class NewsControllerTest extends TestCase
{
    use RefreshDatabase;

    #[\PHPUnit\Framework\Attributes\Test]

public function index_returns_all_news()
{
    // Supprimez toutes les news existantes avant de créer les nouvelles
    News::query()->delete();

    // Créer exactement 3 news
    News::factory()->count(3)->create();

    $response = $this->getJson('/api/news');

    $response->assertStatus(200)
             ->assertJsonCount(3)
             ->assertJsonStructure([
                 '*' => [
                     'id', 'title', 'description', 
                     'category', 'importance'
                 ]
             ]);
}

     #[\PHPUnit\Framework\Attributes\Test]
    public function show_returns_single_news()
    {
        $news = News::factory()->create([
            'title' => 'Festival Details',
            'description' => 'Exciting music festival upcoming',
            'category' => 'Festival',
            'importance' => News::IMPORTANCE_HAUTE
        ]);

        $response = $this->getJson("/api/news/{$news->id}");

        $response->assertStatus(200)
                 ->assertJson([
                     'id' => $news->id,
                     'title' => 'Festival Details',
                     'description' => 'Exciting music festival upcoming',
                     'category' => 'Festival',
                     'importance' => 2
                 ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function show_returns_404_for_non_existent_news()
    {
        $response = $this->getJson('/api/news/9999');

        $response->assertStatus(404);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function admin_can_create_news()
    {
        $admin = AdminUser::factory()->create();
        Sanctum::actingAs($admin);

        $newsData = [
            'title' => 'New Festival Announcement',
            'description' => 'Major music event coming soon',
            'category' => 'Festival',
            'importance' => News::IMPORTANCE_TRES_HAUTE
        ];

        $response = $this->postJson('/api/admin/news', $newsData);

        $response->assertStatus(201)
                 ->assertJson([
                     'title' => 'New Festival Announcement',
                     'category' => 'Festival',
                     'importance' => 3
                 ]);

        $this->assertDatabaseHas('news', [
            'title' => 'New Festival Announcement',
            'category' => 'Festival'
        ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function admin_cannot_create_news_with_invalid_data()
    {
        $admin = AdminUser::factory()->create();
        Sanctum::actingAs($admin);

        $invalidNewsData = [
            'title' => '', // Empty title
            'description' => 'Some description',
            'category' => 'Festival',
            'importance' => 99 // Invalid importance
        ];

        $response = $this->postJson('/api/admin/news', $invalidNewsData);

        $response->assertStatus(422)
                 ->assertJsonValidationErrors(['title', 'importance']);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function non_admin_cannot_create_news()
    {
        $newsData = [
            'title' => 'Unauthorized News',
            'description' => 'Should not be created',
            'category' => 'Festival',
            'importance' => News::IMPORTANCE_MOYENNE
        ];

        $response = $this->postJson('/api/admin/news', $newsData);

        $response->assertStatus(401); // Unauthorized
    }
}