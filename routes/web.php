<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ImportExcelController;
use App\Http\Controllers\VehicleController;
use App\Http\Controllers\PedidoController;
use App\Http\Controllers\CapaProductoController;
use App\Http\Controllers\clase_producto;
use App\Http\Controllers\PendienteController;
use App\Http\Controllers\programacion;
use App\Http\Controllers\tabla_existencia;
use App\Http\Livewire\DatosProductos;
use App\Http\Livewire\FacturaTerminado;
use App\Http\Livewire\Productos;
use App\Http\Livewire\PendienteEmpaque;
use App\Http\Livewire\Pendiente;
use App\Http\Livewire\ProductosTerminados;
use Illuminate\Support\Facades\Auth;
use App\Http\Livewire\ImportarProductoBodega;
use App\Http\Livewire\InventarioCajas;
use App\Http\Livewire\HistorialProgramacion;
use App\Http\Livewire\DetalleProgramacion;



/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

 Route::get('/import_excel', [ImportExcelController::class, 'index'])->name('import_excel');


Route::post('/import', [VehicleController::class, 'import']);



Route::post('/importar_pedido', [PedidoController::class, 'import']);
Route::get('/importar_pedido', [PedidoController::class, 'import']);



Route::get('/productos', Productos::class)->name('productos');
Route::post('/productos', Productos::class)->name('productos');



Route::get('/pendiente_empaque', PendienteEmpaque::class)->name('pendiente_empaque');
Route::post('/pendiente_empaque', PendienteEmpaque::class)->name('pendiente_empaque');


Route::get('/insertar_detalles', [PendienteEmpaque::class, 'insertar_detalle_provicional'])->name('insertar_detalles');
Route::post('/insertar_detalles', [PendienteEmpaque::class, 'insertar_detalle_provicional'])->name('insertar_detalles');

Route::get('/insertar_productos', [Productos::class, 'insertar_clase'])->name('nuevo_producto');
Route::post('/insertar_productos', [Productos::class, 'insertar_clase'])->name('nuevo_producto');



Route::get('/actualizar_productos', [Productos::class, 'actualizar_clase'])->name('actualizar_producto');
Route::post('/actualizar_productos', [Productos::class, 'actualizar_clase'])->name('actualizar_producto');


Route::get('/insertar_detalle_productos', [Productos::class, 'insertar_detalle_clase'])->name('detalle');
Route::post('/insertar_detalle_productos', [Productos::class, 'insertar_detalle_clase'])->name('detalle');


Route::get('/mostrar_detalle_productos', [clase_producto::class, 'insertar_detalle_clase'])->name('detalle_producto');
Route::post('/mostrar_detalle_productos', [clase_producto::class, 'insertar_detalle_clase'])->name('detalle_producto');

Route::post('/importar_clase', [CapaProductoController::class, 'import']);
Route::get('/importar_clase', [CapaProductoController::class, 'import']);


Route::get('/pendiente', Pendiente::class)->name('pendiente');
Route::post('/pendiente', Pendiente::class)->name('pendiente');


Route::get('/inventario_cajas', InventarioCajas::class)->name('inventario_cajas');
Route::post('/inventario_cajas', InventarioCajas::class)->name('inventario_cajas');


Route::get('/importar_c', ImportarProductoBodega::class)->name('importar_ca');
Route::post('/importar_c', ImportarProductoBodega::class)->name('importar_ca');


Route::get('/historial_programacion', HistorialProgramacion::class)->name('historial_programacion');
Route::post('/historial_programacion', HistorialProgramacion::class)->name('historial_programacion');


Route::get('/detalles_programacion', DetalleProgramacion::class)->name('detalles_programacion');
Route::post('/detalles_programacion', DetalleProgramacion::class)->name('detalles_programacion');



Route::get('/pedido_buscar', [PedidoController::class, 'buscar'])->name('buscar_pedido');
Route::post('/pedido_buscar', [PedidoController::class, 'buscar'])->name('buscar_pedido');


Route::get('/programacion', [programacion::class, 'index'])->name('programacion');
Route::post('/programacion', [programacion::class, 'index'])->name('programacion');



Route::get('/producto', [tabla_existencia::class, 'import'])->name('codigo');
Route::post('/producto', [tabla_existencia::class, 'import'])->name('codigo');


