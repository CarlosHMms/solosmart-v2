<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TicketsResource extends JsonResource
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
            'status' => $this->status,
            'assunto' => $this->assunto,
            'descricao' => $this->descricao,
            'data_ticket' => $this->data_ticket,
            'user' => [
                'name' => $this->user->name,
                'email' => $this->user->email
            ]
        ];
    }
}
