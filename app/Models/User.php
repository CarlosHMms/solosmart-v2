<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'users';

    protected $fillable = [
        'name',
        'email',
        'password',
        'profile_image',
    ];

    public $timestamps = false;

    public function placas()
    {
        return $this->hasMany(Placas::class);
    }

    // Acessador para a propriedade profile_image
    public function getProfileImageAttribute($value)
    {
        return $value ? url($value) : null; // Retorna a URL completa se houver um valor
    }
}
