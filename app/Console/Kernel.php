<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{

    protected function schedule(Schedule $schedule)
    {
        //todos os tokens que foram expirados dentro das últimas 24 horas serão apagados das tabelas no banco
         $schedule->command('sanctum:prune-expired')->dailyAt('00:00')->timezone('America/Sao_Paulo');
    }

    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }

}
