<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;

class Usuarios extends Model
{
    use HasApiTokens, HasFactory;

    protected $table = 'usuarios';

    protected $fillable = [
        'nome',
        'email',
        'password',  // Alterado para 'password' em vez de 'senha'
        'nivel_acesso'
    ];

    public $timestamps = false;

    /**
     * Definir um mutator para garantir que a senha seja sempre
     * armazenada de forma segura, ou seja, hash.
     */
    public function setPasswordAttribute($value)
    {
        $this->attributes['password'] = bcrypt($value);
    }
}

