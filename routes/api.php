<?php

use App\Http\Controllers\UsuariosController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');
Route::get('/usuarios', [UsuariosController::class, 'index']);
Route::get('/usuarios/{usuario}', [UsuariosController::class, 'show']);
Route::post('/usuarios', [UsuariosController::class, 'store']);
Route::put('/usuarios/{usuario}', [UsuariosController::class, 'update']);
Route::delete('/usuarios/{usuario}', [UsuariosController::class, 'destroy']);

