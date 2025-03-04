<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        $this->call([
            AdminUserSeeder::class,
            ArtistSeeder::class,
            ConcertSeeder::class,
            MeetingSeeder::class,
            NewsTableSeeder::class,
            PartnerSeeder::class,
            SubscribersTableSeeder::class,
        ]);
    }
}