<?php

namespace Tests\Feature\Controllers;

use App\Models\AdminUser;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class AuthControllerTest extends TestCase
{
    use RefreshDatabase;

    #[\PHPUnit\Framework\Attributes\Test]
    /**
     * Test : L'administrateur peut se connecter avec des informations d'identification correctes.
     */
    public function admin_can_login_with_correct_credentials()
    {
        $admin = AdminUser::create([
            'name'     => 'Admin Test',
            'email'    => 'admin@test.com',
            'password' => Hash::make('password123'),
        ]);

        $response = $this->postJson('/api/login', [
            'email'    => 'admin@test.com',
            'password' => 'password123',
        ]);

        // Vérifier que la réponse a un statut 200 et que la structure JSON est correcte
        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'token',
                     'admin' => [
                         'id',
                         'name',
                         'email',
                     ],
                 ]);
    }

    
    /**
     * Test : La tentative de connexion échoue avec des informations incorrectes.
     */
    public function login_fails_with_incorrect_credentials()
    {
        $response = $this->postJson('/api/login', [
            'email'    => 'admin@test.com',
            'password' => 'wrong_password',
        ]);

        // Vérifier que le statut de la réponse est 401 (non autorisé)
        $response->assertStatus(401);
    }

    
    /**
     * Test : L'administrateur peut se déconnecter après une connexion réussie.
     */
    public function admin_can_logout()
    {
        $email = 'admin_' . uniqid() . '@test.com';

        // Créer un utilisateur admin dans la base de données
        $admin = AdminUser::create([
            'name'     => 'Admin Test',
            'email'    => $email,
            'password' => Hash::make('password123'),
        ]);

        // Simuler une connexion pour obtenir un token
        $loginResponse = $this->postJson('/api/login', [
            'email'    => $email,
            'password' => 'password123',
        ]);

        // Récupérer le token depuis la réponse JSON
        $token = $loginResponse->json('token');

        // Ajouter le header Authorization avec le token Bearer
        $headers = ['Authorization' => 'Bearer ' . $token];

        // Effectuer la déconnexion
        $logoutResponse = $this->postJson('/api/admin/logout', [], $headers);

        // Vérifier que la réponse de la déconnexion est un succès (200) et contient le message attendu
        $logoutResponse->assertStatus(200)
                       ->assertJson(['message' => 'Déconnexion réussie']);
    }

    
    /**
     * Test : Vérification du token renvoie un statut valide pour un utilisateur authentifié.
     */
    public function verify_token_returns_valid_for_authenticated_user()
    {
        $email = 'admin_' . uniqid() . '@test.com';

        // Créer un utilisateur admin avec l'email unique
        $admin = AdminUser::create([
            'name'     => 'Admin Test',
            'email'    => $email,
            'password' => Hash::make('password123'),
        ]);

        // Simuler la connexion pour obtenir un token
        $loginResponse = $this->postJson('/api/login', [
            'email'    => $email,
            'password' => 'password123',
        ]);

        // Récupérer le token depuis la réponse
        $token = $loginResponse->json('token');

        // Préparer les headers avec le token Bearer
        $headers = ['Authorization' => 'Bearer ' . $token];

        // Vérifier si le token est valide
        $response = $this->getJson('/api/admin/verify-token', $headers);

        // Vérifier que la réponse est 200 et que le token est valide
        $response->assertStatus(200)
                 ->assertJson(['valid' => true]);
    }

    
    /**
     * Test : Vérification du token renvoie un statut invalide pour un utilisateur non authentifié.
     */
    public function verify_token_returns_invalid_for_unauthenticated_user()
    {
        // Sans header Authorization, la requête doit être considérée comme non authentifiée
        $response = $this->getJson('/api/admin/verify-token');

        // Vérifier que la réponse a un statut 401 (non authentifié) et un message d'erreur
        $response->assertStatus(401)
                 ->assertJson([
                     'message' => 'Unauthenticated.',
                 ]);
    }

    
    /**
     * Test : La validation de la connexion exige un email et un mot de passe.
     */
    public function login_validation_requires_email_and_password()
    {
        $response = $this->postJson('/api/login', []);

        // Vérifier que la validation échoue et que les erreurs de validation sont présentes pour l'email et le mot de passe
        $response->assertStatus(422)
                 ->assertJsonValidationErrors(['email', 'password']);
    }

    
    /**
     * Test : La validation de la connexion exige un format d'email valide.
     */
    public function login_validation_requires_valid_email_format()
    {
        $response = $this->postJson('/api/login', [
            'email'    => 'invalid-email',
            'password' => 'password123',
        ]);

        // Vérifier que la validation échoue pour l'email et que l'erreur correspond à un format d'email invalide
        $response->assertStatus(422)
                 ->assertJsonValidationErrors(['email']);
    }
}
