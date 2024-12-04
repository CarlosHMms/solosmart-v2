<?php

namespace App\Http\Controllers;

use App\Http\Resources\PlacaResource;
use App\Models\Placas;
use App\Traits\HttpResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PlacaController extends Controller
{
    use HttpResponse;

    public function index()
    {
        if (!auth()->user()->tokenCan('placa-index')) {
            return $this->error('Unauthorized', 403);
        }
        $placas = Placas::with('user')->where('user_id', auth()->id())->get();

        return PlacaResource::collection($placas);
    }

    public function store(Request $request)
    {
        if (!auth()->user()->tokenCan('placa-store')) {
            return $this->error('Unauthorized', 403);
        }
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'numero_serie' => 'required|string|max:50',
            'temperatura_ar_minima' => 'required|numeric',
            'umidade_ar_minima'=> 'required|numeric',
            'umidade_solo_minima'=> 'required|numeric',
        ]);
        if ($validator->fails()) {
            return $this->error('Dados inválidos', 422, $validator->errors());
        }

        $created = Placas::create([
            'name' => $validator->validated()['name'],
            'numero_serie' => $validator->validated()['numero_serie'],
            'temperatura_ar_minima' => $validator->validated()['temperatura_ar_minima'],
            'umidade_ar_minima' => $validator->validated()['umidade_ar_minima'],
            'umidade_solo_minima' => $validator->validated()['umidade_solo_minima'],
            'user_id' => auth()->id()
        ]);
        if ($created) {
            return $this->response('Placa cadastrada', 200, $created);
        }
        return $this->error('Placa não foi cadastrada', 401);
    }

    public function destroy($placaId)
    {
        if (!auth()->user()->tokenCan('placa-destroy')) {
            return $this->error('Unauthorized', 403);
        }

        // Busca a placa para garantir que o usuário autenticado é o dono
        $placa = Placas::where('user_id', auth()->id())->where('id', $placaId)->first();

        if (!$placa) {
            return $this->error('Placa não encontrada', 404);
        }

        // Tenta deletar a placa
        if ($placa->gravacoes()->delete() || $placa->delete()) {
            return $this->response('Placa deletada', 200);
        }

        return $this->error('Placa não foi deletada', 400);
    }



    public function show($id)
    {
        if (!auth()->user()->tokenCan('placa-show')) {
            return $this->error('Unauthorized', 403);
        }
        $placa = Placas::with('user')->where('user_id', auth()->id())->where('id', $id)->first();
        if (!$placa) {
            return $this->error('Placa não encontrada', 404);
        }

        return new PlacaResource($placa);
    }

    public function editName($id, Request $request)
    {
        if (!auth()->user()->tokenCan('placa-editName')) {
            return $this->error('Unauthorized', 403);
        }

        $placa = Placas::find($id);

        if (!$placa) {
            return $this->error('Placa não encontrada', 404);
        }
        $validator = $this->validateName($request);
        if ($validator->fails()) {
            return $this->error('Dados inválidos', 422, $validator->errors());
        }
        $validatedData = $validator->validated();

        try {
            $placa->update($validatedData);
            return $this->response('Placa atualizada', 200, $placa);
        } catch (\Exception $e) {
            return $this->error('Placa não foi atualizada', 400);
        }
    }

    public function validateName(Request $request)
    {
        return Validator::make($request->all(), [
            'name' => 'required|string|max:255',
        ]);
    }
}