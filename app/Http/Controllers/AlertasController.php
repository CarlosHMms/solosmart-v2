<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Traits\HttpResponse;
use Illuminate\Support\Facades\Validator;
use App\Models\Alertas;

class AlertasController extends Controller
{
    use HttpResponse;
    /**
     * Display a listing of the resource.
     */
    public function index($placa_id)
    {
        if (!auth()->user()->tokenCan('alerta-index')) {
            return $this->error('Unauthorized', 403);
        }

        // Buscar os alertas associados à placa_id e gravacoes_id
        $alertas = Alertas::with('gravacoes.placa') // Carrega as gravações e placas associadas
            ->whereHas('gravacoes', function ($query) use ($placa_id) {
                // Filtra os alertas com base na placa_id associada ao gravacoes_id
                $query->where('placa_id', $placa_id);
            })
            ->get();

        $alertas = $alertas->map(function ($alerta) {
            return [
                'id' => $alerta->id,
                'tipo' => $alerta->tipo,
                'descricao' => $alerta->descricao,
                'data_alerta' => $alerta->data_alerta,
                'gravacoes_id' => $alerta->gravacoes_id,
            ];
        });

        return response()->json([
            'status' => 200,
            'message' => 'Alertas recuperados com sucesso.',
            'data' => $alertas,
        ]);
    }




    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
