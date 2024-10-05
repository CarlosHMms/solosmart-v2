<?php

use App\Http\Controllers\UserController;
use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PlacaController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

//rotas para placas

Route::middleware('auth:sanctum')->group(function (){
    Route::get('/placas/{placa}', [PlacaController::class, 'show'])->middleware('auth:sanctum');
    Route::post('/placas', [PlacaController::class, 'store'])->middleware('auth:sanctum');
    Route::get('/placas', [PlacaController::class, 'index'])->middleware('auth:sanctum');
    Route::post('/logout', [AuthController::class, 'logout']);
});


    Route::get('/usuarios', [UserController::class, 'index']);
    Route::get('/usuarios/{usuario}', [UserController::class, 'show']);
    Route::post('/cadastro', [UserController::class, 'store']);
    Route::post('/login', [AuthController::class, 'login']);
    Route::put('/usuarios/{usuario}', [UserController::class, 'update']);
    Route::delete('/usuarios/{usuario}', [UserController::class, 'destroy']);

