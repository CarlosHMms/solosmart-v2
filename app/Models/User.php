<?php

namespace App\Models;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Sanctum\HasApiTokens;


//1bfc041d754acabe1f05cfd9c2001b4b3840e9812d6ae2347096ef350faf9918

//67d80d7735ab55d484f92ebfdf11c5f749b23bfc6361c49bfdd771f0566d4d29
class User extends Authenticatable
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
