<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Alertas extends Model
{
    public function placa_id(): HasMany
    {
        return $this->hasMany(Placas::class, 'id', 'placa_id');
    }
    use HasFactory;
}
