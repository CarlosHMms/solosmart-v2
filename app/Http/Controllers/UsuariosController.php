<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Usuarios;
use App\Traits\HttpResponse;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash; 

class UsuariosController extends Controller
{
    use HttpResponse;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Usuarios::all();
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nome' => 'required|string|max:100',
            'email' => 'required|string|email|max:255|unique:usuarios,email',
            'senha' => 'required|string|min:6',
            'nivel_acesso' => 'required|in:admin,user'
        ]);
        if($validator -> fails()){
            return $this->error('Dados inválidos', 400, $validator->errors());
        }
        $validatedData = $validator->validated();
        $validatedData['senha'] = Hash::make($validatedData['senha']); // Criptografa a senha
    
        $created = Usuarios::create($validatedData);
        if($created){
            return $this->response('Usuario criado', 200, $created);
        }
        return $this->error('Usuario não foi criado', 400);

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        
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
