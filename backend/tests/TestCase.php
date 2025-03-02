<?php

namespace Tests;

use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Illuminate\Support\Facades\DB;

abstract class TestCase extends BaseTestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        
        // Nettoie les tables de test avant chaque test
        $this->cleanupDatabase();
    }

    /**
     * Nettoie la base de données avant chaque test
     */
    protected function cleanupDatabase()
    {
        // Supprimez les données des tables où vous avez des problèmes
        DB::table('admin_users')->delete();
        DB::table('subscribers')->delete();
        // Ajoutez d'autres tables si nécessaire
    }
}