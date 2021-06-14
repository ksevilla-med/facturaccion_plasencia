<?php

namespace App\Http\Livewire;

use Livewire\Component;

use Illuminate\Http\Request;
use Carbon\Carbon;

use Maatwebsite\Excel\Facades\Excel;

use App\Exports\detallesExport;
use Illuminate\Support\Facades\DB;

class DetalleProgramacion extends Component
{


    public $detalles_provicionales;
    public $busqueda;
    public $borrar;
    public $actualizar;
    public $actualizar_insertar;
    public $fecha;
    public $contenedor;
    public $insertar_programacion;
    public $fecha_actual;

    public function render()
    {
        $this->detalles_provicionales = DB::select('call mostrar_detalles_provicional(:buscar)', [
            'buscar' => $this->busqueda
        ]);

        return view('livewire.detalle-programacion')->extends('principal')->section('content');
    }

    public function mount()
    {

        $this->detalles_provicionales = [];
        $this->borrar = [];
        $this->busqueda = "";
        $this->actualizar = [];
        $this->actualizar_insertar = [];
        $this->contenedor = "";

        $this->insertar_programacion = [];

        $this->fecha = Carbon::now()->format("Y-m-d");
    }

    public function eliminar_detalles(Request $request)
    {


        $this->detalles_provicionales = [];


        $actualizar_existencia =  ($request->saldo_viejoe + $request->cant_cajase);

        $this->borrar = DB::select(
            'call eliminar_detalles(:buscar,:id_pendiente,:cant)',
            [
                'buscar' => $request->id_usuarioE,
                'id_pendiente' => $request->id_pendientee,
                'cant' => $actualizar_existencia
            ]
        );;



        return redirect()->route('detalles_programacion');
    }


    public function modal_limpiar()
    {
        $this->dispatchBrowserEvent('abrir_modal_eliminar');
    }

    public function eliminar_datos()
    {
        DB::table('detalle_programacion_temporal')->delete();
        DB::update("ALTER TABLE detalle_programacion_temporal AUTO_INCREMENT = 1");
        $this->dispatchBrowserEvent('cerrar_modal_eliminar');
    }



    public function actualizar_saldo(Request $request)
    {

        $detalles_provicionales = DB::select('call mostrar_detalles_provicional(:buscar)', [
            'buscar' => $this->busqueda
        ]);


        $cant_tipo = DB::select(
            'call traer_cant_cajas(:id_pendiente)',
            ['id_pendiente' => $request->id_pendientea]
        );


        $cajas_utilizadas_actual = ($request->saldo / $cant_tipo[0]->cajas_tipo); //50

        $cajas_utilizadas_viejas = $request->cant_cajas + $request->saldo_viejo; //30



        $cajas_actualizar = ($cajas_utilizadas_viejas - $cajas_utilizadas_actual); //


        $this->actualizar = DB::select(
            'call actualizar_saldo_programacion(:id, :saldo,:cant,:id_pendiente)',
            [
                'id' => $request->id_detalle,
                'saldo' => $request->saldo,
                'cant' => $cajas_actualizar,
                'id_pendiente' => $request->id_pendientea
            ]
        );




        return redirect()->route('detalles_programacion');
    }

    public function insertarDetalle_y_actualizarPendiente()
    {



        $this->detalles_provicionales = DB::select('call mostrar_detalles_provicional(:buscar)', ['buscar' => $this->busqueda]);


        $this->insertar_programacion = DB::select(
            'call insertar_programacion(:fecha,:contenedor)',
            [
                'fecha' => $this->fecha,
                'contenedor' => $this->contenedor
            ]
        );


        $this->tuplas = count($this->detalles_provicionales);


        for ($i = 0; $this->tuplas > $i; $i++) {
            $this->actualizar_insertar = DB::select(
                'call insertar_detalle_programacion(:numero_orden, :orden,:cod_producto,:saldo,:id_pendiente,:caja,:cant)',
                [
                    'numero_orden' => isset($this->detalles_provicionales[$i]->numero_orden) ? $this->detalles_provicionales[$i]->numero_orden : null,
                    'orden' => isset($this->detalles_provicionales[$i]->orden) ? $this->detalles_provicionales[$i]->orden : null,
                    'cod_producto' => isset($this->detalles_provicionales[$i]->cod_producto) ? $this->detalles_provicionales[$i]->cod_producto : null,
                    'saldo' => isset($this->detalles_provicionales[$i]->saldo) ? $this->detalles_provicionales[$i]->saldo : null,
                    'id_pendiente' => isset($this->detalles_provicionales[$i]->id_pendiente) ? $this->detalles_provicionales[$i]->id_pendiente : null,
                    'caja' => isset($this->detalles_provicionales[$i]->existencia) ? $this->detalles_provicionales[$i]->existencia : null,
                    'cant' => isset($this->detalles_provicionales[$i]->cant_cajas) ? $this->detalles_provicionales[$i]->cant_cajas : null
                ]
            );
        }



        return redirect()->route('historial_programacion');
    }


    function exportProgramacion(Request $request)
    {
        return Excel::download(new detallesExport(), 'ProgramaciónPro.xlsx');
    }
}
