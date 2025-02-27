<?php

namespace App\Http\Controllers;

use App\Http\Resources\AlertasResource;
use App\Http\Resources\PlacaResource;
use App\Models\Alertas;
use App\Models\Placas;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use function Pest\Laravel\get;

class AlertasController extends Controller
{
    /**
     * Display a listing of the resource.
     */

    public function index()
    {
        if(!auth()->user()->tokenCan('alerta-index')){
            return $this->error('unauthorized', 403);
        }
        $alertas = Alertas::whereHas('placa', function ($query){
            $query->where('user_id', auth()->id());
        })->with('placa')->get();
        return AlertasResource::collection($alertas);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store($descricao, $placaId, $tipo)
    {
        $validator = Validator::make([
            'placa_id' => $placaId,
            'tipo' => $tipo,
            'descricao' => $descricao
        ], [
            'placa_id' => 'required|exists:placas,id',
            'tipo' => 'required|in:grave,medio,leve',
            'descricao' => 'required|string',
        ]);
        if($validator->fails()){
            return response()->json([
                'message' =>'error validation',
                'error' =>$validator->errors()
            ], 422);
        }
        $alerta = Alertas::create([
            'placa_id' => $placaId,
            'tipo' => $tipo,
            'descricao' => $descricao,
            'data' => now(),
        ]);
        return $this->response()->json([
            'message' => 'Alerta criado com sucesso!',
            'alerta' => $alerta
        ], 200);

    }

    public function getNewAlertas(Request $request)
    {
        $lastChecked = $request->query('last_checked');
        $alertas = Alertas::whereHas('placas', function ($query) {
            $query->where('user_id', auth()->id());
        })
            ->where('visualizado', false) // Filtra apenas os alertas não visualizados
            ->with('placas')
            ->when($lastChecked, function ($query) use ($lastChecked) {
                $query->where('data', '>', $lastChecked);
            })
            ->get();
        //$alertas->each(function ($alerta) {
            //$alerta->update(['visualizado' => true]);
        //});
        return AlertasResource::collection($alertas);
    }

    public function Visualizado(Request $request)
    {
        if(!auth()->user()->tokenCan('alerta-visualizado')){
            return $this->error('unauthorized', 403);
        }
        // Valida a lista de IDs de alertas passados no corpo da requisição
        $validated = $request->validate([
            'ids' => 'required|array',
            'ids.*' => 'exists:alertas,id', // Verifica se os IDs existem na tabela
        ]);

        // Atualiza o campo 'visualizado' para true (1) nos registros
        Alertas::whereIn('id', $validated['ids'])->update(['visualizado' => true]);

        // Retorna uma resposta de sucesso
        return response()->json([
            'message' => 'Alertas marcados como visualizados com sucesso.',
        ], 200);
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
