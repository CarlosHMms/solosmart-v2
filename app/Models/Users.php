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
        'password',
    ];
    public $timestamps = false;
}
