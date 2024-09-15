<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('usuarios', function (Blueprint $table) {
            $table->id()->autoIncrement();
            $table->string('nome', 100);
            $table->string('name', 100);
            $table->string('email', 255);
            $table->string('senha');
            $table->enum('nivel_acesso', ['admin', 'user']);
        });
    }
    public function down(): void
    {
        Schema::drop('usuarios');
    }
};