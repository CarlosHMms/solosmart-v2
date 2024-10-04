<?php

namespace App\Http\Controllers;

use App\Http\Resources\UsersResource;
use Illuminate\Http\Request;
use App\Models\User;
use App\Traits\HttpResponse;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    use HttpResponse;
    
    public function index()
    {
        return User::all();
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = $this->validation($request);
        if($validator -> fails()){
            return $this->error('Dados inválidos', 400, $validator->errors());
        }
        $validatedData = $validator->validated();
        $validatedData['password'] = Hash::make($validatedData['password']);

        $created = User::create($validatedData);
        if($created){
            return $this->response('Usuário cadastrado', 200, $created);
        }
        return $this->error('Usuário não cadastrado', 401);

    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email|max:255',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return $this->error('Dados inválidos', 400, $validator->errors());
        }

        $user = Users::where('email', $request->email)->first();

        if (!$user) {
            return $this->error('Email incorreto ou usuário não cadastrado', 404);
        }

        if (!Hash::check($request->password, $user->password)) {
            return $this->error('Senha incorreta', 401);
        }

        $token = $user->createToken('authToken')->plainTextToken;

        return $this->response('Login realizado com sucesso', 200, [
            'user' => $user,
            'token' => $token
        ]);
    }

    public function logout(Request $request)
    {
        // Verifica se o usuário está autenticado
        if ($request->user()) {
            // Revoke (invalida) o token atual
            $request->user()->currentAccessToken()->delete();

            // Retorna resposta de sucesso
            return $this->response('Logout realizado com sucesso', 200);
        }

        // Caso o usuário não esteja autenticado, retorna erro
        return $this->error('Usuário não autenticado', 401);
    }

    /**
     * Display the specified resource.
     */
    public function show(User $usuario)
    {
        return new UsersResource($usuario);
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
        $validator = $this->validation($request);
        if ($validator->fails()){
            return $this->error('Validation failed', 422, $validator->errors());
        }
        $validatedData = $validator->validated();
        $validatedData['password'] = Hash::make($validatedData['password']);
        $updated = User::find($id)->update([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => $validatedData['password'],
            'nivel_acesso' => $validatedData['nivel_acesso']
        ]);
        if($updated){
            return $this->response('usuário atualizado', 200, $request->all());

        }
        return $this->error('', 400);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $usuario)
    {
        $deleted = $usuario->delete();
        if ($deleted){
            return $this->response('usuário deletado', 200);
        }
        return $this->error('usuário não foi deletado', 400);
    }

    public function validation(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:100',
            'email' => 'required|string|email|max:255|unique:users,email',
            'password' => 'required|string|min:6'
        ]);
        return $validator;
    }
}
