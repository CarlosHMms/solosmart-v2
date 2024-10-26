<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;

class ImageController extends Controller
{
    public function getImage($filename)
    {
        $user = Auth::user();
        if (!$user) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        $path = storage_path('app/public/profiles/' . $filename);

        if (!file_exists($path)) {
            return response()->json(['message' => 'Imagem não encontrada'], 404);
        }

        return response()->file($path, [
            'Access-Control-Allow-Origin' => '*', // Permitir todos os domínios
            // Ou use um domínio específico:
            // 'Access-Control-Allow-Origin' => 'http://seu-dominio.com',
        ]);
    }
}
