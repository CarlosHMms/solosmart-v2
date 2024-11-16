<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\HttpResponse;
use Illuminate\Support\Facades\Validator;
use App\Models\ConfigAlertas;

class ConfigAlertasController extends Controller
{
    use HttpResponse;

    public function store(Request $request)
    {
        // Verifica se o usuário tem permissão para criar uma configuração
        if (!auth()->user()->tokenCan('config-store')) {
            return $this->error('Unauthorized', 403);
        }

        // Validação dos dados recebidos
        $validator = Validator::make($request->all(), [
            'placa_id' => 'required|exists:placas,id',
        ]);

        // Retorna erro se a validação falhar
        if ($validator->fails()) {
            return $this->error('Dados inválidos', 422, $validator->errors());
        }

        // Obter os dados validados
        $validatedData = $validator->validated();

        // Verifica se já existe uma configuração para a placa
        $existingConfig = ConfigAlertas::where('placa_id', $validatedData['placa_id'])->first();

        if ($existingConfig) {
            return $this->error('Já existe uma configuração para esta placa.', 409);
        }

        // Cria a nova configuração
        $configuracao = ConfigAlertas::create([
            'placa_id' => $validatedData['placa_id'],
            'temp_minima' => 20, // Valores padrão
            'umidade_ar_minima' => 20,
            'umidade_solo_minima' => 20,
        ]);

        return $this->response('Configuração de alerta criado.', 200, $configuracao); // Sucesso na criação
    }
}
