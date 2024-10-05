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
        return PlacaResource::collection(Placas::with('user')->get());
    }

    public function store(Request $request)
    {
        if(!auth()->user()->tokenCan('placa-store')){
            return $this->error('Unauthorized', 403);
        }
        $validator = Validator::make($request->all(),[
            'numero_serie' => 'required|string|max:50',
            'user_id' => 'required|int',
        ]);
        if($validator->fails()){
            return $this->error( 'Dados inválidos', 422, $validator->errors());
        }
        $created = Placas::create($validator->validated());
        if($created){
            return $this->response('Placa cadastrada', 200, $created);
        }
        return $this->error('Placa não foi cadastrada', 401);

    }




    public function show(Placas $placas)
    {
        if(!auth()->user()->tokenCan('placa-show')){
            return $this->error('Unauthorized', 403);
        }

        return new PlacaResource($placas);

    }

}
