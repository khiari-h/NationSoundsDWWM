<?php
namespace Tests\Unit\Models;

use App\Models\News;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class NewsTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function it_has_fillable_attributes()
    {
        $news = new News();
        $fillable = $news->getFillable();

        $this->assertEquals([
            'title',
            'description',
            'category',
            'importance',
        ], $fillable);
    }

    /** @test */
    public function it_can_create_news()
    {
        // Créer une actualité avec l'importance comme valeur numérique
        $news = News::create([
            'title' => 'Test News',
            'description' => 'This is a test news',
            'category' => 'Event',
            'importance' => News::IMPORTANCE_HAUTE // ou simplement 2
        ]);

        // Vérifier que l'actualité a été créée avec la bonne importance
        $this->assertDatabaseHas('news', [
            'title' => 'Test News',
            'description' => 'This is a test news',
            'category' => 'Event',
            'importance' => 2
        ]);

        // Vérifier le libellé de l'importance
        $this->assertEquals('Haute', $news->importance_label);
    }

    /** @test */
    public function it_can_update_news()
    {
        // Créer une actualité
        $news = News::create([
            'title' => 'Original Title',
            'description' => 'Original Description',
            'category' => 'Event',
            'importance' => News::IMPORTANCE_MOYENNE // ou 1
        ]);

        // Mettre à jour l'actualité
        $news->update([
            'title' => 'Updated Title',
            'description' => 'Updated Description',
            'importance' => News::IMPORTANCE_HAUTE // ou 2
        ]);

        // Vérifier que l'actualité a été mise à jour
        $this->assertDatabaseHas('news', [
            'id' => $news->id,
            'title' => 'Updated Title',
            'description' => 'Updated Description',
            'category' => 'Event',
            'importance' => 2
        ]);

        // Vérifier le nouveau libellé de l'importance
        $this->assertEquals('Haute', $news->importance_label);
    }

    /** @test */
    public function it_can_delete_news()
    {
        // Créer une actualité
        $news = News::create([
            'title' => 'News to Delete',
            'description' => 'This news will be deleted',
            'category' => 'Event',
            'importance' => News::IMPORTANCE_FAIBLE // ou 0
        ]);

        // Récupérer l'ID pour vérification ultérieure
        $newsId = $news->id;

        // Supprimer l'actualité
        $news->delete();

        // Vérifier que l'actualité a été supprimée
        $this->assertDatabaseMissing('news', [
            'id' => $newsId
        ]);
    }
}