Route::get('/datos_producto', DatosProductos::class)->name('datos_producto');



// INSERTAR DATOS ADICIONALES DE LOS PRODUCTOS

Route::get('/insertar_marca', [DatosProductos::class, 'insertar_marca'])->name('insertar_marca');
Route::post('/insertar_marca', [DatosProductos::class, 'insertar_marca'])->name('insertar_marca');


Route::get('/insertar_nombre', [DatosProductos::class, 'insertar_nombre'])->name('insertar_nombre');
Route::post('/insertar_nombre', [DatosProductos::class, 'insertar_nombre'])->name('insertar_nombre');

Route::get('/insertar_vitola', [DatosProductos::class, 'insertar_vitola'])->name('insertar_vitola');
Route::post('/insertar_vitola', [DatosProductos::class, 'insertar_vitola'])->name('insertar_vitola');

Route::get('/insertar_tipo', [DatosProductos::class, 'insertar_tipo'])->name('insertar_tipo');
Route::post('/insertar_tipo', [DatosProductos::class, 'insertar_tipo'])->name('insertar_tipo');

Route::get('/insertar_capa', [DatosProductos::class, 'insertar_capa'])->name('insertar_capa');
Route::post('/insertar_capa', [DatosProductos::class, 'insertar_capa'])->name('insertar_capa');






Route::get('/welcome', function () {
    return view('welcome');
});


Auth::routes();
Route::get('/logout', [App\Http\Controllers\LoginController::class, 'logout'])->name('logout');

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

//rutas melvin
Route::get('/', [App\Http\Controllers\TableditController::class, 'index'])->name('tabla');

Route::post('/', [App\Http\Controllers\TableditController::class, 'buscar'])->name('buscar');
Route::post('tabledit/action', [App\Http\Controllers\TableditController::class, 'action'])->name('tabledit.action');
Route::get('/principal', [App\Http\Controllers\Principal::class, 'index'])->name('principal');


//USERS
Route::post('/usuarios/d',[App\Http\Controllers\Users::class, 'update' ])->name('actualizar_usuario');
Route::post('/usuarios/a',[App\Http\Controllers\Users::class, 'destroy' ])->name('eliminar_usuario');
Route::post('usuarios/contra', [App\Http\Controllers\Users::class,'update_contrasenia'])->name('actualizar_usuario_contrasenia');
Route::get('/usuarios',[App\Http\Controllers\Users::class, 'index' ])->name('usuarios');


//cajas

Route::get('/index_importar_cajas', [App\Http\Controllers\CajasController::class, 'index_importar'])->name('index_importar_cajas');
Route::get('/index_bodega', [App\Http\Controllers\CajasController::class, 'index_bodega'])->name('index_bodega');
Route::get('/index_lista_cajas', [App\Http\Controllers\CajasController::class, 'index_lista'])->name('index_lista_cajas');
Route::post('/editaryeliminarlista', [App\Http\Controllers\CajasController::class, 'editaryeliminarlista'])->name('editaryeliminarlista');


Route::post('/buscar_lista_cajas', [App\Http\Controllers\CajasController::class, 'buscar_lista_cajas'])->name('buscar_lista_cajas');
Route::post('/agregar_lista_caja', [App\Http\Controllers\CajasController::class, 'agregar_lista_caja'])->name('agregar_lista_caja');

Route::post('/importar_cajas', [App\Http\Controllers\CajasController::class, 'import'])->name('importar_cajas');
Route::get('/importar_cajas', [App\Http\Controllers\CajasController::class, 'import'])->name('importar_cajas');
Route::get('/anadir_inventario', [App\Http\Controllers\CajasController::class, 'anadir_inventario'])->name('anadir_inventario');

Route::post('/importar_inv_cajas', [App\Http\Controllers\CajasController::class, 'importinvcajas'])->name('importar_inv_cajas');
Route::get('/importar_inv_cajas', [App\Http\Controllers\CajasController::class, 'importinvcajas'])->name('importar_inv_cajas');


Route::get('/exportar_pendiente', [Pendiente::class, 'exportPendiente'])->name('exportar_pendiente');


//Produtco terminado y Facturacion
Route::get('/productos_terminado', ProductosTerminados::class)->name('p_terminado');

Route::get('/factura_terminados', FacturaTerminado::class)->name('f_terminado');