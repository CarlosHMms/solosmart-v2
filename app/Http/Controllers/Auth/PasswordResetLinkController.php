<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Traits\HttpResponse;
use Illuminate\Validation\ValidationException;
use App\Notifications\CustomResetPasswordNotification;
use App\Models\User;

class PasswordResetLinkController extends Controller
{   
    use HttpResponse;
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

        // Gerar o código aleatório de 6 dígitos
        $code = random_int(100000, 999999);

        // Enviar o código para o e-mail do usuário
        $user->notify(new CustomResetPasswordNotification($code));

        // Retornar o código na resposta JSON (apenas para fins de demonstração ou testes)
        return $this->response("Código de redefinição de senha enviado com sucesso.", 200, ['code' => $code]);
    }
}
