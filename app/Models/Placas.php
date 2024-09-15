<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Placas extends Model
{
    public function user_id(): HasMany
    {
        return $this->hasMany(Usuarios::class, 'id', 'user_id');
    }
    use HasFactory;
}
