<?php

use App\Http\Controllers\UserController;
use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PlacaController;
use App\Http\Controllers\Auth\PasswordResetLinkController;
use App\Http\Controllers\SensorDataController;
use App\Http\Controllers\ImageController;
use App\Http\Controllers\TicketsController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

//rotas para placas

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/placas/{placa}', [PlacaController::class, 'show']);
    Route::post('/placas', [PlacaController::class, 'store']);
    Route::get('/placas', [PlacaController::class, 'index']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/gerar', [SensorDataController::class, 'generateData']);
    Route::get('/placa/{placa_id}', [SensorDataController::class, 'getPlacaData']);
    Route::get('/profile', [UserController::class, 'getProfile']);
    Route::post('/profileupd', [UserController::class, 'updateProfileImage']);
    Route::get('/imagem/{filename}', [ImageController::class, 'getImage']);
    Route::put('/usuarios/perfil/{usuario}', [UserController::class, 'edit']);
    Route::get('/buscar/{placa_id}', [SensorDataController::class, 'getLastPlacaData']);
    Route::delete('/placas/delete/{placaId}', [PlacaController::class, 'destroy']);
    Route::post('/ticket', [TicketsController::class, 'store']);
});

Route::get('/usuarios', [UserController::class, 'index']);
Route::get('/usuarios/{usuario}', [UserController::class, 'show']);
Route::post('/cadastro', [UserController::class, 'store']);
Route::post('/login', [AuthController::class, 'login']);
Route::put('/usuarios/{usuario}', [UserController::class, 'update']);
Route::delete('/usuarios/{usuario}', [UserController::class, 'destroy']);
Route::post('/recover', [PasswordResetLinkController::class, 'store']);
