<?php

use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class DatabaseConnectionTest extends TestCase
{
    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_connect_to_the_database()
    {
        try {
            DB::connection()->getPdo();
            $this->assertTrue(true);
        } catch (\Exception $e) {
            $this->fail('Could not connect to the database: ' . $e->getMessage());
        }
    }
}
