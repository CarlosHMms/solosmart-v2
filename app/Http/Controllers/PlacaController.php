<?php

namespace App\Http\Controllers;

use App\Models\Placas;
use App\Traits\HttpResponse;
use Illuminate\Http\Request;

class PlacaController extends Controller
{
    use HttpResponse;
    public function store()
    {
        return $this->response('Authorized', 200 );
    }




    public function show(Placas $placas)
    {
        return $this->response('Authorized', 200 );
    }

}
