<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use Illuminate\Http\Request;
use App\Models\User;
use App\Traits\HttpResponse;
use Illuminate\Contracts\Validation\Rule;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    use HttpResponse;

    public function index()
    {
        return UserResource::collection(User::all());
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = $this->validation($request);
        if ($validator->fails()) {
            return $this->error('Dados inválidos', 400, $validator->errors());
        }
        $validatedData = $validator->validated();
        $validatedData['password'] = Hash::make($validatedData['password']);

        $created = User::create($validatedData);
        if ($created) {
            return $this->response('Usuário cadastrado', 200, $created);
        }
        return $this->error('Usuário não cadastrado', 401);
    }

    /**
     * Display the specified resource.
     */
    public function show(User $usuario)
    {
        return new UserResource($usuario);
    }

    public function getProfile()
    {
        try {
            // Obtém o usuário autenticado
            $user = Auth::user();

            if ($user) {
                // Log para verificar o usuário autenticado
                \Log::info('Usuário autenticado: ', ['user_id' => $user->id]);

                // Retorna os dados do usuário autenticado
                return $this->response('Perfil do usuário recuperado com sucesso', 200, $user);
            }

            return $this->error('Usuário não autenticado', 401);
        } catch (\Exception $e) {
            \Log::error('Erro ao recuperar o perfil do usuário: ' . $e->getMessage());
            return $this->error('Erro ao recuperar o perfil do usuário', 500);
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id, Request $request)
    {
        //Valido os dados da requisição
        $validator = $this->validationEdit($request);
        if ($validator->fails()) {
            return $this->error('Validation failed', 422, $validator->errors());
        }
        //Verifico se o usuário existe
        $usuario = User::find($id);
        if (!$usuario) {
            return $this->error('Não foi possivel concluir a edição', 404);
        }

        $validatedData = $validator->validated();

        if (array_key_exists('password', $validatedData)) {
            $validatedData['password'] = Hash::make($validatedData['password']);
        }


        //Verifico se a senha antiga é válida
        if (!Hash::check($validatedData['old_password'], $usuario->password)) {
            return $this->error('Senha Incorreta', 400);
        }
        //Atualizo os dados do usuário
        try {
            $usuario->update($validatedData);
        } catch (\Exception $e) {
            return $this->error('Não foi possivel concluir a edição', 400);
        }

        return $this->response('Usuário atualizado', 200, $usuario);
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $validator = $this->validation($request);
        if ($validator->fails()) {
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
        if ($updated) {
            return $this->response('usuário atualizado', 200, $request->all());
        }
        return $this->error('', 400);
    }

    public function updateProfileImage(Request $request)
    {
        $request->validate([
            'profile_image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $user = Auth::user();

        if ($request->hasFile('profile_image')) {
            // Remove a imagem antiga, se existir
            if ($user->profile_image) {
                Storage::delete($user->profile_image);
            }

            // Salva a nova imagem no disco público
            $path = $request->file('profile_image')->store('profiles', 'public'); // Adicione 'public' aqui

            // Atualiza o caminho da imagem no perfil do usuário
            $user->profile_image = Storage::url($path); // Gera a URL correta
            $user->save();
        }

        return response()->json(['message' => 'Imagem de perfil atualizada com sucesso!'], 200);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $usuario)
    {
        $deleted = $usuario->delete();
        if ($deleted) {
            return $this->response('usuário deletado', 200);
        }
        return $this->error('usuário não foi deletado', 400);
    }

    public function validation(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:100',
            'email' => 'required|string|email|max:255|unique:users,email',
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);
        return $validator;
    }
    public function validationEdit(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'string|max:100',
            'email' => 'string|email|max:255|unique:users,email',
            'password' =>  'confirmed',
            Rules\Password::defaults(),
            'old_password' => "required",
            Rules\Password::defaults(),
        ]);
        return $validator;
    }
}
