<?php

namespace App\Http\Livewire;

use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Livewire\Component;

class FacturaTerminado extends Component
{
    public $titulo_factura;
    public $mes;
    public $titulo_mes;
    public $titulo_cliente;
    public $num_factura_sistema;
    public $cliente;
    public $numero_factura;
    public $contenedor;
    public $total_cantidad_bultos;
    public $total_total_puros;
    public $total_peso_bruto;
    public $total_peso_neto;
    public $fecha_factura;
    public $detalles_venta;
    public $datos_pendiente;
    public $tipo_factura;
    public $id_pendiente;

    public $descripcion_producto;
    public $cantidad_bultos;
    public $unidades_bultos;
    public $unidades_cajon;
    public $peso_bruto;
    public $peso_neto;


    public function render(){
        $this->total_cantidad_bultos=0;
        $this->total_total_puros=0;
        $this->total_peso_bruto=0;
        $this->total_peso_neto=0;
        
        setlocale(LC_TIME, "spanish");
        $Nueva_Fecha = date("d-m-Y", strtotime($this->fecha_factura));

        $this->titulo_mes = strftime("%B", strtotime($Nueva_Fecha));
        $this->titulo_cliente = $this->cliente;

        $this->datos_pendiente = DB::select(
                'call buscar_pendiente_factura(:orden,"","","")',
                [
                    'orden' => $this->tipo_factura
                ]
            );

            
        $this->detalles_venta = DB::select('call mostrar_detalle_factura(:ordenes)',
        [
            'ordenes' => $this->tipo_factura
        ]);

        for($i=0;$i<count($this->detalles_venta);$i++){
            $this->total_cantidad_bultos += $this->detalles_venta[$i]->cantidad_puros;
            $this->total_total_puros += $this->detalles_venta[$i]->total_tabacos;
            $this->total_peso_bruto += $this->detalles_venta[$i]->total_bruto;
            $this->total_peso_neto += $this->detalles_venta[$i]->total_neto;
        }


        return view('livewire.factura-terminado')->extends('principal')->section('content');
    }



    public function abrir_modal($id_pendiente){

        $pendiente = DB::select(' CALL `traer_descripcion_factura`(:id)',
            [
                'id'=>$id_pendiente
            ]);

        $this->id_pendiente =  $id_pendiente;
        $this->descripcion_producto = $pendiente[0]->producto;
        $this->dispatchBrowserEvent("abrir");
    }

    public function cerrar_modal(){

        $this->dispatchBrowserEvent("cerrar");
    }

  

    public function mount(){

        $this->titulo_factura = "Factura";
        $this->num_factura_sistema = "FA-00-00000000";
        $this->tipo_factura="HON";

        setlocale(LC_TIME, "spanish");
        
        $this->titulo_mes = strftime("%B", $this->mes);
        $this->titulo_cliente = "";
          
        $this->contenedor = "";
        $this->total_cantidad_bultos = 0;
        $this->total_total_puros = 0;
        $this->total_peso_bruto = 0;
        $this->total_peso_neto = 0;
             
          $this->fecha_factura = Carbon::now()->format("Y-m-d");       
    }

    public function insertar_detalle_factura(Request $request){

        DB::select('call insertar_detalle_factura(
                 :id_pendiente
                ,:pa_cantidad_cajas
                ,:pa_peso_bruto
                ,:pa_peso_neto
                ,:pa_cantidad_puros
                ,:pa_unidad
                ,:pa_observaciones)', [

                "id_pendiente" => $request->id_pendi
                ,"pa_cantidad_cajas" => $request->unidades_cajon
                ,"pa_peso_bruto" => $request->peso_bruto
                ,"pa_peso_neto" => $request->peso_neto
                ,"pa_cantidad_puros" => $request->cantidad_bultos
                ,"pa_unidad" => $request->unidades_bultos
                ,"pa_observaciones" => "Sin Facturar"              
            ]);    
            
        return redirect()->route('f_terminado'); 
    }
}
