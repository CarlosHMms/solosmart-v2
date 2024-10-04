<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;

class Users extends Model
{
    use HasApiTokens,HasFactory;
    protected $table = 'users';

    protected $fillable = [
        'name',
        'email',
        'password',  // Alterado para 'password' em vez de 'senha'
        'nivel_acesso'
    ];
    public $timestamps = false;
}
