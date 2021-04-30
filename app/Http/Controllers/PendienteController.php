<?php

namespace App\Http\Controllers;

use App\Exports\PendienteExport;
use Illuminate\Http\Request;
use DB;
use Maatwebsite\Excel\Facades\Excel;

class PendienteController extends Controller
{
    var $datos_pendiente;


    public function pendiente_indexi(Request $request)
    {

        $insertar_pendiente_empaque =   \DB::select(
            'call insertar_pendente_empaque(:fecha)',
            ['fecha' => (string)$request->fecha]
        );

        $insertar_pendiente = \DB::select(
            'call insertar_pendiente(:fecha)',
            ['fecha' => (string)$request->fecha]
        );

        $datos_pendiente =  \DB::select('call mostrar_pendiente');

        return view('pendiente')->with('insertar_pendiente', $insertar_pendiente)->with('datos_pendiente', $datos_pendiente)->with('insertar_pendiente_empaque', $insertar_pendiente_empaque);
    }


    public function pendiente_index(Request $request)
    {

        $datos_pendiente =  \DB::select('call mostrar_pendiente');

        return view('pendiente')->with('datos_pendiente', $datos_pendiente);
    }



    public function buscar(Request $request)
    {
        if ($request->fecha_de == null) {
            $fede = "0";
        } else {
            $fede = $request->fecha_de;
        }

        if ($request->fecha_hasta === null) {
            $feha = "0";
        } else {
            $feha = $request->fecha_hasta;
        }


        if ($request->nombre == null) {
            $nom = "0";
        } else {
            $nom = $request->nombre;
        }

        $datos_pendiente = \DB::select(
            'call buscar_pendiente(:nombre,:fechade,:fechahasta)',
            [
                'nombre' => (string)$nom,
                'fechade' => (string)$fede,
                'fechahasta' => (string)$feha
            ]
        );


        return view('pendiente')->with('datos_pendiente', $datos_pendiente)
            ->with('nom', $nom)
            ->with('fede', $fede)
            ->with('feha', $feha);
    }

    

    function exportPendiente(Request $request)
    {
        if ($request->fecha_de == null) {
            $fede = "0";
        } else {
            $fede = $request->fecha_de;
        }

        if ($request->fecha_hasta === null) {
            $feha = "0";
        } else {
            $feha = $request->fecha_hasta;
        }


        if ($request->nombre == null) {
            $nom = "0";
        } else {
            $nom = $request->nombre;
        }
        return Excel::download(new PendienteExport($nom, $fede, $feha), 'Pendiente.xlsx');
    }
}
