<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tickets', function (Blueprint $table) {
            $table->id()->autoIncrement();
            $table->boolean('status');
            $table->string('assunto', 50);
            $table->text('descricao');
            $table->timestamp('data_ticket', precision: 0);
            $table->foreignId('user_id')->constrained('users')->onDelete('RESTRICT');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tickets');
    }
};