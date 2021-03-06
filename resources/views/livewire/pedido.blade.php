<div xmlns:wire="http://www.w3.org/1999/xhtml">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
    @livewireStyles
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">


    <ul class="nav justify-content-center">
        <li class="nav-item">
            <a style="color:white; font-size:12px;" href="pendiente"><strong>Pendiente</strong></a>
        </li>
        <li class="nav-item">
            <a style="color:#E5B1E2; font-size:12px;" href="import_excel"><strong>Importar pedido</strong></a>
        </li>
        <li class="nav-item">
            <a style="color:white; font-size:12px;" href="pendiente_salida"><strong>Reporte</strong></a>
        </li>
    </ul>

    <br>

    <div class="container" style="max-width:100%;">

        <div class="row" style="text-align:center; padding-left: 15px">
            <div class="col">
                <div class="input-group" style="max-width:100%;">

                    <form method="post" enctype="multipart/form-data" action="{{ url('/importar_pedido') }}"
                        class="form-inline">
                        @csrf
                        <input type="file" name="select_file" id="select_file" class="form-control   mr-sm-2 "
                            style="width:250px;" required />
                        <input type="submit" name="upload" style="width:130px;" class=" botonprincipal mr-sm-2 "
                            value="Importar">
                    </form>



                    @if (count($nuevos) == 0){
                    <form action="{{Route('pendiente_insertar')}}" method="POST">
                        @csrf
                        <input type="date" value="" name="fecha" id="fecha"
                            style="width: 120px; color:black ;text-align:center;" class=" form-control   mr-sm-2 "
                            required>
                        <input type="number" value="" name="sistema" id="sistema"
                            style="width: 60px; color:black ;text-align:center;" class=" form-control   mr-sm-2 "
                            required>
                        <button onclick="agregarpendiente()" style="width:160px;"
                            class="botonprincipal mr-sm-2 ">Agregar a pendiente</button>
                    </form>
                    }
                    @endif


                    <button data-toggle="modal" style="width:30px;" class=" botonprincipal mr-sm-2 "
                        data-target="#modal_actualizar">
                        <abbr title="Agregar nuevo pedido">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                class="bi bi-plus-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
                                <path
                                    d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z" />
                            </svg>
                        </abbr>
                    </button>

                    <button wire:click="vaciar_import_excel()" style="width:30px;" class=" botonprincipal mr-sm-2 ">
                        <abbr title="Vacia la tabla">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                class="bi bi-folder-x" viewBox="0 0 16 16">
                                <path
                                    d="M.54 3.87.5 3a2 2 0 0 1 2-2h3.672a2 2 0 0 1 1.414.586l.828.828A2 2 0 0 0 9.828 3h3.982a2 2 0 0 1 1.992 2.181L15.546 8H14.54l.265-2.91A1 1 0 0 0 13.81 4H2.19a1 1 0 0 0-.996 1.09l.637 7a1 1 0 0 0 .995.91H9v1H2.826a2 2 0 0 1-1.991-1.819l-.637-7a1.99 1.99 0 0 1 .342-1.31zm6.339-1.577A1 1 0 0 0 6.172 2H2.5a1 1 0 0 0-1 .981l.006.139C1.72 3.042 1.95 3 2.19 3h5.396l-.707-.707z" />
                                <path
                                    d="M11.854 10.146a.5.5 0 0 0-.707.708L12.293 12l-1.146 1.146a.5.5 0 0 0 .707.708L13 12.707l1.146 1.147a.5.5 0 0 0 .708-.708L13.707 12l1.147-1.146a.5.5 0 0 0-.707-.708L13 11.293l-1.146-1.147z" />
                            </svg>
                        </abbr>
                    </button>

                    @if (count($nuevos) > 0){
                    <button wire:click="modal_productos_nuevos()" style="width:30px;" class=" botonprincipal mr-sm-2 ">
                        <abbr title="Nuevos Productos">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                class="bi bi-lightning-charge" viewBox="0 0 16 16">
                                <path
                                    d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09zM4.157 8.5H7a.5.5 0 0 1 .478.647L6.11 13.59l5.732-6.09H9a.5.5 0 0 1-.478-.647L9.89 2.41 4.157 8.5z" />
                            </svg>
                        </abbr>
                    </button>
                    }

                    @endif
                </div>
            </div>




        </div>
        <div class="col">
            <div class="input-group mb-3">
                <input class=" form-control  mr-sm-2" placeholder="B??squeda por Item" wire:model="b_item">
                <input class=" form-control  mr-sm-2" placeholder="B??squeda por Categoria" wire:model="b_categoria">
                <input class=" form-control  mr-sm-2" placeholder="B??squeda por Orden" wire:model="b_orden">

            </div>

        </div>

        <form action="{{Route('nuevo_pedido')}}" method="POST" id="nuevo_pedido" name="nuevo_pedido">
            <div class="modal fade" role="dialog" id="modal_actualizar" data-backdrop="static" data-keyboard="false"
                tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true"
                style="opacity:.9;background:#212529;width=800px;">
                <div class="modal-dialog modal-dialog-centered modal-lg"
                    style="opacity:.9;background:#212529;width=80%">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 id="staticBackdropLabel"><strong>Agregar a la orden el producto: </strong><span
                                    id="titulo" name="titulo"></span></h5>
                        </div>
                        @csrf


                        <div class="modal-body">

                            <div class="row">

                                <div class="mb-6 col">
                                    <label for="txt_figuraytipo" class="form-label">Item</label>
                                    <input name="item" id="item" class="form-control" type="text" autocomplete="off">
                                </div>
                                <div class="mb-6 col">
                                    <label for="txt_figuraytipo" class="form-label">Orden</label>
                                    <input name="orden" id="orden" class="form-control" type="text" autocomplete="off">
                                </div>



                            </div>
                            <div class="row">

                                <input name="id_pendientea" id="id_pendientea" value="" hidden />

                                <input name="itema" id="itema" value="" hidden />
                                <div class="mb-3 col">
                                    <label for="txt_figuraytipo" class="form-label">Cant. Paquetes</label>
                                    <input name="paquetes" id="paquetes" class="form-control" \ type="text"
                                        autocomplete="off">
                                </div>
                                <div class="mb-3 col">
                                    <label for="txt_figuraytipo" class="form-label">Unidades</label>
                                    <input name="unidades" id="unidades" class="form-control" type="text"
                                        autocomplete="off">
                                </div>

                                <div class="mb-3 col">
                                    <label for="txt_figuraytipo" class="form-label">Categoria</label>

                                    <select class="form-control" name="categoria" id="categoria"
                                        placeholder="Ingresa figura y tipo" style="overflow-y: scroll; height:30px;"
                                        required>
                                        <option value="1">NEW ROLL</option>
                                        <option value="2">CATALOGO</option>
                                        <option value="3">TAKE FROM EXISTING INVENT</option>
                                        <option value="4">INTERNATIONAL SALES</option>

                                    </select>
                                </div>

                            </div>
                        </div>

                        <div class="modal-footer">
                            <button class="bmodal_no" data-dismiss="modal">
                                <span>Cancelar</span>
                            </button>
                            <button type="submit" class="bmodal_yes">
                                <span>A??adir</span>
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </form>



        <div class="panel-body" style="padding:0px;">
            <div style="width:100%; padding-left:0px;   font-size:10px;   overflow-x: display; overflow-y: auto;
     height:70%;">
                @csrf
                <table class="table table-light" style="font-size:10px; ">
                    <thead>
                        <tr style="font-size:16px; text-align:center;">
                            <th style=" text-align:center;">N#</th>
                            <th style=" text-align:center;">Categoria</th>
                            <th style=" text-align:center;">RP Item#</th>
                            <th style=" text-align:center;">Paquetes</th>
                            <th style=" text-align:center;">Item Description</th>
                            <th style=" text-align:center;">Sticks</th>
                            <th style=" text-align:center;">Units</th>
                            <th style=" text-align:center;">PO#</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $count = 1; ?>

                        @foreach($pedido_completo as $pedido)
                        <tr>
                            <td>{{$count}}</td>
                            <td>{{$pedido->categorias}}</td>
                            <td>{{$pedido->item}}</td>
                            <td>{{$pedido->cant_paquetes}}</td>
                            <td>{{$pedido->descripcion}}</td>
                            <td>{{$pedido->unidades*$pedido->cant_paquetes}}</td>
                            <td>{{$pedido->unidades}}</td>
                            <td>{{$pedido->numero_orden}}</td>

                        </tr>
                        <?php $count++; ?>
                        @endforeach
                    </tbody>
                </table>


            </div>

            <br>
            <div class="col-sm-9">
            </div>
            <div class="col-sm-1">
                <span style="width:50px;" class="form-control input-group-text">Total</span>
            </div>
            <div class="col-sm-2">
                <input style="width:150px;" type="text" class="form-control" wire:model="total_puros">
            </div>
        </div>




    </div>





    <div class="modal fade" id="datos_faltantes" data-backdrop="static" data-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true" style="opacity:.9;background:#212529;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Eliminar Usuario </h5>
                </div>

                <div class="modal-body">
                    ??Est??s seguro que quieres eliminar a <strong><input value="" id="txt_usuarioE" name="txt_usuarioE"
                            style="border:none;text-align:center;" readonly></strong>?
                    <input name="id_usuarioE" id="id_usuarioE" value="" hidden />
                </div>

                <div class="modal-footer">
                    <button class="bmodal_no" data-dismiss="modal">
                        <span>Cancelar</span>
                    </button>
                    <button type="submit" class="bmodal_yes">
                        <span>Eliminar</span>
                    </button>
                </div>

            </div>
        </div>
    </div>






    <script type="text/javascript">
        function agregarpendiente() {

            var datas = '<?php echo json_encode($verificar);?>';
            var data = JSON.parse(datas);





            if (data.length > 0) {
                var bool = confirm(
                    'Necesitas agregar los productos correspondientes a los siguientes item: \n @foreach($verificar as $v) \n{{$v->item}} @endforeach '
                );
                if (bool) {
                    location.href = "/productos";
                }
                event.preventDefault();


            } else {
                theForm.addEventListener('submit', function (event) {});
            }
        }
    </script>










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



    <div class="modal fade" id="productos_faltantes" data-backdrop="static" data-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true" style="opacity:.9;background:#212529;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h6>Estos productos no existen en la base de datos: </h6>
                </div>

                <div class="modal-body">

                    <ul>
                        @foreach ($nuevos as $n)
                        <li>{{$n->categoria." ".$n->item." ".$n->detalles}}</li>
                        @endforeach

                    </ul>


                </div>

                <div class="modal-footer">
                    <button class="bmodal_no" wire:click="agregar_productos()">
                        <span>Agregar Productos</span>
                    </button>
                    <button wire:click="agregar_productos_exporta()" class="bmodal_yes">
                        <span>Exportar</span>
                    </button>
                </div>

            </div>
        </div>
    </div>

</div>
