<?php

namespace App\Http\Controllers;

use App\Models\Gravacoes;
use App\Traits\HttpResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class SensorDataController extends Controller
{
    use HttpResponse;

    public function generateData(Request $request)
    {
        if(!auth()->user()->tokenCan('placa-store')){
            return $this->error('Unauthorized', 403);
        }

        $validator = Validator::make($request->all(), [
            'placa_id' => 'required|exists:placas,id',
        ]);

        if($validator->fails()){
            return $this->error('Dados inválidos', 422, $validator->errors());
        }

        $data = [
            'placa_id' => $request->placa_id,
            'temperatura_ar' => rand(20, 35),
            'umidade_ar' => rand(30, 90),
            'umidade_solo' => rand(10, 70),
            'data_registro' => now(),
        ];

        $created = Gravacoes::create($data);

        if($created){
            return $this->response('Dados gerados e salvos com sucesso.', 200, $created);
        }

        return $this->error('Falha ao gerar os dados', 500);
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
