<?php

namespace App\Http\Controllers;

use App\Traits\HttpResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use function Pest\Laravel\get;

class AuthController extends Controller
{
    use HttpResponse;
public function login(Request $request)
{
    if (Auth::attempt($request->only('email', 'password'))) {
        $user = Auth::user();
        $token = $request->user()->createToken('tokenAuth', [
            'placa-index',
            'placa-store',
            'placa-show',
            'auth-logout',
            'placa-destroy'
        ], now()->addHours(16));

        return $this->response('Login Realizado!', 200, [
            'token' => $token->plainTextToken,
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'profile_image' => $user->profile_image,
            ]
        ]);
    }
    return $this->response('Email ou Senha incorretos!', 403);
}
    public function logout(Request $request){
        if(!auth()->user()->tokenCan('auth-logout')){
            return $this->error('Unauthorized', 403);
        }
        $request->user()->currentAccessToken()->delete();
        return $this->response('token revoked', 200);
    }
}
