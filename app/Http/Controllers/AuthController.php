<?php

namespace App\Http\Controllers;

use App\Traits\HttpResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    use HttpResponse;
    public function login(Request $request){
        if(Auth::attempt($request->only('email','password'))){
            return $this->response('Authorized', 200,[
                'token' => $request->user()->createToken('tokenAuth', ['placa-index','placa-store','placa-show', 'auth-logout'])
            ]);
        }
        return $this->response('Not Authorized', 403);
    }
    public function logout(Request $request){
        if(!auth()->user()->tokenCan('auth-logout')){
            return $this->error('Unauthorized', 403);
        }
        $request->user()->currentAccessToken()->delete();
        return $this->response('token revoked', 200);
    }
}
