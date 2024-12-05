<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Gravacoes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Traits\HttpResponse;

class GravacaoController extends Controller
{
    use HttpResponse;
    public function index()
    {
        if (!auth()->user()->tokenCan("gravacoes-index")){
            return $this->error("Unauthorized", 403);
        }
        
        return response()->json(Gravacoes::all());
        
    }
}