<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Password;
use Illuminate\Validation\ValidationException;
use App\Notifications\CustomResetPasswordNotification;
use App\Models\User;

class PasswordResetLinkController extends Controller
{
    public function store(Request $request): JsonResponse
    {
    $request->validate([
        'email' => ['required', 'email'],
    ]);

    $user = User::where('email', $request->email)->first();

    if (!$user) {
        throw ValidationException::withMessages([
            'email' => ['Este endereço de e-mail não foi encontrado.'],
        ]);
    }

    $token = Password::createToken($user);
    
    $user->notify(new CustomResetPasswordNotification($token));

    return response()->json(['status' => 'Link de redefinição de senha enviado com sucesso.']);
    }
}
