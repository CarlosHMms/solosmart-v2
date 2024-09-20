<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('alertas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('gravacoes_id')->references('id')->on('gravacoes')->onDelete('RESTRICT');
            $table->float('temperatura_ar_minima');
            $table->float('umidade_ar_minima');
            $table->float('umidade_solo_mm');
            $table->string('tipo', 50);
            $table->text('descricao');
            $table->timestamp('data', precision: 0);
        });
    }
    public function down(): void
    {
        Schema::drop('alertas', function (Blueprint $table) {
            $table->dropForeign('placa_id');
            $table->drop('alertas');
        });
    }
};
