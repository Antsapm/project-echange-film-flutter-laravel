<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\FilmController;
use Illuminate\Support\Facades\Auth;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
Route::get('/test', function (){
    $data = [
        "message" => "Roulez en paix."
    ];
    return response()->json($data);
});

// Route::post('/api/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');getInsertionInfo
Route::post('/logout', [AuthController::class, 'logout']);
Route::post('/register',[AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/recovery', [AuthController::class, 'recovery']);
Route::post('/getUserData', [UserController::class, 'getUserByToken']);
Route::post('/update/profil', [AuthController::class, 'updateProfil']);
Route::get('/getInsertionInfo', [FilmController::class, 'recuperation']);


Route::post('/recup/film', [FilmController::class, 'searchFilm_bySomethings']);

Route::post('/uploadFilm', [FilmController::class, 'upload']);

