<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
// use Tymon\JWTAuth\JWTAuth;

use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validatedData = $request->validate([
            'fullName' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
        ]);

        // Créez un nouvel utilisateur
        $user = new User;
        $user->name = $validatedData['fullName'];
        $user->email = $validatedData['email'];
        $user->password = Hash::make($validatedData['password']);
        $user->save();

        // Générez le jeton JWT pour l'utilisateur
        // $token = JWTAuth::fromUser($user);

        // Retournez le jeton JWT dans la réponse
        return response()->json(['message' => 'Inscription réussie']);
    }

}
