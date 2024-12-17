<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class Alertas extends Model
{
    use HasApiTokens, HasFactory, Notifiable;
    public $timestamps = false;

    protected $table = 'alertas';
    protected $fillable = [
        'placa_id',
        'tipo',
        'descricao',
        'visualizado',
        'data'
    ];
    protected $casts = [
        'data' => 'datetime',
    ];


    public function placas()
    {
        return $this->belongsTo(Placas::class, 'placa_id', 'id');
    }

}
