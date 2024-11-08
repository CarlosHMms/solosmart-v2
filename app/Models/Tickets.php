<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class Tickets extends Model
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'tickets';
    protected $fillable = [
        'status',
        'assunto',
        'descricao',
        'data_ticket',
        'user_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

}
