<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('placas', function (Blueprint $table) {
            $table->id()->autoIncrement();
            $table->string('name', 255);
            $table->string('numero_serie', 50);
            $table->float('temperatura_ar_minima');
            $table->float('umidade_ar_minima');
            $table->float('umidade_solo_minima');
            $table->foreignId('user_id')->references('id')->on('users')->onDelete('RESTRICT');
        });
    }

    public function down(): void
    {
        Schema::drop('placas', function (Blueprint $table) {
            $table->dropForeign('user_id');
            $table->drop('placas');
        });
    }
};
