<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable; // Importar a trait Notifiable

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable; // Adicione Notifiable aqui

    protected $table = 'users';

    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    public $timestamps = false;

    public function placas()
    {
        return $this->hasMany(Placas::class);
    }
}
