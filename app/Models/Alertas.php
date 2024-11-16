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

    protected $table = 'alertas';
    protected $fillable = [
        'tipo',
        'descricao',
        'data_alerta',
        'gravacoes_id',
    ];

    public function gravacoes()
    {
        return $this->belongsTo(Gravacoes::class, 'gravacoes_id');
    }

    public $timestamps = false;
}
