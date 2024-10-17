<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gravacoes extends Model
{
    use HasFactory;

    protected $table = 'gravacoes';

    protected $fillable = [
        'placa_id',
        'temperatura_ar',
        'umidade_ar',
        'umidade_solo',
        'data_registro'
    ];

    public $timestamps = false;
}
