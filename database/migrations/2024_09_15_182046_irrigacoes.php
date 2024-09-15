<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('irrigacoes', function (Blueprint $table) {
            $table->id()->autoIncrement();
            $table->foreignId('placa_id')->nullable(true)->references('id')->on('placas')->onDelete('RESTRICT');
            $table->enum('status', ['ativado', 'desativado']);
            $table->enum('estado_controle', ['automatico', 'manual']);
            $table->timestamp('data_ativacao', precision: 0);
        });
    }
    public function down(): void
    {
        Schema::drop('irrigacoes', function (Blueprint $table) {
            $table->dropForeign('placa_id');
            $table->drop('irrigacoes');
        });
    }
};
