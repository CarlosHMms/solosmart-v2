<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AlertasResource extends JsonResource
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
            'tipo'=> $this->tipo,
            'descricao' => $this->descricao,
            'data'=> $this->data->toDateTimeString(),
            'placa_relacionada' => $this->whenLoaded('placa', function (){
               return $this->placa->only(['id','name','numero_serie']);
            }),
            ];
    }
}
