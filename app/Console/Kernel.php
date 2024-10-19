<?php

namespace App\Console;

use Illuminate\Support\Facades\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use App\Jobs\GenerateSensorDataJob;

class Kernel extends ConsoleKernel
{
    protected function schedule(Schedule $schedule)
    {
        $schedule->command('sanctum:prune-expired')->dailyAt('00:00')->timezone('America/Sao_Paulo');
        $schedule->job(new GenerateSensorDataJob())->everyMinute();
    }

    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
