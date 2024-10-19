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
        if(!auth()->user()->tokenCan('placa-index')){
            return $this->error('Unauthorized', 403);
        }
        $placas = Placas::with('user')->where('user_id', auth()->id())->get();

        return PlacaResource::collection($placas);
    }

    // Método de sucesso
    protected function success($message, $data, $statusCode = 200)
    {
        return response()->json([
            'status' => 'success',
            'message' => $message,
            'data' => $data,
        ], $statusCode);
    }

    // Método de erro
    protected function error($message, $statusCode)
    {
        return response()->json([
            'status' => 'error',
            'message' => $message,
        ], $statusCode);
    }



    public function store(Request $request)
    {
        if(!auth()->user()->tokenCan('placa-store')){
            return $this->error('Unauthorized', 403);
        }
        $validator = Validator::make($request->all(),[
            'name' => 'required|string|max:255',
            'numero_serie' => 'required|string|max:50'
        ]);
        if($validator->fails()){
            return $this->error( 'Dados inválidos', 422, $validator->errors());
        }
        
        $created = Placas::create([
            'name' => $validator->validated()['name'],
            'numero_serie' => $validator->validated()['numero_serie'],
            'user_id' => auth()->id()
        ]);
        if($created){
            return $this->response('Placa cadastrada', 200, $created);
        }
        return $this->error('Placa não foi cadastrada', 401);
    

    }




    public function show($id)
    {
        if(!auth()->user()->tokenCan('placa-show')){
            return $this->error('Unauthorized', 403);
        }
        $placa = Placas::with('user')->where('user_id', auth()->id())->where('id', $id)->first();
        if (!$placa) {
            return $this->error('Placa não encontrada', 404);
        }

        return new PlacaResource($placa);

    }

}