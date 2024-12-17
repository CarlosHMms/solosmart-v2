<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Placas extends Model
{
    use HasFactory;

    protected $table = 'placas';
    protected $fillable = [
        'name',
        'numero_serie',
        'temperatura_ar_minima',
        'umidade_ar_minima',
        'umidade_solo_minima',
        'user_id',
    ];

    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function gravacoes()
    {
        return $this->hasMany(Gravacoes::class, 'placa_id', 'id');
    }
    public function alertas()
{
    return $this->hasMany(Alertas::class, 'placa_id', 'id');
}
}
