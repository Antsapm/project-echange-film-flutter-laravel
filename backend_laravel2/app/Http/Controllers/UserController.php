<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
// use Laravel\Sanctum\PersonalAccessToken;
use App\Models\User;
use Laravel\Passport\Token;

class UserController extends Controller
{
    public function getUserData(Request $request)
    {
        $user = $request->user();

        return response()->json($user);
    }

    public function getUserByToken(Request $request)
    {
        $userId = $request->input('user_id');
        $user = \App\Models\User::where('id', $userId)->first();

        if (!$user) {
            return response()->json(['message' => 'Utilisateur non trouvé'], 404);
        }

        return response()->json(["user" => $user], 200);
    }
}
