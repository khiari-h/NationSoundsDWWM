<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    use HasFactory;

    // Constantes pour les niveaux d'importance
    const IMPORTANCE_FAIBLE = 0;
    const IMPORTANCE_MOYENNE = 1;
    const IMPORTANCE_HAUTE = 2;
    const IMPORTANCE_TRES_HAUTE = 3;

    protected $fillable = [
        'title',
        'description',
        'category',
        'importance'
    ];

    // Méthode pour obtenir le libellé de l'importance
    public function getImportanceLabelAttribute()
    {
        return match($this->importance) {
            self::IMPORTANCE_FAIBLE => 'Faible',
            self::IMPORTANCE_MOYENNE => 'Moyenne',
            self::IMPORTANCE_HAUTE => 'Haute',
            self::IMPORTANCE_TRES_HAUTE => 'Très Haute',
            default => 'Faible'
        };
    }

    // Assure que l'importance est toujours un entier
    protected $casts = [
        'importance' => 'integer'
    ];

   
    protected $appends = ['importance_label'];
}