<?php

namespace Tests\Unit\Models;

use App\Models\Artist;
use App\Models\Meeting;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use Carbon\Carbon;

class MeetingTest extends TestCase
{
    use RefreshDatabase;

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_has_fillable_attributes()
    {
        $meeting = new Meeting();
        $fillable = $meeting->getFillable();

        $this->assertEquals([
            'artist_id',
            'title',
            'description',
            'date',
            'start_time',
            'end_time',
            'venue',
            'type'
        ], $fillable);
    }

    
    #[\PHPUnit\Framework\Attributes\Test]
    public function it_has_date_cast()
    {
        $meeting = new Meeting();
        $casts = $meeting->getCasts();

        $this->assertArrayHasKey('date', $casts);
        $this->assertEquals('date', $casts['date']);
    }

    
    #[\PHPUnit\Framework\Attributes\Test]
    public function it_belongs_to_artist()
    {
        // Créer un artiste
        $artist = Artist::factory()->create();
        // Créer un meeting associé à cet artiste
        $meeting = Meeting::factory()->create([
            'artist_id' => $artist->id
        ]);

        $this->assertInstanceOf(Artist::class, $meeting->artist);
        $this->assertEquals($artist->id, $meeting->artist->id);
    }

    
    #[\PHPUnit\Framework\Attributes\Test]
    public function meeting_date_is_a_carbon_instance()
    {
        // Créer un artiste pour satisfaire la contrainte de clé étrangère
        $artist = Artist::factory()->create();
        $meeting = Meeting::factory()->create([
            'artist_id' => $artist->id,
            'date' => '2023-12-31'
        ]);
        
        $this->assertInstanceOf(Carbon::class, $meeting->date);
        $this->assertEquals('2023-12-31', $meeting->date->toDateString());
    }
}
