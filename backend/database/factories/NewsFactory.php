<?php
namespace Database\Factories;

use App\Models\News;
use Illuminate\Database\Eloquent\Factories\Factory;

class NewsFactory extends Factory
{
    protected $model = News::class;

    public function definition()
    {
        return [
            'title' => $this->faker->sentence(4),
            'description' => $this->faker->paragraph(),
            'category' => $this->faker->randomElement([
                'Festival', 
                'Artiste', 
                'Concert', 
                'Événement'
            ]),
            'importance' => $this->faker->randomElement([
                News::IMPORTANCE_FAIBLE,
                News::IMPORTANCE_MOYENNE,
                News::IMPORTANCE_HAUTE,
                News::IMPORTANCE_TRES_HAUTE
            ])
        ];
    }
}