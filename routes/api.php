<?php

use App\Http\Controllers\UserController;
use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');
<<<<<<< HEAD
Route::get('/usuarios', [UserController::class, 'index']);
Route::get('/usuarios/{usuario}', [UserController::class, 'show']);
Route::post('/cadastro', [UserController::class, 'store']);
Route::post('/login', [AuthController::class, 'login']);
Route::put('/usuarios/{usuario}', [UserController::class, 'update']);
Route::delete('/usuarios/{usuario}', [UserController::class, 'destroy']);
=======
Route::get('/usuarios', [UsersController::class, 'index']);
Route::get('/usuarios/{usuario}', [UsersController::class, 'show']);
Route::post('/cadastro', [UsersController::class, 'store']);
Route::post('/login', [UsersController::class, 'login']);
Route::post('/logout', [UsersController::class, 'logout']);
Route::put('/usuarios/{usuario}', [UsersController::class, 'update']);
Route::delete('/usuarios/{usuario}', [UsersController::class, 'destroy']);
>>>>>>> e99b89611b07f98437a057babd36ec6e06b1e262

