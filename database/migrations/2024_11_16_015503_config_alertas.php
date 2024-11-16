<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ConfigAlertas extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('config_alertas', function (Blueprint $table) {
            $table->id()->autoIncrement(); // Chave primária
            $table->foreignId('placa_id')->constrained('placas')->onDelete('cascade'); // Relacionamento com placas
            $table->float('temp_minima')->nullable(false); // Temperatura mínima
            $table->float('umidade_ar_minima')->nullable(); // Umidade ar mínima
            $table->float('umidade_solo_minima')->nullable(); // Umidade solo mínima
            $table->timestamps(); // Campos de criação e atualização
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('config_alertas');
    }
}
