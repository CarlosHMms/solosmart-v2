<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Usuarios extends Model
{
    protected $table = 'usuarios';
    protected $fillable = [
        'nome',
        'email',
        'senha',
        'nivel_acesso'
    ];

    public $timestamps = false;
    use HasFactory;
}
