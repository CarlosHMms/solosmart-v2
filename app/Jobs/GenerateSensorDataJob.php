<?php

namespace App\Jobs;

use App\Models\Gravacoes;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Foundation\Bus\Dispatchable;

class GenerateSensorDataJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $placaId;

    public function __construct($placaId)
    {
        $this->placaId = $placaId;
    }

    public function handle()
    {
        Gravacoes::create([
            'placa_id' => $this->placaId,
            'temperatura_ar' => rand(15, 40),
            'umidade_ar' => rand(30, 70),
            'umidade_solo' => rand(10, 50),
            'data_registro' => now(),
        ]);
    }
}

