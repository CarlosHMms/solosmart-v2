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
            $table->string('numero_serie', 50);
            $table->foreignId('user_id')->references('id')->on('usuarios')->onDelete('RESTRICT');
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
