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
            $table->foreignId('placa_id')->references('id')->on('placas')->onDelete('RESTRICT');
            $table->enum('tipo', ['grave', 'medio', 'leve']);
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
