<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Tickets>
 */
class TicketsFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'status' => $this->status,
            'assunto' => $this->assunto,
            'descricao' => $this->descricao,
            'data_ticket' => $this->data_ticket,
            'user_id' => $this->user_id,
        ];
    }
}
