<div xmlns:wire="http://www.w3.org/1999/xhtml">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hola</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="{{ URL::asset('css/tabla.js') }}"></script>
@livewireStyles
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">


    

    <ul class="nav justify-content-center">
        <li class="nav-item">
            <a style="color:#E5B1E2; font-size:12px;" href="pendiente_empaque"><strong>Pendiente</strong></a>
        </li>
        <li class="nav-item">
            <a style="color:white; font-size:12px;" href="importar_c"><strong>Existencia en bodega</strong></a>
        </li>
        <li class="nav-item">
            <a style="color:white; font-size:12px;" href="inventario_cajas"><strong>Existencia de cajas</strong></a>
        </li>
        <li class="nav-item">
            <a style="color:white; font-size:12px; " href="historial_programacion"><strong>Programaciones</strong></a>
        </li>
    </ul>



    <div class="container" style="max-width:100%; ">
    
    <div class="row" style="text-align:center;">

            <div class="col">
                   <div class="input-group mb-3">


            <span class="input-group-text form-control ">De</span>
            <input type="date" name="fecha_de" id="fecha_de" wire:model="fechade" class="form-control botonprincipal" style="width:200px;" placeholder="Nombre">
            <span class="input-group-text form-control ">Hasta</span>
            <input type="date" name="fecha_hasta" id="fecha_hasta" wire:model="fechahasta" class="form-control mr-sm-2 botonprincipal" style="width:200px;" placeholder="Nombre">

                        <input name="nombre" id="nombre" class="form-control mr-sm-2 botonprincipal" style="width:200px;" placeholder="Nombre" wire:model="nombre">
                  
                <form action="{{Route('exportar_pendiente')}}">
                    <input type="text" value="{{isset($nom)?$nom:null}}" name="nombre" id="nombre" hidden>
                    <input type="date" value="{{isset($fede)?$fede:null}}" name="fecha_de" id="fecha_de" hidden>
                    <input type="date" value="{{isset($feha)?$feha:null}}" name="fecha_hasta" id="fecha_hasta" hidden>
                </form>
            
                <form wire:submit.prevent="insertar_detalle_provicional()">
                      @csrf
                      <button class="mr-sm-2 botonprincipal" style="width:200px;">Agregar Programación </button>
                   </form>
         
                   <a  href="/detalles_programacion"> <button class="mr-sm-2 botonprincipal" style="width:200px;"> Ver</button></a> 
           
   </div>
</div>
</div>











    <div class="panel-body" style="padding:0px;">
            <div style="width:100%; padding-left:0px;   font-size:10px;   overflow-x: display; overflow-y: auto;
     height:450px;">
            @csrf
            <table class="table table-light" style="font-size:10px;">
                <thead>
                    <tr>
                        <th style="width:100px;">CATEGORIA</th>
                        <th>ITEM</th>
                        <th>ORDEN DEL SISTEMA</th>
                        <th>OBSERVACÓN</th>
                        <th>PRESENTACIÓN</th>
                        <th>MES</th>
                        <th>ORDEN</th>
                        <th style="width:100px;">MARCA</th>
                        <th>VITOLA</th>
                        <th>NOMBRE</th>
                        <th>CAPA</th>
                        <th>TIPO DE EMPAQUE</th>
                        <th>CANT. CAJAS</th>
                        <th>ANILLO</th>
                        <th>CELLO</th>
                        <th>UPC</th>
                        <th>PENDIENTE</th>
                        <th>SALDO</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($datos_pendiente_empaque as $datos)      
                    <tr>
                        <td style="width:100px; max-width: 400px;overflow-x:auto;">{{$datos->categoria}}</td>
                        <td>{{$datos->item}}</td>
                        <td>{{$datos->orden_del_sitema}}</td>
                        <td>{{$datos->observacion}}</td>
                        <td>{{$datos->presentacion}}</td>
                        <td>{{$datos->mes}}</td>
                        <td>{{$datos->orden}}</td>
                        <td>{{$datos->marca}}</td>
                        <td>{{$datos->vitola}}</td>
                        <td>{{$datos->nombre}}</td>
                        <td>{{$datos->capa}}</td>
                        <td>{{$datos->tipo_empaque}}</td>
                        <td>{{$datos->cant_cajas}}</td>
                        <td>{{$datos->anillo}}</td>
                        <td>{{$datos->cello}}</td>
                        <td>{{$datos->upc}}</td>
                        <td>{{$datos->pendiente_empaque}}</td>
                        <td>{{$datos->saldo}}</td>
                    </tr>

                    @endforeach
            </table>
        </div>
    </div>
</div>
</div>



<script type="text/javascript">
    $(document).ready(function () {

        $.ajaxSetup({
            headers: {
                'X-CSRF-Token': $("input[name=_token]").val()
            }
        });

        $('#editable').Tabledit({
            url: '{{ route("tabledit.action") }}',
            method: 'POST',
            dataType: "json",
            columns: {
                identifier: [0, 'id'],
                editable: [
                    [1, 'first_name'],
                    [2, 'last_name'],
                    [3, 'gender']
                ]
            },
            restoreButton: false,

            onSuccess: function (data, textStatus, jqXHR) {
                if (data.action == 'delete') {
                    $('#' + data.id).remove();
                }
            }

        });

    });
</script>
</div>
