<?php
namespace App\Http\Controllers;

use App\Models\Artist;
use Illuminate\Http\Request;

class ArtistController extends Controller
{
    /**
     * Afficher une liste des artistes
     */
    public function index()
    {
        $artists = Artist::all();
        return response()->json($artists);
    }

    /**
     * Afficher un artiste spécifique avec ses relations
     */
    public function show(Artist $artist)
    {
        $artist->load(['concerts', 'meetings']);
        return response()->json($artist);
    }
}
