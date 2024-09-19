<?php
namespace App\Traits;
use Illuminate\Support\MessageBag;
use Illuminate\Database\Eloquent\Model;

trait HttpResponse{

    //função da estrutura json que traz resultados de uma requisição de sucesso
    public function response(string $message,  string|int $status,array|Model $data = [] ){
        return response()->json([
            'message' => $message,
            'status' => $status,
            'data' => $data
            ],$status);
    }
    // função que faz estrutura json que recebe mensagens de erros que podem acontecer
    public function error(string $message,  string|int $status,array|MessageBag $errors = [],array $data = [] ){
        return response()->json([
            'message' => $message,
            'status' => $status,
            'errors' => $errors,
            'data' => $data
            ],$status);
    }

} 





