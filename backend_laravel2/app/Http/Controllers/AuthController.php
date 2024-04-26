<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Hamcrest\Core\HasToString;
use Illuminate\Support\Facades\Auth;

use App\Models\User;

use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\PersonalAccessToken;
use Illuminate\Foundation\Auth\User as Authenticatable;


use Laravel\Passport\Http\Controllers\AccessTokenController;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validatedData = $request->validate([
            'fullName' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
        ]);
        $user = new User;
        $user->name = $validatedData['fullName'];
        $user->email = $validatedData['email'];
        $user->password = Hash::make($validatedData['password']);
        $user->save();

        $token = $user->createToken('TokenName')->plainTextToken;
        return response()->json([
            'message' => 'Inscription réussie',
            'token' => $token,
        ]);


    }


    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            $token = $user->createToken('MyToken')->accessToken;

            return response()->json([
                "tokens" =>  ['user_id' => $user->id, 'token' => $token]
            ], 200);
        }

        $user = \App\Models\User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['error' => 'Cet utilisateur n\'existe pas. Veuillez vous inscrire'], 401);
        }

        return response()->json(['error' => 'Mot de passe incorrect'], 401);
    }

    public function logout(Request $request)
    {
        $apiToken = $request->input('id_user');
        if ($apiToken) {
            // $request->user()->tokens->each(function ($token) use ($apiToken) {
            //     if ($token->token === $apiToken) {
            //         $token->delete();
            //     }
            // });
            DB::table("oauth_access_tokens")->where('user_id', $apiToken)->delete();
            auth()->logout();
            return response('Déconnexion réussie', 200);
        }
        return response(["error" => "Aucun token associé à l\'utilisateur"], 400);
    }


    public function updateProfil(Request $request)
    {
        $user_id = $request->input('user_id');
        if ($user_id) {
            $user = \App\Models\User::where('id', $user_id)->first();
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->photo = $request->input('image');
            $user->save();
            return response(["succes" => 'Modification enregistrée avec succès'], 200);
        }
        return response(["error" => "Aucun token associé à l\'utilisateur"], 400);
    }


    public function recovery(Request $request)
    {
        $code = $request->input('code');
        $code = $request->input('recovery_code');

        $user = User::where('recovery_code', $code)->first();
        if ($user && Carbon::now()->diffInMinutes($user->recovery_code_created_at) <= 10) {
            $user->password = Hash::make($code);
            $user->save();
                $user->update([
                'recovery_code' => null,
                'recovery_code_created_at' => null,
            ]);

            return response()->json(['message' => 'Mot de passe mis à jour avec succès'], 200);
        } else {
            return response()->json(['error' => 'Code de récupération invalide ou expiré'], 400);
        }
    }

    public function verifyRecoveryCode(Request $request)
    {
        $code = $request->input('recovery_code');
        $newPassword = $request->input('new_password');

        // Vérifiez si le code est valide
        $recoveryCode = DB::table('recovery_codes')
            ->where('code', $code)
            ->first();

        if ($recoveryCode && Carbon::now()->diffInMinutes($recoveryCode->created_at) <= 10) {
            // Code de récupération valide et toujours dans la limite de 10 minutes
            // Mettez à jour le mot de passe de l'utilisateur
            $user = User::find($recoveryCode->user_id);
            $user->password = Hash::make($newPassword);
            $user->save();

            // Supprimez le code de récupération car il n'est plus nécessaire
            DB::table('recovery_codes')->where('code', $code)->delete();

            return response()->json(['message' => 'Mot de passe mis à jour avec succès'], 200);
        } else {
            return response()->json(['error' => 'Code de récupération invalide ou expiré'], 400);
        }
    }
}
