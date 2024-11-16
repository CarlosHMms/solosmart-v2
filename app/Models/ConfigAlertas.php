<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConfigAlertas extends Model
{
    use HasFactory;

    protected $fillable = [
        'placa_id',
        'temp_minima',
        'umidade_ar_minima',
        'umidade_solo_minima',
    ];

    /**
     * Relacionamento com a placa.
     */
    public function placas()
    {
        return $this->belongsTo(Placas::class, 'placa_id');
    }
}

