<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Gravacoes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Traits\HttpResponse;
use Illuminate\Support\Facades\Validator;

class GravacaoController extends Controller
{
    use HttpResponse;
    public function index()
    {
        if (!auth()->user()->tokenCan("gravacoes-index")) {
            return $this->error("Unauthorized", 403);
        }

        return response()->json(Gravacoes::all());
    }

    public function listByDate(Request $request)
    {
        if (!auth()->user()->tokenCan("gravacoes-index")) {
            return $this->error("Unauthorized", 403);
        }

        $validatedData = $this->validateName($request);
        if ($validatedData->fails()) {
            return $this->error("Dados inválidos", 422, $validatedData->errors());
        }
        $startDate = $request->initialDate;
        $endDate = $request->finalDate;

        $startDate = date('Y-m-d H:i:s', strtotime($startDate));
        $endDate = date('Y-m-d H:i:s', strtotime($endDate));

        $gravacoes = Gravacoes::query()
            ->where('data_registro', '>=', $startDate)
            ->where('data_registro', '<=', $endDate)
            ->get();

        return $this->response("Gravações encontradas", 200, $gravacoes->toArray());
    }
    public function validateName(Request $request)
    {
        return Validator::make($request->all(), [
            'initialDate' => 'required',
            'finalDate' => 'required',

        ]);
    }
}