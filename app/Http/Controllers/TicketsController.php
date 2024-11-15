<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tickets;
use Illuminate\Support\Facades\Validator;
use App\Traits\HttpResponse;
use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Validation\ValidationException;
use App\Http\Controllers\AuthController;
use App\Notifications\CustomTicketEmail;
use App\Models\User;

class TicketsController extends Controller
{
    use HttpResponse;

    public function store(Request $request)
    {
        // Verifica se o usuário tem permissão para criar um ticket
        if (!auth()->user()->tokenCan('ticket-store')) {
            return $this->error('Unauthorized', 403);
        }

        // Validação dos dados da requisição
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|max:255',  // Validação do email
            'status' => 'required|boolean',  // Validação do status
            'assunto' => 'required|string|max:50',  // Validação do assunto
            'descricao' => 'required|string|max:500',  // Validação da descrição
        ]);

        // Retorna erro se a validação falhar
        if ($validator->fails()) {
            return $this->error('Dados inválidos', 422, $validator->errors());
        }

        // Cria o ticket no banco de dados
        $ticket = Tickets::create([
            'status' => $validator->validated()['status'],
            'assunto' => $validator->validated()['assunto'],
            'descricao' => $validator->validated()['descricao'],
            'data_ticket' => now(),
            'user_id' => auth()->id()  // Usuário autenticado cria o ticket
        ]);

        // Verifica se o ticket foi criado
        if ($ticket) {
            // Obtenha o usuário pelo email informado
            $user = User::where('email', $validator->validated()['email'])->first();

            // Verifica se o usuário foi encontrado
            if ($user) {
                // Envia a notificação por email
                $user->notify(new CustomTicketEmail($ticket));

                // Retorna a resposta indicando sucesso
                return $this->response('Ticket aberto e enviado para o email com sucesso.', 200, $ticket);
            } else {
                return $this->error('Usuário não encontrado', 404);
            }
        }

        // Retorna erro se a criação do ticket falhar
        return $this->error('Falha ao abrir o ticket', 500);
    }
}