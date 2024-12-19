<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('gravacoes', function (Blueprint $table) {
            $table->id()->autoIncrement();
            $table->foreignId('placa_id')->references('id')->on('placas')->onDelete('CASCADE');
            $table->float('temperatura_ar');
            $table->float('umidade_ar');
            $table->float('umidade_solo');
            $table->timestamp('data_registro', precision: 0);
        });
    }

    public function down(): void
    {
        Schema::drop('gravacoes', function (Blueprint $table) {
            $table->dropForeign('placa_id');
            $table->drop('gravacoes');
        });
    }
};