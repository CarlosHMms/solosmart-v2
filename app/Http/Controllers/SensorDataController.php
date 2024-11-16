<?php

namespace App\Http\Controllers;

use App\Jobs\GenerateSensorDataJob;
use App\Traits\HttpResponse;
use Illuminate\Http\Request;
use App\Models\Gravacoes;
use App\Models\Placas;
use App\Models\Alertas;
use Illuminate\Support\Facades\Validator;

class SensorDataController extends Controller
{
    use HttpResponse;

    public function generateData(Request $request)
    {
        if (!auth()->user()->tokenCan('placa-store')) {
            return $this->error('Unauthorized', 403);
        }

        $validator = Validator::make($request->all(), [
            'placa_id' => 'required|exists:placas,id',
        ]);

        if ($validator->fails()) {
            return $this->error('Dados inválidos', 422, $validator->errors());
        }

        $data = [
            'placa_id' => $request->placa_id,
            'temperatura_ar' => rand(15, 35),
            'umidade_ar' => rand(30, 90),
            'umidade_solo' => rand(10, 70),
            'data_registro' => now(),
        ];

        // Cria a gravação
        $gravacao = Gravacoes::create($data);

        if (!$gravacao) {
            return $this->error('Falha ao gerar os dados', 500);
        }

        $alerta = null;

        // Verifica os limites configurados na tabela ConfigAlertas
        $placa = Placas::with('configAlertas')->find($request->placa_id);

        if ($placa && $placa->configAlertas) {
            $configAlertas = $placa->configAlertas;

            // Verifica se a temperatura está abaixo do limite mínimo
            if ($gravacao->temperatura_ar < $configAlertas->temp_minima) {
                $alerta = Alertas::create([
                    'tipo' => 'Temperatura Baixa',
                    'descricao' => "A temperatura registrada foi de {$gravacao->temperatura_ar}° que está abaixo do limite configurado.",
                    'data_alerta' => now(),
                    'gravacoes_id' => $gravacao->id,
                ]);
            }
        }

        return $this->response('Dados gerados e salvos com sucesso.', 200, [
            'gravacao' => $gravacao,
            'alerta' => $alerta,
        ]);
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

    public function getLastPlacaData($placa_id)
    {
        if(!auth()->user()->tokenCan('placa-show')){
            return $this->error('Unauthorized', 403);
        }

        // Busca a última gravação feita para a placa específica
        $data = Gravacoes::where('placa_id', $placa_id)
                    ->orderBy('data_registro', 'desc')
                    ->first();

        // Verifica se algum dado foi encontrado
        if (!$data) {
            return $this->error('Nenhum dado encontrado para essa placa', 404);
        }

        // Retorna o dado mais recente encontrado
        return $this->response('Último dado recuperado com sucesso.', 200, $data);
    }

}
