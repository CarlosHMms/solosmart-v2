<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Usuarios extends Model
{
    protected $fillable = [
        'nome',
        'email',
        'senha',
        'nivel_acesso'
    ];

    public $timestamps = false;
    public function usuarios() {}
    use HasFactory;
}
