<?php

namespace App\Http\Controllers;

use App\Jobs\GenerateSensorDataJob;
use App\Traits\HttpResponse;
use Illuminate\Http\Request;
use App\Models\Gravacoes;
use App\Models\Placas;
use Illuminate\Support\Facades\Bus;
use Illuminate\Support\Facades\Validator;

class SensorDataController extends Controller
{
    use HttpResponse;

   public function startGeneratingData(Request $request)
{
    // Verifica se o usuário tem permissão para armazenar placas
    if (!auth()->user()->tokenCan('placa-store')) {
        return $this->error('Unauthorized', 403);
    }

    // Validação dos dados da requisição
    $validator = Validator::make($request->all(), [
        'placa_id' => 'required|exists:placas,id',
    ]);

    // Verifica se a validação falhou
    if ($validator->fails()) {
        return $this->error('Validation failed', 422, $validator->errors());
    }

    try {
        // Dispara o job para gerar dados do sensor
        Bus::dispatch(new GenerateSensorDataJob($request->placa_id));
        
        // Se o dispatch for bem-sucedido
        return $this->response('Geração de dados iniciada para a placa.', 200);
    } catch (\Exception $e) {
        // Se houver um erro ao despachar o job
        return $this->error('Failed to dispatch job: ' . $e->getMessage(), 500);
    }
}


    public function getPlacaData($placa_id)
    {
        if(!auth()->user()->tokenCan('placa-show')){
            return $this->error('Unauthorized', 403);
        }

        $data = Gravacoes::where('placa_id', $placa_id)->orderBy('data_registro', 'desc')->get();

        if ($data->isEmpty()) {
            return $this->error('Nenhum dado encontrado para essa placa', 404);
        }

        return $this->response('Dados recuperados com sucesso.', 200, $data);
    }
}
