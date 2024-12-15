<?php

namespace App\Listeners;

use App\Events\NovaGravacao;
use App\Models\Alertas;
use App\Models\Gravacoes;
use App\Models\Placas;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class VerificarGravacao
{
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(NovaGravacao $event): void
    {
        $gravacao = $event->gravacao;
        $placa = $gravacao->placas;
        if($gravacao->temperatura_ar < $placa->temperatura_ar_minima || $gravacao->temperatura_ar > $placa->temperatura_ar_minima){
            $tipo = $this->defineTipoAlerta($gravacao->temperatura_ar, $placa->temperatura_ar_minima);
            if($tipo != 'normal') {
                Alertas::create([
                    'placa_id' => $placa->id,
                    'tipo' => $tipo,
                    'descricao' => "Temperatura do ar fora do limite: {$gravacao->temperatura_ar}°C",
                    'data' => now(),
                ]);
            }
        }
        if($gravacao->umidade_solo < $placa->umidade_solo_minima || $gravacao->umidade_solo > $placa->umidade_solo_minima){
            $tipo = $this->defineTipoAlerta($gravacao->umidade_solo, $placa->umidade_solo_minima);
            if($tipo != 'normal') {
                Alertas::create([
                    'placa_id' => $placa->id,
                    'tipo' => $tipo,
                    'descricao' => "Umidade do solo fora do limite: {$gravacao->umidade_solo}%.",
                    'data' => now(),
                ]);
            }
        }
        if($gravacao->umidade_ar < $placa->umidade_ar_minima || $gravacao->umidade_ar > $placa->umidade_ar_minima){
            $tipo = $this->defineTipoAlerta($gravacao->umidade_ar, $placa->umidade_ar_minima);
            if($tipo != 'normal') {
                Alertas::create([
                    'placa_id' => $placa->id,
                    'tipo' => $tipo,
                    'descricao' => "Umidade do ar fora do limite: {$gravacao->umidade_ar}%.",
                    'data' => now(),
                ]);
            }
        }
    }

    private function defineTipoAlerta($temperatura, $limite)
    {
        $diferenca = abs($temperatura - $limite);
        if ($diferenca >= $limite * 0.6){
            return 'grave';

        }elseif($diferenca >= $limite * 0.4){
            return 'medio';
        }else if($diferenca >= $limite * 0.1){
            return 'leve';
        }else{
            return 'normal';
        }
    }

}
