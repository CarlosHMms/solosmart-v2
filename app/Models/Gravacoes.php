<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Gravacoes extends Model
{
    public function placa_id(): HasOne
    {
        return $this->hasOne(Placas::class, 'id', 'placa_id');
    }
    use HasFactory;
}
