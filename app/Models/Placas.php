<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Placas extends Model
{
    use HasFactory;

    protected $table = 'placas';
    protected $fillable = [
        'numero_serie',
        'user_id',

    ];

    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
