<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PlacaResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'numero_serie' => $this->numero_serie,
            'temperatura_ar_minima' => $this->temperatura_ar_minima,
            'umidade_ar_minima' => $this->umidade_ar_minima,
            'umidade_solo_minima' => $this->umidade_solo_minima,
            'user' => [
                'name' => $this->user->name,
                'email' => $this->user->email
            ]
        ];
    }
}
