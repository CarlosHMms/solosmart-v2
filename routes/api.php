<?php

use App\Http\Controllers\UsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');
Route::get('/usuarios', [UsersController::class, 'index']);
Route::get('/usuarios/{usuario}', [UsersController::class, 'show']);
Route::post('/cadastro', [UsersController::class, 'store']);
Route::post('/login', [UsersController::class, 'login']);
Route::put('/usuarios/{usuario}', [UsersController::class, 'update']);
Route::delete('/usuarios/{usuario}', [UsersController::class, 'destroy']);

