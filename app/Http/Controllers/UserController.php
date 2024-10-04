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
        // Validação dos dados de entrada
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email',
            'password' => 'required|string|min:6',
        ]);

        // Verifica se a validação falhou
        if ($validator->fails()) {
            return $this->error('Dados inválidos', 400, $validator->errors());
        }

        // Obtém as credenciais do usuário
        $credentials = $request->only('email', 'password');

        // Tenta autenticar o usuário
        if (Auth::attempt($credentials)) {
            // Autenticação bem-sucedida
            $user = Auth::user();
            return $this->response('Login bem-sucedido', 200, new UsersResource($user));
        }

        // Retorna erro se as credenciais forem inválidas
        return $this->error('Credenciais inválidas', 401);
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

    private function loginValidation(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email',
            'password' => 'required|string|min:6',
        ]);
        return $validator;
    }
}
