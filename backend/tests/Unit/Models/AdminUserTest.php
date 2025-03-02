<?php
namespace Tests\Unit\Models;

use App\Models\AdminUser;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class AdminUserTest extends TestCase
{
    use RefreshDatabase;

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_has_fillable_attributes()
    {
        $admin = new AdminUser();
        $fillable = $admin->getFillable();

        $this->assertEquals([
            'name',
            'email',
            'password',
        ], $fillable);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_has_hidden_attributes()
    {
        $admin = new AdminUser();
        $hidden = $admin->getHidden();

        $this->assertContains('password', $hidden);
        $this->assertContains('remember_token', $hidden);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_create_admin_user()
    {
        $admin = AdminUser::create([
            'name' => 'Admin Test',
            'email' => 'admin@test.com',
            'password' => Hash::make('password123')
        ]);

        $this->assertDatabaseHas('admin_users', [
            'name' => 'Admin Test',
            'email' => 'admin@test.com',
        ]);

        $this->assertTrue(Hash::check('password123', $admin->password));
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_generate_api_token()
    {
        $admin = AdminUser::create([
            'name' => 'Admin Test',
            'email' => 'admin@test.com',
            'password' => Hash::make('password123')
        ]);

        $token = $admin->createToken('admin-token')->plainTextToken;

        $this->assertNotEmpty($token);
        $this->assertDatabaseHas('personal_access_tokens', [
            'tokenable_type' => AdminUser::class,
            'tokenable_id' => $admin->id,
            'name' => 'admin-token'
        ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_enforces_unique_email()
    {
        AdminUser::create([
            'name' => 'Admin One',
            'email' => 'admin@test.com',
            'password' => Hash::make('password123')
        ]);

        $this->expectException(\Illuminate\Database\QueryException::class);

        AdminUser::create([
            'name' => 'Admin Two',
            'email' => 'admin@test.com', // même email
            'password' => Hash::make('different_password')
        ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_update_admin_user()
    {
        $admin = AdminUser::create([
            'name' => 'Original Admin',
            'email' => 'admin@test.com',
            'password' => Hash::make('password123')
        ]);

        $admin->update([
            'name' => 'Updated Admin',
            'email' => 'updated@test.com'
        ]);

        $this->assertDatabaseHas('admin_users', [
            'id' => $admin->id,
            'name' => 'Updated Admin',
            'email' => 'updated@test.com',
        ]);
    }
}
