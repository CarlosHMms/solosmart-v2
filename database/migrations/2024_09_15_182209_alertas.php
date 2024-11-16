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
            $table->string('tipo', 50);
            $table->text('descricao');
            $table->timestamp('data_alerta', precision: 0);
            $table->foreignId('gravacoes_id')->references('id')->on('gravacoes')->onDelete('RESTRICT');
        });
    }
    public function down(): void
    {
        Schema::drop('alertas', function (Blueprint $table) {
            $table->dropForeign('gravacoes_id');
            $table->drop('alertas');
        });
    }
};
