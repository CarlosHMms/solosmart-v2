<?php

namespace App\Models;

use App\Events\NovaGravacao;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gravacoes extends Model
{
    use HasFactory;

    protected $table = 'gravacoes';

    protected $fillable = [
        'placa_id',
        'temperatura_ar',
        'umidade_ar',
        'umidade_solo',
        'data_registro'
    ];
    protected static function booted()
    {
        static::created(function ($gravacao){
            $gravacao->load('placas');
            event(new NovaGravacao($gravacao));
        });
    }

    public function placas(){
        return $this->belongsTo(Placas::class,'placa_id');
    }


    public $timestamps = false;
}
