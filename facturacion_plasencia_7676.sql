-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 18-06-2021 a las 16:20:18
-- Versión del servidor: 5.7.24
-- Versión de PHP: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `facturacion_plasencia`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `Actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Actualizar` (IN `id_pro` INT, IN `saldo_programacion` DECIMAL(10,2), IN `id_pendiente` INT, IN `saldo_pendiente` DECIMAL(10,2))  BEGIN

UPDATE detalle_programacion SET detalle_programacion.saldo = saldo_programacion WHERE detalle_programacion.id_detalle_programacion =
id_pro;

UPDATE pendiente_empaque SET pendiente_empaque.saldo =  pendiente_empaque.saldo + saldo_pendiente WHERE pendiente_empaque.id_pendiente
= id_pendiente;
END$$

DROP PROCEDURE IF EXISTS `actualizar_capa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_capa` (IN `pa_id` VARCHAR(50), IN `pa_capa` VARCHAR(50))  BEGIN
  UPDATE capa_productos
                SET
                      capa_productos.capa = pa_capa

                WHERE capa_productos.id_capa= pa_id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_contrasenia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_contrasenia` (IN `pa_id` INT, IN `pa_email` VARCHAR(50), IN `pa_password` VARCHAR(200))  BEGIN
             UPDATE users
                SET
                      users.email = pa_email,
                      users.password = pa_password


                WHERE users.id = pa_id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_detalle_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_detalle_factura` (IN `pa_id_pendiente` INT, IN `pa_cantidad_cajas` INT, IN `pa_peso_bruto` INT, IN `pa_peso_neto` INT, IN `pa_cantidad_puros` INT, IN `pa_unidad` INT)  BEGIN

	UPDATE detalle_factura SET
		detalle_factura.cantidad_cajas =pa_cantidad_cajas,
		detalle_factura.peso_bruto =pa_peso_bruto,
		detalle_factura.peso_neto =pa_peso_neto,
		detalle_factura.cantidad_puros =pa_cantidad_puros,
		detalle_factura.unidad =pa_unidad
   WHERE detalle_factura.id_detalle = pa_id_pendiente;



END$$

DROP PROCEDURE IF EXISTS `actualizar_detalle_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_detalle_pendiente` (IN `id_pro` INT, IN `id_pen` INT, IN `saldo` DECIMAL(10,2), IN `saldo_pendiente` DECIMAL(10,2), IN `cant` INT)  BEGIN


UPDATE pendiente_empaque SET pendiente_empaque.saldo = pendiente_empaque.saldo + saldo_pendiente WHERE pendiente_empaque.id_pendiente =
id_pen;

UPDATE detalle_programacion SET detalle_programacion.saldo = saldo, detalle_programacion.cant_cajas =
cant WHERE detalle_programacion.id_detalle_programacion = id_pro;


UPDATE lista_cajas SET lista_cajas.existencia = cant
WHERE (SELECT (SELECT  clase_productos.codigo_caja FROM clase_productos WHERE
			  clase_productos.item = pendiente_empaque.item  ) AS caja
 FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pen) = lista_cajas.codigo;


END$$

DROP PROCEDURE IF EXISTS `actualizar_factura_venta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_factura_venta` (IN `pa_num_factura` VARCHAR(50), IN `pa_cliente` VARCHAR(50), IN `pa_contenedor` VARCHAR(50), IN `pa_id` INT)  BEGIN
   UPDATE factura_terminados SET factura_terminados.cliente = pa_cliente,
   										factura_terminados.numero_factura = pa_num_factura,
   										factura_terminados.contenedor = pa_contenedor
   		WHERE factura_terminados.id = pa_id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_marca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_marca` (IN `pa_id` VARCHAR(50), IN `pa_marca` VARCHAR(50))  BEGIN
  UPDATE marca_productos
                SET
                      marca_productos.marca = pa_marca

                WHERE marca_productos.id_marca = pa_id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_nombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_nombre` (IN `pa_id` VARCHAR(50), IN `pa_nombre` VARCHAR(50))  BEGIN
  UPDATE nombre_productos
                SET
                      nombre_productos.nombre = pa_nombre

                WHERE nombre_productos.id_nombre = pa_id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_pendientes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_pendientes` (IN `id` INT, IN `item` VARCHAR(50), IN `orden_sistema` VARCHAR(50), IN `observeacion` VARCHAR(50), IN `presentacion` VARCHAR(50), IN `pendient` VARCHAR(50), IN `seriep` VARCHAR(50), IN `precio` VARCHAR(50), IN `orden` VARCHAR(50))  BEGIN

UPDATE pendiente set pendiente.orden_del_sitema = orden_sistema,
pendiente.observacion = observeacion, pendiente.presentacion = presentacion,

 pendiente.pendiente = pendient,
 pendiente.serie_precio = seriep,
 pendiente.precio = precio,
 pendiente.saldo = pendient,
 pendiente.orden= orden
 WHERE pendiente.id_pendiente = id;


 UPDATE pendiente_empaque SET
 pendiente_empaque.orden_del_sitema = orden_sistema,
 pendiente_empaque.observacion = observeacion,
 pendiente_empaque.presentacion = presentacion,
 pendiente_empaque.pendiente = pendient,
 pendiente_empaque.saldo = pendient,
 pendiente_empaque.orden = orden
 WHERE pendiente_empaque.id_pendiente_pedido = id ;


 UPDATE clase_productos SET clase_productos.presentacion = presentacion, clase_productos.codigo_precio =seriep,
 clase_productos.precio = precio
 WHERE clase_productos.item = item;

 end$$

DROP PROCEDURE IF EXISTS `actualizar_pendiente_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_pendiente_empaque` (IN `id` INT, IN `saldo` VARCHAR(50))  BEGIN
UPDATE pendiente_empaque SET pendiente_empaque.saldo = saldo
WHERE pendiente_empaque.id_pendiente = id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_pendiente_empaque_sampler`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_pendiente_empaque_sampler` (IN `marca` INT, IN `nombre` INT, IN `vitola` INT, IN `capa` INT, IN `tipo_empaque` INT, IN `item` INT)  BEGIN
 UPDATE pendiente_empaque SET
  pendiente_empaque.marca= marca,
  pendiente_empaque.nombre = nombre ,
 pendiente_empaque.capa = capa,
 pendiente_empaque.vitola = vitola,
 pendiente_empaque.tipo_empaque = tipo_empaque
 WHERE pendiente_empaque.id_pendiente = item;
END$$

DROP PROCEDURE IF EXISTS `actualizar_pendiente_saldo_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_pendiente_saldo_factura` (IN `id` INT, IN `pa_saldo` INT)  BEGIN
   UPDATE pendiente SET pendiente.saldo =  pendiente.saldo - pa_saldo  WHERE pendiente.id_pendiente = id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_pendiente_sampler`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_pendiente_sampler` (IN `marca` INT, IN `nombre` INT, IN `vitola` INT, IN `capa` INT, IN `tipo_empaque` INT, IN `item` INT)  BEGIN
 UPDATE pendiente SET
  pendiente.marca= marca,
  pendiente.nombre = nombre ,
 pendiente.capa = capa,
 pendiente.vitola = vitola,
 pendiente.tipo_empaque = tipo_empaque
 WHERE pendiente.id_pendiente = item;
END$$

DROP PROCEDURE IF EXISTS `actualizar_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_productos` (IN `id` INT, IN `item` VARCHAR(50), IN `cod_producto` VARCHAR(50), IN `cod_caja` VARCHAR(50), IN `cod_precio` VARCHAR(50), IN `pa_precio` VARCHAR(50), IN `capa` VARCHAR(50), IN `vitola` VARCHAR(50), IN `nombre` VARCHAR(50), IN `marca` VARCHAR(50), IN `cello` VARCHAR(50), IN `anillo` VARCHAR(50), IN `upc` VARCHAR(50), IN `tipo_empaque` VARCHAR(50), IN `presentacion` VARCHAR(50), IN `sampler` VARCHAR(50), IN `descripcion` VARCHAR(100))  BEGIN
DECLARE icapa INT;
DECLARE imarca INT;
DECLARE inombre INT;
DECLARE ivitola INT;
DECLARE icello INT;
DECLARE itipo INT;


SET ivitola = (SELECT vitola_productos.id_vitola FROM  vitola_productos WHERE vitola_productos.vitola = vitola);

SET icapa = (SELECT capa_productos.id_capa FROM  capa_productos WHERE capa_productos.capa = capa);

SET imarca = (SELECT marca_productos.id_marca FROM marca_productos WHERE marca_productos.marca = marca);
SET inombre = (SELECT nombre_productos.id_nombre FROM nombre_productos WHERE nombre_productos.nombre = nombre);
SET icello = (SELECT cellos.id_cello FROM cellos WHERE cellos.cello = cello AND cellos.anillo = anillo AND cellos.upc= upc);
SET itipo =  (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = tipo_empaque);

UPDATE clase_productos SET clase_productos.item = item,clase_productos.codigo_producto = cod_producto,
clase_productos.codigo_caja=cod_caja,clase_productos.codigo_precio = cod_precio,
clase_productos.precio = pa_precio,
clase_productos.id_capa = icapa,clase_productos.id_vitola = ivitola,
 clase_productos.id_nombre = inombre,clase_productos.id_marca = imarca,
 clase_productos.id_cello = icello,
clase_productos.id_tipo_empaque = itipo, clase_productos.presentacion = presentacion,
clase_productos.sampler = sampler,
clase_productos.descripcion_sampler= descripcion
WHERE clase_productos.id_producto = id;


END$$

DROP PROCEDURE IF EXISTS `actualizar_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_programacion` (IN `id_pro` INT, IN `con` VARCHAR(50))  BEGIN

UPDATE prograamacion SET prograamacion.mes_contenedor = con WHERE prograamacion.id = id_pro;

END$$

DROP PROCEDURE IF EXISTS `actualizar_saldo_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_saldo_programacion` (IN `id_detalle` INT, IN `saldo` DECIMAL(8,2), IN `cant` INT, IN `id_pendiente` INT)  BEGIN




UPDATE detalle_programacion_temporal SET detalle_programacion_temporal.saldo = saldo,
detalle_programacion_temporal.cant_cajas = cant


WHERE detalle_programacion_temporal.id_detalle_programacion = id_detalle;


UPDATE lista_cajas SET lista_cajas.existencia = cant
WHERE (SELECT (SELECT  clase_productos.codigo_caja FROM clase_productos WHERE
			  clase_productos.item = pendiente_empaque.item  ) AS caja
 FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente) = lista_cajas.codigo;



END$$

DROP PROCEDURE IF EXISTS `actualizar_tipo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_tipo` (IN `pa_id` VARCHAR(50), IN `pa_tipo` VARCHAR(50))  BEGIN
  UPDATE tipo_empaques
                SET
                      tipo_empaques.tipo_empaque = pa_tipo

                WHERE tipo_empaques.id_tipo_empaque = pa_id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_usuarios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_usuarios` (IN `pa_id` INT, IN `pa_codigo` INT, IN `pa_nombre` VARCHAR(50), IN `pa_rol` INT)  BEGIN
             UPDATE users
                SET
                      users.name = pa_nombre,
                      users.codigo = pa_codigo,
                      users.rol =pa_rol


                WHERE users.id = pa_id;
END$$

DROP PROCEDURE IF EXISTS `actualizar_vitola`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_vitola` (IN `pa_id` VARCHAR(50), IN `pa_vitola` VARCHAR(50))  BEGIN
  UPDATE vitola_productos
                SET
                      vitola_productos.vitola = pa_vitola

                WHERE vitola_productos.id_vitola = pa_id;
END$$

DROP PROCEDURE IF EXISTS `agregar_lista_caja`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_lista_caja` (IN `pa_codigo` VARCHAR(50), IN `pa_producto` VARCHAR(255), IN `pa_marca` VARCHAR(50), IN `pa_existencia` INT)  BEGIN
INSERT INTO lista_cajas (lista_cajas.codigo,lista_cajas.productoServicio,lista_cajas.marca,lista_cajas.existencia)
 VALUES (pa_codigo,pa_producto,pa_marca,pa_existencia);
END$$

DROP PROCEDURE IF EXISTS `anadir_cajas_a_inventario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `anadir_cajas_a_inventario` (IN `pa_codigo` VARCHAR(50), IN `pa_cantidad` INT)  BEGIN
      UPDATE lista_cajas
		 SET lista_cajas.existencia = lista_cajas.existencia + pa_cantidad
		 WHERE
     lista_cajas.codigo = pa_codigo;

END$$

DROP PROCEDURE IF EXISTS `borrar_datos_existencia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_datos_existencia` ()  BEGIN
 DELETE FROM importar_existencias;
END$$

DROP PROCEDURE IF EXISTS `borrar_pendientes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_pendientes` (IN `id` INT)  BEGIN

DELETE FROM pendiente WHERE pendiente.id_pendiente = id;
DELETE FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente_pedido = id;

END$$

DROP PROCEDURE IF EXISTS `buscar_capa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_capa` (IN `capa` VARCHAR(50))  BEGIN

if capa = "" then

SELECT * FROM capa_productos ;
ELSE

SELECT * FROM capa_productos WHERE capa_productos.capa LIKE CONCAT("%",capa,"%");
END if;
END$$

DROP PROCEDURE IF EXISTS `buscar_capa_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_capa_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT (SELECT (UPPER(((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = pendiente_empaque.capa))))) AS capa
FROM pendiente_empaque

	where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT (SELECT (UPPER(((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = pendiente_empaque.capa))))) AS capa
FROM pendiente_empaque;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_capa_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_capa_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT (SELECT (UPPER(((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = pendiente.capa))))) AS capa
FROM pendiente

	where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT (SELECT (UPPER(((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = pendiente.capa))))) AS capa
FROM pendiente ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_existencia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_existencia` (IN `busqueda` VARCHAR(50))  BEGIN

 if busqueda = ""  then
  SELECT importar_existencias.id , importar_existencias.codigo_producto ,
importar_existencias.marca,importar_existencias.nombre, importar_existencias.vitola,importar_existencias.capa
, importar_existencias.total
from  importar_existencias;

ELSE

  SELECT importar_existencias.id , importar_existencias.codigo_producto ,
importar_existencias.marca,importar_existencias.nombre, importar_existencias.vitola,importar_existencias.capa
, importar_existencias.total
from  importar_existencias
WHERE (importar_existencias.marca LIKE CONCAT("%",busqueda,"%") || importar_existencias.nombre LIKE CONCAT("%",busqueda,"%") ||
importar_existencias.capa LIKE CONCAT("%",busqueda,"%") );
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_fechas_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_fechas_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT mes
FROM pendiente
	where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT mes
FROM pendiente ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_fecha_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_fecha_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT mes
FROM pendiente_empaque
	where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT mes
FROM pendiente_empaque ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_hons_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_hons_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

	SELECT DISTINCT pendiente_empaque.orden
FROM pendiente_empaque
	where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT pendiente_empaque.orden
FROM pendiente_empaque ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_hons_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_hons_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

	SELECT DISTINCT pendiente.orden
FROM pendiente
	where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT pendiente.orden
FROM pendiente ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_item_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_item_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT item
FROM pendiente_empaque
	where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT item
FROM pendiente_empaque ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_item_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_item_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then


SELECT DISTINCT item AS item
FROM pendiente
	where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;

ELSE
SELECT DISTINCT item AS item
FROM pendiente ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_listadecajas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_listadecajas` (IN `buscar` VARCHAR(50))  BEGIN
if buscar=""then
 SELECT lista_cajas.id,lista_cajas.codigo,lista_cajas.productoServicio,lista_cajas.marca, lista_cajas.existencia FROM lista_cajas;

 else

 SELECT lista_cajas.id,lista_cajas.codigo,lista_cajas.productoServicio,lista_cajas.marca, lista_cajas.existencia
  FROM lista_cajas
 WHERE lista_cajas.codigo LIKE CONCAT("%",buscar,"%") or lista_cajas.productoServicio LIKE CONCAT("%",buscar,"%")
 or lista_cajas.marca LIKE CONCAT("%",buscar,"%");

 END if;
END$$

DROP PROCEDURE IF EXISTS `buscar_lista_cajas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_lista_cajas` (IN `pa_nombre` VARCHAR(50))  BEGIN
SELECT lista_cajas.codigo,lista_cajas.productoServicio,lista_cajas.marca, lista_cajas.id,lista_cajas.existencia
FROM lista_cajas
WHERE lista_cajas.codigo LIKE CONCAT("%",pa_nombre,"%") OR
lista_cajas.productoServicio LIKE CONCAT("%",pa_nombre,"%") OR
lista_cajas.marca LIKE CONCAT("%",pa_nombre,"%") ;
END$$

DROP PROCEDURE IF EXISTS `buscar_marca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_marca` (IN `marca` VARCHAR(50))  BEGIN
  IF marca = ""  THEN
  SELECT * FROM marca_productos ;

ELSE
SELECT * FROM marca_productos WHERE marca_productos.marca  like CONCAT("%",marca,"%");

END if;
END$$

DROP PROCEDURE IF EXISTS `buscar_marca_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_marca_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

	SELECT DISTINCT (SELECT (UPPER(((SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = pendiente_empaque.marca))))) AS marca
FROM pendiente_empaque
	where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;

ELSE

	SELECT DISTINCT (SELECT (UPPER(((SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = pendiente_empaque.marca))))) AS marca
FROM pendiente_empaque;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_marca_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_marca_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

	SELECT DISTINCT (SELECT (UPPER(((SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = pendiente.marca))))) AS marca
	FROM pendiente
	where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;

ELSE

	SELECT DISTINCT (SELECT (UPPER(((SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = pendiente.marca))))) AS marca
	FROM pendiente;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_nombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_nombre` (IN `nombre` VARCHAR(50))  BEGIN
if nombre = "" then
SELECT * FROM nombre_productos;

ELSE

SELECT * FROM nombre_productos WHERE nombre_productos.nombre  like CONCAT("%",nombre,"%");
END if;
END$$

DROP PROCEDURE IF EXISTS `buscar_nombre_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_nombre_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then
 SELECT DISTINCT (SELECT (UPPER(((SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = pendiente_empaque.nombre))))) AS nombre
FROM pendiente_empaque
	where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT (SELECT (UPPER(((SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = pendiente_empaque.nombre))))) AS nombre
FROM pendiente_empaque ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_nombre_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_nombre_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then
 SELECT DISTINCT (SELECT (UPPER(((SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = pendiente.nombre))))) AS nombre
FROM pendiente
	where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT (SELECT (UPPER(((SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = pendiente.nombre))))) AS nombre
FROM pendiente;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_ordenes_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_ordenes_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT pendiente_empaque.orden_del_sitema
FROM pendiente_empaque

	where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT pendiente_empaque.orden_del_sitema
FROM pendiente_empaque;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_ordenes_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_ordenes_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT pendiente.orden_del_sitema
FROM pendiente

	where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT pendiente.orden_del_sitema
FROM pendiente ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_pedidos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_pedidos` (IN `pa_item` TEXT, IN `pa_categoria` TEXT, IN `pa_numero_orden` TEXT)  BEGIN

SELECT (SELECT categoria.categoria FROM categoria WHERE categoria.id_categoria
		 = pedidos.categoria) AS categorias,
		pedidos.item,
		pedidos.cant_paquetes,
		pedidos.unidades,
		pedidos.numero_orden,
		(SELECT

		 (CONCAT( (SELECT tipo_empaques.tipo_empaque from tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque)," ",
					(SELECT marca_productos.marca from marca_productos WHERE marca_productos.id_marca =clase_productos.id_marca)," ",
					(SELECT nombre_productos.nombre from nombre_productos WHERE nombre_productos.id_nombre =clase_productos.id_nombre)," ",
					(SELECT capa_productos.capa from capa_productos WHERE capa_productos.id_capa =clase_productos.id_capa)," ",
					(SELECT vitola_productos.vitola from vitola_productos WHERE vitola_productos.id_vitola =clase_productos.id_vitola)))


		 	 AS des FROM clase_productos WHERE clase_productos.item = pedidos.item) AS descripcion,
	    (pedidos.cant_paquetes*pedidos.unidades) AS total

FROM pedidos
WHERE pedidos.item LIKE CONCAT("%",pa_item,"%")
		AND (SELECT categoria.categoria FROM categoria WHERE categoria.id_categoria = pedidos.categoria) LIKE CONCAT("%",pa_categoria,"%")
		AND pedidos.numero_orden LIKE CONCAT("%",pa_numero_orden,"%")
ORDER BY id ;





END$$

DROP PROCEDURE IF EXISTS `buscar_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN

if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then



SELECT pendiente.id_pendiente ,
		 (SELECT categoria.categoria FROM  categoria WHERE categoria.id_categoria = pendiente.categoria	) AS categoria,
		 pendiente.item AS item,
		 pendiente.orden_del_sitema ,
		 pendiente.observacion,
		 pendiente.presentacion ,
		 pendiente.mes AS mes ,
		 pendiente.orden AS orden,
	(SELECT

		if( clase_productos.sampler = "si", CONCAT((SELECT clase_productos.descripcion_sampler FROM clase_productos WHERE clase_productos.item = pendiente.item)," ",(SELECT marca_productos.marca  FROM marca_productos WHERE marca_productos.id_marca = pendiente.marca)),
														(SELECT marca_productos.marca  FROM marca_productos WHERE marca_productos.id_marca = pendiente.marca)
						                     	) AS des FROM clase_productos WHERE clase_productos.item = pendiente.item) 	 AS marca,
		(SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = pendiente.vitola	) AS vitola,
		(SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = pendiente.nombre	) AS nombre,
		(SELECT capa_productos.capa FROM  capa_productos WHERE capa_productos.id_capa = pendiente.capa	) AS capa,
		(SELECT cellos.anillo AS anillo FROM cellos WHERE cellos.id_cello = pendiente.cello) AS anillo,
		(SELECT cellos.cello AS cello FROM cellos WHERE cellos.id_cello = pendiente.cello) AS cello,
		(SELECT cellos.upc AS upc FROM cellos WHERE cellos.id_cello = pendiente.cello) AS upc,
		 pendiente.pendiente as pendiente,
		 pendiente.saldo,
      (SELECT tipo_empaques.tipo_empaque FROM  tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente.tipo_empaque	) AS tipo_empaque,
		pendiente.paquetes AS paquetes,
		pendiente.unidades AS unidades,
	(select clase_productos.codigo_precio FROM clase_productos WHERE clase_productos.item = pendiente.item) AS serie_precio,
		(select clase_productos.precio FROM clase_productos WHERE clase_productos.item = pendiente.item) AS precio

FROM  pendiente
WHERE pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro

		ORDER BY pendiente.id_pendiente;


 else



SELECT pendiente.id_pendiente ,
		 (SELECT categoria.categoria FROM  categoria WHERE categoria.id_categoria = pendiente.categoria	) AS categoria,
		 pendiente.item AS item,
		 pendiente.orden_del_sitema ,
		 pendiente.observacion,
		 pendiente.presentacion ,
		 pendiente.mes AS mes ,
		 pendiente.orden AS orden,
	(SELECT

		if( clase_productos.sampler = "si", CONCAT((SELECT clase_productos.descripcion_sampler FROM clase_productos WHERE clase_productos.item = pendiente.item)," ",(SELECT marca_productos.marca  FROM marca_productos WHERE marca_productos.id_marca = pendiente.marca)),
														(SELECT marca_productos.marca  FROM marca_productos WHERE marca_productos.id_marca = pendiente.marca)
						                     	) AS des FROM clase_productos WHERE clase_productos.item = pendiente.item) 	 AS marca,
		(SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = pendiente.vitola	) AS vitola,
		(SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = pendiente.nombre	) AS nombre,
		(SELECT capa_productos.capa FROM  capa_productos WHERE capa_productos.id_capa = pendiente.capa	) AS capa,
		(SELECT cellos.anillo AS anillo FROM cellos WHERE cellos.id_cello = pendiente.cello) AS anillo,
		(SELECT cellos.cello AS cello FROM cellos WHERE cellos.id_cello = pendiente.cello) AS cello,
		(SELECT cellos.upc AS upc FROM cellos WHERE cellos.id_cello = pendiente.cello) AS upc,
		 pendiente.pendiente as pendiente,
		 pendiente.saldo,
      (SELECT tipo_empaques.tipo_empaque FROM  tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente.tipo_empaque	) AS tipo_empaque,
		pendiente.paquetes AS paquetes,
		pendiente.unidades AS unidades,
	(select clase_productos.codigo_precio FROM clase_productos WHERE clase_productos.item = pendiente.item) AS serie_precio,
		(select clase_productos.precio FROM clase_productos WHERE clase_productos.item = pendiente.item) AS precio

FROM  pendiente

		ORDER BY pendiente.id_pendiente;
END if;


END$$

DROP PROCEDURE IF EXISTS `buscar_pendiente_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_pendiente_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN

if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT pendiente_empaque.id_pendiente ,
		 (SELECT categoria.categoria FROM  categoria WHERE categoria.id_categoria = pendiente_empaque.categoria	) AS categoria,
		 pendiente_empaque.item AS item,
		 pendiente_empaque.orden_del_sitema ,
		 pendiente_empaque.observacion,
		 pendiente_empaque.presentacion ,
		 pendiente_empaque.mes AS mes ,
		 pendiente_empaque.orden AS orden,
	(SELECT

		if( clase_productos.sampler = "si", CONCAT((SELECT clase_productos.descripcion_sampler FROM clase_productos WHERE clase_productos.item = pendiente_empaque.item)," ",(SELECT marca_productos.marca  FROM marca_productos WHERE marca_productos.id_marca = pendiente_empaque.marca)),
														(SELECT marca_productos.marca  FROM marca_productos WHERE marca_productos.id_marca = pendiente_empaque.marca)
						                     	) AS des FROM clase_productos WHERE clase_productos.item = pendiente_empaque.item)  AS marca,
		 (SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = pendiente_empaque.vitola	) AS vitola,
		 (SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = pendiente_empaque.nombre	) AS nombre,
		  (SELECT capa_productos.capa FROM  capa_productos WHERE capa_productos.id_capa = pendiente_empaque.capa	) AS capa,
		(SELECT cellos.anillo AS anillo FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS anillo,
		(SELECT cellos.cello AS cello FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS cello,
		(SELECT cellos.upc AS upc FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS upc,
		 pendiente_empaque.pendiente as pendiente,
		 pendiente_empaque.saldo,
		 (SELECT tipo_empaques.tipo_empaque FROM  tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente_empaque.tipo_empaque	) AS tipo_empaque,
		pendiente_empaque.paquetes AS paquetes,
		pendiente_empaque.unidades AS unidades,

(SELECT pendiente_empaque.saldo/(SELECT SUBSTRING(tipo_empaques.tipo_empaque, 9, 3) FROM tipo_empaques WHERE tipo_empaques.tipo_empaque LIKE CONCAT("%","CAJAS","%") AND
tipo_empaques.id_tipo_empaque = pendiente_empaque.tipo_empaque)) AS cant_cajas
FROM  pendiente_empaque
WHERE pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro
		ORDER BY pendiente_empaque.id_pendiente;

ELSE

SELECT pendiente_empaque.id_pendiente ,
		 (SELECT categoria.categoria FROM  categoria WHERE categoria.id_categoria = pendiente_empaque.categoria	) AS categoria,
		 pendiente_empaque.item AS item,
		 pendiente_empaque.orden_del_sitema ,
		 pendiente_empaque.observacion,
		 pendiente_empaque.presentacion ,
		 pendiente_empaque.mes AS mes ,
		 pendiente_empaque.orden AS orden,
	(SELECT

		if( clase_productos.sampler = "si", CONCAT((SELECT clase_productos.descripcion_sampler FROM clase_productos WHERE clase_productos.item = pendiente_empaque.item)," ",(SELECT marca_productos.marca  FROM marca_productos WHERE marca_productos.id_marca = pendiente_empaque.marca)),
														(SELECT marca_productos.marca  FROM marca_productos WHERE marca_productos.id_marca = pendiente_empaque.marca)
						                     	) AS des FROM clase_productos WHERE clase_productos.item = pendiente_empaque.item)  AS marca,
		 (SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = pendiente_empaque.vitola	) AS vitola,
		 (SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = pendiente_empaque.nombre	) AS nombre,
		  (SELECT capa_productos.capa FROM  capa_productos WHERE capa_productos.id_capa = pendiente_empaque.capa	) AS capa,
		(SELECT cellos.anillo AS anillo FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS anillo,
		(SELECT cellos.cello AS cello FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS cello,
		(SELECT cellos.upc AS upc FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS upc,
		 pendiente_empaque.pendiente as pendiente,
		 pendiente_empaque.saldo,
		 (SELECT tipo_empaques.tipo_empaque FROM  tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente_empaque.tipo_empaque	) AS tipo_empaque,
		pendiente_empaque.paquetes AS paquetes,
		pendiente_empaque.unidades AS unidades,
(SELECT pendiente_empaque.saldo/(SELECT SUBSTRING(tipo_empaques.tipo_empaque, 9, 3) FROM tipo_empaques WHERE tipo_empaques.tipo_empaque LIKE CONCAT("%","CAJAS","%") AND
tipo_empaques.id_tipo_empaque = pendiente_empaque.tipo_empaque)) AS cant_cajas
FROM  pendiente_empaque
		ORDER BY pendiente_empaque.id_pendiente;
END if;
END$$

DROP PROCEDURE IF EXISTS `buscar_pendiente_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_pendiente_factura` (IN `pa_factura` VARCHAR(10), IN `fechade` VARCHAR(50), IN `pa_item` VARCHAR(50), IN `pa_orden` VARCHAR(50), IN `pa_hon` VARCHAR(50))  BEGIN

DECLARE fechames varchar(50);
if fechade != ""  then
SET lc_time_names = 'es_ES';
SET fechames = if(fechade IS NULL, "" ,(SELECT UPPER( CONCAT( MONTHNAME( STR_TO_DATE(fechade,'%Y-%m-%d'))," ",year(STR_TO_DATE(fechade,'%Y-%m-%d'))))));
ELSE
SET fechames = "";

END if;

SELECT pendiente.id_pendiente ,
		 (SELECT categoria.categoria FROM  categoria WHERE categoria.id_categoria = pendiente.categoria	) AS categoria,
		 pendiente.item AS item,
		 pendiente.orden_del_sitema ,
		 pendiente.observacion,
		 pendiente.presentacion ,pendiente.mes AS mes ,
		 pendiente.orden AS orden,
	(SELECT

		if( clase_productos.sampler = "si", (SELECT clase_productos.descripcion_sampler
										FROM clase_productos WHERE clase_productos.item = pendiente.item),

										(SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = pendiente.marca	)


		 	) AS des FROM clase_productos WHERE clase_productos.item = pendiente.item) AS marca,

		 (SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = pendiente.vitola	) AS vitola,
		 (SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = pendiente.nombre	) AS nombre,
		  (SELECT capa_productos.capa FROM  capa_productos WHERE capa_productos.id_capa = pendiente.capa	) AS capa,
		(SELECT cellos.anillo AS anillo FROM cellos WHERE cellos.id_cello = pendiente.cello) AS anillo,
		(SELECT cellos.cello AS cello FROM cellos WHERE cellos.id_cello = pendiente.cello) AS cello,
		(SELECT cellos.upc AS upc FROM cellos WHERE cellos.id_cello = pendiente.cello) AS upc,
		 pendiente.pendiente as pendiente,
		 pendiente.saldo,
      (SELECT tipo_empaques.tipo_empaque FROM  tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente.tipo_empaque	) AS tipo_empaque,
		pendiente.paquetes AS paquetes,
		pendiente.unidades AS unidades,
		(select clase_productos.codigo_precio FROM clase_productos WHERE clase_productos.item = pendiente.item) AS serie_precio,
		(select clase_productos.precio FROM clase_productos WHERE clase_productos.item = pendiente.item) AS precio,
		(select sum(inventario_productos_terminados.Existencia)
						FROM inventario_productos_terminados
						WHERE inventario_productos_terminados.Marca = pendiente.marca and
								inventario_productos_terminados.Alias_vitola = pendiente.nombre and
								inventario_productos_terminados.Vitola = pendiente.vitola and
								inventario_productos_terminados.Nombre_capa = pendiente.capa AND
								inventario_productos_terminados.orden_sistema LIKE CONCAT("%",pendiente.orden_del_sitema,"%") AND
								inventario_productos_terminados.orden_pedido LIKE CONCAT("%",pendiente.orden,"%")
								) AS PT
FROM pendiente
WHERE pendiente.orden like CONCAT("%",pa_factura,"%")
		AND pendiente.mes like CONCAT("%",fechames,"%")
		AND pendiente.item like CONCAT("%",pa_item,"%")
		AND pendiente.orden_del_sitema like CONCAT("%",pa_orden,"%")
		AND pendiente.orden like CONCAT("%",pa_hon,"%")

GROUP BY pendiente.id_pendiente;



END$$

DROP PROCEDURE IF EXISTS `buscar_producto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_producto` (IN `todo` VARCHAR(50))  BEGIN


 SELECT clase_productos.id_producto,
 			(SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa	) AS capa,
			 clase_productos.item,clase_productos.codigo_producto,clase_productos.codigo_caja,clase_productos.codigo_precio,
 clase_productos.presentacion,

 			(SELECT cellos.anillo AS anillo FROM cellos WHERE cellos.id_cello = clase_productos.id_cello) AS anillo,
		(SELECT cellos.cello AS cello FROM cellos WHERE cellos.id_cello = clase_productos.id_cello) AS cello,
		(SELECT cellos.upc AS upc FROM cellos WHERE cellos.id_cello = clase_productos.id_cello) AS upc,


		(SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca	) AS marca,

		(SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = clase_productos.id_vitola	) AS vitola,
		 (SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre	) AS nombre,



		  (SELECT tipo_empaques.tipo_empaque FROM  tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque	) AS tipo_empaque,


		  clase_productos.sampler, clase_productos.descripcion_sampler AS des,
		  clase_productos.precio
FROM clase_productos
WHERE   (SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombrE) LIKE  CONCAT("%",todo,"%")
		|| (SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca) LIKE  CONCAT("%",todo,"%")
		|| clase_productos.item LIKE  CONCAT("%",todo,"%")
		|| (SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = clase_productos.id_vitola) LIKE  CONCAT("%",todo,"%");




END$$

DROP PROCEDURE IF EXISTS `buscar_tipo_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_tipo_empaque` (IN `tipo` VARCHAR(50))  BEGIN
if tipo =""then
SELECT * FROM tipo_empaques ;
else
SELECT * FROM tipo_empaques WHERE tipo_empaques.tipo_empaque  like CONCAT("%",tipo,"%");
END if;
END$$

DROP PROCEDURE IF EXISTS `buscar_tipo_empaque_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_tipo_empaque_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT (SELECT (UPPER(((SELECT tipo_empaques.tipo_empaque FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente_empaque.tipo_empaque))))) AS empaque
FROM pendiente_empaque

	where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT (SELECT (UPPER(((SELECT tipo_empaques.tipo_empaque FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente_empaque.tipo_empaque))))) AS empaque
FROM pendiente_empaque ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_tipo_empaque_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_tipo_empaque_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then

SELECT DISTINCT (SELECT (UPPER(((SELECT tipo_empaques.tipo_empaque FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente.tipo_empaque))))) AS empaque
FROM pendiente

	where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;

ELSE

SELECT DISTINCT (SELECT (UPPER(((SELECT tipo_empaques.tipo_empaque FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente.tipo_empaque))))) AS empaque
FROM pendiente ;
END if;

END$$

DROP PROCEDURE IF EXISTS `buscar_vitola`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_vitola` (IN `vitola` VARCHAR(50))  BEGIN
if vitola = "" then
SELECT * FROM vitola_productos;

ELSE
SELECT * FROM vitola_productos WHERE vitola_productos.vitola   like CONCAT("%",vitola,"%");
END if;
END$$

DROP PROCEDURE IF EXISTS `buscar_vitola_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_vitola_empaque` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then
SELECT DISTINCT (SELECT (UPPER(((SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = pendiente_empaque.vitola))))) AS vitola
FROM pendiente_empaque
where  pendiente_empaque.categoria = pa_uno or
pendiente_empaque.categoria = pa_dos  or
pendiente_empaque.categoria = pa_tres or
pendiente_empaque.categoria = pa_cuatro ;
ELSE
SELECT DISTINCT (SELECT (UPPER(((SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = pendiente_empaque.vitola))))) AS vitola
FROM pendiente_empaque ;
END if;
END$$

DROP PROCEDURE IF EXISTS `buscar_vitola_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_vitola_pendiente` (IN `pa_uno` VARCHAR(50), IN `pa_dos` VARCHAR(50), IN `pa_tres` VARCHAR(50), IN `pa_cuatro` VARCHAR(50))  BEGIN
if pa_uno != "" || pa_dos != "" || pa_tres  != "" || pa_cuatro != ""
 then
SELECT DISTINCT (SELECT (UPPER(((SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = pendiente.vitola))))) AS vitola
FROM pendiente
where  pendiente.categoria = pa_uno or
pendiente.categoria = pa_dos  or
pendiente.categoria = pa_tres or
pendiente.categoria = pa_cuatro ;
ELSE
SELECT DISTINCT (SELECT (UPPER(((SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = pendiente.vitola))))) AS vitola
FROM pendiente;
END if;
END$$

DROP PROCEDURE IF EXISTS `cantidad_cajas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cantidad_cajas` ()  BEGIN
DECLARE codigo_caja VARCHAR(100);


set codigo_caja =(SELECT  pendiente_empaque.id_pendiente ,clase_productos.codigo_caja FROM pendiente_empaque, clase_productos WHERE
pendiente_empaque.item = clase_productos.item AND clase_productos.codigo_caja IS not NULL);

SELECT codigo_caja;
END$$

DROP PROCEDURE IF EXISTS `contar_detalles_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `contar_detalles_productos` (IN `item` VARCHAR(50))  BEGIN
SELECT COUNT(*) as detalles FROM  detalle_clase_productos  WHERE detalle_clase_productos.item = item;
END$$

DROP PROCEDURE IF EXISTS `datos_pendiente_programar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `datos_pendiente_programar` (IN `id` INT)  BEGIN

SELECT pendiente_empaque.id_pendiente,
(SELECT categoria.categoria FROM  categoria WHERE categoria.id_categoria = pendiente_empaque.categoria	) AS categoria,
 pendiente_empaque.item AS item,
 pendiente_empaque.orden_del_sitema AS orden_del_sitema,
 pendiente_empaque.observacion AS observacion,
 pendiente_empaque.presentacion AS presentacion ,
 pendiente_empaque.mes AS mes ,
pendiente_empaque.orden AS orden,

(SELECT

		if( clase_productos.sampler = "si", (SELECT clase_productos.descripcion_sampler
										FROM clase_productos WHERE clase_productos.item = pendiente_empaque.item),

										(SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = pendiente_empaque.marca	)


		 	) AS des FROM clase_productos WHERE clase_productos.item = pendiente_empaque.item) AS marca,

 (SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = pendiente_empaque.vitola	) AS vitola,
		 (SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = pendiente_empaque.nombre	) AS nombre,
		  (SELECT capa_productos.capa FROM  capa_productos WHERE capa_productos.id_capa = pendiente_empaque.capa	) AS capa,

(SELECT cellos.anillo AS anillo FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS anillo,
(SELECT cellos.cello AS cello FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS cello,
(SELECT cellos.upc AS upc FROM cellos WHERE cellos.id_cello = pendiente_empaque.cello) AS upc,
 pendiente_empaque.pendiente as pendiente_empaque,
pendiente_empaque.saldo AS saldo,
(SELECT tipo_empaques.tipo_empaque FROM  tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pendiente_empaque.tipo_empaque	) AS tipo_empaque,

 pendiente_empaque.unidades AS paquetes,
(SELECT pendiente_empaque.saldo/(SELECT SUBSTRING(tipo_empaques.tipo_empaque, 9, 3) FROM tipo_empaques WHERE tipo_empaques.tipo_empaque LIKE CONCAT("%","CAJAS","%") AND
tipo_empaques.id_tipo_empaque = pendiente_empaque.tipo_empaque)) AS cant_cajas

FROM pendiente_empaque
WHERE  pendiente_empaque.id_pendiente = id;

END$$

DROP PROCEDURE IF EXISTS `editar_existencia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_existencia` (IN `pa_id` INT, IN `pa_existencia` INT)  BEGIN
 UPDATE lista_cajas
                SET
                      lista_cajas.existencia = pa_existencia


                WHERE lista_cajas.id = pa_id;
END$$

DROP PROCEDURE IF EXISTS `editar_existencia_producto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_existencia_producto` (IN `pa_id` INT, IN `pa_existencia` INT, IN `pa_pedido` VARCHAR(50), IN `pa_sistema` VARCHAR(50))  BEGIN
 UPDATE inventario_productos_terminados
                SET
                      inventario_productos_terminados.Existencia = pa_existencia,
                      inventario_productos_terminados.orden_pedido = pa_pedido,
                      inventario_productos_terminados.orden_sistema = pa_sistema


                WHERE inventario_productos_terminados.id = pa_id;
END$$

DROP PROCEDURE IF EXISTS `eliminar_detalles`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_detalles` (IN `id` INT, IN `id_pendiente` INT, IN `cant` INT)  BEGIN

DELETE FROM detalle_programacion_temporal WHERE detalle_programacion_temporal.id_detalle_programacion = id;


UPDATE lista_cajas SET lista_cajas.existencia = cant
WHERE (SELECT (SELECT  clase_productos.codigo_caja FROM clase_productos WHERE
			  clase_productos.item = pendiente_empaque.item  ) AS caja
 FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente) = lista_cajas.codigo;



END$$

DROP PROCEDURE IF EXISTS `eliminar_detalle_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_detalle_factura` (IN `pa_detalle` INT)  BEGIN
  DELETE FROM detalle_factura WHERE detalle_factura.id_detalle = pa_detalle;
END$$

DROP PROCEDURE IF EXISTS `eliminar_detalle_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_detalle_programacion` (IN `id` INT, IN `id_pendiente` INT, IN `saldo` DECIMAL(10,2), IN `cant` INT)  BEGIN


UPDATE pendiente_empaque SET pendiente_empaque.saldo = saldo + pendiente_empaque.saldo WHERE pendiente_empaque.id_pendiente = id_pendiente;

UPDATE lista_cajas SET lista_cajas.existencia = cant
WHERE (SELECT (SELECT  clase_productos.codigo_caja FROM clase_productos WHERE
			  clase_productos.item = pendiente_empaque.item  ) AS caja
 FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente) = lista_cajas.codigo;


DELETE FROM detalle_programacion WHERE detalle_programacion.id_detalle_programacion = id;
END$$

DROP PROCEDURE IF EXISTS `eliminar_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_programacion` (IN `id_pro` INT)  BEGIN


DELETE FROM prograamacion WHERE prograamacion.id = id_pro;

DELETE FROM detalle_programacion WHERE detalle_programacion.id_programacion = id_pro;
END$$

DROP PROCEDURE IF EXISTS `eliminar_usuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_usuario` (IN `pa_id_usuario` INT)  BEGIN

        DELETE FROM users
        WHERE users.id = pa_id_usuario;

        END$$

DROP PROCEDURE IF EXISTS `ingresar_presentacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_presentacion` ()  BEGIN

UPDATE clase_productos,(
	SELECT tabla_codigo_programacions.codigo, tabla_codigo_programacions.presentacion, tabla_codigo_programacions.capa,
	tabla_codigo_programacions.nombre ,tabla_codigo_programacions.marca
	FROM clase_productos, tabla_codigo_programacions
	WHERE clase_productos.id_capa = tabla_codigo_programacions.capa AND clase_productos.id_nombre =
tabla_codigo_programacions.nombre AND clase_productos.id_marca = tabla_codigo_programacions.marca)x
SET clase_productos.codigo_producto = x.codigo , clase_productos.presentacion = x.presentacion
WHERE clase_productos.id_capa = x.capa AND clase_productos.id_nombre =
x.nombre AND clase_productos.id_marca = x.marca;
END$$

DROP PROCEDURE IF EXISTS `insertar_actualizar_existencias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_actualizar_existencias` (IN `codigo` VARCHAR(50), IN `marca` VARCHAR(50), IN `nombre` VARCHAR(50), IN `vitola` VARCHAR(50), IN `capa` VARCHAR(50), IN `total` VARCHAR(50))  BEGIN

 DECLARE inicio VARCHAR(50);
 DECLARE fin VARCHAR(50);
 DECLARE tamano INT;
 DECLARE con INT;
 DECLARE localizacion INT;
 DECLARE nuevo_total VARCHAR(50);
 DECLARE tot DECIMAL(10,2);


 SET con = 0;
 SET localizacion =  (select LOCATE(',',total));
 SET inicio = (SELECT SUBSTRING_INDEX(total, ',', 1));
 SET fin =  (SELECT SUBSTRING(total, LENGTH(total) - 5, 6));
 SET tamano = LENGTH(total);

 if localizacion >0 then
  SET nuevo_total = CONCAT(inicio, fin);

 else
 SET nuevo_total = total;
 END if;

SET tot =( CAST(nuevo_total AS DECIMAL(10,2)));

INSERT INTO importar_existencias(importar_existencias.codigo_producto,importar_existencias.marca,
importar_existencias.nombre,importar_existencias.vitola, importar_existencias.capa,importar_existencias.total)
VALUES(codigo,marca,nombre,vitola,capa,tot);

END$$

DROP PROCEDURE IF EXISTS `insertar_capa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_capa` (IN `capa` VARCHAR(50))  BEGIN
 INSERT INTO capa_productos(capa_productos.capa)VALUES(capa);
END$$

DROP PROCEDURE IF EXISTS `insertar_clase_producto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_clase_producto` (IN `item` VARCHAR(50), IN `cod_producto` VARCHAR(50), IN `cod_caja` VARCHAR(50), IN `cod_precio` VARCHAR(50), IN `precio` INT, IN `capa` VARCHAR(50), IN `vitola` VARCHAR(50), IN `nombre` VARCHAR(50), IN `marca` VARCHAR(50), IN `cello` VARCHAR(50), IN `anillo` VARCHAR(50), IN `upc` VARCHAR(50), IN `tipo_empaque` VARCHAR(50), IN `presentacion` VARCHAR(50))  BEGIN

DECLARE icapa INT;
DECLARE imarca INT;
DECLARE inombre INT;
DECLARE ivitola INT;
DECLARE icello INT;
DECLARE itipo INT;


SET ivitola = (SELECT vitola_productos.id_vitola FROM  vitola_productos WHERE vitola_productos.vitola = vitola);

SET icapa = (SELECT capa_productos.id_capa FROM  capa_productos WHERE capa_productos.capa = capa);

SET imarca = (SELECT marca_productos.id_marca FROM marca_productos WHERE marca_productos.marca = marca);
SET inombre = (SELECT nombre_productos.id_nombre FROM nombre_productos WHERE nombre_productos.nombre = nombre);
SET icello = (SELECT cellos.id_cello FROM cellos WHERE cellos.cello = cello AND cellos.anillo = anillo AND cellos.upc= upc);
SET itipo =  (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = tipo_empaque);

INSERT INTO clase_productos(clase_productos.item,clase_productos.codigo_producto,clase_productos.codigo_caja
,clase_productos.codigo_precio,clase_productos.precio,clase_productos.id_capa, clase_productos.id_vitola,
clase_productos.id_nombre,clase_productos.id_marca, clase_productos.id_cello, clase_productos.id_tipo_empaque
,clase_productos.presentacion)
VALUES(item,cod_producto,cod_caja,cod_precio,precio,icapa,ivitola,inombre,imarca,icello,itipo,presentacion);




END$$

DROP PROCEDURE IF EXISTS `insertar_codigoproducto_presentacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_codigoproducto_presentacion` ()  BEGIN

UPDATE clase_productos,tabla_codigo_programacions SET clase_productos.codigo_producto = tabla_codigo_programacions.codigo,
clase_productos.presentacion = tabla_codigo_programacions.presentacion
WHERE clase_productos.id_vitola = tabla_codigo_programacions.vitola AND clase_productos.id_nombre  = tabla_codigo_programacions.nombre AND
clase_productos.id_marca = tabla_codigo_programacions.marca AND
clase_productos.id_capa = tabla_codigo_programacions.capa;
END$$

DROP PROCEDURE IF EXISTS `insertar_detallePro_temporalSinExistencia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_detallePro_temporalSinExistencia` (IN `numero_orden` VARCHAR(50), IN `orden` VARCHAR(50), IN `cod_producto` VARCHAR(50), IN `saldo` VARCHAR(50), IN `id_pendiente` INT, IN `cajas_cant` INT)  BEGIN

DECLARE  c VARCHAR(50);
DECLARE total_Existencia DECIMAL(10,2);
DECLARE saldo_pendiente DECIMAL(10,2);


SET c = (SELECT clase_productos.codigo_producto from clase_productos
WHERE clase_productos.item = cod_producto);

INSERT INTO detalle_programacion_temporal(detalle_programacion_temporal.numero_orden,detalle_programacion_temporal.orden,
detalle_programacion_temporal.cod_producto,detalle_programacion_temporal.saldo, detalle_programacion_temporal.id_pendiente,
detalle_programacion_temporal.cant_cajas)
VALUES(numero_orden,orden,c,saldo,id_pendiente,


	(SELECT ((SELECT lista_cajas.existencia FROM lista_cajas WHERE lista_cajas.codigo =
	(SELECT (	SELECT  clase_productos.codigo_caja FROM clase_productos WHERE
			  clase_productos.item = pendiente_empaque.item  ) AS caja
 FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente))-cajas_cant)
  FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente)

);



UPDATE lista_cajas SET lista_cajas.existencia = lista_cajas.existencia - cajas_cant
WHERE (SELECT (SELECT  clase_productos.codigo_caja FROM clase_productos WHERE
			  clase_productos.item = pendiente_empaque.item  ) AS caja
 FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente) = lista_cajas.codigo;

END$$

DROP PROCEDURE IF EXISTS `insertar_detalle_clase_producto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_detalle_clase_producto` (IN `item` VARCHAR(50), IN `capa` VARCHAR(50), IN `vitola` VARCHAR(50), IN `nombre` VARCHAR(50), IN `marca` VARCHAR(50), IN `cello` VARCHAR(50), IN `anillo` VARCHAR(50), IN `upc` VARCHAR(50), IN `tipo_empaque` VARCHAR(50), IN `precio` VARCHAR(50))  BEGIN

DECLARE icapa INT;
DECLARE imarca INT;
DECLARE inombre INT;
DECLARE ivitola INT;
DECLARE icello INT;
DECLARE itipo INT;

SET ivitola = (SELECT vitola_productos.id_vitola FROM  vitola_productos WHERE vitola_productos.vitola = vitola);
SET icapa = (SELECT capa_productos.id_capa FROM  capa_productos WHERE capa_productos.capa = capa);
SET imarca = (SELECT marca_productos.id_marca FROM marca_productos WHERE marca_productos.marca = marca);
SET inombre = (SELECT nombre_productos.id_nombre FROM nombre_productos WHERE nombre_productos.nombre = nombre);
SET icello = (SELECT cellos.id_cello FROM cellos WHERE cellos.cello = cello AND cellos.anillo = anillo AND cellos.upc= upc);
SET itipo =  (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = tipo_empaque);

INSERT INTO detalle_clase_productos(detalle_clase_productos.item,detalle_clase_productos.id_capa, detalle_clase_productos.id_vitola,
detalle_clase_productos.id_nombre,detalle_clase_productos.id_marca, detalle_clase_productos.id_cello, detalle_clase_productos.id_tipo_empaque
,detalle_clase_productos.otra_descripcion)
VALUES(item, icapa,ivitola,inombre,imarca,icello,itipo,precio);

END$$

DROP PROCEDURE IF EXISTS `insertar_detalle_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_detalle_factura` (IN `pa_id_pendiente` BIGINT, IN `pa_cantidad_cajas` INT, IN `pa_peso_bruto` INT, IN `pa_peso_neto` INT, IN `pa_cantidad_puros` INT, IN `pa_unidad` INT, IN `pa_observaciones` TEXT)  BEGIN
	INSERT INTO detalle_factura(
		detalle_factura.id_pendiente,
		detalle_factura.id_venta,
		detalle_factura.cantidad_cajas,
		detalle_factura.peso_bruto,
		detalle_factura.peso_neto,
		detalle_factura.cantidad_puros,
		detalle_factura.unidad,
		detalle_factura.observaciones,
		detalle_factura.facturado)
   VALUES(
		pa_id_pendiente,
		0,
		pa_cantidad_cajas,
		pa_peso_bruto,
		pa_peso_neto,
		pa_cantidad_puros,
		pa_unidad,
		pa_observaciones,
		'N');



END$$

DROP PROCEDURE IF EXISTS `insertar_detalle_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_detalle_programacion` (IN `numero_orden` VARCHAR(50), IN `orden` VARCHAR(50), IN `cod_producto` VARCHAR(50), IN `saldo` BIGINT, IN `id_pendiente` INT, IN `caja` VARCHAR(50), IN `cant_cajas` INT)  BEGIN

DECLARE id INT;

SET id= (SELECT MAX(prograamacion.id) AS id FROM prograamacion);


INSERT INTO detalle_programacion(detalle_programacion.numero_orden,detalle_programacion.orden,
detalle_programacion.cod_producto,detalle_programacion.saldo, detalle_programacion.id_programacion,detalle_programacion.id_pendiente,
detalle_programacion.cajas, detalle_programacion.cant_cajas)
VALUES(numero_orden,orden,cod_producto,saldo,id,id_pendiente,caja, cant_cajas);

UPDATE pendiente_empaque SET pendiente_empaque.saldo = (pendiente_empaque.saldo- saldo)
WHERE pendiente_empaque.id_pendiente= id_pendiente;

DELETE FROM detalle_programacion_temporal;

END$$

DROP PROCEDURE IF EXISTS `insertar_detalle_temporal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_detalle_temporal` (IN `numero_orden` VARCHAR(50), IN `orden` VARCHAR(50), IN `cod_producto` VARCHAR(50), IN `saldo` DECIMAL(10,2), IN `id_pendiente` INT, IN `cajas_cant` INT)  BEGIN

DECLARE  c VARCHAR(50);
DECLARE total_Existencia DECIMAL(10,2);
DECLARE saldo_pendiente DECIMAL(10,2);


SET c = (SELECT clase_productos.codigo_producto from clase_productos
WHERE clase_productos.item = cod_producto);
SET total_Existencia= (SELECT sum(importar_existencias.total) FROM importar_existencias WHERE
importar_existencias.codigo_producto = cod_producto);


if EXISTS(SELECT importar_existencias.codigo_producto FROM importar_existencias WHERE
importar_existencias.codigo_producto = c)then
INSERT INTO detalle_programacion_temporal(detalle_programacion_temporal.numero_orden,detalle_programacion_temporal.orden,
detalle_programacion_temporal.cod_producto,detalle_programacion_temporal.saldo, detalle_programacion_temporal.id_pendiente,
detalle_programacion_temporal.cant_cajas)
VALUES(numero_orden,orden,c,saldo,id_pendiente,


	(SELECT ((SELECT lista_cajas.existencia FROM lista_cajas WHERE lista_cajas.codigo =
	(SELECT (	SELECT  clase_productos.codigo_caja FROM clase_productos WHERE
			  clase_productos.item = pendiente_empaque.item  ) AS caja
 FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente))-cajas_cant)
  FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente)

);

UPDATE lista_cajas SET lista_cajas.existencia = lista_cajas.existencia - cajas_cant
WHERE (SELECT (SELECT  clase_productos.codigo_caja FROM clase_productos WHERE
			  clase_productos.item = pendiente_empaque.item  ) AS caja
 FROM pendiente_empaque WHERE pendiente_empaque.id_pendiente =id_pendiente) = lista_cajas.codigo;

ELSE

SELECT "nada";
END if;

END$$

DROP PROCEDURE IF EXISTS `insertar_factura_terminado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_factura_terminado` (IN `orden_sufijo` VARCHAR(10), IN `pa_cliente` VARCHAR(50), IN `pa_numero_factura` VARCHAR(50), IN `pa_contenedor` VARCHAR(50), IN `pa_cantidad_bultos` INT, IN `pa_total_puros` INT, IN `pa_total_peso_bruto` INT, IN `pa_total_peso_neto` INT, IN `pa_fecha_factura` DATETIME)  BEGIN
  INSERT INTO factura_terminados(
  		factura_terminados.cliente,
  		factura_terminados.numero_factura,
  		factura_terminados.contenedor,
		factura_terminados.cantidad_bultos,
		factura_terminados.total_puros,
		factura_terminados.total_peso_bruto,
		factura_terminados.total_peso_neto,
		factura_terminados.fecha_factura,
		factura_terminados.facturado)
	VALUES(
		pa_cliente,
		pa_numero_factura,
		pa_contenedor,
		pa_cantidad_bultos,pa_total_puros,pa_total_peso_bruto,pa_total_peso_neto,pa_fecha_factura,'N');



	UPDATE detalle_factura,pendiente SET

	detalle_factura.facturado = "S",
	detalle_factura.id_venta = (SELECT factura_terminados.id FROM  factura_terminados WHERE factura_terminados.numero_factura = pa_numero_factura)

	WHERE pendiente.id_pendiente = detalle_factura.id_pendiente
			AND pendiente.orden LIKE CONCAT("%",orden_sufijo,"%")
			AND detalle_factura.facturado = "N";


END$$

DROP PROCEDURE IF EXISTS `insertar_lista_cajas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_lista_cajas` (IN `pa_item` VARCHAR(50), IN `pa_productoServicio` VARCHAR(200), IN `pa_marca` VARCHAR(100))  BEGIN

DECLARE imarca INT;
DECLARE itipo_empaque INT;
DECLARE vl_palabra_1 VARCHAR(50);
DECLARE vl_palabra_2 VARCHAR(50);
DECLARE vl_palabra_3 VARCHAR(50);
DECLARE vl_palabra_4 VARCHAR(50);
DECLARE vl_palabra_5 VARCHAR(50);
DECLARE vl_palabra_6 VARCHAR(50);
DECLARE vl_palabra_7 VARCHAR(50);
DECLARE vl_palabra_8 VARCHAR(50);
DECLARE vl_palabra_9 VARCHAR(50);
DECLARE vl_palabra_10 VARCHAR(50);
DECLARE vl_palabra_12 VARCHAR(50);
DECLARE vl_palabra_13 VARCHAR(50);
DECLARE vl_palabra_14 VARCHAR(50);
DECLARE vl_palabra_15 VARCHAR(50);
DECLARE vl_numpalabras INT;
DECLARE vl_tamanio INT;
DECLARE cont INT;
DECLARE vl_palabra_empaque VARCHAR(50);


SET cont = 0;
SET vl_numpalabras = 0;
SET vl_tamanio = LENGTH(pa_productoServicio);

SET vl_palabra_empaque = SUBSTRING(pa_productoServicio, vl_tamanio - 5,7);
SET vl_palabra_empaque = SUBSTRING(vl_palabra_empaque, LENGTH(vl_palabra_empaque) - 1,3);



IF EXISTS (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = CONCAT("CAJAS 1/",vl_palabra_empaque)) THEN
  		SET itipo_empaque = (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = CONCAT("CAJAS 1/",vl_palabra_empaque));
ELSE
		SET vl_palabra_empaque = SUBSTRING(pa_productoServicio, vl_tamanio - 4, 6);
		SET vl_palabra_empaque = SUBSTRING(vl_palabra_empaque, 5);
		SET itipo_empaque = (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = CONCAT("CAJAS 1/",vl_palabra_empaque));

		IF EXISTS (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = CONCAT("CAJAS 1/",vl_palabra_empaque)) THEN
  				SET itipo_empaque = (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = CONCAT("CAJAS 1/",vl_palabra_empaque));
		ELSE
				SET vl_palabra_empaque = SUBSTRING(pa_productoServicio, vl_tamanio - 5,7);
				SET vl_palabra_empaque = SUBSTRING(vl_palabra_empaque, LENGTH(vl_palabra_empaque) - 2,3);

			   SET itipo_empaque = (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = CONCAT("CAJAS 1/",vl_palabra_empaque));

		END IF;
END IF;




	INSERT INTO lista_cajas(lista_cajas.marca,lista_cajas.productoServicio,lista_cajas.codigo,lista_cajas.tipo_empaque,lista_cajas.existencia)

	VALUES(pa_marca,pa_productoServicio,pa_item,itipo_empaque,0);



END$$

DROP PROCEDURE IF EXISTS `insertar_marca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_marca` (IN `marca` VARCHAR(100))  BEGIN
 INSERT INTO marca_productos(marca_productos.marca)VALUES(marca);
 end$$

DROP PROCEDURE IF EXISTS `insertar_nombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_nombre` (IN `nombre` VARCHAR(50))  BEGIN
  INSERT INTO nombre_productos(nombre_productos.nombre)VALUES(nombre);
END$$

DROP PROCEDURE IF EXISTS `insertar_nuevo_pedido`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_nuevo_pedido` (IN `item` VARCHAR(50), IN `paquetes` VARCHAR(50), IN `unidades` VARCHAR(50), IN `orden` VARCHAR(50), IN `categori` VARCHAR(50))  BEGIN

INSERT INTO pedidos(pedidos.item,pedidos.cant_paquetes,pedidos.unidades,pedidos.numero_orden,pedidos.categoria)
VALUEs(item, paquetes, unidades, orden, categori);
END$$

DROP PROCEDURE IF EXISTS `insertar_nuevo_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_nuevo_pendiente` (IN `categori` VARCHAR(50), IN `item` VARCHAR(50), IN `orden_del_sitema` VARCHAR(50), IN `observacion` VARCHAR(50), IN `presentacion` VARCHAR(50), IN `mes` VARCHAR(50), IN `orden` VARCHAR(50), IN `marca` VARCHAR(50), IN `vitola` VARCHAR(50), IN `nombre` VARCHAR(50), IN `capa` VARCHAR(50), IN `tipo_empaque` VARCHAR(50), IN `cello` VARCHAR(50), IN `anillo` VARCHAR(50), IN `upc` VARCHAR(50), IN `pendient` VARCHAR(50), IN `saldo` VARCHAR(50), IN `paquetes` VARCHAR(50), IN `unidades` VARCHAR(50), IN `serie_precio` VARCHAR(50), IN `precio` VARCHAR(50))  BEGIN

DECLARE icapa INT;
DECLARE imarca INT;
DECLARE inombre INT;
DECLARE ivitola INT;
DECLARE icello INT;
DECLARE itipo INT;




SET ivitola = (SELECT vitola_productos.id_vitola FROM  vitola_productos WHERE vitola_productos.vitola = vitola);

SET icapa = (SELECT capa_productos.id_capa FROM  capa_productos WHERE capa_productos.capa = capa);

SET imarca = (SELECT marca_productos.id_marca FROM marca_productos WHERE marca_productos.marca = marca);
SET inombre = (SELECT nombre_productos.id_nombre FROM nombre_productos WHERE nombre_productos.nombre = nombre);
SET icello = (SELECT cellos.id_cello FROM cellos WHERE cellos.cello = cello AND cellos.anillo = anillo AND cellos.upc= upc);
SET itipo =  (SELECT tipo_empaques.id_tipo_empaque FROM tipo_empaques WHERE tipo_empaques.tipo_empaque = tipo_empaque);


SET lc_time_names = 'es_ES';
insert into pendiente(
	pendiente.categoria,
	pendiente.item,
	pendiente.orden_del_sitema,
	pendiente.observacion,
	pendiente.presentacion,
	pendiente.mes,
pendiente.orden,
pendiente.marca,
pendiente.vitola,
pendiente.nombre,
pendiente.capa,
pendiente.tipo_empaque,
	pendiente.cello,
pendiente.pendiente,
	pendiente.saldo,
	pendiente.paquetes,
pendiente.unidades,
    pendiente.serie_precio,
    pendiente.precio)values (categori,
	item,
	orden_del_sitema,
	observacion,
	presentacion,
	( UPPER( CONCAT( MONTHNAME(mes)," ",year(mes)))),
	orden,
	imarca,
	ivitola,
	inombre,
	icapa,
	itipo,
	icello,
	pendient,
	saldo,
	paquetes,
	unidades,
   serie_precio,
   precio);


insert into pendiente_empaque(
	pendiente_empaque.categoria,
	pendiente_empaque.item,
	pendiente_empaque.orden_del_sitema,
	pendiente_empaque.observacion,
	pendiente_empaque.presentacion,
	pendiente_empaque.mes,
pendiente_empaque.orden,
pendiente_empaque.marca,
pendiente_empaque.vitola,
pendiente_empaque.nombre,
pendiente_empaque.capa,
pendiente_empaque.tipo_empaque,
	pendiente_empaque.cello,
pendiente_empaque.pendiente,
	pendiente_empaque.saldo,
	pendiente_empaque.paquetes,
pendiente_empaque.unidades,
pendiente_empaque.id_pendiente_pedido)values (categori,
	item,
	orden_del_sitema,
	observacion,
	presentacion,
	( UPPER( CONCAT( MONTHNAME(mes)," ",year(mes)))),
	orden,
	imarca,
	ivitola,
	inombre,
	icapa,
	itipo,
	icello,
	pendient,
	saldo,
	paquetes,
	unidades,
	(SELECT MAX(id_pendiente) FROM pendiente));


UPDATE clase_productos SET clase_productos.codigo_precio = serie_precio, clase_productos.precio = precio
WHERE clase_productos.item = item;


END$$

DROP PROCEDURE IF EXISTS `insertar_pendente_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_pendente_empaque` (IN `fecha` VARCHAR(50))  BEGIN

SET lc_time_names = 'es_ES';
insert into pendiente_empaque(
	`categoria`,
	`item`,
	`orden_del_sitema`,
	`observacion`,
	`presentacion`,
	`mes`,
	`orden`,
	`marca`,
	`vitola`,
	`nombre`,
	`capa`,
	`tipo_empaque`,
	`cello`,
	`pendiente`,
	`saldo`,
	`paquetes`,
	`unidades`,
	pendiente_empaque.id_pendiente_pedido) (SELECT
  pendiente.categoria  AS categoria,
 (SELECT clase_productos.item  FROM clase_productos WHERE clase_productos.item = pendiente.item) AS item,
 '' AS orden_del_sistema,
 '' AS observacion,
 (SELECT clase_productos.presentacion FROM clase_productos WHERE clase_productos.item = pendiente.item) AS presentacion,

pendiente.mes AS mes,
pendiente.orden AS orden,
 (SELECT clase_productos.id_marca FROM clase_productos WHERE clase_productos.item = pendiente.item) AS marca,
 (SELECT clase_productos.id_vitola FROM clase_productos WHERE clase_productos.item = pendiente.item) AS vitola,
 (SELECT clase_productos.id_nombre FROM clase_productos WHERE clase_productos.item = pendiente.item) AS nombre,
 (SELECT clase_productos.id_capa FROM clase_productos WHERE clase_productos.item = pendiente.item) AS capa,
 (SELECT clase_productos.id_tipo_empaque FROM clase_productos WHERE clase_productos.item = pendiente.item) AS tipo_empaque,
 (SELECT clase_productos.id_cello FROM clase_productos WHERE clase_productos.item = pendiente.item) AS cello,
  pendiente.pendiente  AS pendiente,
    pendiente.saldo AS saldo,
     pendiente.paquetes AS paquetes,
      pendiente.unidades AS unidades,
       pendiente.id_pendiente AS id_pendiente_pedido
       FROM pendiente WHERE pendiente.mes =  UPPER( CONCAT( MONTHNAME(fecha)," ",year(fecha))));


END$$

DROP PROCEDURE IF EXISTS `insertar_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_pendiente` (IN `fecha` DATE)  BEGIN
SET lc_time_names = 'es_ES';
insert into pendiente(
	`categoria`,
	`item`,
	`orden_del_sitema`,
	`observacion`,
	`presentacion`,
	`mes`,
	`orden`,
	`marca`,
	`vitola`,
	`nombre`,
	`capa`,
	`tipo_empaque`,
	`cello`,
	`pendiente`,
	`saldo`,
	`paquetes`,
	`unidades`,
serie_precio,
precio	) (SELECT
  pedidos.categoria  AS categoria,
 (SELECT clase_productos.item  FROM clase_productos WHERE clase_productos.item = pedidos.item) AS item,
 '' AS orden_del_sistema,
 '' AS observacion,
 (SELECT clase_productos.presentacion FROM clase_productos WHERE clase_productos.item = pedidos.item) AS presentacion,

(SELECT UPPER( CONCAT( MONTHNAME(fecha)," ",year(fecha)))) AS mes,
pedidos.numero_orden  AS orden,
 (SELECT clase_productos.id_marca FROM clase_productos WHERE clase_productos.item = pedidos.item) AS marca,
 (SELECT clase_productos.id_vitola FROM clase_productos WHERE clase_productos.item = pedidos.item) AS vitola,
 (SELECT clase_productos.id_nombre FROM clase_productos WHERE clase_productos.item = pedidos.item) AS nombre,
 (SELECT clase_productos.id_capa FROM clase_productos WHERE clase_productos.item = pedidos.item) AS capa,
 (SELECT clase_productos.id_tipo_empaque FROM clase_productos WHERE clase_productos.item = pedidos.item) AS tipo_empaque,
 (SELECT clase_productos.id_cello FROM clase_productos WHERE clase_productos.item = pedidos.item) AS cello,
  (pedidos.cant_paquetes * pedidos.unidades)  AS pendiente,
    (pedidos.cant_paquetes * pedidos.unidades) AS saldo,
     pedidos.cant_paquetes AS paquetes,
      pedidos.unidades AS unidades,
       '' AS serie_precio,
       '' AS precio
       FROM pedidos);


DELETE FROM pedidos;

END$$

DROP PROCEDURE IF EXISTS `insertar_productos_terminados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_productos_terminados` (IN `marca` VARCHAR(50), IN `nombre` VARCHAR(50), IN `vitola` VARCHAR(50), IN `capa` VARCHAR(50), IN `existencia` INT)  BEGIN
DECLARE imarca INT;
DECLARE inombre INT;
DECLARE ivitola INT;
DECLARE icapa INT;

SET imarca = (SELECT marca_productos.id_marca FROM marca_productos WHERE marca_productos.marca = marca);
SET inombre = (SELECT nombre_productos.id_nombre FROM nombre_productos WHERE nombre_productos.nombre = nombre);
SET ivitola = (SELECT vitola_productos.id_vitola FROM  vitola_productos WHERE vitola_productos.vitola = vitola);
SET icapa = (SELECT capa_productos.id_capa FROM  capa_productos WHERE capa_productos.capa = capa);

INSERT INTO inventario_productos_terminados
(inventario_productos_terminados.orden_pedido,inventario_productos_terminados.orden_sistema,inventario_productos_terminados.Marca,
inventario_productos_terminados.Alias_vitola,inventario_productos_terminados.Vitola,
inventario_productos_terminados.Nombre_capa,inventario_productos_terminados.Existencia)
VALUES('','',imarca,inombre,ivitola,icapa,existencia);

END$$

DROP PROCEDURE IF EXISTS `insertar_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_programacion` (IN `fecha` DATETIME, IN `contenedor` VARCHAR(100))  BEGIN



INSERT INTO prograamacion(prograamacion.fecha,prograamacion.mes_contenedor)VALUES(cast(fecha AS date),contenedor);


END$$

DROP PROCEDURE IF EXISTS `insertar_pro_terminado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_pro_terminado` (IN `lote` VARCHAR(50), IN `marca` VARCHAR(50), IN `nombre` VARCHAR(50), IN `vitola` VARCHAR(50), IN `capa` VARCHAR(50), IN `existencia` VARCHAR(50))  BEGIN

DECLARE icapa INT;
DECLARE imarca INT;
DECLARE inombre INT;
DECLARE ivitola INT;


SET ivitola = (SELECT vitola_productos.id_vitola FROM  vitola_productos WHERE vitola_productos.vitola = vitola);
SET icapa = (SELECT capa_productos.id_capa FROM  capa_productos WHERE capa_productos.capa = capa);
SET imarca = (SELECT marca_productos.id_marca FROM marca_productos WHERE marca_productos.marca = marca);
SET inombre = (SELECT nombre_productos.id_nombre FROM nombre_productos WHERE nombre_productos.nombre = nombre);


INSERT INTO inventario_productos_terminados(inventario_productos_terminados.lote,
inventario_productos_terminados.Marca, inventario_productos_terminados.Alias_vitola,
inventario_productos_terminados.Vitola,inventario_productos_terminados.Nombre_capa,
inventario_productos_terminados.Existencia)VALUES (lote,imarca,inombre,ivitola,icapa,existencia);

END$$

DROP PROCEDURE IF EXISTS `insertar_tipo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_tipo` (IN `tipo` VARCHAR(50))  BEGIN
INSERT INTO tipo_empaques(tipo_empaques.tipo_empaque)VALUES(tipo);
END$$

DROP PROCEDURE IF EXISTS `insertar_vitola`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_vitola` (IN `vitola` VARCHAR(50))  BEGIN
INSERT INTO vitola_productos(vitola_productos.vitola)VALUES(vitola);
END$$

DROP PROCEDURE IF EXISTS `max_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `max_programacion` (IN `id` INT)  BEGIN

DECLARE MAXi INT;
SET maxi= (SELECT max(prograamacion.id) FROM prograamacion);

if id = 0 then
 SELECT prograamacion.mes_contenedor FROM prograamacion  WHERE prograamacion.id  = maxi;
 else

  SELECT prograamacion.mes_contenedor FROM prograamacion  WHERE prograamacion.id  = id;

 END if;
END$$

DROP PROCEDURE IF EXISTS `mostrar_cajas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_cajas` ()  BEGIN
 SELECT lista_cajas.id,lista_cajas.codigo,lista_cajas.productoServicio,lista_cajas.marca FROM lista_cajas;
END$$

DROP PROCEDURE IF EXISTS `mostrar_cajas_export`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_cajas_export` ()  BEGIN
SELECT lista_cajas.codigo,lista_cajas.productoServicio,lista_cajas.marca,lista_cajas.existencia
FROM lista_cajas
WHERE lista_cajas.existencia > 0;
END$$

DROP PROCEDURE IF EXISTS `mostrar_clase_paradetalle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_clase_paradetalle` (IN `item` VARCHAR(50))  BEGIN


 SELECT clase_productos.id_producto,clase_productos.item,marca_productos.marca, nombre_productos.nombre, vitola_productos.vitola,tipo_empaques.tipo_empaque
FROM clase_productos ,marca_productos,vitola_productos,tipo_empaques,nombre_productos
WHERE  clase_productos.id_vitola = vitola_productos.id_vitola AND
 clase_productos.id_nombre = nombre_productos.id_nombre AND  clase_productos.id_marca = marca_productos.id_marca  AND  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque
 AND clase_productos.item =item ;


END$$

DROP PROCEDURE IF EXISTS `mostrar_datos_para_editar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_datos_para_editar` (IN `id` INT)  BEGIN


 SELECT clase_productos.id_producto ,clase_productos.codigo_producto,clase_productos.codigo_caja,clase_productos.codigo_precio
 ,clase_productos.item,marca_productos.marca, nombre_productos.nombre, vitola_productos.vitola,tipo_empaques.tipo_empaque,clase_productos.presentacion,
 cellos.cello, cellos.anillo, cellos.upc, capa_productos.capa
FROM clase_productos ,marca_productos,vitola_productos,tipo_empaques,nombre_productos,cellos, capa_productos
WHERE  clase_productos.id_vitola = vitola_productos.id_vitola AND capa_productos.id_capa= clase_productos.id_capa and
 clase_productos.id_nombre = nombre_productos.id_nombre AND  clase_productos.id_marca = marca_productos.id_marca
  AND  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque AND cellos.id_cello = clase_productos.id_cello AND clase_productos.id_producto = id;


END$$

DROP PROCEDURE IF EXISTS `mostrar_detallesprovicional_exportar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_detallesprovicional_exportar` ()  BEGIN


SELECT 
detalle_programacion_temporal.numero_orden,
			(SELECT concat(detalle_programacion_temporal.orden ,"-",
	
        ( case SUBSTRING(pendiente_empaque.mes, 1, (LENGTH(pendiente_empaque.mes)-4))
			 	when "ENERO"  then  "01"
			 	when  "FEBRERO"  then  "02"
			 	when  "MARZO"  then  "03"
			 	when "ABRIL" then  "04"
			 	when "MAYO" then  "05"
			 	when  "JUNIO"  then  "06"
			 	when "JULIO" then  "07"
			 	when  "AGOSTO" then  "08"
			 	when "SEPTIEMBRE"then  "09"
			 	when "OCTUBRE" then  "10"
			 	when "NOVIEMBRE"  then  "11"
			 	when  "DICIEMBRE"  then  "12"
			 	
		 	END )
		 	 ,"-",(SUBSTRING(pendiente_empaque.mes,(LENGTH(pendiente_empaque.mes)-4) , 5 ))) FROM pendiente_empaque
			  
			  WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente  ) AS orden,
		   
			(select marca_productos.marca FROM marca_productos WHERE (select pendiente_empaque.marca FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = marca_productos.id_marca) AS marca,
			 
				(select vitola_productos.vitola FROM vitola_productos WHERE (select pendiente_empaque.vitola FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = vitola_productos.id_vitola) AS vitola,
			 
		(select nombre_productos.nombre FROM nombre_productos WHERE (select pendiente_empaque.nombre FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = nombre_productos.id_nombre) AS nombre,
			              
		(select capa_productos.capa FROM capa_productos WHERE (select pendiente_empaque.capa FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = capa_productos.id_capa) AS capa,
			              
 			(select tipo_empaques.tipo_empaque FROM tipo_empaques WHERE (select pendiente_empaque.tipo_empaque FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = tipo_empaques.id_tipo_empaque) AS tipo_empaque,
			 
 				(select cellos.anillo FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = cellos.id_cello) AS anillo,
			 
 			(select cellos.cello FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = cellos.id_cello) AS cello,
			 
		(select cellos.upc FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = cellos.id_cello) AS upc,
			 
			detalle_programacion_temporal.saldo

FROM  detalle_programacion_temporal;	  


END$$

DROP PROCEDURE IF EXISTS `mostrar_detalles_exportar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_detalles_exportar` (IN `busqueda` VARCHAR(50), IN `id` INT)  BEGIN

		DECLARE id_max INT;
		SET id_max = (select MAX(prograamacion.id) FROM prograamacion);

      if busqueda = "" && id = 0 then


SELECT  detalle_programacion.id_detalle_programacion ,
        detalle_programacion.numero_orden,
			detalle_programacion.orden,
			marca_productos.marca,
			vitola_productos.vitola,
			nombre_productos.nombre,
			capa_productos.capa,
 			tipo_empaques.tipo_empaque,
 			cellos.anillo,
 			cellos.cello,
			cellos.upc,
			detalle_programacion.saldo

 FROM  detalle_programacion,
 		 clase_productos,
	    marca_productos,
		 vitola_productos,
		 nombre_productos,
 		 capa_productos,
		 tipo_empaques,
		 cellos,

		 importar_existencias,prograamacion
 WHERE  clase_productos.codigo_producto =  detalle_programacion.cod_producto AND
        clase_productos.id_capa = capa_productos.id_capa AND
 		  clase_productos.id_marca = marca_productos.id_marca AND
        clase_productos.id_vitola = vitola_productos.id_vitola AND
		  clase_productos.id_nombre =  nombre_productos.id_nombre and
 		  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque AND
 		  clase_productos.id_cello = cellos.id_cello and
 		  detalle_programacion.cod_producto = importar_existencias.codigo_producto and
 		  importar_existencias.codigo_producto = clase_productos.codigo_producto and
 		  detalle_programacion.id_programacion =id_max

GROUP BY 1;
ELSE

if  busqueda != "" && id = 0  then

SELECT detalle_programacion.id_detalle_programacion ,
        detalle_programacion.numero_orden,
			detalle_programacion.orden,
			marca_productos.marca,
			vitola_productos.vitola,
			nombre_productos.nombre,
			capa_productos.capa,
 			tipo_empaques.tipo_empaque,
 			cellos.anillo,
 			cellos.cello,
			cellos.upc,
			detalle_programacion.saldo

 FROM  detalle_programacion,
 		 clase_productos,
	    marca_productos,
		 vitola_productos,
		 nombre_productos,
 		 capa_productos,
		 tipo_empaques,
		 cellos,
		 importar_existencias, prograamacion
 WHERE  clase_productos.codigo_producto =  detalle_programacion.cod_producto AND
        clase_productos.id_capa = capa_productos.id_capa AND
 		  clase_productos.id_marca = marca_productos.id_marca AND
        clase_productos.id_vitola = vitola_productos.id_vitola AND
		  clase_productos.id_nombre =  nombre_productos.id_nombre and
 		  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque AND
 		  clase_productos.id_cello = cellos.id_cello and
 		  detalle_programacion.cod_producto = importar_existencias.codigo_producto and
 		  importar_existencias.codigo_producto = clase_productos.codigo_producto and
 		  (detalle_programacion.numero_orden LIKE CONCAT("%",busqueda,"%")||
			detalle_programacion.orden LIKE CONCAT("%",busqueda,"%")||
			marca_productos.marca LIKE CONCAT("%",busqueda,"%")||
			nombre_productos.nombre LIKE CONCAT("%",busqueda,"%")||
			capa_productos.capa LIKE CONCAT("%",busqueda,"%")) AND
			detalle_programacion.id_programacion = id_max

GROUP BY 1;



else

SELECT detalle_programacion.id_detalle_programacion,
        detalle_programacion.numero_orden,
			detalle_programacion.orden,
			marca_productos.marca,
			vitola_productos.vitola,
			nombre_productos.nombre,
			capa_productos.capa,
 			tipo_empaques.tipo_empaque,
 			cellos.anillo,
 			cellos.cello,
			cellos.upc,
			detalle_programacion.saldo
 FROM  detalle_programacion,
 		 clase_productos,
	    marca_productos,
		 vitola_productos,
		 nombre_productos,
 		 capa_productos,
		 tipo_empaques,
		 cellos,
		 importar_existencias, prograamacion
 WHERE  clase_productos.codigo_producto =  detalle_programacion.cod_producto AND
        clase_productos.id_capa = capa_productos.id_capa AND
 		  clase_productos.id_marca = marca_productos.id_marca AND
        clase_productos.id_vitola = vitola_productos.id_vitola AND
		  clase_productos.id_nombre =  nombre_productos.id_nombre and
 		  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque AND
 		  clase_productos.id_cello = cellos.id_cello and
 		  detalle_programacion.cod_producto = importar_existencias.codigo_producto and
 		  importar_existencias.codigo_producto = clase_productos.codigo_producto and
 		  (detalle_programacion.numero_orden LIKE CONCAT("%",busqueda,"%")||
			detalle_programacion.orden LIKE CONCAT("%",busqueda,"%")||
			marca_productos.marca LIKE CONCAT("%",busqueda,"%")||
			nombre_productos.nombre LIKE CONCAT("%",busqueda,"%")||
			capa_productos.capa LIKE CONCAT("%",busqueda,"%")) AND
			detalle_programacion.id_programacion = id

GROUP BY 1;

		 END if;
		 	 END if;

END$$

DROP PROCEDURE IF EXISTS `mostrar_detalles_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_detalles_productos` ()  BEGIN


 SELECT detalle_clase_productos.id_producto,detalle_clase_productos.item,marca_productos.marca, nombre_productos.nombre, vitola_productos.vitola,tipo_empaques.tipo_empaque, capa_productos.capa
FROM detalle_clase_productos ,marca_productos,vitola_productos,tipo_empaques,nombre_productos, capa_productos
WHERE  detalle_clase_productos.id_vitola = vitola_productos.id_vitola AND detalle_clase_productos.id_capa = capa_productos.id_capa and
 detalle_clase_productos.id_nombre = nombre_productos.id_nombre AND  detalle_clase_productos.id_marca = marca_productos.id_marca  AND  detalle_clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque
;


END$$

DROP PROCEDURE IF EXISTS `mostrar_detalles_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_detalles_programacion` (IN `busqueda` VARCHAR(50), IN `id` INT)  BEGIN

		DECLARE id_max INT;
		SET id_max = (select MAX(prograamacion.id) FROM prograamacion);

      if busqueda = "" && id = 0 then


SELECT  detalle_programacion.id_detalle_programacion ,
        detalle_programacion.numero_orden,
			detalle_programacion.cod_producto,
				detalle_programacion.orden,
			(select marca_productos.marca FROM marca_productos WHERE (select pendiente_empaque.marca FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = marca_productos.id_marca) AS marca,

				(select vitola_productos.vitola FROM vitola_productos WHERE (select pendiente_empaque.vitola FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = vitola_productos.id_vitola) AS vitola,

		(select nombre_productos.nombre FROM nombre_productos WHERE (select pendiente_empaque.nombre FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = nombre_productos.id_nombre) AS nombre,

			(select capa_productos.capa FROM capa_productos WHERE (select pendiente_empaque.capa FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = capa_productos.id_capa) AS capa,

 			(select tipo_empaques.tipo_empaque FROM tipo_empaques WHERE (select pendiente_empaque.tipo_empaque FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = tipo_empaques.id_tipo_empaque) AS tipo_empaque,

 				(select cellos.anillo FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = cellos.id_cello) AS anillo,

 			(select cellos.cello FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = cellos.id_cello) AS cello,

		(select cellos.upc FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = cellos.id_cello) AS upc,

			detalle_programacion.saldo,
			prograamacion.id,
			detalle_programacion.id_pendiente,

				(SELECT 	if (detalle_programacion.cant_cajas < 0,
		   CONCAT("Faltan ",detalle_programacion.cant_cajas, " cajas") ,

		 CONCAT("Sobran ",detalle_programacion.cant_cajas, " cajas") )) AS cajas,


			detalle_programacion.cant_cajas,

				 (SELECT detalle_programacion.saldo/


		 (

		 SELECT SUBSTRING((select tipo_empaques.tipo_empaque FROM tipo_empaques
		 WHERE tipo_empaques.id_tipo_empaque = (select pendiente_empaque.tipo_empaque FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) AND tipo_empaques.tipo_empaque LIKE CONCAT("%","CAJAS","%")


			 ) , 9, 3))) AS cant_cajas_necesarias

 FROM  detalle_programacion,
 		 clase_productos,
	    marca_productos,
		 vitola_productos,
		 nombre_productos,
 		 capa_productos,
		 tipo_empaques,
		 cellos,

		 importar_existencias,prograamacion
 WHERE  clase_productos.codigo_producto =  detalle_programacion.cod_producto AND
        clase_productos.id_capa = capa_productos.id_capa AND
 		  clase_productos.id_marca = marca_productos.id_marca AND
        clase_productos.id_vitola = vitola_productos.id_vitola AND
		  clase_productos.id_nombre =  nombre_productos.id_nombre and
 		  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque AND
 		  clase_productos.id_cello = cellos.id_cello and
 		  detalle_programacion.cod_producto = importar_existencias.codigo_producto and
 		  importar_existencias.codigo_producto = clase_productos.codigo_producto and
 		  detalle_programacion.id_programacion =id_max

GROUP BY 1;
ELSE

if  busqueda != "" && id = 0  then

SELECT  detalle_programacion.id_detalle_programacion ,
        detalle_programacion.numero_orden,
			detalle_programacion.cod_producto,
				detalle_programacion.orden,
			(select marca_productos.marca FROM marca_productos WHERE (select pendiente_empaque.marca FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = marca_productos.id_marca) AS marca,

				(select vitola_productos.vitola FROM vitola_productos WHERE (select pendiente_empaque.vitola FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = vitola_productos.id_vitola) AS vitola,

		(select nombre_productos.nombre FROM nombre_productos WHERE (select pendiente_empaque.nombre FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = nombre_productos.id_nombre) AS nombre,

			(select capa_productos.capa FROM capa_productos WHERE (select pendiente_empaque.capa FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = capa_productos.id_capa) AS capa,

 			(select tipo_empaques.tipo_empaque FROM tipo_empaques WHERE (select pendiente_empaque.tipo_empaque FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = tipo_empaques.id_tipo_empaque) AS tipo_empaque,

 				(select cellos.anillo FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = cellos.id_cello) AS anillo,

 			(select cellos.cello FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = cellos.id_cello) AS cello,

		(select cellos.upc FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) = cellos.id_cello) AS upc,

			detalle_programacion.saldo,
			prograamacion.id,
			detalle_programacion.id_pendiente,
		(SELECT 	if (detalle_programacion.cant_cajas < 0,
		   CONCAT("Faltan ",detalle_programacion.cant_cajas, " cajas") ,

		 CONCAT("Sobran ",detalle_programacion.cant_cajas, " cajas") )) AS cajas,
			detalle_programacion.cant_cajas

 FROM  detalle_programacion,
 		 clase_productos,
	    marca_productos,
		 vitola_productos,
		 nombre_productos,
 		 capa_productos,
		 tipo_empaques,
		 cellos,
		 importar_existencias, prograamacion
 WHERE  clase_productos.codigo_producto =  detalle_programacion.cod_producto AND
        clase_productos.id_capa = capa_productos.id_capa AND
 		  clase_productos.id_marca = marca_productos.id_marca AND
        clase_productos.id_vitola = vitola_productos.id_vitola AND
		  clase_productos.id_nombre =  nombre_productos.id_nombre and
 		  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque AND
 		  clase_productos.id_cello = cellos.id_cello and
 		  detalle_programacion.cod_producto = importar_existencias.codigo_producto and
 		  importar_existencias.codigo_producto = clase_productos.codigo_producto and
 		  (detalle_programacion.numero_orden LIKE CONCAT("%",busqueda,"%")||
			detalle_programacion.orden LIKE CONCAT("%",busqueda,"%")||
			marca_productos.marca LIKE CONCAT("%",busqueda,"%")||
			nombre_productos.nombre LIKE CONCAT("%",busqueda,"%")||
			capa_productos.capa LIKE CONCAT("%",busqueda,"%")) AND
			detalle_programacion.id_programacion = id_max

GROUP BY 1;



else

SELECT detalle_programacion.id_detalle_programacion,
        detalle_programacion.numero_orden,
			detalle_programacion.cod_producto,
			detalle_programacion.orden,
			marca_productos.marca,
			vitola_productos.vitola,
			nombre_productos.nombre,
			capa_productos.capa,
 			tipo_empaques.tipo_empaque,
 			cellos.anillo,
 			cellos.cello,
			cellos.upc,
			detalle_programacion.saldo,
			prograamacion.id,
			detalle_programacion.id_pendiente,
			(SELECT 	if (detalle_programacion.cant_cajas < 0,
		   CONCAT("Faltan ",detalle_programacion.cant_cajas, " cajas") ,

		 CONCAT("Sobran ",detalle_programacion.cant_cajas, " cajas") )) AS cajas,

			(SELECT 	if (detalle_programacion.cant_cajas < 0,
		   CONCAT("Faltan ",detalle_programacion.cant_cajas, " cajas") ,

		 CONCAT("Sobran ",detalle_programacion.cant_cajas, " cajas") )) AS cajas,


			detalle_programacion.cant_cajas,

				 (SELECT detalle_programacion.saldo/


		 (

		 SELECT SUBSTRING((select tipo_empaques.tipo_empaque FROM tipo_empaques
		 WHERE tipo_empaques.id_tipo_empaque = (select pendiente_empaque.tipo_empaque FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion.id_pendiente) AND tipo_empaques.tipo_empaque LIKE CONCAT("%","CAJAS","%")


			 ) , 9, 3))) AS cant_cajas_necesarias

 FROM  detalle_programacion,
 		 clase_productos,
	    marca_productos,
		 vitola_productos,
		 nombre_productos,
 		 capa_productos,
		 tipo_empaques,
		 cellos,
		 importar_existencias, prograamacion
 WHERE  clase_productos.codigo_producto =  detalle_programacion.cod_producto AND
        clase_productos.id_capa = capa_productos.id_capa AND
 		  clase_productos.id_marca = marca_productos.id_marca AND
        clase_productos.id_vitola = vitola_productos.id_vitola AND
		  clase_productos.id_nombre =  nombre_productos.id_nombre and
 		  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque AND
 		  clase_productos.id_cello = cellos.id_cello and
 		  detalle_programacion.cod_producto = importar_existencias.codigo_producto and
 		  importar_existencias.codigo_producto = clase_productos.codigo_producto and
 		  (detalle_programacion.numero_orden LIKE CONCAT("%",busqueda,"%")||
			detalle_programacion.orden LIKE CONCAT("%",busqueda,"%")||
			marca_productos.marca LIKE CONCAT("%",busqueda,"%")||
			nombre_productos.nombre LIKE CONCAT("%",busqueda,"%")||
			capa_productos.capa LIKE CONCAT("%",busqueda,"%")) AND
			detalle_programacion.id_programacion = id

GROUP BY 1;

		 END if;
		 	 END if;

END$$

DROP PROCEDURE IF EXISTS `mostrar_detalles_provicional`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_detalles_provicional` (IN `busqueda` VARCHAR(50))  BEGIN

DECLARE codigo_caja VARCHAR(50);


SELECT  detalle_programacion_temporal.id_detalle_programacion AS id,
detalle_programacion_temporal.numero_orden,
			detalle_programacion_temporal.cod_producto ,
			(SELECT concat(detalle_programacion_temporal.orden ,"-",

        ( case SUBSTRING(pendiente_empaque.mes, 1, (LENGTH(pendiente_empaque.mes)-4))
			 	when "ENERO"  then  "01"
			 	when  "FEBRERO"  then  "02"
			 	when  "MARZO"  then  "03"
			 	when "ABRIL" then  "04"
			 	when "MAYO" then  "05"
			 	when  "JUNIO"  then  "06"
			 	when "JULIO" then  "07"
			 	when  "AGOSTO" then  "08"
			 	when "SEPTIEMBRE"then  "09"
			 	when "OCTUBRE" then  "10"
			 	when "NOVIEMBRE"  then  "11"
			 	when  "DICIEMBRE"  then  "12"

		 	END )
		 	 ,"-",(SUBSTRING(pendiente_empaque.mes,(LENGTH(pendiente_empaque.mes)-4) , 5 ))) FROM pendiente_empaque

			  WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente  ) AS orden,







			(select marca_productos.marca FROM marca_productos WHERE (select pendiente_empaque.marca FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = marca_productos.id_marca) AS marca,

				(select vitola_productos.vitola FROM vitola_productos WHERE (select pendiente_empaque.vitola FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = vitola_productos.id_vitola) AS vitola,

		(select nombre_productos.nombre FROM nombre_productos WHERE (select pendiente_empaque.nombre FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = nombre_productos.id_nombre) AS nombre,

		(select capa_productos.capa FROM capa_productos WHERE (select pendiente_empaque.capa FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = capa_productos.id_capa) AS capa,

 			(select tipo_empaques.tipo_empaque FROM tipo_empaques WHERE (select pendiente_empaque.tipo_empaque FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = tipo_empaques.id_tipo_empaque) AS tipo_empaque,

 				(select cellos.anillo FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = cellos.id_cello) AS anillo,

 			(select cellos.cello FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = cellos.id_cello) AS cello,

		(select cellos.upc FROM cellos WHERE (select pendiente_empaque.cello FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = cellos.id_cello) AS upc,

			detalle_programacion_temporal.saldo,
			(SELECT SUM(importar_existencias.total) FROM importar_existencias WHERE importar_existencias.codigo_producto = detalle_programacion_temporal.cod_producto)  AS total_existencia,
			((SELECT SUM(importar_existencias.total) FROM importar_existencias WHERE importar_existencias.codigo_producto = detalle_programacion_temporal.cod_producto) - detalle_programacion_temporal.saldo) AS diferencia,
       	(SELECT 	if (detalle_programacion_temporal.cant_cajas < 0,
		   CONCAT("Faltan ",detalle_programacion_temporal.cant_cajas, " cajas") ,

		 CONCAT("Sobran ",detalle_programacion_temporal.cant_cajas, " cajas") )) AS existencia,

		  (SELECT detalle_programacion_temporal.saldo/


		 (

		 SELECT SUBSTRING((select tipo_empaques.tipo_empaque FROM tipo_empaques
		 WHERE tipo_empaques.id_tipo_empaque = (select pendiente_empaque.tipo_empaque FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) AND tipo_empaques.tipo_empaque LIKE CONCAT("%","CAJAS","%")


			 ) , 9, 3)

		 )) AS cant_cajas_necesarias,


		 detalle_programacion_temporal.id_pendiente,
		 detalle_programacion_temporal.cant_cajas

 FROM  detalle_programacion_temporal
 WHERE  (detalle_programacion_temporal.numero_orden LIKE CONCAT("%",busqueda,"%")||
			detalle_programacion_temporal.orden LIKE CONCAT("%",busqueda,"%")||
			(select marca_productos.marca FROM marca_productos WHERE (select pendiente_empaque.marca FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = marca_productos.id_marca)
			 LIKE CONCAT("%",busqueda,"%")||
		(select nombre_productos.nombre FROM nombre_productos WHERE (select pendiente_empaque.nombre FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = nombre_productos.id_nombre)
		 LIKE CONCAT("%",busqueda,"%")||
			(select capa_productos.capa FROM capa_productos WHERE (select pendiente_empaque.capa FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = detalle_programacion_temporal.id_pendiente) = capa_productos.id_capa)
			   LIKE CONCAT("%",busqueda,"%"))

GROUP BY 1;

END$$

DROP PROCEDURE IF EXISTS `mostrar_detalle_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_detalle_factura` (IN `pa_tipo_factura` VARCHAR(10))  BEGIN
SELECT `id_detalle`,
	`id_venta`,
	`id_pendiente`,
	`cantidad_puros`,
	`unidad`,
	(CAST(((`cantidad_puros`*`unidad`)/cantidad_cajas) AS DECIMAL(9,0))) AS cantidad_cajas,
	`cantidad_puros`*`unidad` AS total_tabacos,

	(SELECT (UPPER((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS capas,
	`cantidad_cajas` AS 'cantidad_por_caja'

	,(SELECT UPPER(CONCAT((SELECT tipo_empaques.tipo_empaque_ingles FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque)
		 ," ",
	    (SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = clase_productos.id_vitola)
		 ," ",
		 (SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ," ",
		 (SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre)
		 ," ",
		 (SELECT case cello
			 	when cello != "SI"  then  "CELLO"
			 	when cello != "NO"  then  ""
		 	END AS celloss
			FROM cellos
		   WHERE cellos.id_cello = clase_productos.id_cello)
		 )) AS producto
	FROM clase_productos
	WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)
	) AS producto,

	(SELECT clase_productos.codigo_precio
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo
	,

	(SELECT clase_productos.item
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo_item
	,
	(SELECT CONCAT(pendiente.orden) AS oer
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden,

		(SELECT  pendiente.pendiente
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden_total,

		(SELECT pendiente.saldo - total_tabacos
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden_restante,

	`peso_bruto`*`cantidad_puros` AS total_bruto,
	`peso_neto`*`cantidad_puros`AS total_neto,
	(SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente ) AS precio_producto,

	((CAST((SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente )  AS DECIMAL(9,0)) * `cantidad_cajas`)/1000) AS costo,

	(((CAST((SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente )  AS DECIMAL(9,0)) * `cantidad_cajas`)/1000)*
	(CAST(((`cantidad_puros`*`unidad`)/cantidad_cajas) AS DECIMAL(9,0)))) AS valor_total


FROM detalle_factura
WHERE `facturado` = "N" AND (SELECT pendiente.orden AS oer
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) LIKE CONCAT("%",pa_tipo_factura,"%");



END$$

DROP PROCEDURE IF EXISTS `mostrar_detalle_factura_export`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_detalle_factura_export` (IN `fac` VARCHAR(50))  BEGIN
SELECT `id_detalle`,
	`id_venta`,
	`id_pendiente`,
	`cantidad_puros`,
	`unidad`,
	(CAST(((`cantidad_puros`*`unidad`)/cantidad_cajas) AS DECIMAL(9,0))) AS cantidad_cajas,
	`cantidad_puros`*`unidad` AS total_tabacos,

	(SELECT (UPPER((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS capas,
	`cantidad_cajas` AS 'cantidad_por_caja'

	,(SELECT UPPER(CONCAT((SELECT tipo_empaques.tipo_empaque_ingles FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque)
		 ," ",
	    (SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = clase_productos.id_vitola)
		 ," ",
		 (SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ," ",
		 (SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre)
		 ," ",
		 (SELECT case cello
			 	when cello != "SI"  then  "CELLO"
			 	when cello != "NO"  then  ""
		 	END AS celloss
			FROM cellos
		   WHERE cellos.id_cello = clase_productos.id_cello)
		 )) AS producto
	FROM clase_productos
	WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)
	) AS producto,

	(SELECT clase_productos.codigo_precio
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo
	,

	(SELECT clase_productos.item
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo_item
	,
	(SELECT CONCAT(pendiente.orden ) AS oer
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden,

		(SELECT  pendiente.pendiente
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden_total,

		(SELECT pendiente.saldo - total_tabacos
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden_restante,

	`peso_bruto`*`cantidad_puros` AS total_bruto,
	`peso_neto`*`cantidad_puros`AS total_neto,
	(SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente ) AS precio_producto,

	((CAST((SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente )  AS DECIMAL(9,0)) * `cantidad_cajas`)/1000) AS costo,

	(((CAST((SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente )  AS DECIMAL(9,0)) * `cantidad_cajas`)/1000)*
	(CAST(((`cantidad_puros`*`unidad`)/cantidad_cajas) AS DECIMAL(9,0)))) AS valor_total


FROM detalle_factura,factura_terminados
WHERE detalle_factura.id_venta = factura_terminados.id AND factura_terminados.numero_factura = fac;
END$$

DROP PROCEDURE IF EXISTS `mostrar_existencia_bodega`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_existencia_bodega` ()  BEGIN
 SELECT importar_existencias.id , importar_existencias.codigo_producto ,
importar_existencias.marca,importar_existencias.nombre, importar_existencias.vitola,importar_existencias.capa
, importar_existencias.total
from  importar_existencias;
END$$

DROP PROCEDURE IF EXISTS `mostrar_lista_cajas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_lista_cajas` ()  BEGIN
SELECT * FROM lista_cajas;
END$$

DROP PROCEDURE IF EXISTS `mostrar_lista_inventario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_lista_inventario` ()  BEGIN


SELECT  inventario_productos_terminados.id, inventario_productos_terminados.orden_pedido,
inventario_productos_terminados.orden_sistema,marca_productos.marca, nombre_productos.nombre,
vitola_productos.vitola, capa_productos.capa,
inventario_productos_terminados.Existencia
 FROM inventario_productos_terminados, marca_productos, nombre_productos,vitola_productos
 ,capa_productos
 WHERE inventario_productos_terminados.Marca = marca_productos.id_marca and
  inventario_productos_terminados.Alias_vitola = nombre_productos.id_nombre and
inventario_productos_terminados.Vitola = vitola_productos.id_vitola AND
 inventario_productos_terminados.Nombre_capa = capa_productos.id_capa;


END$$

DROP PROCEDURE IF EXISTS `mostrar_lista_productos_terminados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_lista_productos_terminados` ()  BEGIN
SELECT inventario_productos_terminados.id,inventario_productos_terminados.Existencia FROM inventario_productos_terminados;
END$$

DROP PROCEDURE IF EXISTS `mostrar_pedido`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_pedido` ()  BEGIN



SELECT

		(SELECT categoria.categoria FROM categoria WHERE categoria.id_categoria
		 = pedidos.categoria) AS categorias,
		pedidos.item,
		pedidos.cant_paquetes,
		pedidos.unidades,
		pedidos.numero_orden,
		(SELECT CONCAT( (SELECT tipo_empaques.tipo_empaque from tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque)," ",
					(SELECT marca_productos.marca from marca_productos WHERE marca_productos.id_marca =clase_productos.id_marca)," ",
					(SELECT nombre_productos.nombre from nombre_productos WHERE nombre_productos.id_nombre =clase_productos.id_nombre)," ",
					(SELECT capa_productos.capa from capa_productos WHERE capa_productos.id_capa =clase_productos.id_capa)," ",
					(SELECT vitola_productos.vitola from vitola_productos WHERE vitola_productos.id_vitola =clase_productos.id_vitola)	) AS des FROM clase_productos WHERE clase_productos.item = pedidos.item) AS descripcion

FROM pedidos;
END$$

DROP PROCEDURE IF EXISTS `mostrar_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_pendiente` ()  BEGIN

SELECT pendiente.id_pendiente, categoria.categoria AS categoria, pendiente.item AS item,pendiente.orden_del_sitema AS orden_del_sitema,pendiente.observacion AS observacion,pendiente.presentacion AS presentacion ,pendiente.mes AS mes ,orden_productos.orden AS orden, marca_productos.marca AS marca,vitola_productos.vitola AS vitola,
nombre_productos.nombre AS nombre, capa_productos.capa AS capa,
cellos.anillo AS anillo,cellos.cello AS cello, cellos.upc AS upc, pendiente.pendiente as pendiente,pendiente.factura_del_mes as factura_del_mes, pendiente.cantidad_enviada_mes AS cantidad_enviada_mes, pendiente.saldo AS saldo, tipo_empaques.tipo_empaque AS tipo_empaque
FROM categoria, clase_productos, marca_productos, vitola_productos,nombre_productos, capa_productos, orden_productos,cellos,
tipo_empaques, pendiente
WHERE pendiente.vitola = vitola_productos.id_vitola AND pendiente.capa = capa_productos.id_capa and
 pendiente.nombre = nombre_productos.id_nombre AND  pendiente.marca = marca_productos.id_marca AND
   pendiente.tipo_empaque = tipo_empaques.id_tipo_empaque AND pendiente.categoria = categoria.id_categoria
	GROUP BY pendiente.item, pendiente.categoria
	;

END$$

DROP PROCEDURE IF EXISTS `mostrar_pendiente_empaque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_pendiente_empaque` ()  BEGIN

SELECT categoria.categoria AS categoria, pendiente_empaque.item AS item,pendiente_empaque.orden_del_sitema AS orden_del_sitema,pendiente_empaque.observacion AS observacion,pendiente_empaque.presentacion AS presentacion ,pendiente_empaque.mes AS mes ,orden_productos.orden AS orden, marca_productos.marca AS marca,vitola_productos.vitola AS vitola,
nombre_productos.nombre AS nombre, capa_productos.capa AS capa,
cellos.anillo AS anillo,cellos.cello AS cello, cellos.upc AS upc, pendiente_empaque.pendiente as pendiente_empaque,pendiente_empaque.factura_del_mes as factura_del_mes, pendiente_empaque.cantidad_enviada_mes AS cantidad_enviada_mes, pendiente_empaque.saldo AS saldo, tipo_empaques.tipo_empaque AS tipo_empaque
FROM categoria, clase_productos, marca_productos, vitola_productos,nombre_productos, capa_productos, orden_productos,cellos,
tipo_empaques, pendiente_empaque
WHERE pendiente_empaque.vitola = vitola_productos.id_vitola AND pendiente_empaque.capa = capa_productos.id_capa  and
 pendiente_empaque.nombre = nombre_productos.id_nombre AND  pendiente_empaque.marca = marca_productos.id_marca AND cellos.id_cello=pendiente_empaque.cello AND orden_productos.id_orden =pendiente_empaque.orden and
   pendiente_empaque.tipo_empaque = tipo_empaques.id_tipo_empaque AND pendiente_empaque.categoria = categoria.id_categoria AND
   pendiente_empaque.saldo > 0
	GROUP BY pendiente_empaque.item, pendiente_empaque.orden, pendiente_empaque.categoria;

END$$

DROP PROCEDURE IF EXISTS `mostrar_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_productos` ()  BEGIN


 SELECT clase_productos.id_producto ,clase_productos.codigo_producto,clase_productos.codigo_caja,clase_productos.codigo_precio
 ,clase_productos.item,marca_productos.marca, nombre_productos.nombre, vitola_productos.vitola,tipo_empaques.tipo_empaque,clase_productos.presentacion,
 cellos.cello, cellos.anillo, cellos.upc, capa_productos.capa, clase_productos.sampler
FROM clase_productos ,marca_productos,vitola_productos,tipo_empaques,nombre_productos,cellos, capa_productos
WHERE  clase_productos.id_vitola = vitola_productos.id_vitola AND clase_productos.id_capa = capa_productos.capa and
 clase_productos.id_nombre = nombre_productos.id_nombre AND  clase_productos.id_marca = marca_productos.id_marca
  AND  clase_productos.id_tipo_empaque = tipo_empaques.id_tipo_empaque AND cellos.id_cello = clase_productos.id_cello;


END$$

DROP PROCEDURE IF EXISTS `mostrar_programacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_programacion` ()  BEGIN


  SELECT * FROM prograamacion ORDER by prograamacion.id desc;
END$$

DROP PROCEDURE IF EXISTS `reporte_capas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_capas` (IN `pa_capa` TEXT)  BEGIN
SELECT DISTINCT (SELECT (UPPER((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS capas
FROM detalle_factura
WHERE `facturado` = "S" AND (SELECT DISTINCT(SELECT (UPPER((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente))) LIKE CONCAT("%",pa_capa,"%");
END$$

DROP PROCEDURE IF EXISTS `reporte_facura_pendiente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_facura_pendiente` (IN `fecha` DATE, IN `marca` VARCHAR(200), IN `nombre` VARCHAR(50), IN `capa` VARCHAR(50), IN `factura` VARCHAR(50))  BEGIN
 SELECT

	(SELECT clase_productos.item
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo_item
	,

		(SELECT (UPPER(((SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS marca,


		(SELECT (UPPER((SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS nombre,
	(SELECT (UPPER((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS capas,

	(SELECT (UPPER((SELECT tipo_empaques.tipo_empaque FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque))) AS tipo_empaque
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS tipo_empaque,



	(SELECT UPPER(CONCAT((SELECT tipo_empaques.tipo_empaque_ingles FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque)
		 ," ",
	    (SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = clase_productos.id_vitola)
		 ," ",
		 (SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ," ",
		 (SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre)
		 ," ",
		 (SELECT case cello
			 	when cello != "SI"  then  "CELLO"
			 	when cello != "NO"  then  ""
		 	END AS celloss
			FROM cellos
		   WHERE cellos.id_cello = clase_productos.id_cello)
		 )) AS producto
	FROM clase_productos
	WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)
	) AS producto,
	(CAST(((`cantidad_puros`*`unidad`)/cantidad_cajas) AS DECIMAL(9,0))) AS cantidad_cajas,

	`cantidad_puros`*`unidad` AS total_tabacos,

	(SELECT CONCAT(pendiente.orden) AS oer
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden,

	(SELECT factura_terminados.numero_factura FROM factura_terminados  WHERE factura_terminados.id = detalle_factura.id_venta) AS num_factura,

	(SELECT factura_terminados.contenedor FROM factura_terminados WHERE factura_terminados.id = detalle_factura.id_venta) AS contenedor,

		(SELECT factura_terminados.fecha_factura FROM factura_terminados WHERE factura_terminados.id = detalle_factura.id_venta) AS fecha

FROM detalle_factura
WHERE `facturado` = "S" AND
	year((SELECT factura_terminados.fecha_factura FROM factura_terminados WHERE factura_terminados.id = detalle_factura.id_venta)) = year(fecha) AND
	month((SELECT factura_terminados.fecha_factura FROM factura_terminados WHERE factura_terminados.id = detalle_factura.id_venta)) = month(fecha) AND
	((SELECT (UPPER(((SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente))) LIKE (CONCAT("%",marca,"%")) AND

	((SELECT (UPPER((SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente))) LIKE (CONCAT("%",nombre,"%")) AND

											((SELECT (UPPER((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente))) LIKE (CONCAT("%",capa,"%"))
											AND  (
												(SELECT factura_terminados.numero_factura FROM factura_terminados  WHERE factura_terminados.id = detalle_factura.id_venta) LIKE (CONCAT("%",factura,"%")) OR

	(SELECT factura_terminados.contenedor FROM factura_terminados WHERE factura_terminados.id = detalle_factura.id_venta) LIKE (CONCAT("%",factura,"%")) OR (SELECT clase_productos.item
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) LIKE (CONCAT("%",factura,"%")) );

 end$$

DROP PROCEDURE IF EXISTS `reporte_marcas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_marcas` (IN `pa_marca` TEXT)  BEGIN
SELECT DISTINCT (SELECT (UPPER(((SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS marca
FROM detalle_factura
WHERE `facturado` = "S" AND ((SELECT (UPPER(((SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente))) LIKE CONCAT("%",pa_marca,"%");

END$$

DROP PROCEDURE IF EXISTS `reporte_nombres`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_nombres` (IN `pa_nombre` TEXT)  BEGIN

SELECT DISTINCT (SELECT (UPPER((SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS nombre
FROM detalle_factura
WHERE `facturado` = "S" AND (
(SELECT (UPPER((SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente))) LIKE CONCAT("%", pa_nombre,"%");


END$$

DROP PROCEDURE IF EXISTS `sustraer_total`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sustraer_total` (IN `total` VARCHAR(50))  BEGIN

 DECLARE inicio VARCHAR(50);
 DECLARE fin VARCHAR(50);
 DECLARE tamano INT;
 DECLARE con INT;
 DECLARE localizacion INT;
 DECLARE nuevo_total VARCHAR(50);


 SET con = 0;
 SET localizacion =  (select LOCATE(',',total));
 SET inicio = (SELECT SUBSTRING_INDEX(total, ',', 1));
 SET fin =  (SELECT SUBSTRING(total, LENGTH(total) - 5, 6));
 SET tamano = LENGTH(total);

 if localizacion >0 then



 SET nuevo_total = CONCAT(inicio, fin);

 else
 SET nuevo_total = total;
 END if;

SELECT CAST(nuevo_total AS DECIMAL(10,2)), fin, inicio;

END$$

DROP PROCEDURE IF EXISTS `traer_cant_cajas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_cant_cajas` (IN `id_pendiente` INT)  BEGIn


		 SELECT SUBSTRING((select tipo_empaques.tipo_empaque FROM tipo_empaques
		 WHERE tipo_empaques.id_tipo_empaque = (select pendiente_empaque.tipo_empaque FROM pendiente_empaque
			 WHERE pendiente_empaque.id_pendiente = id_pendiente) AND tipo_empaques.tipo_empaque LIKE CONCAT("%","CAJAS","%")


			 ) , 9, 3) AS cajas_tipo ;
END$$

DROP PROCEDURE IF EXISTS `traer_categoria_id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_categoria_id` (IN `pa_categoria` VARCHAR(50))  BEGIN
IF pa_categoria = "CATALAGO" THEN

SELECT categoria.id_categoria FROM  categoria WHERE categoria.categoria = "CATALOGO";

ELSE
 SELECT categoria.id_categoria FROM  categoria WHERE categoria.categoria = pa_categoria;

 END IF;
END$$

DROP PROCEDURE IF EXISTS `traer_datos_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_datos_productos` (IN `item` VARCHAR(50))  BEGIN

SELECT * FROM clase_productos WHERE clase_productos.item = item;
END$$

DROP PROCEDURE IF EXISTS `traer_descripcion_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_descripcion_factura` (IN `pa_id_pendiente` INT)  BEGIN
(SELECT UPPER(CONCAT((SELECT tipo_empaques.tipo_empaque_ingles FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque)
		 ," ",
	    (SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = clase_productos.id_vitola)
		 ," ",
		 (SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ," ",
		 (SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre)
		 ," ",
		 (SELECT case cello
			 	when cello != "SI"  then  "CELLO"
			 	when cello != "NO"  then  ""
		 	END AS celloss
			FROM cellos
		   WHERE cellos.id_cello = clase_productos.id_cello)
		 )) AS producto
	FROM clase_productos
	WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente = pa_id_pendiente     )
	);
END$$

DROP PROCEDURE IF EXISTS `traer_detalles_editar_capa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_detalles_editar_capa` (IN `pa_id` INT)  BEGIN
SELECT capa FROM capa_productos WHERE id_capa = pa_id;
END$$

DROP PROCEDURE IF EXISTS `traer_detalles_editar_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_detalles_editar_factura` (IN `pa_id` INT)  BEGIN
 SELECT `id_detalle`,
	`id_venta`,
	`id_pendiente`,
	`cantidad_puros`,
	`unidad`,
	(CAST(((`cantidad_puros`*`unidad`)/cantidad_cajas) AS DECIMAL(9,0))) AS cantidad_cajas,
	`cantidad_puros`*`unidad` AS total_tabacos,

	(SELECT (UPPER((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS capas,
	`cantidad_cajas` AS 'cantidad_por_caja'

	,(SELECT UPPER(CONCAT((SELECT tipo_empaques.tipo_empaque_ingles FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque)
		 ," ",
	    (SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = clase_productos.id_vitola)
		 ," ",
		 (SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ," ",
		 (SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre)
		 ," ",
		 (SELECT case cello
			 	when cello != "SI"  then  "CELLO"
			 	when cello != "NO"  then  ""
		 	END AS celloss
			FROM cellos
		   WHERE cellos.id_cello = clase_productos.id_cello)
		 )) AS producto
	FROM clase_productos
	WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)
	) AS producto,

	(SELECT clase_productos.codigo_precio
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo
	,

	(SELECT clase_productos.item
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo_item
	,
	(SELECT CONCAT(pendiente.orden ,"-", MONTH(pendiente.mes) , "-" , date_format(pendiente.mes,'%y')) AS oer
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden,

		(SELECT  pendiente.pendiente
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden_total,

		(SELECT pendiente.saldo - total_tabacos
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden_restante,

	`peso_bruto`*`cantidad_puros` AS total_bruto,
	`peso_neto`*`cantidad_puros`AS total_neto
FROM detalle_factura WHERE detalle_factura.id_detalle= pa_id;
END$$

DROP PROCEDURE IF EXISTS `traer_detalles_editar_marca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_detalles_editar_marca` (IN `pa_marca` INT)  BEGIN
SELECT marca FROM marca_productos WHERE id_marca = pa_marca;
END$$

DROP PROCEDURE IF EXISTS `traer_detalles_editar_nombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_detalles_editar_nombre` (IN `pa_id` INT)  BEGIN
SELECT nombre FROM nombre_productos WHERE id_nombre = pa_id;
END$$

DROP PROCEDURE IF EXISTS `traer_detalles_editar_tipo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_detalles_editar_tipo` (IN `pa_id` INT)  BEGIN
SELECT tipo_empaque FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = pa_id;
END$$

DROP PROCEDURE IF EXISTS `traer_detalles_editar_vitola`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_detalles_editar_vitola` (IN `pa_id` INT)  BEGIN
SELECT vitola FROM vitola_productos WHERE id_vitola = pa_id;
END$$

DROP PROCEDURE IF EXISTS `traer_detalles_historial_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_detalles_historial_factura` (IN `pa_id_factura` INT)  BEGIN
   SELECT `id_detalle`,
	`id_venta`,
	`id_pendiente`,
	`cantidad_puros`,
	`unidad`,
	(CAST(((`cantidad_puros`*`unidad`)/cantidad_cajas) AS DECIMAL(9,0))) AS cantidad_cajas,
	`cantidad_puros`*`unidad` AS total_tabacos,

	(SELECT (UPPER((SELECT capa_productos.capa FROM capa_productos WHERE capa_productos.id_capa = clase_productos.id_capa))) AS capa
FROM clase_productos
WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente =  detalle_factura.id_pendiente)) AS capas,
	`cantidad_cajas` AS 'cantidad_por_caja'

	,(SELECT UPPER(CONCAT((SELECT tipo_empaques.tipo_empaque_ingles FROM tipo_empaques WHERE tipo_empaques.id_tipo_empaque = clase_productos.id_tipo_empaque)
		 ," ",
	    (SELECT vitola_productos.vitola FROM vitola_productos WHERE vitola_productos.id_vitola = clase_productos.id_vitola)
		 ," ",
		 (SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = clase_productos.id_marca)
		 ," ",
		 (SELECT nombre_productos.nombre FROM nombre_productos WHERE nombre_productos.id_nombre = clase_productos.id_nombre)
		 ," ",
		 (SELECT case cello
			 	when cello != "SI"  then  "CELLO"
			 	when cello != "NO"  then  ""
		 	END AS celloss
			FROM cellos
		   WHERE cellos.id_cello = clase_productos.id_cello)
		 )) AS producto
	FROM clase_productos
	WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
											WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)
	) AS producto,

	(SELECT clase_productos.codigo_precio
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo
	,

	(SELECT clase_productos.item
		FROM clase_productos
		WHERE clase_productos.item = (SELECT pendiente.item FROM pendiente
													WHERE pendiente.id_pendiente = detalle_factura.id_pendiente)) AS codigo_item
	,
	(SELECT CONCAT(pendiente.orden ) AS oer
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden,

		(SELECT  pendiente.pendiente
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden_total,

		(SELECT pendiente.saldo - total_tabacos
	FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente) AS orden_restante,

	`peso_bruto`*`cantidad_puros` AS total_bruto,
	`peso_neto`*`cantidad_puros`AS total_neto,
	(SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente ) AS precio_producto,

	((CAST((SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente )  AS DECIMAL(9,0)) * `cantidad_cajas`)/1000) AS costo,

	(((CAST((SELECT pendiente.precio FROM pendiente WHERE pendiente.id_pendiente = detalle_factura.id_pendiente )  AS DECIMAL(9,0)) * `cantidad_cajas`)/1000)*
	(CAST(((`cantidad_puros`*`unidad`)/cantidad_cajas) AS DECIMAL(9,0)))) AS valor_total


FROM detalle_factura
WHERE detalle_factura.id_venta = pa_id_factura;

END$$

DROP PROCEDURE IF EXISTS `traer_detalles_productos_actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_detalles_productos_actualizar` (IN `pa_item` VARCHAR(50), IN `pa_limite` MEDIUMINT)  BEGIN
    SELECT  detalle_clase_productos.id_marca AS marca,
			    detalle_clase_productos.id_vitola	 AS vitola,
					 detalle_clase_productos.id_nombre	 AS nombre,
					  detalle_clase_productos.id_capa	 AS capa,
					   detalle_clase_productos.id_tipo_empaque	 AS tipo_empaque,
					  detalle_clase_productos.item
	 FROM detalle_clase_productos
	 WHERE detalle_clase_productos.item = pa_item
	 ORDER BY id_producto
	 LIMIT pa_limite,1;




END$$

DROP PROCEDURE IF EXISTS `traer_factura_datos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_factura_datos` (IN `pa_ida_venta` INT)  BEGIN
   SELECT * FROM factura_terminados WHERE factura_terminados.id = pa_ida_venta;
END$$

DROP PROCEDURE IF EXISTS `traer_maximo_registro_existencia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_maximo_registro_existencia` ()  BEGIN

DECLARE max_id BIGINT;

SET max_id = (SELECT max(importar_existencias.id)from  importar_existencias);

 SELECT importar_existencias.id , importar_existencias.codigo_producto ,
importar_existencias.marca,importar_existencias.nombre, importar_existencias.vitola,importar_existencias.capa
from  importar_existencias
WHERE importar_existencias.id = max_id;
END$$

DROP PROCEDURE IF EXISTS `traer_numero_detalles_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_numero_detalles_productos` (IN `pa_item` VARCHAR(50))  BEGIN
    SELECT COUNT(detalle_clase_productos.item) AS tuplas
	 FROM detalle_clase_productos
	 WHERE detalle_clase_productos.item = pa_item;
END$$

DROP PROCEDURE IF EXISTS `traer_numero_detalles_productos_datos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_numero_detalles_productos_datos` (IN `pa_item` VARCHAR(50), IN `pa_limite` MEDIUMINT)  BEGIN
    SELECT (SELECT marca_productos.marca FROM marca_productos WHERE marca_productos.id_marca = detalle_clase_productos.id_marca) AS marca,
			    (SELECT vitola_productos.vitola FROM  vitola_productos WHERE vitola_productos.id_vitola = detalle_clase_productos.id_vitola	) AS vitola,
					 (SELECT nombre_productos.nombre FROM  nombre_productos WHERE nombre_productos.id_nombre = detalle_clase_productos.id_nombre	) AS nombre,
					  (SELECT capa_productos.capa FROM  capa_productos WHERE capa_productos.id_capa = detalle_clase_productos.id_capa	) AS capa
	 FROM detalle_clase_productos
	 WHERE detalle_clase_productos.item = pa_item
	 ORDER BY id_producto
	 LIMIT pa_limite,1;




END$$

DROP PROCEDURE IF EXISTS `traer_numero_detalles_productos_ids`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_numero_detalles_productos_ids` (IN `pa_limite` MEDIUMINT, IN `pa_item` VARCHAR(50))  BEGIN

    SELECT *
	 FROM detalle_clase_productos
	 WHERE detalle_clase_productos.item = pa_item
	 ORDER BY id_producto
	 LIMIT pa_limite,1;

END$$

DROP PROCEDURE IF EXISTS `traer_num_factura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_num_factura` ()  BEGIN
	DECLARE vl_num_factura VARCHAR(14);
	DECLARE vl_numero_de_factura_emitidas INT;

	SET vl_num_factura = "FA-";

	SET vl_numero_de_factura_emitidas = (SELECT COUNT(*) FROM factura_terminados)+1;



	SELECT CONCAT("FA-",
				(SELECT (CASE
			    WHEN CHARACTER_LENGTH(vl_numero_de_factura_emitidas) = 1 THEN (CONCAT("00-0000000",vl_numero_de_factura_emitidas))
			    WHEN CHARACTER_LENGTH(vl_numero_de_factura_emitidas) = 2 THEN (CONCAT("00-000000",vl_numero_de_factura_emitidas))
			    WHEN CHARACTER_LENGTH(vl_numero_de_factura_emitidas) = 3 THEN (CONCAT("00-00000",vl_numero_de_factura_emitidas))
			    WHEN CHARACTER_LENGTH(vl_numero_de_factura_emitidas) = 4 THEN (CONCAT("00-0000",vl_numero_de_factura_emitidas))
			    WHEN CHARACTER_LENGTH(vl_numero_de_factura_emitidas) = 5 THEN (CONCAT("00-000",vl_numero_de_factura_emitidas))
			    WHEN CHARACTER_LENGTH(vl_numero_de_factura_emitidas) = 6 THEN (CONCAT("00-00",vl_numero_de_factura_emitidas))
			    WHEN CHARACTER_LENGTH(vl_numero_de_factura_emitidas) = 7 THEN (CONCAT("00-0",vl_numero_de_factura_emitidas))
			    WHEN CHARACTER_LENGTH(vl_numero_de_factura_emitidas) = 8 THEN (CONCAT("00-",vl_numero_de_factura_emitidas))
				END))
	) AS factura_interna;


END$$

DROP PROCEDURE IF EXISTS `traer_ubicacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_ubicacion` (IN `ubicacion` VARCHAR(50))  BEGIN
SELECT importar_existencias.id, importar_existencias.codigo_producto,importar_existencias.marca,
importar_existencias.nombre,importar_existencias.vitola,importar_existencias.capa, importar_existencias.ubicacion,
importar_existencias.total
FROM importar_existencias
WHERE importar_existencias.ubicacion  = ubicacion;
END$$

DROP PROCEDURE IF EXISTS `traer_ventas_historial`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `traer_ventas_historial` (IN `fecha` DATE, IN `busqueda` VARCHAR(50))  BEGIN
  SELECT * FROM factura_terminados WHERE MONTH(factura_terminados.fecha_factura) = MONTH(fecha)
   AND year(factura_terminados.fecha_factura) = year(fecha) AND factura_terminados.numero_factura LIKE CONCAT("%",busqueda,"%")
	ORDER BY 1 DESC;
END$$

DROP PROCEDURE IF EXISTS `trae_factura_venta_actual`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `trae_factura_venta_actual` ()  BEGIN
 SELECT * FROM factura_terminados WHERE factura_terminados.facturado = 'N';
END$$

DROP PROCEDURE IF EXISTS `verificar_item_clase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verificar_item_clase` ()  BEGIN
SELECT item FROM pedidos WHERE pedidos.item NOT IN(SELECT clase_productos.item FROM clase_productos);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anadir_inventario_cajas`
--

DROP TABLE IF EXISTS `anadir_inventario_cajas`;
CREATE TABLE IF NOT EXISTS `anadir_inventario_cajas` (
  `id_cajas` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) DEFAULT NULL,
  `descripcion` longtext,
  `lote_origen` longtext,
  `lote_destino` longtext,
  `cantidad` longtext,
  `costo_u` longtext,
  `subtotal` longtext,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_cajas`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `anadir_inventario_cajas`
--

INSERT INTO `anadir_inventario_cajas` (`id_cajas`, `codigo`, `descripcion`, `lote_origen`, `lote_destino`, `cantidad`, `costo_u`, `subtotal`, `created_at`, `updated_at`) VALUES
(21, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', NULL, NULL),
(22, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', NULL, NULL),
(23, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', NULL, NULL),
(24, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', NULL, NULL),
(25, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', NULL, NULL),
(26, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', NULL, NULL),
(27, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', NULL, NULL),
(28, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', NULL, NULL),
(29, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', NULL, NULL),
(30, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', NULL, NULL),
(31, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', NULL, NULL),
(32, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', NULL, NULL),
(33, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', NULL, NULL),
(34, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', NULL, NULL),
(35, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', NULL, NULL),
(36, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', NULL, NULL),
(37, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', NULL, NULL),
(38, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', NULL, NULL),
(39, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', NULL, NULL),
(40, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', NULL, NULL),
(41, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', NULL, NULL),
(42, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', NULL, NULL),
(43, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', NULL, NULL),
(44, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', NULL, NULL),
(45, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', NULL, NULL),
(46, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', NULL, NULL),
(47, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', NULL, NULL),
(48, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', NULL, NULL),
(49, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', NULL, NULL),
(50, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivo_producto_terminados`
--

DROP TABLE IF EXISTS `archivo_producto_terminados`;
CREATE TABLE IF NOT EXISTS `archivo_producto_terminados` (
  `id` int(11) DEFAULT NULL,
  `Lote` varchar(50) DEFAULT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `orden_pedido` varchar(50) DEFAULT NULL,
  `orden_sistema` varchar(50) DEFAULT NULL,
  `Alias_vitola` varchar(50) DEFAULT NULL,
  `Vitola` varchar(50) DEFAULT NULL,
  `Nombre_capa` varchar(50) DEFAULT NULL,
  `Existencia_total` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas`
--

DROP TABLE IF EXISTS `cajas`;
CREATE TABLE IF NOT EXISTS `cajas` (
  `id_cajas` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) DEFAULT NULL,
  `descripcion` longtext,
  `lote_origen` longtext,
  `lote_destino` longtext,
  `cantidad` longtext,
  `costo_u` longtext,
  `subtotal` longtext,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_cajas`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cajas`
--

INSERT INTO `cajas` (`id_cajas`, `codigo`, `descripcion`, `lote_origen`, `lote_destino`, `cantidad`, `costo_u`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(2, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(3, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(4, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(5, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(6, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(7, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(8, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(9, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(10, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:44:34', '2021-05-12 21:44:34'),
(11, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(12, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(13, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(14, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(15, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(16, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(17, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(18, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(19, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(20, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:46:23', '2021-05-12 21:46:23'),
(21, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(22, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(23, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(24, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(25, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(26, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(27, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(28, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(29, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(30, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:47:10', '2021-05-12 21:47:10'),
(31, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(32, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(33, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(34, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(35, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(36, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(37, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(38, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(39, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(40, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:47:18', '2021-05-12 21:47:18'),
(41, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(42, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(43, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(44, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(45, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(46, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(47, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(48, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(49, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(50, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:47:20', '2021-05-12 21:47:20'),
(51, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '420', '4', '1680', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(52, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '40', '6', '240', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(53, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '546', '4', '2184', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(54, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'CAJAS_MADERA', 'CAJAS_MADERA', '4', '6', '24', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(55, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(56, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '10', '5', '50', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(57, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '25', '5', '125', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(58, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'CAJAS_MADERA', 'CAJAS_MADERA', '5', '5', '25', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(59, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:47:26', '2021-05-12 21:47:26'),
(60, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'CAJAS_MADERA', 'CAJAS_MADERA', '50', '4.5', '225', '2021-05-12 21:47:26', '2021-05-12 21:47:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capa_productos`
--

DROP TABLE IF EXISTS `capa_productos`;
CREATE TABLE IF NOT EXISTS `capa_productos` (
  `id_capa` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `capa` char(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_capa`),
  UNIQUE KEY `capa` (`capa`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `capa_productos`
--

INSERT INTO `capa_productos` (`id_capa`, `capa`, `created_at`, `updated_at`) VALUES
(1, 'HABANO', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(2, 'MADURO', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(3, 'SUMATRA', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(4, 'CAMEROON', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(5, 'COROJO', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(6, 'CONNECTICUT', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(7, 'CAMEROON NAT', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(8, 'HABANO/OSCURO', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(9, 'HABANO/COL', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(10, 'DOS CAPAS', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(11, 'HABANO/COLORADO', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(12, 'HABANO/CLARO', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(13, 'SUMATRA OSCURO', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(14, 'PENSILVANIA MAD', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(15, 'CANDELA', '2021-04-08 21:40:31', '2021-04-08 21:40:31'),
(16, 'VARIADO', '2021-04-08 21:40:32', '2021-04-08 21:40:32'),
(17, 'MADURO PENSILVANIA', '2021-04-08 21:40:32', '2021-04-08 21:40:32'),
(18, 'HABANO-2000', '2021-04-08 21:40:32', '2021-04-08 21:40:32'),
(19, 'NINGUNA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(20, 'ARAPIRACA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(21, 'INDONESIA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(22, 'MATAFINA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(23, 'NATURAL', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(24, 'BROADLEAF', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(25, 'TRES CAPAS', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(26, 'CAMEROON MAD', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(27, 'PENSILVANIA NAT', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(28, 'ORGANICO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(29, 'ALMENDROS-NAT.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(30, 'KRAFT', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(31, 'CRIOLLO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(32, 'CONNECTICUT/ECUAD', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(33, 'JALAPA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(34, 'SAN ANDRES', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(35, 'HABANO/ROS.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(36, 'CANDELA/HABAN', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(37, 'HABANO/CAFE', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(38, 'HABANO/JALAPA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(39, 'SAN ANDRES MADURO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(40, 'VISO/HABANO/NIC', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(41, 'CONNECTICUT/TALANGA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(42, 'VISO/HABANO/JALAPA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(43, 'SECO/HABANO/JALAPA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(44, 'SECO/CONNECTICUT', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(45, 'CONNECTICUT/SHADE', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(46, 'ECUADOR/CONN', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(47, 'BRASIL', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(48, 'ECUADOR/SUMATRA', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(49, 'ECUADOR/HABANO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(50, 'Ecuador/Connecticut/Clara', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(51, 'Connecticut/Clara', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(52, 'Connecticut XLT/ Clara', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(53, 'Habano-2000/Intermedio', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(54, 'Criollo Mexicano/Intermedio', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(55, 'Ecuador/Sumatra/Rojizo', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(56, 'Ecuador/Connecticut/Bronceado', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(57, 'Brasil/Intermedio', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(58, 'Habano-2000/Oscuro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(59, 'Ecuador/Habano/Intermedio', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(60, 'Habano/Maduro/Natural', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(61, 'Connecticut/Amarillo/Talanga', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(62, 'Corojo Rosado', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(63, 'Viso Hab. Hond. Mad. Nat. Osc.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(64, 'Seco Hab. Rosado Jalapa', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(65, 'Mata Fina Brazil', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(66, 'Sumatra Indonesia', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(67, 'Seco Hab. Oscuro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(68, 'Viso Hab. Mad. Osc. Nat.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(69, 'Habano Rosado Oscuro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(70, 'Habano Maduro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(71, 'Viso Jalapa de Sol', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(72, 'INDONESIA/NAT.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(73, 'Seco/Sumatra/Indon', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(74, 'Viso/Habano/Maduro/Osc.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(75, 'Seco/Sumatra/Ecuador', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(76, 'Indonesia/Maduro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(77, 'ECUADOR', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(78, 'Sumatra Claro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(79, 'CONNECTICUT/BRONCEADO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(80, 'Connecticut/Oscuro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(81, 'CONNECTICUT/HONDURAS', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(82, 'BROADLEAF/MADURO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(83, 'Honduran/Olancho/Ligero', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(84, 'Nicaraguan/Jalapa/Ligero', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(85, 'INDONESIA/BESUKI', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(86, 'Nicaraguan/Jalapa/Seco', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(87, 'Honduran/Jamastran', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(88, 'Honduran/Olancho/Viso', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(89, 'Honduran/Jamastran/Seco', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(90, 'Honduran/Olancho/Seco', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(91, 'Nicaraguan/Jalapa/Viso', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(92, 'VISO/HABANO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(93, 'HABANO/SECO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(94, 'VISO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(95, 'SECO/HABANO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(96, 'HABANO/MEXICO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(97, 'Ligero/Habano/Jalapa', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(98, 'SUMATRA/ECUADOR', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(99, 'VISO/MEXICO', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(100, 'LIGERO/JAMAST.', '2021-04-28 20:51:58', '2021-04-28 20:51:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `categoria` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `categoria`, `created_at`, `updated_at`) VALUES
(1, 'NEW ROLL', NULL, NULL),
(2, 'CATALOGO', NULL, NULL),
(3, 'INVENTARIO EXISTENTE', NULL, NULL),
(4, 'WAREHOUSE', NULL, NULL),
(5, 'INVENTARIO', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cellos`
--

DROP TABLE IF EXISTS `cellos`;
CREATE TABLE IF NOT EXISTS `cellos` (
  `id_cello` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cello` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anillo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_cello`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cellos`
--

INSERT INTO `cellos` (`id_cello`, `cello`, `anillo`, `upc`, `created_at`, `updated_at`) VALUES
(1, 'SI', 'SI', 'NO', '2021-04-08 21:40:41', '2021-04-08 21:40:41'),
(2, 'NO', 'SI', 'NO', '2021-04-08 21:40:41', '2021-04-08 21:40:41'),
(3, 'SI', 'SI', 'SI', '2021-04-08 21:40:41', '2021-04-08 21:40:41'),
(4, 'SI', 'NO', 'NO', '2021-04-08 21:40:41', '2021-04-08 21:40:41'),
(5, 'SI', 'NO', 'SI', '2021-05-20 08:59:53', '2021-05-20 08:59:54'),
(6, 'NO', 'NO', 'SI', '2021-05-20 09:00:50', '2021-05-20 09:00:51'),
(7, 'NO', 'SI', 'SI', '2021-05-20 09:00:52', '2021-05-20 09:00:52'),
(8, 'NO', 'NO', 'NO', '2021-05-20 09:01:42', '2021-05-20 09:01:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase_productos`
--

DROP TABLE IF EXISTS `clase_productos`;
CREATE TABLE IF NOT EXISTS `clase_productos` (
  `id_producto` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_producto` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_caja` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_precio` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `id_capa` int(11) DEFAULT NULL,
  `id_vitola` int(11) DEFAULT NULL,
  `id_nombre` int(11) DEFAULT NULL,
  `id_marca` int(11) DEFAULT NULL,
  `id_cello` int(11) DEFAULT NULL,
  `id_tipo_empaque` int(11) DEFAULT NULL,
  `presentacion` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sampler` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'no',
  `descripcion_sampler` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `item` (`item`)
) ENGINE=MyISAM AUTO_INCREMENT=732 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clase_productos`
--

INSERT INTO `clase_productos` (`id_producto`, `item`, `codigo_producto`, `codigo_caja`, `codigo_precio`, `precio`, `id_capa`, `id_vitola`, `id_nombre`, `id_marca`, `id_cello`, `id_tipo_empaque`, `presentacion`, `sampler`, `descripcion_sampler`, `created_at`, `updated_at`) VALUES
(1, '02008065', 'P-0000', NULL, NULL, NULL, 19, 45, 1, 1450, 1, 5, 'Puros Tripa Larga', 'si', 'RP Honduran Robusto 2015 Sampler', '2021-05-05 08:03:43', '2021-05-05 08:03:43'),
(2, '02008048', 'P-0000', NULL, NULL, NULL, 19, 45, 153, 1450, 1, 6, 'Puros Tripa Larga', 'si', 'RP Humidor Selection Gift Pack', '2021-05-05 08:03:43', '2021-05-05 08:03:43'),
(3, '00404460', 'P-23398', NULL, '222', NULL, 6, 5, 4, 13, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:43', '2021-05-05 08:03:43'),
(4, '00404463', 'P-23401', NULL, NULL, NULL, 6, 4, 2, 13, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:43', '2021-05-05 08:03:43'),
(5, '00404451', 'P-23404', NULL, NULL, NULL, 1, 2, 1, 13, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:43', '2021-05-05 08:03:43'),
(6, '00110196', 'P-23802', 'CM-07620', NULL, NULL, 3, 12, 13, 52, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(8, '00508015', 'P-22288', 'CM-05532', NULL, NULL, 5, 11, 12, 51, 1, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(9, '00508016', 'P-22289', 'CM-05533', NULL, NULL, 2, 11, 12, 51, 1, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(10, '47801009', 'P-02095', NULL, NULL, NULL, 19, 45, 153, 1450, 1, 10, 'Puros Tripa Larga', 'si', 'RP Connecticut Mega Sampler', '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(11, '47003001', 'P-02076', NULL, NULL, NULL, 6, 1, 15, 55, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(12, '01606866', 'P-22796', NULL, NULL, NULL, 6, 2, 1, 56, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(13, '01606867', 'P-22797', NULL, NULL, NULL, 6, 4, 2, 56, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(14, '01606875', 'P-22797', NULL, NULL, NULL, 6, 4, 2, 56, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(15, '01606872', 'P-22797', NULL, NULL, NULL, 6, 4, 2, 56, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(16, '603006600', 'P-23072', NULL, NULL, NULL, 3, 2, 1, 56, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(17, '603006603', 'P-23397', NULL, NULL, NULL, 3, 9, 11, 56, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(18, '01606865', 'P-23759', NULL, NULL, NULL, 6, 9, 11, 56, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(19, '47801892', 'P-23431', NULL, NULL, NULL, 1, 9, 16, 57, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(20, '47801803', 'P-22698', 'CM-06110', NULL, NULL, 1, 13, 4, 58, 1, 7, 'Puros Tripa Corta', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(21, '01104000', 'P-02045', 'CM-03722', NULL, NULL, 2, 4, 3, 59, 3, 13, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(22, '47801421', 'P-23567', NULL, NULL, NULL, 8, 4, 2, 60, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(23, '00904038', 'P-02001', NULL, NULL, NULL, 2, 4, 2, 51, 1, 14, 'Puros Tripa Larga', 'si', 'DISPLAY OF 15 EDGE SAMPLER TORO 4 COUNT PACK', '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(24, '00505003', 'P-02003', 'CM-03570', NULL, NULL, 2, 4, 14, 51, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(25, '00605003', 'P-02011', 'CM-03583', NULL, NULL, 2, 14, 17, 51, 3, 13, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(26, '00231000', 'P-02161', NULL, NULL, NULL, 3, 15, 18, 62, 1, 15, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(27, '12503002', 'P-02205', 'CM-06896', NULL, NULL, 2, 4, 2, 63, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(28, '13099006', 'P-02867', 'CM-03506', NULL, NULL, 1, 3, 3, 64, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(29, '13099010', 'P-02400', 'CM-03336', NULL, NULL, 6, 3, 3, 65, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(30, '12403004', 'P-02407', NULL, NULL, NULL, 6, 3, 2, 66, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(31, '1240300101', 'P-02407', NULL, NULL, NULL, 6, 3, 2, 66, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(32, '10104113', NULL, 'CM-03718', NULL, NULL, 3, 6, 67, 67, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(33, '13099014', 'P-02531', 'CM-03330', NULL, NULL, 3, 3, 3, 68, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(34, '13099016', 'P-02533', 'CM-03658', NULL, NULL, 3, 4, 20, 68, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(35, '12403008', 'P-02691', 'CM-05311', NULL, NULL, 5, 4, 21, 69, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(36, '10504026', 'P-02930', 'CM-03866', NULL, NULL, 3, 16, 14, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(37, '10504019', 'P-02945', 'CM-03863', NULL, NULL, 6, 16, 14, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(38, '00110086', 'P-22214', 'CM-05280', NULL, NULL, 3, 3, 21, 71, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(39, '12506001', 'P-22251', 'CM-05269', NULL, NULL, 1, 4, 2, 61, 1, 18, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(40, '12506020', 'P-22251', 'CM-05267', NULL, NULL, 1, 4, 2, 61, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(41, '00110283', 'P-22264', NULL, NULL, NULL, 2, 9, 11, 72, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(42, '00110284', 'P-22271', NULL, NULL, NULL, 6, 9, 11, 72, 1, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(43, '10504032', 'P-22383', 'CM-05645', NULL, NULL, 3, 9, 11, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(44, '10504030', 'P-22385', 'CM-05643', NULL, NULL, 6, 9, 11, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:45', '2021-05-05 08:03:45'),
(45, '00508017', 'P-22621', 'CM-06458', NULL, NULL, 6, 11, 12, 99, 3, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(46, '00904021', 'P-23412', 'CM-06856', NULL, NULL, 5, 3, 3, 74, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(47, '10504022', 'P-23585', 'CM-06907', NULL, NULL, 2, 16, 14, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(48, '10504031', 'P-23587', 'CM-06906', NULL, NULL, 2, 9, 11, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(49, '11707001', 'P-22502', NULL, NULL, NULL, 9, 15, 22, 75, 4, 17, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(50, '10499063', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 9, 'Puros Tripa Larga', 'si', 'CI/RP 10 Cigar Cover Sampler 2019', '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(51, '01606871', 'P-22796', NULL, NULL, NULL, 6, 2, 1, 56, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(52, '01606870', 'P-23759', NULL, NULL, NULL, 6, 9, 11, 56, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(53, '40503013', 'P-02013', NULL, NULL, NULL, 2, 18, 24, 51, 3, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(54, '12506012', 'P-22251', NULL, NULL, NULL, 1, 4, 2, 61, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(55, '00302002', 'P-02502', 'CM-03753', NULL, NULL, 6, 19, 25, 86, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(56, '09903021', 'P-23568', NULL, NULL, NULL, 6, 2, 1, 87, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(57, '603004002', 'P-22518', NULL, NULL, NULL, 1, 4, 3, 88, 1, 7, NULL, NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(58, '00104102', 'P-02905', 'CM-03542', NULL, NULL, 6, 16, 14, 89, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(59, '20005002', 'P-02338', 'CM-03545', NULL, NULL, 3, 3, 21, 90, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(60, '20005001', 'P-02339', 'CM-03551', NULL, NULL, 3, 3, 3, 90, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(61, '20005007', 'P-02342', 'CM-03549', NULL, NULL, 3, 9, 26, 90, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(62, '00508022', 'P-22620', 'CM-06214', '106006', '1730.86', 10, 9, 11, 91, 1, 7, NULL, 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(63, '603005751', 'P-23376', NULL, NULL, NULL, 1, 4, 2, 92, 1, 4, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(64, '603005750', 'P-23377', NULL, NULL, NULL, 1, 2, 1, 92, 1, 4, NULL, NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(65, '603005752', 'P-23432', NULL, NULL, NULL, 1, 9, 11, 92, 1, 4, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(66, '9900009111', 'P-23263', 'CM-06999', NULL, NULL, 2, 3, 27, 93, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(67, '9900009112', 'P-23264', 'CM-07001', NULL, NULL, 2, 9, 28, 93, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(68, '9900004004', 'P-23249', NULL, NULL, NULL, 2, 2, 1, 94, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(69, '9900004020', 'P-23215', 'CM-06864', '142002', '1541.22', 1, 3, 2, 53, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(70, '01606680', 'P-23692', NULL, NULL, NULL, 5, 2, 1, 40, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(71, '01606677', 'P-23693', 'CM-07603', NULL, NULL, 5, 9, 11, 40, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(72, '01606674', 'P-23694', 'CM-07604', NULL, NULL, 5, 3, 2, 40, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(73, '009040220', 'P-23413', 'CM-06879', NULL, NULL, 5, 9, 29, 74, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(74, '01607600', 'P-23626', 'CM-06941', NULL, NULL, 11, 20, 30, 95, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(75, '01607601', 'P-23627', 'CM-06942', NULL, NULL, 11, 2, 1, 95, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(76, '01607602', 'P-23628', 'CM-06943', NULL, NULL, 11, 3, 2, 95, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(77, '01607620', 'P-23628', NULL, NULL, NULL, 11, 3, 2, 95, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(78, '01607603', 'P-23629', 'CM-06944', NULL, NULL, 11, 9, 11, 95, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(79, '01607604', 'P-23635', 'CM-06945', NULL, NULL, 11, 5, 31, 95, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(80, 'HON-3011', 'P-02924', 'CM-03817', NULL, NULL, 3, 16, 14, 67, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(81, '00505006', 'p-02002', 'CM-03580', NULL, NULL, 5, 4, 14, 51, 3, 18, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:46', '2021-05-05 08:03:46'),
(82, '00505007', 'P-02003', 'CM-04488', NULL, NULL, 2, 4, 14, 51, 3, 18, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(83, '00508001', 'p-02017', 'CM-03578', NULL, NULL, 2, 9, 32, 51, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(84, '00505019', 'P-02021', 'CM-03568', NULL, NULL, 3, 4, 14, 51, 1, 18, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(85, '00508010', 'P-22247', 'CM-05356', NULL, NULL, 5, 21, 33, 51, 1, 19, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(86, '00508011', 'P-22248', 'CM-05357', NULL, NULL, 2, 21, 33, 51, 1, 19, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(87, '00504051', 'P-22199', NULL, NULL, NULL, 2, 22, 34, 100, 4, 12, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(88, '12506002', 'P-22300', 'CM-05334', NULL, NULL, 1, 4, 14, 61, 1, 18, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(89, '12506021', 'P-22300', 'CM-05522', NULL, NULL, 1, 4, 14, 61, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(90, '10104751', 'P-03202', 'CM-03875', NULL, NULL, 4, 3, 35, 101, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(91, '10104752', 'P-03203', 'CM-03877', NULL, NULL, 4, 16, 36, 101, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(92, '10104754', 'P-03204', 'CM-03886', NULL, NULL, 4, 9, 37, 101, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(93, '10104753', 'P-03205', 'CM-03876', NULL, NULL, 4, 5, 38, 101, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(94, '13105211', 'P-22495', 'CM-05791', NULL, NULL, 2, 4, 2, 102, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(95, '13105213', 'P-23749', 'CM-07034', NULL, NULL, 2, 9, 39, 102, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(96, '00504044', 'P-02003', NULL, NULL, NULL, 2, 4, 14, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(97, '00505009', 'P-02003', NULL, NULL, NULL, 2, 4, 14, 51, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(98, '00504042', 'p-02017', NULL, NULL, NULL, 2, 9, 32, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(99, '47801041', 'P-22426', NULL, NULL, NULL, 2, 4, 2, 103, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(100, '00404009', 'P-02034', NULL, NULL, NULL, 3, 3, 2, 67, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(101, '13408000', 'P-02040', NULL, NULL, NULL, 3, 9, 40, 67, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(102, '12506010', 'P-22251', NULL, NULL, NULL, 1, 4, 2, 61, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(103, '12506011', 'P-22300', NULL, NULL, NULL, 1, 4, 14, 61, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(104, '15205521', 'P-22341', NULL, NULL, NULL, 12, 4, 2, 104, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(105, '12003053', 'P-22361', NULL, NULL, NULL, 1, 9, 11, 105, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(106, '001105003', 'P-02692', 'CM-03515', NULL, NULL, 3, 5, 4, 106, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(107, '001105001', 'P-02696', 'CM-03881', NULL, NULL, 3, 23, 30, 106, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(108, '19904005', 'P-02371', 'CM-04504', NULL, NULL, 6, 3, 2, 107, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(109, '13205003', 'P-02191', 'CM-03646', NULL, NULL, 6, 2, 1, 108, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(110, '13205002', 'P-02192', 'CM-03647', NULL, NULL, 6, 4, 14, 108, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(111, '01604010', 'P-02179', 'CM-03668', NULL, NULL, 1, 24, 41, 109, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(112, '01604011', 'P-02439', 'CM-03809', NULL, NULL, 1, 3, 2, 109, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(113, '01606676', 'P-23692', 'CM-07606', NULL, NULL, 5, 2, 1, 40, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(114, '016006678', 'P-23694', 'CM-07604', NULL, NULL, 5, 3, 2, 40, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(115, '00904220', 'P-23413', 'CM-06879', NULL, NULL, 5, 9, 29, 74, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:47', '2021-05-05 08:03:47'),
(116, '13105027', 'P-22318', 'CM-05468', NULL, NULL, 6, 25, 2, 110, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(117, '016007602', 'P-23628', 'CM-06943', NULL, NULL, 11, 3, 2, 95, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(118, '12503500', 'P-23727', NULL, NULL, NULL, 3, 1, 1, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(119, '12503501', 'P-23728', NULL, NULL, NULL, 3, 5, 4, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(120, '12503502', 'P-23729', NULL, NULL, NULL, 3, 4, 14, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(121, '12503503', 'P-23730', NULL, NULL, NULL, 3, 9, 39, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(122, '12503511', 'P-23768', NULL, NULL, NULL, 6, 5, 4, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(123, '12503512', 'P-23769', NULL, NULL, NULL, 6, 4, 14, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(124, '12503513', 'P-23770', NULL, NULL, NULL, 6, 9, 39, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(125, '12503518', 'P-23771', NULL, NULL, NULL, 1, 1, 1, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(126, '12503519', 'P-23772', NULL, NULL, NULL, 1, 5, 4, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(127, '12503520', 'P-23773', NULL, NULL, NULL, 1, 4, 14, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(128, '12503521', 'P-23774', NULL, NULL, NULL, 1, 9, 39, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(129, '00110282', 'P-22270', NULL, NULL, NULL, 5, 9, 11, 72, 1, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(130, '00404000', 'P-02034', 'CM-03820', NULL, NULL, 3, 3, 2, 67, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(131, '00408000', 'P-02040', 'CM-03816', NULL, NULL, 3, 9, 40, 67, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(132, '00303007', 'P-02433', 'CM-04490', NULL, NULL, 3, 25, 2, 67, 1, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(133, '00405000', 'P-02924', 'CM-03817', NULL, NULL, 3, 16, 14, 67, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(134, '08503515', 'P-23023', NULL, NULL, NULL, 2, 1, 1, 112, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(135, '08503516', 'P-23024', NULL, NULL, NULL, 2, 4, 2, 112, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(136, '20018023', 'P-22373', NULL, NULL, NULL, 1, 26, 42, 113, 1, 12, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(137, '00504007', 'P-02001', 'CM-03582', NULL, NULL, 2, 4, 2, 51, 3, 18, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(138, '00505002', 'p-02002', 'CM-03574', NULL, NULL, 5, 4, 14, 51, 3, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(139, '00505008', 'p-02002', NULL, NULL, NULL, 5, 4, 14, 51, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(140, '00504102', 'P-02018', 'CM-03576', NULL, NULL, 5, 22, 34, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(141, '00504024', 'P-02020', 'CM-03563', NULL, NULL, 3, 4, 2, 51, 1, 18, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(142, '00504033', 'P-02021', 'CM-05128', NULL, NULL, 3, 4, 14, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(143, '00504038', 'P-02021', NULL, NULL, NULL, 3, 4, 14, 51, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:48', '2021-05-05 08:03:48'),
(144, '00508003', 'P-22263', NULL, NULL, NULL, 1, 9, 11, 61, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(145, '10104775', 'P-03202', NULL, NULL, NULL, 4, 3, 35, 101, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(146, '10104777', 'P-03202', NULL, NULL, NULL, 4, 3, 35, 101, 3, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(147, '001105053', 'P-22489', NULL, NULL, NULL, 5, 27, 30, 115, 4, 20, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(148, '00503008', 'P-02980', 'CM-04495', NULL, NULL, 2, 6, 43, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(149, '10104212', 'P-02195', 'CM-03748', NULL, NULL, 3, 16, 21, 14, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(150, '00712001', 'P-02025', 'CM-03586', NULL, NULL, 6, 22, 34, 99, 3, 21, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(151, '47801430', 'P-23360', NULL, NULL, NULL, 5, 4, 2, 116, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(152, '47801434', 'P-23361', NULL, NULL, NULL, 2, 4, 2, 116, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(153, '603004048', 'P-23194', NULL, NULL, NULL, 13, 17, 23, 88, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(154, '10104111', 'P-02494', 'CM-04487', NULL, NULL, 3, 6, 44, 90, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(155, '01004015', 'P-02339', NULL, NULL, NULL, 3, 3, 3, 90, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(156, '15212000', 'P-22673', 'CM-06450', NULL, NULL, 2, 28, 43, 117, 1, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(157, '15212001', 'P-22674', 'CM-06451', NULL, NULL, 2, 3, 2, 117, 1, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(158, '00704004', 'P-02028', NULL, NULL, NULL, 6, 4, 2, 99, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(159, '47006005', 'P-02075', NULL, NULL, NULL, 6, 4, 2, 55, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(160, '47006004', 'P-02077', NULL, NULL, NULL, 6, 29, 45, 55, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(161, '47117000', 'P-02184', 'CM-05930', NULL, NULL, 1, 30, 1, 118, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(162, '47117002', 'P-02184', NULL, NULL, NULL, 1, 30, 1, 118, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(163, '47801420', 'P-23566', NULL, NULL, NULL, 8, 1, 1, 60, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(164, '10499012', NULL, NULL, NULL, NULL, 5, 4, 2, 1450, 1, 10, 'Puros Tripa Larga', 'si', 'BUNDLE 20 CI MEGA SAMPLER TOP TWENTY 2015', '2021-05-05 08:03:49', '2021-05-05 08:03:49'),
(165, '10499061', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 22, 'Puros Tripa Larga', 'si', 'RP 15 Top-Shelf Takeover Cigar Sampler 2018', '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(166, '10499062', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 11, 'Puros Tripa Larga', 'si', 'RP Vintage 5-Star Sampler', '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(167, '11812003', 'P-02445', 'CM-03504', NULL, NULL, 6, 31, 4, 132, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(168, '11812002', 'P-02446', 'CM-03503', NULL, NULL, 6, 9, 11, 132, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(169, '12003005', 'P-02477', 'CM-03535', NULL, NULL, 5, 22, 34, 133, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(170, '12005003', 'P-02481', 'CM-03538', NULL, NULL, 2, 9, 11, 133, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(171, '12005004', 'P-02481', NULL, NULL, NULL, 2, 9, 11, 133, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(172, '12005005', 'P-02482', NULL, NULL, NULL, 5, 9, 11, 133, 1, 12, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(173, '12003007', 'P-02847', 'CM-03534', NULL, NULL, 2, 22, 34, 133, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(174, '12104006', 'P-02213', NULL, NULL, NULL, 5, 3, 3, 134, 1, 12, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(175, '13403005', 'P-02220', NULL, NULL, NULL, 3, 3, 2, 135, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(176, '12003050', 'P-22359', 'CM-05267', NULL, NULL, 1, 4, 2, 105, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(177, '12003065', 'P-22359', NULL, NULL, NULL, 1, 4, 2, 105, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(178, '12003051', 'P-22360', 'CM-05522', NULL, NULL, 1, 4, 14, 105, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(179, '12003066', 'P-22360', NULL, NULL, NULL, 1, 4, 14, 105, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(180, '12003064', 'P-22361', NULL, NULL, NULL, 1, 9, 11, 105, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(181, '11707000', 'P-22510', NULL, NULL, NULL, 9, 15, 46, 136, 4, 17, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(182, '11707002', 'P-22504', NULL, NULL, NULL, 3, 15, 47, 137, 4, 17, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(183, '11707003', 'P-22503', 'CM-03640', NULL, NULL, 6, 15, 48, 138, 4, 17, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(184, '603004023', 'P-22518', NULL, NULL, NULL, 1, 4, 3, 88, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(185, '10504020', 'P-02713', 'CM-03851', NULL, NULL, 6, 4, 2, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(186, '10504024', 'P-02929', 'CM-03867', NULL, NULL, 3, 1, 1, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(187, '10504025', 'P-02931', 'CM-03865', NULL, NULL, 3, 4, 2, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(188, '10504018', 'P-02944', 'CM-03864', NULL, NULL, 6, 1, 1, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(189, '10504023', 'P-23586', 'CM-06904', NULL, NULL, 2, 1, 1, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(190, '10504021', 'P-23588', 'CM-06905', NULL, NULL, 2, 4, 2, 70, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(191, '13105200', 'P-22599', 'CM-06018', NULL, NULL, 6, 22, 34, 139, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(192, '13105201', 'P-22600', 'CM-06019', NULL, NULL, 6, 32, 49, 139, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(193, '13105202', 'P-22601', 'CM-06020', NULL, NULL, 6, 4, 2, 139, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(194, '13105203', 'P-22602', 'CM-06021', NULL, NULL, 6, 1, 1, 139, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(195, '13105204', 'P-22603', 'CM-06022', NULL, NULL, 6, 9, 39, 139, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(196, '13105205', 'P-22604', 'CM-06023', NULL, NULL, 6, 33, 30, 139, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(197, '13105206', 'P-23162', 'CM-06983', NULL, NULL, 6, 4, 14, 139, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(198, '01105003', 'P-02692', 'CM-03515', NULL, NULL, 3, 5, 4, 106, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(199, '001105004', 'P-02693', 'CM-03765', NULL, NULL, 3, 4, 2, 106, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(200, '001105002', 'P-02695', 'CM-03516', NULL, NULL, 3, 1, 1, 106, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(201, '13099007', 'P-02393', 'CM-05647', NULL, NULL, 1, 5, 38, 64, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(202, '13099005', 'P-02395', 'CM-05646', NULL, NULL, 1, 1, 1, 64, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(203, '13099008', 'P-02396', 'CM-05648', NULL, NULL, 1, 4, 50, 64, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(204, '13099011', 'P-02399', 'CM-04562', NULL, NULL, 6, 5, 38, 65, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:50', '2021-05-05 08:03:50'),
(205, '13099009', 'P-02401', 'CM-03337', NULL, NULL, 6, 1, 1, 65, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:51', '2021-05-05 08:03:51'),
(206, '13099012', 'P-02402', 'CM-03338', NULL, NULL, 6, 4, 50, 65, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:51', '2021-05-05 08:03:51'),
(207, '13099013', 'P-02530', 'CM-04531', NULL, NULL, 3, 1, 6, 68, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:51', '2021-05-05 08:03:51'),
(208, '13099015', 'P-02532', 'CM-03807', NULL, NULL, 3, 5, 51, 68, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:03:51', '2021-05-05 08:03:51'),
(209, '20005010', 'P-02029', NULL, NULL, NULL, 3, 3, 35, 90, 4, 4, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(210, '20005000', 'P-02337', 'CM-03769', NULL, NULL, 3, 1, 6, 90, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(211, '01004012', 'P-02339', NULL, NULL, NULL, 3, 3, 3, 90, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(212, '20005005', 'P-02341', 'CM-03552', NULL, NULL, 3, 34, 52, 90, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(213, '20005012', 'P-02342', NULL, NULL, NULL, 3, 9, 26, 90, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(214, '00508020', 'P-22368', 'CM-05798', NULL, NULL, 10, 4, 2, 91, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(215, '10105510', 'P-22678', 'CM-06819', NULL, NULL, 6, 1, 1, 140, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(216, '10105511', 'P-22679', 'CM-06820', NULL, NULL, 6, 5, 4, 140, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(217, '10105513', 'P-22680', 'CM-06823', NULL, NULL, 6, 16, 14, 140, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(218, '1010517', 'P-22681', 'CM-06818', NULL, NULL, 14, 1, 1, 140, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(219, '10105518', 'P-22682', 'CM-06824', NULL, NULL, 14, 5, 4, 140, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(220, '10105519', 'P-22683', 'CM-06825', NULL, NULL, 14, 16, 14, 140, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(221, '00107000', 'P-01314', NULL, NULL, NULL, 9, 15, 53, 141, 1, 15, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(222, '10203000', 'P-02333', 'CM-03657', NULL, NULL, 5, 2, 1, 142, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(223, '10205000', 'P-02334', 'CM-03656', NULL, NULL, 5, 4, 14, 142, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(224, '10204000', 'P-02335', 'CM-04012', NULL, NULL, 5, 4, 2, 142, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(225, '01603002', 'P-02179', NULL, NULL, NULL, 1, 24, 41, 109, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(226, '01606675', 'P-23691', 'CM-07605', NULL, NULL, 5, 20, 30, 40, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(227, '01606678', 'P-23694', 'CM-07604', NULL, NULL, 5, 3, 2, 40, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(228, '00904020', 'P-23411', 'CM-06857', NULL, NULL, 5, 18, 6, 74, 3, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(229, '00903051', 'P-23411', NULL, NULL, NULL, 5, 18, 6, 74, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:09', '2021-05-05 08:10:09'),
(230, '13105265', 'P-23813', NULL, NULL, NULL, 6, 2, 1, 1462, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(231, '13105266', 'P-23814', NULL, NULL, NULL, 6, 3, 2, 143, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(232, '13105267', 'P-23815', NULL, NULL, NULL, 6, 5, 4, 143, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(233, '13105268', 'P-23816', NULL, NULL, NULL, 6, 9, 16, 143, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(234, '00110287', 'P-22062', NULL, NULL, NULL, 6, 4, 2, 72, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(235, '00401000', 'P-02032', 'CM-03714', NULL, NULL, 3, 19, 25, 67, 3, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(236, '00403000', 'P-02033', 'CM-03719', NULL, NULL, 3, 2, 1, 67, 3, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(237, '00404005', 'P-02034', NULL, NULL, NULL, 3, 3, 2, 67, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(238, '00504006', 'P-02000', 'CM-03581', NULL, NULL, 5, 4, 2, 51, 3, 18, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(239, '00504002', 'P-02000', 'CM-03572', NULL, NULL, 5, 4, 2, 51, 3, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(240, '00504003', 'P-02001', 'CM-03569', NULL, NULL, 2, 4, 2, 51, 3, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(241, '00504010', 'P-02001', NULL, NULL, NULL, 2, 4, 2, 51, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(242, '00504027', 'P-02001', NULL, NULL, NULL, 2, 4, 2, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(243, '00504101', 'P-02005', 'CM-03561', NULL, NULL, 2, 2, 1, 51, 3, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(244, '00503005', 'P-02005', NULL, NULL, NULL, 2, 2, 1, 51, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(245, '00605002', 'p-02010', 'CM-03573', NULL, NULL, 5, 14, 17, 51, 3, 13, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(246, '00508000', 'P-02016', 'CM-06863', NULL, NULL, 5, 9, 32, 51, 3, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(247, '00504032', 'P-02020', 'CM-05129', NULL, NULL, 3, 4, 2, 51, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(248, '00504150', 'P-22078', 'CM-03984', NULL, NULL, 15, 4, 2, 51, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(249, '00705003', 'P-01308', 'CM-01420', NULL, NULL, 6, 4, 14, 99, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(250, '00705001', 'P-01308', 'CM-01416', NULL, NULL, 6, 4, 14, 99, 3, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(251, '00703003', 'P-02024', 'CM-01421', NULL, NULL, 6, 2, 1, 99, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(252, '00703001', 'P-02024', 'CM-01418', NULL, NULL, 6, 2, 1, 99, 3, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(253, '10104911', 'P-02024', NULL, NULL, NULL, 6, 2, 1, 99, 1, 23, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(254, '00703004', 'P-02024', NULL, NULL, NULL, 6, 2, 1, 99, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(255, '00712003', 'P-02025', 'CM-01422', NULL, NULL, 6, 22, 34, 99, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:10', '2021-05-05 08:10:10'),
(256, '00508002', 'P-02031', 'CM-03596', NULL, NULL, 6, 9, 11, 99, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(257, '00504250', 'P-23232', 'CM-05830', NULL, NULL, 5, 4, 54, 144, 1, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(258, '00504251', 'P-23233', 'CM-05828', NULL, NULL, 2, 4, 54, 144, 1, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(259, '00504252', 'P-23234', 'CM-05832', NULL, NULL, 1, 4, 54, 144, 1, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(260, '00504255', 'P-23235', 'CM-05833', NULL, NULL, 1, 4, 55, 144, 1, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(261, '10104122', 'P-02501', NULL, NULL, NULL, 6, 2, 1, 86, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(262, '00303078', 'P-22703', 'CM-07613', NULL, NULL, 4, 35, 56, 101, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(263, '00303104', 'P-22703', NULL, NULL, NULL, 4, 35, 56, 101, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(264, '00303095', 'P-22703', NULL, NULL, NULL, 4, 35, 56, 101, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(265, '10603007', 'P-02321', NULL, NULL, NULL, 6, 36, 57, 145, 1, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(266, '13105210', 'P-22494', 'CM-05790', NULL, NULL, 2, 1, 1, 102, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(267, '13105212', 'P-23748', 'CM-07033', NULL, NULL, 2, 5, 4, 102, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(268, '00504041', 'P-02016', NULL, NULL, NULL, 5, 9, 32, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(269, '47801031', 'P-22426', NULL, NULL, NULL, 2, 4, 2, 103, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(270, '11803026', 'P-23218', NULL, NULL, NULL, 2, 4, 2, 50, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(271, '08503511', 'P-23224', NULL, NULL, NULL, 3, 4, 2, 112, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(272, '00504048', 'P-02020', NULL, NULL, NULL, 3, 4, 2, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(273, '11803031', 'P-23219', NULL, NULL, NULL, 3, 4, 2, 146, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(274, '11803030', 'P-23220', NULL, NULL, NULL, 3, 1, 1, 146, 1, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(275, '11803032', 'P-23221', NULL, NULL, NULL, 3, 31, 4, 146, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(276, '14399000', 'P-02562', 'CM-04039', NULL, NULL, 3, 2, 6, 147, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(277, '14399003', 'P-02563', 'CM-04557', NULL, NULL, 3, 16, 21, 147, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(278, '14399004', 'P-03193', 'CM-03966', NULL, NULL, 3, 9, 11, 147, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(279, '15212002', 'P-22675', 'CM-06452', NULL, NULL, 2, 9, 40, 117, 1, 4, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(280, '15212003', 'P-22676', 'CM-06453', NULL, NULL, 2, 26, 42, 117, 1, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(281, '47801032', 'P-22538', NULL, NULL, NULL, 1, 4, 2, 103, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(282, '47801033', 'P-23229', NULL, NULL, NULL, 6, 4, 2, 103, 4, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(283, '47801042', NULL, NULL, NULL, NULL, 6, 4, 2, 148, 1, 10, NULL, NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(284, '11803020', 'P-22928', NULL, NULL, NULL, 6, 4, 2, 149, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(285, '11803021', NULL, NULL, NULL, NULL, 6, 1, 1, 149, 1, 10, NULL, NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(286, '47801480', 'P-23246', NULL, NULL, NULL, 6, 3, 2, 150, 4, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(287, '01104500', 'P-23402', 'CM-06886', NULL, NULL, 15, 4, 2, 151, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(288, '15205501', 'P-22341', 'CM-05624', NULL, NULL, 12, 4, 2, 104, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(289, '15205502', 'P-22342', 'CM-05625', NULL, NULL, 12, 13, 4, 104, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(290, '47801201', 'P-23191', 'CM-05931', NULL, NULL, 8, 4, 2, 152, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(291, '47801405', 'P-22612', NULL, NULL, NULL, 4, 4, 2, 153, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:11', '2021-05-05 08:10:11'),
(292, '00504100', 'P-02004', 'CM-03577', NULL, NULL, 5, 2, 1, 51, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(293, '00407000', 'P-02162', NULL, NULL, NULL, 9, 15, 46, 158, 1, 15, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(294, '00403009', 'P-02033', NULL, NULL, NULL, 3, 2, 1, 67, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(295, '10104227', 'P-03320', 'CM-03747', NULL, NULL, 3, 33, 58, 14, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(296, '10104225', 'P-22081', 'CM-03835', NULL, NULL, 3, 2, 5, 14, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(297, '10104182', 'P-22108', 'CM-04547', NULL, NULL, 3, 6, 59, 14, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(298, '10104199', 'P-02252', 'CM-03826', NULL, NULL, 2, 2, 5, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(299, '00303063', 'P-22090', NULL, NULL, NULL, 2, 2, 5, 15, 1, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(300, '10104228', 'P-02250', 'CM-03742', NULL, NULL, 2, 5, 38, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(301, '00704003', 'P-02028', 'CM-03597', NULL, NULL, 6, 4, 2, 99, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(302, '00702000', 'P-22006', 'CM-03589', NULL, NULL, 6, 33, 30, 99, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(303, '00303065', 'P-02501', NULL, NULL, NULL, 6, 2, 1, 86, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(304, '00302004', NULL, NULL, NULL, NULL, 6, 37, 61, 86, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(305, '00507001', 'P-02397', NULL, NULL, NULL, 6, 15, 62, 159, 1, 15, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(306, '01604013', 'P-02180', 'CM-03666', NULL, NULL, 1, 38, 57, 109, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(307, '01605003', 'P-02179', NULL, NULL, NULL, 1, 24, 41, 109, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(308, '603004033', 'P-22516', NULL, NULL, NULL, 1, 26, 63, 88, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(309, '01606689', 'P-23692', NULL, NULL, NULL, 5, 2, 1, 40, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(310, '10104750', 'P-03201', 'CM-03874', NULL, NULL, 4, 2, 5, 101, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(311, '00231001', 'P-22167', NULL, NULL, NULL, 4, 15, 64, 160, 1, 15, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(312, '12199002', 'P-02212', NULL, NULL, NULL, 5, 18, 6, 134, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:12', '2021-05-05 08:10:12'),
(313, '11803007', 'P-02446', NULL, NULL, NULL, 6, 9, 11, 132, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(314, '12003068', 'P-22359', NULL, NULL, NULL, 1, 4, 2, 105, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(315, '12003067', 'P-22361', NULL, NULL, NULL, 1, 9, 11, 105, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(316, '12003020', 'P-02277', NULL, NULL, NULL, 2, 4, 2, 133, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(317, '12003019', 'P-02482', NULL, NULL, NULL, 5, 9, 11, 133, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(318, '09906035', 'P-22628', NULL, NULL, NULL, 2, 4, 2, 161, 4, 20, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(319, '10610018', 'P-22194', NULL, NULL, NULL, 2, 9, 11, 162, 4, 22, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(320, '10610019', 'P-22353', NULL, NULL, NULL, 5, 4, 2, 162, 4, 22, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(321, '009003051', 'P-23411', NULL, NULL, NULL, 5, 18, 6, 74, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(322, '13105280', 'P-23819', NULL, NULL, NULL, 5, 2, 65, 163, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(323, '13105281', 'P-23820', NULL, NULL, NULL, 5, 4, 66, 163, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(324, '00110197', 'P-23802', NULL, NULL, NULL, 3, 12, 13, 52, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(325, '001103990', 'P-23697', 'CM-06961', NULL, NULL, 2, 4, 2, 164, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(326, '001103991', 'P-23697', NULL, NULL, NULL, 2, 4, 2, 164, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(327, '001103992', 'P-23698', 'CM-06962', NULL, NULL, 2, 1, 1, 164, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(328, '001103993', 'P-23698', NULL, NULL, NULL, 2, 1, 1, 164, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(329, '003041660', 'P-02433', NULL, NULL, NULL, 3, 25, 2, 67, 2, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(330, '003041640', 'P-02433', NULL, NULL, NULL, 3, 25, 2, 67, 2, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(331, '13403000', 'P-02033', NULL, NULL, NULL, 3, 2, 1, 67, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(332, '003041625', 'P-02029', NULL, NULL, NULL, 3, 3, 35, 90, 5, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(333, '10104132', 'P-22188', 'CM-05151', NULL, NULL, 3, 6, 67, 51, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(334, '00110396', 'P-23699', 'CM-07045', NULL, NULL, 3, 1, 1, 164, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13');
INSERT INTO `clase_productos` (`id_producto`, `item`, `codigo_producto`, `codigo_caja`, `codigo_precio`, `precio`, `id_capa`, `id_vitola`, `id_nombre`, `id_marca`, `id_cello`, `id_tipo_empaque`, `presentacion`, `sampler`, `descripcion_sampler`, `created_at`, `updated_at`) VALUES
(335, '00110397', 'P-23699', NULL, NULL, NULL, 3, 1, 1, 164, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(336, '00110398', 'P-23700', 'CM-07044', NULL, NULL, 3, 4, 2, 164, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(337, '00110399', 'P-23700', NULL, NULL, NULL, 3, 4, 2, 164, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(338, '00110390', 'P-23701', 'CM-07046', NULL, NULL, 6, 4, 2, 164, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(339, '00110391', 'P-23701', NULL, NULL, NULL, 6, 4, 2, 164, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(340, '00110392', 'P-23702', 'CM-07047', NULL, NULL, 6, 1, 1, 164, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(341, '00110393', 'P-23702', NULL, NULL, NULL, 6, 1, 1, 164, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(342, '12403003', 'P-02406', 'CM-03664', NULL, NULL, 6, 2, 1, 66, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(343, '1240300100', 'P-02406', NULL, NULL, NULL, 6, 2, 1, 66, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(344, '12403005', 'P-02408', 'CM-03868', NULL, NULL, 6, 3, 14, 66, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(345, '1240300102', 'P-02408', NULL, NULL, NULL, 6, 3, 14, 66, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(346, '12403006', 'P-02409', 'CM-03869', NULL, NULL, 6, 5, 4, 66, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(347, '1240300104', 'P-02409', NULL, NULL, NULL, 6, 5, 4, 66, 1, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(348, '12403007', 'P-02410', 'CM-03665', NULL, NULL, 6, 22, 34, 66, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(349, '1240300103', 'P-02410', NULL, NULL, NULL, 6, 22, 34, 66, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(350, '603005760', 'P-23377', NULL, NULL, NULL, 1, 2, 1, 92, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(351, '00504026', 'P-02000', NULL, NULL, NULL, 5, 4, 2, 51, 3, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(352, '00504046', 'p-02002', NULL, NULL, NULL, 5, 4, 14, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(353, '00508077', 'P-22247', NULL, NULL, NULL, 5, 21, 33, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(354, '40503012', 'P-02012', NULL, NULL, NULL, 5, 18, 24, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(355, '47801040', NULL, NULL, NULL, NULL, 5, 4, 2, 148, 1, 10, NULL, NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(356, '08503501', 'P-22932', NULL, NULL, NULL, 5, 4, 2, 165, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:13', '2021-05-05 08:10:13'),
(357, '603004050', 'P-23193', NULL, NULL, NULL, 13, 4, 3, 88, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(358, '01104010', 'P-02047', 'CM-04518', NULL, NULL, 2, 38, 68, 59, 1, 13, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(359, '47801562', 'P-23392', NULL, NULL, NULL, 2, 1, 1, 166, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(360, '15406011', 'P-02368', 'CM-03806', NULL, NULL, 2, 4, 2, 167, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(361, '20005016', 'P-02337', NULL, NULL, NULL, 3, 1, 6, 90, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(362, '01004018', 'P-02337', NULL, NULL, NULL, 3, 1, 6, 90, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(363, '603006601', 'P-23396', NULL, NULL, NULL, 3, 4, 2, 56, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(364, '47801044', NULL, NULL, NULL, NULL, 3, 4, 2, 148, 1, 10, NULL, NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(365, '00704015', 'P-02028', NULL, NULL, NULL, 6, 4, 2, 99, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(366, '10704020', 'P-02024', NULL, NULL, NULL, 6, 2, 1, 99, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(367, '47801012', 'P-22592', 'CM-05978', NULL, NULL, 6, 9, 69, 168, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(368, '47801560', 'P-23394', NULL, NULL, NULL, 1, 1, 1, 166, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(369, '47801043', NULL, NULL, NULL, NULL, 1, 4, 2, 148, 1, 10, NULL, NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(370, '47801890', 'P-23429', NULL, NULL, NULL, 1, 2, 1, 57, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(371, '47801200', 'P-22732', 'CM-05935', NULL, NULL, 8, 2, 1, 152, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(372, '10104778', 'P-03201', NULL, NULL, NULL, 4, 2, 5, 101, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(373, '10499013', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 20, 'Puros Tripa Larga', 'si', 'CI Big Ring Sampler 2015', '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(374, '10499014', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 24, 'Puros Tripa Larga', 'si', 'CI Mildn Mellow Sampler', '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(375, '10499010', 'P-22419', NULL, NULL, NULL, 6, 4, 2, 176, 1, 25, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(376, '00303110', NULL, NULL, NULL, NULL, 19, 35, 56, 1450, 1, 12, 'Puros Tripa Larga', 'si', 'RP Santa Clara Vintage Short Gordo Samplers', '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(377, '001105048', 'P-23821', NULL, NULL, NULL, 5, 28, 43, 115, 4, 20, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(378, '09903020', 'P-23019', NULL, NULL, NULL, 6, 3, 2, 87, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(379, '12305000', 'P-02221', 'CM-03701', NULL, NULL, 3, 16, 14, 135, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(380, '09906014', 'P-02613', NULL, NULL, NULL, 6, 4, 14, 181, 4, 20, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(381, '09906039', 'P-22648', NULL, NULL, NULL, 3, 9, 40, 182, 4, 22, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(382, '11710052', 'P-22993', 'CM-06848', NULL, NULL, 3, 16, 14, 183, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(383, '00303023', 'P-02029', NULL, NULL, NULL, 3, 3, 35, 90, 2, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(384, '20005066', 'P-02340', NULL, NULL, NULL, 3, 39, 70, 90, 1, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(385, '15003000', 'P-02260', 'CM-03645', NULL, NULL, 2, 24, 6, 184, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(386, '50000565', NULL, NULL, NULL, NULL, 6, 4, 2, 185, 1, 12, NULL, NULL, NULL, '2021-05-05 08:10:14', '2021-05-05 08:10:14'),
(387, '13105033', 'P-22570', NULL, NULL, NULL, 4, 9, 16, 110, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:15', '2021-05-05 08:10:15'),
(388, '10104912', 'P-02004', NULL, NULL, NULL, 5, 2, 1, 51, 1, 23, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:15', '2021-05-05 08:10:15'),
(389, '00503013', 'p-02010', NULL, NULL, NULL, 5, 14, 17, 51, 1, 26, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:15', '2021-05-05 08:10:15'),
(390, '005040102', 'P-02018', 'CM-03576', NULL, NULL, 5, 22, 34, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:15', '2021-05-05 08:10:15'),
(391, '005040103', 'P-02019', 'CM-03575', NULL, NULL, 2, 22, 34, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:15', '2021-05-05 08:10:15'),
(392, '00504037', 'P-02020', NULL, NULL, NULL, 3, 4, 2, 51, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:15', '2021-05-05 08:10:15'),
(393, '00503012', 'P-02937', NULL, NULL, NULL, 6, 31, 4, 99, 1, 26, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:15', '2021-05-05 08:10:15'),
(394, '00904111', 'P-02147', NULL, NULL, NULL, 2, 3, 3, 186, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(395, '15212095', 'P-22694', NULL, NULL, NULL, 1, 4, 2, 187, 1, 18, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(396, '15212093', 'P-22694', NULL, NULL, NULL, 1, 4, 2, 187, 1, 9, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(397, '47801556', 'P-23375', NULL, NULL, NULL, 1, 1, 1, 189, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(398, '603004031', 'P-22518', NULL, NULL, NULL, 1, 4, 3, 88, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(399, '603004004', 'P-22536', NULL, NULL, NULL, 1, 17, 23, 88, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(400, '11803022', 'P-23223', NULL, NULL, NULL, 6, 5, 4, 149, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(401, '10604072', 'P-22369', NULL, NULL, NULL, 6, 39, 42, 190, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(402, '00110085', 'P-22213', NULL, NULL, NULL, 3, 1, 6, 71, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(403, '15406001', 'P-02411', NULL, NULL, NULL, 4, 3, 14, 191, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(404, '47801000', 'P-02095', NULL, NULL, NULL, 6, 2, 1, 168, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(405, '47801005', 'P-02095', NULL, NULL, NULL, 6, 2, 1, 168, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(406, '47801001', 'P-02096', NULL, NULL, NULL, 6, 4, 2, 168, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(407, '47801011', 'P-02096', NULL, NULL, NULL, 6, 4, 2, 168, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(408, '47801002', 'P-02097', NULL, NULL, NULL, 6, 3, 14, 168, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(409, '47801004', 'P-02098', 'CM-03813', NULL, NULL, 6, 5, 4, 168, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(410, '11803025', 'P-23217', NULL, NULL, NULL, 5, 4, 2, 50, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(411, '19902999', NULL, NULL, NULL, NULL, 19, 4, 2, 1450, 1, 10, 'Puros Tripa Larga', 'si', 'RP Famous Fuma Sampler', '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(412, '15212012', 'P-22673', NULL, NULL, NULL, 2, 28, 43, 117, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(413, '10499060', NULL, NULL, NULL, NULL, 19, 45, 1, 1450, 1, 11, 'Puros Tripa Larga', 'si', 'Bundle of 5 RP/CI Rated 93 5-Star Sampler', '2021-05-05 08:10:16', '2021-05-05 08:10:16'),
(414, '20005006', 'P-02339', NULL, NULL, NULL, 3, 3, 3, 90, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(415, '10499015', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 11, 'Puros Tripa Larga', 'si', 'CI RP 5-Star Toro Sampler', '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(416, '20004000', NULL, NULL, NULL, NULL, 4, 1, 1, 207, 1, 7, NULL, NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(417, '20004001', NULL, NULL, NULL, NULL, 4, 3, 2, 207, 1, 7, NULL, NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(418, '20004002', NULL, NULL, NULL, NULL, 4, 3, 14, 207, 1, 7, NULL, NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(419, '603001001', 'P-02492', NULL, NULL, NULL, 17, 4, 2, 208, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(420, '19904004', NULL, NULL, NULL, NULL, 6, 24, 1, 107, 1, 7, NULL, NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(421, '19904006', 'P-02373', NULL, NULL, NULL, 6, 28, 14, 107, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(422, '19904007', 'P-02374', NULL, NULL, NULL, 6, 42, 34, 107, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(423, '12404014', 'P-02375', 'CM-03985', NULL, NULL, 5, 24, 1, 107, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(424, '12404015', 'P-02376', 'CM-04499', NULL, NULL, 5, 3, 2, 107, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(425, '12404036', 'P-02381', 'CM-04503', NULL, NULL, 6, 38, 69, 107, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(426, '12404035', 'P-02382', NULL, NULL, NULL, 5, 38, 69, 107, 1, 7, NULL, NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(427, '00508030', 'P-22368', NULL, NULL, NULL, 10, 4, 2, 91, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(428, '47801431', 'P-23366', NULL, NULL, NULL, 18, 4, 2, 116, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(429, '00804066', 'P-23385', 'CM-06875', NULL, NULL, 2, 3, 3, 209, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(430, '13105120', 'P-22157', NULL, NULL, NULL, 3, 2, 1, 210, 4, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(431, '15406000', 'P-02266', NULL, NULL, NULL, 6, 13, 4, 211, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(432, '15203002', 'P-02272', NULL, NULL, NULL, 6, 1, 1, 211, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(433, '15205000', 'P-02783', NULL, NULL, NULL, 6, 3, 14, 211, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(434, '15403024', NULL, NULL, NULL, NULL, 6, 4, 2, 211, 1, 11, NULL, NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(435, '12503020', NULL, NULL, NULL, NULL, 3, 4, 2, 212, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(436, '10106501', 'P-23758', 'CM-07049', NULL, NULL, 9, 4, 2, 213, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(437, '10106511', 'P-23758', NULL, NULL, NULL, 9, 4, 2, 213, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(438, '01104509', 'P-23402', NULL, NULL, NULL, 15, 4, 2, 151, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(439, '00207011', 'P-01314', NULL, NULL, NULL, 9, 15, 53, 141, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(440, '00207013', 'P-22167', NULL, NULL, NULL, 4, 15, 64, 160, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(441, '9900004022', 'P-23066', NULL, '142003', '1136.28', 1, 2, 1, 53, 1, 10, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(442, '01604012', 'P-02181', NULL, NULL, NULL, 1, 28, 14, 109, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:17', '2021-05-05 08:10:17'),
(443, '003041630', 'P-23825', NULL, NULL, NULL, 5, 25, 2, 40, 4, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(444, '00904151', 'P-02147', NULL, NULL, NULL, 2, 3, 3, 186, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(445, '40923002', 'P-03169', NULL, NULL, NULL, 5, 3, 3, 186, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(446, '00903004', 'P-23411', NULL, NULL, NULL, 5, 18, 6, 74, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(447, '581000250', 'P-22598', NULL, NULL, NULL, 3, 3, 3, 214, 1, 4, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(448, '14399001', 'P-02560', NULL, NULL, NULL, 3, 3, 3, 147, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(449, '14399006', 'P-02560', NULL, NULL, NULL, 3, 3, 3, 147, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(450, '14399008', 'P-02561', NULL, NULL, NULL, 3, 5, 51, 147, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(451, '14399005', 'P-02562', NULL, NULL, NULL, 3, 2, 6, 147, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(452, '14399010', 'P-03193', NULL, NULL, NULL, 3, 9, 11, 147, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(453, '47801210', 'P-22732', NULL, NULL, NULL, 8, 2, 1, 152, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(454, '47801202', 'P-22734', NULL, NULL, NULL, 8, 9, 69, 152, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(455, '47801204', 'P-22739', NULL, NULL, NULL, 8, 5, 4, 152, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(456, '09906000', 'P-02617', NULL, NULL, NULL, 3, 3, 3, 219, 4, 24, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(457, '09906010', 'P-02611', NULL, NULL, NULL, 6, 9, 11, 181, 4, 20, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(458, '09906012', 'P-02612', NULL, NULL, NULL, 6, 4, 2, 181, 4, 20, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(459, '09906016', 'P-02614', NULL, NULL, NULL, 6, 31, 4, 181, 4, 20, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(460, '09906034', 'P-02616', NULL, NULL, NULL, 6, 2, 1, 181, 4, 20, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(461, '09906037', 'P-22646', NULL, NULL, NULL, 3, 3, 2, 182, 4, 22, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(462, '47801891', 'P-23430', NULL, NULL, NULL, 1, 3, 14, 57, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(463, '47801501', 'P-22685', NULL, NULL, NULL, 13, 8, 1, 220, 4, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(464, '12503510', 'P-23767', NULL, NULL, NULL, 6, 1, 1, 111, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:18', '2021-05-05 08:10:18'),
(465, '0404000', 'P-02034', 'CM-03820', NULL, NULL, 3, 3, 2, 67, 3, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(466, '00303008', 'P-02433', NULL, NULL, NULL, 3, 25, 2, 67, 1, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(467, '01103005', 'P-01325', NULL, NULL, NULL, 2, 24, 21, 59, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(468, '01103004', 'P-02041', NULL, NULL, NULL, 18, 1, 6, 59, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(469, '01120000', 'P-02042', NULL, NULL, NULL, 18, 43, 73, 59, 3, 13, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(470, '41112001', 'P-02043', NULL, NULL, NULL, 1, 22, 74, 59, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(471, '01103006', 'P-02045', NULL, NULL, NULL, 2, 4, 3, 59, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(472, '01103010', 'P-02047', NULL, NULL, NULL, 2, 38, 68, 59, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(473, '00504009', 'P-02000', NULL, NULL, NULL, 5, 4, 2, 51, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(474, '10104816', 'P-02001', NULL, NULL, NULL, 2, 4, 2, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:19', '2021-05-05 08:10:19'),
(475, '10515002', 'P-02004', NULL, NULL, NULL, 5, 2, 1, 51, 1, 4, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:20', '2021-05-05 08:10:20'),
(476, '00504103', 'P-02019', NULL, NULL, NULL, 2, 22, 34, 51, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:20', '2021-05-05 08:10:20'),
(477, '003041634', 'P-23823', NULL, NULL, NULL, 5, 25, 75, 51, 8, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:20', '2021-05-05 08:10:20'),
(478, '003041633', 'P-23824', NULL, NULL, NULL, 2, 25, 75, 51, 8, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:20', '2021-05-05 08:10:20'),
(479, '10515004', 'P-02024', 'CM-04511', NULL, NULL, 6, 2, 76, 99, 8, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:20', '2021-05-05 08:10:20'),
(480, '00712004', 'P-02025', NULL, NULL, NULL, 6, 22, 34, 99, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(481, '00704001', 'P-02028', 'CM-03598', NULL, NULL, 6, 4, 2, 99, 3, 21, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(482, '00504043', 'P-02031', NULL, NULL, NULL, 6, 9, 11, 99, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(483, '003041635', 'P-23826', NULL, NULL, NULL, 6, 25, 2, 99, 4, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(484, '12506015', 'P-22300', NULL, NULL, NULL, 1, 4, 14, 61, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(485, '00303050', 'P-02993', 'CM-03828', NULL, NULL, 2, 25, 77, 15, 8, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(486, '10104216', 'P-02193', NULL, NULL, NULL, 3, 9, 37, 14, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(487, '10104211', 'P-02197', NULL, NULL, NULL, 3, 3, 3, 14, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(488, '10104232', 'P-02998', NULL, NULL, NULL, 3, 33, 78, 14, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(489, '00302001', 'P-02501', NULL, NULL, NULL, 6, 2, 1, 86, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(490, '00302000', 'P-02505', NULL, NULL, NULL, 6, 27, 30, 86, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(491, '00303002', 'P-02502', NULL, NULL, NULL, 6, 19, 25, 86, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(492, '00302007', 'P-02507', NULL, NULL, NULL, 6, 3, 2, 86, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(493, '47801406', 'P-22611', NULL, NULL, NULL, 4, 1, 1, 153, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(494, '47801563', 'P-23393', NULL, NULL, NULL, 2, 4, 2, 166, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(495, '47801561', 'P-23395', NULL, NULL, NULL, 1, 4, 2, 166, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:21', '2021-05-05 08:10:21'),
(496, '11803000', 'P-02207', 'CM-03343', NULL, NULL, 6, 2, 1, 132, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(497, '11803002', 'P-02207', NULL, NULL, NULL, 6, 2, 1, 132, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(498, '11812010', 'P-02209', NULL, NULL, NULL, 6, 4, 2, 132, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(499, '11812008', 'P-02445', NULL, NULL, NULL, 6, 31, 4, 132, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(500, '47705002', 'P-02097', NULL, NULL, NULL, 6, 3, 14, 168, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(501, '12003002', 'P-02273', 'CM-03540', NULL, NULL, 2, 2, 1, 133, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(502, '12003003', 'P-02274', 'CM-05133', NULL, NULL, 5, 2, 1, 133, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(503, '12003001', 'P-02274', NULL, NULL, NULL, 5, 2, 1, 133, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(504, '12004001', 'P-02276', 'CM-03530', NULL, NULL, 5, 4, 2, 133, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(505, '12002999', 'P-02276', NULL, NULL, NULL, 5, 4, 2, 133, 1, 12, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(506, '12004000', 'P-02277', 'CM-03531', NULL, NULL, 2, 4, 2, 133, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(507, '12002998', 'P-02277', NULL, NULL, NULL, 2, 4, 2, 133, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(508, '00804065', 'P-23386', 'CM-06875', NULL, NULL, 2, 18, 6, 209, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(509, '00110346', 'P-23766', 'CM-07612', NULL, NULL, 9, 4, 2, 226, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(510, '00110347', 'P-23812', 'CM-07611', NULL, NULL, 9, 20, 30, 226, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(511, '11710050', 'P-22991', 'CM-03757', NULL, NULL, 3, 2, 1, 183, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(512, '11710055', 'P-22991', NULL, NULL, NULL, 3, 2, 1, 183, 1, 12, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(513, '10105565', 'P-23706', NULL, NULL, NULL, 5, 1, 1, 227, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(514, '10105566', 'P-23707', NULL, NULL, NULL, 5, 4, 2, 227, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(515, '10105550', 'P-23708', NULL, NULL, NULL, 2, 1, 1, 227, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(516, '10105551', 'P-23709', NULL, NULL, NULL, 2, 4, 2, 227, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(517, '10105560', 'P-23713', NULL, NULL, NULL, 6, 1, 1, 227, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(518, '10105561', 'P-23714', NULL, NULL, NULL, 6, 4, 2, 227, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(519, '10105555', 'P-23715', NULL, NULL, NULL, 1, 1, 1, 227, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(520, '10105556', 'P-23716', NULL, NULL, NULL, 1, 4, 2, 227, 1, 10, 'Puros Tripa Corta', NULL, NULL, '2021-05-05 08:10:22', '2021-05-05 08:10:22'),
(521, '12104000', 'P-02213', NULL, NULL, NULL, 5, 3, 3, 134, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(522, '15004001', 'P-02475', NULL, NULL, NULL, 2, 5, 51, 184, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(523, '9900009110', 'P-23262', NULL, NULL, NULL, 2, 2, 79, 93, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(524, '9900009115', 'P-23262', NULL, NULL, NULL, 2, 2, 79, 93, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(525, '9900009117', 'P-23263', NULL, NULL, NULL, 2, 3, 27, 93, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(526, '9900004000', 'P-23248', 'CM-06994', NULL, NULL, 2, 9, 16, 94, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(527, '9900004002', 'P-23249', NULL, NULL, NULL, 2, 2, 1, 94, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(528, '9900004003', 'P-23250', 'CM-06995', NULL, NULL, 2, 25, 2, 94, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(529, '9900004005', 'P-23250', NULL, NULL, NULL, 2, 25, 2, 94, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(530, '9900004011', 'P-22831', NULL, NULL, NULL, 1, 2, 1, 228, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(531, '9900004016', 'P-22831', NULL, NULL, NULL, 1, 2, 1, 228, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(532, '9900004012', 'P-22832', NULL, NULL, NULL, 1, 3, 2, 228, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(533, '9900004019', 'P-23066', 'CM-06865', NULL, NULL, 1, 2, 1, 53, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(534, '9900004023', 'P-23215', NULL, NULL, NULL, 1, 3, 2, 53, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(535, '9900004035', 'P-22868', NULL, NULL, NULL, 3, 9, 16, 229, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(536, '9900004037', 'P-22870', NULL, NULL, NULL, 3, 2, 1, 229, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(537, '9900004039', 'P-22870', NULL, NULL, NULL, 3, 2, 1, 229, 1, 10, NULL, NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(538, '9900004038', 'P-22871', NULL, NULL, NULL, 3, 3, 2, 229, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(539, '9900004040', 'P-22871', NULL, NULL, NULL, 3, 3, 2, 229, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(540, '9900004028', 'P-23606', 'CM-07043', NULL, NULL, 1, 3, 2, 230, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(541, '9900004031', 'P-23606', NULL, NULL, NULL, 1, 3, 2, 230, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(542, '9900004027', 'P-23763', 'CM-07035', NULL, NULL, 1, 2, 1, 230, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(543, '9900004030', 'P-23763', NULL, NULL, NULL, 1, 2, 1, 230, 1, 10, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(544, '9900004025', 'P-23764', 'CM-07036', NULL, NULL, 1, 9, 16, 230, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(545, '00110060', 'P-22640', NULL, NULL, NULL, 6, 2, 1, 231, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(546, '00110061', 'P-22641', NULL, NULL, NULL, 6, 4, 2, 231, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(547, '00110062', 'P-22642', NULL, NULL, NULL, 6, 9, 11, 231, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(548, '00110063', 'P-23417', NULL, NULL, NULL, 6, 22, 34, 231, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(549, '12301000', 'P-02218', 'CM-03706', NULL, NULL, 3, 19, 25, 135, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(550, '12303000', 'P-02219', 'CM-03702', NULL, NULL, 3, 2, 1, 135, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(551, '13403010', 'P-02220', NULL, NULL, NULL, 3, 3, 2, 135, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(552, '10105005', 'P-02360', 'CM-03652', NULL, NULL, 2, 5, 4, 232, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:23', '2021-05-05 08:10:23'),
(553, '09906018', 'P-02615', NULL, NULL, NULL, 6, 22, 34, 181, 4, 20, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(554, '6030066060', 'P-23396', NULL, NULL, NULL, 3, 4, 2, 56, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(555, '10610017', 'P-22193', NULL, NULL, NULL, 5, 9, 11, 162, 4, 22, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(556, '10610020', 'P-02715', NULL, NULL, NULL, 2, 4, 2, 162, 4, 22, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(557, '12503003', 'P-02791', 'CM-06987', NULL, NULL, 1, 4, 2, 63, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(558, '12503010', 'P-02913', 'CM-06985', NULL, NULL, 1, 1, 1, 63, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(559, '12503005', 'P-23254', NULL, NULL, NULL, 2, 19, 30, 63, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(560, '00110276', 'P-23559', NULL, NULL, NULL, 6, 2, 1, 72, 1, 23, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(561, '00110275', 'P-23560', NULL, NULL, NULL, 5, 2, 1, 72, 4, 23, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(562, '00110277', 'P-23561', NULL, NULL, NULL, 2, 2, 1, 72, 4, 23, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(563, '00408003', 'P-02040', NULL, NULL, NULL, 3, 9, 40, 67, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(564, '20018021', 'P-22371', NULL, NULL, NULL, 1, 3, 2, 113, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(565, '20018002', 'P-22372', NULL, NULL, NULL, 1, 9, 11, 113, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(566, '20018022', 'P-22372', NULL, NULL, NULL, 1, 9, 11, 113, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(567, '10104817', NULL, NULL, NULL, NULL, 5, 4, 2, 234, 1, 11, NULL, NULL, NULL, '2021-05-05 08:10:24', '2021-05-05 08:10:24'),
(568, '00503009', 'P-02977', 'CM-04496', NULL, NULL, 5, 6, 43, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(569, '00501150', 'P-22078', 'CM-03984', NULL, NULL, 15, 4, 2, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(570, '10104130', 'P-22151', NULL, NULL, NULL, 5, 6, 67, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(571, '40503005', 'P-23831', NULL, NULL, NULL, 3, 18, 80, 51, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(572, '40503022', 'P-23831', NULL, NULL, NULL, 3, 18, 80, 51, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(573, '40503016', 'P-23831', NULL, NULL, NULL, 3, 18, 80, 51, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(574, '40503004', 'P-23832', NULL, NULL, NULL, 6, 18, 80, 99, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(575, '40503021', 'P-23832', NULL, NULL, NULL, 6, 18, 80, 99, 1, 9, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(576, '40503015', 'P-23832', NULL, NULL, NULL, 6, 18, 80, 99, 1, 11, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:25', '2021-05-05 08:10:25'),
(577, '40503003', 'P-23833', NULL, NULL, NULL, 1, 18, 24, 61, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(578, '40503020', 'P-23833', NULL, NULL, NULL, 1, 18, 24, 61, 1, 9, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(579, '40503014', 'P-23833', NULL, NULL, NULL, 1, 18, 24, 61, 1, 11, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(580, '12003060', 'P-22359', NULL, NULL, NULL, 1, 4, 2, 105, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(581, '12003062', 'P-22360', NULL, NULL, NULL, 1, 4, 14, 105, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(582, '12003061', 'P-22361', NULL, NULL, NULL, 1, 9, 11, 105, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(583, '10104210', 'P-02198', 'CM-03750', NULL, NULL, 3, 2, 6, 14, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(584, '00303051', 'P-22019', NULL, NULL, NULL, 3, 25, 35, 14, 1, 4, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(585, '00302009', 'P-02509', NULL, NULL, NULL, 6, 9, 11, 86, 1, 7, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(586, '10104772', 'P-03205', NULL, NULL, NULL, 4, 5, 38, 101, 1, 12, 'Puros Tripa Larga', NULL, NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(587, '10104150', 'P-22168', 'CM-05338', NULL, NULL, 4, 44, 61, 101, 1, 7, 'Puros Tripa Larga', 'no', NULL, '2021-05-05 08:10:26', '2021-05-05 08:10:26'),
(593, '00504005', 'P-02001', 'CM-03582', NULL, NULL, 2, 4, 2, 51, 3, 18, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(594, '40503002', NULL, 'CM-03567', NULL, NULL, 2, 18, 24, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(595, '40503001', NULL, 'CM-06910', NULL, NULL, 5, 18, 24, 51, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(596, '00504047', 'P-02021', NULL, NULL, NULL, 3, 4, 14, 51, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(597, '01103000', 'P-02041', NULL, NULL, NULL, 18, 1, 6, 59, 3, 13, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(598, '11199000', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 10, 'Puros Tripa Larga', 'si', 'RP Super Fuerte Mega Sampler', NULL, NULL),
(599, '10104940', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 9, 'Puros Tripa Larga', 'si', 'Costco RP Honduran Robusto Sampler', NULL, NULL),
(600, '19903027', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 9, 'Puros Tripa Larga', 'si', 'RP Thompsons CI 10-Cigar Cover Sampler', NULL, NULL),
(601, '01004013', NULL, NULL, NULL, NULL, 3, 3, 21, 90, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(602, '15406023', NULL, NULL, NULL, NULL, 2, 4, 2, 167, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(603, '15406022', NULL, NULL, NULL, NULL, 4, 4, 2, 191, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(604, '12003018', 'P-02481', NULL, NULL, NULL, 2, 9, 11, 133, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(605, '14399002', NULL, NULL, NULL, NULL, 3, 5, 51, 147, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(606, '09906004', NULL, NULL, NULL, NULL, 3, 9, 11, 219, 2, 24, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(607, '09906020', NULL, NULL, NULL, NULL, 3, 1, 6, 219, 2, 24, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(608, '09906008', NULL, NULL, NULL, NULL, 3, 32, 97, 219, 2, 24, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(609, '50000159', 'P-02968', NULL, NULL, NULL, 2, 4, 2, 265, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(610, '20018001', 'P-22371', NULL, NULL, NULL, 1, 3, 2, 113, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(611, '47801030', 'P-22425', NULL, NULL, NULL, 5, 4, 2, 103, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(612, '47801400', NULL, NULL, NULL, NULL, 3, 4, 2, 644, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(613, '47801401', NULL, NULL, NULL, NULL, 3, 1, 1, 644, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(614, '09906036', 'P-22613', NULL, NULL, NULL, 2, 4, 14, 161, 2, 20, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(615, '09906038', NULL, NULL, NULL, NULL, 3, 16, 14, 182, 2, 22, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(616, '47801409', NULL, NULL, NULL, NULL, 2, 1, 1, 664, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(617, '47801408', NULL, NULL, NULL, NULL, 2, 4, 2, 664, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(618, '47801416', NULL, NULL, NULL, NULL, 6, 1, 1, 665, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(619, '47801415', NULL, NULL, NULL, NULL, 6, 4, 2, 665, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(620, '47801500', NULL, NULL, NULL, NULL, 13, 36, 2, 220, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(621, '08503500', NULL, NULL, NULL, NULL, 6, 4, 2, 779, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(622, '08503503', NULL, NULL, NULL, NULL, 2, 4, 2, 780, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(623, '9900009186', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 10, 'Puros Tripa Larga', 'si', 'LP vs RP Robusto Sampler', NULL, NULL),
(624, '47801211', 'P-23191', NULL, NULL, NULL, 8, 4, 2, 152, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(625, '47801481', NULL, NULL, NULL, NULL, 6, 2, 1, 150, 2, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(626, '19911999', 'P-23274', NULL, NULL, NULL, 6, 9, 16, 889, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(627, '19912000', 'P-23275', NULL, NULL, NULL, 6, 22, 34, 889, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(628, '47801435', NULL, NULL, NULL, NULL, 6, 4, 2, 116, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(629, '47801433', NULL, NULL, NULL, NULL, 15, 4, 2, 116, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(630, '00904005', 'P-23412', NULL, NULL, NULL, 5, 3, 3, 74, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(631, '13705661', NULL, 'CM-06913', NULL, NULL, 5, 4, 2, 947, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(632, '13705662', NULL, 'CM-06915', NULL, NULL, 2, 4, 2, 947, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(633, '13705660', NULL, 'CM-06914', NULL, NULL, 6, 4, 2, 947, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(634, '01606686', 'P-23694', NULL, NULL, NULL, 5, 3, 2, 40, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(635, '13705667', NULL, 'CM-06964', NULL, NULL, 5, 9, 39, 947, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(636, '13705666', NULL, 'CM-06966', NULL, NULL, 6, 9, 39, 947, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(637, '13705668', NULL, 'CM-06968', NULL, NULL, 2, 9, 39, 947, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(638, '00504090', NULL, NULL, NULL, NULL, 5, 25, 75, 51, 4, 4, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(639, '00504091', NULL, NULL, NULL, NULL, 2, 25, 75, 51, 4, 4, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(640, '01606673', NULL, NULL, NULL, NULL, 5, 25, 75, 40, 5, 4, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(641, '00504092', NULL, NULL, NULL, NULL, 6, 25, 75, 99, 4, 4, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(642, '12403100', NULL, NULL, NULL, NULL, 6, 3, 2, 1125, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(643, '47801429', NULL, NULL, NULL, NULL, 2, 22, 34, 116, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(644, '9900004018', 'P-23423', NULL, NULL, NULL, 1, 28, 43, 53, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(645, '00110225', NULL, NULL, NULL, NULL, 1, 1, 1, 1015, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(646, '00110226', NULL, NULL, NULL, NULL, 1, 168, 2, 1015, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(647, '20005057', 'P-01301', 'CM-03320', NULL, NULL, 3, 1, 5, 90, 3, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(648, '20005051', 'P-02029', 'CM-03771', NULL, NULL, 3, 3, 35, 90, 3, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(649, '20005058', 'P-22094', NULL, NULL, NULL, 3, 32, 117, 90, 3, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(650, '15004002', NULL, NULL, NULL, NULL, 2, 3, 3, 184, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(651, '9900009118', NULL, NULL, NULL, NULL, 2, 2, 79, 93, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(652, '9900004015', 'P-22831', '1223', NULL, NULL, 1, 2, 1, 228, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(653, '9900004013', 'P-23589', 'CM-06908', NULL, NULL, 1, 9, 16, 228, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(654, '9900009189', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 10, 'Puros Tripa Larga', 'si', 'La Palina 90+ Toro Sampler', NULL, NULL),
(655, '9900009187', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 11, 'Puros Tripa Larga', 'si', 'L a Palina Toro Sampler', NULL, NULL),
(656, '01603005', 'P-02180', NULL, NULL, NULL, 1, 38, 57, 109, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(657, '01605002', 'P-02181', NULL, NULL, NULL, 1, 28, 14, 109, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(658, '11220035', 'P-23433', NULL, NULL, NULL, 1, 4, 2, 943, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(659, '11220036', NULL, NULL, NULL, NULL, 6, 4, 2, 943, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(660, '01606877', NULL, NULL, NULL, NULL, 6, 4, 2, 56, 1, 9, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(661, '603006614', NULL, NULL, NULL, NULL, 3, 9, 11, 56, 1, 9, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(662, '01606878', NULL, NULL, NULL, NULL, 6, 9, 11, 56, 1, 9, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(663, '603006630', NULL, NULL, NULL, NULL, 2, 2, 1, 56, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(664, '603006646', NULL, NULL, NULL, NULL, 2, 2, 1, 56, 1, 9, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(665, '603006640', NULL, NULL, NULL, NULL, 2, 2, 1, 56, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(666, '603006631', NULL, NULL, NULL, NULL, 2, 4, 2, 56, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(667, '603006645', NULL, NULL, NULL, NULL, 2, 4, 2, 56, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(668, '603006647', NULL, NULL, NULL, NULL, 2, 4, 2, 56, 1, 9, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(669, '603006641', NULL, NULL, NULL, NULL, 2, 4, 2, 56, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(670, '603006632', NULL, NULL, NULL, NULL, 2, 9, 11, 56, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(671, '603006649', NULL, NULL, NULL, NULL, 2, 9, 11, 56, 1, 9, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(672, '603006642', NULL, NULL, NULL, NULL, 2, 9, 11, 56, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(673, '00110285', 'P-22060', NULL, NULL, NULL, 5, 4, 2, 72, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(674, '00110286', 'P-22061', NULL, NULL, NULL, 2, 4, 2, 72, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(675, '01119000', 'P-01325', NULL, NULL, NULL, 2, 24, 21, 59, 3, 13, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(676, '20018003', 'P-22373', NULL, NULL, NULL, 1, 26, 123, 113, 3, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(677, '00503004', 'P-02004', NULL, NULL, NULL, 5, 2, 1, 51, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(678, '10515003', 'P-02005', 'CM-05627', NULL, NULL, 2, 2, 1, 51, 4, 4, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(679, '00503011', NULL, NULL, NULL, NULL, 5, 31, 4, 51, 1, 26, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(680, '00503010', NULL, NULL, NULL, NULL, 2, 31, 4, 51, 1, 26, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(681, '00503014', 'P-02011', NULL, NULL, NULL, 2, 14, 17, 51, 1, 26, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(682, '40503023', NULL, NULL, NULL, NULL, 5, 18, 24, 51, 1, 9, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(683, '15506017', 'P-22263', NULL, NULL, NULL, 1, 9, 11, 61, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(684, '12507001', 'P-22325', 'CM-05859', NULL, NULL, 1, 2, 1, 61, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(685, '10104224', 'P-02247', NULL, NULL, NULL, 2, 3, 35, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(686, '10104200', 'P-02252', 'CM-04541', NULL, NULL, 2, 2, 6, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(687, '10104205', 'P-02468', NULL, NULL, NULL, 2, 19, 101, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(688, '10104207', NULL, 'CM-04533', NULL, NULL, 2, 9, 37, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(689, '10104181', 'P-02986', 'CM-03832', NULL, NULL, 2, 6, 9, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(690, '10104201', 'P-02987', NULL, NULL, NULL, 2, 3, 3, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(691, '10104202', NULL, 'CM-03741', NULL, NULL, 2, 16, 21, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(692, '00302005', 'P-02508', NULL, NULL, NULL, 6, 16, 14, 86, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(693, '00302006', NULL, NULL, NULL, NULL, 6, 5, 4, 86, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(694, '00303052', 'P-02815', NULL, NULL, NULL, 6, 25, 35, 86, 5, 4, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(695, '00302008', 'P-22023', NULL, NULL, NULL, 6, 6, 8, 86, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(696, '10104112', NULL, NULL, NULL, NULL, 6, 6, 67, 86, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(697, '10104774', 'P-03201', NULL, NULL, NULL, 4, 2, 5, 101, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(698, '10104762', 'P-03203', 'CM-03877', NULL, NULL, 4, 16, 36, 101, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(699, '00303097', NULL, NULL, NULL, NULL, 4, 35, 56, 101, 1, 9, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(700, '13305018', 'P-02016', NULL, NULL, NULL, 5, 9, 32, 51, 4, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(701, '00504253', 'P-23231', 'CM-05831', '111002', NULL, 5, 4, 55, 144, 1, 21, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(702, '00504254', 'P-23208', 'CM-05829', '111004', NULL, 2, 4, 55, 144, 1, 21, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(703, '00508023', 'P-23216', 'CM-06972', '106008', NULL, 10, 2, 1, 91, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL);
INSERT INTO `clase_productos` (`id_producto`, `item`, `codigo_producto`, `codigo_caja`, `codigo_precio`, `precio`, `id_capa`, `id_vitola`, `id_nombre`, `id_marca`, `id_cello`, `id_tipo_empaque`, `presentacion`, `sampler`, `descripcion_sampler`, `created_at`, `updated_at`) VALUES
(704, '00504256', 'P-23416', 'CM-04520', '111008', NULL, 3, 4, 55, 144, 1, 21, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(705, '9900004021', 'P-23049', 'CM-06849', '142006', NULL, 1, 3, 16, 53, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(706, '00804060', 'P-23387', 'CM-04524', '7411', NULL, 5, 18, 6, 209, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(707, '00804061', 'P-23381', 'CM-06872', '7409', NULL, 5, 3, 3, 209, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(708, '00503051', 'P-02005', NULL, '1037-D', NULL, 2, 2, 1, 51, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(709, '14399007', 'P-02563', NULL, '28008', NULL, 3, 16, 21, 147, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(710, '47006003', 'P-02078', NULL, '1515', NULL, 6, 311, 4, 55, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(711, '12506013', 'P-22251', NULL, '90032', NULL, 1, 4, 2, 61, 1, 68, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(712, '15406015', 'P-02272', NULL, '6313', NULL, 6, 1, 1, 211, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(713, '12506014', 'P-22325', NULL, '90004', NULL, 1, 2, 1, 61, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(714, '47801213', 'P-22734', NULL, '112027', NULL, 8, 9, 2, 152, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(715, '001105054', 'P-22493', NULL, NULL, NULL, 5, 38, 127, 115, 4, 20, 'Puros Tripa Corta', 'no', NULL, NULL, NULL),
(716, '10104208', 'P-02250', 'CM-03829', '5932', NULL, 2, 5, 51, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(717, '10104198', 'P-01326', 'CM-03743', '5925', NULL, 2, 19, 84, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(718, '10104223', 'P-22138', 'CM-03831', '5930', NULL, 2, 33, 58, 15, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(719, '10104214', 'P-02440', 'CM-03838', '4221', NULL, 3, 19, 101, 14, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(720, '10104234', 'P-02197', 'CM-03749', '4214', NULL, 3, 3, 3, 14, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(721, '10104213', 'P-02441', 'CM-04542', '4231', NULL, 3, 44, 61, 14, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(722, '00705020', 'P-22195', NULL, NULL, NULL, 6, 22, 34, 414, 4, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(723, '603005761', 'P-23377', NULL, '161003', NULL, 1, 2, 1, 92, 1, 10, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(724, '20018000', 'P-22370', NULL, '96011', NULL, 1, 1, 1, 113, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(725, '12507002', 'P-22595', 'CM-07057', '90023', NULL, 1, 6, 43, 61, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(726, '603004000', 'P-22516', NULL, '110006', '0.00', 1, 26, 123, 88, 1, 7, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(727, '15406024', 'P-22097', NULL, '6316', NULL, 6, 4, 2, 211, 1, 11, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(728, '12805004', 'P-02534', NULL, '23001', NULL, 3, 4, 14, 1386, 1, 12, 'Puros Tripa Larga', 'no', NULL, NULL, NULL),
(729, '9900009188', NULL, NULL, NULL, NULL, 19, 45, 153, 1464, 1, 11, 'Puros Tripa Larga', 'si', 'La Palina Robusto Sampler', NULL, NULL),
(730, '9900009190', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 1, 87, 'Puros Tripa Larga', 'si', 'La Palina Magificent 7 Sampler', NULL, NULL),
(731, '02008066', NULL, NULL, NULL, NULL, 19, 45, 153, 1450, 2, 1, 'Puros Tripa Larga', 'si', 'RP Deluxe Toro Tubo 2015 Sampler', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_clase_productos`
--

DROP TABLE IF EXISTS `detalle_clase_productos`;
CREATE TABLE IF NOT EXISTS `detalle_clase_productos` (
  `id_producto` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_capa` int(11) NOT NULL,
  `id_vitola` int(11) NOT NULL,
  `id_nombre` int(11) NOT NULL,
  `id_marca` int(11) NOT NULL,
  `id_cello` int(11) NOT NULL,
  `id_tipo_empaque` int(11) NOT NULL,
  `otra_descripcion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=344 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_clase_productos`
--

INSERT INTO `detalle_clase_productos` (`id_producto`, `item`, `id_capa`, `id_vitola`, `id_nombre`, `id_marca`, `id_cello`, `id_tipo_empaque`, `otra_descripcion`, `created_at`, `updated_at`) VALUES
(222, '00904038', 2, 4, 2, 51, 1, 14, '1035', NULL, NULL),
(223, '00904038', 5, 4, 2, 51, 1, 14, '1034', NULL, NULL),
(224, '00904038', 1, 4, 2, 51, 1, 14, '90016', NULL, NULL),
(225, '00904038', 3, 4, 2, 51, 1, 14, '1070-C', NULL, NULL),
(226, '10499012', 5, 4, 2, 51, 1, 10, '1034', NULL, NULL),
(227, '10499012', 1, 4, 2, 113, 1, 10, '96002', NULL, NULL),
(228, '10499012', 8, 4, 2, 152, 4, 10, '112017', NULL, NULL),
(229, '10499012', 2, 4, 3, 15, 4, 10, '5901', NULL, NULL),
(230, '10499012', 3, 4, 3, 147, 4, 10, '28005', NULL, NULL),
(231, '10499060', 19, 45, 1, 90, 4, 11, '0000', NULL, NULL),
(232, '10499060', 2, 45, 1, 67, 4, 11, '0000', NULL, NULL),
(233, '10499060', 19, 45, 1, 255, 4, 11, '0000', NULL, NULL),
(234, '10499060', 1, 2, 1, 51, 4, 11, '0000', NULL, NULL),
(235, '10499060', 19, 45, 1, 457, 4, 11, '0000', NULL, NULL),
(236, '11199000', 18, 1, 6, 59, 1, 10, NULL, NULL, NULL),
(237, '11199000', 2, 4, 3, 59, 1, 10, NULL, NULL, NULL),
(238, '11199000', 18, 43, 73, 59, 1, 10, NULL, NULL, NULL),
(239, '11199000', 1, 24, 14, 59, 1, 10, NULL, NULL, NULL),
(240, '10104940', 3, 1, 6, 90, 1, 9, NULL, NULL, NULL),
(241, '10104940', 6, 2, 1, 99, 1, 9, NULL, NULL, NULL),
(242, '10104940', 1, 2, 1, 61, 1, 9, NULL, NULL, NULL),
(243, '10104940', 2, 2, 1, 51, 1, 9, NULL, NULL, NULL),
(244, '10104940', 3, 2, 1, 51, 1, 9, NULL, NULL, NULL),
(245, '10104940', 3, 2, 1, 67, 1, 9, NULL, NULL, NULL),
(246, '10104940', 2, 2, 1, 15, 1, 9, NULL, NULL, NULL),
(247, '10104940', 3, 2, 1, 14, 1, 9, NULL, NULL, NULL),
(248, '10104940', 6, 2, 1, 86, 1, 9, NULL, NULL, NULL),
(249, '10104940', 4, 2, 5, 101, 1, 9, NULL, NULL, NULL),
(250, '19903027', 3, 1, 6, 90, 1, 9, NULL, NULL, NULL),
(251, '19903027', 1, 1, 1, 113, 1, 9, NULL, NULL, NULL),
(252, '19903027', 1, 17, 23, 88, 1, 9, NULL, NULL, NULL),
(253, '19903027', 5, 2, 1, 51, 1, 9, NULL, NULL, NULL),
(254, '19903027', 4, 17, 1, 191, 1, 9, NULL, NULL, NULL),
(255, '19903027', 2, 17, 1, 167, 1, 9, NULL, NULL, NULL),
(256, '19903027', 6, 1, 1, 211, 1, 9, NULL, NULL, NULL),
(257, '19903027', 2, 2, 1, 15, 1, 9, NULL, NULL, NULL),
(258, '19903027', 3, 2, 1, 14, 1, 9, NULL, NULL, NULL),
(259, '19903027', 6, 2, 1, 86, 1, 9, NULL, NULL, NULL),
(260, '9900009186', 1, 2, 1, 53, 1, 10, NULL, NULL, NULL),
(261, '9900009186', 3, 2, 1, 229, 1, 10, NULL, NULL, NULL),
(262, '9900009186', 3, 1, 6, 90, 1, 10, NULL, NULL, NULL),
(263, '9900009186', 5, 2, 1, 51, 1, 10, NULL, NULL, NULL),
(264, '9900009189', 3, 3, 2, 229, 1, 11, NULL, NULL, NULL),
(265, '9900009187', 3, 3, 2, 229, 1, 11, NULL, NULL, NULL),
(275, '10499015', 19, 3, 2, 457, 1, 11, NULL, NULL, NULL),
(267, '9900009187', 2, 25, 2, 94, 1, 11, NULL, NULL, NULL),
(268, '9900009187', 1, 3, 2, 228, 1, 11, NULL, NULL, NULL),
(269, '9900009187', 1, 3, 2, 53, 1, 11, NULL, NULL, NULL),
(270, '9900009187', 1, 3, 2, 230, 1, 11, NULL, NULL, NULL),
(271, '19902999', 2, 4, 2, 50, 1, 10, NULL, NULL, NULL),
(272, '19902999', 6, 4, 2, 149, 1, 10, NULL, NULL, NULL),
(273, '19902999', 2, 4, 2, 146, 1, 10, NULL, NULL, NULL),
(274, '19902999', 3, 4, 2, 112, 1, 10, NULL, NULL, NULL),
(276, '10499015', 19, 3, 2, 754, 1, 11, NULL, NULL, NULL),
(277, '10499015', 3, 3, 3, 90, 1, 11, NULL, NULL, NULL),
(278, '10499015', 2, 3, 3, 15, 1, 11, NULL, NULL, NULL),
(279, '10499015', 3, 4, 2, 51, 1, 11, NULL, NULL, NULL),
(280, '47801009', 6, 2, 1, 168, 1, 10, NULL, NULL, NULL),
(281, '47801009', 6, 4, 2, 168, 1, 10, NULL, NULL, NULL),
(282, '47801009', 6, 3, 14, 168, 1, 10, NULL, NULL, NULL),
(283, '47801009', 6, 5, 4, 168, 1, 10, NULL, NULL, NULL),
(284, '10499014', 6, 2, 1, 99, 1, 24, NULL, NULL, NULL),
(285, '10499014', 6, 2, 1, 86, 1, 24, NULL, NULL, NULL),
(286, '10499014', 6, 2, 1, 168, 1, 24, NULL, NULL, NULL),
(287, '10499063', 8, 4, 2, 152, 1, 9, NULL, NULL, NULL),
(288, '10499063', 6, 3, 14, 168, 1, 9, NULL, NULL, NULL),
(289, '10499063', 3, 16, 21, 147, 1, 9, NULL, NULL, NULL),
(290, '10499063', 5, 4, 2, 51, 1, 9, NULL, NULL, NULL),
(291, '10499063', 2, 2, 1, 15, 1, 9, NULL, NULL, NULL),
(292, '10499063', 6, 2, 1, 86, 1, 9, NULL, NULL, NULL),
(293, '10499063', 4, 2, 5, 101, 1, 9, NULL, NULL, NULL),
(294, '10499063', 1, 1, 1, 113, 1, 9, NULL, NULL, NULL),
(295, '10499063', 1, 17, 23, 88, 1, 9, NULL, NULL, NULL),
(296, '10499063', 19, 2, 1, 1463, 1, 9, NULL, NULL, NULL),
(297, '10499062', 2, 2, 1, 15, 1, 11, NULL, NULL, NULL),
(298, '10499062', 3, 2, 1, 14, 1, 11, NULL, NULL, NULL),
(299, '10499062', 6, 2, 1, 86, 1, 11, NULL, NULL, NULL),
(300, '10499062', 4, 2, 5, 101, 1, 11, NULL, NULL, NULL),
(301, '10499062', 19, 2, 1, 1464, 1, 11, NULL, NULL, NULL),
(302, '10499061', 3, 1, 6, 90, 1, 22, NULL, NULL, NULL),
(303, '10499061', 2, 45, 1, 67, 1, 22, NULL, NULL, NULL),
(304, '10499061', 2, 2, 1, 15, 1, 22, NULL, NULL, NULL),
(305, '02008065', 2, 2, 1, 3, 8, 27, NULL, NULL, NULL),
(306, '02008065', 3, 2, 1, 67, 1, 5, NULL, NULL, NULL),
(307, '02008065', 3, 1, 1, 90, 1, 5, NULL, NULL, NULL),
(308, '02008065', 4, 1, 1, 207, 1, 5, NULL, NULL, NULL),
(309, '02008065', 1, 1, 1, 113, 1, 5, NULL, NULL, NULL),
(310, '02008065', 1, 1, 1, 88, 1, 5, NULL, NULL, NULL),
(311, '10499013', 2, 38, 68, 59, 1, 20, NULL, NULL, NULL),
(312, '10499013', 8, 9, 69, 152, 1, 20, NULL, NULL, NULL),
(313, '10499013', 2, 9, 32, 51, 1, 20, NULL, NULL, NULL),
(314, '10499013', 19, 9, 11, 28, 1, 20, NULL, NULL, NULL),
(315, '02008048', 3, 3, 3, 90, 1, 6, NULL, NULL, NULL),
(316, '02008048', 3, 3, 2, 67, 1, 6, NULL, NULL, NULL),
(317, '02008048', 3, 3, 2, 360, 1, 6, NULL, NULL, NULL),
(318, '02008048', 5, 3, 3, 186, 1, 6, NULL, NULL, NULL),
(319, '02008048', 3, 4, 2, 51, 1, 6, NULL, NULL, NULL),
(320, '00303110', 19, 35, 56, 15, 1, 27, NULL, NULL, NULL),
(321, '00303110', 19, 35, 56, 15, 1, 27, NULL, NULL, NULL),
(322, '00303110', 19, 35, 56, 15, 1, 27, NULL, NULL, NULL),
(323, '00303110', 4, 35, 56, 101, 1, 12, NULL, NULL, NULL),
(324, '00303110', 19, 35, 56, 180, 1, 27, NULL, NULL, NULL),
(326, '9900009188', 3, 2, 1, 229, 7, 11, '153002', NULL, NULL),
(327, '9900009188', 2, 2, 1, 94, 1, 11, '154002', NULL, NULL),
(328, '9900009188', 1, 2, 1, 228, 1, 11, '166001', NULL, NULL),
(329, '9900009188', 1, 2, 1, 53, 1, 11, '142003', NULL, NULL),
(330, '9900009188', 1, 2, 1, 230, 1, 22, '186003', NULL, NULL),
(331, '9900009190', 23, 45, 2, 1465, 1, 87, NULL, NULL, NULL),
(332, '9900009190', 19, 45, 1, 1466, 1, 87, NULL, NULL, NULL),
(333, '9900009190', 19, 45, 16, 1467, 1, 87, NULL, NULL, NULL),
(334, '9900009190', 2, 45, 2, 1468, 1, 87, NULL, NULL, NULL),
(335, '9900009190', 19, 45, 30, 1469, 1, 87, NULL, NULL, NULL),
(336, '9900009190', 1, 2, 1, 53, 1, 87, '142003', NULL, NULL),
(337, '9900009190', 3, 3, 2, 229, 1, 87, '153003', NULL, NULL),
(338, '02008066', 3, 3, 35, 90, 2, 1, '7504', NULL, NULL),
(339, '02008066', 19, 45, 77, 754, 2, 1, NULL, NULL, NULL),
(340, '02008066', 19, 25, 77, 457, 2, 1, NULL, NULL, NULL),
(341, '02008066', 2, 25, 77, 15, 2, 1, NULL, NULL, NULL),
(342, '02008066', 6, 25, 77, 86, 2, 1, NULL, NULL, NULL),
(343, '02008066', 3, 25, 77, 67, 2, 1, '1189', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_factura`
--

DROP TABLE IF EXISTS `detalle_factura`;
CREATE TABLE IF NOT EXISTS `detalle_factura` (
  `id_detalle` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_pendiente` bigint(20) NOT NULL DEFAULT '0',
  `id_venta` int(11) NOT NULL,
  `cantidad_cajas` smallint(6) DEFAULT NULL,
  `peso_bruto` decimal(5,2) NOT NULL,
  `peso_neto` decimal(5,2) NOT NULL,
  `cantidad_puros` smallint(6) NOT NULL,
  `unidad` smallint(6) NOT NULL,
  `observaciones` tinytext,
  `facturado` char(1) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_factura`
--

INSERT INTO `detalle_factura` (`id_detalle`, `id_pendiente`, `id_venta`, `cantidad_cajas`, `peso_bruto`, `peso_neto`, `cantidad_puros`, `unidad`, `observaciones`, `facturado`) VALUES
(1, 744, 1, 20, '9.00', '9.00', 2, 500, 'Sin Facturar', 'S'),
(2, 710, 2, 20, '32.00', '22.00', 2, 500, 'Sin Facturar', 'S'),
(3, 149, 2, 20, '41.00', '23.00', 4, 100, 'Sin Facturar', 'S'),
(4, 327, 0, 20, '23.00', '22.00', 1, 200, 'Sin Facturar', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_programacion`
--

DROP TABLE IF EXISTS `detalle_programacion`;
CREATE TABLE IF NOT EXISTS `detalle_programacion` (
  `id_detalle_programacion` int(11) NOT NULL AUTO_INCREMENT,
  `numero_orden` varchar(50) DEFAULT NULL,
  `orden` varchar(50) DEFAULT NULL,
  `cod_producto` varchar(50) DEFAULT NULL,
  `saldo` decimal(10,2) DEFAULT NULL,
  `id_programacion` int(11) DEFAULT NULL,
  `id_pendiente` int(11) DEFAULT NULL,
  `cajas` varchar(50) DEFAULT NULL,
  `cant_cajas` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_detalle_programacion`)
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_programacion`
--

INSERT INTO `detalle_programacion` (`id_detalle_programacion`, `numero_orden`, `orden`, `cod_producto`, `saldo`, `id_programacion`, `id_pendiente`, `cajas`, `cant_cajas`) VALUES
(1, '3193', 'HON-3063-11- 2020', 'P-02020', '1600.00', 1, 577, 'Faltan -155 cajas', -155),
(2, '3201', 'HON-3100-01- 2021', 'P-02020', '18000.00', 1, 925, 'Faltan -159 cajas', -159),
(3, '3201', 'HON-3100-01- 2021', 'P-02020', '2400.00', 1, 926, 'Faltan -275 cajas', -275),
(4, '3207', 'HON-3120-02- 2021', 'P-02020', '68000.00', 1, 1243, 'Faltan -839 cajas', -839),
(5, '3207', 'HON-3120-02- 2021', 'P-02020', '11600.00', 1, 1245, 'Faltan -855 cajas', -855),
(6, '3217', 'HON-3142-03- 2021', 'P-02020', '1600.00', 1, 1538, 'Faltan -935 cajas', -935),
(7, '3222', 'HON-3166-04- 2021', 'P-02020', '250.00', 1, 1624, NULL, NULL),
(8, '3222', 'HON-3167-04- 2021', 'P-02020', '3200.00', 1, 1766, 'Faltan -1095 cajas', -1095),
(9, '3222', 'HON-3147-04- 2021', 'P-02020', '8750.00', 1, 1767, NULL, NULL),
(10, '3201', 'HON-3100-01- 2021', 'p-02017', '3500.00', 1, 922, 'Faltan -150 cajas', -150),
(11, '3207', 'HON-3120-02- 2021', 'p-02017', '18000.00', 1, 1239, 'Faltan -1050 cajas', -1050),
(12, '3217', 'HON-3142-03- 2021', 'p-02017', '7200.00', 1, 1534, 'Faltan -1410 cajas', -1410),
(13, '3222', 'HON-3167-04- 2021', 'p-02017', '5200.00', 1, 1762, 'Faltan -1670 cajas', -1670),
(14, '3222', 'HON-3167-04- 2021', 'P-22251', '5600.00', 1, 1822, 'Faltan -1141 cajas', -1141),
(15, '3222', 'HON-3147-04- 2021', 'P-22251', '12500.00', 1, 1823, NULL, NULL),
(16, '3222', 'HON-3169-04- 2021', 'P-22300', '1000.00', 1, 1679, NULL, NULL),
(17, '3222', 'HON-3167-04- 2021', 'P-22300', '4800.00', 1, 1826, 'Faltan -112 cajas', -112),
(18, '3222', 'HON-3147-04- 2021', 'P-22300', '7500.00', 1, 1827, NULL, NULL),
(19, '3217', 'HON-3127-03- 2021', 'P-23833', '10000.00', 1, 1391, NULL, NULL),
(20, '3217', 'HON-3127-03- 2021', 'P-23833', '3000.00', 1, 1392, NULL, NULL),
(21, '3217', 'HON-3127-03- 2021', 'P-23833', '2500.00', 1, 1393, NULL, NULL),
(22, '3217', 'HON-3142-03- 2021', 'P-22263', '1200.00', 1, 1563, NULL, NULL),
(23, '3222', 'HON-3167-04- 2021', 'p-02002', '6000.00', 1, 1751, 'Faltan -20 cajas', -20),
(24, '3222', 'HON-3147-04- 2021', 'p-02002', '12500.00', 1, 1752, NULL, NULL),
(25, '3222', 'HON-3167-04- 2021', 'P-02003', '2000.00', 1, 1753, 'Faltan -39 cajas', -39),
(26, '3222', 'HON-3167-04- 2021', 'P-02003', '2000.00', 1, 1754, 'Sobran 65 cajas', 65),
(27, '3222', 'HON-3162-04- 2021', 'P-02016', '500.00', 1, 1623, NULL, NULL),
(28, '3222', 'HON-3167-04- 2021', 'P-02016', '4800.00', 1, 1761, 'Faltan -161 cajas', -161),
(29, '3222', 'HON-3167-04- 2021', 'P-22247', '5490.00', 1, 1819, 'Faltan -40 cajas', -40),
(30, '3217', 'HON-3142-03- 2021', 'P-22248', '1200.00', 1, 1544, 'Sobran 25 cajas', 25),
(31, '3222', 'HON-3167-04- 2021', 'P-02005', '4000.00', 1, 1758, 'Sobran 291 cajas', 291),
(32, '3222', 'HON-3174-04- 2021', NULL, '10000.00', 1, 1621, NULL, NULL),
(33, '3217', 'HON-3142-03- 2021', 'P-02011', '1500.00', 1, 1531, 'Sobran 6 cajas', 6),
(34, '3217', 'HON-3142-03- 2021', 'P-22078', '800.00', 1, 1541, 'Faltan -344 cajas', -344),
(35, '3222', 'HON-3167-04- 2021', 'P-02004', '3600.00', 1, 1756, 'Faltan -204 cajas', -204),
(36, '3207', 'HON-3112-02- 2021', 'P-02034', '2000.00', 1, 1163, NULL, NULL),
(37, '3217', 'HON-3138-03- 2021', 'P-02034', '5000.00', 1, 1366, NULL, NULL),
(38, '3217', 'HON-3142-03- 2021', 'P-02034', '4400.00', 1, 1508, 'Sobran 455 cajas', 455),
(39, '3222', 'HON-3167-04- 2021', 'P-02034', '2000.00', 1, 1782, 'Sobran 355 cajas', 355),
(40, '3217', 'HON-3142-03- 2021', 'P-02032', '1200.00', 1, 1506, 'Faltan -147 cajas', -147),
(41, '3222', 'HON-3151-04- 2021', 'P-02033', '4250.00', 1, 1626, NULL, NULL),
(42, '3222', 'HON-3161-04- 2021', 'P-02033', '1000.00', 1, 1627, NULL, NULL),
(43, '3222', 'HON-3167-04- 2021', 'P-02033', '2400.00', 1, 1781, 'Sobran 31 cajas', 31),
(44, '3217', 'HON-3142-03- 2021', 'P-02924', '400.00', 1, 1511, 'Sobran 26 cajas', 26),
(45, '3217', 'HON-3142-03- 2021', 'P-02040', '400.00', 1, 1509, 'Faltan -17 cajas', -17),
(46, '3222', 'HON-3167-04- 2021', 'P-02040', '800.00', 1, 1784, 'Faltan -57 cajas', -57),
(47, '3217', 'HON-3142-03- 2021', 'P-02342', '1200.00', 1, 1444, 'Faltan -20 cajas', -20),
(48, '3222', 'HON-3167-04- 2021', 'P-02342', '2400.00', 1, 1803, 'Faltan -140 cajas', -140),
(49, '3222', 'HON-3167-04- 2021', 'P-23692', '1600.00', 1, 1843, 'Faltan -402 cajas', -402),
(50, '3217', 'HON-3142-03- 2021', 'P-23694', '5200.00', 1, 1498, 'Faltan -387 cajas', -387),
(51, '3222', 'HON-3167-04- 2021', 'P-23694', '6000.00', 1, 1844, 'Faltan -687 cajas', -687),
(52, '3217', 'HON-3130-03- 2021', 'P-02218', '1500.00', 1, 1419, 'Sobran 25 cajas', 25),
(53, '3217', 'HON-3131-03- 2021', 'P-02220', '6000.00', 1, 1421, NULL, NULL),
(54, '3217', 'HON-3128-03- 2021', 'P-02791', '800.00', 1, 1500, NULL, NULL),
(55, '3217', 'HON-3128-03- 2021', 'P-02913', '800.00', 1, 1501, NULL, NULL),
(56, '3217', 'HON-3128-03- 2021', 'P-23254', '800.00', 1, 1502, NULL, NULL),
(57, '3222', 'HON-3174-04- 2021', 'P-23397', '10000.00', 1, 1727, NULL, NULL),
(58, '3222', 'HON-3174-04- 2021', 'P-23759', '8500.00', 1, 1736, 'Sobran 75 cajas', 75),
(59, '3197', 'HON-3078-12- 2020', 'P-23819', '2000.00', 1, 777, NULL, NULL),
(60, '3197', 'HON-3078-12- 2020', 'P-23820', '2000.00', 1, 778, NULL, NULL),
(61, '3222', 'HON-3167-04- 2021', 'P-02024', '600.00', 1, 1769, NULL, NULL),
(62, '3222', 'HON-3167-04- 2021', 'P-02024', '1600.00', 1, 1770, 'Faltan -169 cajas', -169),
(63, '3222', 'HON-3167-04- 2021', 'P-02024', '2000.00', 1, 1771, 'Faltan -240 cajas', -240),
(64, '3207', 'HON-3120-02- 2021', 'P-02028', '2500.00', 1, 1278, 'Sobran 830 cajas', 830),
(65, '3217', 'HON-3142-03- 2021', 'P-02028', '2000.00', 1, 1555, 'Sobran 730 cajas', 730),
(66, '3217', 'HON-3142-03- 2021', 'P-02028', '2000.00', 1, 1556, NULL, NULL),
(67, '3217', 'HON-3138-03- 2021', 'P-02028', '11000.00', 1, 1382, 'Sobran 0 cajas', 0),
(68, '3217', 'HON-3142-03- 2021', 'P-01308', '1200.00', 1, 1547, 'Faltan -60 cajas', -60),
(69, '3217', 'HON-3142-03- 2021', 'P-01308', '1000.00', 1, 1548, 'Faltan -120 cajas', -120),
(70, '3222', 'HON-3167-04- 2021', 'P-01308', '400.00', 1, 1738, 'Faltan -80 cajas', -80),
(71, '3222', 'HON-3167-04- 2021', 'P-01308', '3000.00', 1, 1739, 'Faltan -180 cajas', -180),
(72, '3207', 'HON-3120-02- 2021', 'P-02025', '1000.00', 1, 1274, 'Sobran 292 cajas', 292),
(73, '3222', 'HON-3164-04- 2021', 'P-02095', '3000.00', 1, 1639, NULL, NULL),
(74, '3217', 'HON-3141-03- 2021', 'P-02097', '2500.00', 1, 1338, NULL, NULL),
(75, '3222', 'HON-3164-04- 2021', 'P-02097', '1000.00', 1, 1641, NULL, NULL),
(76, '3222', 'HON-3164-04- 2021', 'P-02097', '2000.00', 1, 1642, NULL, NULL),
(77, '3207', 'HON-3118-02- 2021', 'P-02096', '2300.00', 1, 987, NULL, NULL),
(78, '3222', 'HON-3164-04- 2021', 'P-02096', '1500.00', 1, 1640, 'Sobran 50 cajas', 50),
(79, '3222', 'HON-3164-04- 2021', 'P-02098', '1500.00', 1, 1643, 'Faltan -71 cajas', -71),
(80, '3207', 'HON-3110-02- 2021', 'P-02371', '320.00', 1, 1039, 'Sobran 0 cajas', 0),
(81, '3207', 'HON-3110-02- 2021', 'P-02375', '500.00', 1, 1042, NULL, NULL),
(82, '3207', 'HON-3110-02- 2021', 'P-02376', '500.00', 1, 1043, NULL, NULL),
(83, '3217', 'HON-3142-03- 2021', 'P-22368', '19840.00', 1, 1446, 'Sobran 301 cajas', 301),
(84, '3222', 'HON-3167-04- 2021', 'P-22157', '400.00', 1, 1818, NULL, NULL),
(85, '3222', 'HON-3164-04- 2021', 'P-23402', '600.00', 1, 1728, 'Sobran 0 cajas', 0),
(86, '3222', 'HON-3159-04- 2021', 'P-23402', '200.00', 1, 1729, NULL, NULL),
(87, '3217', 'HON-3144-03- 2021', 'P-22640', '200.00', 1, 1490, NULL, NULL),
(88, '3217', 'HON-3144-03- 2021', 'P-22641', '200.00', 1, 1491, NULL, NULL),
(89, '3217', 'HON-3144-03- 2021', 'P-22642', '200.00', 1, 1492, NULL, NULL),
(90, '3217', 'HON-3142-03- 2021', 'P-02181', '400.00', 1, 1495, NULL, NULL),
(91, '3217', 'HON-3142-03- 2021', 'P-02179', '400.00', 1, 1494, 'Faltan -20 cajas', -20),
(92, '3217', 'HON-3126-03- 2021', 'P-02360', '400.00', 1, 1499, NULL, NULL),
(93, '3222', 'HON-3168-04- 2021', 'P-02616', '2400.00', 1, 1876, NULL, NULL),
(94, '3222', 'HON-3168-04- 2021', 'P-02613', '2400.00', 1, 1873, NULL, NULL),
(95, '3217', 'HON-3140-03- 2021', 'P-22646', '750.00', 1, 1426, NULL, NULL),
(96, '3222', 'HON-3163-04- 2021', NULL, '500.00', 1, 1812, NULL, NULL),
(97, '3217', 'HON-3142-03- 2021', 'P-03203', '800.00', 1, 1568, 'Faltan -40 cajas', -40),
(98, '3217', 'HON-3142-03- 2021', 'P-03204', '800.00', 1, 1569, 'Sobran 54 cajas', 54),
(99, '3222', 'HON-3167-04- 2021', 'P-02339', '4480.00', 1, 1801, 'Faltan -4864 cajas', -4864),
(100, '3207', 'HON-3120-02- 2021', 'P-02339', '16800.00', 1, 1023, 'Faltan -5704 cajas', -5704),
(101, '3207', 'HON-3112-02- 2021', 'P-22518', '5000.00', 1, 970, NULL, NULL),
(102, '3217', 'HON-3142-03- 2021', 'P-02341', '400.00', 1, 1443, 'Faltan -58 cajas', -58),
(103, '3222', 'HON-3167-04- 2021', 'P-02341', '400.00', 1, 1802, 'Faltan -78 cajas', -78),
(104, '3217', 'HON-3127-03- 2021', 'P-02260', '2000.00', 1, 1463, NULL, NULL),
(105, '3222', 'HON-3159-04- 2021', 'P-02561', '750.00', 1, 1674, NULL, NULL),
(106, '3222', 'HON-3167-04- 2021', 'P-02338', '5200.00', 1, 1799, 'Faltan -260 cajas', -260),
(107, '3222', 'HON-3156-04- 2021', 'P-23412', '3750.00', 1, 1840, NULL, NULL),
(108, '3222', 'HON-3155-04- 2021', 'P-23274', '400.00', 1, 1890, NULL, NULL),
(109, '3222', 'HON-3155-04- 2021', 'P-23275', '750.00', 1, 1891, NULL, NULL),
(110, '3222', 'HON-3167-04- 2021', 'P-22251', '16000.00', 1, 1821, 'Faltan -82 cajas', -82),
(111, '3222', 'HON-3167-04- 2021', 'P-02004', '400.00', 1, 1755, NULL, NULL),
(112, '3222', 'HON-3168-04- 2021', 'P-22613', '2400.00', 1, 1884, NULL, NULL),
(113, '3217', 'HON-3137-03- 2021', 'P-02321', '1000.00', 1, 1571, NULL, NULL),
(114, '3207', 'HON-3108-02- 2021', 'P-02531', '100.00', 1, 1004, 'Faltan -5 cajas', -5),
(115, '3207', 'HON-3118-02- 2021', 'P-02560', '1250.00', 1, 1103, NULL, NULL),
(116, '3217', 'HON-3141-03- 2021', 'P-02560', '4000.00', 1, 1354, NULL, NULL),
(117, '3207', 'HON-3118-02- 2021', 'P-02045', '250.00', 1, 1178, NULL, NULL),
(118, '3222', 'HON-3185-04- 2021', 'P-02617', '240.00', 1, 1877, NULL, NULL),
(119, '3235', 'HON-3181-05- 2021', 'P-02617', '300.00', 1, 2154, NULL, NULL),
(120, '3222', 'HON-3168-04- 2021', NULL, '1800.00', 1, 1879, NULL, NULL),
(121, '3222', 'HON-3165-04- 2021', NULL, '240.00', 1, 1880, NULL, NULL),
(122, '3207', 'HON-3120-02- 2021', 'P-02337', '20000.00', 1, 2276, 'Sobran 21 cajas', 21),
(123, '3207', 'HON-3110-02- 2021', NULL, '200.00', 1, 1038, NULL, NULL),
(124, '3207', 'HON-3106-02- 2021', 'P-02433', '7500.00', 1, 1169, 'Sobran 0 cajas', 0),
(125, '3217', 'HON-3142-03- 2021', 'P-22621', '200.00', 1, 2722, 'Sobran 0 cajas', 0),
(126, '3222', 'HON-3145-04- 2021', 'P-23819', '500.00', 2, 1858, NULL, NULL),
(127, '3222', 'HON-3145-04- 2021', 'P-23820', '500.00', 2, 1859, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_programacion_temporal`
--

DROP TABLE IF EXISTS `detalle_programacion_temporal`;
CREATE TABLE IF NOT EXISTS `detalle_programacion_temporal` (
  `id_detalle_programacion` int(11) NOT NULL AUTO_INCREMENT,
  `numero_orden` varchar(50) DEFAULT NULL,
  `orden` varchar(50) DEFAULT NULL,
  `cod_producto` varchar(50) DEFAULT NULL,
  `saldo` decimal(8,2) DEFAULT NULL,
  `id_pendiente` int(11) DEFAULT NULL,
  `cant_cajas` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_detalle_programacion`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_terminados`
--

DROP TABLE IF EXISTS `factura_terminados`;
CREATE TABLE IF NOT EXISTS `factura_terminados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` varchar(100) NOT NULL DEFAULT '0',
  `numero_factura` varchar(30) DEFAULT '0',
  `contenedor` varchar(50) NOT NULL DEFAULT '0',
  `cantidad_bultos` smallint(6) NOT NULL DEFAULT '0',
  `total_puros` mediumint(9) NOT NULL DEFAULT '0',
  `total_peso_bruto` mediumint(9) NOT NULL DEFAULT '0',
  `total_peso_neto` mediumint(9) NOT NULL DEFAULT '0',
  `fecha_factura` date DEFAULT NULL,
  `facturado` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `factura_terminados`
--

INSERT INTO `factura_terminados` (`id`, `cliente`, `numero_factura`, `contenedor`, `cantidad_bultos`, `total_puros`, `total_peso_bruto`, `total_peso_neto`, `fecha_factura`, `facturado`) VALUES
(1, 'Rocky Patel', '767667878', 'Pimer Contenedor Mayo', 2, 1000, 18, 18, '2021-06-02', 'N'),
(2, 'Rocky', 'FA-00-00000002', 'Primer Contenedor', 6, 1400, 228, 228, '2021-06-02', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `importar_existencias`
--

DROP TABLE IF EXISTS `importar_existencias`;
CREATE TABLE IF NOT EXISTS `importar_existencias` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo_producto` varchar(100) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `vitola` varchar(100) DEFAULT NULL,
  `capa` varchar(100) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2539 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `importar_existencias`
--

INSERT INTO `importar_existencias` (`id`, `codigo_producto`, `marca`, `nombre`, `vitola`, `capa`, `total`, `updated_at`, `created_at`) VALUES
(2129, 'P-01301', 'Decada', 'ROBUSTO RED.', '5X50', 'SUMATRA ', '2565.00', NULL, NULL),
(2130, 'P-01304', 'Decada', 'Torpedo Red.', '6-1/2X52', 'SUMATRA ', '1322.00', NULL, NULL),
(2131, 'P-01305', 'Cuban Blend', 'Torpedo', '6X52 TORPEDO', 'MADURO', '51.00', NULL, NULL),
(2132, 'P-01308', 'The Edge Connecticut', 'Torpedo', '6X52', 'CONNECTICUT', '2129.00', NULL, NULL),
(2133, 'P-01314', 'Junior Vintage 1990', 'Vintage 1990', '4X38', 'HABANO/COL', '1000.00', NULL, NULL),
(2134, 'P-01325', 'Super Fuerte', 'Torpedo Press', '5-1/2X52', 'MADURO', '32.00', NULL, NULL),
(2135, 'P-01326', 'Vintage 1990', 'PETIT CORONA RED.', '4-1/2X44', 'MADURO', '37.00', NULL, NULL),
(2136, 'P-01330', 'Bering', '# 8', '4-1/4X26', 'CONNECTICUT', '32.00', NULL, NULL),
(2137, 'P-01653', 'Blender Gold', 'Robusto', '4-1/2X50', 'MADURO', '48.00', NULL, NULL),
(2138, 'P-01950', 'Cuban Rejects', 'Robusto', '4-3/4X50', 'MADURO', '98.00', NULL, NULL),
(2139, 'P-02000', 'The Edge', 'Toro', '6X52', 'COROJO', '81419.00', NULL, NULL),
(2140, 'P-02001', 'The Edge', 'Toro', '6X52', 'MADURO', '161499.00', NULL, NULL),
(2141, 'P-02002', 'The Edge', 'Torpedo', '6X52', 'COROJO', '3391.00', NULL, NULL),
(2142, 'P-02003', 'The Edge', 'Torpedo', '6X52', 'MADURO', '23325.00', NULL, NULL),
(2143, 'P-02004', 'The Edge', 'Robusto', '5-1/2X50', 'COROJO', '112404.00', NULL, NULL),
(2144, 'P-02005', 'The Edge', 'Robusto', '5-1/2X50', 'MADURO', '13140.00', NULL, NULL),
(2145, 'P-02011', 'The Edge', 'Missile Torpedo', '5X48', 'MADURO', '4411.00', NULL, NULL),
(2146, 'P-02012', 'The Edge', 'Gran Robusto', '5-1/2X54', 'COROJO', '200.00', NULL, NULL),
(2147, 'P-02013', 'The Edge', 'Gran Robusto', '5-1/2X54', 'MADURO', '7325.00', NULL, NULL),
(2148, 'P-02016', 'The Edge', 'Battalion', '6X60', 'COROJO', '6908.00', NULL, NULL),
(2149, 'P-02017', 'The Edge', 'Battalion', '6X60', 'MADURO', '11111.00', NULL, NULL),
(2150, 'P-02018', 'The Edge', 'Double Corona', '7-1/2X52', 'COROJO', '200.00', NULL, NULL),
(2151, 'P-02019', 'The Edge', 'Double Corona', '7-1/2X52', 'MADURO', '809.00', NULL, NULL),
(2152, 'P-02020', 'The Edge', 'Toro', '6X52', 'SUMATRA ', '89418.00', NULL, NULL),
(2153, 'P-02021', 'The Edge', 'Torpedo', '6X52', 'SUMATRA ', '8789.00', NULL, NULL),
(2154, 'P-02024', 'The Edge Connecticut', 'Robusto', '5-1/2X50', 'CONNECTICUT', '10040.00', NULL, NULL),
(2155, 'P-02025', 'The Edge Connecticut', 'Double Corona', '7-1/2X52', 'CONNECTICUT', '2325.00', NULL, NULL),
(2156, 'P-02028', 'The Edge Connecticut', 'Toro', '6X52', 'CONNECTICUT', '23524.00', NULL, NULL),
(2157, 'P-02029', 'Decada', 'Toro Red.', '6-1/2X52', 'SUMATRA ', '21868.00', NULL, NULL),
(2158, 'P-02030', 'The Edge Connecticut', 'Robusto', '4X54', 'CONNECTICUT', '18.00', NULL, NULL),
(2159, 'P-02031', 'The Edge Connecticut', 'Sixty', '6X60', 'CONNECTICUT', '808.00', NULL, NULL),
(2160, 'P-02032', 'Sungrown', 'Petite Corona', '4-1/2X44', 'SUMATRA ', '1405.00', NULL, NULL),
(2161, 'P-02033', 'Sungrown', 'Robusto', '5-1/2X50', 'SUMATRA ', '6645.00', NULL, NULL),
(2162, 'P-02034', 'Sungrown', 'Toro', '6-1/2X52', 'SUMATRA ', '21781.00', NULL, NULL),
(2163, 'P-02039', 'Sungrown', 'Corona', '5-1/2X42', 'SUMATRA ', '1935.00', NULL, NULL),
(2164, 'P-02040', 'Sungrown', 'Sixty Con Moño', '6X60', 'SUMATRA ', '3050.00', NULL, NULL),
(2165, 'P-02041', 'Super Fuerte', 'Robusto Press', '5X50', 'HABANO-2000', '15.00', NULL, NULL),
(2166, 'P-02047', 'Super Fuerte', 'Super Toro Red.', '6X58', 'MADURO', '1000.00', NULL, NULL),
(2167, 'P-02049', 'Classic', 'Boxer', '4-1/2X50', 'COROJO', '80.00', NULL, NULL),
(2168, 'P-02054', 'Classic', 'Teepee', '5-1/2X52X36 PIRAMIDE', 'MADURO', '213.00', NULL, NULL),
(2169, 'P-02077', 'Limited Reserve', 'Bison', '6-1/2X36X54 PIRAMIDE', 'CONNECTICUT', '142.00', NULL, NULL),
(2170, 'P-02084', 'Cameroon Legend', 'Super Toro', '6X58', 'CAMEROON ', '7.00', NULL, NULL),
(2171, 'P-02095', 'Connecticut Rocky Patel', 'Robusto', '5-1/2X50', 'CONNECTICUT', '4484.00', NULL, NULL),
(2172, 'P-02096', 'Connecticut Rocky Patel', 'Toro', '6X52', 'CONNECTICUT', '3939.00', NULL, NULL),
(2173, 'P-02097', 'Connecticut Rocky Patel', 'Torpedo', '6-1/2X52', 'CONNECTICUT', '5500.00', NULL, NULL),
(2174, 'P-02098', 'Connecticut Rocky Patel', 'Churchill', '7X48', 'CONNECTICUT', '2106.00', NULL, NULL),
(2175, 'P-02151', 'Old World Reserve', 'Torpedo Press', '5X54', 'MADURO', '135.00', NULL, NULL),
(2176, 'P-02161', 'Junior Vintage 1992', 'Vintage 1992', '4X38', 'SUMATRA ', '7.00', NULL, NULL),
(2177, 'P-02162', 'Junior Sungrown', 'Sungrown', '4X38', 'HABANO/COL', '1829.00', NULL, NULL),
(2178, 'P-02179', 'Nording', 'Robusto Con Moño', '5-1/2X52', 'HABANO', '400.00', NULL, NULL),
(2179, 'P-02181', 'Nording', 'Torpedo', '4X54', 'HABANO', '405.00', NULL, NULL),
(2180, 'P-02193', 'Vintage 1992', 'Sixty Red.', '6X60', 'SUMATRA ', '6.00', NULL, NULL),
(2181, 'P-02197', 'Vintage 1992', 'Toro Press', '6-1/2X52', 'SUMATRA ', '442.00', NULL, NULL),
(2182, 'P-02209', 'American Market Selection', 'Toro', '6X52', 'CONNECTICUT', '1363.00', NULL, NULL),
(2183, 'P-02218', 'Rosado', 'Petite Corona', '4-1/2X44', 'SUMATRA ', '2000.00', NULL, NULL),
(2184, 'p-02219', 'Rosado', 'Robusto', '5-1/2X50', 'SUMATRA ', '25.00', NULL, NULL),
(2185, 'P-02219', 'Rosado', 'Robusto', '5-1/2X50', 'SUMATRA ', '1977.00', NULL, NULL),
(2186, 'P-02220', 'Rosado', 'Toro', '6-1/2X52', 'SUMATRA ', '6800.00', NULL, NULL),
(2187, 'P-02247', 'Vintage 1990', 'Toro Red.', '6-1/2X52', 'MADURO', '75.00', NULL, NULL),
(2188, 'P-02252', 'Vintage 1990', 'Robusto Press', '5-1/2X50', 'MADURO', '567.00', NULL, NULL),
(2189, 'P-02270', 'Gold By RP', 'Corona', '5-1/2X42', 'CONNECTICUT', '6.00', NULL, NULL),
(2190, 'P-02304', 'Cunuco', 'Corona', '5-1/2X46', 'HABANO/COL', '25.00', NULL, NULL),
(2191, 'P-02321', 'World Famous Cigar Bar', 'Toro Grande', '6-1/2X54', 'CONNECTICUT', '1000.00', NULL, NULL),
(2192, 'P-02337', 'Decada', 'Robusto Press', '5X50', 'SUMATRA ', '150.00', NULL, NULL),
(2193, 'P-02339', 'Decada', 'Toro Press', '6-1/2X52', 'SUMATRA ', '516.00', NULL, NULL),
(2194, 'P-02341', 'Decada', 'Forty Six Press', '4-1/2X46', 'SUMATRA ', '413.00', NULL, NULL),
(2195, 'P-02342', 'Decada', 'Emperor Red.', '6X60', 'SUMATRA ', '5103.00', NULL, NULL),
(2196, 'P-02360', 'RP - Costa Rica', 'Churchill', '7X48', 'MADURO', '400.00', NULL, NULL),
(2197, 'P-02367', 'Gold Maduro By RP', 'Robusto', '5X54', 'MADURO', '51.00', NULL, NULL),
(2198, 'P-02370', 'Desiena 312', 'Robusto', '5-1/2X52', 'CONNECTICUT', '200.00', NULL, NULL),
(2199, 'P-02371', 'Desiena 312', 'Toro', '6-1/2X52', 'CONNECTICUT', '320.00', NULL, NULL),
(2200, 'P-02373', 'Desiena 312', 'Torpedo', '4X54', 'CONNECTICUT', '25.00', NULL, NULL),
(2201, 'P-02375', 'Desiena 312', 'Robusto', '5-1/2X52', 'COROJO', '717.00', NULL, NULL),
(2202, 'P-02376', 'Desiena 312', 'Toro', '6-1/2X52', 'COROJO', '500.00', NULL, NULL),
(2203, 'P-02377', 'Desiena 312', 'Short Torpedo', '4X54', 'COROJO', '100.00', NULL, NULL),
(2204, 'P-02381', 'Desiena 312', 'Super Toro', '6X58', 'CONNECTICUT', '93.00', NULL, NULL),
(2205, 'P-02395', 'Davidus Antietam', 'Robusto', '5X50', 'HABANO', '13.00', NULL, NULL),
(2206, 'P-02397', 'Junior Vintage 1999', 'Vintage 1999', '4X38', 'CONNECTICUT', '208.00', NULL, NULL),
(2207, 'P-02406', 'Nick Cigar World 10 Anivereary', 'Robusto', '5-1/2X50', 'CONNECTICUT', '200.00', NULL, NULL),
(2208, 'P-02407', 'Nick Cigar World 10 Anivereary', 'Toro', '6-1/2X52', 'CONNECTICUT', '925.00', NULL, NULL),
(2209, 'P-02408', 'Nick Cigar World 10 Anivereary', 'Torpedo', '6-1/2X52', 'CONNECTICUT', '500.00', NULL, NULL),
(2210, 'P-02409', 'Nick Cigar World 10 Anivereary', 'Churchill', '7X48', 'CONNECTICUT', '200.00', NULL, NULL),
(2211, 'P-02414', 'Cameroon By RP', 'Robusto', '5X54', 'CAMEROON ', '600.00', NULL, NULL),
(2212, 'P-02415', 'Cameroon By RP', 'Toro', '6X52', 'CAMEROON ', '450.00', NULL, NULL),
(2213, 'P-02432', 'Sungrown', 'Churchill', '7X49', 'SUMATRA ', '75.00', NULL, NULL),
(2214, 'P-02433', 'Sungrown', 'Toro', '6X50', 'SUMATRA ', '9615.00', NULL, NULL),
(2215, 'P-02439', 'Nording', 'Toro', '6-1/2X52', 'HABANO', '1900.00', NULL, NULL),
(2216, 'P-02468', 'Vintage 1990', 'Petite Corona Press', '4-1/2X44', 'MADURO', '1214.00', NULL, NULL),
(2217, 'P-02476', 'Gold By RP', 'Lancero', '7X38', 'CONNECTICUT', '181.00', NULL, NULL),
(2218, 'P-02477', 'Cuban Blend', 'Double Corona', '7-1/2X52', 'COROJO', '300.00', NULL, NULL),
(2219, 'P-02481', 'Cuban Blend', 'Sixty', '6X60', 'MADURO', '1650.00', NULL, NULL),
(2220, 'P-02488', 'Decada', 'Short Robusto Press', '4X54', 'SUMATRA ', '1582.00', NULL, NULL),
(2221, 'P-02503', 'Vintage 1999', 'Perfecto', '4-1/2X46X49', 'CONNECTICUT', '597.00', NULL, NULL),
(2222, 'P-02506', 'Vintage 1999', 'Robusto', '5X50', 'CONNECTICUT', '34.00', NULL, NULL),
(2223, 'P-02507', 'Vintage 1999', 'Toro', '6-1/2X52', 'CONNECTICUT', '19.00', NULL, NULL),
(2224, 'P-02508', 'Vintage 1999', 'Torpedo', '6-1/4X52', 'CONNECTICUT', '405.00', NULL, NULL),
(2225, 'P-02530', 'Davidus PL Monocacy', 'Robusto Press', '5X50', 'SUMATRA ', '103.00', NULL, NULL),
(2226, 'P-02533', 'Davidus PL Monocacy', 'Piramide Press', '6X52', 'SUMATRA ', '19.00', NULL, NULL),
(2227, 'P-02563', 'Royal vintage By RP', 'Torpedo Press', '6-1/4X52', 'SUMATRA ', '2034.00', NULL, NULL),
(2228, 'P-02612', 'RP Factory Over- Runs-E (edge lite)', 'Toro', '6X52', 'CONNECTICUT', '650.00', NULL, NULL),
(2229, 'P-02613', 'RP Factory Over- Runs-E (edge lite)', 'Torpedo', '6X52', 'CONNECTICUT', '2400.00', NULL, NULL),
(2230, 'P-02614', 'RP Factory Over- Runs-E (edge lite)', 'Churchill', '7X49', 'CONNECTICUT', '2315.00', NULL, NULL),
(2231, 'P-02615', 'RP Factory Over- Runs-E (edge lite)', 'Double Corona', '7-1/2X52', 'CONNECTICUT', '380.00', NULL, NULL),
(2232, 'P-02616', 'RP Factory Over- Runs-E (edge lite)', 'Robusto', '5-1/2X50', 'CONNECTICUT', '2400.00', NULL, NULL),
(2233, 'P-02619', 'RP Factory Over- Runs-D (Decade f/s)', 'Sixty', '6X60', 'SUMATRA ', '2040.00', NULL, NULL),
(2234, 'P-02637', 'Gran Vida', 'Toro', '6-1/2X52', 'PENSILVANIA MAD', '125.00', NULL, NULL),
(2235, 'P-02640', 'RP Factory Over - Runs- O.W.R.', 'Torpedo', '5X54', 'MADURO', '505.00', NULL, NULL),
(2236, 'P-02645', 'RP Factory Over - Runs- O.W.R.', 'Robusto', '5-1/2X54', 'COROJO', '213.00', NULL, NULL),
(2237, 'P-02681', 'Outback', 'Torpedo', '6X52', 'COROJO', '194.00', NULL, NULL),
(2238, 'P-02694', 'Caucus', 'Torpedo', '5-3/4X52', 'SUMATRA ', '500.00', NULL, NULL),
(2239, 'P-02695', 'Caucus', 'Robusto', '5X50', 'SUMATRA ', '37.00', NULL, NULL),
(2240, 'P-02729', 'Desiena 312', 'Torpedo', '5X54', 'COROJO', '25.00', NULL, NULL),
(2241, 'P-02757', 'The Edge', 'Lancero', '7X38', 'COROJO', '1175.00', NULL, NULL),
(2242, 'P-02791', 'Shockoe Valley', 'Toro', '6X52', 'HABANO', '800.00', NULL, NULL),
(2243, 'P-02796', 'Gold Maduro By RP', 'Belicoso', '6-1/2X52', 'MADURO', '100.00', NULL, NULL),
(2244, 'p-02808', 'Super Fuerte', 'Torpedo Red.', '5-1/2X52', 'MADURO', '100.00', NULL, NULL),
(2245, 'P-02815', 'Vintage 1999', 'Toro Red.', '6X50', 'CONNECTICUT', '20.00', NULL, NULL),
(2246, 'P-02847', 'Cuban Blend', 'Double Corona', '7-1/2X52', 'MADURO', '1200.00', NULL, NULL),
(2247, 'P-02912', 'Rosado', 'Double Corona', '7-1/2X52', 'SUMATRA ', '3.00', NULL, NULL),
(2248, 'P-02913', 'Shockoe Valley', 'Robusto', '5X50', 'HABANO', '800.00', NULL, NULL),
(2249, 'P-02924', 'Sungrown', 'Torpedo', '6-1/4X52', 'SUMATRA ', '1074.00', NULL, NULL),
(2250, 'P-02968', 'Tom Gringo', 'TORO', '6X52', 'MADURO', '500.00', NULL, NULL),
(2251, 'P-02977', 'The Edge', 'Short Robusto', '4-1/2X54', 'COROJO', '805.00', NULL, NULL),
(2252, 'P-02985', 'Vintage 1990', 'Corona Press', '5-1/2X44', 'MADURO', '1115.00', NULL, NULL),
(2253, 'P-02986', 'Vintage 1990', 'Petite Belicoso Press', '4-1/2X54', 'MADURO', '1078.00', NULL, NULL),
(2254, 'P-02987', 'Vintage 1990', 'Toro Press', '6-1/2X52', 'MADURO', '1283.00', NULL, NULL),
(2255, 'P-02998', 'Vintage 1992', 'Corona Press', '5-1/2X44', 'SUMATRA ', '125.00', NULL, NULL),
(2256, 'P-03169', 'Old World Reserve', 'Toro Press', '6-1/2X52', 'COROJO', '45.00', NULL, NULL),
(2257, 'P-03193', 'Royal vintage By RP', 'SIXTY', '6X60', 'SUMATRA ', '1900.00', NULL, NULL),
(2258, 'P-03201', 'VINTAGE 2003', 'ROBUSTO RED.', '5-1/2X50', 'CAMEROON ', '4341.00', NULL, NULL),
(2259, 'P-03202', 'VINTAGE 2003', 'Toro Red.', '6-1/2X52', 'CAMEROON ', '9807.00', NULL, NULL),
(2260, 'P-03203', 'VINTAGE 2003', 'Torpedo Red.', '6-1/4X52', 'CAMEROON ', '4000.00', NULL, NULL),
(2261, 'P-03204', 'VINTAGE 2003', 'Sixty Red.', '6X60', 'CAMEROON ', '1502.00', NULL, NULL),
(2262, 'P-03320', 'Vintage 1992', 'CORONA RED.', '5-1/2X44', 'SUMATRA ', '2240.00', NULL, NULL),
(2263, 'P-11157', 'Muestras', 'Corona', '3-1/2X44', 'HABANO', '10.00', NULL, NULL),
(2264, 'P-11215', 'Muestras', NULL, '7-1/2X38', 'HABANO', '32.00', NULL, NULL),
(2265, 'P-11503', 'Muestras', NULL, '6X60', 'SUMATRA ', '10.00', NULL, NULL),
(2266, 'P-11928', 'Muestras', NULL, '4-1/2X50', 'HABANO', '150.00', NULL, NULL),
(2267, 'P-13520', 'Vega Fina Fortaleza Dos', 'Robusto', '5X50', 'Criollo Mexicano/Intermedio', '13.00', NULL, NULL),
(2268, 'P-13554', 'Vegafina Nicaragua', 'Cañonazo', '5-15/16X52', 'Habano-2000/Intermedio', '50.00', NULL, NULL),
(2269, 'P-13562', 'Vega Fina Fortaleza Dos', 'Toro', '6X54', 'Criollo Mexicano/Intermedio', '25.00', NULL, NULL),
(2270, 'P-14110', 'CI RB Genesis The Proyect', 'Robusto', '5X50', 'BROADLEAF/MADURO', '55.00', NULL, NULL),
(2271, 'P-22005', 'The Edge Connecticut', 'MINI BELICOSO', '5X48', 'CONNECTICUT', '300.00', NULL, NULL),
(2272, 'P-22006', 'The Edge Connecticut', 'Corona', '5-1/2X44', 'CONNECTICUT', '407.00', NULL, NULL),
(2273, 'P-22012', 'Decada', 'Petite Belicoso Press', '4-1/2X54', 'SUMATRA ', '1014.00', NULL, NULL),
(2274, 'P-22023', 'Vintage 1999', 'Petite Belicoso', '4-1/2X54', 'CONNECTICUT', '932.00', NULL, NULL),
(2275, 'P-22025', 'Sungrown', 'Petite Belicoso', '4-1/2X54', 'SUMATRA ', '1048.00', NULL, NULL),
(2276, 'P-22026', 'Decada', 'Short Robusto Press', '4-1/2X54', 'SUMATRA ', '179.00', NULL, NULL),
(2277, 'P-22040', 'Muestras', 'VARIOS', '6X52', 'HABANO', '160.00', NULL, NULL),
(2278, 'P-22046', 'Muestras', 'Toro', '6X52', 'COROJO', '20.00', NULL, NULL),
(2279, 'P-22052', 'Muestras', 'Toro', '6X52', 'CONNECTICUT', '5.00', NULL, NULL),
(2280, 'P-22060', 'Smoker Friendly', 'Toro', '6X52', 'COROJO', '1850.00', NULL, NULL),
(2281, 'P-22061', 'Smoker Friendly', 'Toro', '6X52', 'MADURO', '800.00', NULL, NULL),
(2282, 'P-22062', 'Smoker Friendly', 'Toro', '6X52', 'CONNECTICUT', '125.00', NULL, NULL),
(2283, 'P-22067', 'Muestras', 'VARIOS', '6X60', 'HABANO', '10.00', NULL, NULL),
(2284, 'P-22078', 'The Edge', 'Toro', '6X52', 'CANDELA', '912.00', NULL, NULL),
(2285, 'P-22080', 'Vintage 1992', 'PETIT CORONA RED.', '4-1/2X44', 'SUMATRA ', '510.00', NULL, NULL),
(2286, 'P-22082', 'Vintage 1992', 'ROBUSTO RED.', '5X50', 'SUMATRA ', '3.00', NULL, NULL),
(2287, 'P-22083', 'Vintage 1992', 'Toro Red.', '6-1/2X52', 'SUMATRA ', '66.00', NULL, NULL),
(2288, 'P-22089', 'Vintage 1990', 'BELICOSO RED.', '4-1/2X54', 'MADURO', '760.00', NULL, NULL),
(2289, 'P-22097', 'Gold By RP', 'TORO', '6X52', 'CONNECTICUT', '750.00', NULL, NULL),
(2290, 'P-22107', 'Vintage 1990', 'ROBUSTO RED.', '5X50', 'MADURO', '525.00', NULL, NULL),
(2291, 'P-22108', 'Vintage 1992', 'BELICOSO RED.', '4-1/2X54', 'SUMATRA ', '315.00', NULL, NULL),
(2292, 'P-22138', 'Vintage 1990', 'CORONA RED.', '5-1/2X44', 'MADURO', '340.00', NULL, NULL),
(2293, 'P-22139', 'Vintage 1990', 'Perfecto', '4-1/2X46X49', 'MADURO', '229.00', NULL, NULL),
(2294, 'P-22157', 'El Conejito', 'Robusto', '5-1/2X50', 'SUMATRA ', '1000.00', NULL, NULL),
(2295, 'P-22158', 'Vintage 1992', 'Perfecto', '4-1/2X46X49', 'SUMATRA ', '40.00', NULL, NULL),
(2296, 'P-22167', 'Junior Vintage 2003', 'Vintage 2003', '4X38', 'CAMEROON ', '6746.00', NULL, NULL),
(2297, 'P-22168', 'VINTAGE 2003', 'Perfecto', '4-1/2X46X49', 'CAMEROON ', '1925.00', NULL, NULL),
(2298, 'P-22201', 'Vivalo', 'Lancero', '6X44', 'HABANO/COL', '450.00', NULL, NULL),
(2299, 'P-22235', 'Moscato', 'Imperiale', '4-1/4X54', 'CONNECTICUT', '3025.00', NULL, NULL),
(2300, 'P-22247', 'The Edge', 'B52', '4-1/2X60', 'COROJO', '80.00', NULL, NULL),
(2301, 'P-22248', 'The Edge', 'B52', '4-1/2X60', 'MADURO', '6055.00', NULL, NULL),
(2302, 'P-22251', 'The Edge Nicaragua', 'Toro', '6X52', 'HABANO', '103357.00', NULL, NULL),
(2303, 'P-22263', 'The Edge Nicaragua', 'Sixty', '6X60', 'HABANO', '4000.00', NULL, NULL),
(2304, 'P-22271', 'Smoker Friendly', 'Sixty', '6X60', 'CONNECTICUT', '400.00', NULL, NULL),
(2305, 'P-22288', 'The Edge', 'Howitzer', '7X70', 'COROJO', '1384.00', NULL, NULL),
(2306, 'P-22289', 'The Edge', 'Howitzer', '7X70', 'MADURO', '3496.00', NULL, NULL),
(2307, 'P-22300', 'The Edge Nicaragua', 'Torpedo', '6X52', 'HABANO', '15543.00', NULL, NULL),
(2308, 'P-22305', 'Vivalo', 'Robusto Grande', '5-1/2X54', 'HABANO/COL', '20.00', NULL, NULL),
(2309, 'P-22323', 'Vivalo', 'Robusto', '4-7/8X50', 'HABANO/COL', '443.00', NULL, NULL),
(2310, 'P-22325', 'The Edge Nicaragua', 'Robusto', '5-1/2X50', 'HABANO', '5357.00', NULL, NULL),
(2311, 'P-22341', 'Wall Street', 'Toro', '6X52', 'HABANO/CLARO', '850.00', NULL, NULL),
(2312, 'P-22343', 'Wall Street', 'Sixty', '6X60', 'HABANO/CLARO', '22.00', NULL, NULL),
(2313, 'P-22360', 'The Edge Nicaraguan', 'Torpedo', '6X52', 'HABANO', '12.00', NULL, NULL),
(2314, 'P-22361', 'The Edge Nicaraguan', 'Sixty', '6X60', 'HABANO', '12.00', NULL, NULL),
(2315, 'P-22368', 'Edge 10th Anniversary', 'Toro', '6X52', 'DOS CAPAS', '21400.00', NULL, NULL),
(2316, 'P-22370', 'Super Ligero', 'Robusto', '5X50', 'HABANO', '4971.00', NULL, NULL),
(2317, 'P-22371', 'Super Ligero', 'Toro', '6-1/2X52', 'HABANO', '670.00', NULL, NULL),
(2318, 'P-22372', 'Super Ligero', 'Sixty', '6X60', 'HABANO', '150.00', NULL, NULL),
(2319, 'P-22373', 'Super Ligero', 'Lancero Con Rabito', '7-1/2X38', 'HABANO', '2.00', NULL, NULL),
(2320, 'P-22374', 'Decade Cameroon', 'Robusto', '5X50', 'CAMEROON ', '150.00', NULL, NULL),
(2321, 'P-22376', 'Decade Cameroon', 'Torpedo', '6-1/2X52', 'CAMEROON ', '1.00', NULL, NULL),
(2322, 'P-22378', 'Velvet', 'Robusto', '5-1/2X52', 'CONNECTICUT', '44.00', NULL, NULL),
(2323, 'P-22419', 'RP Connecticut Fuma', 'Toro', '6X52', 'CONNECTICUT', '2768.00', NULL, NULL),
(2324, 'P-22425', 'The Edge Fuma', 'Toro', '6X52', 'COROJO', '21825.00', NULL, NULL),
(2325, 'P-22426', 'The Edge Fuma', 'Toro', '6X52', 'MADURO', '4925.00', NULL, NULL),
(2326, 'P-22478', 'Old World Reserve', 'Torpedo', '5X54', 'CONNECTICUT', '79.00', NULL, NULL),
(2327, 'P-22489', 'Kautz', 'Corona', '5-1/2X42', 'COROJO', '24.00', NULL, NULL),
(2328, 'P-22494', 'Zeus by Humidour', 'Robusto', '5X50', 'MADURO', '3.00', NULL, NULL),
(2329, 'P-22496', 'Zeus by Humidour', 'Lancero', '7X38', 'MADURO', '240.00', NULL, NULL),
(2330, 'P-22502', 'Junior Vintage 1990 2da', 'Junior Vintage 1990', '4X38', 'HABANO/COL', '5435.00', NULL, NULL),
(2331, 'P-22503', 'Junior Vintage 1999 2da', 'Junior Vintage 1999', '4X38', 'CONNECTICUT', '35763.00', NULL, NULL),
(2332, 'P-22510', 'Junior Sungrown 2da', 'Sungrown', '4X38', 'HABANO/COL', '6475.00', NULL, NULL),
(2333, 'P-22514', 'Sungrown', 'Lancero Pigtail', '7-1/2X38', 'MADURO', '6360.00', NULL, NULL),
(2334, 'P-22516', '20th Anniversary', 'Lancero Red. Rabito', '7-1/2X38', 'HABANO', '25.00', NULL, NULL),
(2335, 'P-22517', '20th Anniversary', 'Rockchilde Press', '4-1/2X50', 'HABANO', '245.00', NULL, NULL),
(2336, 'P-22518', '20th Anniversary', 'Toro Press', '6X52', 'HABANO', '704.00', NULL, NULL),
(2337, 'P-22536', '20th Anniversary', 'Robusto Grande Press', '5X54', 'HABANO', '20.00', NULL, NULL),
(2338, 'P-22537', 'Wall Street', 'Corona', '5-1/2X44', 'HABANO/CLARO', '449.00', NULL, NULL),
(2339, 'P-22538', 'The Edge Fuma', 'Toro', '6X52', 'HABANO', '26800.00', NULL, NULL),
(2340, 'P-22570', 'Pablo Martin', 'Gordo', '6X60', 'CAMEROON ', '3.00', NULL, NULL),
(2341, 'P-22582', 'Ramon Zapata', 'Short Robusto', '4-1/4X52', 'CONNECTICUT', '177.00', NULL, NULL),
(2342, 'P-22585', 'Ramon Zapata', 'Corona Grande', '6X44', 'CONNECTICUT', '65.00', NULL, NULL),
(2343, 'P-22592', 'Connecticut Rocky Patel', 'Super Toro', '6X60', 'CONNECTICUT', '38.00', NULL, NULL),
(2344, 'P-22593', '20th Anniversary', 'Robusto Press', '5X50', 'HABANO', '819.00', NULL, NULL),
(2345, 'P-22595', 'The Edge Nicaragua', 'Short Robusto', '4-1/2X54', 'HABANO', '4.00', NULL, NULL),
(2346, 'P-22610', 'Vintage 1992 Fuma', 'Robusto', '5X50', 'SUMATRA ', '8000.00', NULL, NULL),
(2347, 'P-22611', 'Vintage 2003 Fuma', 'Robusto', '5X50', 'CAMEROON ', '1000.00', NULL, NULL),
(2348, 'P-22612', 'Vintage 2003 Fuma', 'Toro', '6X52', 'CAMEROON ', '6075.00', NULL, NULL),
(2349, 'P-22613', 'RP Factory Over- Runs-E (edge)', 'Torpedo', '6X52', 'MADURO', '2400.00', NULL, NULL),
(2350, 'P-22615', 'Renaissance', 'Robusto', '5X50', 'CONNECTICUT', '50.00', NULL, NULL),
(2351, 'P-22617', 'Renaissance', 'Toro', '6-1/4X52', 'CONNECTICUT', '10.00', NULL, NULL),
(2352, 'P-22620', 'Edge 10th Anniversary', 'Sixty', '6X60', 'DOS CAPAS', '20.00', NULL, NULL),
(2353, 'P-22621', 'The Edge Connecticut', 'Howitzer', '7X70', 'CONNECTICUT', '817.00', NULL, NULL),
(2354, 'P-22634', 'RP Black Label', 'Torpedo', '6X52', 'MADURO', '480.00', NULL, NULL),
(2355, 'P-22640', 'La Sirena', 'Robusto', '5-1/2X50', 'CONNECTICUT', '200.00', NULL, NULL),
(2356, 'P-22641', 'La Sirena', 'Toro', '6X52', 'CONNECTICUT', '200.00', NULL, NULL),
(2357, 'P-22642', 'La Sirena', 'Sixty', '6X60', 'CONNECTICUT', '200.00', NULL, NULL),
(2358, 'P-22646', 'RP Factory Over- Runs-S (Sungrown)', 'Toro', '6-1/2X52', 'SUMATRA ', '750.00', NULL, NULL),
(2359, 'P-22648', 'RP Factory Over- Runs-S (Sungrown)', 'Sixty Con Moño', '6X60', 'SUMATRA ', '1340.00', NULL, NULL),
(2360, 'P-22663', 'Reposado', 'Torpedo', '6X52', 'CONNECTICUT', '338.00', NULL, NULL),
(2361, 'P-22665', 'RP Travel Set', 'Short Robusto', '4X54', 'HABANO', '468.00', NULL, NULL),
(2362, 'P-22669', 'Vintage 1990 Fuma', 'Robusto', '5X50', 'MADURO', '16575.00', NULL, NULL),
(2363, 'P-22671', 'Vintage 1999 Fuma', 'Robusto', '5X50', 'CONNECTICUT', '25.00', NULL, NULL),
(2364, 'P-22672', 'Vintage 1999 Fuma', 'Toro', '6X52', 'CONNECTICUT', '4435.00', NULL, NULL),
(2365, 'P-22675', 'Dark Dominion', 'Sixty Con Moño', '6X60', 'MADURO', '3.00', NULL, NULL),
(2366, 'P-22684', 'RP Royale Clone', 'Toro', '6-1/2X54', 'SUMATRA OSCURO', '4475.00', NULL, NULL),
(2367, 'P-22685', 'RP Royale Clone', 'Robusto', '5X52', 'SUMATRA OSCURO', '50.00', NULL, NULL),
(2368, 'P-22687', 'Moscato', 'Fortissimo Con Moño', '6-3/4X50', 'MADURO', '15.00', NULL, NULL),
(2369, 'P-22696', 'RP Strada', 'Toro', '6X50', 'HABANO', '100.00', NULL, NULL),
(2370, 'P-22730', 'Crio-ojo By RP', 'Toro', '6-1/2X50', 'HABANO', '25.00', NULL, NULL),
(2371, 'P-22732', 'RP Broadleaf', 'Robusto', '5-1/2X50', 'HABANO/OSCURO', '675.00', NULL, NULL),
(2372, 'P-22741', 'Classic', 'Warrior', '6X42', 'COROJO', '5.00', NULL, NULL),
(2373, 'P-22744', 'Four Kicks', 'Corona Gorda', '5-5/8X46', 'MADURO', '50.00', NULL, NULL),
(2374, 'P-22781', 'The Edge', 'Robusto', '5-1/2X50', 'SUMATRA ', '3422.00', NULL, NULL),
(2375, 'P-22796', 'RP Freedom ', 'Robusto', '5-1/2X50', 'CONNECTICUT', '4025.00', NULL, NULL),
(2376, 'P-22797', 'RP Freedom ', 'Toro', '6X52', 'CONNECTICUT', '1400.00', NULL, NULL),
(2377, 'P-22816', 'J.D. Howard', 'HR56', '6-1/2X46', 'MADURO', '42.00', NULL, NULL),
(2378, 'P-22817', 'Jericho Hill', '44S Press', '4-1/2X44', 'MADURO', '3.00', NULL, NULL),
(2379, 'P-22818', 'Jericho Hill', 'Jack Brown', '6X60', 'MADURO', '3.00', NULL, NULL),
(2380, 'P-22821', 'Jericho Hill', 'Willy Lee  Press', '6-1/2X52', 'MADURO', '3.00', NULL, NULL),
(2381, 'P-22831', 'La Palina Blue Label', 'Robusto', '5-1/2X50', 'HABANO', '11663.00', NULL, NULL),
(2382, 'P-22832', 'La Palina Blue Label', 'Toro', '6-1/2X52', 'HABANO', '2884.00', NULL, NULL),
(2383, 'P-22838', 'La Palina KB Series', 'KB1', '4X40', 'MADURO', '200.00', NULL, NULL),
(2384, 'P-22841', 'La Palina KB Series', 'KB4', '6X50', 'MADURO', '3.00', NULL, NULL),
(2385, 'P-22861', 'La Palina LP Line 9', 'Toro', '6-1/2X54', 'CAMEROON ', '1.00', NULL, NULL),
(2386, 'P-22866', 'La Palina Purple Label', 'Toro', '6-1/2X52', 'SUMATRA ', '61.00', NULL, NULL),
(2387, 'P-22868', 'La Palina Red Label', 'Gordo', '6X60', 'SUMATRA ', '1240.00', NULL, NULL),
(2388, 'P-22870', 'La Palina Red Label', 'Robusto', '5-1/2X50', 'SUMATRA ', '16365.00', NULL, NULL),
(2389, 'P-22875', 'La Palina White Label', 'Torpedo', '6-1/2X52X36 PIRAMIDE', 'CONNECTICUT', '51.00', NULL, NULL),
(2390, 'P-22876', 'Las Calaveras 2014', 'LC550 Press', '5X50', 'SUMATRA ', '3.00', NULL, NULL),
(2391, 'P-22877', 'Las Calaveras 2014', 'LC552 Press', '6X52', 'SUMATRA ', '3.00', NULL, NULL),
(2392, 'P-22878', 'Las Calaveras 2014', 'LC660', '6X60', 'SUMATRA ', '3.00', NULL, NULL),
(2393, 'P-22895', 'Yellow Rose', 'Belicoso', '5X54', 'MADURO', '16.00', NULL, NULL),
(2394, 'P-22905', 'Maranello Collezionoe Berlinetta', 'Lonsdale', '6X44', 'CAMEROON ', '196.00', NULL, NULL),
(2395, 'P-22932', 'Olde World Reserve Fuma Corojo', 'Toro', '6X52', 'COROJO', '2895.00', NULL, NULL),
(2396, 'P-22944', 'Le Careme', 'Belicoso', '5-1/2X52', 'MADURO', '3.00', NULL, NULL),
(2397, 'P-22945', 'Le Careme', 'Cosacos', '4-1/2X44', 'MADURO', '3.00', NULL, NULL),
(2398, 'P-22991', 'Extreme', 'Robusto', '5-1/2X50', 'SUMATRA ', '1700.00', NULL, NULL),
(2399, 'P-23003', 'RP Legacy', 'Torpedo', '5-1/2X52', 'MADURO', '22.00', NULL, NULL),
(2400, 'P-23005', 'RP OSG', 'Toro', '6-1/2X52', 'SUMATRA ', '6.00', NULL, NULL),
(2401, 'P-23023', 'Sungrown FUMA', 'Robusto', '5X50', 'MADURO', '10850.00', NULL, NULL),
(2402, 'P-23024', 'Sungrown FUMA', 'Toro', '6X52', 'MADURO', '8650.00', NULL, NULL),
(2403, 'P-23025', 'Tennessee Waltz', 'Petite Corona', '4-1/2X44', 'MADURO', '16.00', NULL, NULL),
(2404, 'P-23037', 'Yellow Rose', 'Robusto Press', '5-1/2X54', 'MADURO', '15.00', NULL, NULL),
(2405, 'P-23038', 'Yellow Rose', 'Toro Press', '6-1/2X52', 'MADURO', '15.00', NULL, NULL),
(2406, 'P-23040', 'Luminosa', 'Robusto', '5X50', 'CONNECTICUT', '15.00', NULL, NULL),
(2407, 'P-23044', 'Luminosa', 'Gordo', '6X60', 'CONNECTICUT', '14.00', NULL, NULL),
(2408, 'P-23049', 'La Palina Bronze Label', 'Gordo', '6X60', 'HABANO', '35.00', NULL, NULL),
(2409, 'P-23066', 'La Palina Bronze Label', 'Robusto', '5-1/2X50', 'HABANO', '22415.00', NULL, NULL),
(2410, 'P-23072', 'RP Freedom ', 'Robusto', '5-1/2X50', 'SUMATRA ', '6825.00', NULL, NULL),
(2411, 'P-23175', 'Formula', 'Toro', '6-1/2X52', 'COROJO', '13.00', NULL, NULL),
(2412, 'P-23176', 'Formula', 'Torpedo', '6X52', 'COROJO', '419.00', NULL, NULL),
(2413, 'P-23187', 'RP Strada', 'Churchill', '7X48', 'HABANO', '1423.00', NULL, NULL),
(2414, 'P-23191', 'RP Broadleaf', 'Toro', '6X52', 'HABANO/OSCURO', '2500.00', NULL, NULL),
(2415, 'P-23192', '20th Anniversary', 'Rockchilde Press', '4-1/2X50', 'SUMATRA OSCURO', '229.00', NULL, NULL),
(2416, 'P-23193', '20th Anniversary', 'Toro Press', '6X52', 'SUMATRA OSCURO', '15.00', NULL, NULL),
(2417, 'P-23215', 'La Palina Bronze Label', 'Toro', '6-1/2X52', 'HABANO', '830.00', NULL, NULL),
(2418, 'P-23216', 'Edge 10th Anniversary', 'Robusto', '5-1/2X50', 'DOS CAPAS', '10.00', NULL, NULL),
(2419, 'P-23217', 'Cuban Blend Fuma', 'Toro', '6X52', 'COROJO', '9243.00', NULL, NULL),
(2420, 'P-23218', 'Cuban Blend Fuma', 'Toro', '6X52', 'MADURO', '4556.00', NULL, NULL),
(2421, 'P-23219', 'Rosado Fuma', 'Toro', '6X52', 'SUMATRA ', '22953.00', NULL, NULL),
(2422, 'P-23224', 'Sungrown FUMA', 'Toro', '6X52', 'SUMATRA ', '11303.00', NULL, NULL),
(2423, 'P-23228', 'The Edge Fuma', 'Toro', '6X52', 'SUMATRA ', '2975.00', NULL, NULL),
(2424, 'P-23229', 'The Edge Fuma', 'Toro', '6X52', 'CONNECTICUT', '3000.00', NULL, NULL),
(2425, 'P-23232', 'The Edge Seleccion', '652 (Toro)', '6X52', 'COROJO', '11400.00', NULL, NULL),
(2426, 'P-23233', 'The Edge Seleccion', '652 (Toro)', '6X52', 'MADURO', '2000.00', NULL, NULL),
(2427, 'P-23235', 'The Edge Seleccion', 'Pyramid', '6X52', 'HABANO', '2000.00', NULL, NULL),
(2428, 'P-23241', 'La Palina LP Line 2', 'Robusto', '5X52', 'MADURO', '492.00', NULL, NULL),
(2429, 'P-23246', 'Vintage 1999 Clones', 'Toro', '6-1/2X52', 'CONNECTICUT', '4000.00', NULL, NULL),
(2430, 'P-23249', 'La Palina Black Label', 'Robusto', '5-1/2X50', 'MADURO', '361.00', NULL, NULL),
(2431, 'P-23250', 'La Palina Black Label', 'Toro', '6X50', 'MADURO', '19.00', NULL, NULL),
(2432, 'P-23254', 'Shockoe Valley', 'Corona', '4-1/2X44', 'MADURO', '800.00', NULL, NULL),
(2433, 'P-23255', 'Renaissance', 'Toro', '6-1/4X52', 'MADURO', '273.00', NULL, NULL),
(2434, 'P-23260', 'Renaissance', 'Corona', '5-1/2X44', 'MADURO', '5.00', NULL, NULL),
(2435, 'P-23263', 'La Palina Anniversary', 'Toro Semi Press', '6-1/2X52', 'MADURO', '35.00', NULL, NULL),
(2436, 'P-23264', 'La Palina Anniversary', 'Gordo', '6X60', 'MADURO', '214.00', NULL, NULL),
(2437, 'P-23266', 'Soto Cano', 'Toro', '6X52', 'CONNECTICUT', '323.00', NULL, NULL),
(2438, 'P-23274', 'Flint Hills', 'Gordo', '6X60', 'CONNECTICUT', '400.00', NULL, NULL),
(2439, 'P-23275', 'Flint Hills', 'Double Corona', '7-1/2X52', 'CONNECTICUT', '750.00', NULL, NULL),
(2440, 'P-23277', 'Reposado', 'Churchill', '7X50', 'PENSILVANIA MAD', '156.00', NULL, NULL),
(2441, 'P-23364', 'Edge Clone', 'Toro', '6X52', 'CONNECTICUT', '400.00', NULL, NULL),
(2442, 'P-23365', 'Edge Clone', 'Toro', '6X52', 'CANDELA', '2000.00', NULL, NULL),
(2443, 'P-23375', '15th Anniversary Fuma', 'Robusto', '5X50', 'HABANO', '257.00', NULL, NULL),
(2444, 'P-23376', 'Grand Reserve Red Label', 'Toro', '6X52', 'HABANO', '14478.00', NULL, NULL),
(2445, 'P-23377', 'Grand Reserve Red Label', 'Robusto', '5-1/2X50', 'HABANO', '315.00', NULL, NULL),
(2446, 'P-23388', 'Edge Square', 'Torpedo Press', '5X54', 'MADURO', '20.00', NULL, NULL),
(2447, 'P-23392', '20th Anniversary Fuma', 'Robusto', '5X50', 'MADURO', '8811.00', NULL, NULL),
(2448, 'P-23393', '20th Anniversary Fuma', 'Toro', '6X52', 'MADURO', '35900.00', NULL, NULL),
(2449, 'P-23394', '20th Anniversary Fuma', 'Robusto', '5X50', 'HABANO', '268.00', NULL, NULL),
(2450, 'P-23395', '20th Anniversary Fuma', 'Toro', '6X52', 'HABANO', '15600.00', NULL, NULL),
(2451, 'P-23396', 'RP Freedom ', 'Toro', '6X52', 'SUMATRA ', '8500.00', NULL, NULL),
(2452, 'P-23397', 'RP Freedom ', 'Sixty', '6X60', 'SUMATRA ', '10150.00', NULL, NULL),
(2453, 'P-23398', 'RP Ultimate', 'Churchill', '7X48', 'CONNECTICUT', '20.00', NULL, NULL),
(2454, 'P-23400', 'RP Ultimate', 'Super Toro', '6X60', 'CONNECTICUT', '5.00', NULL, NULL),
(2455, 'P-23401', 'RP Ultimate', 'Toro', '6X52', 'CONNECTICUT', '68.00', NULL, NULL),
(2456, 'P-23402', 'ITC Emerald', 'Toro', '6X52', 'CANDELA', '1225.00', NULL, NULL),
(2457, 'P-23406', 'RP Ultimate', 'Toro', '6X52', 'HABANO', '20.00', NULL, NULL),
(2458, 'P-23412', 'Old World Reserve (Edge)', 'Toro Press', '6-1/2X52', 'COROJO', '737.00', NULL, NULL),
(2459, 'P-23415', 'The Edge Seleccion', 'Toro (652)', '6X52', 'SUMATRA ', '118.00', NULL, NULL),
(2460, 'P-23417', 'La Sirena', 'Double Corona', '7-1/2X52', 'CONNECTICUT', '75.00', NULL, NULL),
(2461, 'P-23423', 'La Palina Bronze Label', 'Short Robusto', '4X54', 'HABANO', '1975.00', NULL, NULL),
(2462, 'P-23430', 'RP Imperial', 'Torpedo', '6-1/2X52', 'HABANO', '2605.00', NULL, NULL),
(2463, 'P-23432', 'Grand Reserve Red Label', 'Sixty', '6X60', 'HABANO', '13279.00', NULL, NULL),
(2464, 'P-23433', 'Oretoberfest', 'Toro', '6X52', 'HABANO', '500.00', NULL, NULL),
(2465, 'P-23559', 'Smoker Friendly', 'Robusto', '5-1/2X50', 'CONNECTICUT', '500.00', NULL, NULL),
(2466, 'P-23560', 'Smoker Friendly', 'Robusto', '5-1/2X50', 'COROJO', '500.00', NULL, NULL),
(2467, 'P-23561', 'Smoker Friendly', 'Robusto', '5-1/2X50', 'MADURO', '475.00', NULL, NULL),
(2468, 'P-23565', 'El Hefe Fuma', 'Churchill', '7X48', 'MADURO', '3249.00', NULL, NULL),
(2469, 'P-23566', 'Vintage 2006 Fuma', 'Robusto', '5X50', 'HABANO/OSCURO', '711.00', NULL, NULL),
(2470, 'P-23567', 'Vintage 2006 Fuma', 'Toro', '6X52', 'HABANO/OSCURO', '5300.00', NULL, NULL),
(2471, 'P-23568', 'Waller´s Premiun Club', 'Robusto', '5-1/2X50', 'CONNECTICUT', '57.00', NULL, NULL),
(2472, 'P-23583', 'La Palina Regal Reserve', 'Toro', '6X52', 'HABANO', '10.00', NULL, NULL),
(2473, 'P-23589', 'La Palina Blue Label', 'Gordo', '6X60', 'HABANO', '4940.00', NULL, NULL),
(2474, 'P-23595', 'Muestras', NULL, '4X54', 'HABANO', '10.00', NULL, NULL),
(2475, 'P-23609', 'Oreasis', 'Gordo', '6X60', 'SUMATRA ', '100.00', NULL, NULL),
(2476, 'P-23621', 'RP Legacy', 'Churchill Shaggy', '7X48', 'COROJO', '11173.00', NULL, NULL),
(2477, 'P-23622', 'RP Legacy', 'Corona', '6X44', 'COROJO', '16045.00', NULL, NULL),
(2478, 'P-23623', 'RP Legacy', 'Robusto', '5-1/2X50', 'COROJO', '275.00', NULL, NULL),
(2479, 'P-23624', 'RP Legacy', 'Toro', '6-1/2X52', 'COROJO', '442.00', NULL, NULL),
(2480, 'P-23625', 'RP Legacy', 'Sixty', '6X60', 'COROJO', '22826.00', NULL, NULL),
(2481, 'P-23626', 'RP LB1', 'Corona', '6X44', 'HABANO/COLORADO', '156.00', NULL, NULL),
(2482, 'P-23627', 'RP LB1', 'Robusto', '5-1/2X50', 'HABANO/COLORADO', '1.00', NULL, NULL),
(2483, 'P-23628', 'RP LB1', 'Toro', '6-1/2X52', 'HABANO/COLORADO', '1329.00', NULL, NULL),
(2484, 'P-23629', 'RP LB1', 'Sixty', '6X60', 'HABANO/COLORADO', '5.00', NULL, NULL),
(2485, 'P-23682', 'Oretoberfest', 'Gordo', '6X60', 'HABANO', '50.00', NULL, NULL),
(2486, 'P-23692', 'Number 6', 'Robusto', '5-1/2X50', 'COROJO', '12046.00', NULL, NULL),
(2487, 'P-23693', 'Number 6', 'Sixty', '6X60', 'COROJO', '6425.00', NULL, NULL),
(2488, 'P-23694', 'Number 6', 'Toro', '6-1/2X52', 'COROJO', '12834.00', NULL, NULL),
(2489, 'P-23699', 'The Pharaoh (TOH-60-14)', 'Robusto', '5X50', 'SUMATRA ', '300.00', NULL, NULL),
(2490, 'P-23704', 'Muestras', 'Lancero', '7-1/2X38', 'SUMATRA ', '41.00', NULL, NULL),
(2491, 'P-23705', 'Muestras', 'Lancero', '7-1/2X38', 'MADURO', '40.00', NULL, NULL),
(2492, 'P-23706', 'Fox Fuma', 'Robusto', '5X50', 'COROJO', '2000.00', NULL, NULL),
(2493, 'P-23707', 'Fox Fuma', 'Toro', '6X52', 'COROJO', '1884.00', NULL, NULL),
(2494, 'P-23708', 'Fox Fuma', 'Robusto', '5X50', 'MADURO', '6000.00', NULL, NULL),
(2495, 'P-23709', 'Fox Fuma', 'Toro', '6X52', 'MADURO', '2417.00', NULL, NULL),
(2496, 'P-23710', 'Fox Connecticut', 'Robusto', '5X50', 'CONNECTICUT', '20.00', NULL, NULL),
(2497, 'P-23713', 'Fox Fuma', 'Robusto', '5X50', 'CONNECTICUT', '2506.00', NULL, NULL),
(2498, 'P-23714', 'Fox Fuma', 'Toro', '6X52', 'CONNECTICUT', '1813.00', NULL, NULL),
(2499, 'P-23715', 'Fox Fuma', 'Robusto', '5X50', 'HABANO', '1885.00', NULL, NULL),
(2500, 'P-23716', 'Fox Fuma', 'Toro', '6X52', 'HABANO', '1538.00', NULL, NULL),
(2501, 'P-23727', 'RP SunMart (TOH-60-14)', 'Robusto', '5X50', 'SUMATRA ', '9150.00', NULL, NULL),
(2502, 'P-23728', 'RP SunMart (TOH-60-14)', 'Churchill', '7X48', 'SUMATRA ', '7100.00', NULL, NULL),
(2503, 'P-23729', 'RP SunMart (TOH-60-14)', 'Torpedo', '6X52', 'SUMATRA ', '7000.00', NULL, NULL),
(2504, 'P-23730', 'RP SunMart (TOH-60-14)', 'Grande', '6X60', 'SUMATRA ', '9100.00', NULL, NULL),
(2505, 'P-23732', 'The Collection Fuma', 'Grande', '6X60', 'COROJO', '1000.00', NULL, NULL),
(2506, 'P-23734', 'The Collection Fuma', 'Grande', '6X60', 'CONNECTICUT', '1400.00', NULL, NULL),
(2507, 'P-23736', 'The Collection Fuma', 'Grande', '6X60', 'MADURO', '1000.00', NULL, NULL),
(2508, 'P-23743', 'CGAL-IV', 'Robusto', '5X50', 'HABANO', '400.00', NULL, NULL),
(2509, 'P-23744', 'CGAL-IV', 'Toro', '6-1/2X50', 'HABANO', '400.00', NULL, NULL),
(2510, 'P-23759', 'RP Freedom ', 'Sixty', '6X60', 'CONNECTICUT', '11975.00', NULL, NULL),
(2511, 'P-23763', 'La Palina Silver Label', 'Robusto', '5-1/2X50', 'HABANO', '775.00', NULL, NULL),
(2512, 'P-23764', 'La Palina Silver Label', 'Gordo', '6X60', 'HABANO', '1215.00', NULL, NULL),
(2513, 'P-23767', 'RP SunMart (TOH-60-14)', 'Robusto', '5X50', 'CONNECTICUT', '5650.00', NULL, NULL),
(2514, 'P-23768', 'RP SunMart (TOH-60-14)', 'Churchill', '7X48', 'CONNECTICUT', '3075.00', NULL, NULL),
(2515, 'P-23769', 'RP SunMart (TOH-60-14)', 'Torpedo', '6X52', 'CONNECTICUT', '4500.00', NULL, NULL),
(2516, 'P-23770', 'RP SunMart (TOH-60-14)', 'Grande', '6X60', 'CONNECTICUT', '3000.00', NULL, NULL),
(2517, 'P-23771', 'RP SunMart (TOH-60-14)', 'Robusto', '5X50', 'HABANO', '3475.00', NULL, NULL),
(2518, 'P-23772', 'RP SunMart (TOH-60-14)', 'Churchill', '7X48', 'HABANO', '6500.00', NULL, NULL),
(2519, 'P-23773', 'RP SunMart (TOH-60-14)', 'Torpedo', '6X52', 'HABANO', '3000.00', NULL, NULL),
(2520, 'P-23774', 'RP SunMart (TOH-60-14)', 'Grande', '6X60', 'HABANO', '4025.00', NULL, NULL),
(2521, 'P-23813', 'Renegade Connecticut', 'Robusto', '5-1/2X50', 'CONNECTICUT', '500.00', NULL, NULL),
(2522, 'P-23814', 'Renegade Connecticut', 'Toro', '6-1/2X52', 'CONNECTICUT', '500.00', NULL, NULL),
(2523, 'P-23815', 'Renegade Connecticut', 'Churchill', '7X48', 'CONNECTICUT', '500.00', NULL, NULL),
(2524, 'P-23816', 'Renegade Connecticut', 'Gordo', '6X60', 'CONNECTICUT', '500.00', NULL, NULL),
(2525, 'P-23817', 'Muestras', 'Corona', '3-1/2X44', 'MADURO', '10.00', NULL, NULL),
(2526, 'P-23818', 'Muestras', 'Corona', '3-1/2X44', 'CONNECTICUT', '10.00', NULL, NULL),
(2527, 'P-23819', 'Dober´s Society', 'Robusto Cidbones', '5-1/2X50', 'COROJO', '2000.00', NULL, NULL),
(2528, 'P-23820', 'Dober´s Society', 'Toro Jawbones', '6X52', 'COROJO', '2000.00', NULL, NULL),
(2529, 'P-23821', 'Kautz', 'Short Robusto', '4X54', 'COROJO', '800.00', NULL, NULL),
(2530, 'P-23823', 'The Edge', 'Toro', '6X50', 'COROJO', '42200.00', NULL, NULL),
(2531, 'P-23824', 'The Edge', 'Toro', '6X50', 'MADURO', '35850.00', NULL, NULL),
(2532, 'P-23825', 'Number 6', 'Toro', '6X50', 'COROJO', '15000.00', NULL, NULL),
(2533, 'P-23826', 'The Edge Connecticut', 'Toro', '6X50', 'CONNECTICUT', '50075.00', NULL, NULL),
(2534, 'p-23830', 'La Palina Bronze Label', 'Lancero Rabito', '7-1/2X38', 'HABANO', '425.00', NULL, NULL),
(2535, 'P-23830', 'La Palina Bronze Label', 'Lancero Rabito', '7-1/2X38', 'HABANO', '4400.00', NULL, NULL),
(2536, 'P-23832', 'The Edge Connecticut', 'Grand Robusto', '5-1/2X54', 'CONNECTICUT', '4875.00', NULL, NULL),
(2537, 'P-23836', 'RP Freedom ', 'Robusto', '5-1/2X50', 'MADURO', '25.00', NULL, NULL),
(2538, 'Total General', NULL, NULL, NULL, NULL, '1750458.00', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_productos_terminados`
--

DROP TABLE IF EXISTS `inventario_productos_terminados`;
CREATE TABLE IF NOT EXISTS `inventario_productos_terminados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orden_pedido` varchar(50) DEFAULT NULL,
  `orden_sistema` varchar(50) DEFAULT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `Alias_vitola` varchar(50) DEFAULT NULL,
  `Vitola` varchar(50) DEFAULT NULL,
  `Nombre_capa` varchar(50) DEFAULT NULL,
  `Existencia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=362 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `inventario_productos_terminados`
--

INSERT INTO `inventario_productos_terminados` (`id`, `orden_pedido`, `orden_sistema`, `Marca`, `Alias_vitola`, `Vitola`, `Nombre_capa`, `Existencia`) VALUES
(326, 'undefined', 'undefined', '52', '13', '12', '3', '0'),
(327, NULL, NULL, '51', '2', '4', '5', '450'),
(328, NULL, NULL, '51', '2', '4', '2', '450'),
(329, 'HON-3138', '3197', '51', '2', '4', '3', '450'),
(330, NULL, NULL, '61', '2', '4', '1', '450'),
(331, NULL, NULL, '61', '2', '4', '1', '2000'),
(332, NULL, NULL, '51', '2', '4', '5', '6420'),
(333, NULL, NULL, '51', '2', '4', '2', '6420'),
(334, NULL, NULL, '51', '2', '4', '3', '6420'),
(335, NULL, NULL, '51', '14', '4', '3', '800'),
(336, NULL, NULL, '67', '40', '9', '3', '12600'),
(337, NULL, NULL, '61', '2', '4', '1', '19220'),
(338, NULL, NULL, '61', '14', '4', '1', '800'),
(339, NULL, NULL, '105', '11', '9', '1', '560'),
(340, NULL, NULL, '74', '3', '3', '5', '2400'),
(341, NULL, NULL, '40', '1', '2', '5', '400'),
(342, NULL, NULL, '51', '2', '4', '5', '4860'),
(343, NULL, NULL, '51', '2', '4', '2', '4860'),
(344, NULL, NULL, '51', '14', '4', '5', '3200'),
(345, NULL, NULL, '51', '2', '4', '3', '4860'),
(346, NULL, NULL, '90', '21', '3', '3', '2400'),
(347, NULL, NULL, '90', '3', '3', '3', '10640'),
(348, NULL, NULL, '61', '2', '4', '1', '4860'),
(349, NULL, NULL, '105', '11', '9', '1', '2400'),
(350, NULL, NULL, '99', '14', '4', '6', '1000'),
(351, NULL, NULL, '51', '2', '4', '5', '29600'),
(352, NULL, NULL, '51', '14', '4', '5', '3200'),
(353, NULL, NULL, '99', '2', '4', '6', '1000'),
(354, NULL, NULL, '99', '11', '9', '6', '2400'),
(355, NULL, NULL, '70', '1', '1', '6', '200'),
(356, NULL, NULL, '72', '11', '9', '6', '6300'),
(357, NULL, NULL, '74', '6', '18', '5', '1250'),
(358, NULL, NULL, '70', '1', '1', '2', '200'),
(359, NULL, NULL, '99', '2', '4', '6', '4000'),
(360, NULL, NULL, '90', '6', '1', '3', '12500'),
(361, NULL, NULL, '52', '13', '12', '3', '75');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item_faltantes`
--

DROP TABLE IF EXISTS `item_faltantes`;
CREATE TABLE IF NOT EXISTS `item_faltantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `detalles` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `item_faltantes`
--

INSERT INTO `item_faltantes` (`id`, `categoria`, `item`, `detalles`) VALUES
(1, 'ROLL NEW', '10206016', 'Bundle of 4 RP/New Global Toro Samper (Band, Cello)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_cajas`
--

DROP TABLE IF EXISTS `lista_cajas`;
CREATE TABLE IF NOT EXISTS `lista_cajas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) DEFAULT NULL,
  `productoServicio` varchar(255) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `tipo_empaque` int(11) DEFAULT NULL,
  `existencia` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1046 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lista_cajas`
--

INSERT INTO `lista_cajas` (`id`, `codigo`, `productoServicio`, `marca`, `tipo_empaque`, `existencia`, `created_at`, `updated_at`) VALUES
(1, 'CM-01296', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 ROBUSTO TUBO 5-1/2X50 MADURO BOX/10', 'Vintage 1990', 4, 181, NULL, NULL),
(2, 'CM-01413', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 ROBUSTO TUBO 6X50 CONERICO BOX/10', 'Vintage 1999', 4, 0, NULL, NULL),
(3, 'CM-01415', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE TORO BOX/50', 'The Edge Connecticut', 21, 0, NULL, NULL),
(4, 'CM-01416', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE TORPEDO BOX/50', 'The Edge Connecticut', 21, -120, NULL, NULL),
(5, 'CM-01417', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE DOBLE CORONA BOX/50', 'The Edge Connecticut', 21, 0, NULL, NULL),
(6, 'CM-01418', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE ROBUSTO BOX/50', 'The Edge Connecticut', 21, -360, NULL, NULL),
(7, 'CM-01419', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE TORO BOX/20', 'The Edge Connecticut', 7, 0, NULL, NULL),
(8, 'CM-01420', 'CAJAS DE MADERA ROCKY PATEL EDGE  TORPEDO CONNECTICUT BOX/20', 'The Edge Connecticut', 7, -60, NULL, NULL),
(9, 'CM-01421', 'CAJAS DE MADERA ROCKY PATEL EDGE ROBUSTO CONNECTICUT BOX/20', 'The Edge Connecticut', 7, -264, NULL, NULL),
(10, 'CM-01422', 'CAJAS DE MADERA ROCKY PATEL EDGE DOBLE CORONA CONNETICUT BOX/20', 'The Edge Connecticut', 7, -8, NULL, NULL),
(11, 'CM-01423', 'CAJAS DE MADERA ROCKY PATEL FIRE ROBUSTO BOX/20', 'Fire', 7, 0, NULL, NULL),
(12, 'CM-01424', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 ROBUSTO TUBO 4-1/2X50 CONERICO BOX/10', 'Vintage 1999', 4, 0, NULL, NULL),
(13, 'CM-01425', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD ROBUSTO MADURO BOX/20', 'Olde World Tobacco', 7, 0, NULL, NULL),
(14, 'CM-01869', 'CAJAS DE MADERA ROCKY PATEL FRED & STEVE  BOX/20', 'Fred & Steve', 7, 0, NULL, NULL),
(15, 'CM-01934', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 CHURCHILL PRESS CAMEROON BOX/20', 'VINTAGE 2003', 7, 0, NULL, NULL),
(16, 'CM-01974', 'CAJAS DE MADERA  ROCKY PATEL PREMIUM BURN BY ROCKY PATEL TORO BOX-20', 'Gold By RP', 7, 0, NULL, NULL),
(17, 'CM-03319', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON BY R.P. LANCERO CAMEROON BOX/20', 'Cameroon By RP', 7, 0, NULL, NULL),
(18, 'CM-03320', 'CAJAS DE MADERA ROCKY PATEL DECADE ROBUSTO RED. SUMATRA BOX/20', 'Decada', 7, 30, NULL, NULL),
(19, 'CM-03321', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 PERFECTO RED. MADURO BOX/20', 'Vintage 1990', 7, 0, NULL, NULL),
(20, 'CM-03322', 'CAJAS DE MADERA ROCKY PATEL SAMPLER ROCK STAR ROBUSTO BOX 5', 'NINGUNA', 6, 0, NULL, NULL),
(21, 'CM-03323', 'CAJAS DE MADERA ROCKY PATEL MONTE TRIPLE LIGERO ROBUSTO BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(22, 'CM-03324', 'CAJAS DE MADERA ROCKY PATEL MONTE TRIPLE LIGERO TORPEDO BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(23, 'CM-03325', 'CAJAS DE MADERA ROCKY PATEL MONTE TRIPLE LIGERO TORO BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(24, 'CM-03326', 'CAJAS DE MADERA ROCKY PATEL MONTE TRIPLE MADURO TORPEDO BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(25, 'CM-03327', 'CAJAS DE MADERA ROCKY PATEL MONTE TRIPLE MADURO ROBUSTO BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(26, 'CM-03328', 'CAJAS DE MADERA ROCKY PATEL MONTE TRIPLE MADURO CHURCHILL BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(27, 'CM-03329', 'CAJAS DE MADERA ROCKY PATEL GRAN VIDA MISSILES PENSILVANIA BOX/20', 'Gran Vida', 7, 0, NULL, NULL),
(28, 'CM-03330', 'CAJAS DE MADERA ROCKY PATEL  MONOCACY TORO PRESS SUMATRA  BOX/20', 'Davidus PL Monocacy', 7, -10, NULL, NULL),
(29, 'CM-03331', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 SIXTY CONNEECTICUT BOX 20', 'Vintage 1999', 7, 214, NULL, NULL),
(30, 'CM-03332', 'CAJAS DE MADERA ROCKY PATEL STRIKE TORO BOX 20', 'Strike', 7, 0, NULL, NULL),
(31, 'CM-03333', 'CAJAS DE MADERA ROCKY PATEL STRIKE TORPEDO BOX 20', 'Strike', 7, 0, NULL, NULL),
(32, 'CM-03334', 'CAJAS DE MADERA ROCKY PATEL STRIKE CHURCHILL BOX 20', 'Strike', 7, 0, NULL, NULL),
(33, 'CM-03335', 'CAJAS DE MADERA ROCKY PATEL SAMPLER LIMITE EDITION LANCERO BOX 10', 'NINGUNA', 4, 0, NULL, NULL),
(34, 'CM-03336', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE TORO PRESS BOX/20', 'Davidus Fredericktown', 7, 0, NULL, NULL),
(35, 'CM-03337', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE ROBUSTO ROUND BOX/20', 'Davidus Fredericktown', 7, 25, NULL, NULL),
(36, 'CM-03338', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE PIRAMIDE BOX/20', 'Davidus Fredericktown', 7, 0, NULL, NULL),
(37, 'CM-03339', 'CAJAS DE MADERA ROCKY PATEL  CUBAN CIGAR FACTORY ROJAS TORO BOX/20', 'Cuban Cigar Factory Cabinet Selection', 7, 0, NULL, NULL),
(38, 'CM-03340', 'CAJAS DE MADERA ROCKY PATEL CCF WHITE LABEL SIXTY BOX/20', 'CCF- White Label', 7, 0, NULL, NULL),
(39, 'CM-03341', 'CAJAS DE MADERA ROCKY PATEL  OCEAN CLUB ROBUSTO PRESS SUMATRA  BOX/20', 'RP Ocean Club', 7, 1, NULL, NULL),
(40, 'CM-03342', 'CAJAS DE MADERA ROCKY PATEL  CAUCUS  SIXTY SUMATRA BOX/20', 'Caucus', 7, 0, NULL, NULL),
(41, 'CM-03343', 'CAJAS DE MADERA ROCKY PATEL  AMERICAN MARKET ROBUSTO CONN BOX/20', 'American Market Selection', 7, 0, NULL, NULL),
(42, 'CM-03344', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORO COR/MAD BOX/10', 'Old World Reserve', 4, 0, NULL, NULL),
(43, 'CM-03345', 'CAJAS DE MADERA ROCKY PATEL 3-13 GRANDE BOX 20', 'Phoenix', 7, 0, NULL, NULL),
(44, 'CM-03346', 'CAJAS DE MADERA ROCKY PATEL 3-13 ROBUSTO BOX 20', 'Phoenix', 7, 0, NULL, NULL),
(45, 'CM-03347', 'CAJAS DE MADERA ROCKY PATEL 3-13 TORPEDO BOX 20', 'Phoenix', 7, 0, NULL, NULL),
(46, 'CM-03500', 'CAJAS DE MADERA ROCKY PATEL  AMERICAN MARKET DOUBLE CORONA CONN BOX/20', 'American Market Selection', 7, 0, NULL, NULL),
(47, 'CM-03501', 'CAJAS DE MADERA ROCKY PATEL  AMERICAN MARKET TORPEDO CONN BOX/20', 'American Market Selection', 7, 0, NULL, NULL),
(48, 'CM-03502', 'CAJAS DE MADERA ROCKY PATEL  AMERICAN MARKET LONSDALES CONN BOX/20', 'American Market Selection', 7, 0, NULL, NULL),
(49, 'CM-03503', 'CAJAS DE MADERA ROCKY PATEL  AMERICAN MARKET SIXTY CONN BOX/20', 'American Market Selection', 7, 27, NULL, NULL),
(50, 'CM-03504', 'CAJAS DE MADERA ROCKY PATEL  AMERICAN MARKET CHURCHILL CONN BOX/20', 'American Market Selection', 7, 0, NULL, NULL),
(51, 'CM-03505', 'CAJAS DE MADERA ROCKY PATEL  AMERICAN MARKET TORO CONN BOX/20', 'American Market Selection', 7, 0, NULL, NULL),
(52, 'CM-03506', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO PRESS BOX/20', 'Davidus Antietam', 7, 10, NULL, NULL),
(53, 'CM-03507', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON BY R.P. BELICOSO CAMEROON BOX/20', 'Cameroon By RP', 7, 1, NULL, NULL),
(54, 'CM-03508', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON BY R.P. TORO CAMEROON BOX/20', 'Cameroon By RP', 7, 0, NULL, NULL),
(55, 'CM-03509', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON BY R.P. CHURCHILL CAMEROON BOX/20', 'Cameroon By RP', 7, 0, NULL, NULL),
(56, 'CM-03510', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON BY R.P. ROBUSTO CAMEROON BOX/20', 'Cameroon By RP', 7, 0, NULL, NULL),
(57, 'CM-03511', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON LEGEND TORO GRANDE MADURO BOX/25', 'Cameroon Legend', 13, 0, NULL, NULL),
(58, 'CM-03512', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON LEGEND ROBUSTO GRANDE NATURAL BOX/25', 'Cameroon Legend', 13, 0, NULL, NULL),
(59, 'CM-03513', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON LEGEND SUPER TORO NATURAL BOX/25', 'Cameroon Legend', 13, 0, NULL, NULL),
(60, 'CM-03514', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON LEGEND TORO GRANDE NATURAL BOX/25', 'Cameroon Legend', 13, 0, NULL, NULL),
(61, 'CM-03515', 'CAJAS DE MADERA ROCKY PATEL  CAUCUS CHURCHILL SUMATRA BOX/20', 'Caucus', 7, 0, NULL, NULL),
(62, 'CM-03516', 'CAJAS DE MADERA ROCKY PATEL  CAUCUS ROBUSTO SUMATRA BOX/20', 'Caucus', 7, 1, NULL, NULL),
(63, 'CM-03517', 'CAJAS DE MADERA ROCKY PATEL  CI LEGENDS ROBUSTO HAB/COL BOX/20  (VIEJAS)', 'CI Legend', NULL, 0, NULL, NULL),
(64, 'CM-03518', 'CAJAS DE MADERA ROCKY PATEL  CLASICO CHIEF COROJO BOX/25', 'Classic', 13, 0, NULL, NULL),
(65, 'CM-03519', 'CAJAS DE MADERA ROCKY PATEL  CLASICO TEEPEE COROJO BOX/25', 'Classic', 13, 0, NULL, NULL),
(66, 'CM-03520', 'CAJAS DE MADERA ROCKY PATEL  CLASICO BOXER COROJO BOX/25', 'Classic', 13, 0, NULL, NULL),
(67, 'CM-03521', 'CAJAS DE MADERA ROCKY PATEL  CLASICO TOMAHAWK COROJO BOX/25', 'Classic', 13, 0, NULL, NULL),
(68, 'CM-03522', 'CAJAS DE MADERA ROCKY PATEL  CLASICO TEEPEE MADURO BOX/25', 'Classic', 13, 0, NULL, NULL),
(69, 'CM-03523', 'CAJAS DE MADERA ROCKY PATEL  CLASICO BOXER MADURO BOX/25', 'Classic', 13, 0, NULL, NULL),
(70, 'CM-03524', 'CAJAS DE MADERA ROCKY PATEL  CLASICO TOMAHAWK MADURO BOX/25', 'Classic', 13, 0, NULL, NULL),
(71, 'CM-03525', 'CAJAS DE MADERA ROCKY PATEL  CUNUCO TORO NATURAL BOX/20', 'Cunuco', 7, 0, NULL, NULL),
(72, 'CM-03526', 'CAJAS DE MADERA ROCKY PATEL  CUNUCO SIXTY NATURAL BOX/20', 'Cunuco', 7, 0, NULL, NULL),
(73, 'CM-03527', 'CAJAS DE MADERA ROCKY PATEL  CUNUCO ROBUSTO NATURAL BOX/20', 'Cunuco', 7, 0, NULL, NULL),
(74, 'CM-03528', 'CAJAS DE MADERA ROCKY PATEL  CUNUCO DOUBLE CORONA NATURAL BOX/20', 'Cunuco', 7, 0, NULL, NULL),
(75, 'CM-03529', 'CAJAS DE MADERA ROCKY PATEL  CUNUCO CORONA NATURAL BOX/20', 'Cunuco', 7, 0, NULL, NULL),
(76, 'CM-03530', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND TORO COROJO BOX/20', 'Cuban Blend', 7, 200, NULL, NULL),
(77, 'CM-03531', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND TORO MADURO BOX/20', 'Cuban Blend', 7, 200, NULL, NULL),
(78, 'CM-03532', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND LONSDALES COROJO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(79, 'CM-03533', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND LONSDALES MADURO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(80, 'CM-03534', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND DOBLE CORONA MADURO BOX/20', 'Cuban Blend', 7, -50, NULL, NULL),
(81, 'CM-03535', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND DOBLE CORONA COROJO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(82, 'CM-03536', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND LANCERO COROJO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(83, 'CM-03537', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND SIXTY COROJO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(84, 'CM-03538', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND SIXTY MADURO BOX/20', 'Cuban Blend', 7, 375, NULL, NULL),
(85, 'CM-03539', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND TORPEDO COROJO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(86, 'CM-03540', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND ROBUSTO MADURO BOX/20', 'Cuban Blend', 7, 2, NULL, NULL),
(87, 'CM-03541', 'CAJAS DE MADERA ROCKY PATEL CCF WHITE LABEL ROBUSTO BOX/20', 'CCF- White Label', 7, 0, NULL, NULL),
(88, 'CM-03542', 'CAJAS DE MADERA ROCKY PATEL CCF WHITE LABEL TORPEDO BOX/20', 'CCF- White Label', 7, 40, NULL, NULL),
(89, 'CM-03543', 'CAJAS DE MADERA ROCKY PATEL  CUBAN CIGAR FACTORY ROJAS ROBUSTO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(90, 'CM-03544', 'CAJAS DE MADERA ROCKY PATEL  CUBAN CIGAR FACTORY ROJAS TORPEDO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(91, 'CM-03545', 'CAJAS DE MADERA ROCKY PATEL DECADE TORPEDO SUMATRA BOX/20', 'Decada', 7, 0, NULL, NULL),
(92, 'CM-03546', 'CAJAS DE MADERA ROCKY PATEL DECADE LONSDALES PRENSADO SUMATRA BOX/20', 'Decada', 7, 0, NULL, NULL),
(93, 'CM-03547', 'CAJAS DE MADERA ROCKY PATEL DECADE LANCERO SUMATRA BOX/26', 'Decada', 52, 0, NULL, NULL),
(94, 'CM-03548', 'CAJAS DE MADERA ROCKY PATEL DECADE RARES SAMPLER SUMATRA BOX/7', 'Decada', 40, 0, NULL, NULL),
(95, 'CM-03549', 'CAJAS DE MADERA ROCKY PATEL DECADE EMPEROR ROUND SUMATRA BOX/20', 'Decada', 7, -40, NULL, NULL),
(96, 'CM-03550', 'CAJAS DE MADERA ROCKY PATEL DECADE DISPLAY SUMATRA BOX/75', 'Decada', 90, 0, NULL, NULL),
(97, 'CM-03551', 'CAJAS DE MADERA ROCKY PATEL DECADE TORO SUMATRA BOX/10', 'Decada', 4, -5696, NULL, NULL),
(98, 'CM-03552', 'CAJAS DE MADERA ROCKY PATEL DECADE FORTY SIX PRES SUMATRA BOX/20', 'Decada', 7, -78, NULL, NULL),
(99, 'CM-03553', 'CAJAS DE MADERA ROCKY PATEL  DECADA LIMITADA TORO PENSILVANIA BOX/20', 'Decada', 7, 0, NULL, NULL),
(100, 'CM-03554', 'CAJAS DE MADERA ROCKY PATEL  DECADA LIMITADA TORPEDO PENSILVANIA BOX/20', 'Decada', 7, 0, NULL, NULL),
(101, 'CM-03555', 'CAJAS DE MADERA ROCKY PATEL  DECADA LIMITADA ROBUSTO PENSILVANIA BOX/20', 'Decada', 7, 0, NULL, NULL),
(102, 'CM-03556', 'CAJAS DE MADERA ROCKY PATEL  DESIENA TORO COROJO BOX/20', 'Desiena 312', 7, 19, NULL, NULL),
(103, 'CM-03557', 'CAJAS DE MADERA ROCKY PATEL  DESIENA ROBUSTO CONERICO BOX/20', 'Desiena 312', 7, 10, NULL, NULL),
(104, 'CM-03558', 'CAJAS DE MADERA ROCKY PATEL  DON CASIANI CORONA BOX/20', 'Don Cassieni PL', 7, 0, NULL, NULL),
(105, 'CM-03559', 'CAJAS DE MADERA ROCKY PATEL  EDGE SHORT MADURO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(106, 'CM-03560', 'CAJAS DE MADERA ROCKY PATEL  EDGE SHORT COROJO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(107, 'CM-03561', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO MADURO BOX/20', 'The Edge', 7, 68, NULL, NULL),
(108, 'CM-03562', 'CAJAS DE MADERA ROCKY PATEL  EDGE LANCERO MADURO BOX/24', 'The Edge', 47, 0, NULL, NULL),
(109, 'CM-03563', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO SUMATRA BOX/100', 'The Edge', 18, -339, NULL, NULL),
(110, 'CM-03564', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO COROJO BOX/10', 'The Edge', 4, 0, NULL, NULL),
(111, 'CM-03565', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO MADURO BOX/10 (Divisor Madera)', 'The Edge', NULL, 0, NULL, NULL),
(112, 'CM-03566', 'CAJAS DE MADERA ROCKY PATEL  EDGE SAMPLER VARIADO BOX/8', 'The Edge', 50, 0, NULL, NULL),
(113, 'CM-03567', 'CAJAS DE MADERA ROCKY PATEL  EDGE GRAN ROBUSTO MADURO BOX/20', 'The Edge', 7, 1000, NULL, NULL),
(114, 'CM-03568', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO SUMATRA BOX/100', 'The Edge', 18, -3, NULL, NULL),
(115, 'CM-03569', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/20', 'The Edge', 7, -209, NULL, NULL),
(116, 'CM-03570', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO MADURO BOX/20', 'The Edge', 7, 105, NULL, NULL),
(117, 'CM-03571', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO MADURO BOX/20 (Malas)', 'The Edge', NULL, 0, NULL, NULL),
(118, 'CM-03572', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/20', 'The Edge', 7, 43, NULL, NULL),
(119, 'CM-03573', 'CAJAS DE MADERA ROCKY PATEL  EDGE MISSILES COROJO BOX/25', 'The Edge', 13, 40, NULL, NULL),
(120, 'CM-03574', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/20', 'The Edge', 7, -81, NULL, NULL),
(121, 'CM-03575', 'CAJAS DE MADERA ROCKY PATEL  EDGE DOBLE CORONA MADURO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(122, 'CM-03576', 'CAJAS DE MADERA ROCKY PATEL  EDGE DOBLE CORONA COROJO BOX/20', 'The Edge', 7, -37, NULL, NULL),
(123, 'CM-03577', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO COROJO BOX/20', 'The Edge', 7, -512, NULL, NULL),
(124, 'CM-03578', 'CAJAS DE MADERA ROCKY PATEL  EDGE BATTALION MADURO BOX/20', 'The Edge', 7, -413, NULL, NULL),
(125, 'CM-03579', 'CAJAS DE MADERA ROCKY PATEL  EDGE SIXTY COROJO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(126, 'CM-03580', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO COROJO BOX/100', 'The Edge', 18, 40, NULL, NULL),
(127, 'CM-03581', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/100', 'The Edge', 18, 326, NULL, NULL),
(128, 'CM-03582', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO MADURO BOX/100', 'The Edge', 18, -571, NULL, NULL),
(129, 'CM-03583', 'CAJAS DE MADERA ROCKY PATEL  EDGE MISSILES MADURO BOX/25', 'The Edge', 13, -74, NULL, NULL),
(130, 'CM-03584', 'CAJAS DE MADERA ROCKY PATEL  EDGE CABINET CHURCHILL MADURO BOX/16', 'The Edge', 26, 60, NULL, NULL),
(131, 'CM-03585', 'CAJAS DE MADERA ROCKY PATEL  EDGE CABINET CHURCHILL COROJO BOX/16', 'The Edge', 26, 40, NULL, NULL),
(132, 'CM-03586', 'CAJAS DE MADERA ROCKY PATEL  EDGE DOBLE CORONA CONNECTICUT BOX/50', 'The Edge Connecticut', 21, 60, NULL, NULL),
(133, 'CM-03587', 'CAJAS DE MADERA ROCKY PATEL  EDGE LITE CORONA CONERICO BOX/50', 'El Diablo', 21, 0, NULL, NULL),
(134, 'CM-03588', 'CAJAS DE MADERA ROCKY PATEL  EDGE  GABINET CHURCHILL CONERICO BOX/16', 'The Edge', 26, 10, NULL, NULL),
(135, 'CM-03589', 'CAJAS DE MADERA ROCKY PATEL  EDGE  CORONA CONERICO BOX/20', 'The Edge', 7, -329, NULL, NULL),
(136, 'CM-03590', 'CAJAS DE MADERA ROCKY PATEL  EDGE LITE SHORT CONERICO BOX/50', 'El Diablo', 21, 10, NULL, NULL),
(137, 'CM-03591', 'CAJAS DE MADERA ROCKY PATEL  EDGE LITE TORPEDO CONERICO BOX/20', 'El Diablo', 7, 0, NULL, NULL),
(138, 'CM-03592', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO CONNECTICUT BOX/50', 'The Edge', 21, 120, NULL, NULL),
(139, 'CM-03593', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO CONNECTICUT BOX/50', 'The Edge', 21, 210, NULL, NULL),
(140, 'CM-03594', 'CAJAS DE MADERA ROCKY PATEL  EDGE LITE ROBUSTO CONERICO BOX/20', 'El Diablo', 7, 0, NULL, NULL),
(141, 'CM-03595', 'CAJAS DE MADERA ROCKY PATEL  EDGE LITE ROBUSTO CONERICO BOX/10', 'El Diablo', 4, 0, NULL, NULL),
(142, 'CM-03596', 'CAJAS DE MADERA ROCKY PATEL  EDGE LITE SIXTY CONERICO BOX/20', 'The Edge Connecticut', 7, -520, NULL, NULL),
(143, 'CM-03597', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO CONNETICUT BOX/20', 'The Edge Connecticut', 7, 275, NULL, NULL),
(144, 'CM-03598', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO CONNECTICUT BOX/50', 'The Edge Connecticut', 21, 51, NULL, NULL),
(145, 'CM-03599', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE TORPEDO COROJO BOX/50', 'Edge Square', 21, 0, NULL, NULL),
(146, 'CM-03600', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE TORO COROJO BOX/50', 'Edge Square', 21, 0, NULL, NULL),
(147, 'CM-03601', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE ROBUSTO COROJO BOX/50', 'Edge Square', 21, 0, NULL, NULL),
(148, 'CM-03602', 'CAJAS DE MADERA ROCKY PATEL  EMILIO SERIES TORO SUMATRA BOX/20', 'Emilio  H Serie', 7, 0, NULL, NULL),
(149, 'CM-03603', 'CAJAS DE MADERA ROCKY PATEL  EMILIO SERIES TORPEDO MADURO BOX/20', 'Emilio  H Serie', 7, 0, NULL, NULL),
(150, 'CM-03604', 'CAJAS DE MADERA ROCKY PATEL  EMILIO SERIES TORO MADURO BOX/20', 'Emilio  H Serie', 7, 0, NULL, NULL),
(151, 'CM-03605', 'CAJAS DE MADERA  ROCKY PATEL  FAMOUS SAMPLER TOBUSTO BOX/20', 'Judges', 7, 0, NULL, NULL),
(152, 'CM-03606', 'CAJAS DE MADERA ROCKY PATEL  FIRE TORO  BOX/20', 'Fire Smoke', 7, 0, NULL, NULL),
(153, 'CM-03607', 'CAJAS DE MADERA ROCKY PATEL  FIRE ROBUSTO  BOX/20', 'Fire Smoke', 7, 0, NULL, NULL),
(154, 'CM-03608', 'CAJAS DE MADERA ROCKY PATEL  FIRE DOBLE CORONA  BOX/20', 'Fire Smoke', 7, 0, NULL, NULL),
(155, 'CM-03609', 'CAJAS DE MADERA ROCKY PATEL  FIRE CORONA  BOX/20', 'Fire Smoke', 7, 0, NULL, NULL),
(156, 'CM-03610', 'CAJAS DE MADERA ROCKY PATEL  FIRE LANCERO  BOX/20', 'Fire Smoke', 7, 0, NULL, NULL),
(157, 'CM-03611', 'CAJAS DE MADERA ROCKY PATEL  FIRE CHURCHILL  BOX/20', 'Fire Smoke', 7, 0, NULL, NULL),
(158, 'CM-03612', 'CAJAS DE MADERA ROCKY PATEL  FIRE PETIT CORONA  BOX/20', 'Fire Smoke', 7, 0, NULL, NULL),
(159, 'CM-03613', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. LANCERO CONERICO  BOX/20', 'Gold By RP', 7, 0, NULL, NULL),
(160, 'CM-03614', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. LONSDALES CONERICO  BOX/20', 'Gold By RP', 7, 1, NULL, NULL),
(161, 'CM-03615', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. BELICOSO CONERICO  BOX/20', 'Gold By RP', 7, 41, NULL, NULL),
(162, 'CM-03616', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. CORONA CONERICO  BOX/20', 'Gold By RP', 7, 0, NULL, NULL),
(163, 'CM-03617', 'CAJAS DE MADERA ROCKY PATEL  GRAN VIDA ROBUSTO PENSILVANIA  BOX/20', 'Gran Vida', 7, 0, NULL, NULL),
(164, 'CM-03618', 'CAJAS DE MADERA ROCKY PATEL  GRAN VIDA TORO PENSILVANIA  BOX/20', 'Gran Vida', 7, 0, NULL, NULL),
(165, 'CM-03619', 'CAJAS DE MADERA ROCKY PATEL  HABANA COROJO TORPEDO  BOX/20', 'Habano Corojo By RP', 7, 0, NULL, NULL),
(166, 'CM-03620', 'CAJAS DE MADERA ROCKY PATEL  HABANA COROJO ROBUSTO  BOX/20', 'Habano Corojo By RP', 7, 0, NULL, NULL),
(167, 'CM-03621', 'CAJAS DE MADERA ROCKY PATEL  HABANA COROJO TORO GRANDE  BOX/20', 'Habano Corojo By RP', 7, 0, NULL, NULL),
(168, 'CM-03622', 'CAJAS DE MADERA ROCKY PATEL  HABANA COROJO SIXTY  BOX/20', 'Habano Corojo By RP', 7, 0, NULL, NULL),
(169, 'CM-03623', 'CAJAS DE MADERA ROCKY PATEL  HABANA PREMIUN TORO CONERICO  BOX/25', 'Habana Premiun', 13, 2, NULL, NULL),
(170, 'CM-03624', 'CAJAS DE MADERA ROCKY PATEL  HABANA PREMIUN TORPEDO CONERICO  BOX/25', 'Habana Premiun', 13, 1, NULL, NULL),
(171, 'CM-03625', 'CAJAS DE MADERA ROCKY PATEL  HABANA PREMIUN ROBUSTO CONERICO  BOX/25', 'Habana Premiun', 13, 0, NULL, NULL),
(172, 'CM-03626', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO ROBUSTO MADURO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(173, 'CM-03627', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO LONSDALES MADURO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(174, 'CM-03628', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO DOBLE CORONA MADURO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(175, 'CM-03629', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO TORO MADURO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(176, 'CM-03630', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO TORPEDO MADURO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(177, 'CM-03631', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO LANCERO COROJO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(178, 'CM-03632', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO TORPEDO COROJO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(179, 'CM-03633', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO LONSDALES COROJO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(180, 'CM-03634', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO DOBLE CORONA COROJO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(181, 'CM-03635', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO TORO COROJO  BOX/20', 'Honduran Classic', 7, 120, NULL, NULL),
(182, 'CM-03636', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO ROBUSTO COROJO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(183, 'CM-03637', 'CAJAS DE MADERA ROCKY PATEL  I-PRESS TORO MADURO  BOX/20', 'I Press By RP', 7, 0, NULL, NULL),
(184, 'CM-03638', 'CAJAS DE MADERA ROCKY PATEL  ITC ESMERALDA ROBUSTO  BOX/8', 'Stanley Papas', 50, 0, NULL, NULL),
(185, 'CM-03639', 'CAJAS DE MADERA ROCKY PATEL  ITC ESMERALDA TORO  BOX/8', 'Stanley Papas', 50, 0, NULL, NULL),
(186, 'CM-03640', 'CAJAS DE MADERA ROCKY PATEL  JUNIOR VINTAGE 1999 CONERICO  BOX/40', 'Junior Vintage 1999', NULL, NULL, NULL, NULL),
(187, 'CM-03641', 'CAJAS DE MADERA ROCKY PATEL  JUNIOR VINTAGE 1992  NATURAL  BOX/40', 'Junior Vintage 1992', NULL, 1, NULL, NULL),
(188, 'CM-03642', 'CAJAS DE MADERA ROCKY PATEL  JUNIOR VINTAGE 1990 MADURO  BOX/40', 'Junior Vintage 1990', NULL, 600, NULL, NULL),
(189, 'CM-03643', 'CAJAS DE MADERA ROCKY PATEL  LA CONQUISTA TORO MADURO  BOX/20', 'La Conquista', 7, 0, NULL, NULL),
(190, 'CM-03644', 'CAJAS DE MADERA ROCKY PATEL  LA CONQUISTA TORPEDO MADURO  BOX/20', 'La Conquista', 7, 0, NULL, NULL),
(191, 'CM-03645', 'CAJAS DE MADERA ROCKY PATEL  LA CONQUISTA ROBUSTO MADURO  BOX/20', 'La Conquista', 7, 0, NULL, NULL),
(192, 'CM-03646', 'CAJAS DE MADERA ROCKY PATEL  LEESBURG ROBUSTO CONERICO BOX/20', 'Leesburg', 7, 2, NULL, NULL),
(193, 'CM-03647', 'CAJAS DE MADERA ROCKY PATEL  LEESBURG TORPEDO CONERICO BOX/20', 'Leesburg', 7, 0, NULL, NULL),
(194, 'CM-03648', 'CAJAS DE MADERA ROCKY PATEL  LIMITED EDITION SIZE A  BOX/16', 'Graveyson', 26, 0, NULL, NULL),
(195, 'CM-03649', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE DOBLE CORONA CONERICO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(196, 'CM-03650', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE TORO CONERICO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(197, 'CM-03651', 'CAJAS DE MADERA ROCKY PATEL  MADURO COSTA RICA TORPEDO MADURO  BOX/20', 'RP - Costa Rica', 7, 0, NULL, NULL),
(198, 'CM-03652', 'CAJAS DE MADERA ROCKY PATEL  MADURO COSTA RICA CHURCHILL MADURO  BOX/20', 'RP - Costa Rica', 7, 0, NULL, NULL),
(199, 'CM-03653', 'CAJAS DE MADERA ROCKY PATEL  MADURO COSTA RICA SIXTY MADURO  BOX/20', 'RP - Costa Rica', 7, 0, NULL, NULL),
(200, 'CM-03654', 'CAJAS DE MADERA ROCKY PATEL  MADURO COSTA RICA ROBUSTO MADURO  BOX/20', 'RP - Costa Rica', 7, 1, NULL, NULL),
(201, 'CM-03655', 'CAJAS DE MADERA ROCKY PATEL  MERITAGE CHURCHILL COR/MAD  BOX/20', 'Meritage', 7, 0, NULL, NULL),
(202, 'CM-03656', 'CAJAS DE MADERA ROCKY PATEL  MERITAGE TORPEDO COR/MAD  BOX/20', 'Meritage', 7, 1, NULL, NULL),
(203, 'CM-03657', 'CAJAS DE MADERA ROCKY PATEL  MERITAGE ROBUSTO COR/MAD  BOX/20', 'Meritage', 7, 0, NULL, NULL),
(204, 'CM-03658', 'CAJAS DE MADERA ROCKY PATEL  MONOCACY PIRAMIDE PRESS SUMATRA  BOX/20', 'Davidus PL Monocacy', 7, 0, NULL, NULL),
(205, 'CM-03659', 'CAJAS DE MADERA ROCKY PATEL  MONOCACY ROBUSTO SUMATRA  BOX/20', 'Davidus PL Monocacy', 7, 0, NULL, NULL),
(206, 'CM-03660', 'CAJAS DE MADERA ROCKY PATEL  NICARAO TORO HAB/COL  BOX/20', 'Nicarao', 7, 0, NULL, NULL),
(207, 'CM-03661', 'CAJAS DE MADERA ROCKY PATEL  NICARAO TORPEDO HAB/COL  BOX/20', 'Nicarao', 7, 0, NULL, NULL),
(208, 'CM-03662', 'CAJAS DE MADERA ROCKY PATEL  NICARAO ROBUSTO HAB/COL  BOX/20', 'Nicarao', 7, 0, NULL, NULL),
(209, 'CM-03663', 'CAJAS DE MADERA ROCKY PATEL  NICARAO CHURCHILL HAB/COL  BOX/20', 'Nicarao', 7, 0, NULL, NULL),
(210, 'CM-03664', 'CAJAS DE MADERA ROCKY PATEL  NICK CIGAR ROBUSTO CONERICO  BOX/20', 'Nick Cigar World 10 Anivereary', 7, -280, NULL, NULL),
(211, 'CM-03665', 'CAJAS DE MADERA ROCKY PATEL  NICK CIGAR DOBLE CORONA CONERICO  BOX/20', 'Nick Cigar World 10 Anivereary', 7, 11, NULL, NULL),
(212, 'CM-03666', 'CAJAS DE MADERA ROCKY PATEL  NORDING TORO GRANDE HAB/COL  BOX/20', 'Nording', 7, 20, NULL, NULL),
(213, 'CM-03667', 'CAJAS DE MADERA ROCKY PATEL  NORDING TORPEDO HAB/COL  BOX/20', 'Nording', 7, 60, NULL, NULL),
(214, 'CM-03668', 'CAJAS DE MADERA ROCKY PATEL  NORDING ROBUSTO HAB/COL  BOX/20', 'Nording', 7, -20, NULL, NULL),
(215, 'CM-03669', 'CAJAS DE MADERA ROCKY PATEL  NORDING TORO GRANDE HAB/COL  BOX/25 (Malas)', 'Nording', NULL, 0, NULL, NULL),
(216, 'CM-03670', 'CAJAS DE MADERA ROCKY PATEL  NORDING TORPEDO HAB/COL  BOX/25', 'Nording', 13, 0, NULL, NULL),
(217, 'CM-03671', 'CAJAS DE MADERA ROCKY PATEL  NORDING ROBUSTO HAB/COL  BOX/25', 'Nording', 13, 1, NULL, NULL),
(218, 'CM-03672', 'CAJAS DE MADERA ROCKY PATEL  NORDING CHURCHILL HAB/COL  BOX/25', 'Nording', 13, 0, NULL, NULL),
(219, 'CM-03673', 'CAJAS DE MADERA ROCKY PATEL  NORDING TORO GRANDE HAB/COL  BOX/25', 'Nording', 13, 0, NULL, NULL),
(220, 'CM-03674', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. TORPEDO MADURO  BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(221, 'CM-03675', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. ROBUSTO MADURO  BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(222, 'CM-03676', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. ROBUSTO COROJO  BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(223, 'CM-03677', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. TORPEDO COROJO  BOX/20', 'Old World Reserve', 7, 52, NULL, NULL),
(224, 'CM-03678', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. TORO MADURO  BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(225, 'CM-03679', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. LANCERO MADURO  BOX/24', 'Old World Reserve', 47, 0, NULL, NULL),
(226, 'CM-03680', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. LANCERO COROJO  BOX/24', 'Old World Reserve', 47, 0, NULL, NULL),
(227, 'CM-03681', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. TORO COROJO  BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(228, 'CM-03682', 'CAJAS DE MADERA ROCKY PATEL  OCEAN CLUB TORPEDO PRESS SUMATRA  BOX/20', 'RP Ocean Club', 7, 0, NULL, NULL),
(229, 'CM-03683', 'CAJAS DE MADERA ROCKY PATEL  OCEAN CLUB SIXTY PRESS SUMATRA  BOX/20', 'RP Ocean Club', 7, 0, NULL, NULL),
(230, 'CM-03684', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN MADURO TORPEDO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(231, 'CM-03685', 'CAJAS DE MADERA ROCKY PATEL  PHOENIX ROBUSTO MADURO BOX/20', 'Phoenix', 7, 0, NULL, NULL),
(232, 'CM-03686', 'CAJAS DE MADERA ROCKY PATEL  PHOENIX PETIT BELICOSO MADURO BOX/20', 'Phoenix', 7, 0, NULL, NULL),
(233, 'CM-03687', 'CAJAS DE MADERA ROCKY PATEL  RENAISSANCE CHURCHILL SUMATRA BOX/20', 'Renaissance', 7, 0, NULL, NULL),
(234, 'CM-03688', 'CAJAS DE MADERA ROCKY PATEL  RENAISSANCE TORO SUMATRA BOX/20', 'Renaissance', 7, 0, NULL, NULL),
(235, 'CM-03689', 'CAJAS DE MADERA ROCKY PATEL  RENAISSANCE ROBUSTO SUMATRA BOX/20', 'Renaissance', 7, 0, NULL, NULL),
(236, 'CM-03690', 'CAJAS DE MADERA ROCKY PATEL  REO CHAIRMAN HAB/COL BOX/20', 'Reo', 7, 0, NULL, NULL),
(237, 'CM-03691', 'CAJAS DE MADERA ROCKY PATEL  REO TORPEDO HAB/COL BOX/20', 'Reo', 7, 0, NULL, NULL),
(238, 'CM-03692', 'CAJAS DE MADERA ROCKY PATEL  REO ROBUSTO HAB/COL BOX/20', 'Reo', 7, 0, NULL, NULL),
(239, 'CM-03693', 'CAJAS DE MADERA ROCKY PATEL CONNECTICUT BYTORO CONERICO BOX/20', 'Connecticut Rocky Patel', 7, 125, NULL, NULL),
(240, 'CM-03694', 'CAJAS DE MADERA ROCKY PATEL CONNECTICUT BY TORPEDO CONERICO BOX/20', 'Connecticut Rocky Patel', 7, 210, NULL, NULL),
(241, 'CM-03695', 'CAJAS DE MADERA ROCKY PATEL MADURO BY TORO BOX/20', 'Connecticut Rocky Patel', 7, 0, NULL, NULL),
(242, 'CM-03696', 'CAJAS DE MADERA ROCKY PATEL MADURO BY  LANCERO BOX/20', 'Connecticut Rocky Patel', 7, 0, NULL, NULL),
(243, 'CM-03697', 'CAJAS DE MADERA ROCKY PATEL MADURO BY CHURCILL BOX/20', 'Connecticut Rocky Patel', 7, 18, NULL, NULL),
(244, 'CM-03698', 'CAJAS DE MADERA ROCKY PATEL  ROCKY PATEL MADURO BY BELICOSO MADURO BOX/20', 'Connecticut Rocky Patel', 7, 0, NULL, NULL),
(245, 'CM-03699', 'CAJAS DE MADERA ROCKY PATEL CONNECTICUT BY ROBUSTO CONERICO BOX/20', 'Connecticut Rocky Patel', 7, 158, NULL, NULL),
(246, 'CM-03700', 'CAJAS DE MADERA ROCKY PATEL  ROSADO TORO SUMATRA BOX/20', 'Rosado', 7, 0, NULL, NULL),
(247, 'CM-03701', 'CAJAS DE MADERA ROCKY PATEL  ROSADO TORPEDO SUMATRA BOX/20', 'Rosado', 7, 0, NULL, NULL),
(248, 'CM-03702', 'CAJAS DE MADERA ROCKY PATEL  ROSADO ROBUSTO SUMATRA BOX/20', 'Rosado', 7, 0, NULL, NULL),
(249, 'CM-03703', 'CAJAS DE MADERA ROCKY PATEL  ROSADO LONSDALE SUMATRA BOX/20', 'Rosado', 7, 0, NULL, NULL),
(250, 'CM-03704', 'CAJAS DE MADERA ROCKY PATEL  ROSADO LANCERO SUMATRA BOX/20', 'Rosado', 7, 14, NULL, NULL),
(251, 'CM-03705', 'CAJAS DE MADERA ROCKY PATEL  ROSADO DOBLE CORONA SUMATRA BOX/20', 'Rosado', 7, 63, NULL, NULL),
(252, 'CM-03706', 'CAJAS DE MADERA ROCKY PATEL  ROSADO PETIT CORONA SUMATRA BOX/20', 'Rosado', 7, 75, NULL, NULL),
(253, 'CM-03707', 'CAJAS DE MADERA ROCKY PATEL  SAMPLER SIXTY 90,92,99 VARIADO BOX/10', 'VARIOS', 4, 1, NULL, NULL),
(254, 'CM-03708', 'CAJAS DE MADERA ROCKY PATEL  SAMPLER ROBUSTO GIFT VARIADO BOX/8', 'VARIOS', 50, 7, NULL, NULL),
(255, 'CM-03709', 'CAJAS DE MADERA ROCKY PATEL  SAMPLER TORO GIFT VARIADO BOX/10', 'VARIOS', 4, 3, NULL, NULL),
(256, 'CM-03711', 'CAJAS DE MADERA ROCKY PATEL  SAMPLER LIMITED RELEASE TORO VARIADO BOX/6', 'VARIOS', 5, 11, NULL, NULL),
(257, 'CM-03712', 'CAJAS DE MADERA ROCKY PATEL  SAVERIO TORO BOX/20', 'Saverio', 7, 55, NULL, NULL),
(258, 'CM-03713', 'CAJAS DE MADERA ROCKY PATEL  SAVERIO TORPEDO BOX/20', 'Saverio', 7, 25, NULL, NULL),
(259, 'CM-03714', 'CAJAS DE MADERA ROCKY PATEL  SUNGROWN PETIT CORONA SUMATRA BOX/20', 'Sungrown', 7, -236, NULL, NULL),
(260, 'CM-03715', 'CAJAS DE MADERA ROCKY PATEL  SUNGROWN CORONA SUMATRA BOX/20', 'Sungrown', 7, 89, NULL, NULL),
(261, 'CM-03716', 'CAJAS DE MADERA ROCKY PATEL  SUNGROWN SHORT ROBUSTO 4-1/2X54 SUMATRA BOX/20', 'Sungrown', 7, 0, NULL, NULL),
(262, 'CM-03717', 'CAJAS DE MADERA ROCKY PATEL  SUNGROWN LANCERO SUMATRA BOX/24', 'Sungrown', 47, 0, NULL, NULL),
(263, 'CM-03718', 'CAJAS DE MADERA ROCKY PATEL  SUNGROWN ROCKCHILL SUMATRA BOX/20', 'Sungrown', 7, 0, NULL, NULL),
(264, 'CM-03719', 'CAJAS DE MADERA ROCKY PATEL  SUNGROWN ROBUSTO SUMATRA BOX/20', 'Sungrown', 7, -329, NULL, NULL),
(265, 'CM-03720', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE PETIT BELICOSO PRESS MADURO BOX/25', 'Super Fuerte', 13, 0, NULL, NULL),
(266, 'CM-03721', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE ROBUSTO HAB-2000 BOX/25', 'Super Fuerte', 13, 0, NULL, NULL),
(267, 'CM-03722', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE TORO PRESS MADURO BOX/25', 'Super Fuerte', 13, 180, NULL, NULL),
(268, 'CM-03723', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE CORONA MADURO BOX/25', 'Super Fuerte', 13, 0, NULL, NULL),
(269, 'CM-03724', 'CAJAS DE MADERA ROCKY PATEL  THE PENINSULA CHICAGO BOX/1', 'The Peninsula', 65, 0, NULL, NULL),
(270, 'CM-03725', 'CAJAS DE MADERA ROCKY PATEL  VALEDOR TORPEDO SUMATRA BOX/20', 'Valedor', 7, 0, NULL, NULL),
(271, 'CM-03726', 'CAJAS DE MADERA ROCKY PATEL  VENGENCE ROBUSTO MADURO BOX/20', 'Vengence', 7, 0, NULL, NULL),
(272, 'CM-03727', 'CAJAS DE MADERA ROCKY PATEL  VENGENCE CHURCHILL MADURO BOX/20', 'Vengence', 7, 0, NULL, NULL),
(273, 'CM-03728', 'CAJAS DE MADERA ROCKY PATEL  VENGENCE TORPEDO MADURO BOX/20', 'Vengence', 7, 0, NULL, NULL),
(274, 'CM-03729', 'CAJAS DE MADERA ROCKY PATEL  VENGENCE TORO MADURO BOX/20', 'Vengence', 7, 0, NULL, NULL),
(275, 'CM-03730', 'CAJAS DE MADERA ROCKY PATEL  VIBE TORO GRANDE HAB/COL BOX/20', 'Vibe', 7, 0, NULL, NULL),
(276, 'CM-03731', 'CAJAS DE MADERA ROCKY PATEL  VIBE ROBUSTO HAB/COL BOX/20', 'Vibe', 7, 0, NULL, NULL),
(277, 'CM-03732', 'CAJAS DE MADERA ROCKY PATEL  VIBE CORONA HAB/COL BOX/20', 'Vibe', 7, 0, NULL, NULL),
(278, 'CM-03733', 'CAJAS DE MADERA ROCKY PATEL  VIGILANTE TORO GRANDE MADURO BOX/25', 'Vigilante', 13, 0, NULL, NULL),
(279, 'CM-03734', 'CAJAS DE MADERA ROCKY PATEL  VIGILANTE ROBUSTO GRANDE MADURO BOX/25', 'Vigilante', 13, 0, NULL, NULL),
(280, 'CM-03735', 'CAJAS DE MADERA ROCKY PATEL  VIGILANTE PETIT CORONA MADURO BOX/25', 'Vigilante', 13, 0, NULL, NULL),
(281, 'CM-03737', 'CAJAS DE MADERA ROCKY PATEL  VIGILANTE PETIT CORONA COROJO BOX/25', 'Vigilante', 13, 0, NULL, NULL),
(282, 'CM-03738', 'CAJAS DE MADERA ROCKY PATEL  VIGILANTE SUPER TORO COROJO BOX/25', 'Vigilante', 13, 0, NULL, NULL),
(283, 'CM-03739', 'CAJAS DE MADERA ROCKY PATEL  VIGILANTE TORPEDO COROJO BOX/25', 'Vigilante', 13, 0, NULL, NULL),
(284, 'CM-03740', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 ROCKCHILL MADURO PRESS BOX/20', 'Vintage 1990', 7, 1, NULL, NULL),
(285, 'CM-03741', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 TORPEDO MADURO PRESS BOX/20', 'Vintage 1990', 7, 50, NULL, NULL),
(286, 'CM-03742', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 CHURCHILL RED. MADURO BOX/20', 'Vintage 1990', 7, 70, NULL, NULL),
(287, 'CM-03743', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 PETIT CORONA MADURO REDONDO BOX/20', 'Vintage 1990', 7, 0, NULL, NULL),
(288, 'CM-03744', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 TORO MADURO PRESS BOX/20', 'Vintage 1990', 7, 173, NULL, NULL),
(289, 'CM-03745', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 SIXTY MADURO BOX/20', 'Vintage 1990', 7, 0, NULL, NULL),
(290, 'CM-03746', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 PERFECTO MADURO BOX/20', 'Vintage 1990', 7, 0, NULL, NULL),
(291, 'CM-03747', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1992 PETIT CORONA SUMATRA REDONDO BOX/20', 'Vintage 1992', 7, 0, NULL, NULL),
(292, 'CM-03748', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1992 TORPEDO PRESS SUMATRA BOX/20', 'Vintage 1992', 7, 2, NULL, NULL),
(293, 'CM-03749', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1992 TORO PRESS SUMATRA BOX/20', 'Vintage 1992', 7, 14, NULL, NULL),
(294, 'CM-03750', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1992 ROBUSTO PRESS SUMATRA BOX/20', 'Vintage 1992', 7, 7, NULL, NULL),
(295, 'CM-03751', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1992 SIXTY SUMATRA BOX/20', 'Vintage 1992', 7, 45, NULL, NULL),
(296, 'CM-03752', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1999 PERFECTO CONERICO BOX/20', 'Vintage 1999', 7, 210, NULL, NULL),
(297, 'CM-03753', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1999 CORONA CONERICO BOX/20', 'Vintage 1999', 7, 94, NULL, NULL),
(298, 'CM-03754', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1999 ROBUSTO CONERICO BOX/20', 'Vintage 1999', 7, 2, NULL, NULL),
(299, 'CM-03755', 'CAJAS DE MADERA ROCKY PATEL  EXTREME TORO SUMATRA BOX/20', 'Extreme', 7, 4, NULL, NULL),
(300, 'CM-03756', 'CAJAS DE MADERA ROCKY PATEL  EXTREME CHURCHILL SUMATRA BOX/20', 'Extreme', 7, 0, NULL, NULL),
(301, 'CM-03757', 'CAJAS DE MADERA ROCKY PATEL  EXTREME ROBUSTO SUMATRA BOX/20', 'Extreme', 7, 1, NULL, NULL),
(302, 'CM-03758', 'CAJAS DE MADERA ROCKY PATEL  COBUTO CHURCHILL BOX/20', 'Cobuto', 7, 0, NULL, NULL),
(303, 'CM-03759', 'CAJAS DE MADERA ROCKY PATEL  COBUTO TORO BOX/20', 'Cobuto', 7, 0, NULL, NULL),
(304, 'CM-03760', 'CAJAS DE MADERA ROCKY PATEL  COBUTO ROBUSTO BOX/20', 'Cobuto', 7, 0, NULL, NULL),
(305, 'CM-03761', 'CAJAS DE MADERA ROCKY PATEL  SAMPLER PERFECTO BOX/10', 'VARIOS', 4, 0, NULL, NULL),
(306, 'CM-03762', 'CAJAS DE MADERA ROCKY PATEL  MONOCACY CHURCHILL SUMATRA BOX/20', 'Davidus PL Monocacy', 7, 0, NULL, NULL),
(307, 'CM-03763', 'CAJAS DE MADERA ROCKY PATEL CAMERON BY P.P. CAMERON BOX/20', 'RP Cameroon Especial', 7, 0, NULL, NULL),
(308, 'CM-03764', 'CAJAS DE MADERA ROCKY PATEL CAUCUS TORPEDO SUMATRA BOX/20', 'Caucus', 7, 5, NULL, NULL),
(309, 'CM-03765', 'CAJAS DE MADERA ROCKY PATEL CAUCUS TORO SUMATRA BOX/20', 'Caucus', 7, 1, NULL, NULL),
(310, 'CM-03766', 'CAJAS DE MADERA ROCKY PATEL  CUNUCO  PETIT CORONA HAB. COLORADO BOX/20', 'Cunuco', 7, 0, NULL, NULL),
(311, 'CM-03767', 'CAJAS DE MADERA ROCKY PATEL CRUZ REAL ROBUSTO SUMATRA BOX/20', 'Cruz Real', 7, 0, NULL, NULL),
(312, 'CM-03768', 'CAJAS DE MADERA ROCKY PATEL DECADE LONSDALES REDONDO SUMATRA BOX/20', 'Decada', 7, 20, NULL, NULL),
(313, 'CM-03769', 'CAJAS DE MADERA ROCKY PATEL DECADE ROBUSTO PRENSADO SUMATRA BOX/20', 'Decada', 7, -219, NULL, NULL),
(314, 'CM-03770', 'CAJAS DE MADERA ROCKY PATEL DECADE TORO PRENSADO SUMATRA BOX/20', 'Decada', 7, 2713, NULL, NULL),
(315, 'CM-03771', 'CAJAS DE MADERA ROCKY PATEL DECADE TORO REDONDO SUMATRA BOX/20', 'Decada', 7, 85, NULL, NULL),
(316, 'CM-03772', 'CAJAS DE MADERA ROCKY PATEL DECADE SHORT ROBUSTO PRENSADO SUMATRA BOX/20', 'Decada', 7, 0, NULL, NULL),
(317, 'CM-03773', 'CAJAS DE MADERA ROCKY PATEL DECADE SHORT ROBUSTO REDONDO SUMATRA BOX/20', 'Decada', 7, 0, NULL, NULL),
(318, 'CM-03774', 'CAJAS DE MADERA ROCKY PATEL DECADE TORPEDO REDONDO SUMATRA BOX/20', 'Decada', 7, 4, NULL, NULL),
(319, 'CM-03775', 'CAJAS DE MADERA ROCKY PATEL DECADE FORTY SIX REDONDO SUMATRA BOX/20', 'Decada', 7, 19, NULL, NULL),
(320, 'CM-03776', 'CAJAS DE MADERA ROCKY PATEL DECADE PETIT BELICOSO PRESADO SUMATRA BOX/20', 'Decada', 7, 45, NULL, NULL),
(321, 'CM-03777', 'CAJAS DE MADERA ROCKY PATEL DECADE PETIT BELICOSO REDONDO SUMATRA BOX/20', 'Decada', 7, 0, NULL, NULL),
(322, 'CM-03778', 'CAJAS DE MADERA ROCKY PATEL EDGE LANCERO COROJO BOX/24', 'The Edge Connecticut', 47, 0, NULL, NULL),
(323, 'CM-03779', 'CAJAS DE MADERA ROCKY PATEL EDGE CORONA MADURO BOX/20', 'The Edge', 7, 1, NULL, NULL),
(324, 'CM-03780', 'CAJAS DE MADERA ROCKY PATEL EDGE CABINET MISIL MADURO BOX/16', 'The Edge', 26, 0, NULL, NULL),
(325, 'CM-03781', 'CAJAS DE MADERA ROCKY PATEL EDGE CABINET MISIL COROJO  BOX/16', 'The Edge', 26, 0, NULL, NULL),
(326, 'CM-03782', 'CAJAS DE MADERA ROCKY PATEL EDGE LIGE DOUBLE CORONA CONERICO BOX/20', 'The Edge Connecticut', 7, 0, NULL, NULL),
(327, 'CM-03783', 'CAJAS DE MADERA ROCKY PATEL EDGE MINI BELICOSO CONERICO BOX/20', 'The Edge Connecticut', 7, 47, NULL, NULL),
(328, 'CM-03784', 'CAJAS DE MADERA ROCKY PATEL EDGE SHORT ROBUSTO CONNECTICUT BOX/20', 'The Edge Connecticut', 7, 9, NULL, NULL),
(329, 'CM-03785', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION ROBUSTO NATURAL BOX/20', 'Evolution', 7, 0, NULL, NULL),
(330, 'CM-03786', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION TORPEDO NATURAL BOX/20', 'Evolution', 7, 0, NULL, NULL),
(331, 'CM-03787', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION TORO NATURAL BOX/20', 'Evolution', 7, 0, NULL, NULL),
(332, 'CM-03788', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION TORO REDONDO NATURAL BOX/20', 'Evolution', 7, 0, NULL, NULL),
(333, 'CM-03789', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION FORTY SIX NATURAL BOX/20', 'Evolution', 7, 0, NULL, NULL),
(334, 'CM-03790', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION LONSDALES NATURAL BOX/20', 'Evolution', 7, 0, NULL, NULL),
(335, 'CM-03791', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION EMPEROR NATURAL BOX/20', 'Evolution', 7, 0, NULL, NULL),
(336, 'CM-03792', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION LANCERO NATURAL BOX/20', 'Evolution', 7, 0, NULL, NULL),
(337, 'CM-03793', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION TORPEDO MADURO BOX/20', 'Evolution', 7, 0, NULL, NULL),
(338, 'CM-03794', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION TORO MADURO BOX/20', 'Evolution', 7, 0, NULL, NULL),
(339, 'CM-03795', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION ROBUSTO MADURO BOX/20', 'Evolution', 7, 0, NULL, NULL),
(340, 'CM-03796', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION LANCERO MADURO BOX/20', 'Evolution', 7, 0, NULL, NULL),
(341, 'CM-03797', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION FORTY SIX MADURO BOX/20', 'Evolution', 7, 0, NULL, NULL),
(342, 'CM-03798', 'CAJAS DE MADERA ROCKY PATEL GOLD BY R.P. CHURCHILL CONERICO BOX/20', 'Gold By RP', 7, 1, NULL, NULL),
(343, 'CM-03799', 'CAJAS DE MADERA ROCKY PATEL GRAN VIDA SUPER TORO PENSILVANIA BOX/20', 'Gran Vida', 7, 0, NULL, NULL),
(344, 'CM-03800', 'CAJAS DE MADERA ROCKY PATEL HABANA RAYS TORO SUMATRA BOX/20', 'Havana Rays Signature', 7, 0, NULL, NULL),
(345, 'CM-03801', 'CAJAS DE MADERA ROCKY PATEL HABANA RAYS TORPEDO SUMATRA BOX/20', 'Havana Rays Signature', 7, 0, NULL, NULL),
(346, 'CM-03802', 'CAJAS DE MADERA ROCKY PATEL HABANA RAYS ROBUSTO SUMATRA BOX/20', 'Havana Rays Signature', 7, 0, NULL, NULL),
(347, 'CM-03803', 'CAJAS DE MADERA ROCKY PATEL HABANA RAYS CORONA SUMATRA BOX/20', 'Havana Rays Signature', 7, 0, NULL, NULL),
(348, 'CM-03804', 'CAJAS DE MADERA ROCKY PATEL HABANA RAYS LITLE RAY SUMATRA BOX/20', 'Havana Rays Signature', 7, 0, NULL, NULL),
(349, 'CM-03805', 'CAJAS DE MADERA ROCKY PATEL HABANA RAYS BIG RAY SUMATRA BOX/20', 'Havana Rays Signature', 7, 0, NULL, NULL),
(350, 'CM-03806', 'CAJAS DE MADERA ROCKY PATEL MADURO OF COSTA RICA MADURO TORO  BOX/20', 'Gold Maduro By RP', 7, 2, NULL, NULL),
(351, 'CM-03807', 'CAJAS DE MADERA ROCKY PATEL MONOCASY CHURCHILL PRESS SUMATRA BOX/20', 'Davidus PL Monocacy', 7, 25, NULL, NULL),
(352, 'CM-03808', 'CAJAS DE MADERA ROCKY PATEL  NICK CIGAR TORO CONERICO BOX/20', 'Nick`s Perdomo', 7, 15, NULL, NULL),
(353, 'CM-03809', 'CAJAS DE MADERA ROCKY PATEL  NORDING  TORO HAB. COLORADO BOX/20', 'Nording', 7, 61, NULL, NULL),
(354, 'CM-03810', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD ROBUSTO REDONDO MADURO BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(355, 'CM-03811', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD ROBUSTO REDONDO COROJO BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(356, 'CM-03812', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORO REDONDO MADURO BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(357, 'CM-03813', 'CAJAS DE MADERA ROCKY PATEL CONNECTICUT BYCHURCHILL CONERICO BOX/20', 'Connecticut Rocky Patel', 7, -41, NULL, NULL),
(358, 'CM-03814', 'CAJAS DE MADERA ROCKY PATEL ROCKY PATEL BLOCK ISLAND SEVERAL BOX/6', 'VARIOS', 5, 0, NULL, NULL),
(359, 'CM-03815', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION LONSDALE MADURO BOX/ 20', 'Evolution', 7, 0, NULL, NULL),
(360, 'CM-03816', 'CAJAS DE MADERA ROCKY PATEL SUNGROWN SIXTY SUMATRA BOX/20', 'Sungrown', 7, -102, NULL, NULL),
(361, 'CM-03817', 'CAJAS DE MADERA ROCKY PATEL SUNGROWN TORPEDO SUMATRA BOX/20', 'Sungrown', 7, -29, NULL, NULL),
(362, 'CM-03818', 'CAJAS DE MADERA ROCKY PATEL SUNGROWN SHORT ROBUSTO 4X54 SUMATRA BOX/20', 'Sungrown', 7, 0, NULL, NULL),
(363, 'CM-03819', 'CAJAS DE MADERA ROCKY PATEL SUNGROWN PETIT BELICOSO SUMATRA BOX/20', 'Sungrown', 7, 20, NULL, NULL),
(364, 'CM-03820', 'CAJAS DE MADERA ROCKY PATEL SUNGROWN TORO SUMATRA BOX/20', 'Sungrown', 7, 365, NULL, NULL),
(365, 'CM-03821', 'CAJAS DE MADERA ROCKY PATEL SUNGROWN SAMPLER SEVERAL BOX/5', 'Sungrown', 6, 0, NULL, NULL),
(366, 'CM-03822', 'CAJAS DE MADERA ROCKY PATEL SUPER FUERTE CORONA GRANDE COROJO BOX/25', 'Super Fuerte', 13, 0, NULL, NULL),
(367, 'CM-03823', 'CAJAS DE MADERA ROCKY PATEL VALEDOR TORO SUMATRA BOX/20', 'Valedor', 7, 0, NULL, NULL),
(368, 'CM-03824', 'CAJAS DE MADERA ROCKY PATEL VALEDOR ROBUSTO SUMATRA BOX/20', 'Valedor', 7, 0, NULL, NULL),
(369, 'CM-03825', 'CAJAS DE MADERA ROCKY PATEL VIGILANTE TORO GRANDE COROJO BOX/25', 'Vigilante', 13, 0, NULL, NULL),
(370, 'CM-03826', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 ROBUSTO REDONDO MADURO BOX/20', 'Vintage 1990', 7, -310, NULL, NULL),
(371, 'CM-03827', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 ROBUSTO 5X50 RED MADURO BOX/10', 'Vintage 1990', 4, 22, NULL, NULL),
(372, 'CM-03828', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 TORO TUBO ROUND MADURO BOX/10', 'Vintage 1990', 4, 145, NULL, NULL),
(373, 'CM-03829', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 CHURCHILL PRENSADO MADURO BOX/20', 'Vintage 1990', 7, 211, NULL, NULL),
(374, 'CM-03830', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 CORONA PRENSADO MADURO BOX/20', 'Vintage 1990', 7, 57, NULL, NULL),
(375, 'CM-03831', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 CORONA REDONDO MADURO BOX/20', 'Vintage 1990', 7, 59, NULL, NULL),
(376, 'CM-03832', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 PETIT BELICOSO PRENSADO MADURO BOX/20', 'Vintage 1990', 7, 22, NULL, NULL),
(377, 'CM-03833', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 TORO TUBO ROUND SUMATRA BOX/10', 'Vintage 1992', 4, 47, NULL, NULL),
(378, 'CM-03834', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 ROBUSTO 5X50 TUBO SUMATRA BOX/10', 'Vintage 1992', 4, 0, NULL, NULL),
(379, 'CM-03835', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 ROBUSTO REDONDO SUMATRA BOX/20', 'Vintage 1992', 7, 130, NULL, NULL),
(380, 'CM-03836', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 CORONA PRENSADO SUMATRA BOX/20', 'Vintage 1992', 7, 137, NULL, NULL),
(381, 'CM-03837', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 PERFECTO SUMATRA BOX/20', 'Vintage 1992', 7, 2, NULL, NULL),
(382, 'CM-03838', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 PETIT CORONA REDONDO SUMATRA BOX/20', 'Vintage 1992', 7, 34, NULL, NULL),
(383, 'CM-03839', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 TORPEDO REDONDO SUMATRA BOX/20', 'Vintage 1992', 7, 1, NULL, NULL),
(384, 'CM-03840', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 PETIT BELICOSO PRENSADO SUMATRA BOX/20', 'Vintage 1992', 7, 86, NULL, NULL),
(385, 'CM-03841', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 CHURCHILL REDONDO SUMATRA BOX/20', 'Vintage 1992', 7, 5, NULL, NULL),
(386, 'CM-03842', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 CORONA REDONDO SUMATRA BOX/20', 'Vintage 1992', 7, 52, NULL, NULL),
(387, 'CM-03843', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 ROBUSTO TUBO 5X50 CONERICO BOX/10', 'Vintage 1999', 4, 0, NULL, NULL),
(388, 'CM-03844', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 PETIT CORONA CONERICO BOX/20', 'Vintage 1999', 7, 265, NULL, NULL),
(389, 'CM-03845', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 TORO TUBO CONERICO BOX/10', 'Vintage 1999', 4, 175, NULL, NULL),
(390, 'CM-03846', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 TORO CONERICO BOX/20', 'Vintage 1999', 7, 55, NULL, NULL),
(391, 'CM-03847', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 TORPEDO CONERICO BOX/20', 'Vintage 1999', 7, 0, NULL, NULL),
(392, 'CM-03848', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 PERFECTO CORTOS CONERICO BOX/20', 'Vintage 1999', 7, 0, NULL, NULL),
(393, 'CM-03849', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 PETIT BELICOSO CONERICO BOX/20', 'Vintage 1999', 7, 48, NULL, NULL),
(394, 'CM-03850', 'CAJAS DE MADERA ROCKY PATEL 1950 SPECIAL RESERVE SIXTY SUMATRA BOX/20', 'VARIOS', 7, 0, NULL, NULL),
(395, 'CM-03851', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORO CONERICO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(396, 'CM-03852', 'CAJAS DE MADERA ROCKY PATEL SAMPLER PRESS SEVERAL BOX/6', 'VARIOS', 5, 0, NULL, NULL),
(397, 'CM-03853', 'CAJAS DE MADERA ROCKY PATEL SAMPLER PETIT BELICOSO SEVERAL BOX/6', 'VARIOS', 5, 0, NULL, NULL),
(398, 'CM-03854', 'CAJAS DE MADERA ROCKY PATEL SAMPLER SUPER PREMIUN L.R. TORO SEVERAL BOX/6', 'VARIOS', 5, 0, NULL, NULL),
(399, 'CM-03855', 'CAJAS DE MADERA ROCKY PATEL SAMPLER EDGE ROBUSTO  SEVERAL BOX/5', 'VARIOS', 6, 0, NULL, NULL),
(400, 'CM-03856', 'CAJAS DE MADERA ROCKY PATEL SAMPLER EDICION ESPECIAL SHORT ROBUSTO SEVERAL BOX/6', 'VARIOS', 5, 0, NULL, NULL),
(401, 'CM-03857', 'CAJAS DE MADERA ROCKY PATEL SAMPLER TUBO ALUMINIO TORO SEVERAL BOX/5', 'VARIOS', 6, 0, NULL, NULL),
(402, 'CM-03859', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORPEDO BOX/100', 'Old World Reserve', 18, 0, NULL, NULL),
(403, 'CM-03860', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORO BOX/100', 'Old World Reserve', 18, 0, NULL, NULL),
(404, 'CM-03861', 'CAJAS DE MADERA  ROCKY PATEL  SAMPLER LIMITED RELEASE  TORO SEVERAL BOX/6', 'VARIOS', 5, 0, NULL, NULL),
(405, 'CM-03862', 'CAJAS DE MADERA ROCKY PATEL CLASICO ARROW COROJO BOX/20', 'Classic', 7, 0, NULL, NULL),
(406, 'CM-03863', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORPEDO CONERICO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(407, 'CM-03864', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET ROBUSTO CONERICO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(408, 'CM-03865', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORO SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(409, 'CM-03866', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORPEDO SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(410, 'CM-03867', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET ROBUSTO SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(411, 'CM-03868', 'CAJAS DE MADERA ROCKY PATEL  NICK CIGAR TORPEDO CONERICO  BOX/20', 'Nick Cigar World 10 Anivereary', 7, -10, NULL, NULL),
(412, 'CM-03869', 'CAJAS DE MADERA ROCKY PATEL  NICK CIGAR CHURCHILL CONERICO  BOX/20', 'Nick Cigar World 10 Anivereary', 7, 1, NULL, NULL),
(413, 'CM-03870', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON LEGEND ROBUSTO GRANDE MADURO BOX/25', 'Cameroon Legend', 13, 0, NULL, NULL),
(414, 'CM-03871', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN MADURO ROBUSTO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(415, 'CM-03872', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN MADURO TORO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(416, 'CM-03873', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN CORONA MADURO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(417, 'CM-03874', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 ROBUSTO ROUND CAMEROON BOX/20', 'VINTAGE 2003', 7, -582, NULL, NULL),
(418, 'CM-03875', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 TORO ROUND CAMEROON BOX/20', 'VINTAGE 2003', 7, -114, NULL, NULL),
(419, 'CM-03876', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 CHURCHILL ROUND CAMEROON BOX/20', 'VINTAGE 2003', 7, 30, NULL, NULL),
(420, 'CM-03877', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 TORPEDO ROND CAMEROON BOX/20', 'VINTAGE 2003', 7, -160, NULL, NULL),
(421, 'CM-03878', 'CAJAS DE MADERA ROCKY PATEL DECADE TORPEDO PRENSADO SUMATRA BOX/20', 'Decada', 7, 1274, NULL, NULL),
(422, 'CM-03879', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. ROBUSTO CONERICO  BOX/20', 'Gold By RP', 7, 51, NULL, NULL),
(423, 'CM-03880', 'CAJAS DE MADERA ROCKY PATEL  ROCKY PATEL MADURO BY ROBUSTO MADURO BOX/20 NUEVA EDICION', 'Gold Maduro By RP', NULL, 0, NULL, NULL),
(424, 'CM-03881', 'CAJAS DE MADERA ROCKY PATEL  CAUCUS  CORONA SUMATRA BOX/20', 'Caucus', 7, 0, NULL, NULL),
(425, 'CM-03882', 'CAJAS DE MADERA ROCKY PATEL LIMITED EDITION HONDURAS SAMPLER BOX/5', 'VARIOS', 6, 0, NULL, NULL);
INSERT INTO `lista_cajas` (`id`, `codigo`, `productoServicio`, `marca`, `tipo_empaque`, `existencia`, `created_at`, `updated_at`) VALUES
(426, 'CM-03883', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE TORPEDO CONERICO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(427, 'CM-03884', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE ROBUSTO CONERICO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(428, 'CM-03885', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE SIXTY CONERICO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(429, 'CM-03886', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 SIXTY ROUND CAMEROON BOX/20', 'VINTAGE 2003', 7, -147, NULL, NULL),
(430, 'CM-03887', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE DOBLE CORONA MADURO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(431, 'CM-03888', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE TORO MADURO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(432, 'CM-03889', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE ROBUSTO MADURO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(433, 'CM-03890', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE SIXTY MADURO  BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(434, 'CM-03891', 'CAJAS DE MADERA ROCKY PATEL  M.J.K.CIGAR SOURCE TORPEDO MADURO BOX/20', 'MJK  Cigar Source', 7, 0, NULL, NULL),
(435, 'CM-03892', 'CAJAS DE MADERA ROCKY PATEL DECADE', 'Decada', NULL, 0, NULL, NULL),
(436, 'CM-03940', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE DOUBLE CORONA NATURAL BOX/25', 'Super Fuerte', 13, 0, NULL, NULL),
(437, 'CM-03966', 'CAJAS DE MADERA ROCKY PATEL ROYAL VINTAGE SIXTY SUMATRA  BOX/20', 'Royal vintage By RP', 7, 5, NULL, NULL),
(438, 'CM-03967', 'CAJAS DE MADERA ROCKY PATEL 1950 SPECIAL RESERVE ROBUSTO SUMATRA BOX/20', 'VARIOS', 7, 0, NULL, NULL),
(439, 'CM-03968', 'CAJAS DE MADERA ROCKY PATEL 1950 SPECIAL RESERVE TORO SUMATRA BOX/20', 'VARIOS', 7, 0, NULL, NULL),
(440, 'CM-03969', 'CAJAS DE MADERA ROCKY PATEL 1950 SPECIAL RESERVE TORPEDO SUMATRA BOX/20', 'VARIOS', 7, 0, NULL, NULL),
(441, 'CM-03970', 'CAJAS DE MADERA ROCKY PATEL THIRD COAST SINDICATE TORPEDO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(442, 'CM-03972', 'CAJAS DE MADERA  ROCKY PATEL  EDGE LITE  ROBUSTO BOX/12', 'The Edge Connecticut', 44, 1, NULL, NULL),
(443, 'CM-03973', 'CAJAS DE MADERA  ROCKY PATEL  EDGE LITE  TORO BOX/12', 'The Edge Connecticut', 44, 0, NULL, NULL),
(444, 'CM-03974', 'CAJAS DE MADERA  ROCKY PATEL  EDGE LITE  TORPEDO BOX/12', 'The Edge Connecticut', 44, 2, NULL, NULL),
(445, 'CM-03975', 'CAJAS DE MADERA  ROCKY PATEL  EDGE LITE  BATTALION BOX/12', 'The Edge Connecticut', 44, 1, NULL, NULL),
(446, 'CM-03976', 'CAJAS DE MADERA  ROCKY PATEL  EDGE LITE  ROBUSTO BOX/6', 'The Edge Connecticut', 5, 0, NULL, NULL),
(447, 'CM-03977', 'CAJAS DE MADERA  ROCKY PATEL  EDGE LITE  TORO BOX/6', 'The Edge Connecticut', 5, 0, NULL, NULL),
(448, 'CM-03978', 'CAJAS DE MADERA  ROCKY PATEL  EDGE LITE  TORPEDO BOX/6', 'The Edge Connecticut', 5, 0, NULL, NULL),
(449, 'CM-03979', 'CAJAS DE MADERA  ROCKY PATEL  EDGE LITE  BATTALION BOX/6', 'The Edge Connecticut', 5, 0, NULL, NULL),
(450, 'CM-03984', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO CANDELA BOX 20', 'The Edge', 7, -724, NULL, NULL),
(451, 'CM-03985', 'CAJAS DE MADERA ROCKY PATEL  DESIENA ROBUSTO COROJO BOX/20', 'Desiena 312', 7, 26, NULL, NULL),
(452, 'CM-03987', 'CAJAS DE MADERA ROCKY PATEL  ROSADO SIXTY SUMATRA BOX/20', 'Rosado', 7, 0, NULL, NULL),
(453, 'CM-03988', 'CAJAS DE MADERA ROCKY PATEL COBUTO TORPEDO BOX 20', 'Cobuto', 7, 0, NULL, NULL),
(454, 'CM-03989', 'CAJAS DE MADERA ROCKY PATEL  RYAN  DANGER  TORO BOX/20', 'Ryan Danger', 7, 0, NULL, NULL),
(455, 'CM-04012', 'CAJAS DE MADERA ROCKY PATEL  MERITAGE TORO COR/MAD  BOX/20', 'Meritage', 7, 0, NULL, NULL),
(456, 'CM-04014', 'CAJAS DE MADERA ROCKY PATEL HIGH SEAS COLLETION BLUE BOX', 'VARIOS', NULL, 0, NULL, NULL),
(457, 'CM-04030', 'CAJAS DE MADERA ROCKY PATEL MISSION TOBACCO LOUNGE 4X38 MAD BOX 40', 'Mission Tobacco Lounge', NULL, 0, NULL, NULL),
(458, 'CM-04031', 'CAJAS DE MADERA ROCKY PATEL MISSION TOBACCO LOUNGE 4X38 SUM BOX 40', 'Mission Tobacco Lounge', NULL, 0, NULL, NULL),
(459, 'CM-04032', 'CAJAS DE MADERA ROCKY PATEL DECADE LIMITED GIFT PACK BOX 6', 'Decada', 5, 0, NULL, NULL),
(460, 'CM-04033', 'CAJAS DE MADERA ROCKY PATEL SUNGROWN SAMPLER BOX 5', 'Sungrown', 6, 0, NULL, NULL),
(461, 'CM-04034', 'CAJAS DE MADERA ROCKY PATEL DECADE VS DECADE LIMITADA TORO SAMPLER BOX 6', 'Decada', 5, 0, NULL, NULL),
(462, 'CM-04036', 'CAJAS DE MADERA ROCKY PATEL DRAIG K 5X50 MAD', 'Draig K', NULL, 0, NULL, NULL),
(463, 'CM-04037', 'CAJAS DE MADERA ROCKY PATEL DRAIG K 6X50 MAD', 'Draig K', NULL, 0, NULL, NULL),
(464, 'CM-04038', 'CAJAS DE MADERA ROCKY PATEL DRAIG K 5X42 MAD', 'Draig K', NULL, 0, NULL, NULL),
(465, 'CM-04039', 'CAJAS DE MADERA ROCKY PATEL ROYAL VINTAGE ROBUSTO SUMATRA  BOX/20', 'Royal vintage By RP', 7, 1, NULL, NULL),
(466, 'CM-04042', 'CAJAS DE MADERA ROCKY PATEL SIXTY EXECUTION BOX/20', 'Execution by RP', 7, 0, NULL, NULL),
(467, 'CM-04043', 'CAJAS DE MADERA ROCKY PATEL ROBUSTO EXECUTION BOX/20', 'Execution by RP', 7, 0, NULL, NULL),
(468, 'CM-04049', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 PRESS ROBUSTO CAMEROON BOX/20', 'VINTAGE 2003', 7, 0, NULL, NULL),
(469, 'CM-04050', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 PRESS TORO CAMEROON BOX/20', 'VINTAGE 2003', 7, 0, NULL, NULL),
(470, 'CM-04052', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 PRESS TORPEDO CAMEROON BOX/20', 'VINTAGE 2003', 7, 0, NULL, NULL),
(471, 'CM-04053', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND PETITE BELICOSO MADURO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(472, 'CM-04054', 'CAJAS DE MADERA ROCKY PATEL MADURO BY LANCERO BOX/20 NUEVA EDICION', 'Connecticut Rocky Patel', NULL, 50, NULL, NULL),
(473, 'CM-04055', 'CAJAS DE MADERA ROCKY PATEL MADURO BY TORO BOX/20 NUEVA EDICION', 'Connecticut Rocky Patel', NULL, 0, NULL, NULL),
(474, 'CM-04056', 'CAJAS DE MADERA ROCKY PATEL MADURO BY CHURCILL BOX/20 NUEVA EDICION', 'Connecticut Rocky Patel', NULL, 0, NULL, NULL),
(475, 'CM-04057', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON BY R.P. BELICOSO CAMEROON BOX/20 NUEVA EDICION', 'Cameroon By RP', NULL, 10, NULL, NULL),
(476, 'CM-04058', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE TORO BOX/10 (NUEVA)', 'The Edge Connecticut', NULL, 0, NULL, NULL),
(477, 'CM-04059', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO COROJO BOX/10', 'The Edge', 4, 0, NULL, NULL),
(478, 'CM-04067', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 2003 PRESS SHORT ROBUSTO BOX 10', 'VINTAGE 2003', 4, 0, NULL, NULL),
(479, 'CM-04068', 'CAJAS DE MADERA ROCKY PATEL HEIRES PETITE CORONA BOX 10', 'Heiress', 4, 0, NULL, NULL),
(480, 'CM-04087', 'CAJAS DE MADERA ROCKY PATEL  EMILIO SERIES ROBUSTO SUMATRA BOX/20', 'Emilio  H Serie', 7, 0, NULL, NULL),
(481, 'CM-04088', 'CAJAS DE MADERA ROCKY PATEL  EMILIO SERIES ROBUSTO MADURO BOX/20', 'Emilio  H Serie', 7, 0, NULL, NULL),
(482, 'CM-04089', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROCKCHILD COROJO BOX/20', 'The Edge', 7, 25, NULL, NULL),
(483, 'CM-04090', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROCKCHILD MADURO BOX/20', 'The Edge', 7, 4, NULL, NULL),
(484, 'CM-04093', 'CAJAS DE MADERA  ROCKY PATEL  EL CONEJITO ROBUSTO BOX 10', 'El Conejito', 4, 182, NULL, NULL),
(485, 'CM-04487', 'CAJAS DE MADERA ROCKY PATEL DECADE ROCKCHILLDE PRENSADO SUMATRA BOX/20', 'Decada', 7, 0, NULL, NULL),
(486, 'CM-04488', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO MADURO BOX/100', 'The Edge', 18, -79, NULL, NULL),
(487, 'CM-04489', 'CAJAS DE MADERA ROCKY PATEL  TORO NAAS BOX/20', 'Naas', 7, 0, NULL, NULL),
(488, 'CM-04490', 'CAJAS DE MADERA ROCKY PATEL SUNGROWN TORO TUBO BOX/10', 'Sungrown', 4, -611, NULL, NULL),
(489, 'CM-04491', 'CAJAS DE MADERA ROCKY PATEL EDGE  MINI BELICOSO MADURO BOX/20', 'Edition Special', 7, 0, NULL, NULL),
(490, 'CM-04492', 'CAJAS DE MADERA ROCKY PATEL EDGE  MINI BELICOSO COROJO BOX/20', 'Edition Special', 7, 10, NULL, NULL),
(491, 'CM-04493', 'CAJAS DE MADERA ROCKY PATEL TERRY BRENNAN TORO BOX/20', 'Terry Brennan', 7, 0, NULL, NULL),
(492, 'CM-04494', 'CAJAS DE MADERA ROCKY PATEL  EDGE SHORT SHORT ROBUSTO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(493, 'CM-04495', 'CAJAS DE MADERA ROCKY PATEL  EDGE SHORT ROBUSTO MADURO BOX/20', 'The Edge', 7, 20, NULL, NULL),
(494, 'CM-04496', 'CAJAS DE MADERA ROCKY PATEL  EDGE SHORT ROBUSTO COROJO BOX/20', 'The Edge', 7, 275, NULL, NULL),
(495, 'CM-04497', 'CAJAS DE MADERA ROCKY PATEL  DOUBLE CORONA COROJO DESIENA BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(496, 'CM-04498', 'CAJAS DE MADERA ROCKY PATEL DESIENA SUPER TORO COROJO  BOX/20', 'Desiena 312', 7, 40, NULL, NULL),
(497, 'CM-04499', 'CAJAS DE MADERA ROCKY PATEL DESIENA TORO COROJO  BOX/20', 'Desiena 312', 7, 25, NULL, NULL),
(498, 'CM-04500', 'CAJAS DE MADERA ROCKY PATEL DESIENA ROBUSTO MADURO BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(499, 'CM-04501', 'CAJAS DE MADERA ROCKY PATEL DESIENA TORO MADURO BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(500, 'CM-04502', 'CAJAS DE MADERA ROCKY PATEL  DOUBLE CORONA CONNECTICUT DESIENA BOX/20', 'Desiena 312', 7, 25, NULL, NULL),
(501, 'CM-04503', 'CAJAS DE MADERA ROCKY PATEL  DESIENA SUPER TORO CONNECTICUT  BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(502, 'CM-04504', 'CAJAS DE MADERA ROCKY PATEL DESIENA TORO CONNECTICUT  BOX/20', 'Desiena 312', 7, 16, NULL, NULL),
(503, 'CM-04505', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. TORO COROJO REDONDO BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(504, 'CM-04506', 'CAJAS DE MADERA ROCKY PATEL CONNECTICUT BY GORDO CONERICO BOX/20', 'Connecticut Rocky Patel', 7, 0, NULL, NULL),
(505, 'CM-04507', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE CORONA BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(506, 'CM-04508', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE SHORT ROBUSTO BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(507, 'CM-04509', 'CAJAS DE MADERA ROCKY PATEL LEGENDS CAMEROOM SUPER TORO MADURO BOX/25', 'Desiena 312', 13, 0, NULL, NULL),
(508, 'CM-04510', 'CAJAS DE MADERA ROCKY PATEL OCEAN CLUB TORO PRESS SUMATRA BOX/20', 'RP Ocean Club', 7, 4, NULL, NULL),
(509, 'CM-04511', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO TUBO CONECTICUT BOX/10', 'The Edge Connecticut', 4, -59, NULL, NULL),
(510, 'CM-04512', 'CAJAS DE MADERA ROCKY PATEL  ORE GOLF ROBUSTO  CONECTICUT BOX/10', 'Ore Golf', 4, 0, NULL, NULL),
(511, 'CM-04513', 'CAJAS DE MADERA ROCKY PATEL  ORE GOLF TORO  CONECTICUT BOX/10', 'Ore Golf', 4, 0, NULL, NULL),
(512, 'CM-04514', 'CAJAS DE MADERA ROCKY PATEL  ORE GOLF GORDO  CONECTICUT BOX/10', 'Ore Golf', 4, 0, NULL, NULL),
(513, 'CM-04515', 'CAJAS DE MADERA ROCKY PATEL  LA CONQUISTA ROBUSTO PRESS BOX/20', 'La Conquista', 7, 600, NULL, NULL),
(514, 'CM-04516', 'CAJAS DE MADERA ROCKY PATEL  LA CONQUISTA TORO PRESS BOX/20', 'La Conquista', 7, 0, NULL, NULL),
(515, 'CM-04517', 'CAJAS DE MADERA ROCKY PATEL  LA CONQUISTA CHURCHILL PRESS BOX/20', 'La Conquista', 7, 200, NULL, NULL),
(516, 'CM-04518', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE SUPER TORO ROUND MADURO BOX/25', 'Super Fuerte', 13, 125, NULL, NULL),
(517, 'CM-04519', 'CAJAS DE MADERA ROCKY PATEL  EDGE SELECTION 652 SUMATRA BOX/50', 'The Edge', 21, 9, NULL, NULL),
(518, 'CM-04520', 'CAJAS DE MADERA ROCKY PATEL  EDGE SELECTION PYRAMID SUMATRA BOX/50', 'The Edge', 21, 18, NULL, NULL),
(519, 'CM-04521', 'CAJAS DE MADERA ROCKY PATEL LA SIRENA DOBLE CORONA BOX/20', 'La Sirena', 7, 10, NULL, NULL),
(520, 'CM-04522', 'CAJAS DE MADERA ROCKY PATEL SMOKE INN HOUSE BLEND  GORDO TRAYS100', 'Smoke Inn House Blend', 18, 0, NULL, NULL),
(521, 'CM-04523', 'CAJAS DE MADERA ROCKY PATEL DECADE TORO TUBO  DELUXE SUMATRA BOX/10', 'Decada', 4, 160, NULL, NULL),
(522, 'CM-04524', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE ROBUSTO PRESS COROJO BOX/20', 'Edge Square', 7, 0, NULL, NULL),
(523, 'CM-04525', 'CAJAS DE MADERA ROCKY PATEL EDGE CORONA COROJO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(524, 'CM-04526', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 PETIT CORONA REDONDO SUMATRA  BOX/20', 'Vintage 1990', 7, 0, NULL, NULL),
(525, 'CM-04527', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 PETIT CORONA REDONDO CONN BOX/20', 'Vintage 1999', 7, 0, NULL, NULL),
(526, 'CM-04528', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 ROBUSTO REDONDO CONN BOX/20', 'Vintage 1999', 7, 155, NULL, NULL),
(527, 'CM-04529', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 TORO REDONDO SUMATRA BOX/20', 'Vintage 1999', 7, 353, NULL, NULL),
(528, 'CM-04530', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 CHURCHILL REDONDO CONNECTICUT BOX/20', 'Vintage 1999', 7, 30, NULL, NULL),
(529, 'CM-04531', 'CAJAS DE MADERA ROCKY PATEL MONOCASY ROBUSTO PRESS SUMATRA BOX/20', 'Davidus PL Monocacy', 7, -5, NULL, NULL),
(530, 'CM-04532', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 TORO REDONDO SUMATRA BOX/20', 'Vintage 1992', 7, 0, NULL, NULL),
(531, 'CM-04533', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 SIXTY REDONDO MADURO BOX/20', 'Vintage 1990', 7, 110, NULL, NULL),
(532, 'CM-04534', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 TORPEDO REDONDO BOX/20', 'Vintage 1990', 7, 34, NULL, NULL),
(533, 'CM-04535', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 CORONA PRENSADO SUMATRA BOX/20', 'Vintage 1990', 7, 0, NULL, NULL),
(534, 'CM-04536', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 TORPEDO REDONDO BOX 20', 'Vintage 1999', 7, 0, NULL, NULL),
(535, 'CM-04537', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 PETIT BELICOSO REDONDO BOX 20', 'Vintage 1999', 7, 0, NULL, NULL),
(536, 'CM-04538', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 PETIT BELICOSO REDONDO BOX 20', 'Vintage 1990', 7, 76, NULL, NULL),
(537, 'CM-04539', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 CHURCHILL PRENSADO BOX 20', 'Vintage 1990', 7, 47, NULL, NULL),
(538, 'CM-04540', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 PETIT CORONA PRENSADO BOX 20', 'Vintage 1992', 7, 3, NULL, NULL),
(539, 'CM-04541', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 ROBUSTO MADURO PRENSADO BOX 20', 'Vintage 1990', 7, 78, NULL, NULL),
(540, 'CM-04542', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 PERFECTO REDONDO BOX 20', 'Vintage 1992', 7, 28, NULL, NULL),
(541, 'CM-04543', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 PERFECTO PRENSADO BOX 20', 'Vintage 1999', 7, 0, NULL, NULL),
(542, 'CM-04544', 'CAJAS DE MADERA ROCKY PATEL  CAMEROON LEGEND SUPER TORO MADURO BOX/25', 'Super Fuerte', 13, 0, NULL, NULL),
(543, 'CM-04545', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 PERFECTO REDONDO BOX/20', 'Vintage 1990', 7, 0, NULL, NULL),
(544, 'CM-04546', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 TORO REDONDO BOX/20', 'Vintage 1990', 7, 50, NULL, NULL),
(545, 'CM-04547', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 PETIT BELICOSO REDONDO SUMATRA BOX/20', 'Vintage 1992', 7, 51, NULL, NULL),
(546, 'CM-04548', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 PETIT CORONA PRENSADO SUMATRA BOX/20', 'Vintage 1990', 7, 83, NULL, NULL),
(547, 'CM-04549', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 CHURCHILL TUBO CONN. BOX/10', 'Vintage 1990', 4, 5, NULL, NULL),
(548, 'CM-04550', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 CHURCHILL TUBO MADURO BOX/10', 'Vintage 1990', 4, 70, NULL, NULL),
(549, 'CM-04551', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM PIRAMID PRESS BOX/20', 'Davidus Antietam', 7, 0, NULL, NULL),
(550, 'CM-04552', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM CHURCILL PRESS BOX/20', 'Davidus Antietam', 7, 0, NULL, NULL),
(551, 'CM-04553', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO PRESS BOX/20', 'Davidus Antietam', 7, 25, NULL, NULL),
(552, 'CM-04554', 'CAJAS DE MADERA ROCKY PATEL  LEESBURG ROBUSTO MADURO BOX/20', 'Leesburg', 7, 49, NULL, NULL),
(553, 'CM-04555', 'CAJAS DE MADERA ROCKY PATEL  LEESBURG TORPEDO MADURO BOX/20', 'Leesburg', 7, 0, NULL, NULL),
(554, 'CM-04556', 'CAJAS DE MADERA ROCKY PATEL ROYAL VINTAGE TORO SUMATRA  BOX/20', 'Royal vintage By RP', 7, 210, NULL, NULL),
(555, 'CM-04557', 'CAJAS DE MADERA ROCKY PATEL ROYAL VINTAGE TORPEDO SUMATRA  BOX/20', 'Royal vintage By RP', 7, 530, NULL, NULL),
(556, 'CM-04558', 'CAJAS DE MADERA ROCKY PATEL ROYAL VINTAGE CHURCHILL SUMATRA  BOX/20', 'Royal vintage By RP', 7, 140, NULL, NULL),
(557, 'CM-04559', 'CAJAS DE MADERA ROCKY PATEL  HABANA PREMIUM TORPEDO MADURO BOX/20', 'Habana Premiun', 7, 0, NULL, NULL),
(558, 'CM-04560', 'CAJAS DE MADERA ROCKY PATEL  HABANA PREMIUM ROBUSTO BOX/20', 'Habana Premiun', 7, 0, NULL, NULL),
(559, 'CM-04561', 'CAJAS DE MADERA ROCKY PATEL SMOKE FRIENDLY BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(560, 'CM-04562', 'CAJAS DE MADERA ROCKY PATEL FREDERICKTOWNE CHURCHILL ROUND  BOX/20', 'Davidus Fredericktown', 7, 5, NULL, NULL),
(561, 'CM-04563', 'CAJAS DE MADERA ROCKY PATEL CCF WHITE LABEL TORO BOX/20', 'CCF- White Label', 7, 0, NULL, NULL),
(562, 'CM-04564', 'CAJAS DE MADERA ROCKY PATEL CCF WHITE LABEL SHORT ROBUSTO BOX/20', 'CCF- White Label', 7, 0, NULL, NULL),
(563, 'CM-04565', 'CAJAS DE MADERA ROCKY PATEL CCF WHITE LABEL CORONA BOX/20', 'CCF- White Label', 7, 0, NULL, NULL),
(564, 'CM-04597', 'CAJAS DE MADERA ROCKY PATEL  ORETOBERFEST TORO  CONECTICUT BOX/10', 'Oretoberfest', 4, 0, NULL, NULL),
(565, 'CM-04598', 'CAJAS DE MADERA ROCKY PATEL  ORETOBERFEST  TORO  HABANO BOX/10', 'Oretoberfest', 4, 0, NULL, NULL),
(566, 'CM-04599', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 ROBUSTO ROUND CAMEROON BOX/10', 'VINTAGE 2003', 4, 0, NULL, NULL),
(567, 'CM-04600', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 ROBUSTO PRENSADO MADURO BOX 10', 'Vintage 1990', 4, 0, NULL, NULL),
(568, 'CM-04601', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1992 ROBUSTO PRESS SUMATRA BOX/10', 'Vintage 1992', 4, 0, NULL, NULL),
(569, 'CM-04602', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1999 ROBUSTO CONERICO 5X50 BOX/10', 'Vintage 1999', 4, 0, NULL, NULL),
(570, 'CM-04603', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 TORPEDO ROND CAMEROON BOX10', 'VINTAGE 2003', 4, 140, NULL, NULL),
(571, 'CM-04604', 'CAJAS DE MADERA ROCKY PATEL  EDGE HABANO SIN GRABADO BOX/100', 'The Edge Nicaragua', 18, 0, NULL, NULL),
(572, 'CM-05001', 'CAJAS DE MADERA  ROCKY PATEL PREMIUM BURN BY ROCKY PATEL TORPEDO  BOX-20', 'Gold By RP', 7, 0, NULL, NULL),
(573, 'CM-05003', 'CAJAS DE MADERA  ROCKY PATEL PREMIUM BURN BY ROCKY PATEL ROBUSTO  BOX-20', 'Gold By RP', 7, 0, NULL, NULL),
(574, 'CM-05128', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO SUMATRA BOX/20', 'The Edge', 7, 1, NULL, NULL),
(575, 'CM-05129', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO SUMATRA BOX/20', 'The Edge', 7, -175, NULL, NULL),
(576, 'CM-05133', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND ROBUSTO COROJO BOX/20', 'Cuban Blend', 7, 50, NULL, NULL),
(577, 'CM-05140', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND PETITE BELICOSO COROJO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(578, 'CM-05141', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND TORPEDO MADURO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(579, 'CM-05151', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROCKCHILDE SUMATRA BOX/20', 'The Edge', 7, 10, NULL, NULL),
(580, 'CM-05166', 'CAJAS DE MADERA ROCKY PATEL  LA CONQUISTA CHURCHILL MADURO  BOX/20', 'La Conquista', 7, 0, NULL, NULL),
(581, 'CM-05182', 'CAJAS DE MADERA ROCKY PATEL VIVALO LONSDALE BOX/20', 'Vivalo', 7, 0, NULL, NULL),
(582, 'CM-05222', 'CAJAS DE MADERA ROCKY PATEL  EDGE LIMITED EDITION \"A\" 8-1/2X50 TRAY 12', 'The Edge', 44, 0, NULL, NULL),
(583, 'CM-05247', 'CAJAS DE MADERA ROCKY PATEL ZARKA 1932 5-1/2X52 JAL.', 'Zarka 1932', NULL, 0, NULL, NULL),
(584, 'CM-05248', 'CAJAS DE MADERA ROCKY PATEL ZARKA 1932 6-1/2X52 JAL.', 'Zarka 1932', NULL, 0, NULL, NULL),
(585, 'CM-05249', 'CAJAS DE MADERA ROCKY PATEL ZARKA 1932 6-1/2X52 TORPEDO JAL.', 'Zarka 1932', NULL, 0, NULL, NULL),
(586, 'CM-05250', 'CAJAS DE MADERA ROCKY PATEL ZARKA 1932 6X60 JAL.', 'Zarka 1932', NULL, 0, NULL, NULL),
(587, 'CM-05267', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO HABANO BOX/20', 'The Edge Nicaragua', 7, -1911, NULL, NULL),
(588, 'CM-05268', 'CAJAS DE MADERA ROCKY PATEL  EDGE SIXTY BATTALION HABANO BOX/20', 'The Edge', 7, 7, NULL, NULL),
(589, 'CM-05269', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO HABANO TRAYS/100', 'The Edge Nicaragua', 18, -170, NULL, NULL),
(590, 'CM-05275', 'CAJAS DE MADERA ROCKY PATEL EDGE TRAYS', 'The Edge', NULL, 0, NULL, NULL),
(591, 'CM-05276', 'CAJAS DE MADERA ROCKY PATEL SMOKER FRIENDLY TRAYS TORO', 'Smoker Friendly', NULL, 0, NULL, NULL),
(592, 'CM-05277', 'CAJAS DE MADERA ROCKY PATEL DECADE TRAYS', 'Decada', NULL, 0, NULL, NULL),
(593, 'CM-05279', 'CAJAS DE MADERA ROCKY PATEL R.A.D. TORO BOX 20', 'R.A.D.', 7, 0, NULL, NULL),
(594, 'CM-05280', 'CAJAS DE MADERA ROCKY PATEL BLACK WARRIOR TORPEDO BOX 20', 'Black Warrior', 7, 0, NULL, NULL),
(595, 'CM-05281', 'CAJAS DE MADERA ROCKY PATEL BLACK WARRIOR ROBUSTO BOX 20', 'Black Warrior', 7, 0, NULL, NULL),
(596, 'CM-05310', 'CAJAS DE MADERA ROCKY PATEL LUXURY COLLECTION TORO SAMPLER BOX/10', 'VARIOS', 4, 22, NULL, NULL),
(597, 'CM-05311', 'CAJAS DE MADERA ROCKY PATEL MARQUETTE 77 TORPEDO PRESS BOX/20', 'Marquette 77', 7, 0, NULL, NULL),
(598, 'CM-05312', 'CAJAS DE MADERA ROCKY PATEL DOBLE CORONA MADURO DESIENA BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(599, 'CM-05313', 'CAJAS DE MADERA ROCKY PATEL SUPER TORO MADURO DESIENA BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(600, 'CM-05314', 'CAJAS DE MADERA ROCKY PATEL SHORT TORPEDO COROJO DESIENA BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(601, 'CM-05315', 'CAJAS DE MADERA ROCKY PATEL SHORT TORPEDO MADURO DESIENA BOX/20', 'Desiena 312', 7, 0, NULL, NULL),
(602, 'CM-05316', 'CAJAS DE MADERA ROCKY PATEL SHORT TORPEDO CONN DESIENA BOX/20', 'Desiena 312', 7, 10, NULL, NULL),
(603, 'CM-05319', 'CAJAS DE MADERA ROCKY PATEL B1 BURNERS TORO BOX/20', 'B1 Burners Private Label', 7, 0, NULL, NULL),
(604, 'CM-05320', 'CAJAS DE MADERA ROCKY PATEL B1 BURNERS ROBUSTO BOX/20', 'B1 Burners Private Label', 7, 0, NULL, NULL),
(605, 'CM-05333', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO HABANO BOX/100', 'The Edge', 18, 0, NULL, NULL),
(606, 'CM-05334', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO HABANO BOX/100', 'The Edge Nicaragua', 18, 3, NULL, NULL),
(607, 'CM-05335', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO COROJO BOX/100', 'The Edge', 18, 0, NULL, NULL),
(608, 'CM-05336', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1999 ROCKCHILDE CONERICO BOX/20', 'Vintage 1999', 7, 0, NULL, NULL),
(609, 'CM-05337', 'CAJAS DE MADERA ROCKY PATEL  SUNGROWN TRAY DELUXE TORO TUBE  SUMATRA BOX/50', 'Sungrown', 21, 0, NULL, NULL),
(610, 'CM-05338', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 2003 PERFECTO CAMEROON BOX/20', 'VINTAGE 2003', 7, 100, NULL, NULL),
(611, 'CM-05351', 'CAJAS DE MADERA ROCKY PATEL JAXX LT TORO BOX/20', 'Jaxx LT', 7, 0, NULL, NULL),
(612, 'CM-05352', 'CAJAS DE MADERA ROCKY PATEL JAXX LT ROBUSTO BOX/20', 'Jaxx LT', 7, 0, NULL, NULL),
(613, 'CM-05353', 'CAJAS DE MADERA ROCKY PATEL JAXX LT SIXTY BOX/20', 'Jaxx LT', 7, 0, NULL, NULL),
(614, 'CM-05356', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/30', 'The Edge', 19, -148, NULL, NULL),
(615, 'CM-05357', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/30', 'The Edge', 19, -140, NULL, NULL),
(616, 'CM-05359', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE ROBUSTO BOX/100', 'The Edge Connecticut', 18, 0, NULL, NULL),
(617, 'CM-05379', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 CHURCHILL TUBO SUMATRA BOX/10', 'Vintage 1992', 4, 0, NULL, NULL),
(618, 'CM-05400', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 TRAYS EMPTY', 'Vintage 1990', NULL, 0, NULL, NULL),
(619, 'CM-05402', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1992 TRAYS EMPTY', 'Vintage 1992', NULL, 0, NULL, NULL),
(620, 'CM-05403', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1999 TRAYS EMPTY', 'Vintage 1999', NULL, 0, NULL, NULL),
(621, 'CM-05421', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 ROCKCHILL RED. MADURO BOX/20', 'Vintage 1990', 7, 45, NULL, NULL),
(622, 'CM-05429', 'CAJAS DE MADERA ROCKY PATEL  EDGE COUNTERFEIT TORO COROJO BOX/20', 'The Edge', 7, 1, NULL, NULL),
(623, 'CM-05430', 'CAJAS DE MADERA ROCKY PATEL  EDGE COUNTERFEIT TORPEDO COROJO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(624, 'CM-05431', 'CAJAS DE MADERA ROCKY PATEL  EDGE COUNTERFEIT TORO MADURO BOX/20', 'The Edge', 7, 2, NULL, NULL),
(625, 'CM-05432', 'CAJAS DE MADERA ROCKY PATEL  EDGE COUNTERFEIT TORPEDO MADURO BOX/20', 'The Edge', 7, 0, NULL, NULL),
(626, 'CM-05458', 'CAJAS DE MADERA ROCKY PATEL B1 BURNERS CORONA BOX/20', 'B1 Burners Private Label', 7, 0, NULL, NULL),
(627, 'CM-05459', 'CAJAS DE MADERA ROCKY PATEL B1 BURNERS SIXTY BOX/20', 'B1 Burners Private Label', 7, 0, NULL, NULL),
(628, 'CM-05460', 'CAJAS DE MADERA ROCKY PATEL VIVALO ROBUSTO GRANDE BOX/20', 'Vivalo', 7, 0, NULL, NULL),
(629, 'CM-05461', 'CAJAS DE MADERA ROCKY PATEL VIVALO SIXTY BOX/20', 'Vivalo', 7, 0, NULL, NULL),
(630, 'CM-05466', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN TORO COROJO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(631, 'CM-05467', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN ROBUSTO COROJO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(632, 'CM-05468', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN TORO CONERICO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(633, 'CM-05469', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN ROBUSTO CONERICO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(634, 'CM-05470', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN CONERICO TORPEDO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(635, 'CM-05471', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN COROJO TORPEDO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(636, 'CM-05472', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN CONERICO GRANDE BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(637, 'CM-05473', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN COROJO GRANDE BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(638, 'CM-05478', 'CAJAS DE MADERA ROCKY PATEL VIVALO BELICOSO BOX/20', 'Vivalo', 7, 0, NULL, NULL),
(639, 'CM-05479', 'CAJAS DE MADERA ROCKY PATEL VIVALO ROBUSTO BOX/20', 'Vivalo', 7, 0, NULL, NULL),
(640, 'CM-05480', 'CAJAS DE MADERA RP NICARAGUAN BLEND TORO 6X52 HABANO BOX 20', 'Nicaragua Selection', 7, 201, NULL, NULL),
(641, 'CM-05481', 'CAJAS DE MADERA RP NICARAGUAN BLEND TORPEDO 6X52 HABANO BOX 20', 'Nicaragua Selection', 7, 100, NULL, NULL),
(642, 'CM-05482', 'CAJAS DE MADERA RP NICARAGUAN BLEND SIXTY 6X60 HABANO BOX 20', 'Nicaragua Selection', 7, 0, NULL, NULL),
(643, 'CM-05483', 'CAJAS DE MADERA ROCKY PATEL TAMPA BASEBALL BOX 10', 'Tampa Baseball', 4, 0, NULL, NULL),
(644, 'CM-05522', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO HABANO BOX/20', 'The Edge Nicaragua', 7, -67, NULL, NULL),
(645, 'CM-05524', 'CAJAS DE MADERA ROCKY PATEL  EMILIO SERIES TORPEDO SUMATRA BOX/20', 'Emilio  H Serie', 7, 0, NULL, NULL),
(646, 'CM-05528', 'CAJAS DE MADERA ROCKY PATEL  CUBAN CIGAR FACTORY ROJAS CORONA BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(647, 'CM-05529', 'CAJAS DE MADERA ROCKY PATEL  CUBAN BLEND LANCERO MADURO BOX/20', 'Cuban Blend', 7, 0, NULL, NULL),
(648, 'CM-05530', 'CAJAS DE MADERA ROCKY PATEL EVOLUTION EMPEROR MADURO BOX/20', 'Evolution', 7, 0, NULL, NULL),
(649, 'CM-05531', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. TORO CONERICO  BOX/20', 'Gold By RP', 7, 125, NULL, NULL),
(650, 'CM-05532', 'CAJAS DE MADERA ROCKY PATEL  EDGE HOWITZER COROJO BOX/10', 'The Edge', 4, -30, NULL, NULL),
(651, 'CM-05533', 'CAJAS DE MADERA ROCKY PATEL  EDGE HOWITZER MADURO BOX/10', 'The Edge', 4, -239, NULL, NULL),
(652, 'CM-05534', 'CAJAS DE MADERA ROCKY PATEL  LEESBURG TORO MADURO BOX/20', 'Leesburg', 7, 0, NULL, NULL),
(653, 'CM-05549', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE PETITE CORONA H-2000 BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(654, 'CM-05550', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE SIXTY H-2000 BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(655, 'CM-05551', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE TORO H-2000 BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(656, 'CM-05552', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE TORPEDO H-2000 BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(657, 'CM-05553', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE PETITE CORONA COROJO BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(658, 'CM-05554', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE SIXTY COROJO BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(659, 'CM-05555', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE TORO COROJO BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(660, 'CM-05556', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE TORPEDO COROJO BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(661, 'CM-05557', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE PETITE CORONA MADURO BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(662, 'CM-05558', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE SIXTY MADURO BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(663, 'CM-05559', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE TORO MADURO BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(664, 'CM-05560', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE TORPEDO MADURO BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(665, 'CM-05561', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE PETITE CORONA SUMATRA BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(666, 'CM-05562', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE SIXTY SUMATRA BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(667, 'CM-05563', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE TORO SUMATRA BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(668, 'CM-05564', 'CAJAS DE MADERA ROCKY PATEL MAN CAVE TORPEDO SUMATRA BOX/20', 'Man Cave', 7, 0, NULL, NULL),
(669, 'CM-05568', 'CAJAS DE MADERA ROCKY PATEL BLOCK ISLAND TORO BOX/10', 'Block Island', 4, 0, NULL, NULL),
(670, 'CM-05569', 'CAJAS DE MADERA ROCKY PATEL BLOCK ISLAND ROBUSTO BOX/10', 'Block Island', 4, 0, NULL, NULL),
(671, 'CM-05571', 'CAJAS DE MADERA ROCKY PATEL SMOKER FRIENDLY TRAYS SIXTY', 'Smoker Friendly', NULL, 0, NULL, NULL),
(672, 'CM-05578', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN CONERICO CHURCHILL BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(673, 'CM-05587', 'CAJAS DE MADERA ROCKY PATEL  ATTACHE 5X52 ROBUSTO BOX 20', 'Embassy', 7, 0, NULL, NULL),
(674, 'CM-05589', 'CAJAS DE MADERA ROCKY PATEL  ATTACHE 6X60 GRANDE BOX 20', 'Embassy', 7, 0, NULL, NULL),
(675, 'CM-05590', 'CAJAS DE MADERA ROCKY PATEL  ATTACHE 6X52 TORO BOX 20', 'Embassy', 7, 0, NULL, NULL),
(676, 'CM-05599', 'CAJAS DE MADERA ROCKY PATEL RP VELVET EDITION ROBUSTO CONNECTICUT BOX/20', 'Velvet', 7, 0, NULL, NULL),
(677, 'CM-05600', 'CAJAS DE MADERA ROCKY PATEL RP VELVET EDITION TORO CONNECTICUT BOX/20', 'Velvet', 7, 0, NULL, NULL),
(678, 'CM-05601', 'CAJAS DE MADERA ROCKY PATEL RP VELVET EDITION TORPEDO CONNECTICUT BOX/20', 'Velvet', 7, 0, NULL, NULL),
(679, 'CM-05602', 'CAJAS DE MADERA ROCKY PATEL RP VELVET EDITION SIXTY CONNECTICUT BOX/20', 'Velvet', 7, 0, NULL, NULL),
(680, 'CM-05622', 'CAJAS DE MADERA ROCKY PATEL HONDURAS SAMPLER', 'NINGUNA', NULL, 0, NULL, NULL),
(681, 'CM-05623', 'CAJAS DE MADERA ROCKY PATEL WALL STREET ROBUSTO BOX/20', 'Wall Street', 7, 0, NULL, NULL),
(682, 'CM-05624', 'CAJAS DE MADERA ROCKY PATEL WALL STREET TORO BOX/20', 'Wall Street', 7, 0, NULL, NULL),
(683, 'CM-05625', 'CAJAS DE MADERA ROCKY PATEL WALL STREET CHURCHILL BOX/20', 'Wall Street', 7, 0, NULL, NULL),
(684, 'CM-05626', 'CAJAS DE MADERA ROCKY PATEL WALL STREET SIXTY BOX/20', 'Wall Street', 7, 0, NULL, NULL),
(685, 'CM-05627', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO MADURO BOX/10 (Divisor Plastico)', 'The Edge', NULL, -20, NULL, NULL),
(686, 'CM-05638', 'CAJAS DE MADERA ROCKY PATEL CAUCUS 50TH ANNIVERSARY CORONA SUMATRA BOX/10', 'Caucus', 4, 0, NULL, NULL),
(687, 'CM-05639', 'CAJAS DE MADERA ROCKY PATEL CAUCUS 50TH ANNIVERSARY CHURCHILL SUMATRA BOX/10', 'Caucus', 4, 0, NULL, NULL),
(688, 'CM-05642', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET LANCERO CONERICO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(689, 'CM-05643', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET SIXTY CONERICO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(690, 'CM-05644', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET LANCERO SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(691, 'CM-05645', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET SIXTY SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(692, 'CM-05646', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM ROBUSTO RED. BOX/20', 'Davidus Antietam', 7, 0, NULL, NULL),
(693, 'CM-05647', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM CHURCHILL RED. BOX/20', 'Davidus Antietam', 7, 0, NULL, NULL),
(694, 'CM-05648', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM PIRAMID RED. BOX/20', 'Davidus Antietam', 7, 0, NULL, NULL),
(695, 'CM-05649', 'CAJAS DE MADERA ROCKY PATEL DAVIDUS ANTIETAM TORO RED. BOX/20', 'Davidus Antietam', 7, 0, NULL, NULL),
(696, 'CM-05650', 'CAJAS DE MADERA ROCKY PATEL BADGE 282 LANCERO BOX/10', 'Badge 282', 4, 50, NULL, NULL),
(697, 'CM-05651', 'CAJAS DE MADERA ROCKY PATEL DECADE IN COFFINS', 'Decada', NULL, 0, NULL, NULL),
(698, 'CM-05673', 'CAJAS DE MADERA ROCKY PATEL JUNIOR SUNGROWN NATURAL BOX/40', 'Junior Sungrown', NULL, 601, NULL, NULL),
(699, 'CM-05676', 'CAJAS DE MADERA ROCKY PATEL THE DON ROBUSTO BOX/20', 'The Don', 7, 0, NULL, NULL),
(700, 'CM-05677', 'CAJAS DE MADERA ROCKY PATEL THE DON CHURCHILL BOX/20', 'The Don', 7, 0, NULL, NULL),
(701, 'CM-05678', 'CAJAS DE MADERA ROCKY PATEL THE DON SIXTY BOX/20', 'The Don', 7, 0, NULL, NULL),
(702, 'CM-05679', 'CAJAS DE MADERA ROCKY PATEL THE DON TORO BOX/20', 'The Don', 7, 0, NULL, NULL),
(703, 'CM-05690', 'CAJAS DE MADERA ROCKY PATEL CASA DE LAS ESTRELLAS TORPEDO PRESS BOX/20', 'Casa de las Estrellas', 7, 0, NULL, NULL),
(704, 'CM-05691', 'CAJAS DE MADERA ROCKY PATEL CASA DE LAS ESTRELLAS LANCERO PRESS BOX/20', 'Casa de las Estrellas', 7, 0, NULL, NULL),
(705, 'CM-05692', 'CAJAS DE MADERA ROCKY PATEL CASA DE LAS ESTRELLAS TORO RED BOX/20', 'Casa de las Estrellas', 7, 0, NULL, NULL),
(706, 'CM-05717', 'CAJAS DE MADERA  ROCKY PATEL PREMIUM DISPLAY BURN BLANCOS', 'Burn', NULL, 0, NULL, NULL),
(707, 'CM-05751', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1992 ROBUSTO 5-1/2X50 TUBO SUMATRA BOX/10', 'Vintage 1992', 4, 120, NULL, NULL),
(708, 'CM-05752', 'CAJAS DE MADERA ROCKY PATEL  O.W.R. BARBER POLE  BOX/10', 'Old World Reserve', 4, 0, NULL, NULL),
(709, 'CM-05770', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD ROBUSTO REDONDO CONNECTICUT BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(710, 'CM-05771', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORO REDONDO CONNECTICUT BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(711, 'CM-05772', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORPEDO REDONDO CONNECTICUT BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(712, 'CM-05773', 'CAJAS DE MADERA ROCKY PATEL DECADE TORO PLYWOOD SUMATRA BOX/10', 'Decada', 4, 0, NULL, NULL),
(713, 'CM-05780', 'CAJAS DE MADERA ROCKY PATEL VIVALO SAMPLER BOX/5', 'Vivalo', 6, 0, NULL, NULL),
(714, 'CM-05790', 'CAJAS DE MADERA ROCKY PATEL THE  ZEUS BY HUMIDOR ROBUSTO MADURO BOX/20', 'Zeus by Humidour', 7, 20, NULL, NULL),
(715, 'CM-05791', 'CAJAS DE MADERA ROCKY PATEL THE  ZEUS BY HUMIDOR TORO MADURO BOX/20', 'Zeus by Humidour', 7, 20, NULL, NULL),
(716, 'CM-05792', 'CAJAS DE MADERA ROCKY PATEL THE ZEUS BY HUMIDOR LANCERO MADURO BOX/20', 'Zeus by Humidour', 7, 0, NULL, NULL),
(717, 'CM-05794', 'CAJAS DE MADERA ROCKY PATEL WORLD FAMOUS CIGAR BAR TORO GRANDE CONNECTICUT BOX/20', 'World Famous Cigar Bar', 7, 0, NULL, NULL),
(718, 'CM-05795', 'CAJAS DE MADERA ROCKY PATEL WORLD FAMOUS CIGAR BAR ROBUSTO CONNECTICUT BOX/20', 'World Famous Cigar Bar', 7, 0, NULL, NULL),
(719, 'CM-05798', 'CAJAS DE MADERA ROCKY PATEL  EDGE  A10 TORO  BOX/20', 'Edge 10th Anniversary', 7, 137, NULL, NULL),
(720, 'CM-05802', 'CAJAS DE MADERA ROCKY PATEL ROGER STROH TORO BOX/20', 'Roger Stroh', 7, 0, NULL, NULL),
(721, 'CM-05805', 'CAJAS DE MADERA ROCKY PATEL SIGNATURE SERIES TORO BOX 20', 'Signature', 7, 1, NULL, NULL),
(722, 'CM-05828', 'CAJAS DE MADERA ROCKY PATEL  EDGE SELECTION 652 MADURO BOX/50', 'The Edge', 21, 0, NULL, NULL),
(723, 'CM-05829', 'CAJAS DE MADERA ROCKY PATEL  EDGE SELECTION PYRAMID MADURO BOX/50', 'The Edge', 21, 0, NULL, NULL),
(724, 'CM-05830', 'CAJAS DE MADERA ROCKY PATEL  EDGE SELECTION 652 COROJO BOX/50', 'The Edge', 21, 0, NULL, NULL),
(725, 'CM-05831', 'CAJAS DE MADERA ROCKY PATEL  EDGE SELECTION PYRAMID COROJO BOX/50', 'The Edge', 21, 0, NULL, NULL),
(726, 'CM-05832', 'CAJAS DE MADERA ROCKY PATEL  EDGE SELECTION 652 HABANO BOX/50', 'The Edge', 21, 0, NULL, NULL),
(727, 'CM-05833', 'CAJAS DE MADERA ROCKY PATEL  EDGE SELECTION PYRAMID HABANO BOX/50', 'The Edge', 21, 3, NULL, NULL),
(728, 'CM-05859', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO HABANO BOX/20', 'The Edge Nicaragua', 7, 26, NULL, NULL),
(729, 'CM-05890', 'CAJAS DE MADERA ROCKY PATEL DISPLAY PARA PIPA', 'VARIOS', NULL, 0, NULL, NULL),
(730, 'CM-05906', 'CAJAS DE MADERA ROCKY PATEL YACHT CRUISE SAMPLER BOX 6', 'VARIOS', 5, 0, NULL, NULL),
(731, 'CM-05930', 'CAJAS DE MADERA ROCKY PATEL  CI LEGENDS ROBUSTO HAB/COL BOX/20 (NUEVAS)', 'CI Legend', NULL, 51, NULL, NULL),
(732, 'CM-05931', 'CAJAS DE MADERA ROCKY PATEL RP BROADLEAF TORO BOX 20', 'RP Broadleaf', 7, 6, NULL, NULL),
(733, 'CM-05932', 'CAJAS DE MADERA ROCKY PATEL RP BROADLEAF SUPER TORO BOX 20', 'RP Broadleaf', 7, 1, NULL, NULL),
(734, 'CM-05933', 'CAJAS DE MADERA ROCKY PATEL RP BROADLEAF TORPEDO 6-1/4X52 BOX 20', 'RP Broadleaf', 7, 192, NULL, NULL),
(735, 'CM-05934', 'CAJAS DE MADERA ROCKY PATEL RP BROADLEAF CHURCHILL BOX 20', 'RP Broadleaf', 7, 9, NULL, NULL),
(736, 'CM-05935', 'CAJAS DE MADERA ROCKY PATEL RP BROADLEAF ROBUSTO BOX 20', 'RP Broadleaf', 7, 4, NULL, NULL),
(737, 'CM-05972', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN CAMEROON ROBUSTO BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(738, 'CM-05973', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN TORO CAMEROON BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(739, 'CM-05974', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN CORONA CAMEROON BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(740, 'CM-05975', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN CAMEROON GRANDE BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(741, 'CM-05976', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 MADURO BOX/10', 'The Edge', 4, 0, NULL, NULL),
(742, 'CM-05977', 'CAJAS DE MADERA ROCKY PATEL  EDGE  A10 TORO TRAYS/100', 'Edge 10th Anniversary', 18, 0, NULL, NULL),
(743, 'CM-05978', 'CAJAS DE MADERA ROCKY PATEL CONNECTICUT BY SUPER TORO CONERICO BOX/20', 'Connecticut Rocky Patel', 7, 49, NULL, NULL),
(744, 'CM-05979', 'CAJAS DE MADERA ROCKY PATEL  EDGE SHORT ROBUSTO HABANO BOX/20', 'The Edge Nicaragua', 7, 4, NULL, NULL),
(745, 'CM-05980', 'CAJAS DE MADERA ROCKY PATEL WALL STREET CORONA BOX/20', 'Wall Street', 7, 9, NULL, NULL),
(746, 'CM-05981', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 COROJO BOX/10', 'The Edge', 4, 3, NULL, NULL),
(747, 'CM-05982', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORO VARIADO TRAYS/75', 'The Edge', 90, 0, NULL, NULL),
(748, 'CM-05983', 'CAJAS DE MADERA ROCKY PATEL DECADE ROBUSTO PLYWOOD SUMATRA BOX/5', 'Decada', 6, 0, NULL, NULL),
(749, 'CM-05984', 'CAJAS DE MADERA ROCKY PATEL RP ICE ROBUSTO BOX/10', 'RP Ice', 4, 0, NULL, NULL),
(750, 'CM-05985', 'CAJAS DE MADERA ROCKY PATEL RP ICE TORO BOX/10', 'RP Ice', 4, 0, NULL, NULL),
(751, 'CM-05986', 'CAJAS DE MADERA ROCKY PATEL RP ICE TORPEDO BOX/10', 'RP Ice', 4, 0, NULL, NULL),
(752, 'CM-05987', 'CAJAS DE MADERA ROCKY PATEL RP ICE GORDO BOX/10', 'RP Ice', 4, 0, NULL, NULL),
(753, 'CM-05988', 'CAJAS DE MADERA ROCKY PATEL CIGAR KING GOLD II TORO BOX/20 HAB.', 'Cigar King Gold II', NULL, 0, NULL, NULL),
(754, 'CM-06015', 'CAJAS DE MADERA ROCKY PATEL CGALLIII ROBUSTO BOX/20', 'Segaliii', 7, 0, NULL, NULL),
(755, 'CM-06016', 'CAJAS DE MADERA ROCKY PATEL CGALLIII TORO BOX/20', 'Segaliii', 7, 0, NULL, NULL),
(756, 'CM-06017', 'CAJAS DE MADERA ROCKY PATEL CGALLIII CHURCHILL BOX/20', 'Segaliii', 7, 0, NULL, NULL),
(757, 'CM-06018', 'CAJAS DE MADERA ROCKY PATEL BELLA CARMELLA DOUBLE CORONA BOX/20', 'Bella Camella', 7, 0, NULL, NULL),
(758, 'CM-06019', 'CAJAS DE MADERA ROCKY PATEL BELLA CARMELLA LONSDALE BOX/20', 'Bella Camella', 7, 6, NULL, NULL),
(759, 'CM-06020', 'CAJAS DE MADERA ROCKY PATEL BELLA CARMELLA TORO BOX/20', 'Bella Camella', 7, 1, NULL, NULL),
(760, 'CM-06021', 'CAJAS DE MADERA ROCKY PATEL BELLA CARMELLA ROBUSTO BOX/20', 'Bella Camella', 7, 0, NULL, NULL),
(761, 'CM-06022', 'CAJAS DE MADERA ROCKY PATEL BELLA CARMELLA GRANDE BOX/20', 'Bella Camella', 7, 0, NULL, NULL),
(762, 'CM-06023', 'CAJAS DE MADERA ROCKY PATEL BELLA CARMELLA CORONA BOX/20', 'Bella Camella', 7, 1, NULL, NULL),
(763, 'CM-06108', 'CAJAS DE MADERA ROCKY PATEL STRADA CHURCHILL 7X48 BOX/20', 'RP Strada', 7, 0, NULL, NULL),
(764, 'CM-06109', 'CAJAS DE MADERA ROCKY PATEL STRADA TORPEDO 6X52 BOX/20', 'RP Strada', 7, 0, NULL, NULL),
(765, 'CM-06110', 'CAJAS DE MADERA ROCKY PATEL STRADA CHURCHILL 7X50 BOX/20', 'RP Strada', 7, 0, NULL, NULL),
(766, 'CM-06111', 'CAJAS DE MADERA ROCKY PATEL STRADA ROBUSTO 5X50 BOX/20', 'RP Strada', 7, 0, NULL, NULL),
(767, 'CM-06112', 'CAJAS DE MADERA ROCKY PATEL STRADA TORO 6X52 BOX/20', 'RP Strada', 7, 0, NULL, NULL),
(768, 'CM-06113', 'CAJAS DE MADERA ROCKY PATEL STRADA TORO 6X50 BOX/20', 'RP Strada', 7, 0, NULL, NULL),
(769, 'CM-06214', 'CAJAS DE MADERA ROCKY PATEL  EDGE  A10 SIXTY  BOX/20', 'Edge 10th Anniversary', 7, -368, NULL, NULL),
(770, 'CM-06215', 'CAJAS DE MADERA ROCKY PATEL LA SIRENA ROBUSTO BOX/20', 'La Sirena', 7, 10, NULL, NULL),
(771, 'CM-06216', 'CAJAS DE MADERA ROCKY PATEL LA SIRENA TORO BOX/20', 'La Sirena', 7, 10, NULL, NULL),
(772, 'CM-06217', 'CAJAS DE MADERA ROCKY PATEL LA SIRENA SIXTY BOX/20', 'La Sirena', 7, 10, NULL, NULL),
(773, 'CM-06450', 'CAJAS DE MADERA ROCKY PATEL  DARK DOMINION SHORT ROBUSTO BOX 10', 'Dark Dominion', 4, 0, NULL, NULL),
(774, 'CM-06451', 'CAJAS DE MADERA ROCKY PATEL  DARK DOMINION TORO BOX 10', 'Dark Dominion', 4, 0, NULL, NULL),
(775, 'CM-06452', 'CAJAS DE MADERA ROCKY PATEL  DARK DOMINION SIXTY BOX 10', 'Dark Dominion', 4, 2, NULL, NULL),
(776, 'CM-06453', 'CAJAS DE MADERA ROCKY PATEL  DARK DOMINION LANCERO BOX 10', 'Dark Dominion', 4, 1, NULL, NULL),
(777, 'CM-06454', 'CAJAS DE MADERA ROCKY PATEL  SUNGROWN SHORT TORPEDO SUMATRA BOX/20', 'Sungrown', 7, 0, NULL, NULL),
(778, 'CM-06457', 'CAJAS DE MADERA ROCKY PATEL  MUESTRAS VARIADAS', 'Muestras', NULL, 0, NULL, NULL),
(779, 'CM-06458', 'CAJAS DE MADERA ROCKY PATEL EDGE LITE HOWITZER CONN BOX/10', 'The Edge Connecticut', 4, -60, NULL, NULL),
(780, 'CM-06702', 'CAJAS DE MADERA ROCKY PATEL  VIBE TORPEDO HAB/COL BOX/20', 'Vibe', 7, 0, NULL, NULL),
(781, 'CM-06763', 'CAJAS DE MADERA ROCKY PATEL DUCKS UNLIMITED GREEN HEAD TORO BOX 20', 'Daniel Marshall', 7, 0, NULL, NULL),
(782, 'CM-06765', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. TORPEDO CONERICO  BOX/20', 'Gold By RP', 7, 0, NULL, NULL),
(783, 'CM-06766', 'CAJAS DE MADERA ROCKY PATEL  EDGE MISSILES MADURO BOX/16', 'The Edge', 26, 20, NULL, NULL),
(784, 'CM-06767', 'CAJAS DE MADERA ROCKY PATEL  EDGE MISSILES COROJO BOX/16', 'The Edge', 26, 160, NULL, NULL),
(785, 'CM-06793', 'CAJAS DE MADERA ROCKY PATEL RP FIRE & ICE ROBUSTO SAMPLER BOX 10', 'VARIOS', 4, 0, NULL, NULL),
(786, 'CM-06794', 'CAJAS DE MADERA ROCKY PATEL SIGNATURE SERIES ROBUSTO BOX 20', 'Signature', 7, 0, NULL, NULL),
(787, 'CM-06814', 'CAJAS DE MADERA ROCKY PATEL DECADE TORO ESPECIAL CI20TH SUMATRA BOX/10', 'Decada', 4, 0, NULL, NULL),
(788, 'CM-06815', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 2003 5X60 CAMEROON BOX/20', 'VINTAGE 2003', 7, 0, NULL, NULL),
(789, 'CM-06816', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 2003 4X60 CAMEROON BOX/20', 'VINTAGE 2003', 7, 0, NULL, NULL),
(790, 'CM-06818', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS ROBUSTO MADURO BOX/20', 'Jon Carlos', 7, 9, NULL, NULL),
(791, 'CM-06819', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS ROBUSTO CONN BOX/20', 'Jon Carlos', 7, 11, NULL, NULL),
(792, 'CM-06820', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS CHURCHILL CONN BOX/20', 'Jon Carlos', 7, 10, NULL, NULL),
(793, 'CM-06821', 'CAJAS DE MADERA ROCKY PATEL RP BROADLEAF TORPEDO 6-1/8X52 BOX 20', 'RP Broadleaf', 7, 0, NULL, NULL),
(794, 'CM-06822', 'CAJAS DE MADERA ROCKY PATEL RP/HOLT CARPET COLLECTION SAMPLER BOX 20', 'VARIOS', 7, 1, NULL, NULL),
(795, 'CM-06823', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS TORPEDO CONN BOX/20', 'Jon Carlos', 7, 10, NULL, NULL),
(796, 'CM-06824', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS CHURCHILL MADURO BOX/20', 'Jon Carlos', 7, 10, NULL, NULL),
(797, 'CM-06825', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS TORPEDO MADURO BOX/20', 'Jon Carlos', 7, 10, NULL, NULL),
(798, 'CM-06826', 'CAJAS DE MADERA ROCKY PATEL CRI-OJO ROBUSTO HAB. BOX 20', 'The Edge Connecticut', 7, 0, NULL, NULL),
(799, 'CM-06827', 'CAJAS DE MADERA ROCKY PATEL CRI-OJO TORO HAB. BOX 20', 'Crio-ojo By RP', 7, 1, NULL, NULL),
(800, 'CM-06828', 'CAJAS DE MADERA ROCKY PATEL INKTOME TORO HAB. BOX 10 PRENSADO', 'The Edge Connecticut', NULL, 0, NULL, NULL),
(801, 'CM-06829', 'CAJAS DE MADERA ROCKY PATEL CRI-OJO SUPER TORO HAB. BOX 20', 'The Edge Connecticut', 7, 0, NULL, NULL),
(802, 'CM-06830', 'CAJAS DE MADERA ROCKY PATEL CRI-OJO TORPEDO HAB. BOX 20', 'The Edge Connecticut', 7, 1, NULL, NULL),
(803, 'CM-06831', 'CAJAS DE MADERA ROCKY PATEL CRI-OJO CHURCHILL HAB. BOX 20', 'The Edge Connecticut', 7, 0, NULL, NULL),
(804, 'CM-06832', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1999 ROBUSTO 5-1/2X50 TUBO CONERICO BOX/10', 'Vintage 1999', 4, 0, NULL, NULL),
(805, 'CM-06833', 'CAJAS DE MADERA ROCKY PATEL CIGAR KING GOLD II LANCERO BOX/20 HAB.', 'Cigar King Gold II', NULL, 0, NULL, NULL),
(806, 'CM-06834', 'CAJAS DE MADERA ROCKY PATEL CIGAR KING GOLD II ROBUSTO BOX/20 HAB.', 'Cigar King Gold II', NULL, 0, NULL, NULL),
(807, 'CM-06835', 'CAJAS DE MADERA ROCKY PATEL CIGAR KING GOLD II SIXTY BOX/20 HAB.', 'Cigar King Gold II', NULL, 0, NULL, NULL),
(808, 'CM-06836', 'CAJAS DE MADERA ROCKY PATEL DUCKS UNLIMITED DUCK SHOT BOX 20', 'Daniel Marshall', 7, 0, NULL, NULL),
(809, 'CM-06837', 'CAJAS DE MADERA ROCKY PATEL CI- ANNIVERSARY TORO BOX 20', 'Ci - Anniversary', 7, 0, NULL, NULL),
(810, 'CM-06838', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO BOX/50 SUMATRA', 'The Edge', NULL, 0, NULL, NULL),
(811, 'CM-06839', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO BOX/50 COROJO', 'The Edge', NULL, 0, NULL, NULL),
(812, 'CM-06840', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO BOX/50 MADURO', 'The Edge', NULL, 0, NULL, NULL),
(813, 'CM-06841', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO BOX/50 HABANO', 'The Edge Nicaragua', NULL, 0, NULL, NULL),
(814, 'CM-06842', 'CAJAS DE MADERA ROCKY PATEL EDGE TORPEDO BOX/50 SUMATRA', 'The Edge', NULL, 0, NULL, NULL),
(815, 'CM-06843', 'CAJAS DE MADERA ROCKY PATEL EDGE TORPEDO BOX/50 COROJO', 'The Edge', NULL, 0, NULL, NULL),
(816, 'CM-06844', 'CAJAS DE MADERA ROCKY PATEL EDGE TORPEDO BOX/50 MADURO', 'The Edge', NULL, 0, NULL, NULL),
(817, 'CM-06845', 'CAJAS DE MADERA ROCKY PATEL EDGE TORPEDO BOX/50 HABANO', 'The Edge', NULL, 0, NULL, NULL),
(818, 'CM-06846', 'CAJAS DE MADERA ROCKY PATEL MARTINIQUE TORO BOX 10', 'Martinique TAA By RP', 4, 0, NULL, NULL),
(819, 'CM-06847', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1990 LANCERO HABANO BOX/20', 'Vintage 1990', 7, 25, NULL, NULL),
(820, 'CM-06848', 'CAJAS DE MADERA ROCKY PATEL  EXTREME TORPEDO SUMATRA BOX/20', 'Extreme', 7, 5, NULL, NULL),
(821, 'CM-06849', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BRONZE GORDO BOX/20', 'La Palina Bronze Label', 7, 0, NULL, NULL),
(822, 'CM-06850', 'CAJAS DE MADERA SOTO CANO TORO CONN BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(823, 'CM-06851', 'CAJAS DE MADERA SOTO CANO TORO HAB BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(824, 'CM-06852', 'CAJAS DE MADERA SOTO CANO TORO COR. BOX 20', 'NINGUNA', 7, 0, NULL, NULL),
(825, 'CM-06853', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS ROBUSTO COROJO BOX/20', 'Jon Carlos', 7, 0, NULL, NULL),
(826, 'CM-06854', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS CHURCHILL COROJO BOX/20', 'Jon Carlos', 7, 0, NULL, NULL),
(827, 'CM-06855', 'CAJAS DE MADERA ROCKY PATEL JON CARLOS TORPEDO COROJO BOX/20', 'Jon Carlos', 7, 0, NULL, NULL),
(828, 'CM-06856', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORO PRESS COROJO BOX/20', 'Old World Reserve', 7, 34, NULL, NULL),
(829, 'CM-06857', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD ROBUSTO PRESS COROJO BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(830, 'CM-06858', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD SIXTY ROUND COROJO BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(831, 'CM-06859', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORO PRESS MADURO BOX/20', 'Old World Reserve', 7, 1, NULL, NULL),
(832, 'CM-06860', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD ROBUSTO PRESS MADURO BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(833, 'CM-06861', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD TORPEDO PRESS MADURO BOX/20', 'Old World Reserve', 7, 0, NULL, NULL),
(834, 'CM-06862', 'CAJAS DE MADERA ROCKY PATEL EDGE BATTALION HABANO BOX/20', 'The Edge Nicaragua', 7, 74, NULL, NULL),
(835, 'CM-06863', 'CAJAS DE MADERA ROCKY PATEL  EDGE BATTALION COROJO BOX20', 'The Edge', 7, -181, NULL, NULL),
(836, 'CM-06864', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BRONZE TORO BOX/20', 'La Palina Bronze Label', 7, -349, NULL, NULL),
(837, 'CM-06865', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BRONZE ROBUSTO HABANO BOX/20', 'La Palina Bronze Label', 7, 5, NULL, NULL),
(838, 'CM-06866', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD RESERVE ROBUSTO PRESS COROJO NUEVO BOX 20', 'Old World Reserve', 7, 1, NULL, NULL),
(839, 'CM-06867', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD RESERVE TORO PRESS COROJO NUEVO BOX 20', 'Old World Reserve', 7, 50, NULL, NULL),
(840, 'CM-06868', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD RESERVE TORO PRESS COROJO LISA BOX 20', 'Old World Reserve', 7, 0, NULL, NULL),
(841, 'CM-06869', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BLUE LABEL TORO BOX/20', 'La Palina Blue Label', 7, 402, NULL, NULL),
(842, 'CM-06870', 'CAJAS DE MADERA ROCKY PATEL EDGE 652 TORO BOX/50 HABANO', 'The Edge Nicaragua', NULL, 0, NULL, NULL),
(843, 'CM-06871', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BRONZE SHORT ROBUSTO BOX/20', 'La Palina Bronze Label', 7, 120, NULL, NULL),
(844, 'CM-06872', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE TORO PRESS COROJO BOX/20', 'Edge Square', 7, 0, NULL, NULL),
(845, 'CM-06873', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE TORPEDO PRESS  COROJO BOX/20', 'Edge Square', 7, 0, NULL, NULL),
(846, 'CM-06874', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE ROBUSTO PRESS MADURO BOX/20', 'Edge Square', 7, 20, NULL, NULL),
(847, 'CM-06875', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE TORO PRESS MADURO BOX/20', 'Edge Square', 7, 44, NULL, NULL),
(848, 'CM-06876', 'CAJAS DE MADERA ROCKY PATEL  EDGE SQUARE TORPEDO PRESS MADURO BOX/20', 'Edge Square', 7, 1, NULL, NULL),
(849, 'CM-06877', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD RESERVE TORO ROUN CONECTICUT BOX 20', 'Old World Reserve', 7, 0, NULL, NULL),
(850, 'CM-06878', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD RESERVE TORO ROUND MADURO BOX 20', 'Old World Reserve', 7, 0, NULL, NULL),
(851, 'CM-06879', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD RESERVE SIXTI PRESS COROJO NUEVO BOX 20', 'Old World Reserve', 7, 3, NULL, NULL),
(852, 'CM-06880', 'CAJAS DE MADERA ROCKY PATEL CAUCUS MINI BELICOSO SUMATRA BOX/20', 'Caucus', 7, 0, NULL, NULL),
(853, 'CM-06882', 'CAJAS DE MADERA ROCKY PATEL PREMIUM  MUESTRAS TORO COLOR NATURAL BOX20', 'Muestras', 7, 0, NULL, NULL),
(854, 'CM-06883', 'CAJAS DE MADERA ROCKY PATEL PREMIUM  MUESTRAS TORO COLOR CAFE BOX20', 'Muestras', 7, 0, NULL, NULL);
INSERT INTO `lista_cajas` (`id`, `codigo`, `productoServicio`, `marca`, `tipo_empaque`, `existencia`, `created_at`, `updated_at`) VALUES
(855, 'CM-06884', 'CAJAS DE MADERA ROCKY PATEL PREMIUM  MUESTRAS TORO COLOR NEGRO BRILLANTE BOX20', 'Muestras', 7, 0, NULL, NULL),
(856, 'CM-06885', 'CAJAS DE MADERA ROCKY PATEL PREMIUM  MUESTRAS TORO COLOR ROJO  BRILLANTE  BOX20', 'Muestras', 7, 0, NULL, NULL),
(857, 'CM-06886', 'CAJAS DE MADERA ROCKY PATEL  ITC ESMERALDA TORO CANDELA BOX/20', 'ITC Emerald', 7, 5, NULL, NULL),
(858, 'CM-06887', 'CAJAS DE MADERA ROCKY PATEL OLD WORLD RESERVE ROBUSTO REDONDO CONN BOX 20', 'Old World Reserve', 7, 0, NULL, NULL),
(859, 'CM-06888', 'CAJAS DE MADERA ROCKY PATEL PREMIUN FILTHY VIKING  TORO HABA-2000 BOX/20', 'Filthy Vilking', 7, 0, NULL, NULL),
(860, 'CM-06889', 'CAJAS DE MADERA  ROCKY PATEL PREMIUM VICTORY CIGARS TORO PRESS SUMATRA BOX-10', 'Victory', 4, 0, NULL, NULL),
(861, 'CM-06890', 'CAJAS DE MADERA  ROCKY PATEL PREMIUM VICTORY CIGARS TORO PRESS SUMATRA BOX-100', 'Victory', 18, 1, NULL, NULL),
(862, 'CM-06891', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO GLAS TUBO COROJO BOX/10', 'The Edge', 4, 123, NULL, NULL),
(863, 'CM-06892', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE TRAYS 2018 VARIADO BOX100', 'Vintage 1990', 18, 0, NULL, NULL),
(864, 'CM-06893', 'CAJAS DE MADERA ROCKY PATEL  EDGE ROBUSTO GLAS TUBO MADURO BOX/10', 'The Edge', 4, 104, NULL, NULL),
(865, 'CM-06894', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY LIMITED RESERVE ROBUSTO MADURO BOX 20', 'Shockoe Valley', 7, 80, NULL, NULL),
(866, 'CM-06895', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY LIMITED RESERVE TORPEDO MADURO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(867, 'CM-06896', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY LIMITED RESERVE TORO MADURO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(868, 'CM-06897', 'CAJAS DE MADERA ROCKY PATEL THE FOUNDER SIXTY (GORDO) CONN BOX/20', 'The Founder', 7, 0, NULL, NULL),
(869, 'CM-06898', 'CAJAS DE MADERA ROCKY PATEL THE FOUNDER ROBUSTO CONN BOX/20', 'The Founder', 7, 0, NULL, NULL),
(870, 'CM-06899', 'CAJAS DE MADERA ROCKY PATEL THE FOUNDER TORO CONN BOX/20', 'The Founder', 7, 0, NULL, NULL),
(871, 'CM-06900', 'CAJAS DE MADERA ROCKY PATEL THE FOUNDER ROBUSTO PRESS MADURO BOX/20', 'The Founder', 7, 0, NULL, NULL),
(872, 'CM-06901', 'CAJAS DE MADERA ROCKY PATEL THE FOUNDER TORO PRESS MADURO BOX/20', 'The Founder', 7, 0, NULL, NULL),
(873, 'CM-06902', 'CAJAS DE MADERA ROCKY PATEL THE FOUNDER GORDO PRESS MADURO BOX/20', 'The Founder', 7, 0, NULL, NULL),
(874, 'CM-06903', 'CAJAS DE MADERA ROCKY PATEL  NICK CIGAR 10 ANIVERSARIO BOX/20', 'Nick`s Perdomo', 7, 0, NULL, NULL),
(875, 'CM-06904', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET ROBUSTO BASS GUITAR MADURO BOX/20', 'Bealle Street', 7, 1, NULL, NULL),
(876, 'CM-06905', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORO BASS GUITAR MADURO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(877, 'CM-06906', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET SIXTY BASS GUITAR MADURO BOX/20', 'Bealle Street', 7, 20, NULL, NULL),
(878, 'CM-06907', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORPEDO BASS GUITAR MADURO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(879, 'CM-06908', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BLUE LABEL GORDO HABANO BOX/20', 'La Palina Blue Label', 7, 1, NULL, NULL),
(880, 'CM-06909', 'CAJAS DE MADERA ROCKY PATEL  VINTAGE 1999 SHORT ROBUSTO CONERICO BOX/20', 'Vintage 1999', 7, 27, NULL, NULL),
(881, 'CM-06910', 'CAJAS DE MADERA ROCKY PATEL  EDGE GRAN ROBUSTO COROJO BOX/20', 'The Edge', 7, 1000, NULL, NULL),
(882, 'CM-06911', 'CAJAS DE MADERA ROCKY PATEL PREMIUN FILTHY VIKING  ROBUSTO HABA-2000 BOX/20', 'Filthy Vilking', 7, 0, NULL, NULL),
(883, 'CM-06912', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 1990 BELICOSO RED MADURO BOX/20', 'Vintage 1990', 7, 0, NULL, NULL),
(884, 'CM-06913', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION TORO COROJO BOX/20', 'The Collection Fuma', 7, 150, NULL, NULL),
(885, 'CM-06914', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION TORO CONNECTICUT BOX/20', 'The Collection Fuma', 7, 201, NULL, NULL),
(886, 'CM-06915', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION TORO MADURO BOX/20', 'The Collection Fuma', 7, 51, NULL, NULL),
(887, 'CM-06916', 'CAJAS DE MADERA ROCKY PATEL  OREASIS TORO SUMATRA BOX/10', 'Oreasis', 4, 25, NULL, NULL),
(888, 'CM-06917', 'CAJAS DE MADERA ROCKY PATEL  OREASIS GORDO SUMATRA BOX/10', 'Oreasis', 4, 11, NULL, NULL),
(889, 'CM-06918', 'CAJAS DE MADERA ROCKY PATEL  OREASIS CHURCHILL SUMATRA BOX/10', 'Oreasis', 4, 0, NULL, NULL),
(890, 'CM-06919', 'CAJAS DE MADERA ROCKY PATEL THE BACKSTOPPERS TORO HABANO BOX/10', 'Backstoppers', 4, 0, NULL, NULL),
(891, 'CM-06920', 'CAJAS DE MADERA ROCKY PATEL STEEL CITY TORO CONNECTICUT BOX 20', 'Steel City', 7, 0, NULL, NULL),
(892, 'CM-06921', 'CAJAS DE MADERA ROCKY PATEL STEEL CITY GRANDE CONNECTICUT BOX 20', 'Steel City', 7, 0, NULL, NULL),
(893, 'CM-06922', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE CONN ROBUSTO BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(894, 'CM-06923', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE CONN TORO BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(895, 'CM-06924', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE CONN CHURCHILL BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(896, 'CM-06925', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE HAB.OSCURO ROBUSTO BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(897, 'CM-06926', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE HAB.OSCURO TORO BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(898, 'CM-06927', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE HAB.OSCURO CHURCHILL  BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(899, 'CM-06928', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE HAB. ROBUSTO BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(900, 'CM-06929', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE HAB TORO BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(901, 'CM-06930', 'CAJAS DE MADERA ROCKY PATEL LA PALINA REGAL RESERVE HAB. CHURCHILL BOX/20', 'La Palina Regal Reserve', 7, 0, NULL, NULL),
(902, 'CM-06932', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. ROBUSTO MADURO  BOX/20', 'Gold By RP', 7, 1, NULL, NULL),
(903, 'CM-06933', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET ROBUSTO LEAD GUITAR CONNECTICUT BOX/20', 'Bealle Street', 7, 20, NULL, NULL),
(904, 'CM-06934', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET SIXTY LEAD GUITAR CONNECTICUT BOX/20', 'Bealle Street', 7, 24, NULL, NULL),
(905, 'CM-06936', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORO LEAD GUITAR CONNECTICUT BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(906, 'CM-06937', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORPEDO LEAD GUITAR CONNECTICUT BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(907, 'CM-06938', 'CAJAS DE MADERA ROCKY PATEL DECADE TORO PRENSADO SUMATRA BOX/10', 'Decada', 4, 0, NULL, NULL),
(908, 'CM-06939', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET LANCERO BASS GUITAR MADURO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(909, 'CM-06940', 'CAJAS DE MADERA ROCKY PATEL  UNION SQUARE TORO PRESS HABANO BOX/20', 'Union Square', 7, 0, NULL, NULL),
(910, 'CM-06941', 'CAJAS DE MADERA ROCKY PATEL LB1 CORONA HABANO BOX/20', 'RP LB1', 7, 25, NULL, NULL),
(911, 'CM-06942', 'CAJAS DE MADERA ROCKY PATEL LB1 ROBUSTO HABANO BOX/20', 'RP LB1', 7, 6, NULL, NULL),
(912, 'CM-06943', 'CAJAS DE MADERA ROCKY PATEL LB1 TORO HABANO BOX/20', 'RP LB1', 7, -75, NULL, NULL),
(913, 'CM-06944', 'CAJAS DE MADERA ROCKY PATEL LB1 SIXTY HABANO BOX/20', 'RP LB1', 7, -140, NULL, NULL),
(914, 'CM-06945', 'CAJAS DE MADERA ROCKY PATEL LB1 CHURCHILL SHAGGY HABANO BOX/20', 'RP LB1', 7, 0, NULL, NULL),
(915, 'CM-06946', 'CAJAS DE MADERA ROCKY PATEL  EMBASSY ROBUSTO  BOX/20', 'Embassy', 7, 0, NULL, NULL),
(916, 'CM-06947', 'CAJAS DE MADERA ROCKY PATEL  EMBASSY TORO BOX/20', 'Embassy', 7, 0, NULL, NULL),
(917, 'CM-06948', 'CAJAS DE MADERA ROCKY PATEL EMBASSY GRANDE  BOX/20', 'Embassy', 7, 0, NULL, NULL),
(918, 'CM-06949', 'CAJAS DE MADERA ROCKY PATEL DECADE TORO TUBO PLYWOOD SUMATRA BOX/50', 'Decada', 21, 0, NULL, NULL),
(919, 'CM-06950', 'CAJAS DE MADERA ROCKY PATEL GOLD BY R.P. CHURCHILL MADURO BOX/20', 'Gold By RP', 7, 0, NULL, NULL),
(920, 'CM-06951', 'CAJAS DE MADERA ROCKY PATEL TRAYS JML GRANDE VARIADO BOX/100', 'VARIOS', 18, 0, NULL, NULL),
(921, 'CM-06952', 'CAJAS DE MADERA ROCKY PATEL TRAYS JML MEDIANO VARIADO BOX50', 'VARIOS', 21, 0, NULL, NULL),
(922, 'CM-06953', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. BELICOSO MADURO BOX/20', 'Gold By RP', 7, 1, NULL, NULL),
(923, 'CM-06954', 'CAJAS DE MADERA ROCKY PATEL  GOLD BY R.P. TORO MADURO BOX/20', 'Gold By RP', 7, 17, NULL, NULL),
(924, 'CM-06955', 'CAJAS DE MADERA ROCKY PATEL  ORETOBERFEST GORDO HABANO BOX/10', 'Oretoberfest', 4, 16, NULL, NULL),
(925, 'CM-06956', 'CAJAS DE MADERA ROCKY PATEL  ORETOBERFEST GORDO CONNECTICUT BOX/10', 'Oretoberfest', 4, 0, NULL, NULL),
(926, 'CM-06957', 'CAJAS DE MADERA ROCKY PATEL WINDY CITY 5-1/2X50 ROBUSTO CONECTICUT BOX20', 'Windy City', 7, 0, NULL, NULL),
(927, 'CM-06958', 'CAJAS DE MADERA ROCKY PATEL  EDGE COUNTERFEIT TORO HABANO BOX/20', 'The Edge', 7, 1, NULL, NULL),
(928, 'CM-06959', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET LANCERO LEAD GUITAR CONECTICUT BOX/20', 'Bealle Street', 7, 1, NULL, NULL),
(929, 'CM-06960', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY COSTARICA CORONA  MADURO BOX 20', 'Shockoe Valley', 7, 40, NULL, NULL),
(930, 'CM-06961', 'CAJAS DE MADERA ROCKY PATEL PHARAOH TORO MADURO 6X52 BOX/20', 'NINGUNA', 7, 34, NULL, NULL),
(931, 'CM-06962', 'CAJAS DE MADERA ROCKY PATEL PHARAOH ROBUSTO MADURO  BOX/20', 'NINGUNA', 7, 41, NULL, NULL),
(932, 'CM-06963', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION PETIT CORONA COROJO BOX/20', 'The Collection Fuma', 7, 1, NULL, NULL),
(933, 'CM-06964', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION GRANDE COROJO BOX/20', 'The Collection Fuma', 7, 50, NULL, NULL),
(934, 'CM-06965', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION PETIT CORONA CONN BOX/20', 'The Collection Fuma', 7, 0, NULL, NULL),
(935, 'CM-06966', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION GRANDE CONN BOX/20', 'The Collection Fuma', 7, 72, NULL, NULL),
(936, 'CM-06967', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION PETIT CORONA MADURO BOX/20', 'The Collection Fuma', 7, 0, NULL, NULL),
(937, 'CM-06968', 'CAJAS DE MADERA ROCKY PATEL THE COLLECTION GRANDE MADURO BOX/20', 'The Collection Fuma', 7, 52, NULL, NULL),
(938, 'CM-06969', 'CAJAS DE MADERA ROCKY PATEL THE FOUNDER LIMITED PERFECTO CONN BOX/20', 'The Founder', 7, 0, NULL, NULL),
(939, 'CM-06970', 'CAJAS DE MADERA ROCKY PATEL SCREAMING ROBUSTO CONECTICUT BOX/20', 'Screaming Eagle', 7, 0, NULL, NULL),
(940, 'CM-06972', 'CAJAS DE MADERA ROCKY PATEL EDGE  A10 ROBUSTO BOX/20', 'Edge 10th Anniversary', 7, 34, NULL, NULL),
(941, 'CM-06973', 'CAJAS DE MADERA ROCKY PATEL  EXTREME SIXTY SUMATRA BOX/20', 'Extreme', 7, 0, NULL, NULL),
(942, 'CM-06974', 'CAJAS DE MADERA ROCKY PATEL EDGE 4-1/2X60 B52 CONNECTICUT BOX/30', 'The Edge Connecticut', 19, 1, NULL, NULL),
(943, 'CM-06975', 'CAJAS DE MADERA ROCKY PATEL LA PALINA LP LINE #2 PETITE CORONA  BOX 20', 'La Palina LP Line 2', 7, 0, NULL, NULL),
(944, 'CM-06976', 'CAJAS DE MADERA ROCKY PATEL LA PALINA LP LINE #2 GORDO BOX 20', 'La Palina LP Line 2', 7, 0, NULL, NULL),
(945, 'CM-06977', 'CAJAS DE MADERA ROCKY PATEL LA PALINA LP LINE #2 ROBUSTO BOX 20', 'La Palina LP Line 2', 7, 0, NULL, NULL),
(946, 'CM-06978', 'CAJAS DE MADERA ROCKY PATEL LA PALINA LP LINE #2 TORO  BOX 20', 'La Palina LP Line 2', 7, 0, NULL, NULL),
(947, 'CM-06979', 'CAJAS DE MADERA ROCKY PATEL LA PALINA LP LINE #1 PETITE CORONA  BOX 20', 'La Palina LP Line 1', 7, 0, NULL, NULL),
(948, 'CM-06980', 'CAJAS DE MADERA ROCKY PATEL LA PALINA LP LINE #1 GORDO BOX 20', 'La Palina LP Line 1', 7, 5, NULL, NULL),
(949, 'CM-06981', 'CAJAS DE MADERA ROCKY PATEL LA PALINA LP LINE #1 ROBUSTO BOX 20', 'La Palina LP Line 1', 7, 0, NULL, NULL),
(950, 'CM-06982', 'CAJAS DE MADERA ROCKY PATEL LA PALINA LP LINE #1 TORO BOX 20', 'La Palina LP Line 1', 7, 0, NULL, NULL),
(951, 'CM-06983', 'CAJAS DE MADERA ROCKY PATEL BELLA CARMELLA TORPEDO BOX/20', 'Bella Camella', 7, 0, NULL, NULL),
(952, 'CM-06984', 'CAJAS DE MADERA ROCKY PATEL CAJAS VARIADAS', 'VARIOS', NULL, 0, NULL, NULL),
(953, 'CM-06985', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY ROBUSTO HABANO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(954, 'CM-06986', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY CORONA HABANO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(955, 'CM-06987', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY TORO HABANO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(956, 'CM-06988', 'CAJAS DE MADERA ROCKY PATEL BLOOD-LINE RED GIGANTE BOX 20', 'Blood-Line Red Head', 7, 0, NULL, NULL),
(957, 'CM-06989', 'CAJAS DE MADERA ROCKY PATEL BLOOD-LINE RED ROBUSTO BOX 20', 'Blood-Line Red Head', 7, 0, NULL, NULL),
(958, 'CM-06990', 'CAJAS DE MADERA ROCKY PATEL BLOOD-LINE RED SIXTY BOX 20', 'Blood-Line Red Head', 7, 0, NULL, NULL),
(959, 'CM-06991', 'CAJAS DE MADERA ROCKY PATEL BLOOD-LINE RED TORO BOX 20', 'Blood-Line Red Head', 7, 0, NULL, NULL),
(960, 'CM-06992', 'CAJAS DE MADERA ROCKY PATEL BLOOD-LINE RED TORPEDO BOX 20', 'Blood-Line Red Head', 7, 0, NULL, NULL),
(961, 'CM-06993', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BLACK LABEL ROBUSTO BOX/20', 'La Palina Black Label', 7, 150, NULL, NULL),
(962, 'CM-06994', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BLACK LABEL GORDO MADURO BOX/20', 'La Palina Black Label', 7, 200, NULL, NULL),
(963, 'CM-06995', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BLACK LABEL TORO MADURO BOX/20', 'La Palina Black Label', 7, 2, NULL, NULL),
(964, 'CM-06996', 'CAJAS DE MADERA ROCKY PATEL LA PALINA RED LABEL ROBUSTO BOX/20', 'La Palina Red Label', 7, 100, NULL, NULL),
(965, 'CM-06997', 'CAJAS DE MADERA ROCKY PATEL LA PALINA RED LABEL TORO BOX/20', 'La Palina Red Label', 7, 201, NULL, NULL),
(966, 'CM-06998', 'CAJAS DE MADERA ROCKY PATEL LA PALINA RED LABEL GORDO BOX/20', 'La Palina Red Label', 7, 127, NULL, NULL),
(967, 'CM-06999', 'CAJAS DE MADERA ROCKY PATEL LA PALINA ANNIVERSARY TORO BOX/20', 'La Palina Anniversary', 7, -50, NULL, NULL),
(968, 'CM-07000', 'CAJAS DE MADERA ROCKY PATEL LA PALINA ANNIVERSARY ROBUSTO BOX/20', 'La Palina Anniversary', 7, 100, NULL, NULL),
(969, 'CM-07001', 'CAJAS DE MADERA ROCKY PATEL LA PALINA ANNIVERSARY GORDO BOX/20', 'La Palina Anniversary', 7, 0, NULL, NULL),
(970, 'CM-07002', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE DOUBLE CORONA PRESS HABANO BOX/25', 'Super Fuerte', 13, 0, NULL, NULL),
(971, 'CM-07003', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE ROBUSTO PRESS HABANO BOX/25', 'Super Fuerte', 13, 15, NULL, NULL),
(972, 'CM-07004', 'CAJAS DE MADERA ROCKY PATEL  SUPER FUERTE CORONA GRANDE HABANO BOX/25', 'Super Fuerte', 13, 6, NULL, NULL),
(973, 'CM-07005', 'CAJAS DE MADERA ROCKY PATEL  EDGE BATTALION CONECTICUM BOX20', 'The Edge Connecticut', 7, 402, NULL, NULL),
(974, 'CM-07006', 'CAJAS DE MADERA ROCKY PATEL LA PALINA BLUE LABEL ROBUSTO BOX/20', 'La Palina Blue Label', 7, 301, NULL, NULL),
(975, 'CM-07007', 'CAJAS DE MADERA ROCKY PATEL SCREAMING ROBUSTO MADURO BOX/20', 'Screaming Eagle', 7, 0, NULL, NULL),
(976, 'CM-07008', 'CAJAS DE MADERA ROCKY PATEL SCREAMING TORO CONECTICUT BOX/20', 'Screaming Eagle', 7, 0, NULL, NULL),
(977, 'CM-07009', 'CAJAS DE MADERA ROCKY PATEL SCREAMING TORO MADURO BOX/20', 'Screaming Eagle', 7, 0, NULL, NULL),
(978, 'CM-07011', 'CAJAS DE MADERA ROCKY PATEL CIGARS SHOP BILOXI 10TH ANNIVERSARY TORO PRESS CONN BOX20', 'Cigar Shop Biloxi 10th Anniversary', 7, 0, NULL, NULL),
(979, 'CM-07016', 'CAJAS DE MADERA ROCKY PATEL CAJUN CIGARS CZAR TRAYS', 'NINGUNA', NULL, 0, NULL, NULL),
(980, 'CM-07017', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY LIMITED RESERVE TORO HABANO BOX 20', 'Shockoe Valley', 7, 40, NULL, NULL),
(981, 'CM-07018', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY LIMITED RESERVE CORONA HABANO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(982, 'CM-07020', 'CAJAS DE MADERA ROCKY PATEL  HONDURAS CLASICO TORO HABANO  BOX/20', 'Honduran Classic', 7, 0, NULL, NULL),
(983, 'CM-07021', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY COSTARICA 6-1/4X52 TORPEDO MADURO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(984, 'CM-07022', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY COSTARICA 6X52 TORO MADURO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(985, 'CM-07023', 'CAJAS DE MADERA ROCKY PATEL MEXICO ROBUSTO SAMPLER #1 BOX/100', 'Sampler Varios', 18, 0, NULL, NULL),
(986, 'CM-07024', 'CAJAS DE MADERA ROCKY PATEL MEXICO ROBUSTO SAMPLER #2 BOX/100', 'Sampler Varios', 18, 0, NULL, NULL),
(987, 'CM-07025', 'CAJAS DE MADERA ROCKY PATEL CGALIV ROBUSTO 5X50 HABANO BOX/20', 'Segaliii', 7, 0, NULL, NULL),
(988, 'CM-07026', 'CAJAS DE MADERA ROCKY PATEL CGALIV TORO 6-1/2X50 HABANO  BOX/20', 'Segaliii', 7, 0, NULL, NULL),
(989, 'CM-07028', 'CAJAS DE MADERA ROCKY PATEL EL DIABLO 5X50 ROBUSTO HABANO/COL BOX/20', 'El Diablo', 7, 0, NULL, NULL),
(990, 'CM-07029', 'CAJAS DE MADERA ROCKY PATEL EL DIABLO 6-1/2X52 TORO HABANO/COL BOX/20', 'El Diablo', 7, 0, NULL, NULL),
(991, 'CM-07030', 'CAJAS DE MADERA ROCKY PATEL EDGE BATTALION HABANO (WAREHOUSE) BOX/20', 'The Edge Nicaragua', 7, 115, NULL, NULL),
(992, 'CM-07031', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO CELLO HABANO (WAREHOUSE) BOX/100', 'The Edge Nicaragua', 18, 71, NULL, NULL),
(993, 'CM-07032', 'CAJAS DE MADERA ROCKY PATEL EDGE TORO HABANO (WAREHOUSE) BOX/20', 'The Edge Nicaragua', 7, 903, NULL, NULL),
(994, 'CM-07033', 'CAJAS DE MADERA ROCKY PATEL THE ZEUS BY HUMIDOR CHURCHILL MADURO BOX/20', 'Zeus by Humidour', 7, 0, NULL, NULL),
(995, 'CM-07034', 'CAJAS DE MADERA ROCKY PATEL THE ZEUS BY HUMIDOR GRANDE MADURO BOX/20', 'Zeus by Humidour', 7, 10, NULL, NULL),
(996, 'CM-07035', 'CAJAS DE MADERA ROCKY PATEL LA PALINA SILVER ROBUSTO HABANO BOX/20', 'La Palina Silver Label', 7, 0, NULL, NULL),
(997, 'CM-07036', 'CAJAS DE MADERA ROCKY PATEL LA PALINA SILVER GORDO HABANO BOX/20', 'La Palina Silver Label', 7, 1, NULL, NULL),
(998, 'CM-07037', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS NEWBORM HABANO BOX50', 'VARIOS', 21, 0, NULL, NULL),
(999, 'CM-07038', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS NEWBORM HAB.MADURO BOX50', 'VARIOS', 21, 0, NULL, NULL),
(1000, 'CM-07039', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS NEWBORM HAB.SUMATRA BOX50', 'VARIOS', 21, 0, NULL, NULL),
(1001, 'CM-07040', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS NEWBORM TORPEDO CONECTICUT BOX50', 'VARIOS', 21, 0, NULL, NULL),
(1002, 'CM-07041', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS NEWBORM TORPEDO HABANO BOX50', 'VARIOS', 21, 0, NULL, NULL),
(1003, 'CM-07042', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS NEWBORM TORPEDO MADURO BOX50', 'VARIOS', 21, 0, NULL, NULL),
(1004, 'CM-07043', 'CAJAS DE MADERA ROCKY PATEL LA PALINA SILVER TORO HABANO BOX/20', 'La Palina Silver Label', 7, 150, NULL, NULL),
(1005, 'CM-07044', 'CAJAS DE MADERA ROCKY PATEL PHARAOH TORO SUMATRA 6X52 BOX/20', 'NINGUNA', 7, 25, NULL, NULL),
(1006, 'CM-07045', 'CAJAS DE MADERA ROCKY PATEL PHARAOH ROBUSTO SUMATRA 6X52 BOX/20', 'NINGUNA', 7, 25, NULL, NULL),
(1007, 'CM-07046', 'CAJAS DE MADERA ROCKY PATEL PHARAOH TORO CONECTICUT 6X52 BOX/20', 'NINGUNA', 7, 25, NULL, NULL),
(1008, 'CM-07047', 'CAJAS DE MADERA ROCKY PATEL PHARAOH ROBUSTO CONECTICUT 6X52 BOX/20', 'NINGUNA', 7, 25, NULL, NULL),
(1009, 'CM-07048', 'CAJAS DE MADERA ROCKY PATEL ISLAND GIRL TORO CONECTICUT BOX/20', 'Island Girl (TOH-60-14)', 7, 0, NULL, NULL),
(1010, 'CM-07049', 'CAJAS DE MADERA ROCKY PATEL ISLAND GIRL TORO HABANO COL. BOX/20', 'Island Girl (TOH-60-14)', 7, 50, NULL, NULL),
(1011, 'CM-07050', 'CAJAS DE MADERA ROCKY PATEL QUARTER CENTURY 25TH ANIVERSARIO SIXTY BOX/20', 'NINGUNA', 7, 0, NULL, NULL),
(1012, 'CM-07051', 'CAJAS DE MADERA ROCKY PATEL QUARTER CENTURY 25TH ANIVERSARO TORO BOX/20', 'NINGUNA', 7, 0, NULL, NULL),
(1013, 'CM-07052', 'CAJAS DE MADERA ROCKY PATEL QUARTER CENTURY 25TH ANIVERSARIO ROBUSTO BOX/20', 'NINGUNA', 7, 0, NULL, NULL),
(1014, 'CM-07056', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO HABANO (WAREHOUSE) BOX/20', 'The Edge Nicaragua', 7, 65, NULL, NULL),
(1015, 'CM-07057', 'CAJAS DE MADERA ROCKY PATEL  EDGE SHORT ROBUSTO HABANO (WAREHOUSE) BOX/20', 'The Edge Nicaragua', 7, 0, NULL, NULL),
(1016, 'CM-07594', 'CAJAS DE MADERA ROCKY PATEL EL DIABLO 7X38 LANCERO HABANO/COL BOX/20', 'El Diablo', 7, 0, NULL, NULL),
(1017, 'CM-07595', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS 6X52 TORO CONECTICUT BOX50', 'VARIOS', 21, 0, NULL, NULL),
(1018, 'CM-07596', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS 6X52 TORO HABANO BOX50', 'VARIOS', 21, 0, NULL, NULL),
(1019, 'CM-07597', 'CAJAS DE MADERA ROCKY PATEL JML TRAYS 6X52 TORO MADURO BOX50', 'VARIOS', 21, 0, NULL, NULL),
(1020, 'CM-07598', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORO RHYTHM GUITAR SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(1021, 'CM-07599', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET ROBUSTO RHYTHM GUITAR SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(1022, 'CM-07600', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET TORPEDO RHYTHM GUITAR SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(1023, 'CM-07601', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET SIXTY RHYTHM GUITAR SUMATRA BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(1024, 'CM-07602', 'CAJAS DE MADERA ROCKY PATEL J.A EDITION 2021 TORO CONECTICUT BOX/20', 'J.A. Edition 2021', 7, 0, NULL, NULL),
(1025, 'CM-07603', 'CAJAS DE MADERA ROCKY PATEL NUMBER 6 SIXTY COROJO BOX/20', 'Number 6', 7, -295, NULL, NULL),
(1026, 'CM-07604', 'CAJAS DE MADERA ROCKY PATEL NUMBER 6 TORO COROJO BOX/20', 'Number 6', 7, -647, NULL, NULL),
(1027, 'CM-07605', 'CAJAS DE MADERA ROCKY PATEL NUMBER 6 CORONA COROJO BOX/20', 'Number 6', 7, 911, NULL, NULL),
(1028, 'CM-07606', 'CAJAS DE MADERA ROCKY PATEL NUMBER 6 ROBUSTO COROJO BOX/20', 'Number 6', 7, -952, NULL, NULL),
(1029, 'CM-07607', 'CAJAS DE MADERA ROCKY PATEL SHOCKOE VALLEY COSTARICA 5X50 ROBUSTO MADURO BOX 20', 'Shockoe Valley', 7, 0, NULL, NULL),
(1030, 'CM-07608', 'CAJAS DE MADERA ROCKY PATEL BEALLE STREET SIXTY MADURO BOX/20', 'Bealle Street', 7, 0, NULL, NULL),
(1031, 'CM-07609', 'CAJAS DE MADERA ROCKY PATEL  CIGAR OASIS O.P 5-1/2X50  ROBUSTO CONNECTICUT BOX/20', 'Cigar Oasis O.P.', 7, 0, NULL, NULL),
(1032, 'CM-07610', 'CAJAS DE MADERA ROCKY PATEL  CIGAR OASIS O.P 6X60 SIXTY CONNECTICUT BOX/20', 'Cigar Oasis O.P.', 7, 0, NULL, NULL),
(1033, 'CM-07611', 'CAJAS DE MADERA ROCKY PATEL  EL MAGO 6X44  CORONA  HABANO/COL. BOX/20', 'El Mago', 7, 20, NULL, NULL),
(1034, 'CM-07612', 'CAJAS DE MADERA ROCKY PATEL  EL MAGO 6X52 TORO  HABANO/COL. BOX/20', 'El Mago', 7, 30, NULL, NULL),
(1035, 'CM-07613', 'CAJAS DE MADERA ROCKY PATEL VINTAGE 2003 ROUND SHORT GORDO 5X60 BOX 20', 'VINTAGE 2003', 7, 0, NULL, NULL),
(1036, 'CM-07614', 'CAJAS DE MADERA ROCKY PATEL NUMBER 6 CHURCHILL COROJO BOX/20', 'Number 6', 7, 310, NULL, NULL),
(1037, 'CM-07615', 'CAJAS DE MADERA ROCKY PATEL EDGE WOODEN DISPLAY TRAYS/BOX100', 'The Edge', 18, 0, NULL, NULL),
(1038, 'CM-07616', 'CAJAS DE MADERA ROCKY PATEL VINTAGE WOODEN DISPALY TRAYS  BOX100', 'Vintage Especial', 18, 0, NULL, NULL),
(1039, 'CM-07617', 'CAJAS DE MADERA ROCKY PATEL  EDGE TORPEDO HABANO (WAREHOUSE) BOX/100', 'The Edge Nicaragua', 18, 0, NULL, NULL),
(1040, 'CM-07618', 'CAJAS DE MADERA ROCKY PATEL  PABLO MARTIN GORDO CAMEROON BOX/20', 'Pablo Martin', 7, 0, NULL, NULL),
(1041, 'CM-07619', 'CAJAS DE MADERA ROCKY PATEL MARTINIQUE TORO HABANO TRAYS BOX100', 'Martinique TAA By RP', 18, 0, NULL, NULL),
(1042, 'CM-07620', 'CAJAS DE MADERA ROCKY PATEL CLUB REX BELICOSO GRANDE SUMATRA BOX/20', 'Club Rex', 7, 0, NULL, NULL),
(1043, 'CM-07621', 'CAJAS DE MADERA ROCKY PATEL  EDGE GRAN ROBUSTO HABANO BOX/20', 'The Edge', 7, 500, NULL, NULL),
(1044, 'CM-07622', 'CAJAS DE MADERA ROCKY PATEL  EDGE GRAN ROBUSTO CONNECTICUT BOX/20', 'The Edge', 7, 500, NULL, NULL),
(1045, 'CM-07623', 'CAJAS DE MADERA ROCKY PATEL  EDGE GRAN ROBUSTO SUMATRA BOX/20', 'The Edge', 7, 500, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca_productos`
--

DROP TABLE IF EXISTS `marca_productos`;
CREATE TABLE IF NOT EXISTS `marca_productos` (
  `id_marca` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `marca` char(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_marca`),
  UNIQUE KEY `marca` (`marca`)
) ENGINE=MyISAM AUTO_INCREMENT=1464 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `marca_productos`
--

INSERT INTO `marca_productos` (`id_marca`, `marca`, `created_at`, `updated_at`) VALUES
(2, 'RP HONDURAN ROBUSTO 2015 SAMPLER 20TH ANNIVERSARY', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(3, 'SUNGROWN TVC', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(4, 'RP HONDURAN ROBUSTO 2015 SAMPLER DECADE', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(5, 'RP HONDURAN ROBUSTO 2015 SAMPLER DECADE CAMEROON', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(6, 'RP HONDURAN ROBUSTO 2015 SAMPLER SUNGROWN', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(7, 'RP HONDURAN ROBUSTO 2015 SAMPLER SUPER LIGERO', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(8, 'RP HUMIDOR SELECTION GIFT PACK BURN', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(9, 'RP HUMIDOR SELECTION GIFT PACK DECADE', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(10, 'RP HUMIDOR SELECTION GIFT PACK EDGE', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(11, 'RP HUMIDOR SELECTION GIFT PACK O.W.R.', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(12, 'RP HUMIDOR SELECTION GIFT PACK SUNGROWN', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(13, 'RP ULTIMATE', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(14, 'Vintage 1992', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(15, 'Vintage 1990', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(16, 'RP Special Edition Robusto 95 Rated Selecction Decada', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(17, 'RP Special Edition Robusto 95 Rated Selecction 15th Anniversary tvc-1768', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(18, 'RP Special Edition Robusto 95 Rated Selecction  Sungrown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(19, 'RP Special Edition Robusto 95 Rated Selecction  Xen Nish Patel tvc-1768', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(20, 'RP Special Edition Robusto 95 Rated Selecction Vintage 1990', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(21, 'RP Special Edition Robusto 95 Rated Selecction Vintage 1999', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(22, 'RP Special Edition 95 Rated Sampler Decada', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(23, 'RP Special Edition 95 Rated Sampler 15TH Anniversary', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(24, 'RP Special Edition 95 Rated Sampler  Sungrown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(25, 'RP Special Edition 95 Rated Sampler Vintage 1990', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(26, 'RP Special Edition 95 Rated Sampler Vintage 1999', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(27, 'RP Signature Series  Sampler RP Sungrown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(28, 'RP Royale', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(29, 'RP Signature Series  Sampler RP Fifty', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(30, 'RP Signature Series  Sampler 20th Anniversary', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(31, 'RP Signature Series  Sampler Hamlet Tabaquero', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(32, 'RP Special Edition 95 Rated Sampler Sungrown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(33, 'RP Special Edition 95 Rated Sampler Xen by Nish', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(34, 'RP Robusto Sampler 2015 Decada', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(35, 'RP Robusto Sampler 2015 15TH Anniversary', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(36, 'RP Robusto Sampler 2015 Sungrown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(37, 'RP Robusto Sampler 2015 Vintage 1990', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(38, 'RP Robusto Sampler 2015 Vintage 1999', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(39, 'RP Robusto Sampler 2015 Royale', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(40, 'Number 6', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(41, 'Freshpacks of 4 RP Honduran Sampler Vintage 1990', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(42, 'Freshpacks of 4 RP Honduran Sampler Decada', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(43, 'Freshpacks of 4 RP Honduran Sampler Old World Reserve (Edge)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(44, 'Freshpacks of 4 RP Honduran Sampler Sungrown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(45, 'Vintage Robusto 90,99.03 Sampler Vintage 1990', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(46, 'Vintage Robusto 90,99.03 Sampler Vintage 1999', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(47, 'Vintage Robusto 90,99.03 Sampler VINTAGE 2003', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(48, 'Decada RP Zipper Humidor', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(49, 'Number 6 RP Zipper Humidor Case', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(50, 'Cuban Blend Fuma', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(51, 'The Edge', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(52, 'Club Rex', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(53, 'La Palina Bronze Label', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(54, 'Connecticut Rocky Patel Mega Sampler', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(55, 'Limited Reserve', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(56, 'RP Freedom', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(57, 'RP Imperial', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(58, 'RP Strada', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(59, 'Super Fuerte', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(60, 'Vintage 2006 Fuma', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(61, 'The Edge Nicaragua', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(62, 'Junior Vintage 1992', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(63, 'Shockoe Valley', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(64, 'Davidus Antietam', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(65, 'Davidus Fredericktown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(66, 'Nick Cigar World 10 Anivereary', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(67, 'Sungrown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(68, 'Davidus PL Monocacy', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(69, 'Marquette 77', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(70, 'Bealle Street', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(71, 'Black Warrior', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(72, 'Smoker Friendly', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(73, 'The Edge Lite', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(74, 'Old World Reserve (Edge)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(75, 'Junior Vintage 1990 2da', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(76, 'CI/RP 10 Cigar Cover Sampler RP Broadleaf', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(77, 'CI/RP 10 Cigar Cover Sampler Connecticut Rocky Patel', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(78, 'CI/RP 10 Cigar Cover Sampler Royal vintage By RP', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(79, 'CI/RP 10 Cigar Cover Sampler The Edge', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(80, 'CI/RP 10 Cigar Cover Sampler Vintage 1990 (GEN-1763)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(81, 'CI/RP 10 Cigar Cover Sampler Vintage 1999 (GEN-1763)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(82, 'CI/RP 10 Cigar Cover Sampler VINTAGE 2003', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(83, 'CI/RP 10 Cigar Cover Sampler Super Ligero', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(84, 'CI/RP 10 Cigar Cover Sampler 20th Anniversary', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(85, 'CI/RP 10 Cigar Cover Sampler Vintage 1979 (GEN-1763)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(86, 'Vintage 1999', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(87, 'Waller´s Premiun Club', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(88, '20th Anniversary', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(89, 'CCF- White Label', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(90, 'Decada', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(91, 'Edge 10th Anniversary', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(92, 'Grand Reserve Red Label', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(93, 'La Palina Anniversary', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(94, 'La Palina Black Label', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(95, 'RP LB1', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(96, 'Sampler 4 Count Pack The Edge', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(97, 'Sampler 4 Count Pack  The Edge Nicaragua', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(98, 'Sampler 4 Count Pack  The Edge', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(99, 'The Edge Connecticut', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(100, 'The Edge F/Second', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(101, 'VINTAGE 2003', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(102, 'Zeus by Humidour', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(103, 'The Edge Fuma', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(104, 'Wall Street', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(105, 'The Edge Nicaraguan', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(106, 'Caucus', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(107, 'Desiena 312', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(108, 'Leesburg LCP', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(109, 'Nording', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(110, 'Pablo Martin', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(111, 'RP SunMart (TOH-60-14)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(112, 'Sungrown FUMA', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(113, 'Super Ligero', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(114, 'Sampler 4 Count Pack The Edge Nicaragua', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(115, 'Kautz', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(116, 'Edge Clone', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(117, 'Dark Dominion', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(118, 'CI Legend', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(119, 'Mega sampler Top Twenty 2015 The Edge', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(120, 'Mega sampler Top Twenty 2015 Super Ligero', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(121, 'Mega sampler Top Twenty 2015 RP Broadleaf', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(122, 'Mega sampler Top Twenty 2015 Vintage 1990', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(123, 'Mega sampler Top Twenty 2015 Royal vintage By RP', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(124, 'RP 15 CIGAR SAMPLER 2018 Decada', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(125, 'RP 15 CIGAR SAMPLER 2018 Sungrown TVC-2577', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(126, 'RP 15 CIGAR SAMPLER 2018 Vintage 1990 GEN-1779 FZT', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(127, 'RP Vintage 5-Star Sampler Vintage 2003', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(128, 'RP Vintage 5-Star Sampler Vintage 1990 (GEN-1780 FZT)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(129, 'RP Vintage 5-Star Sampler Vintage 1992 (GEN-1780 FZT)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(130, 'RP Vintage 5-Star Sampler Vintage 1996 (GEN-1780 FZT)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(131, 'RP Vintage 5-Star Sampler Vintage 2006 (GEN-1780 FZT)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(132, 'American Market Selection', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(133, 'Cuban Blend', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(134, 'Honduran Classic', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(135, 'Rosado', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(136, 'Junior Sungrown 2da', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(137, 'Junior Vintage 1992 2da', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(138, 'Junior Vintage 1999 2da', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(139, 'Bella Camella', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(140, 'Jon Carlos', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(141, 'Junior Vintage 1990', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(142, 'Meritage', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(143, 'Renegade Connecticut', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(144, 'The Edge Seleccion', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(145, 'World Famous Cigar Bar', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(146, 'Rosado Fuma', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(147, 'Royal vintage By RP', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(148, 'The Edge Fuma NEWBORNE', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(149, 'AMS Fuma', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(150, 'Vintage 1999 Clones', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(151, 'ITC Emerald', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(152, 'RP Broadleaf', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(153, 'Vintage 2003 Fuma', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(154, 'RP Vintage 5-Star Sampler Vintage 1990 GEN-1787', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(155, 'RP Vintage 5-Star Sampler Vintage 1992 GEN-1787', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(156, 'RP Vintage 5-Star Sampler Vintage 1999 GEN-1787', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(157, 'RP Vintage 5-Star Sampler Vintage 2006 GEN-1787', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(158, 'Junior Sungrown', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(159, 'Junior Vintage 1999', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(160, 'Junior Vintage 2003', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(161, 'RP Factory Over- Runs-E (edge)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(162, 'RP Rejectes # 1', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(163, 'Dober´s Society', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(164, 'The Pharaoh (TOH-60-14)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(165, 'Olde World Reserve Fuma Corojo', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(166, '20th Anniversary Fuma', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(167, 'Gold Maduro By RP', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(168, 'Connecticut Rocky Patel', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(169, 'CI Big Ring Sampler 2015 Super Fuerte', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(170, 'CI Big Ring Sampler 2015 RP Broadleaf', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(171, 'CI Big Ring Sampler 2015 The Edge', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(172, 'CI Big Ring Sampler 2015 RP Royale', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(173, 'CI Mildn Mellow Sampler The Edge Connecticut', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(174, 'CI Mildn Mellow Sampler  Vintage 1999', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(175, 'CI Mildn Mellow Sampler  Connecticut Rocky Patel', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(176, 'RP Connecticut Fuma', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(177, 'Cargo By RP', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(178, 'RP/Santa clara vintage short gordo VINTAGE 1990 GEN-1798', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(179, 'RP/Santa clara vintage short gordo VINTAGE 2003', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(180, 'VINTAGE 2006', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(181, 'RP Factory Over- Runs-E (edge lite)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(182, 'RP Factory Over- Runs-S (Sungrown)', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(183, 'Extreme', '2021-04-08 21:40:35', '2021-04-08 21:40:35'),
(184, 'La Conquista', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(185, 'Garage Blend', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(186, 'Old World Reserve', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(187, 'Martinique', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(188, 'MUESTRAS', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(189, '15th Anniversary Fuma', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(190, 'Badge 282', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(191, 'Cameroon By RP', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(192, 'Mega Sampler Connecticut Rocky Patel', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(193, 'RP Famous Fuma Sampler Cuban Blend Fuma', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(194, 'RP Famous Fuma Sampler AMS Fuma', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(195, 'RP Famous Fuma SamplerRosado Fuma', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(196, 'RP Famous Fuma Sampler Sungrown FUMA', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(197, 'RP/CI Rated 93 5-Star Sampler Decada', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(198, 'RP/CI Rated 93 5-Star Sampler Sungrown (TVC-2653)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(199, 'RP/CI Rated 93 5-Star Sampler Royale (TVC-2653)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(200, 'RP/CI Rated 93 5-Star Sampler The Edge Nicaragua', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(201, 'RP/CI Rated 93 5-Star Sampler 15th Anniversary (TVC-2634)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(202, 'CI RP 5-Star Toro Sampler 15th Anniversary (TVC-2654)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(203, 'CI RP 5-Star Toro Sampler Royale', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(204, 'CI RP 5-Star Toro Sampler Decada', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(205, 'CI RP 5-Star Toro Sampler Vintage 1990', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(206, 'CI RP 5-Star Toro Sampler The Edge', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(207, 'Decada Cameroon', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(208, 'Decade Limitada', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(209, 'Edge Square', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(210, 'El Conejito', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(211, 'Gold By RP', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(212, 'Havana Connections (TOH-60-014)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(213, 'Island Girl (TOH-60-14)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(214, 'Ray Lewis', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(215, 'CI/RP Po Boy Sampler RP Connecticut Fuma', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(216, 'CI/RP Po Boy Sampler RP Cargo (TVC-2652)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(217, 'CI/RP Po Boy Sampler  The Edge Fuma', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(218, 'CI/RP Po Boy Sampler The Edge Fuma', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(219, 'RP Factory Over- Runs-D (Decade f/s)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(220, 'RP Royale Clone', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(221, 'RP/CI Rated 93 5-Star Sampler Sungrown (TVC-2666)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(222, 'RP/CI Rated 93 5-Star Sampler Royale (TVC-2666)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(223, 'RP/CI Rated 93 5-Star Sampler 15th Anniversary (TVC-2666)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(224, 'CI RP 5-Star Toro Sampler 15th Anniversary (TVC-2666)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(225, 'CI RP 5-Star Toro Sampler Royale (TVC-2666)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(226, 'El Mago', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(227, 'Fox Fuma', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(228, 'La Palina Blue Label', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(229, 'La Palina Red Label', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(230, 'La Palina Silver Label', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(231, 'La Sirena', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(232, 'RP - Costa Rica', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(233, 'CI/RP Po Boy Sampler Cargo by RP (TVC-2666)', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(234, 'The Edge JR Version', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(235, 'Sampler Count Pack The Edge', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(236, 'Sampler Count Pack The Edge Nicaragua', '2021-04-08 21:40:36', '2021-04-08 21:40:36'),
(237, 'VARIOS', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(238, 'The New Party', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(239, '5 Vegas Black', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(240, '5 Vegas Cask Streng', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(241, '5 Vegas Classic', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(242, 'Flint', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(243, 'Hungry Trout', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(244, 'Mottican Cigars', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(245, 'Pow Pow', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(246, 'R4 Corojo', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(247, 'R4 Maduro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(248, 'Smoking Bean', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(249, 'Spanish Heirloom', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(250, 'The Mess', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(251, 'Turbo Cigars', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(252, 'Mas Fina', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(253, '22N/83/W', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(254, 'Sangre de Toro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(255, 'Royal Nicaragua', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(256, 'Maxx Traditional', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(257, 'Oliveros Eight Zero', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(258, 'Mission Tobacco Lounge', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(259, 'Larrys Montes', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(260, 'Mark Watowich', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(261, 'Jeremy Mcconnico', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(262, 'Randy Rains', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(263, 'David Provenzano', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(264, 'Mark Hale', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(265, 'Tom Gringo', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(266, '21 Degrees Triple Ligero', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(267, 'Estilo Cubano', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(268, 'Las Ramblas', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(269, 'Havana Reserve', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(270, 'La Campiña Nic.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(271, 'Floridita Nic.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(272, 'Livin Large Collection', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(273, 'MP Newport', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(274, 'JAM', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(275, 'Black Market', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(276, 'Chris Oneil', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(277, 'SC-80', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(278, 'Javier Reyes', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(279, 'Shane Hargrove', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(280, 'Russell Bubba', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(281, 'Execution by RP', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(282, 'David Huey', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(283, 'Dmitri Clawson', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(284, 'Tim Hogan', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(285, 'Jeff Hogan', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(286, '5 Vegas Gold', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(287, 'T.p. Hale', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(288, 'Doug Kimmell', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(289, 'Gary Coogan', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(290, 'Martin Kaltreiper', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(291, 'Tim Urbahic', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(292, 'Geoffery Goldberg', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(293, 'Barrie Gibbs', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(294, 'Ron Aldon', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(295, 'John Yalck', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(296, 'Jeff Schooly', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(297, 'Dr. El Magnifico', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(298, 'Shanes', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(299, 'Dancing Bear', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(300, 'J Darren Shue', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(301, '1950 Special Reserve', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(302, 'Plastie', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(303, 'OSC', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(304, 'Micks Stick', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(305, 'ECF', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(306, 'El Jeffe', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(307, 'Big Guanch', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(308, 'Humo Jaguar', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(309, 'Santuary', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(310, 'Julie Taylor', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(311, 'Casa Magna Colorado', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(312, 'H.O.H.', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(313, '1874 Series', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(314, 'Naas', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(315, 'Generation By Nestor', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(316, 'Close Outs', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(317, 'Hugo Cassar', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(318, 'Smokin Cigar', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(319, 'Stogies Liga Excepcional', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(320, 'Habanitos', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(321, 'Taste Of The World', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(322, 'Edition Special', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(323, 'Cuban Rounds', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(324, 'Cuban Rejects', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(325, 'Pura Sangre', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(326, 'American Blend', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(327, 'Family Blend', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(328, 'Gran Toro', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(329, 'Tempus Medius', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(330, 'American Classic Blend', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(331, 'Supervisor Selection', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(332, 'Fred & Steve', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(333, 'Retreat', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(334, 'K-147', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(335, 'Floridita Gold', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(336, 'Floridita Edition Limitada', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(337, 'Lempira Puros', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(338, 'Achievement', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(339, 'Native', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(340, 'Evolution', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(341, 'Travis Club', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(342, 'The Minister', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(343, 'Mr. President', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(344, 'Cacique', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(345, 'The Mayan Princess', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(346, 'Lempa', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(347, 'Patuca', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(348, 'El Paraiso', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(349, 'Dom \"P\"', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(350, 'Gold # 1', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(351, 'Ideology', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(352, 'Letage', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(353, 'Proyecto Alex', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(354, 'Evil Cigars', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(355, 'Legends Vintage 1999', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(356, 'Legends Vulvan', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(357, 'Legends Habana Blend', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(358, 'Legends Rare Breed', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(359, 'Famous 365', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(360, 'Burn', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(361, 'Draig K', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(362, 'Peter Henrichs', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(363, 'Rodrigo de Jerez Edition Special', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(364, 'Natural', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(365, 'Proyecto PL-1', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(366, 'Inceptión', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(367, 'Black Head', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(368, 'Ryan Danger', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(369, 'Shift', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(370, 'Edision de Familia', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(371, 'Maxx Brazil', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(372, 'Corazón de Tabaco', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(373, 'Final Editión', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(374, 'Don Lino Colorado', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(375, 'Don Lino Black Sandwich', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(376, 'Don Lino Black', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(377, 'Vintage Shaggy', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(378, 'Cigar Studios', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(379, 'RP -X- outs liga \"F\"', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(380, 'Sikar 2012', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(381, 'Maroma Dulce', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(382, 'Binny\'s', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(383, '5 Vegas Red', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(384, 'Triple 777', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(385, 'King Habano', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(386, 'Nicaragua Selection', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(387, 'San Diego', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(388, 'Heiress', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(389, 'Spider', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(390, 'Hustler Series', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(391, 'Blendlab', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(392, 'The International', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(393, 'Maria Mancini 2013', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(394, 'Nica Puros', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(395, '312 Cigars', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(396, 'Honduran 3000', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(397, 'Honduran 5000', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(398, 'Toraño 90', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(399, 'Reserva 1898', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(400, 'Cuba Libre One', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(401, 'Bonacquisti', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(402, 'Paraiso', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(403, 'American Sun Grown', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(404, 'Zack', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(405, 'Easy Five', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(406, 'Embassy', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(407, 'Ventura', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(408, 'Godsend', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(409, 'Placeres Reserva', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(410, '2012 Limited', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(411, 'Old World Reserve F/S', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(412, 'The Edge F/Select', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(413, 'Prensado', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(414, 'The Edge Lite F/Second', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(415, 'Montes Triple', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(416, 'Vivalo', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(417, 'B1 Burners Private Label', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(418, 'Smoke Singal', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(419, 'Roatan Cigars', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(420, 'Don Duarte', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(421, 'Maroma Fuerte', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(422, 'Stick Villiger', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(423, 'Connoisseur', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(424, '41334', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(425, 'Menage A Trois', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(426, 'R.A.D.', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(427, 'Plasencia Nicaragua', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(428, 'Palemtto State', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(429, 'Secession', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(430, 'Timeless', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(431, 'Oliva Cigar', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(432, 'AB Connecticut', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(433, 'PeaceMaker', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(434, 'Grand Reserve', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(435, 'Liga Don Nestor', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(436, 'Fine & Rare', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(437, 'AB New York', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(438, 'Spirit Of Cuba', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(439, 'Rusticos', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(440, 'Box Press', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(441, 'Vintage 2003 Press', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(442, 'Tailored', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(443, 'Syndicate', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(444, 'Ole', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(445, 'The Judge', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(446, 'Reserve Connecticut', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(447, 'Moscato', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(448, 'JF-Miami-CT', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(449, 'JF-Miami-C', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(450, 'JF-Miami-S', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(451, 'Moroceli', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(452, 'Velvet', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(453, 'Maria Mancini Edicion 2014', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(454, 'Phatty', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(455, 'Blunt', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(456, 'Gomez & Schwarz', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(457, '15th Anniversary', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(458, 'Xen by Nish', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(459, 'Perla del Mar', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(460, 'El Baton', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(461, 'Brick House', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(462, '5 Vegas C. High Primings', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(463, 'El Mejor Espresso', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(464, 'Triple 777 Zero', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(465, 'Exodus 1959 Finite', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(466, 'DISSIDENT', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(467, 'TOTAL FLAMES', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(468, 'TABLE 36 INTEGRITY', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(469, 'Dan Sawalhi', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(470, 'Palmetto State', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(471, 'Havana Collection', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(472, 'Cigarrillo Strawberry', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(473, 'God Speed Orinoco', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(474, 'Jaxx LT', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(475, 'Sabor', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(476, 'Paco Guerrero', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(477, 'Poly Productos de Guatemala', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(478, '5 Vegas Shorty', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(479, 'Doog  Good', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(480, 'Gonzo Celebración 2007', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(481, 'La Invicta', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(482, 'Nicaraguan', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(483, 'Mayorga', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(484, 'Gold Series', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(485, 'Factory Overruns', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(486, 'R&D Project', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(487, 'J.Fuego Americana', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(488, 'Cruzero de Panama', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(489, 'Joya de Panama', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(490, 'Colon Especiales', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(491, 'Campo Verde', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(492, 'Fina de Panama', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(493, 'Fina de Dominicana', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(494, 'Fina de Brazil', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(495, 'Fina de Nicaragua', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(496, 'Sirena', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(497, 'Astoria de Nicaragua', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(498, 'Machetero', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(499, 'O Line', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(500, 'Felipe Dominicana', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(501, 'Soap Box', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(502, 'Bloc', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(503, 'Costa Linda', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(504, 'Ibis Nic.', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(505, 'Rodrigo de Jerez Nic.', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(506, 'Casa de Torres', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(507, 'Plantation Blend', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(508, 'Liga 5-A', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(509, 'Alec Bradley', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(510, 'Raices Cubanas', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(511, 'Bright Line', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(512, 'Villiger Colorado', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(513, 'Villiger Talanga', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(514, 'The Estelí Primera', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(515, 'The Estelí Segunda', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(516, 'Payday', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(517, 'Live', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(518, 'Defiance', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(519, 'Malfetano', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(520, 'Cheval', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(521, 'Texas Lancero', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(522, 'Edge R69', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(523, 'Habano', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(524, 'Connecticut', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(525, 'Block Island', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(526, 'Old World Reserve R69', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(527, 'Sungrown R90', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(528, 'RP Cameroon Especial R95', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(529, 'Tampa Baseball', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(530, 'Domus Magnus', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(531, 'P.V. Nisher', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(532, 'Black Lotus', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(533, 'La Perla White', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(534, 'Carnival', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(535, 'Decade Cameroon', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(536, 'H.O.H.NIC.', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(537, 'Fighting Cock', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(538, 'Honduran Primeros', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(539, 'Costa Rican Primeros', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(540, 'Cuban Primeros', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(541, 'Nestor Miranda', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(542, 'J.Fuego Corojo', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(543, 'Heat', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(544, 'R&D', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(545, 'King David', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(546, 'The Lineage', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(547, 'Signature', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(548, 'Edge R72', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(549, 'Edge Lite R80', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(550, 'Lavalette', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(551, 'Old World Reserve R72', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(552, 'Cunuco R87', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(553, 'Fusion', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(554, 'White Gold', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(555, 'TOH-P-30-14', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(556, 'Maria Mancini 2015', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(557, 'Factory 57', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(558, 'Sanctum', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(559, 'Liga 7-A', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(560, 'TOH-43-B-13', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(561, '70 Aniversario', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(562, 'Maxx Black', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(563, 'Big Ring Gauges', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(564, 'Daniel Marshall', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(565, 'Chicken Bones', '2021-04-28 20:51:59', '2021-04-28 20:51:59'),
(566, 'House Blend', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(567, 'Monyaz', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(568, 'Casa de las Estrellas', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(569, 'NSR', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(570, 'Bunch', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(571, '5 Pipa Nicaragua', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(572, 'Edge Mistic', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(573, '7/Treinta', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(574, 'Zechbawer', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(575, 'M. M. Vintage Edition', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(576, 'Sea Knight', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(577, 'TOHJBC-1-14', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(578, 'TOHJBM-1-14', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(579, 'TOHH-1-14', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(580, 'American Legion', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(581, 'Diamante', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(582, 'Habanitos Suave', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(583, 'Habanitos Mediano', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(584, 'Habanitos Fuerte', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(585, 'The Edge Lite F/Select', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(586, 'The Edge Counterfeit', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(587, 'Black Ops Rubicon', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(588, 'Terry Brennan', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(589, 'Mira Flor', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(590, 'Puritanos', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(591, 'Opulence', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(592, 'Roger Stroh', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(593, 'Mike 1980', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(594, 'Vudu Sacrifice', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(595, 'Coyol', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(596, 'Montecristo', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(597, 'Vudu Dark', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(598, 'Connecticut By J.Fuego', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(599, 'Habana Collection White Sungrown', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(600, 'Padilla La Terraza', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(601, 'Padilla Hybrid', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(602, 'AB1', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(603, 'AB3', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(604, 'AB5', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(605, 'AB7', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(606, 'AB9', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(607, 'Segaliii', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(608, 'Vudu Priest', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(609, 'Kensington Dolce', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(610, 'Maria Mancini 2016', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(611, 'Classic Series', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(612, 'AB 1600', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(613, 'AB 1633', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(614, 'Villainy', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(615, 'RP Ice', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(616, 'Ramon Zapata', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(617, 'Shock And Awe', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(618, '1893 Vintage', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(619, 'Jose Melendi', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(620, 'Padilla Fumas', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(621, 'Peter Hartkamp', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(622, 'Maroma Cafe', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(623, 'R&S', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(624, 'Blue Agave', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(625, 'Finck \' S Cheroots', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(626, 'Taza de Jose', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(627, 'Famous 366', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(628, 'Famous 367', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(629, 'Bayamo Superiores', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(630, 'Conuco', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(631, 'Private Selection', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(632, 'Vitola Especial', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(633, 'Soledad', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(634, 'Famous Vsl Nicaragua', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(635, 'Artisan Habano', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(636, 'Angry Monks', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(637, 'Beligerent Beaver', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(638, 'Fat Daddy', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(639, 'Loathsome Hogg', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(640, 'Pure Mayhem', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(641, 'Rabid Rhino', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(642, 'Swarthy Badger', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(643, 'Cigar King Gold II', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(644, 'Vintage 1992 Fuma', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(645, 'Atlantic Pa', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(646, 'Mark Twain Memoir', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(647, 'Vintage 1980', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(648, 'Tempus Terra Novo', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(649, 'Jacoub´s Cigars', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(650, 'RP Black Label', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(651, 'RP Short Run', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(652, 'The Project', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(653, 'Reposado', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(654, 'Formula', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(655, 'Oliveros Gran Retorno', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(656, 'Vudu Blood', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(657, 'Vudu Dambala', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(658, 'Origen JF. Connoisseur', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(659, 'Teasers Green', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(660, 'Teasers Red', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(661, 'Top Shelf', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(662, 'Mundial Pl# 6', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(663, 'RP Travel Set', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(664, 'Vintage 1990 Fuma', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(665, 'Vintage 1999 Fuma', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(666, 'Sweet Nostalgia', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(667, 'Liga 1', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(668, 'LIga 2', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(669, 'Santa Karina', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(670, 'Favorita de Nicaragua', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(671, 'Nicaragua Segundos', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(672, 'Palmetto State DW Reserve', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(673, 'Secession DW Reserve', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(674, 'Maestranza', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(675, 'Crio-ojo By RP', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(676, 'Leatherneck', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(677, 'Cigar Of The Gods', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(678, 'RP Calcutta', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(679, 'No.20', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(680, 'Gurkha Fumas', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(681, 'Prohibition Connecticut', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(682, 'Honduran Selection', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(683, 'RP Broadleaf Fuma', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(684, 'Martinique TAA By RP', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(685, 'Opalo 1979', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(686, 'Sanctum Escape', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(687, 'Pryme Gold', '2021-04-28 20:52:00', '2021-04-28 20:52:00');
INSERT INTO `marca_productos` (`id_marca`, `marca`, `created_at`, `updated_at`) VALUES
(688, 'Pryme Platinum Series', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(689, 'Trilogy', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(690, 'Sanctum Sacred City', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(691, 'Black Markett Illicit', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(692, 'Black Markett Contraband', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(693, 'Black Market Phanton M', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(694, 'Black Markett War Dogs C', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(695, 'Havana Sungrown', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(696, 'Medalist Kotinos', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(697, 'Cubilete', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(698, 'Munity', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(699, '11 Eleven', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(700, 'Mexicana', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(701, 'Blend Code 32', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(702, 'Blend Code 76', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(703, 'Blend Code 95', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(704, 'Edicion Liga 400', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(705, '1995', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(706, 'Cameroon', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(707, 'Sumatra', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(708, 'Ducks Unlimited', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(709, 'Four Kicks', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(710, 'Inktome', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(711, 'Brazil', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(712, 'Blood-Line Red Head', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(713, 'Burn Special Reserve', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(714, 'Edge Dominican', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(715, 'Edge San Andreas', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(716, 'Embarcadero', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(717, 'Four Kicks Black Belt Buckle', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(718, 'Hamlet Tabaquero', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(719, 'Headley Grange', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(720, 'Headley Grange Black Dog', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(721, 'Honduran Selection 2000', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(722, 'J.D. Howard', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(723, 'Jericho Hill', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(724, 'Johnny Flamingo', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(725, 'La Palina El Dario', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(726, 'La Palina KB Series', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(727, 'La Palina LP Line 10', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(728, 'La Palina LP Line 4', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(729, 'La Palina LP Line 5', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(730, 'La Palina LP Line 6', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(731, 'La Palina LP Line 7', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(732, 'La Palina LP Line 8', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(733, 'La Palina LP Line 9', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(734, 'La Palina LP Line 1', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(735, 'La Palina LP Line 2', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(736, 'La Palina LP Line 3', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(737, 'La Palina Purple Label', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(738, 'La Palina White Label', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(739, 'Las Calaveras 2014', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(740, '80 Aniversario', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(741, 'LuCallun (A)', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(742, 'LuCallun (B)', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(743, 'LuCallun (C)', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(744, 'LuCallun (D)', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(745, 'Maranello Collezionoe Berlinetta', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(746, 'Mexican Radio', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(747, 'My Hands by Hamlet Paredes', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(748, 'My Smoke by Hamlet Paredes', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(749, 'Nimmy-D Big Burrito', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(750, 'Nimmy-D Big Burrito 2nds', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(751, 'NP Special Edition', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(752, 'NP Special Edition 2nds', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(753, 'Prohibition San Andreas 2nds', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(754, 'Royale', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(755, 'Prohibition Connecticut 2nds', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(756, 'RP Equis', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(757, 'RP ES350', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(758, 'RP Fusion 2nds', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(759, 'RP Hall of Fame', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(760, 'RP Hall of Fame 2nds', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(761, 'RP Legacy', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(762, 'RP My Smoke', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(763, 'RP My Smoke 2nds', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(764, 'RP OSG', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(765, 'RP Platinum 2016', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(766, 'RP Super Fuerte 2nds', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(767, 'RP Super Fuerte Fuma', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(768, 'Siagon Kiss', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(769, 'Tennessee Waltz', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(770, 'Vintage 2007 Fuma', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(771, 'Yellow Rose', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(772, 'Las Calaveras 2016', '2021-04-28 20:52:00', '2021-04-28 20:52:00'),
(773, 'Nestor 747 Vintage', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(774, 'San Victor', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(775, 'My Smoke by Hamlet Paredes 2nds', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(776, 'My Hands by Hamlet Paredes 2nds', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(777, 'Luminosa', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(778, 'Case Study', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(779, 'Olde World Reserve Fuma Connecticut', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(780, 'Olde World Reserve Fuma Maduro', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(781, 'Le Careme', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(782, 'La Palina Purple Seconds Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(783, 'La Palina Red Seconds Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(784, 'La Palina White Seconds Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(785, 'La Palina Black Seconds Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(786, 'La Palina Blue Seconds Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(787, 'La Palina Purple Factory Selects Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(788, 'Royale Connecticut', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(789, 'Royale Maduro', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(790, 'La Palina Red Factory Selects Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(791, 'La Palina White Factory Selects Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(792, 'La Palina Black Factory Selects Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(793, 'La Palina Blue Factory Selects Label', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(794, 'RP Double Maduro', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(795, 'La Palina Purple Over RunsLabel', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(796, 'La Palina Red Over RunsLabel', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(797, 'La Palina White Over RunsLabel', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(798, 'La Palina Black Over RunsLabel', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(799, 'La Palina Blue Over RunsLabel', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(800, 'Rum & Honey', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(801, 'Juan Y Julia', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(802, 'TC Family Blend', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(803, 'TC Original', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(804, 'Prohibition Broadleaf 2nds', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(805, 'Value Lines 100', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(806, 'Value Lines 200', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(807, 'Value Lines 300', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(808, 'ITC Super Fuerte', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(809, 'Value Lines 400', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(810, 'Value Lines 500', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(811, 'Value Lines 600', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(812, 'Cosecha', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(813, 'Bever M.', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(814, 'Vandal', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(815, 'Cosecha 150', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(816, 'Estrella Cubana Lnuci 3-14', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(817, 'Estrella Cubana', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(818, 'Odyssey', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(819, 'Sampler Varios', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(820, 'Alma Fuerte', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(821, 'Texas Nicaragua', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(822, 'La Estrella Cubana', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(823, 'Maria Mancini 2017', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(824, 'Carinos', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(825, 'Caridad', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(826, 'Post Embargo', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(827, 'Maria Mancini Red', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(828, 'Maria Mancini Limited', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(829, 'It\' A', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(830, 'It\' S', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(831, 'Vitolas Varias', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(832, 'Vintage 1990 Second', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(833, 'Vintage 1992 Second', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(834, 'Corrida', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(835, 'Valido', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(836, 'Maroma Chocolate Sorrel', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(837, 'Maroma Caramelo Tawny', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(838, 'Reserve Nicaragua', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(839, 'Siboney', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(840, 'Seleccion de Fabrica', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(841, 'Huntsman', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(842, 'Truce', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(843, 'Lord Blackburn Black', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(844, 'Lord Blackburn Gold', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(845, 'Lord Blackburn Red', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(846, '5 Vegas Lucky', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(847, 'Tion San', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(848, 'Mia Rosa', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(849, 'Romeo y Juli', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(850, 'Mto White-Vint Conn', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(851, 'Gerard Priva', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(852, 'Maria Mancini Excellence', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(853, 'Black Market Esteli', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(854, 'Prensado Lost  Arte', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(855, 'Don Diego European', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(856, 'Tesch125 Anniversario', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(857, 'Bundles M.B', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(858, 'Vegafina Nicaragua', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(859, 'Vega Fina Fortaleza Dos', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(860, 'Don Diego Aniversario', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(861, 'Santa Damiana', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(862, 'Mustique Red', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(863, 'Blanco Kisten', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(864, 'Gerard Private Blend', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(865, 'Mustique Blue', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(866, 'Dominican Estates Xlt', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(867, 'Vega Fina F', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(868, 'Vega Fina E', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(869, 'Pleiades', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(870, 'Gerard Limited Blend', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(871, 'J.A. Santo Domingo', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(872, 'J.A. Santo Domingo Export', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(873, 'Don Diego', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(874, 'Hoyo de Cibao', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(875, 'Dominican Bundles', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(876, 'Bismarck', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(877, 'Gold Crown', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(878, 'Plasencia Cosecha 146', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(879, 'Round Tour', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(880, 'Ab Reserve Connecticut', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(881, 'Ab Reserve Nicaragua', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(882, 'Third Street', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(883, 'Micheleros', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(884, '7 Pecados', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(885, 'Soto Cano', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(886, 'La Rosa', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(887, 'Raza', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(888, 'Renaissance Fuma', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(889, 'Flint Hills', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(890, 'Fresh Pack', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(891, 'Rolling Thunder', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(892, 'Field 5.56', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(893, 'Field 50', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(894, 'Garrison 5.56', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(895, 'Garrison 50', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(896, 'Garrison 7.62', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(897, 'Victory', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(898, 'Carbonell', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(899, 'Primos Classic', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(900, 'Entered  Apprentice', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(901, 'Fellow Craft', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(902, 'Master Mason', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(903, 'Veiled Prophet', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(904, 'Tabakado', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(905, 'Belligerent', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(906, 'Artisan Nic.', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(907, 'H Up Mann Banker', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(908, 'RP Rejects #2', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(909, 'Padilla', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(910, '5 Vegas Limitada', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(911, 'Smoke Inn House Blend', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(912, 'Black Market Prensado', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(913, 'Black Crown', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(914, 'Decade F/Select', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(915, 'Black Ops Berserker', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(916, 'La Perla Habana Classic', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(917, 'La Perla Habana Classic Maduro', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(918, 'Bayamo', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(919, 'Black Market 2 capas', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(920, 'H&S Traveling Man', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(921, 'H&S Entered Apprentice', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(922, 'H&S Fellow Craft', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(923, 'H&S Master Mason', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(924, 'H&S Shriner', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(925, 'H&S Veiled Prophet', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(926, 'Carlos Toraño 90', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(927, 'La Perla Black Pearl', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(928, 'Alamo', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(929, 'Don Blend', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(930, 'JR Esteli Reserva', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(931, 'Magnificat', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(932, 'Farniente', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(933, 'Plasencia Original', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(934, 'Ore Golf', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(935, 'Midnight 5', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(936, 'Classic Series Nica', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(937, 'Black Market Nicaragua', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(938, 'Alma del Campo', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(939, 'The Tank', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(940, 'The Profit', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(941, 'Filthy Vilking', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(942, 'The Commission Fuma', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(943, 'Oretoberfest', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(944, 'Altos Cerros', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(945, 'Wild Bunch', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(946, 'The Founder', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(947, 'The Collection Fuma', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(948, 'Raktos', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(949, 'Sungrown F/S', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(950, 'Maroma Venatian Cherry Vanilla', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(951, 'El Hefe Fuma', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(952, 'Magic Toast', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(953, 'La Palina Regal Reserve', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(954, 'Victory Cigars 10th Anniversary', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(955, 'Placeres Honduras', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(956, 'Me Late Cigars', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(957, 'Platinum Collection', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(958, 'Steel City', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(959, 'The Rattler', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(960, 'Cigar Shop', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(961, 'Guilberth', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(962, 'Panatrading (TOH-60-14)', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(963, 'Plasencia Rojo', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(964, 'Oreasis', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(965, 'Plasencia Reserva Original', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(966, 'Plasencia Reserva 1898', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(967, 'Tempus Medius Nicaragua', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(968, 'Liga Secreta', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(969, 'Blind Faith', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(970, 'HPT (Outback Blend)', '2021-04-28 20:52:01', '2021-04-28 20:52:01'),
(971, 'Backstoppers', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(972, 'JR Alternative', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(973, 'Los Blancos Cigars', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(974, '90 Plus Rated 2nds.', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(975, 'The Founder Special Edition', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(976, 'Wild Bunch WBS Earp', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(977, 'Wild Bunch Billy The Kid', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(978, 'Wild Bunch J.W. Hardin', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(979, 'Wild Bunch Jesse James', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(980, 'Wild Bunch WF Cody', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(981, 'Wild Bunch H.A. Longabaugh', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(982, 'Wild Bunch RL Parker', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(983, 'Wild Bunch J.H. Holliday', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(984, 'Wild Bunch J.B. Hickok', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(985, 'Wild Bunch WH Bonney', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(986, 'Gunfight Bill Clanton Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(987, 'Gunfight Frank McLaury Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(988, 'Gunfight Billy Claibome Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(989, 'Gunfight Wyatt Earp Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(990, 'Gunfight Ike Clanton Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(991, 'Gunfight Morgan Earp Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(992, 'Gunfight doc Holliday Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(993, 'Gunfight Vigil Earp Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(994, 'Gunfight Corral Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(995, 'Gunfight Tom McLaury Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(996, 'Union Square', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(997, 'Howard Powell', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(998, 'Aventura', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(999, 'Windy City', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1000, 'Screaming Eagle', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1001, 'Profumo', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1002, 'Los Tenores', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1003, 'Calamity Jane Fuma', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1004, 'Caribbean Cask', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1005, 'Fox Connecticut', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1006, 'Off Roads Cigars', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1007, 'Reserva', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1008, 'Flint Oaks', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1009, 'Alma del Fuego', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1010, 'Hans Eisening', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1011, 'WW Planungs ag', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1012, 'Cigar Shop Biloxi 10th Anniversary', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1013, 'Alboran', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1014, 'Reserva Villa Zamorano', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1015, 'CGAL-IV', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1016, 'Black Market 3 Capas', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1017, 'Flatirons', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1018, 'El Diablo', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1019, 'Smoking World Championship', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1020, 'Cigars Dayli', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1021, 'Grand Exhibition', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1022, 'Urodoshi', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1023, 'AstroWoods', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1024, 'V2L Black', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1025, 'Superstition', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1026, 'CI Fresh-Rolled', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1027, 'CI RB Genesis The Proyect', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1028, 'CI Super Premium Seconds', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1029, 'CI Bahia Maduro', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1030, 'CI Gurkha', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1031, 'CI Macanudo Inspirado Orange', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1032, 'CI Mark Twain', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1033, 'CI 5 Vegas Serie \"A\"', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1034, 'CI John Bull', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1035, 'CI Villazon', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1036, 'Plasencia Orchant', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1037, 'Plasencia Worlsdorff', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1038, 'G Cigars', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1039, 'CI American Blend', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1040, 'CI Arganese Connecticut', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1041, 'CI Arganese Nicaraguan', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1042, 'CI Bahia Trinidad', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1043, 'CI Bidders Choice', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1044, 'CI Dark Shark', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1045, 'CI Fresh-Rolled Rosado', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1046, 'CI Graycliff Double Espresso', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1047, 'CI Graycliff Profesionale', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1048, 'CI Gurkha Class Regent', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1049, 'CI Gurkha Warpig', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1050, 'CI Gurkha Yakuza', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1051, 'CI HC Series Maduro', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1052, 'CI Sons Of  Anarchy By Black', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1053, 'CI Pioneer Valley Maduro', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1054, 'CI Ramon Bueso Exclusivo', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1055, 'CI Ramon Bueso Olancho', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1056, 'CI RB Genesis Habano', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1057, 'CI Lgc Serie R Black', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1058, 'CI Hoyo Excalibur', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1059, 'Liga Toh-45-19', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1060, 'Liga Toh-16-20', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1061, 'Liga Toh-17-20', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1062, 'J.A. Edition 2021', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1063, 'CI Carlos Torano Dominico', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1064, 'Plasencia Canada', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1065, 'CI Don Tomas Classico', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1066, 'CI Mac Inspirado White', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1067, 'CI Punch GP', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1068, 'CI HB', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1069, 'CI Punch Gran Puro Nicaragua', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1070, 'CI Don Tomas Maduro', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1071, 'CI Don Tomas Sun Grown', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1072, 'CI Hoyo', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1073, 'CI Excalibur', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1074, 'CI Helix', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1075, 'Cigar Oasis O.P.', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1076, 'CI Foundry Chillin M.', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1077, 'CI Foundry Chillin M. Too', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1078, 'White', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1079, 'Black l', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1080, 'Black ll', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1081, 'Edicion', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1082, 'Rhein', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1083, 'CI Toraño Dominico', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1084, 'CI Sancho Panza', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1085, 'CI Thompson Punch Clone', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1086, 'CI Thompson Hoyo Clone', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1087, 'CI Gurkha Master Select', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1088, 'CI Arganese Maduro', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1089, 'CI Punch Knuckle Buster', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1090, 'CI Mac Inspirado Orange', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1091, 'CI Don Tomas Thompson', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1092, 'Cao Pilon', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1093, 'Cao Gold', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1094, 'Cao Consigliere', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1095, 'Good Cigar', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1096, 'Liga 7-20-4', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1097, 'Liga Toh-24-20', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1098, 'Punch Clasico', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1099, 'Punch Nicaragua', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1100, 'Copan', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1101, 'CI LGC White', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1102, 'Alma Fuerte Natural', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1103, 'CI Cao Colombia', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1104, 'CI Don Tomas', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1105, 'CI Lgc Esteli', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1106, 'CI Sancho Panza Extra F.', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1107, 'American Stogies', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1108, 'CI Punch El Grandote', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1109, 'Hambones Pigtail', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1110, 'Wagyu', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1111, 'Kintsugi', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1112, 'Romeo y Julieta', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1113, 'Nine', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1114, 'JT Limitado', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1115, 'Liga Exclusiva', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1116, 'Primos Estate Selection', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1117, 'Co 1st Third Box Pressed', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1118, 'Co Final Third', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1119, 'Co 2do Third', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1120, 'BG Reserve', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1121, 'Romeo y Julieta 1875 Connect.', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1122, 'Artisan Honduras', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1123, 'La Perla Habana Black Pearl', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1124, 'Adonis 1972', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1125, 'Napels National 1st Edition', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1126, 'Gatekeeper', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1127, 'Cu-Avana Punisher', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1128, 'La Perla Habana Wide', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1129, 'Amoroso', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1130, 'Ancient Warrior', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1131, 'Antonio Azul', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1132, 'Armas del Casa', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1133, 'Artisan 34-10', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1134, 'Aspira', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1135, 'Baby Spliff', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1136, 'Bandido', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1137, 'Erin Go Bragh I. Whisk', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1138, 'Bering', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1139, 'Beverly', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1140, 'Blender Gold', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1141, 'Bolero', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1142, 'Bondele', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1143, 'Bull and Bear', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1144, 'Capoeira', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1145, 'Caribean Cruiser', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1146, 'Cariño', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1147, 'Casa Fuego', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1148, 'Casa Magna', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1149, 'Casino Gold', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1150, 'Castro Back', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1151, 'Centurion', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1152, 'Charutos', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1153, 'Chevere', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1154, 'Chinchalero', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1155, 'Churchill', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1156, 'Cigar Fest', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1157, 'Cigar King', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1158, 'Classic', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1159, 'Columbus', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1160, 'Value Line', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1161, 'Criollo', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1162, 'Monte Alto', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1163, 'Cruz Real', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1164, 'Cu-Avana Intenso', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1165, 'Cuba Libre', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1166, 'Cuban Aristocrat', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1167, 'Cuban Classic', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1168, 'Cuban Spliff', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1169, 'Cuban Twist', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1170, 'Danlí Selección', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1171, 'Dinamita', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1172, 'Amerigo II', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1173, 'Don Julio', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1174, 'Don Lino', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1175, 'Don Simon', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1176, 'Don Sixto', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1177, 'Dos Hombres', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1178, 'Dupont', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1179, 'El Laudo', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1180, 'El Mejor Emerald', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1181, 'Evelio', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1182, 'Gurkha Exotica de Oriente', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1183, 'Famous Buenos', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1184, 'Famous Cativo', '2021-04-28 20:52:02', '2021-04-28 20:52:02'),
(1185, 'Fina de Honduras', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1186, 'Finck Commerce', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1187, 'Fire', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1188, 'Fire Smoke', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1189, 'Flor de Honduras', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1190, 'Flor de Jalapa', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1191, 'Fleur de la Reine', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1192, 'Flor de Selva', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1193, 'Floridita Fuerte', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1194, 'Fortuna de Honduras', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1195, 'Frida', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1196, 'Glass Tubo', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1197, 'Gonio Ruso', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1198, 'Gran Nica', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1199, 'Gran Reserva', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1200, 'Gray Cliff 1666', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1201, 'Gurkha Aniversary 1887', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1202, 'Gurkha Avenger G-5', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1203, 'Gurkha G-3', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1204, 'Gurkha Gran R.', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1205, 'Gurkha Master Sel. Cent.', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1206, 'Gurkha Rothchild', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1207, 'Gurkha Shaggy', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1208, 'Gurkha Evil State Sel.', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1209, 'Habano Premium', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1210, 'Harvest Selection', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1211, 'Havana Sunrise', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1212, 'Hond. Especial', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1213, 'Hond. Selection', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1214, 'Honduran Bench Pack', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1215, 'Honduran Plantation', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1216, 'Humberto Primero', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1217, 'Humicon Private Label', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1218, 'Delirium', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1219, 'Plasencia', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1220, 'John Aylesbury', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1221, 'Joya del Rey', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1222, 'Navarro', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1223, 'K. Hansotia', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1224, 'Kinky Friedman', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1225, 'Kinky', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1226, 'La Floridita', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1227, 'La Intimidad', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1228, 'La Libertad', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1229, 'La Ligadora', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1230, 'La Marqueza', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1231, 'La Primadora', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1232, 'La Rica', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1233, 'La Rosa Especial N.V.', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1234, 'Domaine de Lavalette', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1235, 'LAEPE', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1236, 'Latin Gold', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1237, 'Liga Centroamericana', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1238, 'M. M. Edition Special', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1239, 'M. M. Schuster', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1240, 'Mac Beth', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1241, 'Maria Mancini', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1242, 'Maroma', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1243, 'Maxx', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1244, 'Maxx La Gianna', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1245, 'Maxx Paxx', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1246, 'Maxx Vice Line', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1247, 'Medalist', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1248, 'Medici', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1249, 'Micela di Lusso', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1250, 'Mistik', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1251, 'Mocambo', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1252, 'Monseñor', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1253, 'Navegator', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1254, 'Nero Extra', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1255, 'Nestor Reserve', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1256, 'New Orleans', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1257, 'New York (La Bomba)', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1258, 'Nick`s Perdomo', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1259, 'Nude de Honduras', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1260, 'Nude de Nicaragua', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1261, 'Oliveros Classic', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1262, 'Oliveros Nautica', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1263, 'Oliveros Rustic', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1264, 'Oliveros Silver', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1265, 'Oliveros White', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1266, 'Omar Ortez (La Diligencia)', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1267, 'Optimo', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1268, 'Origen J.F.', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1269, 'Ortolan', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1270, 'Paigow', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1271, 'Pilsner', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1272, 'Piñata Cubana', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1273, 'Postre de Banquete', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1274, 'Premium Value', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1275, 'Primera de Hond.', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1276, 'Primo de Cuba', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1277, 'Privada', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1278, 'Puck', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1279, 'Racine & Laramie', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1280, 'Red Oild', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1281, 'Reel Grande', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1282, 'Reserva Limitada', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1283, 'Reserva Organico Nic.', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1284, 'Reserva Selecto', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1285, 'Rodrigo de Jerez', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1286, 'Romero', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1287, 'Royal Flavor', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1288, 'Sandwish', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1289, 'Scarface', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1290, 'Selva Barroco', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1291, 'Shakesspear', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1292, 'Soñador', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1293, 'Stag', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1294, 'Stogies Private Label', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1295, 'Sweet', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1296, 'TCC Suave', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1297, 'Ten Little Indian', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1298, 'Thomas Hinds', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1299, 'Tiburon', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1300, 'Tony Montana', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1301, 'Tropical Delight', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1302, 'Ugly Coyote', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1303, 'Up in Smoke', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1304, 'Valero Texas', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1305, 'Vega Fuego', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1306, 'Vieja Tradicion', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1307, 'Villar S.E.M.', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1308, 'Vintage Especial', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1309, 'World Blend', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1310, 'Xikar Defiance', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1311, 'Paradigm \"262\"', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1312, 'Charles', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1313, 'Lote # 1', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1314, 'Lote # 2', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1315, 'Lote # 3', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1316, 'Mazo', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1317, 'SAN J. # 1', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1318, 'Xikar Havana C', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1319, 'Exoticos Puros', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1320, 'Bentley Cigars', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1321, 'Ibis', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1322, 'New Tea Party', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1323, 'Star Insignia', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1324, 'Camerum', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1325, 'Bunk Head', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1326, 'Catracho', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1327, 'Robus', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1328, 'Mosaico', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1329, 'Cumpay', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1330, 'Villa Zamorano', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1331, 'Maria Mancini 2011', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1332, 'Brocha', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1333, 'Short Filler', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1334, 'Cubano Gold', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1335, 'Cojimar', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1336, 'Kendall\'s 7-20-4', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1337, 'Mataza', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1338, 'Cameroon Legend', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1339, 'Tobacco Haven', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1340, 'Habana Premiun', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1341, 'Vigilante', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1342, 'Reo', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1343, 'Vengence', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1344, 'Carrera Impresso', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1345, 'Tabacco World  PL \"V\"', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1346, 'Cigar Souce PL', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1347, 'Vibe', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1348, 'Don Patel', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1349, 'Havana Connections', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1350, 'Original Cigar Store #4', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1351, 'Milwaukee Mile', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1352, 'The Peninsula', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1353, 'Phoenix', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1354, 'Ci - Anniversary', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1355, 'Don Barco', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1356, 'The Don', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1357, 'Zarka', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1358, 'American Bank Center', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1359, 'PB Limited Reserve', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1360, 'Havana Rays Signature', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1361, 'Saverio', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1362, 'Cunuco', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1363, 'Nicarao', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1364, 'The Rebel', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1365, 'Pilsner Urquel', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1366, 'RP MGM Grand', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1367, 'RP -X- outs liga \"A\"', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1368, 'RP -X- outs liga \"D\"', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1369, 'RP -X- outs liga \"E\"', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1370, 'I Am A Dad & Grandpa', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1371, 'MJK  Cigar Source', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1372, 'I Press By RP', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1373, '10 Años by Cunningham', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1374, 'Osage', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1375, 'Emilio  H Serie', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1376, 'Don Cassieni PL', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1377, 'Famous Bundles Wrap', '2021-04-28 20:52:03', '2021-04-28 20:52:03'),
(1378, 'Hicksville Humidor PL', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1379, 'RP -X- outs liga \"B\"', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1380, 'Liberty Cigar', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1381, 'Esteban Carrera', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1382, 'Twins Smoke Shop', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1383, 'Kensington', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1384, 'RP Cameroon Especial', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1385, 'Renaissance', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1386, 'Chicago Reserve', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1387, 'Zach Abou', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1388, 'Habano Corojo By RP', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1389, 'Churchill\'s PL', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1390, 'Cigar Bar', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1391, 'RP Ocean Club', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1392, 'Zarka 1932', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1393, 'Man Cave', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1394, 'Sentitos', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1395, 'RP Factory Over- Runs-RE (renaissance)', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1396, 'RP Factory Over- Runs-D (Decade 2da)', '2021-04-28 20:52:04', '2021-04-28 20:52:04');
INSERT INTO `marca_productos` (`id_marca`, `marca`, `created_at`, `updated_at`) VALUES
(1397, 'Gran Vida', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1398, 'RP Factory Over - Runs- O.W.R.', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1399, 'Tobacco World - GA', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1400, 'Olde World Tobacco', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1401, 'Angus Bar', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1402, 'Valedor', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1403, 'Cobuto', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1404, 'Outback', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1405, 'MJK  cConnecticut', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1406, 'Cuban Cigar Factory Cabinet Selection', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1407, 'Cuban Cigar Factory vintage limited 1962', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1408, 'MacGladrey', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1409, 'Strike', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1410, 'Marquette Warrior', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1411, 'B2 - A', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1412, 'Bill Davis', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1413, 'Single Stick', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1414, 'Diesel', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1415, 'CCF- Black Label', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1416, 'Ibis Antiguo', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1417, 'Roug Neck', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1418, 'Roug Rider', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1419, 'Outlaws', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1420, 'Horse Power', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1421, 'Factory over - runs', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1422, 'CCF - 1962', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1423, 'Sapiral', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1424, 'LD - \"v\"', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1425, 'Leesburg', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1426, 'Catico Nero', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1427, 'Grand Seineur', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1428, 'Tomas Hind', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1429, 'Mia Maria', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1430, 'Tabacco & Cigar', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1431, 'Cigarrillo Grande', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1432, 'Liga Suave', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1433, 'Ray Bugg', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1434, 'Solido', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1435, 'Steve Wass', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1436, 'Triangler', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1437, 'Cinco Maduro', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1438, 'Carlos Sanchez', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1439, 'Doug Wood', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1440, 'Nestor Vintage', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1441, 'Mocha', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1442, 'Premiun Selection', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1443, 'Tea Party', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1444, 'Malcolm', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1445, 'Hawaiian Gold', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1446, 'Judges', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1447, 'Stanley Papas', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1448, 'Graveyson', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1449, 'Tatiana Mocha', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1450, 'NINGUNA', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(1462, 'Perfet Timing', NULL, NULL),
(1463, 'Vintage 1979', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nombre_productos`
--

DROP TABLE IF EXISTS `nombre_productos`;
CREATE TABLE IF NOT EXISTS `nombre_productos` (
  `id_nombre` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` char(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_nombre`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=MyISAM AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nombre_productos`
--

INSERT INTO `nombre_productos` (`id_nombre`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'ROBUSTO', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(2, 'TORO', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(3, 'TORO PRESS', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(4, 'CHURCHILL', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(5, 'ROBUSTO RED.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(6, 'Robusto Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(7, 'Pettite Belicoso Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(8, 'Petite Belicoso', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(9, 'PETITE BELICOSO PRESS', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(10, 'Toro  Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(11, 'Sixty', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(12, 'Howitzer', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(13, 'Belicoso Grande', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(14, 'Torpedo', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(15, 'Bear', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(16, 'Gordo', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(17, 'Missile Torpedo', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(18, 'Vintage 1992', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(19, 'Rockchild', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(20, 'Piramide Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(21, 'Torpedo Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(22, 'Junior Vintage 1990', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(23, 'Robusto Grande Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(24, 'Gran Robusto', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(25, 'Petite Corona', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(26, 'Emperor Red.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(27, 'Toro Semi Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(28, 'Gordo Round', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(29, 'Sixty Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(30, 'Corona', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(31, 'Churchill Shaggy', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(32, 'Battalion', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(33, 'B52', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(34, 'Double Corona', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(35, 'Toro Red.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(36, 'Torpedo Red.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(37, 'Sixty Red.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(38, 'Churchill Red.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(39, 'Grande', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(40, 'Sixty Con Moño', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(41, 'Robusto Con Moño', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(42, 'Lancero', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(43, 'Short Robusto', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(44, 'Rockchilde Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(45, 'Bison', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(46, 'Sungrown', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(47, 'Junior Vintage 1992', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(48, 'Junior Vintage 1999', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(49, 'Lonsdale', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(50, 'Pyramide', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(51, 'Churchill Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(52, 'Forty Six Press', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(53, 'Vintage 1990', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(54, '652 (Toro)', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(55, 'Pyramid', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(56, 'Short Gordo', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(57, 'Toro Grande', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(58, 'CORONA RED.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(59, 'BELICOSO RED.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(60, 'Junior', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(61, 'Perfecto', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(62, 'Vintage 1999', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(63, 'Lancero Red.', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(64, 'Vintage 2003', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(65, 'Robusto Cidbones', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(66, 'Toro Jawbones', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(67, 'Rockchilde', '2021-04-08 21:40:39', '2021-04-08 21:40:39'),
(68, 'Super Toro Red.', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(69, 'Super Toro', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(70, 'Lancero Press', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(71, 'VARIADO', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(72, '6-1/2X52', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(73, 'Corona Grande Press', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(74, 'Double Corona Press', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(75, 'Toro Deluxe Tubo', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(76, 'Robusto Tubo', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(77, 'Toro Tubo', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(78, 'Corona Press', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(79, 'Robusto Semi Press', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(80, 'Grand Robusto', '2021-04-08 21:40:40', '2021-04-08 21:40:40'),
(81, 'Bandido', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(82, 'Nero', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(83, 'Regular', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(84, 'PETIT CORONA RED.', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(85, '# 8', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(86, 'Imperial', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(87, 'Plaza', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(88, 'Hispano', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(89, 'Casino', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(90, 'Inmensas', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(91, 'Corona Grande', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(92, 'Short Story', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(93, 'Boxer', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(94, 'Teepee', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(95, 'Marinero', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(96, 'Crucero', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(97, 'Lonsdale Press', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(98, 'Short Torpedo', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(99, 'Short', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(100, 'Lancero Sin Moño', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(101, 'Petite Corona Press', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(102, 'Short Robusto Press', '2021-04-28 20:51:56', '2021-04-28 20:51:56'),
(103, 'Missile', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(104, 'Honey', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(105, 'Honey Berry', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(106, 'Berry', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(107, 'Cherry', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(108, 'Belicoso', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(109, 'Forty Six RED.', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(110, 'Muestras', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(111, 'Toro Gordo', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(112, 'Cañonazo', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(113, 'Bully', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(114, 'MINI BELICOSO', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(115, 'VARIOS', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(116, 'Lancero Con Moño', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(117, 'Lonsdale Red.', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(118, 'PETIT BELICOSO RED.', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(119, 'Short Robusto Red.', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(120, 'BELICOSO PRESS', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(121, 'Imperiale', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(122, 'Robusto Grande', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(123, 'Lancero Con Rabito', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(124, 'Variados', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(125, 'Petit Belicoso', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(126, 'Sampler', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(127, 'Fiffty Eight', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(128, 'Lancero Pigtail', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(129, 'Fortissimo Con Moño', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(130, 'Campfire', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(131, 'Warrior', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(132, 'Corona Gorda', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(133, 'HR56', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(134, '44S Press', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(135, 'Jack Brown', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(136, 'Willy Lee  Press', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(137, 'KB1', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(138, 'KB4', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(139, 'LC550 Press', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(140, 'LC552 Press', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(141, 'LC660', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(142, 'Cosacos', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(143, 'Robusto Sampler', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(144, 'Muestras Brocha', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(145, 'Toro (652)', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(146, 'Limited Edition A', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(147, 'Brocha', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(148, 'Super Gordo', '2021-04-28 20:51:57', '2021-04-28 20:51:57'),
(149, 'Sweet Single', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(150, 'Cream', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(151, 'Natural Single', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(152, 'Lancero Rabito', '2021-04-28 20:51:58', '2021-04-28 20:51:58'),
(153, 'NINGUNA', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cant_paquetes` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unidades` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_orden` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `item`, `cant_paquetes`, `unidades`, `numero_orden`, `categoria`, `created_at`, `updated_at`) VALUES
(1, '00504006', '100', '100', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(2, '00505006', '100', '40', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(3, '00504041', '5', '100', 'HON-3135', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(4, '00508000', '20', '200', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(5, '00508015', '10', '60', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(6, '00605002', '25', '220', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(7, '00508010', '30', '60', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(8, '00504100', '20', '200', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(9, '00504102', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(10, '00504002', '20', '480', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(11, '00505002', '20', '180', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(12, '10104130', '20', '25', 'HON-3136', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(13, '10104817', '5', '2000', 'HON-3138', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(14, '10515002', '10', '20', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(15, '10105565', '20', '100', 'FTT-1475', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(16, '10105566', '20', '100', 'FTT-1475', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(17, '00504007', '100', '120', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(18, '00505007', '100', '20', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(19, '00504042', '5', '100', 'HON-3135', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(20, '00508016', '10', '100', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(21, '00605003', '25', '60', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(22, '00508011', '30', '40', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(23, '00508001', '20', '360', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(24, '00504003', '20', '580', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(25, '00505003', '20', '160', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(26, '00504101', '20', '180', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(27, '00504103', '20', '40', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(28, '10104816', '5', '2000', 'HON-3138', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(29, '9900009110', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(30, '9900009111', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(31, '9900009117', '20', '50', 'HON-3146', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(32, '9900009115', '25', '100', 'HON-3123', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(33, '10105005', '20', '20', 'HON-3126', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(34, '9900004000', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(35, '9900004002', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(36, '9900004003', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(37, '9900004005', '20', '50', 'HON-3146', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(38, '10105550', '20', '300', 'FTT-1475', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(39, '10105551', '20', '300', 'FTT-1475', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(40, '00508020', '20', '3140', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(41, '00508022', '20', '60', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(42, '00401000', '20', '60', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(43, '00403000', '20', '140', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(44, '00404000', '20', '220', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(45, '00405000', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(46, '00408000', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(47, '00303007', '10', '100', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(48, '00407000', '50', '60', 'FTT-1479', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(49, '10104111', '20', '25', 'HON-3136', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(50, '20005000', '20', '200', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(51, '20005001', '20', '400', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(52, '20005002', '20', '240', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(53, '20005005', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(54, '20005007', '20', '60', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(55, '20005010', '10', '60', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(56, '00505019', '100', '20', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(57, '00504032', '20', '80', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(58, '00504033', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(59, '00231000', '50', '200', 'FTT-1479', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(60, '9900004035', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(61, '9900004037', '20', '150', 'HON-3124', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(62, '9900004038', '20', '250', 'HON-3124', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(63, '9900004039', '20', '200', 'HON-3143', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(64, '9900004040', '20', '50', 'HON-3146', '1', '2021-06-18 03:05:41', '2021-06-18 03:05:41'),
(65, '13105120', '10', '40', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(66, '00703001', '50', '40', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(67, '00704001', '50', '40', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(68, '00705001', '50', '20', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(69, '00712001', '50', '20', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(70, '00508002', '20', '180', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(71, '00508017', '10', '20', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(72, '00703003', '20', '80', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(73, '00712003', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(74, '00704003', '20', '100', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(75, '00705003', '20', '60', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(76, '00504043', '5', '100', 'HON-3135', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(77, '00712004', '25', '50', 'HON-3135', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(78, '10515004', '10', '40', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(79, '10603007', '20', '50', 'HON-3137', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(80, '00110060', '20', '10', 'HON-3144', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(81, '00110061', '20', '10', 'HON-3144', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(82, '00110062', '20', '10', 'HON-3144', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(83, '00110063', '20', '10', 'HON-3144', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(84, '10105560', '20', '100', 'FTT-1475', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(85, '10105561', '20', '100', 'FTT-1475', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(86, '00504150', '20', '40', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(87, '00508003', '20', '60', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(88, '12506020', '20', '160', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(89, '12506021', '20', '160', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(90, '12506010', '25', '25', 'HON-3135', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(91, '12506012', '5', '2000', 'HON-3138', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(92, '00504252', '50', '40', 'HON-3133', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(93, '01604010', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(94, '01604011', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(95, '01604012', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(96, '01606675', '20', '320', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(97, '01606678', '20', '260', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(98, '603004002', '20', '60', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(99, '603004004', '20', '20', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(100, '603005750', '10', '60', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(101, '603005751', '10', '120', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(102, '603005752', '10', '40', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(103, '9900004027', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(104, '9900004028', '20', '200', 'HON-3124', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(105, '9900004025', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(106, '9900004030', '20', '100', 'HON-3123', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(107, '9900004031', '20', '50', 'HON-3146', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(108, '9900004019', '20', '150', 'HON-3124', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(109, '9900004020', '20', '200', 'HON-3124', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(110, '9900004023', '20', '50', 'HON-3146', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(111, '00107000', '50', '180', 'FTT-1479', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(112, '9900004011', '20', '100', 'HON-3124', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(113, '9900004012', '20', '150', 'HON-3124', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(114, '9900004015', '20', '100', 'HON-3123', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(115, '9900004016', '20', '50', 'HON-3146', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(116, '12503005', '20', '40', 'HON-3128', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(117, '12503003', '20', '40', 'HON-3128', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(118, '12503010', '20', '40', 'HON-3128', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(119, '10105555', '20', '100', 'FTT-1475', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(120, '10105556', '20', '100', 'FTT-1475', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(121, '10104750', '20', '120', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(122, '10104751', '20', '200', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(123, '10104752', '20', '40', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(124, '10104754', '20', '40', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(125, '10104150', '20', '100', 'HON-3134. ', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(126, '15003000', '20', '100', 'HON-3127', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(127, '15004001', '20', '100', 'HON-3127', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(128, '00110276', '5', '100', 'HON-3129', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(129, '00110275', '5', '100', 'HON-3129', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(130, '00110277', '5', '100', 'HON-3129', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(131, '10104912', '5', '2860', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(132, '00904038', '15', '420', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(133, '00904038', '15', '0', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(134, '00904038', '15', '420', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(135, '00904038', '15', '420', 'HON-3142', '1', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(136, '00504026', '5', '600', 'HON-3139', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(137, '00504009', '25', '40', 'HON-3132', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(138, '47801040', '20', '150', 'FTT-1473', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(139, '00804065', '20', '20', 'HON-3139', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(140, '603004050', '5', '600', 'HON-3139', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(141, '00904111', '10', '50', 'HON-3135', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(142, '01104000', '25', '70', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(143, '01103006', '5', '500', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(144, '01103010', '5', '200', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(145, '47801563', '20', '3000', 'FTT-1472', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(146, '00404005', '25', '200', 'HON-3138', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(147, '00408003', '25', '300', 'HON-3138', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(148, '20005006', '5', '5000', 'HON-3138', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(149, '20005016', '5', '8000', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(150, '00504048', '5', '1000', 'HON-3138', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(151, '00504048', '5', '100', 'HON-3139', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(152, '40503005', '20', '500', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(153, '40503022', '10', '300', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(154, '40503016', '5', '500', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(155, '6030066060', '10', '500', 'FTT-1472', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(156, '47801044', '20', '150', 'FTT-1473', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(157, '14399005', '5', '80', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(158, '14399006', '5', '800', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(159, '14399010', '5', '300', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(160, '47801501', '20', '30', 'FTT-1477', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(161, '40503004', '20', '500', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(162, '40503021', '10', '300', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(163, '40503015', '5', '500', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(164, '00704004', '25', '800', 'HON-3138', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(165, '47801004', '20', '100', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(166, '47801002', '20', '60', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(167, '47705002', '5', '1500', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(168, '01606872', '5', '500', 'FTT-1472', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(169, '47801042', '20', '150', 'FTT-1473', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(170, '40503003', '20', '500', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(171, '40503020', '10', '300', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(172, '40503014', '5', '500', 'HON-3127', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(173, '12506011', '25', '40', 'HON-3132', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(174, '603004023', '25', '50', 'HON-3135', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(175, '603004023', '25', '200', 'HON-3138', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(176, '603004031', '5', '150', 'HON-3139', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(177, '20018021', '25', '50', 'HON-3135', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(178, '20018022', '25', '50', 'HON-3135', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(179, '01103004', '5', '65', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(180, '41112001', '5', '40', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(181, '47801420', '20', '3000', 'FTT-1472', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(182, '47801421', '20', '3000', 'FTT-1472', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(183, '47801561', '20', '3000', 'FTT-1472', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(184, '47801043', '20', '150', 'FTT-1473', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(185, '47801890', '10', '140', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(186, '47801892', '10', '160', 'HON-3141', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(187, '10104775', '25', '80', 'HON-3138', '2', '2021-06-18 03:05:42', '2021-06-18 03:05:42'),
(188, '10104772', '25', '50', 'HON-3135', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(189, '10104778', '5', '140', 'HON-3139', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(190, '10499060', '1', '1000', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(191, '10499060', '1', '0', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(192, '10499060', '1', '0', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(193, '10499060', '1', '1000', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(194, '10499060', '1', '0', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(195, '10499015', '1', '0', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(196, '10499015', '1', '0', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(197, '10499015', '1', '500', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(198, '10499015', '1', '500', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(199, '10499015', '1', '500', 'HON-3141', '2', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(200, '12104000', '20', '120', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(201, '11803000', '20', '200', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(202, '11812002', '20', '100', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(203, '11812010', '25', '200', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(204, '11803002', '25', '120', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(205, '11812008', '25', '80', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(206, '11710050', '20', '50', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(207, '11710052', '20', '100', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(208, '11710055', '25', '80', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(209, '12301000', '20', '100', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(210, '12303000', '20', '100', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(211, '13403010', '25', '240', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(212, '12003050', '20', '200', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(213, '12003051', '20', '100', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(214, '12003061', '25', '80', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(215, '12003062', '25', '40', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(216, '12003060', '25', '240', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(217, '12003001', '25', '80', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(218, '12002998', '25', '160', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(219, '12002999', '25', '240', 'HON-3131', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(220, '12004001', '20', '100', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(221, '12004000', '20', '100', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(222, '12003003', '20', '50', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(223, '12003002', '20', '50', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(224, '12003005', '20', '50', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(225, '12003007', '20', '50', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(226, '12005003', '20', '100', 'HON-3130', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(227, '11707003', '40', '800', 'FTT-1474', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(228, '09906000', '12', '30', 'HON-3140', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(229, '09906012', '16', '120', 'HON-3140', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(230, '09906018', '16', '30', 'HON-3140', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(231, '09906035', '16', '20', 'HON-3140', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(232, '09906037', '15', '50', 'HON-3140', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(233, '09906039', '15', '80', 'HON-3140', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(234, '10610017', '15', '50', 'HON-3136', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(235, '10610018', '15', '50', 'HON-3136', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(236, '10610019', '15', '50', 'HON-3136', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(237, '10610020', '15', '100', 'HON-3136', '3', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(238, '00503009', '20', '50', 'INT-H-1238', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(239, '00504100', '20', '5', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(240, '00504007', '100', '4', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(241, '00508011', '30', '10', 'INT-H-1237', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(242, '00503008', '20', '20', 'INT-H-1238', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(243, '00504101', '20', '20', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(244, '00504101', '20', '10', 'INT-H-1239', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(245, '00504003', '20', '20', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(246, '00508001', '20', '10', 'INT-H-1239', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(247, '00303050', '10', '15', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(248, '00303007', '10', '50', 'INT-H-1238', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(249, '00303007', '10', '20', 'INT-H-1236', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(250, '00303007', '10', '16', 'INT-H-1239', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(251, '00407000', '50', '28', 'INT-H-1212', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(252, '00408000', '20', '7', 'INT-H-1238', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(253, '10104210', '20', '7', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(254, '00303051', '10', '10', 'INT-H-1240', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(255, '00303051', '10', '4', 'INT-H-1239', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(256, '20005000', '20', '19', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(257, '20005000', '20', '10', 'INT-H-1238', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(258, '20005010', '10', '5', 'INT-H-1239', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(259, '20005007', '20', '10', 'INT-H-1238', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(260, '20005010', '10', '20', 'INT-H-1238', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(261, '00504032', '20', '5', 'INT-H-1239', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(262, '00703003', '20', '23', 'INT-H-1212', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(263, '00704003', '20', '5', 'INT-H-1239', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(264, '00302007', '20', '50', 'INT-H-1237', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(265, '00302007', '20', '5', 'INT-H-1239', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(266, '00302009', '20', '2', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(267, '00302004', '20', '1', 'INT-H-1212', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(268, '00303065', '20', '10', 'INT-H-1212', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(269, '00507001', '50', '34', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(270, '20018002', '20', '30', 'INT-H-1237', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(271, '12506001', '100', '2', 'INT-H-1235', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(272, '12506021', '20', '4', 'INT-H-1238', '4', '2021-06-18 03:05:43', '2021-06-18 03:05:43'),
(273, '00107000', '50', '10', 'INT-H-1234', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(274, '603004002', '20', '12', 'INT-H-1235', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(275, '01607602', '20', '8', 'INT-H-1235', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(276, '01607602', '20', '10', 'INT-H-1239', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(277, '01607603', '20', '10', 'INT-H-1239', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(278, '01606677', '20', '15', 'INT-H-1235', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(279, '01606678', '20', '19', 'INT-H-1235', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(280, '01606678', '20', '5', 'INT-H-1239', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(281, '01606677', '20', '10', 'INT-H-1239', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(282, '10104750', '20', '30', 'INT-H-1235', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(283, '10104754', '20', '20', 'INT-H-1237', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(284, '00504150', '20', '4', 'INT-H-1235', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(285, '00504150', '20', '2', 'INT-H-1239', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(286, '00110347', '20', '20', 'INT-H-1233', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44'),
(287, '00110346', '20', '30', 'INT-H-1233', '4', '2021-06-18 03:05:44', '2021-06-18 03:05:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pendiente`
--

DROP TABLE IF EXISTS `pendiente`;
CREATE TABLE IF NOT EXISTS `pendiente` (
  `id_pendiente` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` int(11) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `orden_del_sitema` varchar(50) DEFAULT NULL,
  `observacion` varchar(50) DEFAULT NULL,
  `presentacion` varchar(50) DEFAULT NULL,
  `mes` varchar(50) DEFAULT NULL,
  `orden` varchar(50) DEFAULT NULL,
  `marca` int(11) DEFAULT NULL,
  `vitola` int(11) DEFAULT NULL,
  `nombre` int(11) DEFAULT NULL,
  `capa` int(11) DEFAULT NULL,
  `tipo_empaque` int(11) DEFAULT NULL,
  `cello` int(11) DEFAULT NULL,
  `pendiente` int(11) DEFAULT NULL,
  `saldo` int(11) DEFAULT NULL,
  `paquetes` varchar(50) DEFAULT NULL,
  `unidades` varchar(50) DEFAULT NULL,
  `serie_precio` varchar(50) DEFAULT NULL,
  `precio` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pendiente`)
) ENGINE=InnoDB AUTO_INCREMENT=1579 DEFAULT CHARSET=latin1 COMMENT='CATEGORIA	ITEM	ORDEN DEL SISTEMA	OBSERVACÓN	PRESENTACIÓN	MES	ORDEN	MARCA	VITOLA	NOMBRE	CAPA	TIPO DE EMPAQUE	ANILLO	CELLO	UPC	PENDIENTE	MARZO 2021 FACTURA #17976(Warehouse)	ENVIADO MES	SALDO';

--
-- Volcado de datos para la tabla `pendiente`
--

INSERT INTO `pendiente` (`id_pendiente`, `categoria`, `item`, `orden_del_sitema`, `observacion`, `presentacion`, `mes`, `orden`, `marca`, `vitola`, `nombre`, `capa`, `tipo_empaque`, `cello`, `pendiente`, `saldo`, `paquetes`, `unidades`, `serie_precio`, `precio`) VALUES
(3, 4, '09903021', '3171', NULL, NULL, 'AGOSTO 2020', 'INT-H-1190', 87, 2, 1, 6, 10, 1, 400, 400, '0', '0', NULL, NULL),
(4, 1, '603004002', '3182', NULL, NULL, 'SEPTIEMBRE 2020', 'HON-3011', 88, 4, 3, 1, 7, 1, 1120, 1120, '0', '0', NULL, NULL),
(5, 1, '603005751', '3182', NULL, NULL, 'SEPTIEMBRE 2020', 'HON-3000', 92, 4, 2, 1, 4, 1, 7500, 7000, '0', '0', NULL, NULL),
(6, 1, '603005751', '3182', NULL, NULL, 'SEPTIEMBRE 2020', 'HON-3011', 92, 4, 2, 1, 4, 1, 5280, 5280, '0', '0', NULL, NULL),
(7, 1, '01607604', '3182', NULL, NULL, 'SEPTIEMBRE 2020', 'HON-3011', 95, 5, 31, 11, 7, 1, 6000, 40, '0', '0', NULL, NULL),
(8, 1, '603004002', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3030', 88, 4, 3, 1, 7, 1, 800, 800, '0', '0', NULL, NULL),
(9, 1, '603004002', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3039', 88, 4, 3, 1, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(10, 1, '20005007', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3039', 90, 9, 26, 3, 7, 1, 800, 400, '0', '0', NULL, NULL),
(11, 1, '603005751', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3039', 92, 4, 2, 1, 4, 1, 2600, 2600, '0', '0', NULL, NULL),
(12, 1, '08503515', '3187', NULL, NULL, 'OCTUBRE 2020', 'FTT-1447', 112, 1, 1, 2, 10, 1, 10000, 1000, '0', '0', NULL, NULL),
(13, 1, '00505007', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3039', 51, 4, 14, 2, 18, 3, 2000, 400, '0', '0', NULL, NULL),
(14, 4, '001105053', '3187', NULL, NULL, 'OCTUBRE 2020', 'INT-H-1201', 115, 27, 30, 5, 20, 4, 1120, 1120, '0', '0', NULL, NULL),
(15, 4, '001105053', '3187', NULL, NULL, 'OCTUBRE 2020', 'INT-H-1201', 115, 27, 30, 5, 20, 4, 1200, 1200, '0', '0', NULL, NULL),
(16, 4, '00503008', '3187', NULL, NULL, 'OCTUBRE 2020', 'INT-H-1200', 51, 6, 43, 2, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(17, 4, '10104212', '3187', NULL, NULL, 'OCTUBRE 2020', 'INT-H-1206', 14, 16, 21, 3, 7, 1, 240, 240, '0', '0', NULL, NULL),
(18, 4, '20005007', '3187', NULL, NULL, 'OCTUBRE 2020', 'INT-H-1200', 90, 9, 26, 3, 7, 1, 800, 800, '0', '0', NULL, NULL),
(19, 4, '01607602', '3187', NULL, NULL, 'OCTUBRE 2020', 'INT-H-1200', 95, 3, 2, 11, 7, 1, 800, 800, '0', '0', NULL, NULL),
(20, 4, '01607603', '3187', NULL, NULL, 'OCTUBRE 2020', 'INT-H-1209', 95, 9, 11, 11, 7, 1, 400, 400, '0', '0', NULL, NULL),
(21, 4, '01607600', '3187', NULL, NULL, 'OCTUBRE 2020', 'INT-H-1209', 95, 20, 30, 11, 7, 1, 800, 800, '0', '0', NULL, NULL),
(22, 2, '10499012', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3027', 51, 4, 2, 5, 10, 1, 10000, 1000, '0', '0', NULL, NULL),
(23, 2, '10499012', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3027', 113, 4, 2, 1, 10, 1, 10000, 1000, '0', '0', NULL, NULL),
(24, 2, '10499012', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3027', 152, 4, 2, 8, 10, 1, 10000, 1000, '0', '0', NULL, NULL),
(25, 2, '10499012', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3027', 15, 4, 3, 2, 10, 1, 10000, 1000, '0', '0', NULL, NULL),
(26, 2, '10499012', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3027', 147, 4, 3, 3, 10, 1, 10000, 1000, '0', '0', NULL, NULL),
(27, 3, '12005003', '3187', NULL, NULL, 'OCTUBRE 2020', 'HON-3022', 133, 9, 11, 2, 7, 1, 1500, 500, '0', '0', NULL, NULL),
(28, 1, '603004002', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3063', 88, 4, 3, 1, 7, 1, 800, 800, '0', '0', NULL, NULL),
(29, 1, '603005751', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3063', 92, 4, 2, 1, 4, 1, 2400, 2400, '0', '0', NULL, NULL),
(30, 1, '10105510', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3058', 140, 1, 1, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(31, 1, '10105511', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3058', 140, 5, 4, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(32, 1, '10105513', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3058', 140, 16, 14, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(33, 1, '1010517', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3058', 140, 1, 1, 14, 7, 1, 200, 200, '0', '0', NULL, NULL),
(34, 1, '10105518', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3058', 140, 5, 4, 14, 7, 1, 200, 200, '0', '0', NULL, NULL),
(35, 1, '10105519', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3058', 140, 16, 14, 14, 7, 1, 200, 200, '0', '0', NULL, NULL),
(36, 1, '13105265', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3057', 143, 2, 1, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(37, 1, '13105266', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3057', 143, 3, 2, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(38, 1, '13105267', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3057', 143, 5, 4, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(39, 1, '13105268', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3057', 143, 9, 16, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(40, 1, '01607601', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3063', 95, 2, 1, 11, 7, 1, 1600, 100, '0', '0', NULL, NULL),
(41, 1, '00110287', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3063', 72, 4, 2, 6, 10, 1, 16800, 8800, '0', '0', NULL, NULL),
(42, 1, '00404000', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3063', 67, 3, 2, 3, 7, 3, 16000, 400, '0', '0', NULL, NULL),
(43, 1, '00504032', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3063', 51, 4, 2, 3, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(44, 1, '13105210', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'HON-3056', 102, 1, 1, 2, 7, 1, 360, 360, '0', '0', NULL, NULL),
(45, 2, '47801434', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'FTT-1450', 116, 4, 2, 2, 10, 1, 10000, 700, '0', '0', NULL, NULL),
(46, 4, '00508010', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1210', 51, 21, 33, 5, 19, 1, 810, 810, '0', '0', NULL, NULL),
(47, 4, '00504100', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1213', 51, 2, 1, 5, 7, 1, 200, 200, '0', '0', NULL, NULL),
(48, 4, '00605002', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 51, 14, 17, 5, 13, 3, 1500, 300, '0', '0', NULL, NULL),
(49, 4, '00504003', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 51, 4, 2, 2, 7, 3, 1000, 1000, '0', '0', NULL, NULL),
(50, 4, '10104227', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1210', 14, 33, 58, 3, 7, 1, 100, 100, '0', '0', NULL, NULL),
(51, 4, '10104182', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1210', 14, 6, 59, 3, 7, 1, 300, 300, '0', '0', NULL, NULL),
(52, 4, '20005010', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 90, 3, 35, 3, 4, 0, 2000, 2000, '0', '0', NULL, NULL),
(53, 4, '00702000', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 99, 33, 30, 6, 7, 1, 460, 460, '0', '0', NULL, NULL),
(54, 4, '00507001', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1210', 159, 15, 62, 6, 15, 1, 400, 400, '0', '0', NULL, NULL),
(55, 4, '00507001', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1213', 159, 15, 62, 6, 15, 1, 4000, 4000, '0', '0', NULL, NULL),
(56, 4, '603005750', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1213', 92, 2, 1, 1, 4, 1, 750, 750, '0', '0', NULL, NULL),
(57, 4, '603005751', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1214-W', 92, 4, 2, 1, 4, 1, 7710, 7710, '0', '0', NULL, NULL),
(58, 4, '603005752', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1213', 92, 9, 11, 1, 4, 1, 900, 900, '0', '0', NULL, NULL),
(59, 4, '01604010', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1213', 109, 24, 41, 1, 7, 1, 1540, 1540, '0', '0', NULL, NULL),
(60, 4, '01604013', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1213', 109, 38, 57, 1, 7, 1, 1400, 1400, '0', '0', NULL, NULL),
(61, 4, '01604011', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1213', 109, 3, 2, 1, 7, 1, 1900, 1900, '0', '0', NULL, NULL),
(62, 4, '01605003', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 109, 24, 41, 1, 10, 1, 500, 500, '0', '0', NULL, NULL),
(63, 4, '00107000', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1214-W', 141, 15, 53, 9, 15, 1, 6100, 6100, '0', '0', NULL, NULL),
(64, 4, '603004033', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1211', 88, 26, 63, 1, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(65, 4, '01606675', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 40, 20, 30, 5, 7, 1, 60, 60, '0', '0', NULL, NULL),
(66, 4, '01606675', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1213', 40, 20, 30, 5, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(67, 4, '01606689', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 40, 2, 1, 5, 10, 1, 500, 500, '0', '0', NULL, NULL),
(68, 4, '01606678', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 40, 3, 2, 5, 7, 1, 3000, 3000, '0', '0', NULL, NULL),
(69, 4, '00231001', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 160, 15, 64, 4, 15, 1, 2400, 2400, '0', '0', NULL, NULL),
(70, 4, '00504150', '3193', NULL, NULL, 'NOVIEMBRE 2020', 'INT-H-1212', 51, 4, 2, 15, 7, 1, 1640, 1640, '0', '0', NULL, NULL),
(71, 1, '13105280', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3078', 163, 2, 65, 5, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(72, 1, '13105281', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3078', 163, 4, 66, 5, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(73, 1, '00110197', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3086', 52, 12, 13, 3, 12, 1, 75, 75, '0', '0', NULL, NULL),
(74, 1, '001103990', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3090', 164, 4, 2, 2, 7, 1, 500, 500, '0', '0', NULL, NULL),
(75, 1, '001103992', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3090', 164, 1, 1, 2, 7, 1, 500, 500, '0', '0', NULL, NULL),
(76, 1, '00404009', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3076', 67, 3, 2, 3, 11, 1, 6000, 4000, '0', '0', NULL, NULL),
(77, 1, '01004012', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3072', 90, 3, 3, 3, 12, 1, 1500, 1500, '0', '0', NULL, NULL),
(78, 1, '01004012', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3083', 90, 3, 3, 3, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(79, 1, '10104132', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3068', 51, 6, 67, 3, 7, 1, 800, 800, '0', '0', NULL, NULL),
(80, 1, '00110396', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3090', 164, 1, 1, 3, 7, 1, 500, 500, '0', '0', NULL, NULL),
(81, 1, '00110398', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3090', 164, 4, 2, 3, 7, 1, 500, 500, '0', '0', NULL, NULL),
(82, 1, '00110390', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3090', 164, 4, 2, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(83, 1, '00110392', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3090', 164, 1, 1, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(84, 1, '08503515', '3197', NULL, NULL, 'DICIEMBRE 2020', 'FTT-1456', 112, 1, 1, 2, 10, 1, 20000, 20000, '0', '0', NULL, NULL),
(85, 1, '08503516', '3197', NULL, NULL, 'DICIEMBRE 2020', 'FTT-1456', 112, 4, 2, 2, 10, 1, 40000, 12000, '0', '0', NULL, NULL),
(86, 2, '603004050', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3076', 88, 4, 3, 13, 11, 1, 5000, 5000, '0', '0', NULL, NULL),
(87, 2, '00404009', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3085', 67, 3, 2, 3, 11, 1, 11250, 5250, '0', '0', NULL, NULL),
(88, 2, '00303110', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3082', 15, 35, 56, 19, 27, 1, 0, 0, '0', '0', NULL, NULL),
(89, 2, '00303110', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3082', 15, 35, 56, 19, 27, 1, 0, 0, '0', '0', NULL, NULL),
(90, 2, '00303110', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3082', 15, 35, 56, 19, 27, 1, 0, 0, '0', '0', NULL, NULL),
(91, 2, '00303110', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3082', 101, 35, 56, 4, 12, 1, 5000, 5000, '0', '0', NULL, NULL),
(92, 2, '00303110', '3197', NULL, NULL, 'DICIEMBRE 2020', 'HON-3082', 180, 35, 56, 19, 27, 1, 0, 0, '0', '0', NULL, NULL),
(93, 4, '001105048', '3197', NULL, NULL, 'DICIEMBRE 2020', 'INT-H-1219-W', 115, 28, 43, 5, 20, 4, 640, 640, '0', '0', NULL, NULL),
(94, 4, '001105048', '3197', NULL, NULL, 'DICIEMBRE 2020', 'INT-H-1218', 115, 28, 43, 5, 20, 4, 160, 160, '0', '0', NULL, NULL),
(95, 4, '09903021', '3197', NULL, NULL, 'DICIEMBRE 2020', 'INT-H-1217', 87, 2, 1, 6, 10, 1, 300, 300, '0', '0', NULL, NULL),
(96, 4, '09903020', '3197', NULL, NULL, 'DICIEMBRE 2020', 'INT-H-1217', 87, 3, 2, 6, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(97, 1, '603004002', '3201', NULL, NULL, 'ENERO 2021', 'HON-3100', 88, 4, 3, 1, 7, 1, 3200, 3200, '0', '0', NULL, NULL),
(98, 1, '00404000', '3201', NULL, NULL, 'ENERO 2021', 'HON-3100', 67, 3, 2, 3, 7, 3, 8800, 8800, '0', '0', NULL, NULL),
(99, 1, '00508001', '3201', NULL, NULL, 'ENERO 2021', 'HON-3100', 51, 9, 32, 2, 7, 3, 14000, 3560, '0', '0', NULL, NULL),
(100, 1, '00504024', '3201', NULL, NULL, 'ENERO 2021', 'HON-3100', 51, 4, 2, 3, 18, 1, 18000, 18000, '0', '0', NULL, NULL),
(101, 1, '00504032', '3201', NULL, NULL, 'ENERO 2021', 'HON-3100', 51, 4, 2, 3, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(102, 1, '12506020', '3201', NULL, NULL, 'ENERO 2021', 'HON-3100', 61, 4, 2, 1, 7, 1, 7600, 880, '0', '0', NULL, NULL),
(103, 1, '10104750', '3201', NULL, NULL, 'ENERO 2021', 'HON-3100', 101, 2, 5, 4, 7, 1, 8800, 4300, '0', '0', NULL, NULL),
(104, 1, '10104751', '3201', NULL, NULL, 'ENERO 2021', 'HON-3100', 101, 3, 35, 4, 7, 1, 9200, 600, '0', '0', NULL, NULL),
(105, 1, '13105213', '3201', NULL, NULL, 'ENERO 2021', 'HON-3095', 102, 9, 39, 2, 7, 1, 200, 200, '0', '0', NULL, NULL),
(106, 4, '15212095', '3201', NULL, NULL, 'ENERO 2021', 'INT-H-1220', 187, 4, 2, 1, 18, 1, 4500, 4500, '0', '0', NULL, NULL),
(107, 4, '15212093', '3201', NULL, NULL, 'ENERO 2021', 'INT-H-1220', 187, 4, 2, 1, 9, 1, 1500, 1500, '0', '0', NULL, NULL),
(108, 1, '603004002', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 88, 4, 3, 1, 7, 1, 17600, 17600, '0', '0', NULL, NULL),
(109, 1, '603004023', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3112', 88, 4, 3, 1, 12, 1, 5000, 5000, '0', '0', NULL, NULL),
(110, 1, '603004023', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3109', 88, 4, 3, 1, 12, 1, 3000, 3000, '0', '0', NULL, NULL),
(111, 2, '603004031', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3117', 88, 4, 3, 1, 11, 1, 500, 500, '0', '0', NULL, NULL),
(112, 1, '10604072', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3113', 190, 39, 42, 6, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(113, 1, '10504018', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3108', 70, 1, 1, 6, 7, 1, 400, 400, '0', '0', NULL, NULL),
(114, 2, '15406001', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 191, 3, 14, 4, 7, 1, 200, 200, '0', '0', NULL, NULL),
(115, 2, '47801009', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 168, 2, 1, 6, 10, 1, 5700, 5700, '0', '0', NULL, NULL),
(116, 2, '47801009', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 168, 4, 2, 6, 10, 1, 5700, 5700, '0', '0', NULL, NULL),
(117, 2, '47801009', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 168, 3, 14, 6, 10, 1, 5700, 5700, '0', '0', NULL, NULL),
(118, 2, '47801009', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 168, 5, 4, 6, 10, 1, 5700, 5700, '0', '0', NULL, NULL),
(119, 2, '47801005', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3121', 168, 2, 1, 6, 12, 1, 6000, 400, '0', '0', NULL, NULL),
(120, 2, '47801011', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 168, 4, 2, 6, 11, 1, 16300, 13800, '0', '0', NULL, NULL),
(121, 2, '47801002', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 168, 3, 14, 6, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(122, 2, '47801012', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 168, 9, 69, 6, 7, 1, 2000, 320, '0', '0', NULL, NULL),
(123, 2, '47801012', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 168, 9, 69, 6, 7, 1, 4000, 1000, '0', '0', NULL, NULL),
(124, 1, '13099006', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3108', 64, 3, 3, 1, 7, 1, 200, 200, '0', '0', NULL, NULL),
(125, 1, '13099005', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3108', 64, 1, 1, 1, 7, 1, 500, 500, '0', '0', NULL, NULL),
(126, 1, '13099011', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3108', 65, 5, 38, 6, 7, 1, 100, 100, '0', '0', NULL, NULL),
(127, 1, '13099009', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3108', 65, 1, 1, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(128, 1, '13099013', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3108', 68, 1, 6, 3, 7, 1, 100, 100, '0', '0', NULL, NULL),
(129, 1, '13099014', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3108', 68, 3, 3, 3, 7, 1, 100, 100, '0', '0', NULL, NULL),
(130, 1, '13099015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3108', 68, 5, 51, 3, 7, 1, 500, 500, '0', '0', NULL, NULL),
(131, 4, '20005010', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1229', 90, 3, 35, 3, 4, 0, 30, 30, '0', '0', NULL, NULL),
(132, 4, '20005010', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 90, 3, 35, 3, 4, 0, 100, 100, '0', '0', NULL, NULL),
(133, 1, '003041625', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3106', 90, 3, 35, 3, 11, 0, 37000, 19500, '0', '0', NULL, NULL),
(134, 1, '20005000', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 90, 1, 6, 3, 7, 1, 20000, 20000, '0', '0', NULL, NULL),
(135, 1, '20005002', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 90, 3, 21, 3, 7, 3, 23200, 18000, '0', '0', NULL, NULL),
(136, 1, '20005001', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 90, 3, 3, 3, 7, 3, 52800, 32240, '0', '0', NULL, NULL),
(137, 2, '10499015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 457, 3, 2, 19, 11, 1, 0, 0, '0', '0', NULL, NULL),
(138, 2, '10499015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 754, 3, 2, 19, 11, 1, 0, 0, '0', '0', NULL, NULL),
(139, 2, '10499015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 90, 3, 3, 3, 11, 1, 700, 700, '0', '0', NULL, NULL),
(140, 2, '10499015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 15, 3, 3, 2, 11, 1, 700, 700, '0', '0', NULL, NULL),
(141, 2, '10499015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 51, 4, 2, 3, 11, 1, 700, 700, '0', '0', NULL, NULL),
(142, 1, '19904004', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3110', 107, 24, 1, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(143, 1, '19904005', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3110', 107, 3, 2, 6, 7, 1, 320, 320, '0', '0', NULL, NULL),
(144, 1, '19904006', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3110', 107, 28, 14, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(145, 1, '19904007', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3110', 107, 42, 34, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(146, 1, '12404014', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3110', 107, 24, 1, 5, 7, 1, 500, 500, '0', '0', NULL, NULL),
(147, 1, '12404015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3110', 107, 3, 2, 5, 7, 1, 500, 500, '0', '0', NULL, NULL),
(148, 1, '12404036', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3110', 107, 38, 69, 6, 7, 1, 500, 500, '0', '0', NULL, NULL),
(149, 1, '12404035', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3110', 107, 38, 69, 5, 7, 1, 400, 400, '0', '0', NULL, NULL),
(150, 1, '00508020', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 91, 4, 2, 10, 7, 1, 39200, 29600, '0', '0', NULL, NULL),
(151, 1, '00508030', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3109', 91, 4, 2, 10, 12, 1, 1500, 1500, '0', '0', NULL, NULL),
(152, 2, '00804066', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 209, 3, 3, 2, 7, 1, 480, 480, '0', '0', NULL, NULL),
(153, 1, '13105120', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 210, 2, 1, 3, 4, 0, 3600, 1300, '0', '0', NULL, NULL),
(154, 2, '15203002', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 211, 1, 1, 6, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(155, 2, '15205000', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 211, 3, 14, 6, 7, 1, 800, 800, '0', '0', NULL, NULL),
(156, 2, '15403024', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 211, 4, 2, 6, 11, 1, 750, 750, '0', '0', NULL, NULL),
(157, 1, '603005751', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 92, 4, 2, 1, 4, 1, 17000, 17000, '0', '0', NULL, NULL),
(158, 1, '603005750', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 92, 2, 1, 1, 4, 1, 8400, 1400, '0', '0', NULL, NULL),
(159, 1, '603005752', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 92, 9, 11, 1, 4, 1, 6000, 3600, '0', '0', NULL, NULL),
(160, 1, '10106501', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3122', 213, 4, 2, 9, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(161, 1, '10106511', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3122', 213, 4, 2, 9, 12, 1, 1000, 1000, '0', '0', NULL, NULL),
(162, 4, '00407000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1227', 158, 15, 46, 9, 15, 1, 1500, 1500, '0', '0', NULL, NULL),
(163, 4, '00407000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1229', 158, 15, 46, 9, 15, 1, 100, 100, '0', '0', NULL, NULL),
(164, 4, '00407000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 158, 15, 46, 9, 15, 1, 250, 250, '0', '0', NULL, NULL),
(165, 4, '00107000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1225', 141, 15, 53, 9, 15, 1, 50, 50, '0', '0', NULL, NULL),
(166, 4, '00107000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1229', 141, 15, 53, 9, 15, 1, 300, 300, '0', '0', NULL, NULL),
(167, 4, '00107000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1230', 141, 15, 53, 9, 15, 1, 250, 250, '0', '0', NULL, NULL),
(168, 1, '9900004022', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3125', 53, 2, 1, 1, 10, 1, 15000, 5000, '0', '0', NULL, NULL),
(169, 1, '01604013', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 109, 38, 57, 1, 7, 1, 400, 400, '0', '0', NULL, NULL),
(170, 1, '01604012', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 109, 28, 14, 1, 7, 1, 800, 800, '0', '0', NULL, NULL),
(171, 1, '01604011', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 109, 3, 2, 1, 7, 1, 800, 800, '0', '0', NULL, NULL),
(172, 4, '01606676', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1224', 40, 2, 1, 5, 7, 1, 20, 20, '0', '0', NULL, NULL),
(173, 4, '01606676', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1226', 40, 2, 1, 5, 7, 1, 100, 100, '0', '0', NULL, NULL),
(174, 4, '01606676', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1227', 40, 2, 1, 5, 7, 1, 400, 400, '0', '0', NULL, NULL),
(175, 1, '003041630', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3106', 40, 25, 2, 5, 11, 0, 33000, 33000, '0', '0', NULL, NULL),
(176, 4, '01606678', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1224', 40, 3, 2, 5, 7, 1, 20, 20, '0', '0', NULL, NULL),
(177, 4, '01606678', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1226', 40, 3, 2, 5, 7, 1, 100, 100, '0', '0', NULL, NULL),
(178, 4, '01606678', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1227', 40, 3, 2, 5, 7, 1, 80, 80, '0', '0', NULL, NULL),
(179, 1, '00903004', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3105', 74, 18, 6, 5, 12, 1, 5000, 4350, '0', '0', NULL, NULL),
(180, 2, '14399001', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 147, 3, 3, 3, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(181, 2, '14399001', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 147, 3, 3, 3, 7, 1, 1800, 1800, '0', '0', NULL, NULL),
(182, 2, '14399006', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 147, 3, 3, 3, 11, 1, 3750, 3750, '0', '0', NULL, NULL),
(183, 2, '14399005', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3102', 147, 2, 6, 3, 11, 1, 700, 700, '0', '0', NULL, NULL),
(184, 2, '14399005', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 147, 2, 6, 3, 11, 1, 1100, 1100, '0', '0', NULL, NULL),
(185, 3, '09906010', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3119', 181, 9, 11, 6, 20, 4, 1280, 1280, '0', '0', NULL, NULL),
(186, 3, '09906010', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 181, 9, 11, 6, 20, 4, 9600, 9600, '0', '0', NULL, NULL),
(187, 3, '09906012', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3119', 181, 4, 2, 6, 20, 4, 1200, 1200, '0', '0', NULL, NULL),
(188, 3, '09906016', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 181, 31, 4, 6, 20, 4, 1920, 1920, '0', '0', NULL, NULL),
(189, 3, '09906034', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 181, 2, 1, 6, 20, 4, 1920, 1920, '0', '0', NULL, NULL),
(190, 3, '09906034', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3119', 181, 2, 1, 6, 20, 4, 640, 640, '0', '0', NULL, NULL),
(191, 3, '09906035', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3119', 161, 4, 2, 2, 20, 4, 400, 400, '0', '0', NULL, NULL),
(192, 3, '09906037', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 182, 3, 2, 3, 22, 4, 2100, 2100, '0', '0', NULL, NULL),
(193, 3, '09906037', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3119', 182, 3, 2, 3, 22, 4, 1500, 1500, '0', '0', NULL, NULL),
(194, 3, '09906039', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3119', 182, 9, 40, 3, 22, 4, 750, 750, '0', '0', NULL, NULL),
(195, 2, '47801891', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1467', 57, 3, 14, 1, 9, 1, 2600, 2600, '0', '0', NULL, NULL),
(196, 4, '01607602', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1224', 95, 3, 2, 11, 7, 1, 20, 20, '0', '0', NULL, NULL),
(197, 4, '01607602', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1226', 95, 3, 2, 11, 7, 1, 40, 40, '0', '0', NULL, NULL),
(198, 1, '12503500', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1465', 111, 1, 1, 3, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(199, 1, '12503501', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1465', 111, 5, 4, 3, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(200, 1, '12503502', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1465', 111, 4, 14, 3, 10, 1, 4000, 4000, '0', '0', NULL, NULL),
(201, 1, '12503503', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1465', 111, 9, 39, 3, 10, 1, 4000, 3100, '0', '0', NULL, NULL),
(202, 1, '12503511', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1465', 111, 5, 4, 6, 10, 1, 2400, 600, '0', '0', NULL, NULL),
(203, 1, '12503512', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1465', 111, 4, 14, 6, 10, 1, 4000, 1500, '0', '0', NULL, NULL),
(204, 1, '12503518', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1465', 111, 1, 1, 1, 10, 1, 2000, 500, '0', '0', NULL, NULL),
(205, 1, '12503519', '3207', NULL, NULL, 'FEBRERO 2021', 'FTT-1465', 111, 5, 4, 1, 10, 1, 3000, 1500, '0', '0', NULL, NULL),
(206, 4, '00401000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1225', 67, 19, 25, 3, 7, 3, 100, 100, '0', '0', NULL, NULL),
(207, 4, '00403000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1225', 67, 2, 1, 3, 7, 3, 100, 100, '0', '0', NULL, NULL),
(208, 4, '00403000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1226', 67, 2, 1, 3, 7, 3, 40, 40, '0', '0', NULL, NULL),
(209, 4, '00403000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1230', 67, 2, 1, 3, 7, 3, 200, 200, '0', '0', NULL, NULL),
(210, 4, '00403000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 67, 2, 1, 3, 7, 3, 100, 100, '0', '0', NULL, NULL),
(211, 2, '13403000', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3117', 67, 2, 1, 3, 11, 1, 1500, 1500, '0', '0', NULL, NULL),
(212, 1, '0404000', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 67, 3, 2, 3, 7, 3, 12400, 12400, '0', '0', NULL, NULL),
(213, 1, '00404005', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3112', 67, 3, 2, 3, 12, 1, 5000, 5000, '0', '0', NULL, NULL),
(214, 2, '00404009', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3102', 67, 3, 2, 3, 11, 1, 6000, 6000, '0', '0', NULL, NULL),
(215, 4, '00408000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1227', 67, 9, 40, 3, 7, 3, 200, 200, '0', '0', NULL, NULL),
(216, 1, '003041640', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3106', 67, 25, 2, 3, 11, 2, 32000, 32000, '0', '0', NULL, NULL),
(217, 1, '00405000', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 67, 16, 14, 3, 7, 3, 400, 400, '0', '0', NULL, NULL),
(218, 4, '00405000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1226', 67, 16, 14, 3, 7, 3, 40, 40, '0', '0', NULL, NULL),
(219, 2, '41112001', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3102', 59, 22, 74, 1, 11, 1, 600, 600, '0', '0', NULL, NULL),
(220, 2, '01103006', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 59, 4, 3, 2, 11, 1, 250, 250, '0', '0', NULL, NULL),
(221, 2, '10499013', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 59, 38, 68, 2, 20, 1, 3200, 3200, '0', '0', NULL, NULL),
(222, 2, '10499013', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 152, 9, 69, 8, 20, 1, 3200, 3200, '0', '0', NULL, NULL),
(223, 2, '10499013', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 51, 9, 32, 2, 20, 1, 3200, 3200, '0', '0', NULL, NULL),
(224, 2, '10499013', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3101', 28, 9, 11, 19, 20, 1, 0, 0, '0', '0', NULL, NULL),
(225, 2, '01103010', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3102', 59, 38, 68, 2, 11, 1, 1250, 1250, '0', '0', NULL, NULL),
(226, 2, '01103010', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 59, 38, 68, 2, 11, 1, 1350, 1350, '0', '0', NULL, NULL),
(227, 4, '00504002', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1227', 51, 4, 2, 5, 7, 3, 400, 400, '0', '0', NULL, NULL),
(228, 4, '00504007', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 51, 4, 2, 2, 18, 3, 500, 500, '0', '0', NULL, NULL),
(229, 4, '00504003', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1224', 51, 4, 2, 2, 7, 3, 20, 20, '0', '0', NULL, NULL),
(230, 4, '00504003', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1229', 51, 4, 2, 2, 7, 3, 100, 100, '0', '0', NULL, NULL),
(231, 1, '00504010', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3112', 51, 4, 2, 2, 12, 1, 10000, 400, '0', '0', NULL, NULL),
(232, 1, '10104816', '3207', 'Santa Clara Firts Version', NULL, 'FEBRERO 2021', 'HON-3111', 51, 4, 2, 2, 11, 1, 2500, 500, '0', '0', NULL, NULL),
(233, 1, '00904038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 51, 4, 2, 2, 14, 1, 1410, 1410, '0', '0', NULL, NULL),
(234, 1, '00904038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 51, 4, 2, 5, 14, 1, 1410, 1410, '0', '0', NULL, NULL),
(235, 1, '00904038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 51, 4, 2, 1, 14, 1, 1410, 1410, '0', '0', NULL, NULL),
(236, 1, '00904038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 51, 4, 2, 3, 14, 1, 1410, 1410, '0', '0', NULL, NULL),
(237, 1, '00904038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 2, 14, 1, 59100, 45600, '0', '0', NULL, NULL),
(238, 1, '00904038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 5, 14, 1, 59100, 45600, '0', '0', NULL, NULL),
(239, 1, '00904038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 1, 14, 1, 59100, 45600, '0', '0', NULL, NULL),
(240, 1, '00904038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 3, 14, 1, 59100, 45600, '0', '0', NULL, NULL),
(241, 1, '00505002', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 4, 14, 5, 7, 3, 17200, 400, '0', '0', NULL, NULL),
(242, 4, '00505003', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1229', 51, 4, 14, 2, 7, 3, 100, 100, '0', '0', NULL, NULL),
(243, 4, '00504100', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 51, 2, 1, 5, 7, 1, 200, 200, '0', '0', NULL, NULL),
(244, 1, '10104912', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 2, 1, 5, 23, 1, 36900, 26900, '0', '0', NULL, NULL),
(245, 4, '00504101', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1224', 51, 2, 1, 2, 7, 3, 20, 20, '0', '0', NULL, NULL),
(246, 4, '00605003', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1225', 51, 14, 17, 2, 13, 3, 250, 250, '0', '0', NULL, NULL),
(247, 1, '00508001', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 9, 32, 2, 7, 3, 18000, 18000, '0', '0', NULL, NULL),
(248, 1, '00504102', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 22, 34, 5, 7, 1, 2800, 1600, '0', '0', NULL, NULL),
(249, 1, '00504103', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 22, 34, 2, 7, 1, 3600, 3000, '0', '0', NULL, NULL),
(250, 1, '00504024', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 3, 18, 1, 68000, 68000, '0', '0', NULL, NULL),
(251, 1, '00504032', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 3, 7, 1, 11600, 11600, '0', '0', NULL, NULL),
(252, 1, '00504038', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3107', 51, 4, 14, 3, 12, 1, 7500, 5100, '0', '0', NULL, NULL),
(253, 4, '00508015', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1227', 51, 11, 12, 5, 4, 1, 200, 200, '0', '0', NULL, NULL),
(254, 1, '00508016', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 51, 11, 12, 2, 4, 1, 1800, 300, '0', '0', NULL, NULL),
(255, 4, '00508016', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1225', 51, 11, 12, 2, 4, 1, 50, 50, '0', '0', NULL, NULL),
(256, 4, '00508016', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1229', 51, 11, 12, 2, 4, 1, 70, 70, '0', '0', NULL, NULL),
(257, 1, '003041634', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3106', 51, 25, 75, 5, 11, 8, 33000, 33000, '0', '0', NULL, NULL),
(258, 1, '003041633', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3106', 51, 25, 75, 2, 11, 8, 33000, 33000, '0', '0', NULL, NULL),
(259, 1, '00712003', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 99, 22, 34, 6, 7, 1, 6000, 6000, '0', '0', NULL, NULL),
(260, 4, '00712003', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1227', 99, 22, 34, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(261, 1, '00712001', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 99, 22, 34, 6, 21, 3, 5000, 5000, '0', '0', NULL, NULL),
(262, 1, '00712004', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3109', 99, 22, 34, 6, 12, 1, 1500, 1500, '0', '0', NULL, NULL),
(263, 1, '00704003', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 99, 4, 2, 6, 7, 1, 30000, 21720, '0', '0', NULL, NULL),
(264, 4, '00704003', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 99, 4, 2, 6, 7, 1, 100, 100, '0', '0', NULL, NULL),
(265, 1, '003041635', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3106', 99, 25, 2, 6, 11, 0, 33000, 33000, '0', '0', NULL, NULL),
(266, 4, '12506001', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 61, 4, 2, 1, 16, 1, 200, 200, '0', '0', NULL, NULL),
(267, 1, '00508003', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 61, 9, 11, 1, 7, 1, 7600, 320, '0', '0', NULL, NULL),
(268, 1, '12506021', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 61, 4, 14, 1, 7, 1, 14000, 6000, '0', '0', NULL, NULL),
(269, 1, '12506011', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3107', 61, 4, 14, 1, 12, 1, 10000, 9200, '0', '0', NULL, NULL),
(270, 2, '12506015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3102', 61, 4, 14, 1, 11, 1, 1200, 1200, '0', '0', NULL, NULL),
(271, 2, '12506015', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3117', 61, 4, 14, 1, 11, 1, 425, 425, '0', '0', NULL, NULL),
(272, 4, '00303050', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1228', 15, 25, 77, 2, 4, 8, 50, 50, '0', '0', NULL, NULL),
(273, 4, '00302000', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 86, 27, 30, 6, 7, 1, 100, 100, '0', '0', NULL, NULL),
(274, 4, '00303002', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1227', 86, 19, 25, 6, 7, 1, 400, 400, '0', '0', NULL, NULL),
(275, 1, '10104750', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 101, 2, 5, 4, 7, 1, 400, 400, '0', '0', NULL, NULL),
(276, 4, '10104750', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1224', 101, 2, 5, 4, 7, 1, 20, 20, '0', '0', NULL, NULL),
(277, 4, '10104750', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1226', 101, 2, 5, 4, 7, 1, 40, 40, '0', '0', NULL, NULL),
(278, 4, '10104750', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 101, 2, 5, 4, 7, 1, 100, 100, '0', '0', NULL, NULL),
(279, 2, '10104778', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3117', 101, 2, 5, 4, 11, 1, 1750, 1750, '0', '0', NULL, NULL),
(280, 1, '10104751', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3120', 101, 3, 35, 4, 7, 1, 6000, 3000, '0', '0', NULL, NULL),
(281, 4, '10104751', '3207', NULL, NULL, 'FEBRERO 2021', 'INT-H-1231', 101, 3, 35, 4, 7, 1, 200, 200, '0', '0', NULL, NULL),
(282, 1, '10104778', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3111', 101, 2, 5, 4, 11, 1, 1500, 1500, '0', '0', NULL, NULL),
(283, 2, '15205521', '3207', NULL, NULL, 'FEBRERO 2021', 'HON-3118', 104, 4, 2, 12, 11, 1, 350, 350, '0', '0', NULL, NULL),
(284, 1, '603004002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 88, 4, 3, 1, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(285, 4, '603004002', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 88, 4, 3, 1, 7, 1, 240, 240, '0', '0', NULL, NULL),
(286, 2, '603004023', '3217', NULL, NULL, 'MARZO 2021', 'HON-3135', 88, 4, 3, 1, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(287, 2, '603004023', '3217', NULL, NULL, 'MARZO 2021', 'HON-3138', 88, 4, 3, 1, 12, 1, 5000, 5000, '0', '0', NULL, NULL),
(288, 2, '603004031', '3217', NULL, NULL, 'MARZO 2021', 'HON-3139', 88, 4, 3, 1, 11, 1, 750, 750, '0', '0', NULL, NULL),
(289, 2, '603004050', '3217', NULL, NULL, 'MARZO 2021', 'HON-3139', 88, 4, 3, 13, 11, 1, 3000, 3000, '0', '0', NULL, NULL),
(290, 2, '47801563', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1472', 166, 4, 2, 2, 10, 1, 60000, 30000, '0', '0', NULL, NULL),
(291, 2, '47801561', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1472', 166, 4, 2, 1, 10, 1, 60000, 39500, '0', '0', NULL, NULL),
(292, 3, '11812010', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 132, 4, 2, 6, 12, 1, 5000, 5000, '0', '0', NULL, NULL),
(293, 3, '11812008', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 132, 31, 4, 6, 12, 1, 2000, 2000, '0', '0', NULL, NULL),
(294, 3, '11812002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 132, 9, 11, 6, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(295, 2, '47801002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 168, 3, 14, 6, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(296, 2, '47705002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 168, 3, 14, 6, 11, 1, 7500, 7500, '0', '0', NULL, NULL),
(297, 2, '47801004', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 168, 5, 4, 6, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(298, 3, '12003002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 133, 2, 1, 2, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(299, 3, '12003003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 133, 2, 1, 5, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(300, 3, '12003001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 133, 2, 1, 5, 12, 1, 2000, 2000, '0', '0', NULL, NULL),
(301, 3, '12004001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 133, 4, 2, 5, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(302, 3, '12002999', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 133, 4, 2, 5, 12, 1, 6000, 6000, '0', '0', NULL, NULL),
(303, 3, '12004000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 133, 4, 2, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(304, 3, '12002998', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 133, 4, 2, 2, 12, 1, 4000, 4000, '0', '0', NULL, NULL),
(305, 3, '12003005', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 133, 22, 34, 5, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(306, 3, '12005003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 133, 9, 11, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(307, 3, '12003007', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 133, 22, 34, 2, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(308, 1, '20005000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 90, 1, 6, 3, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(309, 4, '20005000', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 90, 1, 6, 3, 7, 1, 380, 380, '0', '0', NULL, NULL),
(310, 2, '20005016', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 90, 1, 6, 3, 11, 1, 40000, 20000, '0', '0', NULL, NULL),
(311, 2, '10499060', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 90, 45, 1, 19, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(312, 2, '10499060', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 67, 45, 1, 2, 11, 1, 0, 0, '0', '0', NULL, NULL),
(313, 2, '10499060', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 255, 45, 1, 19, 11, 1, 0, 0, '0', '0', NULL, NULL),
(314, 2, '10499060', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 51, 2, 1, 1, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(315, 2, '10499060', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 457, 45, 1, 19, 11, 1, 0, 0, '0', '0', NULL, NULL),
(316, 1, '20005002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 90, 3, 21, 3, 7, 3, 4800, 4800, '0', '0', NULL, NULL),
(317, 1, '20005001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 90, 3, 3, 3, 7, 3, 8000, 8000, '0', '0', NULL, NULL),
(318, 2, '20005006', '3217', NULL, NULL, 'MARZO 2021', 'HON-3138', 90, 3, 3, 3, 11, 1, 25000, 25000, '0', '0', NULL, NULL),
(319, 2, '10499015', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 457, 3, 2, 19, 11, 1, 0, 0, '0', '0', NULL, NULL),
(320, 2, '10499015', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 754, 3, 2, 19, 11, 1, 0, 0, '0', '0', NULL, NULL),
(321, 2, '10499015', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 90, 3, 3, 3, 11, 1, 500, 500, '0', '0', NULL, NULL),
(322, 2, '10499015', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 15, 3, 3, 2, 11, 1, 500, 500, '0', '0', NULL, NULL),
(323, 2, '10499015', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 51, 4, 2, 3, 11, 1, 500, 500, '0', '0', NULL, NULL),
(324, 1, '20005005', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 90, 34, 52, 3, 7, 1, 400, 400, '0', '0', NULL, NULL),
(325, 1, '20005007', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 90, 9, 26, 3, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(326, 1, '00508020', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 91, 4, 2, 10, 7, 1, 62800, 62800, '0', '0', NULL, NULL),
(327, 1, '00508022', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 91, 9, 11, 10, 7, 1, 1200, 1200, '0', '0', '106006', '1730.86'),
(328, 2, '00804065', '3217', NULL, NULL, 'MARZO 2021', 'HON-3139', 209, 18, 6, 2, 7, 1, 400, 400, '0', '0', NULL, NULL),
(329, 1, '13105120', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 210, 2, 1, 3, 4, 0, 400, 400, '0', '0', NULL, NULL),
(330, 4, '00110346', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1233', 226, 4, 2, 9, 7, 1, 600, 600, '0', '0', NULL, NULL),
(331, 4, '00110347', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1233', 226, 20, 30, 9, 7, 1, 400, 400, '0', '0', NULL, NULL),
(332, 3, '11710050', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 183, 2, 1, 3, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(333, 3, '11710055', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 183, 2, 1, 3, 12, 1, 2000, 2000, '0', '0', NULL, NULL),
(334, 3, '11710052', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 183, 16, 14, 3, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(335, 1, '10105565', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1475', 227, 1, 1, 5, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(336, 1, '10105566', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1475', 227, 4, 2, 5, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(337, 1, '10105550', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1475', 227, 1, 1, 2, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(338, 1, '10105551', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1475', 227, 4, 2, 2, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(339, 1, '10105560', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1475', 227, 1, 1, 6, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(340, 1, '10105561', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1475', 227, 4, 2, 6, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(341, 1, '10105555', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1475', 227, 1, 1, 1, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(342, 1, '10105556', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1475', 227, 4, 2, 1, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(343, 1, '603005751', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 92, 4, 2, 1, 4, 1, 1200, 1200, '0', '0', NULL, NULL),
(344, 1, '603005750', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 92, 2, 1, 1, 4, 1, 600, 600, '0', '0', NULL, NULL),
(345, 1, '603005752', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 92, 9, 11, 1, 4, 1, 400, 400, '0', '0', NULL, NULL),
(346, 3, '12104000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 134, 3, 3, 5, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(347, 4, '00407000', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1212', 158, 15, 46, 9, 15, 1, 1400, 1400, '0', '0', NULL, NULL),
(348, 4, '00107000', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1234', 141, 15, 53, 9, 15, 1, 500, 500, '0', '0', NULL, NULL),
(349, 1, '00231000', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1479', 62, 15, 18, 3, 15, 1, 10000, 1000, '0', '0', NULL, NULL),
(350, 4, '00507001', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 159, 15, 62, 6, 15, 1, 1700, 1700, '0', '0', NULL, NULL),
(351, 3, '11707003', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1474', 138, 15, 48, 6, 17, 4, 32000, 19680, '0', '0', NULL, NULL),
(352, 1, '15003000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 184, 24, 6, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(353, 1, '15004001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 184, 5, 51, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(354, 1, '9900009111', '3217', NULL, NULL, 'MARZO 2021', 'HON-3124', 93, 3, 27, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(355, 1, '9900009117', '3217', NULL, NULL, 'MARZO 2021', 'HON-3146', 93, 3, 27, 2, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(356, 1, '9900004023', '3217', NULL, NULL, 'MARZO 2021', 'HON-3146', 53, 3, 2, 1, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(357, 1, '9900004035', '3217', NULL, NULL, 'MARZO 2021', 'HON-3124', 229, 9, 16, 3, 7, 1, 2000, 500, '0', '0', NULL, NULL),
(358, 1, '9900004025', '3217', NULL, NULL, 'MARZO 2021', 'HON-3124', 230, 9, 16, 1, 7, 1, 2000, 1000, '0', '0', NULL, NULL),
(359, 1, '00110060', '3217', NULL, NULL, 'MARZO 2021', 'HON-3144', 231, 2, 1, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(360, 1, '00110061', '3217', NULL, NULL, 'MARZO 2021', 'HON-3144', 231, 4, 2, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(361, 1, '00110062', '3217', NULL, NULL, 'MARZO 2021', 'HON-3144', 231, 9, 11, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(362, 1, '00110063', '3217', NULL, NULL, 'MARZO 2021', 'HON-3144', 231, 22, 34, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(363, 1, '01604010', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 109, 24, 41, 1, 7, 1, 400, 400, '0', '0', NULL, NULL),
(364, 1, '01604012', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 109, 28, 14, 1, 7, 1, 400, 400, '0', '0', NULL, NULL),
(365, 1, '01604011', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 109, 3, 2, 1, 7, 1, 400, 400, '0', '0', NULL, NULL),
(366, 1, '01606675', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 40, 20, 30, 5, 7, 1, 6400, 6400, '0', '0', NULL, NULL),
(367, 4, '01606677', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 40, 9, 11, 5, 7, 1, 300, 300, '0', '0', NULL, NULL),
(368, 1, '01606678', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 40, 3, 2, 5, 7, 1, 5200, 5200, '0', '0', NULL, NULL),
(369, 4, '01606678', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 40, 3, 2, 5, 7, 1, 380, 380, '0', '0', NULL, NULL),
(370, 2, '00904111', '3217', NULL, NULL, 'MARZO 2021', 'HON-3135', 186, 3, 3, 2, 9, 1, 500, 500, '0', '0', NULL, NULL),
(371, 3, '12301000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 135, 19, 25, 3, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(372, 3, '12303000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 135, 2, 1, 3, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(373, 3, '13403010', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 135, 3, 2, 3, 12, 1, 6000, 4200, '0', '0', NULL, NULL),
(374, 2, '14399006', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 147, 3, 3, 3, 11, 1, 4000, 4000, '0', '0', NULL, NULL),
(375, 2, '14399005', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 147, 2, 6, 3, 11, 1, 400, 400, '0', '0', NULL, NULL),
(376, 1, '10105005', '3217', NULL, NULL, 'MARZO 2021', 'HON-3126', 232, 5, 4, 2, 7, 1, 400, 400, '0', '0', NULL, NULL),
(377, 3, '09906012', '3217', NULL, NULL, 'MARZO 2021', 'HON-3140', 181, 4, 2, 6, 20, 4, 1920, 1920, '0', '0', NULL, NULL),
(378, 3, '09906018', '3217', NULL, NULL, 'MARZO 2021', 'HON-3140', 181, 22, 34, 6, 20, 4, 480, 480, '0', '0', NULL, NULL),
(379, 3, '09906035', '3217', NULL, NULL, 'MARZO 2021', 'HON-3140', 161, 4, 2, 2, 20, 4, 320, 320, '0', '0', NULL, NULL),
(380, 3, '09906037', '3217', NULL, NULL, 'MARZO 2021', 'HON-3140', 182, 3, 2, 3, 22, 4, 750, 750, '0', '0', NULL, NULL),
(381, 3, '09906039', '3217', NULL, NULL, 'MARZO 2021', 'HON-3140', 182, 9, 40, 3, 22, 4, 1200, 1200, '0', '0', NULL, NULL),
(382, 2, '6030066060', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1472', 56, 4, 2, 3, 9, 1, 5000, 1000, '0', '0', NULL, NULL),
(383, 4, '01607602', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 95, 3, 2, 11, 7, 1, 160, 160, '0', '0', NULL, NULL),
(384, 3, '10610017', '3217', NULL, NULL, 'MARZO 2021', 'HON-3136', 162, 9, 11, 5, 22, 4, 750, 750, '0', '0', NULL, NULL),
(385, 3, '10610020', '3217', NULL, NULL, 'MARZO 2021', 'HON-3136', 162, 4, 2, 2, 22, 4, 1500, 1500, '0', '0', NULL, NULL),
(386, 3, '10610019', '3217', NULL, NULL, 'MARZO 2021', 'HON-3136', 162, 4, 2, 5, 22, 4, 750, 750, '0', '0', NULL, NULL),
(387, 1, '12503003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3128', 63, 4, 2, 1, 7, 1, 800, 800, '0', '0', NULL, NULL),
(388, 1, '12503010', '3217', NULL, NULL, 'MARZO 2021', 'HON-3128', 63, 1, 1, 1, 7, 1, 800, 800, '0', '0', NULL, NULL),
(389, 1, '12503005', '3217', NULL, NULL, 'MARZO 2021', 'HON-3128', 63, 19, 30, 2, 7, 1, 800, 800, '0', '0', NULL, NULL),
(390, 1, '00110276', '3217', NULL, NULL, 'MARZO 2021', 'HON-3129', 72, 2, 1, 6, 23, 1, 500, 500, '0', '0', NULL, NULL),
(391, 1, '00110275', '3217', NULL, NULL, 'MARZO 2021', 'HON-3129', 72, 2, 1, 5, 23, 0, 500, 500, '0', '0', NULL, NULL),
(392, 1, '00110277', '3217', NULL, NULL, 'MARZO 2021', 'HON-3129', 72, 2, 1, 2, 23, 0, 500, 500, '0', '0', NULL, NULL),
(393, 1, '00401000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 67, 19, 25, 3, 7, 3, 1200, 1200, '0', '0', NULL, NULL),
(394, 1, '00403000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 67, 2, 1, 3, 7, 3, 2800, 2800, '0', '0', NULL, NULL),
(395, 1, '00404000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 67, 3, 2, 3, 7, 3, 4400, 4400, '0', '0', NULL, NULL),
(396, 2, '00404005', '3217', NULL, NULL, 'MARZO 2021', 'HON-3138', 67, 3, 2, 3, 12, 1, 5000, 5000, '0', '0', NULL, NULL),
(397, 1, '00408000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 67, 9, 40, 3, 7, 3, 400, 400, '0', '0', NULL, NULL),
(398, 2, '00408003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3138', 67, 9, 40, 3, 12, 1, 7500, 7500, '0', '0', NULL, NULL),
(399, 1, '00303007', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 67, 25, 2, 3, 4, 1, 1000, 1000, '0', '0', NULL, NULL),
(400, 1, '00405000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 67, 16, 14, 3, 7, 3, 400, 400, '0', '0', NULL, NULL),
(401, 2, '41112001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 59, 22, 74, 1, 11, 1, 200, 200, '0', '0', NULL, NULL),
(402, 2, '01104000', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 59, 4, 3, 2, 13, 3, 1750, 1750, '0', '0', NULL, NULL),
(403, 2, '01103006', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 59, 4, 3, 2, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(404, 2, '01103010', '3217', NULL, NULL, 'MARZO 2021', 'HON-3141', 59, 38, 68, 2, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(405, 2, '20018021', '3217', NULL, NULL, 'MARZO 2021', 'HON-3135', 113, 3, 2, 1, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(406, 4, '20018002', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1237', 113, 9, 11, 1, 7, 1, 600, 600, '0', '0', NULL, NULL),
(407, 2, '20018022', '3217', NULL, NULL, 'MARZO 2021', 'HON-3135', 113, 9, 11, 1, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(408, 1, '10104817', '3217', NULL, NULL, 'MARZO 2021', 'HON-3138', 234, 4, 2, 5, 11, 1, 10000, 10000, '0', '0', NULL, NULL),
(409, 4, '00504007', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 51, 4, 2, 2, 18, 3, 400, 400, '0', '0', NULL, NULL),
(410, 1, '00504003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 2, 2, 7, 3, 11600, 8240, '0', '0', NULL, NULL);
INSERT INTO `pendiente` (`id_pendiente`, `categoria`, `item`, `orden_del_sitema`, `observacion`, `presentacion`, `mes`, `orden`, `marca`, `vitola`, `nombre`, `capa`, `tipo_empaque`, `cello`, `pendiente`, `saldo`, `paquetes`, `unidades`, `serie_precio`, `precio`) VALUES
(411, 4, '00504003', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 51, 4, 2, 2, 7, 3, 400, 400, '0', '0', NULL, NULL),
(412, 1, '10104816', '3217', NULL, NULL, 'MARZO 2021', 'HON-3138', 51, 4, 2, 2, 11, 1, 10000, 10000, '0', '0', NULL, NULL),
(413, 1, '00904038', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 2, 2, 14, 1, 6300, 6300, '0', '0', NULL, NULL),
(414, 1, '00904038', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 2, 5, 14, 1, 6300, 6300, '0', '0', NULL, NULL),
(415, 1, '00904038', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 2, 1, 14, 1, 6300, 6300, '0', '0', NULL, NULL),
(416, 1, '00904038', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 2, 3, 14, 1, 6300, 6300, '0', '0', NULL, NULL),
(417, 1, '00505002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 14, 5, 7, 3, 3600, 3600, '0', '0', NULL, NULL),
(418, 1, '00505007', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 14, 2, 18, 3, 2000, 2000, '0', '0', NULL, NULL),
(419, 1, '00505003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 14, 2, 7, 3, 3200, 3200, '0', '0', NULL, NULL),
(420, 1, '10515002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 2, 1, 5, 4, 1, 200, 200, '0', '0', NULL, NULL),
(421, 1, '00504100', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 2, 1, 5, 7, 1, 4000, 1200, '0', '0', NULL, NULL),
(422, 4, '00504100', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 51, 2, 1, 5, 7, 1, 100, 100, '0', '0', NULL, NULL),
(423, 1, '10104912', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 2, 1, 5, 23, 1, 14300, 14300, '0', '0', NULL, NULL),
(424, 1, '00504101', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 2, 1, 2, 7, 3, 3600, 3600, '0', '0', NULL, NULL),
(425, 1, '00605002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 14, 17, 5, 13, 3, 5500, 1000, '0', '0', NULL, NULL),
(426, 1, '00605003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 14, 17, 2, 13, 3, 1500, 1500, '0', '0', NULL, NULL),
(427, 1, '00504041', '3217', NULL, NULL, 'MARZO 2021', 'HON-3135', 51, 9, 32, 5, 11, 1, 500, 500, '0', '0', NULL, NULL),
(428, 1, '00508001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 9, 32, 2, 7, 3, 7200, 7200, '0', '0', NULL, NULL),
(429, 4, '00504101', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 51, 2, 1, 2, 7, 3, 400, 400, '0', '0', NULL, NULL),
(430, 1, '00504102', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 22, 34, 5, 7, 1, 400, 400, '0', '0', NULL, NULL),
(431, 1, '00504103', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 22, 34, 2, 7, 1, 800, 800, '0', '0', NULL, NULL),
(432, 1, '00504032', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 2, 3, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(433, 2, '00504048', '3217', NULL, NULL, 'MARZO 2021', 'HON-3139', 51, 4, 2, 3, 11, 1, 500, 500, '0', '0', NULL, NULL),
(434, 1, '00505019', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 14, 3, 18, 1, 2000, 2000, '0', '0', NULL, NULL),
(435, 1, '00504033', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 14, 3, 7, 1, 400, 400, '0', '0', NULL, NULL),
(436, 4, '00503009', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1238', 51, 6, 43, 5, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(437, 1, '00501150', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 4, 2, 15, 7, 1, 800, 800, '0', '0', NULL, NULL),
(438, 4, '00501150', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 51, 4, 2, 15, 7, 1, 80, 80, '0', '0', NULL, NULL),
(439, 1, '10104130', '3217', NULL, NULL, 'MARZO 2021', 'HON-3136', 51, 6, 67, 5, 7, 1, 500, 500, '0', '0', NULL, NULL),
(440, 1, '00508010', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 21, 33, 5, 19, 1, 1800, 1800, '0', '0', NULL, NULL),
(441, 1, '00508011', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 21, 33, 2, 19, 1, 1200, 1200, '0', '0', NULL, NULL),
(442, 4, '00508011', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1237', 51, 21, 33, 2, 19, 1, 300, 300, '0', '0', NULL, NULL),
(443, 1, '00508015', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 51, 11, 12, 5, 4, 1, 600, 300, '0', '0', NULL, NULL),
(444, 2, '40503005', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 51, 18, 80, 3, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(445, 2, '40503022', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 51, 18, 80, 3, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(446, 2, '40503016', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 51, 18, 80, 3, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(447, 1, '00705003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 99, 4, 14, 6, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(448, 1, '00705001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 99, 4, 14, 6, 21, 3, 1000, 1000, '0', '0', NULL, NULL),
(449, 4, '00703003', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1212', 99, 2, 1, 6, 7, 1, 460, 460, '0', '0', NULL, NULL),
(450, 1, '00712003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 99, 22, 34, 6, 7, 1, 400, 400, '0', '0', NULL, NULL),
(451, 1, '00712001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 99, 22, 34, 6, 21, 3, 1000, 1000, '0', '0', NULL, NULL),
(452, 1, '00712004', '3217', NULL, NULL, 'MARZO 2021', 'HON-3135', 99, 22, 34, 6, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(453, 1, '00704003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 99, 4, 2, 6, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(454, 1, '00704001', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 99, 4, 2, 6, 21, 3, 2000, 2000, '0', '0', NULL, NULL),
(455, 2, '00704004', '3217', NULL, NULL, 'MARZO 2021', 'HON-3138', 99, 4, 2, 6, 12, 1, 20000, 20000, '0', '0', NULL, NULL),
(456, 1, '00508002', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 99, 9, 11, 6, 7, 1, 3600, 240, '0', '0', NULL, NULL),
(457, 1, '00504043', '3217', NULL, NULL, 'MARZO 2021', 'HON-3135', 99, 9, 11, 6, 11, 1, 500, 500, '0', '0', NULL, NULL),
(458, 1, '00508017', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 73, 11, 12, 6, 4, 1, 200, 200, '0', '0', NULL, NULL),
(459, 2, '40503004', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 99, 18, 80, 6, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(460, 2, '40503021', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 99, 18, 80, 6, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(461, 2, '40503015', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 99, 18, 80, 6, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(462, 4, '12506001', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 61, 4, 2, 1, 16, 1, 200, 200, '0', '0', NULL, NULL),
(463, 1, '00508003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 61, 9, 11, 1, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(464, 1, '12506021', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 61, 4, 14, 1, 7, 1, 3200, 3200, '0', '0', NULL, NULL),
(465, 2, '12506011', '3217', NULL, NULL, 'MARZO 2021', 'HON-3132', 61, 4, 14, 1, 12, 1, 1000, 1000, '0', '0', NULL, NULL),
(466, 2, '40503003', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 61, 18, 24, 1, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(467, 2, '40503020', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 61, 18, 24, 1, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(468, 2, '40503014', '3217', NULL, NULL, 'MARZO 2021', 'HON-3127', 61, 18, 24, 1, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(469, 3, '12003050', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 105, 4, 2, 1, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(470, 3, '12003060', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 105, 4, 2, 1, 12, 1, 6000, 6000, '0', '0', NULL, NULL),
(471, 3, '12003051', '3217', NULL, NULL, 'MARZO 2021', 'HON-3130', 105, 4, 14, 1, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(472, 3, '12003062', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 105, 4, 14, 1, 12, 1, 1000, 1000, '0', '0', NULL, NULL),
(473, 3, '12003061', '3217', NULL, NULL, 'MARZO 2021', 'HON-3131', 105, 9, 11, 1, 12, 1, 2000, 2000, '0', '0', NULL, NULL),
(474, 4, '00303050', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 15, 25, 77, 2, 4, 8, 150, 150, '0', '0', NULL, NULL),
(475, 4, '10104210', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 14, 2, 6, 3, 7, 1, 140, 140, '0', '0', NULL, NULL),
(476, 4, '00303051', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1240', 14, 25, 35, 3, 4, 1, 100, 100, '0', '0', NULL, NULL),
(477, 4, '00303051', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1239', 14, 25, 35, 3, 4, 1, 40, 40, '0', '0', NULL, NULL),
(478, 4, '00303065', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1212', 86, 2, 1, 6, 10, 1, 200, 200, '0', '0', NULL, NULL),
(479, 4, '00302004', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1212', 86, 37, 61, 6, 3, 1, 20, 20, '0', '0', NULL, NULL),
(480, 4, '00302007', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1237', 86, 3, 2, 6, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(481, 4, '00302007', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1239', 86, 3, 2, 6, 7, 1, 100, 100, '0', '0', NULL, NULL),
(482, 4, '00302009', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 86, 9, 11, 6, 7, 1, 40, 40, '0', '0', NULL, NULL),
(483, 1, '10104750', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 101, 2, 5, 4, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(484, 4, '10104750', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1235', 101, 2, 5, 4, 7, 1, 600, 600, '0', '0', NULL, NULL),
(485, 2, '10104778', '3217', NULL, NULL, 'MARZO 2021', 'HON-3139', 101, 2, 5, 4, 11, 1, 700, 700, '0', '0', NULL, NULL),
(486, 1, '10104751', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 101, 3, 35, 4, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(487, 2, '10104775', '3217', NULL, NULL, 'MARZO 2021', 'HON-3138', 101, 3, 35, 4, 12, 1, 2000, 2000, '0', '0', NULL, NULL),
(488, 1, '10104752', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 101, 16, 36, 4, 7, 1, 800, 800, '0', '0', NULL, NULL),
(489, 1, '10104754', '3217', NULL, NULL, 'MARZO 2021', 'HON-3142', 101, 9, 37, 4, 7, 1, 800, 800, '0', '0', NULL, NULL),
(490, 4, '10104754', '3217', NULL, NULL, 'MARZO 2021', 'INT-H-1237', 101, 9, 37, 4, 7, 1, 400, 400, '0', '0', NULL, NULL),
(491, 2, '10104772', '3217', NULL, NULL, 'MARZO 2021', 'HON-3135', 101, 5, 38, 4, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(492, 1, '10104150', '3217', NULL, NULL, 'MARZO 2021', 'HON-3134', 101, 44, 61, 4, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(493, 2, '47801421', '3217', NULL, NULL, 'MARZO 2021', 'FTT-1472', 60, 4, 2, 8, 10, 1, 60000, 20000, '0', '0', NULL, NULL),
(494, 1, '10603007', '3217', NULL, NULL, 'MARZO 2021', 'HON-3137', 145, 36, 57, 6, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(495, 1, '00705003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 4, 14, 6, 7, 1, 400, 400, '0', '0', NULL, NULL),
(496, 1, '00705001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 4, 14, 6, 21, 3, 3000, 3000, '0', '0', NULL, NULL),
(497, 1, '00107000', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1492', 141, 15, 53, 9, 15, 1, 4000, 4000, '0', '0', NULL, NULL),
(498, 1, '00504006', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 5, 18, 3, 38000, 38000, '0', '0', NULL, NULL),
(499, 1, '00504002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 5, 7, 3, 11600, 11600, '0', '0', NULL, NULL),
(500, 1, '00504009', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3147', 51, 4, 2, 5, 12, 1, 17500, 17500, '0', '0', NULL, NULL),
(501, 2, '00504026', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3166', 51, 4, 2, 5, 11, 3, 4250, 4250, '0', '0', NULL, NULL),
(502, 1, '00504007', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 2, 18, 3, 38000, 38000, '0', '0', NULL, NULL),
(503, 4, '00504005', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 51, 4, 2, 2, 18, 3, 100, 100, '0', '0', NULL, NULL),
(504, 1, '00504003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 2, 7, 3, 6000, 6000, '0', '0', NULL, NULL),
(505, 1, '00504010', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3147', 51, 4, 2, 2, 12, 1, 17500, 17500, '0', '0', NULL, NULL),
(506, 2, '00504027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3166', 51, 4, 2, 2, 11, 1, 8000, 8000, '0', '0', NULL, NULL),
(507, 1, '00904038', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 2, 14, 1, 6000, 6000, '0', '0', NULL, NULL),
(508, 1, '00904038', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 5, 14, 1, 6000, 6000, '0', '0', NULL, NULL),
(509, 1, '00904038', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 1, 14, 1, 6000, 6000, '0', '0', NULL, NULL),
(510, 1, '00904038', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 3, 14, 1, 6000, 6000, '0', '0', NULL, NULL),
(511, 1, '00505006', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 14, 5, 18, 3, 6000, 6000, '0', '0', NULL, NULL),
(512, 1, '00505008', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3147', 51, 4, 14, 5, 12, 1, 12500, 12500, '0', '0', NULL, NULL),
(513, 1, '00505007', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 14, 2, 18, 3, 2000, 2000, '0', '0', NULL, NULL),
(514, 1, '00505003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 14, 2, 7, 3, 2000, 2000, '0', '0', NULL, NULL),
(515, 1, '10515002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 2, 1, 5, 4, 1, 400, 400, '0', '0', NULL, NULL),
(516, 1, '00504100', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 2, 1, 5, 7, 1, 3600, 3600, '0', '0', NULL, NULL),
(517, 4, '00504100', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 51, 2, 1, 5, 7, 1, 100, 100, '0', '0', NULL, NULL),
(518, 1, '10104912', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 2, 1, 5, 23, 1, 34100, 34100, '0', '0', NULL, NULL),
(519, 1, '00504101', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 2, 1, 2, 7, 3, 4000, 4000, '0', '0', NULL, NULL),
(520, 4, '00504101', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 51, 2, 1, 2, 7, 3, 100, 100, '0', '0', NULL, NULL),
(521, 1, '00605002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 14, 17, 5, 13, 3, 500, 500, '0', '0', NULL, NULL),
(522, 1, '00605003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 14, 17, 2, 13, 3, 1000, 1000, '0', '0', NULL, NULL),
(523, 2, '40503001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3174', 51, 18, 24, 5, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(524, 2, '40503002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3174', 51, 18, 24, 2, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(525, 1, '00508000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 9, 32, 5, 7, 3, 4800, 4800, '0', '0', NULL, NULL),
(526, 2, '00504041', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3162', 51, 9, 32, 5, 11, 1, 500, 500, '0', '0', NULL, NULL),
(527, 1, '00508001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 9, 32, 2, 7, 3, 5200, 5200, '0', '0', NULL, NULL),
(528, 1, '00504102', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 22, 34, 5, 7, 1, 400, 400, '0', '0', NULL, NULL),
(529, 1, '00504103', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 22, 34, 2, 7, 1, 800, 800, '0', '0', NULL, NULL),
(530, 1, '00504024', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 3, 18, 1, 26000, 26000, '0', '0', NULL, NULL),
(531, 1, '00504032', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 3, 7, 1, 3200, 3200, '0', '0', NULL, NULL),
(532, 1, '00504037', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3147', 51, 4, 2, 3, 12, 1, 8750, 8750, '0', '0', NULL, NULL),
(533, 2, '00504048', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3166', 51, 4, 2, 3, 11, 1, 250, 250, '0', '0', NULL, NULL),
(534, 1, '00505019', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 14, 3, 18, 1, 2000, 2000, '0', '0', NULL, NULL),
(535, 2, '00504047', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3169', 51, 4, 14, 3, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(536, 1, '10515004', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 2, 76, 6, 4, 8, 600, 600, '0', '0', NULL, NULL),
(537, 1, '00703003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 2, 1, 6, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(538, 4, '00703003', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 99, 2, 1, 6, 7, 1, 60, 60, '0', '0', NULL, NULL),
(539, 1, '00703001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 2, 1, 6, 21, 3, 2000, 2000, '0', '0', NULL, NULL),
(540, 1, '00712003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 22, 34, 6, 7, 1, 400, 400, '0', '0', NULL, NULL),
(541, 1, '00712001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 22, 34, 6, 21, 3, 3000, 3000, '0', '0', NULL, NULL),
(542, 1, '00712004', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3147', 99, 22, 34, 6, 12, 1, 5000, 5000, '0', '0', NULL, NULL),
(543, 1, '00704003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 4, 2, 6, 7, 1, 4800, 4800, '0', '0', NULL, NULL),
(544, 1, '00704001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 4, 2, 6, 21, 3, 6000, 6000, '0', '0', NULL, NULL),
(545, 1, '00508002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 99, 9, 11, 6, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(546, 1, '00504043', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3162', 99, 9, 11, 6, 11, 1, 500, 500, '0', '0', NULL, NULL),
(547, 1, '00401000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 67, 19, 25, 3, 7, 3, 800, 800, '0', '0', NULL, NULL),
(548, 4, '00401000', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 67, 19, 25, 3, 7, 3, 200, 200, '0', '0', NULL, NULL),
(549, 1, '00403000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 67, 2, 1, 3, 7, 3, 2400, 2400, '0', '0', NULL, NULL),
(550, 2, '13403000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3151', 67, 2, 1, 3, 11, 1, 4250, 4250, '0', '0', NULL, NULL),
(551, 1, '00404000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 67, 3, 2, 3, 7, 3, 3600, 3600, '0', '0', NULL, NULL),
(552, 2, '13403000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 67, 2, 1, 3, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(553, 4, '00404000', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 67, 3, 2, 3, 7, 3, 40, 40, '0', '0', NULL, NULL),
(554, 1, '00404005', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3156', 67, 3, 2, 3, 12, 1, 12500, 12500, '0', '0', NULL, NULL),
(555, 1, '00408000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 67, 9, 40, 3, 7, 3, 800, 800, '0', '0', NULL, NULL),
(556, 2, '01103000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 59, 1, 6, 18, 13, 3, 375, 375, '0', '0', NULL, NULL),
(557, 2, '11199000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 59, 1, 6, 18, 10, 1, 250, 250, '0', '0', NULL, NULL),
(558, 2, '11199000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 59, 4, 3, 2, 10, 1, 250, 250, '0', '0', NULL, NULL),
(559, 2, '11199000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 59, 43, 73, 18, 10, 1, 250, 250, '0', '0', NULL, NULL),
(560, 2, '11199000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 59, 24, 14, 1, 10, 1, 250, 250, '0', '0', NULL, NULL),
(561, 2, '01103004', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 59, 1, 6, 18, 11, 1, 150, 150, '0', '0', NULL, NULL),
(562, 2, '41112001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 59, 22, 74, 1, 11, 1, 200, 200, '0', '0', NULL, NULL),
(563, 2, '41112001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 59, 22, 74, 1, 11, 1, 300, 300, '0', '0', NULL, NULL),
(564, 2, '01104000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 59, 4, 3, 2, 13, 3, 750, 750, '0', '0', NULL, NULL),
(565, 2, '01104000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 59, 4, 3, 2, 13, 3, 2000, 2000, '0', '0', NULL, NULL),
(566, 2, '01103010', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 59, 38, 68, 2, 11, 1, 1100, 1100, '0', '0', NULL, NULL),
(567, 2, '47801000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 168, 2, 1, 6, 7, 1, 3000, 3000, '0', '0', NULL, NULL),
(568, 2, '47801001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 168, 4, 2, 6, 7, 1, 2500, 2500, '0', '0', NULL, NULL),
(569, 2, '47801002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 168, 3, 14, 6, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(570, 2, '47705002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 168, 3, 14, 6, 11, 1, 2000, 2000, '0', '0', NULL, NULL),
(571, 2, '47801004', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 168, 5, 4, 6, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(572, 2, '00904151', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3166', 186, 3, 3, 2, 11, 1, 1500, 1500, '0', '0', NULL, NULL),
(573, 1, '00231000', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1492', 62, 15, 18, 3, 15, 1, 2000, 2000, '0', '0', NULL, NULL),
(574, 1, '00407000', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1492', 158, 15, 46, 9, 15, 1, 1000, 1000, '0', '0', NULL, NULL),
(575, 4, '10104211', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 14, 3, 3, 3, 7, 1, 180, 180, '0', '0', NULL, NULL),
(576, 1, '15003000', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3173', 184, 24, 6, 2, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(577, 3, '12004001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3149', 133, 4, 2, 5, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(578, 3, '12004000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3149', 133, 4, 2, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(579, 1, '20005000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 90, 1, 6, 3, 7, 1, 11600, 11600, '0', '0', NULL, NULL),
(581, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 90, 1, 6, 3, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(582, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 113, 1, 1, 1, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(583, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 88, 17, 23, 1, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(584, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 51, 2, 1, 5, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(585, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 191, 17, 1, 4, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(586, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 167, 17, 1, 2, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(587, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 211, 1, 1, 6, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(588, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL, NULL),
(589, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL, NULL),
(590, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL, NULL),
(591, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 90, 1, 6, 3, 9, 1, 100, 100, '0', '0', NULL, NULL),
(592, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 113, 1, 1, 1, 9, 1, 100, 100, '0', '0', NULL, NULL),
(593, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 88, 17, 23, 1, 9, 1, 100, 100, '0', '0', NULL, NULL),
(594, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 51, 2, 1, 5, 9, 1, 100, 100, '0', '0', NULL, NULL),
(595, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 191, 17, 1, 4, 9, 1, 100, 100, '0', '0', NULL, NULL),
(596, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 167, 17, 1, 2, 9, 1, 100, 100, '0', '0', NULL, NULL),
(597, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 211, 1, 1, 6, 9, 1, 100, 100, '0', '0', NULL, NULL),
(598, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL, NULL),
(599, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL, NULL),
(600, 2, '19903027', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL, NULL),
(601, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 90, 1, 6, 3, 9, 1, 10000, 9000, '0', '0', NULL, NULL),
(602, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 99, 2, 1, 6, 9, 1, 10000, 9000, '0', '0', NULL, NULL),
(603, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 61, 2, 1, 1, 9, 1, 10000, 9000, '0', '0', NULL, NULL),
(604, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 51, 2, 1, 2, 9, 1, 10000, 9000, '0', '0', NULL, NULL),
(605, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 51, 2, 1, 3, 9, 1, 10000, 9000, '0', '0', NULL, NULL),
(606, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 67, 2, 1, 3, 9, 1, 10000, 9000, '0', '0', NULL, NULL),
(607, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL, NULL),
(608, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL, NULL),
(609, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL, NULL),
(610, 1, '10104940', '3222', 'PRIORIDAD', NULL, 'ABRIL 2021', 'HON-3179', 101, 2, 5, 4, 9, 1, 10000, 9000, '0', '0', NULL, NULL),
(611, 2, '20005016', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 90, 1, 6, 3, 11, 1, 20000, 20000, '0', '0', NULL, NULL),
(612, 2, '20005016', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 90, 1, 6, 3, 11, 1, 12500, 12500, '0', '0', NULL, NULL),
(613, 1, '20005002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 90, 3, 21, 3, 7, 3, 5200, 5200, '0', '0', NULL, NULL),
(614, 1, '01004013', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3156', 90, 3, 21, 3, 12, 1, 12500, 12500, '0', '0', NULL, NULL),
(615, 1, '20005001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 90, 3, 3, 3, 7, 3, 10800, 10800, '0', '0', NULL, NULL),
(616, 4, '20005001', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 90, 3, 3, 3, 7, 3, 500, 500, '0', '0', NULL, NULL),
(617, 1, '20005005', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 90, 34, 52, 3, 7, 1, 400, 400, '0', '0', NULL, NULL),
(618, 1, '20005007', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 90, 9, 26, 3, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(619, 2, '15406023', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 167, 4, 2, 2, 11, 1, 400, 400, '0', '0', NULL, NULL),
(620, 1, '12403003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3154', 66, 2, 1, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(621, 1, '12403004', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3154', 66, 3, 2, 6, 7, 1, 300, 300, '0', '0', NULL, NULL),
(622, 1, '1240300101', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3154', 66, 3, 2, 6, 10, 1, 300, 300, '0', '0', NULL, NULL),
(623, 1, '12403005', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3154', 66, 3, 14, 6, 7, 1, 100, 100, '0', '0', NULL, NULL),
(624, 1, '12403006', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3154', 66, 5, 4, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(625, 1, '12403007', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3154', 66, 22, 34, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(626, 2, '15406022', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 191, 4, 2, 4, 11, 1, 200, 200, '0', '0', NULL, NULL),
(627, 1, '00303007', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 67, 25, 2, 3, 4, 1, 4600, 4600, '0', '0', NULL, NULL),
(628, 2, '15406022', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 191, 4, 2, 4, 11, 1, 250, 250, '0', '0', NULL, NULL),
(629, 3, '12005003', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3149', 133, 9, 11, 2, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(630, 3, '12003018', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3149', 133, 9, 11, 2, 11, 1, 3000, 3000, '0', '0', NULL, NULL),
(631, 2, '14399006', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 147, 3, 3, 3, 11, 1, 1500, 1500, '0', '0', NULL, NULL),
(632, 2, '14399002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 147, 5, 51, 3, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(633, 2, '14399002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 147, 5, 51, 3, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(634, 2, '14399008', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 147, 5, 51, 3, 11, 1, 600, 600, '0', '0', NULL, NULL),
(635, 2, '14399008', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 147, 5, 51, 3, 11, 1, 750, 750, '0', '0', NULL, NULL),
(636, 3, '12003018', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3149', 133, 9, 11, 2, 11, 1, 2000, 2000, '0', '0', NULL, NULL),
(637, 3, '09906010', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3160', 181, 9, 11, 6, 20, 4, 2560, 2560, '0', '0', NULL, NULL),
(638, 3, '09906012', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3165', 181, 4, 2, 6, 20, 4, 1760, 1760, '0', '0', NULL, NULL),
(639, 3, '09906014', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3168', 181, 4, 14, 6, 20, 4, 2400, 2400, '0', '0', NULL, NULL),
(640, 3, '09906016', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3168', 181, 31, 4, 6, 20, 4, 2400, 2400, '0', '0', NULL, NULL),
(641, 3, '09906018', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3160', 181, 22, 34, 6, 20, 4, 640, 640, '0', '0', NULL, NULL),
(642, 3, '09906034', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3168', 181, 2, 1, 6, 20, 4, 2400, 2400, '0', '0', NULL, NULL),
(643, 3, '09906000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3185', 219, 3, 3, 3, 24, 4, 240, 240, '0', '0', NULL, NULL),
(644, 3, '09906004', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3168', 219, 9, 11, 3, 24, 2, 1800, 1800, '0', '0', NULL, NULL),
(645, 3, '09906020', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3168', 219, 1, 6, 3, 24, 2, 1800, 1800, '0', '0', NULL, NULL),
(646, 3, '09906008', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3165', 219, 32, 97, 3, 24, 2, 240, 240, '0', '0', NULL, NULL),
(647, 1, '00405000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 67, 16, 14, 3, 7, 3, 400, 400, '0', '0', NULL, NULL),
(648, 1, '50000159', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3163', 265, 4, 2, 2, 12, 1, 500, 500, '0', '0', NULL, NULL),
(649, 2, '14399010', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 147, 9, 11, 3, 11, 1, 500, 500, '0', '0', NULL, NULL),
(650, 1, '10104750', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 101, 2, 5, 4, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(651, 2, '14399010', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 147, 9, 11, 3, 11, 1, 1400, 1400, '0', '0', NULL, NULL),
(653, 2, '10104778', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 101, 2, 5, 4, 11, 1, 750, 750, '0', '0', NULL, NULL),
(654, 2, '10104778', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3166', 101, 2, 5, 4, 11, 1, 400, 400, '0', '0', NULL, NULL),
(655, 1, '10104751', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 101, 3, 35, 4, 7, 1, 7200, 7200, '0', '0', NULL, NULL),
(656, 4, '10104751', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 101, 3, 35, 4, 7, 1, 300, 300, '0', '0', NULL, NULL),
(657, 1, '10104752', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 101, 16, 36, 4, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(658, 1, '10104754', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 101, 9, 37, 4, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(659, 1, '00504150', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 4, 2, 15, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(660, 1, '13105120', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 210, 2, 1, 3, 4, 0, 400, 400, '0', '0', NULL, NULL),
(661, 4, '00504150', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 51, 4, 2, 15, 7, 1, 200, 200, '0', '0', NULL, NULL),
(662, 1, '00508010', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 21, 33, 5, 19, 1, 7200, 7200, '0', '0', NULL, NULL),
(663, 1, '00508011', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 21, 33, 2, 19, 1, 2400, 2400, '0', '0', NULL, NULL),
(664, 1, '12506001', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 61, 4, 2, 1, 16, 1, 16000, 16000, '0', '0', NULL, NULL),
(665, 1, '12506020', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 61, 4, 2, 1, 7, 1, 5600, 5600, '0', '0', NULL, NULL),
(666, 1, '12506010', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3147', 61, 4, 2, 1, 12, 1, 12500, 12500, '0', '0', NULL, NULL),
(667, 1, '00508015', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 11, 12, 5, 4, 1, 800, 800, '0', '0', NULL, NULL),
(668, 1, '00508016', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 51, 11, 12, 2, 4, 1, 1400, 1400, '0', '0', NULL, NULL),
(669, 1, '12506021', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 61, 4, 14, 1, 7, 1, 4800, 4800, '0', '0', NULL, NULL),
(670, 1, '12506011', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3147', 61, 4, 14, 1, 12, 1, 7500, 7500, '0', '0', NULL, NULL),
(671, 2, '12506015', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3169', 61, 4, 14, 1, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(672, 2, '15205521', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3148', 104, 4, 2, 12, 11, 1, 7500, 7500, '0', '0', NULL, NULL),
(673, 4, '20018001', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1243', 113, 3, 2, 1, 7, 1, 200, 200, '0', '0', NULL, NULL),
(674, 2, '47801030', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 103, 4, 2, 5, 10, 1, 80000, 67000, '0', '0', NULL, NULL),
(675, 2, '47801031', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 103, 4, 2, 2, 10, 1, 70000, 20000, '0', '0', NULL, NULL),
(676, 3, '11707001', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1481', 75, 15, 22, 9, 17, 4, 24000, 24000, '0', '0', NULL, NULL),
(677, 3, '11707003', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1481', 138, 15, 48, 6, 17, 4, 48000, 48000, '0', '0', NULL, NULL),
(678, 3, '11707000', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1481', 136, 15, 46, 9, 17, 4, 24000, 24000, '0', '0', NULL, NULL),
(679, 1, '603004002', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 88, 4, 3, 1, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(680, 4, '603004002', '3222', NULL, NULL, 'ABRIL 2021', 'INT-H-1242', 88, 4, 3, 1, 7, 1, 200, 200, '0', '0', NULL, NULL),
(681, 2, '603004031', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 88, 4, 3, 1, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(682, 2, '603004031', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3166', 88, 4, 3, 1, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(683, 1, '603004004', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 88, 17, 23, 1, 7, 1, 400, 400, '0', '0', NULL, NULL),
(684, 2, '47801032', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 103, 4, 2, 1, 10, 1, 70000, 35200, '0', '0', NULL, NULL),
(685, 2, '603004050', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3161', 88, 4, 3, 13, 11, 1, 3000, 3000, '0', '0', NULL, NULL),
(686, 2, '47801400', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 644, 4, 2, 3, 10, 1, 10000, 10000, '0', '0', NULL, NULL),
(687, 2, '47801401', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 644, 1, 1, 3, 10, 1, 8000, 8000, '0', '0', NULL, NULL),
(688, 2, '47801405', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 153, 4, 2, 4, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(689, 3, '09906036', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3168', 161, 4, 14, 2, 20, 2, 2400, 2400, '0', '0', NULL, NULL),
(690, 1, '00508022', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 91, 9, 11, 10, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(691, 1, '00508017', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 73, 11, 12, 6, 4, 1, 200, 200, '0', '0', NULL, NULL),
(692, 3, '09906035', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3165', 161, 4, 2, 2, 20, 4, 320, 320, '0', '0', NULL, NULL),
(693, 3, '09906037', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3165', 182, 3, 2, 3, 22, 4, 900, 900, '0', '0', NULL, NULL),
(694, 3, '09906037', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3168', 182, 3, 2, 3, 22, 4, 2250, 2250, '0', '0', NULL, NULL),
(695, 3, '09906038', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3168', 182, 16, 14, 3, 22, 2, 2250, 2250, '0', '0', NULL, NULL),
(696, 3, '09906039', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3165', 182, 9, 40, 3, 22, 4, 900, 900, '0', '0', NULL, NULL),
(697, 2, '47801409', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 664, 1, 1, 2, 10, 1, 14000, 14000, '0', '0', NULL, NULL),
(698, 2, '47801409', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1486', 664, 1, 1, 2, 10, 1, 10000, 10000, '0', '0', NULL, NULL),
(699, 2, '47801409', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1490', 664, 1, 1, 2, 10, 1, 16000, 16000, '0', '0', NULL, NULL),
(700, 2, '47801408', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 664, 4, 2, 2, 10, 1, 24000, 24000, '0', '0', NULL, NULL),
(701, 2, '47801416', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 665, 1, 1, 6, 10, 1, 28000, 28000, '0', '0', NULL, NULL),
(702, 2, '47801415', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 665, 4, 2, 6, 10, 1, 28000, 2600, '0', '0', NULL, NULL),
(703, 2, '47801415', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1490', 665, 4, 2, 6, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(704, 2, '47801415', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1486', 665, 4, 2, 6, 10, 1, 8000, 8000, '0', '0', NULL, NULL),
(705, 2, '47801500', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 220, 36, 2, 13, 10, 1, 4000, 4000, '0', '0', NULL, NULL),
(706, 2, '47801500', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1490', 220, 36, 2, 13, 10, 1, 1200, 1200, '0', '0', NULL, NULL),
(707, 2, '01606866', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1494', 56, 2, 1, 6, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(708, 2, '01606867', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1494', 56, 4, 2, 6, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(709, 2, '01606872', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1483', 56, 4, 2, 6, 11, 1, 4250, 4250, '0', '0', NULL, NULL),
(710, 1, '9900004039', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3157', 229, 2, 1, 3, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(711, 2, '08503500', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 779, 4, 2, 6, 10, 1, 12000, 12000, '0', '0', NULL, NULL),
(712, 2, '08503501', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1490', 165, 4, 2, 5, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(713, 2, '08503503', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 780, 4, 2, 2, 10, 1, 20000, 20000, '0', '0', NULL, NULL),
(714, 1, '9900009186', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3172', 53, 2, 1, 1, 10, 1, 12500, 12500, '0', '0', NULL, NULL),
(715, 1, '9900009186', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3172', 229, 2, 1, 3, 10, 1, 12500, 12500, '0', '0', NULL, NULL),
(716, 1, '9900009186', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3172', 90, 1, 6, 3, 10, 1, 12500, 12500, '0', '0', NULL, NULL),
(717, 1, '9900009186', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3172', 51, 2, 1, 5, 10, 1, 12500, 12500, '0', '0', NULL, NULL),
(718, 2, '603006600', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1494', 56, 2, 1, 3, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(719, 2, '47801211', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1489', 152, 4, 2, 8, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(720, 1, '9900004023', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3158', 53, 3, 2, 1, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(721, 2, '11803025', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1480', 50, 4, 2, 5, 10, 1, 20000, 20000, '0', '0', NULL, NULL),
(722, 2, '11803031', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1480', 146, 4, 2, 3, 10, 1, 20000, 20000, '0', '0', NULL, NULL),
(723, 2, '11803022', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1480', 149, 5, 4, 6, 10, 1, 10000, 10000, '0', '0', NULL, NULL),
(724, 2, '08503511', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1480', 112, 4, 2, 3, 10, 1, 16000, 16000, '0', '0', NULL, NULL),
(725, 2, '47801480', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 150, 3, 2, 6, 10, 4, 4000, 4000, '0', '0', NULL, NULL),
(726, 2, '47801481', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 150, 2, 1, 6, 10, 2, 2000, 2000, '0', '0', NULL, NULL),
(727, 3, '19911999', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3155', 889, 9, 16, 6, 12, 1, 400, 400, '0', '0', NULL, NULL),
(728, 3, '19912000', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3155', 889, 22, 34, 6, 12, 1, 750, 750, '0', '0', NULL, NULL),
(729, 2, '47801435', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1490', 116, 4, 2, 6, 10, 1, 400, 400, '0', '0', NULL, NULL),
(730, 2, '47801433', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 116, 4, 2, 15, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(731, 2, '47801556', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1490', 189, 1, 1, 1, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(732, 1, '603005751', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 92, 4, 2, 1, 4, 1, 2600, 2600, '0', '0', NULL, NULL),
(733, 1, '603005750', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 92, 2, 1, 1, 4, 1, 1400, 1400, '0', '0', NULL, NULL),
(734, 2, '00804066', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3166', 209, 3, 3, 2, 7, 1, 400, 400, '0', '0', NULL, NULL),
(735, 2, '47801562', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1494', 166, 1, 1, 2, 10, 1, 20000, 20000, '0', '0', NULL, NULL),
(736, 2, '47801563', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1493', 166, 4, 2, 2, 10, 1, 7000, 7000, '0', '0', NULL, NULL),
(737, 2, '47801560', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1494', 166, 1, 1, 1, 10, 1, 20000, 20000, '0', '0', NULL, NULL),
(738, 2, '603006601', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1494', 56, 4, 2, 3, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(739, 2, '603006603', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3174', 56, 9, 11, 3, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(740, 2, '01104500', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3164', 151, 4, 2, 15, 7, 1, 600, 600, '0', '0', NULL, NULL),
(741, 2, '01104509', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3159', 151, 4, 2, 15, 11, 1, 200, 200, '0', '0', NULL, NULL),
(742, 1, '00904005', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3156', 74, 3, 3, 5, 12, 1, 12500, 12500, '0', '0', NULL, NULL),
(743, 1, '603005752', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 92, 9, 11, 1, 4, 1, 9200, 9200, '0', '0', NULL, NULL),
(744, 2, '13705661', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3153', 947, 4, 2, 5, 7, 1, 3000, 3000, '0', '0', NULL, NULL),
(745, 2, '13705662', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3153', 947, 4, 2, 2, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(746, 2, '13705660', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3153', 947, 4, 2, 6, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(747, 1, '01606675', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 40, 20, 30, 5, 7, 1, 4800, 4800, '0', '0', NULL, NULL),
(748, 1, '01606676', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 40, 2, 1, 5, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(749, 1, '01606678', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3167', 40, 3, 2, 5, 7, 1, 6000, 6000, '0', '0', NULL, NULL),
(750, 1, '01606686', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3171', 40, 3, 2, 5, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(751, 1, '12503500', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 1, 1, 3, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(752, 1, '12503501', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 5, 4, 3, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(753, 1, '12503502', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 4, 14, 3, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(754, 1, '12503503', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 9, 39, 3, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(755, 2, '13705667', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3153', 947, 9, 39, 5, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(756, 2, '13705666', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3153', 947, 9, 39, 6, 7, 1, 1400, 1400, '0', '0', NULL, NULL),
(757, 2, '13705668', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3153', 947, 9, 39, 2, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(758, 2, '01606865', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3174', 56, 9, 11, 6, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(759, 1, '12503510', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 1, 1, 6, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(760, 1, '12503511', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 5, 4, 6, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(761, 1, '12503512', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 4, 14, 6, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(762, 1, '12503513', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 9, 39, 6, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(763, 1, '12503518', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 1, 1, 1, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(764, 1, '12503519', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 5, 4, 1, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(765, 1, '12503520', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 4, 14, 1, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(766, 1, '12503521', '3222', NULL, NULL, 'ABRIL 2021', 'FTT-1487', 111, 9, 39, 1, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(767, 1, '13105280', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3145', 163, 2, 65, 5, 7, 1, 500, 500, '0', '0', NULL, NULL),
(768, 1, '13105281', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3145', 163, 4, 66, 5, 7, 1, 500, 500, '0', '0', NULL, NULL),
(769, 1, '00504090', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3150', 51, 25, 75, 5, 4, 4, 20000, 20000, '0', '0', NULL, NULL),
(770, 1, '00504091', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3150', 51, 25, 75, 2, 4, 4, 20000, 20000, '0', '0', NULL, NULL),
(771, 1, '01606673', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3150', 40, 25, 75, 5, 4, 5, 15000, 15000, '0', '0', NULL, NULL),
(772, 1, '00504092', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3150', 99, 25, 75, 6, 4, 4, 20000, 20000, '0', '0', NULL, NULL),
(773, 1, '12403100', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3152', 1125, 3, 2, 6, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(774, 2, '47801429', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3170', 116, 22, 34, 2, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(775, 1, '9900004018', '3222', NULL, NULL, 'ABRIL 2021', 'HON-3178', 53, 28, 43, 1, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(776, 1, '603004002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 88, 4, 3, 1, 7, 1, 6800, 6800, '0', '0', NULL, NULL),
(777, 2, '603004031', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 88, 4, 3, 1, 11, 1, 1250, 1250, '0', '0', NULL, NULL),
(778, 1, '603004004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 88, 17, 23, 1, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(779, 1, '00110225', '3235', NULL, NULL, 'MAYO 2021', 'HON-3199', 1015, 1, 1, 1, 7, 1, 400, 400, '0', '0', NULL, NULL),
(780, 1, '00110226', '3235', NULL, NULL, 'MAYO 2021', 'HON-3199', 1015, 168, 2, 1, 7, 1, 400, 400, '0', '0', NULL, NULL),
(781, 2, '47801000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3183', 168, 2, 1, 6, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(782, 4, '20005057', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 90, 1, 5, 3, 7, 3, 5000, 5000, '0', '0', NULL, NULL),
(783, 1, '20005010', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 90, 3, 35, 3, 4, 0, 1200, 1200, '0', '0', NULL, NULL),
(784, 4, '20005051', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 90, 3, 35, 3, 7, 3, 600, 600, '0', '0', NULL, NULL),
(785, 1, '00303023', '3235', NULL, NULL, 'MAYO 2021', 'HON-3186', 90, 3, 35, 3, 21, 2, 5000, 5000, '0', '0', NULL, NULL),
(786, 1, '20005000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 90, 1, 6, 3, 7, 1, 9200, 9200, '0', '0', NULL, NULL),
(787, 4, '20005000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 90, 1, 6, 3, 7, 1, 4600, 4600, '0', '0', NULL, NULL),
(788, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 90, 1, 6, 3, 9, 1, 2300, 2300, '0', '0', NULL, NULL),
(789, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 2, 1, 6, 9, 1, 2300, 2300, '0', '0', NULL, NULL),
(790, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 61, 2, 1, 1, 9, 1, 2300, 2300, '0', '0', NULL, NULL),
(791, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 2, 1, 2, 9, 1, 2300, 2300, '0', '0', NULL, NULL),
(792, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 2, 1, 3, 9, 1, 2300, 2300, '0', '0', NULL, NULL),
(793, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 67, 2, 1, 3, 9, 1, 2300, 2300, '0', '0', NULL, NULL),
(794, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL, NULL),
(795, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL, NULL),
(796, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL, NULL),
(797, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 101, 2, 5, 4, 9, 1, 2300, 2300, '0', '0', NULL, NULL),
(798, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 90, 1, 6, 3, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(799, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 99, 2, 1, 6, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(800, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 61, 2, 1, 1, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(801, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 51, 2, 1, 2, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(802, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 51, 2, 1, 3, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(803, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 67, 2, 1, 3, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(804, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL, NULL),
(805, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL, NULL),
(806, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL, NULL),
(807, 1, '10104940', '3235', NULL, NULL, 'MAYO 2021', 'HON-3179', 101, 2, 5, 4, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(808, 2, '20005016', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 90, 1, 6, 3, 11, 1, 500, 500, '0', '0', NULL, NULL),
(809, 2, '10499060', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 90, 45, 1, 19, 11, 1, 400, 400, '0', '0', NULL, NULL),
(810, 2, '10499060', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 67, 45, 1, 2, 11, 1, 0, 0, '0', '0', NULL, NULL),
(811, 2, '10499060', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 255, 45, 1, 19, 11, 1, 0, 0, '0', '0', NULL, NULL),
(812, 2, '10499060', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 51, 2, 1, 1, 11, 1, 400, 400, '0', '0', NULL, NULL),
(813, 2, '10499060', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 457, 45, 1, 19, 11, 1, 0, 0, '0', '0', NULL, NULL),
(814, 1, '20005002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 90, 3, 21, 3, 7, 3, 8800, 8800, '0', '0', NULL, NULL),
(815, 4, '20005002', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 90, 3, 21, 3, 7, 3, 2000, 2000, '0', '0', NULL, NULL),
(816, 2, '01004013', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 90, 3, 21, 3, 12, 1, 250, 250, '0', '0', NULL, NULL),
(817, 1, '20005001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 90, 3, 3, 3, 7, 3, 14800, 14800, '0', '0', NULL, NULL),
(818, 1, '01004012', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 90, 3, 3, 3, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(819, 2, '01004012', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 90, 3, 3, 3, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(820, 2, '20005006', '3235', NULL, NULL, 'MAYO 2021', 'HON-3176', 90, 3, 3, 3, 11, 1, 1250, 1250, '0', '0', NULL, NULL),
(821, 1, '20005005', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 90, 34, 52, 3, 7, 1, 800, 800, '0', '0', NULL, NULL),
(822, 1, '20005007', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 90, 9, 26, 3, 7, 1, 1600, 1600, '0', '0', NULL, NULL),
(823, 4, '20005007', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 90, 9, 26, 3, 7, 1, 400, 400, '0', '0', NULL, NULL),
(824, 4, '20005007', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 90, 9, 26, 3, 7, 1, 400, 400, '0', '0', NULL, NULL),
(825, 4, '20005058', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1245', 90, 32, 117, 3, 7, 3, 400, 400, '0', '0', NULL, NULL);
INSERT INTO `pendiente` (`id_pendiente`, `categoria`, `item`, `orden_del_sitema`, `observacion`, `presentacion`, `mes`, `orden`, `marca`, `vitola`, `nombre`, `capa`, `tipo_empaque`, `cello`, `pendiente`, `saldo`, `paquetes`, `unidades`, `serie_precio`, `precio`) VALUES
(826, 4, '00508020', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 91, 4, 2, 10, 7, 1, 200, 200, '0', '0', NULL, NULL),
(827, 1, '00508022', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 91, 9, 11, 10, 7, 1, 2800, 2800, '0', '0', NULL, NULL),
(828, 4, '00508022', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 91, 9, 11, 10, 7, 1, 200, 200, '0', '0', NULL, NULL),
(829, 2, '00804066', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 209, 3, 3, 2, 7, 1, 400, 400, '0', '0', NULL, NULL),
(830, 2, '00804065', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 209, 18, 6, 2, 7, 1, 400, 400, '0', '0', NULL, NULL),
(831, 1, '13105120', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 210, 2, 1, 3, 4, 0, 600, 600, '0', '0', NULL, NULL),
(832, 2, '15406023', '3235', NULL, NULL, 'MAYO 2021', 'HON-3183', 167, 4, 2, 2, 11, 1, 250, 250, '0', '0', NULL, NULL),
(833, 1, '603005751', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 92, 4, 2, 1, 4, 1, 400, 400, '0', '0', NULL, NULL),
(834, 4, '603005751', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 92, 4, 2, 1, 4, 1, 4300, 4300, '0', '0', NULL, NULL),
(835, 1, '603005750', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 92, 2, 1, 1, 4, 1, 2000, 2000, '0', '0', NULL, NULL),
(836, 4, '603005751', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 92, 4, 2, 1, 4, 1, 200, 200, '0', '0', NULL, NULL),
(837, 4, '603005750', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 92, 2, 1, 1, 4, 1, 6700, 6700, '0', '0', NULL, NULL),
(838, 4, '603005750', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 92, 2, 1, 1, 4, 1, 200, 200, '0', '0', NULL, NULL),
(839, 4, '603005752', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 92, 9, 11, 1, 4, 1, 200, 200, '0', '0', NULL, NULL),
(840, 2, '01104500', '3235', NULL, NULL, 'MAYO 2021', 'HON-3183', 151, 4, 2, 15, 7, 1, 500, 500, '0', '0', NULL, NULL),
(841, 2, '01104509', '3235', NULL, NULL, 'MAYO 2021', 'HON-3183', 151, 4, 2, 15, 11, 1, 400, 400, '0', '0', NULL, NULL),
(842, 1, '00407000', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1502', 158, 15, 46, 9, 15, 1, 3000, 3000, '0', '0', NULL, NULL),
(843, 4, '00407000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 158, 15, 46, 9, 15, 1, 10500, 10500, '0', '0', NULL, NULL),
(844, 1, '00107000', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1502', 141, 15, 53, 9, 15, 1, 3000, 3000, '0', '0', NULL, NULL),
(845, 4, '00107000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 141, 15, 53, 9, 15, 1, 10000, 10000, '0', '0', NULL, NULL),
(846, 1, '00231000', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1502', 62, 15, 18, 3, 15, 1, 3000, 3000, '0', '0', NULL, NULL),
(847, 1, '00507001', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1502', 159, 15, 62, 6, 15, 1, 4000, 4000, '0', '0', NULL, NULL),
(848, 4, '00507001', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 159, 15, 62, 6, 15, 1, 21000, 21000, '0', '0', NULL, NULL),
(849, 4, '00231001', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 160, 15, 64, 4, 15, 1, 9500, 9500, '0', '0', NULL, NULL),
(850, 1, '15003000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3190', 184, 24, 6, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(851, 1, '15004001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3190', 184, 5, 51, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(852, 1, '15004002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3190', 184, 3, 3, 2, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(853, 1, '9900009110', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 93, 2, 79, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(854, 1, '9900009118', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 93, 2, 79, 2, 10, 1, 2500, 2500, '0', '0', NULL, NULL),
(855, 1, '9900009118', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 93, 2, 79, 2, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(856, 1, '9900009111', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 93, 3, 27, 2, 7, 1, 3000, 3000, '0', '0', NULL, NULL),
(857, 1, '9900009117', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 93, 3, 27, 2, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(858, 1, '9900009117', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 93, 3, 27, 2, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(859, 1, '9900009112', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 93, 9, 28, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(860, 1, '9900004000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 94, 9, 16, 2, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(861, 1, '9900004002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 94, 2, 1, 2, 7, 1, 3000, 3000, '0', '0', NULL, NULL),
(862, 1, '9900004004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 94, 2, 1, 2, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(863, 1, '9900004004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 94, 2, 1, 2, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(864, 1, '9900004003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 94, 25, 2, 2, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(865, 1, '9900004005', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 94, 25, 2, 2, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(866, 1, '9900004005', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 94, 25, 2, 2, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(867, 1, '9900004011', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 228, 2, 1, 1, 7, 1, 6000, 6000, '0', '0', NULL, NULL),
(868, 1, '9900004015', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 228, 2, 1, 1, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(869, 1, '9900004015', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 228, 2, 1, 1, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(870, 1, '9900004012', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 228, 3, 2, 1, 7, 1, 8000, 8000, '0', '0', NULL, NULL),
(871, 1, '9900004016', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 228, 2, 1, 1, 10, 1, 6000, 6000, '0', '0', NULL, NULL),
(872, 1, '9900004016', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 228, 2, 1, 1, 10, 1, 4000, 4000, '0', '0', NULL, NULL),
(873, 1, '9900004013', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 228, 9, 16, 1, 7, 1, 5000, 5000, '0', '0', NULL, NULL),
(874, 1, '9900004019', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 53, 2, 1, 1, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(875, 1, '9900004022', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 53, 2, 1, 1, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(876, 1, '9900004022', '3235', NULL, NULL, 'MAYO 2021', 'HON-3203', 53, 2, 1, 1, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(877, 1, '9900004020', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 53, 3, 2, 1, 7, 1, 7000, 7000, '0', '0', NULL, NULL),
(878, 1, '9900004023', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 53, 3, 2, 1, 10, 1, 4000, 4000, '0', '0', NULL, NULL),
(879, 1, '9900004023', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 53, 3, 2, 1, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(880, 1, '9900004035', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 229, 9, 16, 3, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(881, 1, '9900004037', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 229, 2, 1, 3, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(882, 1, '9900004039', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 229, 2, 1, 3, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(883, 1, '9900004039', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 229, 2, 1, 3, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(884, 1, '9900004038', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 229, 3, 2, 3, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(885, 1, '9900004040', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 229, 3, 2, 3, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(887, 1, '9900004040', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 229, 3, 2, 3, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(888, 1, '9900009187', '3235', NULL, NULL, 'MAYO 2021', 'HON-3202', 229, 3, 2, 3, 11, 1, 2000, 2000, '0', '0', NULL, NULL),
(889, 1, '9900009187', '3235', NULL, NULL, 'MAYO 2021', 'HON-3202', 94, 25, 2, 2, 11, 1, 2000, 2000, '0', '0', NULL, NULL),
(890, 1, '9900009187', '3235', NULL, NULL, 'MAYO 2021', 'HON-3202', 228, 3, 2, 1, 11, 1, 2000, 2000, '0', '0', NULL, NULL),
(891, 1, '9900009187', '3235', NULL, NULL, 'MAYO 2021', 'HON-3202', 53, 3, 2, 1, 11, 1, 2000, 2000, '0', '0', NULL, NULL),
(892, 1, '9900009187', '3235', NULL, NULL, 'MAYO 2021', 'HON-3202', 230, 3, 2, 1, 11, 1, 2000, 2000, '0', '0', NULL, NULL),
(893, 1, '9900004028', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 230, 3, 2, 1, 7, 1, 3000, 3000, '0', '0', NULL, NULL),
(894, 1, '9900004031', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 230, 3, 2, 1, 10, 1, 500, 500, '0', '0', NULL, NULL),
(895, 1, '9900004031', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 230, 3, 2, 1, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(896, 1, '9900004027', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 230, 2, 1, 1, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(897, 1, '9900004030', '3235', NULL, NULL, 'MAYO 2021', 'HON-3187', 230, 2, 1, 1, 10, 1, 4000, 4000, '0', '0', NULL, NULL),
(898, 1, '9900004030', '3235', NULL, NULL, 'MAYO 2021', 'HON-3204', 230, 2, 1, 1, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(899, 1, '9900004025', '3235', NULL, NULL, 'MAYO 2021', 'HON-3184', 230, 9, 16, 1, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(900, 1, '12403003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3188', 66, 2, 1, 6, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(901, 1, '12403003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3177', 66, 2, 1, 6, 7, 1, 300, 300, '0', '0', NULL, NULL),
(902, 1, '1240300100', '3235', NULL, NULL, 'MAYO 2021', 'HON-3177', 66, 2, 1, 6, 10, 1, 200, 200, '0', '0', NULL, NULL),
(903, 1, '12403004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3188', 66, 3, 2, 6, 7, 1, 3000, 3000, '0', '0', NULL, NULL),
(904, 1, '12403004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3177', 66, 3, 2, 6, 7, 1, 600, 600, '0', '0', NULL, NULL),
(905, 1, '1240300101', '3235', NULL, NULL, 'MAYO 2021', 'HON-3188', 66, 3, 2, 6, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(906, 1, '12403005', '3235', NULL, NULL, 'MAYO 2021', 'HON-3177', 66, 3, 14, 6, 7, 1, 200, 200, '0', '0', NULL, NULL),
(907, 1, '1240300102', '3235', NULL, NULL, 'MAYO 2021', 'HON-3177', 66, 3, 14, 6, 10, 1, 200, 200, '0', '0', NULL, NULL),
(908, 1, '12403006', '3235', NULL, NULL, 'MAYO 2021', 'HON-3177', 66, 5, 4, 6, 7, 1, 300, 300, '0', '0', NULL, NULL),
(909, 1, '12403007', '3235', NULL, NULL, 'MAYO 2021', 'HON-3177', 66, 22, 34, 6, 7, 1, 700, 700, '0', '0', NULL, NULL),
(910, 1, '1240300103', '3235', NULL, NULL, 'MAYO 2021', 'HON-3188', 66, 22, 34, 6, 10, 1, 1000, 1000, '0', '0', NULL, NULL),
(911, 1, '1240300103', '3235', NULL, NULL, 'MAYO 2021', 'HON-3177', 66, 22, 34, 6, 10, 1, 500, 500, '0', '0', NULL, NULL),
(912, 2, '01603005', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 109, 38, 57, 1, 12, 1, 250, 250, '0', '0', NULL, NULL),
(913, 2, '01605002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 109, 28, 14, 1, 12, 1, 125, 125, '0', '0', NULL, NULL),
(914, 1, '01606675', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 40, 20, 30, 5, 7, 1, 6000, 6000, '0', '0', NULL, NULL),
(915, 4, '01606675', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 40, 20, 30, 5, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(916, 1, '01606676', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 40, 2, 1, 5, 7, 1, 4800, 4800, '0', '0', NULL, NULL),
(917, 4, '01606676', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 40, 2, 1, 5, 7, 1, 9000, 9000, '0', '0', NULL, NULL),
(918, 4, '01606677', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 40, 9, 11, 5, 7, 1, 5000, 5000, '0', '0', NULL, NULL),
(919, 1, '01606678', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 40, 3, 2, 5, 7, 1, 7600, 7600, '0', '0', NULL, NULL),
(920, 4, '01606677', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 40, 9, 11, 5, 7, 1, 200, 200, '0', '0', NULL, NULL),
(921, 4, '01606678', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 40, 3, 2, 5, 7, 1, 3200, 3200, '0', '0', NULL, NULL),
(922, 2, '00904111', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 186, 3, 3, 2, 9, 1, 1000, 1000, '0', '0', NULL, NULL),
(923, 2, '40923002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 186, 3, 3, 5, 9, 1, 1000, 1000, '0', '0', NULL, NULL),
(924, 2, '08503501', '3235', NULL, NULL, 'MAYO 2021', 'HON-1495', 165, 4, 2, 5, 10, 1, 1600, 1600, '0', '0', NULL, NULL),
(925, 1, '11220035', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1503', 943, 4, 2, 1, 10, 1, 140, 140, '0', '0', NULL, NULL),
(926, 1, '11220036', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1503', 943, 4, 2, 6, 10, 1, 140, 140, '0', '0', NULL, NULL),
(927, 1, '581000250', '3235', NULL, NULL, 'MAYO 2021', 'HON-3185', 214, 3, 3, 3, 4, 1, 1500, 1500, '0', '0', NULL, NULL),
(928, 4, '01606678', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 40, 3, 2, 5, 7, 1, 200, 200, '0', '0', NULL, NULL),
(929, 3, '09906000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3181', 219, 3, 3, 3, 24, 4, 300, 300, '0', '0', NULL, NULL),
(930, 3, '09906004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3181', 219, 9, 11, 3, 24, 2, 240, 240, '0', '0', NULL, NULL),
(931, 3, '09906010', '3235', NULL, NULL, 'MAYO 2021', 'HON-3181', 181, 9, 11, 6, 20, 4, 2400, 2400, '0', '0', NULL, NULL),
(932, 3, '09906012', '3235', NULL, NULL, 'MAYO 2021', 'HON-3181', 181, 4, 2, 6, 20, 4, 800, 800, '0', '0', NULL, NULL),
(933, 3, '09906018', '3235', NULL, NULL, 'MAYO 2021', 'HON-3181', 181, 22, 34, 6, 20, 4, 640, 640, '0', '0', NULL, NULL),
(934, 3, '09906039', '3235', NULL, NULL, 'MAYO 2021', 'HON-3181', 182, 9, 40, 3, 22, 4, 900, 900, '0', '0', NULL, NULL),
(935, 2, '01606877', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1499', 56, 4, 2, 6, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(936, 2, '603006614', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1499', 56, 9, 11, 3, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(937, 2, '01606878', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1499', 56, 9, 11, 6, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(938, 2, '603006630', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1498', 56, 2, 1, 2, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(939, 2, '603006646', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1499', 56, 2, 1, 2, 9, 1, 5000, 5000, '0', '0', NULL, NULL),
(940, 2, '603006640', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1498', 56, 2, 1, 2, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(941, 2, '603006631', '3235', NULL, NULL, 'MAYO 2021', 'FFT-1498', 56, 4, 2, 2, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(942, 2, '603006645', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1498', 56, 4, 2, 2, 12, 1, 10000, 10000, '0', '0', NULL, NULL),
(943, 2, '603006647', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1499', 56, 4, 2, 2, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(944, 2, '603006641', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1498', 56, 4, 2, 2, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(945, 2, '603006632', '3235', NULL, NULL, 'MAYO 2021', 'FFT-1498', 56, 9, 11, 2, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(946, 2, '603006649', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1499', 56, 9, 11, 2, 9, 1, 10000, 10000, '0', '0', NULL, NULL),
(947, 2, '603006642', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1498', 56, 9, 11, 2, 11, 1, 2500, 2500, '0', '0', NULL, NULL),
(948, 4, '01607600', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 95, 20, 30, 11, 7, 1, 500, 500, '0', '0', NULL, NULL),
(949, 4, '01607602', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 95, 3, 2, 11, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(950, 4, '01607602', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 95, 3, 2, 11, 7, 1, 200, 200, '0', '0', NULL, NULL),
(951, 4, '01607603', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 95, 9, 11, 11, 7, 1, 1800, 1800, '0', '0', NULL, NULL),
(952, 1, '00110285', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 72, 4, 2, 5, 10, 1, 800, 800, '0', '0', NULL, NULL),
(953, 1, '00110286', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 72, 4, 2, 2, 10, 1, 800, 800, '0', '0', NULL, NULL),
(954, 1, '00110284', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 72, 9, 11, 6, 10, 1, 400, 400, '0', '0', NULL, NULL),
(955, 1, '00401000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 67, 19, 25, 3, 7, 3, 1600, 1600, '0', '0', NULL, NULL),
(956, 4, '00401000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 67, 19, 25, 3, 7, 3, 1200, 1200, '0', '0', NULL, NULL),
(957, 1, '00403000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 67, 2, 1, 3, 7, 3, 4800, 4800, '0', '0', NULL, NULL),
(958, 4, '00403000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 67, 2, 1, 3, 7, 3, 4800, 4800, '0', '0', NULL, NULL),
(959, 2, '13403000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 67, 2, 1, 3, 11, 1, 500, 500, '0', '0', NULL, NULL),
(960, 1, '00404000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 67, 3, 2, 3, 7, 3, 3200, 3200, '0', '0', NULL, NULL),
(961, 4, '00403000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 67, 2, 1, 3, 7, 3, 100, 100, '0', '0', NULL, NULL),
(962, 4, '00404000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 67, 3, 2, 3, 7, 3, 2200, 2200, '0', '0', NULL, NULL),
(963, 1, '00408000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 67, 9, 40, 3, 7, 3, 400, 400, '0', '0', NULL, NULL),
(964, 4, '00404000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 67, 3, 2, 3, 7, 3, 200, 200, '0', '0', NULL, NULL),
(965, 4, '00408000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 67, 9, 40, 3, 7, 3, 2000, 2000, '0', '0', NULL, NULL),
(966, 2, '13408000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 67, 9, 40, 3, 11, 1, 1250, 1250, '0', '0', NULL, NULL),
(967, 1, '00303007', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 67, 25, 2, 3, 4, 1, 1600, 1600, '0', '0', NULL, NULL),
(968, 4, '00408000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 67, 9, 40, 3, 7, 3, 600, 600, '0', '0', NULL, NULL),
(969, 4, '00303007', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 67, 25, 2, 3, 4, 1, 1750, 1750, '0', '0', NULL, NULL),
(970, 1, '00405000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 67, 16, 14, 3, 7, 3, 400, 400, '0', '0', NULL, NULL),
(971, 4, '00405000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 67, 16, 14, 3, 7, 3, 700, 700, '0', '0', NULL, NULL),
(972, 2, '01103005', '3235', NULL, NULL, 'MAYO 2021', 'HON-3183', 59, 24, 21, 2, 11, 1, 250, 250, '0', '0', NULL, NULL),
(973, 2, '01119000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3192', 59, 24, 21, 2, 13, 3, 1375, 1375, '0', '0', NULL, NULL),
(974, 2, '01103000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3183', 59, 1, 6, 18, 13, 3, 750, 750, '0', '0', NULL, NULL),
(975, 2, '01104000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3183', 59, 4, 3, 2, 13, 3, 625, 625, '0', '0', NULL, NULL),
(976, 4, '01607603', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 95, 9, 11, 11, 7, 1, 400, 400, '0', '0', NULL, NULL),
(977, 4, '20018002', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 113, 9, 11, 1, 7, 1, 200, 200, '0', '0', NULL, NULL),
(978, 2, '20018022', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 113, 9, 11, 1, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(979, 4, '20018003', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 113, 26, 123, 1, 7, 3, 200, 200, '0', '0', NULL, NULL),
(980, 1, '00504006', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 5, 18, 3, 14000, 14000, '0', '0', NULL, NULL),
(981, 4, '00504006', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 5, 18, 3, 4000, 4000, '0', '0', NULL, NULL),
(982, 1, '00504002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 5, 7, 3, 12400, 12400, '0', '0', NULL, NULL),
(983, 4, '00504006', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 51, 4, 2, 5, 18, 3, 200, 200, '0', '0', NULL, NULL),
(984, 4, '00504002', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 5, 7, 3, 4200, 4200, '0', '0', NULL, NULL),
(985, 1, '00504009', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 51, 4, 2, 5, 12, 1, 500, 500, '0', '0', NULL, NULL),
(986, 2, '00504009', '3235', NULL, NULL, 'MAYO 2021', 'HON-3193', 51, 4, 2, 5, 12, 1, 1875, 1875, '0', '0', NULL, NULL),
(987, 1, '00504007', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 2, 18, 3, 20000, 20000, '0', '0', NULL, NULL),
(988, 4, '00504007', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 2, 18, 3, 5500, 5500, '0', '0', NULL, NULL),
(989, 1, '00504003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 2, 7, 3, 12800, 12800, '0', '0', NULL, NULL),
(990, 4, '00504003', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 2, 7, 3, 4200, 4200, '0', '0', NULL, NULL),
(991, 1, '00504010', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 51, 4, 2, 2, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(992, 2, '00504010', '3235', NULL, NULL, 'MAYO 2021', 'HON-3193', 51, 4, 2, 2, 12, 1, 1875, 1875, '0', '0', NULL, NULL),
(993, 1, '00904038', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 2, 14, 1, 13200, 13200, '0', '0', NULL, NULL),
(994, 1, '00904038', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 5, 14, 1, 13200, 13200, '0', '0', NULL, NULL),
(995, 1, '00904038', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 1, 14, 1, 13200, 13200, '0', '0', NULL, NULL),
(996, 1, '00904038', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 3, 14, 1, 13200, 13200, '0', '0', NULL, NULL),
(997, 1, '00505002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 14, 5, 7, 3, 3600, 3600, '0', '0', NULL, NULL),
(998, 1, '00505007', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 14, 2, 18, 3, 6000, 6000, '0', '0', NULL, NULL),
(999, 1, '00505003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 14, 2, 7, 3, 1200, 1200, '0', '0', NULL, NULL),
(1000, 1, '00505009', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 51, 4, 14, 2, 12, 1, 500, 500, '0', '0', NULL, NULL),
(1001, 1, '10515002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 2, 1, 5, 4, 1, 800, 800, '0', '0', NULL, NULL),
(1002, 1, '00504100', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 2, 1, 5, 7, 1, 6400, 6400, '0', '0', NULL, NULL),
(1003, 2, '00504010', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 51, 4, 2, 2, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(1004, 4, '00504100', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 2, 1, 5, 7, 1, 6400, 6400, '0', '0', NULL, NULL),
(1005, 1, '10104912', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 2, 1, 5, 23, 1, 8000, 8000, '0', '0', NULL, NULL),
(1006, 2, '00503004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 51, 2, 1, 5, 12, 1, 250, 250, '0', '0', NULL, NULL),
(1007, 1, '10515003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 2, 1, 2, 4, 4, 200, 200, '0', '0', NULL, NULL),
(1008, 1, '00504101', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 2, 1, 2, 7, 3, 4000, 4000, '0', '0', NULL, NULL),
(1009, 4, '00504101', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 2, 1, 2, 7, 3, 6000, 6000, '0', '0', NULL, NULL),
(1013, 1, '00605002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 14, 17, 5, 13, 3, 1500, 1500, '0', '0', NULL, NULL),
(1014, 4, '00605002', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 14, 17, 5, 13, 3, 2000, 2000, '0', '0', NULL, NULL),
(1016, 1, '00605003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 14, 17, 2, 13, 3, 2000, 2000, '0', '0', NULL, NULL),
(1017, 4, '00605003', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 14, 17, 2, 13, 3, 2000, 2000, '0', '0', NULL, NULL),
(1018, 2, '40503001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3190', 51, 18, 24, 5, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(1019, 2, '40503023', '3235', NULL, NULL, 'MAYO 2021', 'HON-3190', 51, 18, 24, 5, 9, 1, 3000, 3000, '0', '0', NULL, NULL),
(1020, 2, '40503002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3190', 51, 18, 24, 2, 7, 1, 10000, 10000, '0', '0', NULL, NULL),
(1021, 1, '00508000', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 9, 32, 5, 7, 3, 5200, 5200, '0', '0', NULL, NULL),
(1022, 4, '00508000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 9, 32, 5, 7, 3, 1500, 1500, '0', '0', NULL, NULL),
(1023, 1, '00504041', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 51, 9, 32, 5, 11, 1, 1500, 1500, '0', '0', NULL, NULL),
(1024, 2, '00504041', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 51, 9, 32, 5, 11, 1, 200, 200, '0', '0', NULL, NULL),
(1025, 1, '00508001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 9, 32, 2, 7, 3, 6800, 6800, '0', '0', NULL, NULL),
(1026, 4, '00508001', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 9, 32, 2, 7, 3, 2200, 2200, '0', '0', NULL, NULL),
(1027, 1, '00504042', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 51, 9, 32, 2, 11, 1, 1500, 1500, '0', '0', NULL, NULL),
(1028, 2, '00504042', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 51, 9, 32, 2, 11, 1, 200, 200, '0', '0', NULL, NULL),
(1029, 1, '00504102', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 22, 34, 5, 7, 1, 800, 800, '0', '0', NULL, NULL),
(1030, 1, '00504103', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 22, 34, 2, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(1031, 1, '00504024', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 3, 18, 1, 10000, 10000, '0', '0', NULL, NULL),
(1032, 4, '00508001', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 51, 9, 32, 2, 7, 3, 200, 200, '0', '0', NULL, NULL),
(1033, 4, '00504024', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1245', 51, 4, 2, 3, 18, 1, 2000, 2000, '0', '0', NULL, NULL),
(1034, 1, '00504032', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 3, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(1035, 4, '00504032', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 51, 4, 2, 3, 7, 1, 100, 100, '0', '0', NULL, NULL),
(1036, 1, '00504037', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 51, 4, 2, 3, 12, 1, 500, 500, '0', '0', NULL, NULL),
(1037, 1, '00505019', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 14, 3, 18, 1, 2000, 2000, '0', '0', NULL, NULL),
(1038, 1, '00504033', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 14, 3, 7, 1, 800, 800, '0', '0', NULL, NULL),
(1039, 1, '00504038', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 51, 4, 14, 3, 12, 1, 250, 250, '0', '0', NULL, NULL),
(1040, 2, '00504047', '3235', NULL, NULL, 'MAYO 2021', 'HON-3191', 51, 4, 14, 3, 11, 1, 350, 350, '0', '0', NULL, NULL),
(1041, 4, '00503009', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 6, 43, 5, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(1042, 1, '00504150', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 4, 2, 15, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(1043, 4, '00504150', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 15, 7, 1, 6400, 6400, '0', '0', NULL, NULL),
(1044, 4, '00508010', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 21, 33, 5, 19, 1, 7800, 7800, '0', '0', NULL, NULL),
(1045, 4, '00508010', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 51, 21, 33, 5, 19, 1, 900, 900, '0', '0', NULL, NULL),
(1046, 4, '00508011', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 21, 33, 2, 19, 1, 4800, 4800, '0', '0', NULL, NULL),
(1047, 1, '00508015', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 11, 12, 5, 4, 1, 600, 600, '0', '0', NULL, NULL),
(1048, 4, '00508011', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 51, 21, 33, 2, 19, 1, 600, 600, '0', '0', NULL, NULL),
(1049, 4, '00508015', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 11, 12, 5, 4, 1, 700, 700, '0', '0', NULL, NULL),
(1050, 1, '00508016', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 51, 11, 12, 2, 4, 1, 1200, 1200, '0', '0', NULL, NULL),
(1051, 4, '00508016', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 51, 11, 12, 2, 4, 1, 1000, 1000, '0', '0', NULL, NULL),
(1052, 1, '00705003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 4, 14, 6, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(1053, 1, '00705001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 4, 14, 6, 21, 3, 1000, 1000, '0', '0', NULL, NULL),
(1054, 1, '10515004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 2, 76, 6, 4, 8, 1200, 1200, '0', '0', NULL, NULL),
(1055, 4, '00703003', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 99, 2, 1, 6, 7, 1, 7000, 7000, '0', '0', NULL, NULL),
(1056, 1, '00703001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 2, 1, 6, 21, 3, 8000, 8000, '0', '0', NULL, NULL),
(1057, 1, '10104911', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 2, 1, 6, 23, 1, 200, 200, '0', '0', NULL, NULL),
(1058, 1, '00712003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 22, 34, 6, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(1059, 1, '00712001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 22, 34, 6, 21, 3, 3000, 3000, '0', '0', NULL, NULL),
(1060, 1, '00712004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 99, 22, 34, 6, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(1061, 1, '00704003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 4, 2, 6, 7, 1, 6400, 6400, '0', '0', NULL, NULL),
(1062, 4, '00704003', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 99, 4, 2, 6, 7, 1, 5400, 5400, '0', '0', NULL, NULL),
(1063, 1, '00704001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 4, 2, 6, 21, 3, 1000, 1000, '0', '0', NULL, NULL),
(1064, 1, '00704004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 99, 4, 2, 6, 12, 1, 500, 500, '0', '0', NULL, NULL),
(1065, 2, '00704004', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 99, 4, 2, 6, 12, 1, 125, 125, '0', '0', NULL, NULL),
(1066, 1, '00508002', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 99, 9, 11, 6, 7, 1, 3600, 3600, '0', '0', NULL, NULL),
(1067, 4, '00508002', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 99, 9, 11, 6, 7, 1, 1400, 1400, '0', '0', NULL, NULL),
(1068, 1, '00504043', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 99, 9, 11, 6, 11, 1, 1000, 1000, '0', '0', NULL, NULL),
(1069, 2, '00504043', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 99, 9, 11, 6, 11, 1, 200, 200, '0', '0', NULL, NULL),
(1071, 4, '00702000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 99, 33, 30, 6, 7, 1, 3500, 3500, '0', '0', NULL, NULL),
(1072, 1, '00508017', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 73, 11, 12, 6, 4, 1, 400, 400, '0', '0', NULL, NULL),
(1073, 4, '00508017', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1245', 73, 11, 12, 6, 4, 1, 400, 400, '0', '0', NULL, NULL),
(1074, 2, '47801041', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1500', 103, 4, 2, 2, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(1075, 2, '47801043', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1500', 148, 4, 2, 1, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(1076, 2, '47801044', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1500', 148, 4, 2, 3, 10, 1, 2000, 2000, '0', '0', NULL, NULL),
(1077, 2, '47801042', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1500', 148, 4, 2, 6, 10, 1, 4000, 4000, '0', '0', NULL, NULL),
(1078, 1, '12506001', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 61, 4, 2, 1, 16, 1, 8000, 8000, '0', '0', NULL, NULL),
(1079, 4, '12506001', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 61, 4, 2, 1, 16, 1, 4000, 4000, '0', '0', NULL, NULL),
(1080, 1, '12506020', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 61, 4, 2, 1, 7, 1, 5600, 5600, '0', '0', NULL, NULL),
(1081, 4, '12506020', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 61, 4, 2, 1, 7, 1, 18000, 18000, '0', '0', NULL, NULL),
(1082, 1, '12506010', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 61, 4, 2, 1, 12, 1, 625, 625, '0', '0', NULL, NULL),
(1083, 2, '12506010', '3235', NULL, NULL, 'MAYO 2021', 'HON-3193', 61, 4, 2, 1, 12, 1, 1250, 1250, '0', '0', NULL, NULL),
(1084, 1, '00508003', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 61, 9, 11, 1, 7, 1, 400, 400, '0', '0', NULL, NULL),
(1085, 4, '00508003', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 61, 9, 11, 1, 7, 1, 2300, 2300, '0', '0', NULL, NULL),
(1086, 2, '15506017', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 61, 9, 11, 1, 11, 1, 200, 200, '0', '0', NULL, NULL),
(1087, 1, '12506021', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 61, 4, 14, 1, 7, 1, 2800, 2800, '0', '0', NULL, NULL),
(1088, 4, '12506021', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 61, 4, 14, 1, 7, 1, 1300, 1300, '0', '0', NULL, NULL),
(1089, 1, '12506011', '3235', NULL, NULL, 'MAYO 2021', 'HON-3194', 61, 4, 14, 1, 12, 1, 250, 250, '0', '0', NULL, NULL),
(1090, 2, '12506011', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 61, 4, 14, 1, 12, 1, 250, 250, '0', '0', NULL, NULL),
(1091, 4, '12507001', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 61, 2, 1, 1, 7, 1, 600, 600, '0', '0', NULL, NULL),
(1092, 4, '10104224', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 3, 35, 2, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(1093, 4, '10104200', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 2, 6, 2, 7, 1, 10900, 10900, '0', '0', NULL, NULL),
(1094, 4, '10104205', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 19, 101, 2, 7, 1, 600, 600, '0', '0', NULL, NULL),
(1095, 4, '10104207', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 15, 9, 37, 2, 7, 1, 2000, 2000, '0', '0', NULL, NULL),
(1096, 4, '10104181', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 6, 9, 2, 7, 1, 400, 400, '0', '0', NULL, NULL),
(1097, 4, '10104201', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 3, 3, 2, 7, 1, 1400, 1400, '0', '0', NULL, NULL),
(1098, 4, '10104202', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 16, 21, 2, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(1099, 4, '10104207', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 15, 9, 37, 2, 7, 1, 200, 200, '0', '0', NULL, NULL),
(1100, 4, '00303050', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 25, 77, 2, 4, 8, 1250, 1250, '0', '0', NULL, NULL),
(1101, 4, '10104199', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 2, 5, 2, 7, 1, 3600, 3600, '0', '0', NULL, NULL),
(1102, 4, '00303063', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 2, 5, 2, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(1103, 4, '10104228', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 15, 5, 38, 2, 7, 1, 1500, 1500, '0', '0', NULL, NULL),
(1104, 2, '47801409', '3235', NULL, NULL, 'MAYO 2021', 'HON-1495', 664, 1, 1, 2, 10, 1, 12000, 12000, '0', '0', NULL, NULL),
(1105, 4, '10104211', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 14, 3, 3, 3, 7, 1, 100, 100, '0', '0', NULL, NULL),
(1106, 4, '10104232', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 14, 33, 78, 3, 7, 1, 200, 200, '0', '0', NULL, NULL),
(1107, 4, '00302001', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 2, 1, 6, 7, 1, 34000, 34000, '0', '0', NULL, NULL),
(1108, 4, '00303065', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 2, 1, 6, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(1109, 4, '00302002', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 19, 25, 6, 7, 1, 5300, 5300, '0', '0', NULL, NULL),
(1110, 4, '00302004', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 37, 61, 6, 3, 1, 4200, 4200, '0', '0', NULL, NULL),
(1111, 4, '00302000', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 27, 30, 6, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(1112, 4, '00302007', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 3, 2, 6, 7, 1, 6000, 6000, '0', '0', NULL, NULL),
(1113, 4, '00302005', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 16, 14, 6, 7, 1, 400, 400, '0', '0', NULL, NULL),
(1114, 4, '00302009', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 9, 11, 6, 7, 1, 4000, 4000, '0', '0', NULL, NULL),
(1115, 4, '00302006', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1245', 86, 5, 4, 6, 7, 1, 600, 600, '0', '0', NULL, NULL),
(1116, 4, '00303052', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 25, 35, 6, 4, 5, 1750, 1750, '0', '0', NULL, NULL),
(1117, 4, '00302008', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 86, 6, 8, 6, 7, 1, 2600, 2600, '0', '0', NULL, NULL),
(1118, 2, '10104112', '3235', NULL, NULL, 'MAYO 2021', 'HON-3189', 86, 6, 19, 6, 7, 1, 1000, 1000, '0', '0', NULL, NULL),
(1119, 1, '10104750', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 101, 2, 5, 4, 7, 1, 2400, 2400, '0', '0', NULL, NULL),
(1120, 4, '10104750', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 101, 2, 5, 4, 7, 1, 7800, 7800, '0', '0', NULL, NULL),
(1121, 4, '10104774', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 101, 2, 5, 4, 10, 1, 5000, 5000, '0', '0', NULL, NULL),
(1122, 2, '10104778', '3235', NULL, NULL, 'MAYO 2021', 'HON-3182', 101, 2, 5, 4, 11, 1, 750, 750, '0', '0', NULL, NULL),
(1123, 4, '10104751', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 101, 3, 35, 4, 7, 1, 3500, 3500, '0', '0', NULL, NULL),
(1124, 1, '10104752', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 101, 16, 36, 4, 7, 1, 1200, 1200, '0', '0', NULL, NULL),
(1125, 4, '10104751', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 101, 3, 35, 4, 7, 1, 200, 200, '0', '0', NULL, NULL),
(1126, 4, '10104762', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 101, 16, 36, 4, 7, 1, 400, 400, '0', '0', NULL, NULL),
(1127, 1, '10104754', '3235', NULL, NULL, 'MAYO 2021', 'HON-3196', 101, 9, 37, 4, 7, 1, 800, 800, '0', '0', NULL, NULL),
(1128, 4, '10104754', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1244-W', 101, 9, 37, 4, 7, 1, 2700, 2700, '0', '0', NULL, NULL),
(1129, 4, '10104754', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1246', 101, 9, 37, 4, 7, 1, 200, 200, '0', '0', NULL, NULL),
(1130, 4, '10104753', '3235', NULL, NULL, 'MAYO 2021', 'INT-H-1245', 101, 5, 38, 4, 7, 1, 600, 600, '0', '0', NULL, NULL),
(1131, 2, '10104772', '3235', NULL, NULL, 'MAYO 2021', 'HON-3198', 101, 5, 38, 4, 12, 1, 125, 125, '0', '0', NULL, NULL),
(1132, 1, '00303097', '3235', NULL, NULL, 'MAYO 2021', 'HON-3190', 101, 35, 56, 4, 9, 1, 5000, 5000, '0', '0', NULL, NULL),
(1133, 2, '47801405', '3235', NULL, NULL, 'MAYO 2021', 'FTT-1495', 153, 4, 2, 4, 10, 1, 3000, 3000, '0', '0', NULL, NULL),
(1575, 1, '9900004022', '3162', NULL, 'Puros Tripa Larga', '2020-07-01', 'HON-2921', 53, 2, 1, 1, 10, 1, 2400, 2400, '120', '20', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pendiente_empaque`
--

DROP TABLE IF EXISTS `pendiente_empaque`;
CREATE TABLE IF NOT EXISTS `pendiente_empaque` (
  `id_pendiente` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` int(11) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `orden_del_sitema` varchar(50) DEFAULT NULL,
  `observacion` varchar(50) DEFAULT NULL,
  `presentacion` varchar(50) DEFAULT NULL,
  `mes` varchar(50) DEFAULT NULL,
  `orden` varchar(50) DEFAULT NULL,
  `marca` int(11) DEFAULT NULL,
  `vitola` int(11) DEFAULT NULL,
  `nombre` int(11) DEFAULT NULL,
  `capa` int(11) DEFAULT NULL,
  `tipo_empaque` int(11) DEFAULT NULL,
  `cello` int(11) DEFAULT NULL,
  `pendiente` int(11) DEFAULT NULL,
  `saldo` int(11) DEFAULT NULL,
  `paquetes` varchar(50) DEFAULT NULL,
  `unidades` varchar(50) DEFAULT NULL,
  `id_pendiente_pedido` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pendiente`)
) ENGINE=MyISAM AUTO_INCREMENT=2723 DEFAULT CHARSET=latin1 COMMENT='CATEGORIA	ITEM	ORDEN DEL SISTEMA	OBSERVACÓN	PRESENTACIÓN	MES	ORDEN	MARCA	VITOLA	NOMBRE	CAPA	TIPO DE EMPAQUE	ANILLO	CELLO	UPC	PENDIENTE	MARZO 2021 FACTURA #17976(Warehouse)	ENVIADO MES	SALDO';

--
-- Volcado de datos para la tabla `pendiente_empaque`
--

INSERT INTO `pendiente_empaque` (`id_pendiente`, `categoria`, `item`, `orden_del_sitema`, `observacion`, `presentacion`, `mes`, `orden`, `marca`, `vitola`, `nombre`, `capa`, `tipo_empaque`, `cello`, `pendiente`, `saldo`, `paquetes`, `unidades`, `id_pendiente_pedido`) VALUES
(1807, 1, '12403005', '3222', '', '', 'ABRIL 2021', 'HON-3154', 66, 3, 14, 6, 7, 1, 100, 100, '0', '0', NULL),
(1806, 1, '1240300101', '3222', '', '', 'ABRIL 2021', 'HON-3154', 66, 3, 2, 6, 10, 1, 300, 300, '0', '0', NULL),
(1805, 1, '12403004', '3222', '', '', 'ABRIL 2021', 'HON-3154', 66, 3, 2, 6, 7, 1, 300, 300, '0', '0', NULL),
(1804, 1, '12403003', '3222', '', '', 'ABRIL 2021', 'HON-3154', 66, 2, 1, 6, 7, 1, 200, 200, '0', '0', NULL),
(1803, 1, '20005007', '3222', '', '', 'ABRIL 2021', 'HON-3167', 90, 9, 26, 3, 7, 1, 2400, 0, '0', '0', NULL),
(1802, 1, '20005005', '3222', '', '', 'ABRIL 2021', 'HON-3167', 90, 34, 52, 3, 7, 1, 400, 0, '0', '0', NULL),
(1801, 1, '20005001', '3222', '', '', 'ABRIL 2021', 'HON-3167', 90, 3, 3, 3, 7, 3, 10800, 6320, '0', '0', NULL),
(1800, 1, '01004013', '3222', '', '', 'ABRIL 2021', 'HON-3156', 90, 3, 21, 3, 12, 1, 12500, 12500, '0', '0', NULL),
(1799, 1, '20005002', '3222', '', '', 'ABRIL 2021', 'HON-3167', 90, 3, 21, 3, 7, 3, 5200, 0, '0', '0', NULL),
(1798, 1, '10104940', '3222', '', '', 'ABRIL 2021', 'HON-3179', 101, 2, 5, 4, 9, 1, 6000, 3000, '0', '0', NULL),
(1794, 1, '10104940', '3222', '', '', 'ABRIL 2021', 'HON-3179', 67, 2, 1, 3, 9, 1, 6000, 3000, '0', '0', NULL),
(1793, 1, '10104940', '3222', '', '', 'ABRIL 2021', 'HON-3179', 51, 2, 1, 3, 9, 1, 6000, 3000, '0', '0', NULL),
(1792, 1, '10104940', '3222', '', '', 'ABRIL 2021', 'HON-3179', 51, 2, 1, 2, 9, 1, 6000, 3000, '0', '0', NULL),
(1791, 1, '10104940', '3222', '', '', 'ABRIL 2021', 'HON-3179', 61, 2, 1, 1, 9, 1, 6000, 3000, '0', '0', NULL),
(1790, 1, '10104940', '3222', '', '', 'ABRIL 2021', 'HON-3179', 99, 2, 1, 6, 9, 1, 6000, 3000, '0', '0', NULL),
(1789, 1, '10104940', '3222', '', '', 'ABRIL 2021', 'HON-3179', 90, 1, 6, 3, 9, 1, 6000, 3000, '0', '0', NULL),
(1788, 1, '20005000', '3222', '', '', 'ABRIL 2021', 'HON-3167', 90, 1, 6, 3, 7, 3, 11600, 11600, '0', '0', NULL),
(1787, 1, '15003000', '3222', '', '', 'ABRIL 2021', 'HON-3173', 184, 24, 6, 2, 7, 1, 10000, 10000, '0', '0', NULL),
(1786, 1, '00407000', '3222', '', '', 'ABRIL 2021', 'FTT-1492', 158, 15, 46, 9, 15, 1, 1000, 1000, '0', '0', NULL),
(1785, 1, '00231000', '3222', '', '', 'ABRIL 2021', 'FTT-1492', 62, 15, 18, 3, 15, 1, 2000, 2000, '0', '0', NULL),
(1784, 1, '00408000', '3222', '', '', 'ABRIL 2021', 'HON-3167', 67, 9, 40, 3, 7, 3, 800, 0, '0', '0', NULL),
(1783, 1, '00404005', '3222', '', '', 'ABRIL 2021', 'HON-3156', 67, 3, 2, 3, 12, 1, 12500, 12500, '0', '0', NULL),
(1782, 1, '00404000', '3222', '', '', 'ABRIL 2021', 'HON-3167', 67, 3, 2, 3, 7, 3, 3600, 1600, '0', '0', NULL),
(1781, 1, '00403000', '3222', '', '', 'ABRIL 2021', 'HON-3167', 67, 2, 1, 3, 7, 3, 2400, 0, '0', '0', NULL),
(1780, 1, '00401000', '3222', '', '', 'ABRIL 2021', 'HON-3167', 67, 19, 25, 3, 7, 3, 800, 800, '0', '0', NULL),
(1779, 1, '00504043', '3222', '', '', 'ABRIL 2021', 'HON-3162', 99, 9, 11, 6, 11, 1, 500, 500, '0', '0', NULL),
(1778, 1, '00508002', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 9, 11, 6, 7, 1, 1200, 1200, '0', '0', NULL),
(1776, 1, '00704001', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 4, 2, 6, 21, 3, 6000, 6000, '0', '0', NULL),
(1775, 1, '00704003', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 4, 2, 6, 7, 1, 4800, 4800, '0', '0', NULL),
(1774, 1, '00712004', '3222', '', '', 'ABRIL 2021', 'HON-3147', 99, 22, 34, 6, 12, 1, 5000, 5000, '0', '0', NULL),
(1773, 1, '00712001', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 22, 34, 6, 21, 3, 3000, 3000, '0', '0', NULL),
(1772, 1, '00712003', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 22, 34, 6, 7, 1, 400, 400, '0', '0', NULL),
(1771, 1, '00703001', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 2, 1, 6, 21, 3, 2000, 0, '0', '0', NULL),
(1770, 1, '00703003', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 2, 1, 6, 7, 1, 1600, 0, '0', '0', NULL),
(1769, 1, '10515004', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 2, 1, 6, 4, 2, 600, 0, '0', '0', NULL),
(1768, 1, '00505019', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 14, 3, 18, 1, 2000, 2000, '0', '0', NULL),
(1767, 1, '00504037', '3222', '', '', 'ABRIL 2021', 'HON-3147', 51, 4, 2, 3, 12, 1, 8750, 0, '0', '0', NULL),
(1766, 1, '00504032', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 2, 3, 7, 1, 3200, 0, '0', '0', NULL),
(1765, 1, '00504024', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 2, 3, 18, 1, 26000, 26000, '0', '0', NULL),
(1764, 1, '005040103', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 22, 34, 2, 7, 1, 800, 800, '0', '0', NULL),
(1763, 1, '00504102', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 22, 34, 5, 7, 1, 400, 400, '0', '0', NULL),
(1762, 1, '00508001', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 9, 32, 2, 7, 3, 5200, 0, '0', '0', NULL),
(1761, 1, '00508000', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 9, 32, 5, 7, 3, 4800, 0, '0', '0', NULL),
(1760, 1, '00605003', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 14, 17, 2, 13, 3, 1000, 1000, '0', '0', NULL),
(1759, 1, '00605002', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 14, 17, 5, 13, 3, 500, 500, '0', '0', NULL),
(1758, 1, '00504101', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 2, 1, 2, 7, 1, 4000, 0, '0', '0', NULL),
(1757, 1, '10104912', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 2, 1, 5, 23, 1, 34100, 34100, '0', '0', NULL),
(1756, 1, '00504100', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 2, 1, 5, 7, 1, 3600, 0, '0', '0', NULL),
(1755, 1, '10515002', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 2, 1, 5, 4, 2, 400, 0, '0', '0', NULL),
(1754, 1, '00505003', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 14, 2, 7, 3, 2000, 0, '0', '0', NULL),
(1753, 1, '00505007', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 14, 2, 18, 3, 2000, 0, '0', '0', NULL),
(1752, 1, '00505008', '3222', '', '', 'ABRIL 2021', 'HON-3147', 51, 4, 14, 5, 12, 1, 12500, 0, '0', '0', NULL),
(1751, 1, '00505006', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 14, 5, 18, 3, 6000, 0, '0', '0', NULL),
(1750, 1, '00904038', '3222', '', '', 'ABRIL 2021', 'HON-3167', 96, 4, 2, 3, 14, 1, 6000, 6000, '0', '0', NULL),
(1749, 1, '00904038', '3222', '', '', 'ABRIL 2021', 'HON-3167', 114, 4, 2, 1, 14, 1, 6000, 6000, '0', '0', NULL),
(1748, 1, '00904038', '3222', '', '', 'ABRIL 2021', 'HON-3167', 96, 4, 2, 5, 14, 1, 6000, 6000, '0', '0', NULL),
(1747, 1, '00904038', '3222', '', '', 'ABRIL 2021', 'HON-3167', 96, 4, 2, 2, 14, 1, 6000, 6000, '0', '0', NULL),
(1746, 1, '00504010', '3222', '', '', 'ABRIL 2021', 'HON-3147', 51, 4, 2, 2, 12, 1, 17500, 0, '0', '0', NULL),
(1745, 1, '00504003', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 2, 2, 7, 3, 6000, 0, '0', '0', NULL),
(1744, 1, '00504007', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 2, 2, 18, 3, 38000, 38000, '0', '0', NULL),
(1743, 1, '00504009', '3222', '', '', 'ABRIL 2021', 'HON-3147', 51, 4, 2, 5, 12, 1, 17500, 0, '0', '0', NULL),
(1742, 1, '00504002', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 2, 5, 7, 3, 11600, 0, '0', '0', NULL),
(1741, 1, '00504006', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 2, 5, 18, 3, 38000, 0, '0', '0', NULL),
(1740, 1, '00107000', '3222', '', '', 'ABRIL 2021', 'FTT-1492', 141, 15, 53, 9, 15, 1, 4000, 4000, '0', '0', NULL),
(1739, 1, '00705001', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 4, 14, 6, 21, 3, 3000, 0, '0', '0', NULL),
(1738, 1, '00705003', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 4, 14, 6, 7, 1, 400, 0, '0', '0', NULL),
(1737, 2, '47801429', '3222', '', '', 'ABRIL 2021', 'HON-3170', 116, 22, 34, 2, 10, 1, 2000, 2000, '0', '0', NULL),
(1736, 2, '01606865', '3222', '', '', 'ABRIL 2021', 'HON-3174', 56, 9, 11, 6, 7, 1, 10000, 1500, '0', '0', NULL),
(1735, 2, '13705668', '3222', '', '', 'ABRIL 2021', 'HON-3153', 947, 9, 39, 2, 7, 1, 1000, 1000, '0', '0', NULL),
(1734, 2, '13705666', '3222', '', '', 'ABRIL 2021', 'HON-3153', 947, 9, 39, 6, 7, 1, 1400, 1400, '0', '0', NULL),
(1733, 2, '13705667', '3222', '', '', 'ABRIL 2021', 'HON-3153', 947, 9, 39, 5, 7, 1, 1000, 1000, '0', '0', NULL),
(1732, 2, '13705660', '3222', '', '', 'ABRIL 2021', 'HON-3153', 947, 4, 2, 6, 7, 1, 4000, 4000, '0', '0', NULL),
(1731, 2, '13705662', '3222', '', '', 'ABRIL 2021', 'HON-3153', 947, 4, 2, 2, 7, 1, 1000, 1000, '0', '0', NULL),
(1730, 2, '13705661', '3222', '', '', 'ABRIL 2021', 'HON-3153', 947, 4, 2, 5, 7, 1, 3000, 3000, '0', '0', NULL),
(1729, 2, '01104509', '3222', '', '', 'ABRIL 2021', 'HON-3159', 151, 4, 2, 15, 11, 1, 200, 0, '0', '0', NULL),
(1728, 2, '01104500', '3222', '', '', 'ABRIL 2021', 'HON-3164', 151, 4, 2, 15, 7, 1, 600, 0, '0', '0', NULL),
(1727, 2, '603006603', '3222', '', '', 'ABRIL 2021', 'HON-3174', 56, 9, 11, 3, 7, 1, 10000, 0, '0', '0', NULL),
(1726, 2, '603006601', '3222', '', '', 'ABRIL 2021', 'FTT-1494', 56, 4, 2, 3, 7, 1, 10000, 10000, '0', '0', NULL),
(1725, 2, '47801560', '3222', '', '', 'ABRIL 2021', 'FTT-1494', 166, 1, 1, 1, 10, 1, 20000, 20000, '0', '0', NULL),
(1724, 2, '47801563', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 166, 4, 2, 2, 10, 1, 7000, 7000, '0', '0', NULL),
(1723, 2, '47801562', '3222', '', '', 'ABRIL 2021', 'FTT-1494', 166, 1, 1, 2, 10, 1, 20000, 20000, '0', '0', NULL),
(1722, 2, '00804066', '3222', '', '', 'ABRIL 2021', 'HON-3166', 209, 3, 3, 2, 7, 1, 400, 0, '0', '0', NULL),
(1721, 2, '47801556', '3222', '', '', 'ABRIL 2021', 'FTT-1490', 189, 1, 1, 1, 10, 1, 3000, 3000, '0', '0', NULL),
(1720, 2, '47801433', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 116, 4, 2, 15, 10, 1, 2000, 2000, '0', '0', NULL),
(1719, 2, '47801435', '3222', '', '', 'ABRIL 2021', 'FTT-1490', 116, 4, 2, 6, 10, 1, 400, 400, '0', '0', NULL),
(1718, 2, '47801481', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 150, 2, 1, 6, 10, 4, 2000, 2000, '0', '0', NULL),
(1717, 2, '47801480', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 150, 3, 2, 6, 10, 4, 4000, 4000, '0', '0', NULL),
(1716, 2, '08503511', '3222', '', '', 'ABRIL 2021', 'FTT-1480', 112, 4, 2, 3, 10, 1, 16000, 16000, '0', '0', NULL),
(1715, 2, '11803022', '3222', '', '', 'ABRIL 2021', 'FTT-1480', 149, 5, 4, 6, 10, 1, 10000, 10000, '0', '0', NULL),
(1714, 2, '11803031', '3222', '', '', 'ABRIL 2021', 'FTT-1480', 146, 4, 2, 3, 10, 1, 20000, 20000, '0', '0', NULL),
(1713, 2, '11803025', '3222', '', '', 'ABRIL 2021', 'FTT-1480', 50, 4, 2, 5, 10, 1, 20000, 20000, '0', '0', NULL),
(1712, 2, '47801211', '3222', '', '', 'ABRIL 2021', 'FTT-1489', 152, 4, 2, 8, 11, 1, 2500, 2500, '0', '0', NULL),
(1711, 2, '603006600', '3222', '', '', 'ABRIL 2021', 'FTT-1494', 56, 2, 1, 3, 7, 1, 10000, 10000, '0', '0', NULL),
(1710, 2, '08503503', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 780, 4, 2, 2, 10, 1, 20000, 20000, '0', '0', NULL),
(1709, 2, '08503501', '3222', '', '', 'ABRIL 2021', 'FTT-1490', 165, 4, 2, 5, 10, 1, 5000, 5000, '0', '0', NULL),
(1708, 2, '08503500', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 779, 4, 2, 6, 10, 1, 12000, 12000, '0', '0', NULL),
(1707, 2, '01606872', '3222', '', '', 'ABRIL 2021', 'FTT-1483', 56, 4, 2, 6, 11, 1, 4250, 4250, '0', '0', NULL),
(1706, 2, '01606867', '3222', '', '', 'ABRIL 2021', 'FTT-1494', 56, 4, 2, 6, 7, 1, 10000, 10000, '0', '0', NULL),
(1705, 2, '01606866', '3222', '', '', 'ABRIL 2021', 'FTT-1494', 56, 2, 1, 6, 7, 1, 10000, 10000, '0', '0', NULL),
(1704, 2, '47801500', '3222', '', '', 'ABRIL 2021', 'FTT-1490', 220, 36, 2, 13, 10, 1, 1200, 1200, '0', '0', NULL),
(1703, 2, '47801500', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 220, 36, 2, 13, 10, 1, 4000, 4000, '0', '0', NULL),
(1702, 2, '47801415', '3222', '', '', 'ABRIL 2021', 'FTT-1486', 665, 4, 2, 6, 10, 1, 8000, 8000, '0', '0', NULL),
(1701, 2, '47801415', '3222', '', '', 'ABRIL 2021', 'FTT-1490', 665, 4, 2, 6, 10, 1, 6000, 6000, '0', '0', NULL),
(1700, 2, '47801415', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 665, 4, 2, 6, 10, 1, 2600, 2600, '0', '0', NULL),
(1699, 2, '47801416', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 665, 1, 1, 6, 10, 1, 28000, 28000, '0', '0', NULL),
(1698, 2, '47801408', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 664, 4, 2, 2, 10, 1, 24000, 24000, '0', '0', NULL),
(1697, 2, '47801409', '3222', '', '', 'ABRIL 2021', 'FTT-1490', 664, 1, 1, 2, 10, 1, 16000, 16000, '0', '0', NULL),
(1696, 2, '47801409', '3222', '', '', 'ABRIL 2021', 'FTT-1486', 664, 1, 1, 2, 10, 1, 10000, 10000, '0', '0', NULL),
(1695, 2, '47801409', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 664, 1, 1, 2, 10, 1, 14000, 14000, '0', '0', NULL),
(1694, 2, '47801405', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 153, 4, 2, 4, 10, 1, 5000, 5000, '0', '0', NULL),
(1692, 2, '47801401', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 644, 1, 1, 3, 10, 1, 8000, 8000, '0', '0', NULL),
(1691, 2, '47801400', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 644, 4, 2, 3, 10, 1, 10000, 10000, '0', '0', NULL),
(1690, 2, '603004050', '3222', '', '', 'ABRIL 2021', 'HON-3161', 88, 4, 3, 2, 11, 1, 3000, 3000, '0', '0', NULL),
(1689, 2, '47801032', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 103, 4, 2, 1, 10, 1, 35200, 35200, '0', '0', NULL),
(1688, 2, '603004031', '3222', '', '', 'ABRIL 2021', 'HON-3166', 88, 4, 3, 1, 11, 1, 1000, 1000, '0', '0', NULL),
(1687, 2, '603004031', '3222', '', '', 'ABRIL 2021', 'HON-3161', 88, 4, 3, 1, 11, 1, 1000, 1000, '0', '0', NULL),
(1686, 2, '47801041', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 103, 4, 2, 2, 10, 1, 20000, 20000, '0', '0', NULL),
(1685, 2, '47801030', '3222', '', '', 'ABRIL 2021', 'FTT-1493', 103, 4, 2, 5, 10, 1, 67000, 67000, '0', '0', NULL),
(1684, 2, '10499010', '3222', '', '', 'ABRIL 2021', 'FTT-1484', 103, 4, 2, 5, 25, 1, 14000, 14000, '0', '0', NULL),
(1683, 2, '10499010', '3222', '', '', 'ABRIL 2021', 'FTT-1484', 103, 4, 2, 2, 25, 1, 14000, 14000, '0', '0', NULL),
(1681, 2, '10499010', '3222', '', '', 'ABRIL 2021', 'FTT-1484', 176, 4, 2, 6, 25, 1, 16000, 16000, '0', '0', NULL),
(1680, 2, '15205521', '3222', '', '', 'ABRIL 2021', 'HON-3148', 104, 4, 2, 12, 11, 1, 7500, 7500, '0', '0', NULL),
(1679, 2, '12506015', '3222', '', '', 'ABRIL 2021', 'HON-3169', 61, 4, 14, 1, 11, 1, 1000, 0, '0', '0', NULL),
(1678, 2, '10104778', '3222', '', '', 'ABRIL 2021', 'HON-3166', 101, 2, 5, 4, 11, 1, 400, 400, '0', '0', NULL),
(1677, 2, '10104778', '3222', '', '', 'ABRIL 2021', 'HON-3161', 101, 2, 5, 4, 11, 1, 750, 750, '0', '0', NULL),
(1676, 2, '14399010', '3222', '', '', 'ABRIL 2021', 'HON-3159', 147, 9, 11, 3, 11, 1, 1400, 1400, '0', '0', NULL),
(1675, 2, '14399010', '3222', '', '', 'ABRIL 2021', 'HON-3164', 147, 9, 11, 3, 11, 1, 500, 500, '0', '0', NULL),
(1674, 2, '14399008', '3222', '', '', 'ABRIL 2021', 'HON-3159', 147, 5, 51, 3, 11, 1, 750, 0, '0', '0', NULL),
(1673, 2, '14399008', '3222', '', '', 'ABRIL 2021', 'HON-3164', 147, 5, 51, 3, 11, 1, 600, 0, '0', '0', NULL),
(1672, 2, '14399002', '3222', '', '', 'ABRIL 2021', 'HON-3159', 147, 5, 51, 3, 7, 1, 1200, 0, '0', '0', NULL),
(1671, 2, '14399002', '3222', '', '', 'ABRIL 2021', 'HON-3164', 147, 5, 51, 3, 7, 1, 1600, 0, '0', '0', NULL),
(1670, 2, '14399006', '3222', '', '', 'ABRIL 2021', 'HON-3159', 147, 3, 3, 3, 11, 1, 1500, 1500, '0', '0', NULL),
(1669, 2, '15406022', '3222', '', '', 'ABRIL 2021', 'HON-3159', 191, 4, 2, 4, 11, 1, 250, 250, '0', '0', NULL),
(1668, 2, '15406022', '3222', '', '', 'ABRIL 2021', 'HON-3164', 191, 4, 2, 4, 11, 1, 200, 200, '0', '0', NULL),
(1667, 2, '15406023', '3222', '', '', 'ABRIL 2021', 'HON-3164', 167, 4, 2, 2, 11, 1, 400, 400, '0', '0', NULL),
(1666, 2, '20005016', '3222', '', '', 'ABRIL 2021', 'HON-3159', 90, 1, 6, 3, 11, 1, 12500, 12500, '0', '0', NULL),
(1665, 2, '20005016', '3222', '', '', 'ABRIL 2021', 'HON-3164', 90, 1, 6, 3, 11, 1, 20000, 20000, '0', '0', NULL),
(1661, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3164', 211, 1, 1, 6, 9, 1, 100, 100, '0', '0', NULL),
(1660, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3164', 167, 17, 1, 2, 9, 1, 100, 100, '0', '0', NULL),
(1659, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3164', 191, 17, 1, 4, 9, 1, 100, 100, '0', '0', NULL),
(1658, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3164', 51, 2, 1, 5, 9, 1, 100, 100, '0', '0', NULL),
(1657, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3164', 88, 17, 23, 1, 9, 1, 100, 100, '0', '0', NULL),
(1656, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3164', 113, 1, 1, 1, 9, 1, 100, 100, '0', '0', NULL),
(1655, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3164', 90, 1, 6, 3, 9, 1, 100, 100, '0', '0', NULL),
(1651, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3161', 211, 1, 1, 6, 9, 1, 3000, 3000, '0', '0', NULL),
(1650, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3161', 167, 17, 1, 2, 9, 1, 3000, 3000, '0', '0', NULL),
(1649, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3161', 191, 17, 1, 4, 9, 1, 3000, 3000, '0', '0', NULL),
(1648, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3161', 51, 2, 1, 5, 9, 1, 3000, 3000, '0', '0', NULL),
(1647, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3161', 88, 17, 23, 1, 9, 1, 3000, 3000, '0', '0', NULL),
(1646, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3161', 113, 1, 1, 1, 9, 1, 3000, 0, '0', '0', NULL),
(1645, 2, '19903027', '3222', '', '', 'ABRIL 2021', 'HON-3161', 90, 1, 6, 3, 9, 1, 3000, 0, '0', '0', NULL),
(1644, 2, '00904151', '3222', '', '', 'ABRIL 2021', 'HON-3166', 186, 3, 3, 2, 11, 1, 1500, 1500, '0', '0', NULL),
(1643, 2, '47801004', '3222', '', '', 'ABRIL 2021', 'HON-3164', 168, 5, 4, 6, 7, 1, 2400, 900, '0', '0', NULL),
(1642, 2, '47705002', '3222', '', '', 'ABRIL 2021', 'HON-3164', 168, 3, 14, 6, 11, 1, 2000, 0, '0', '0', NULL),
(1641, 2, '47801002', '3222', '', '', 'ABRIL 2021', 'HON-3164', 168, 3, 14, 6, 7, 1, 1000, 0, '0', '0', NULL),
(1640, 2, '47801001', '3222', '', '', 'ABRIL 2021', 'HON-3164', 168, 4, 2, 6, 7, 1, 2500, 1000, '0', '0', NULL),
(1639, 2, '47801000', '3222', '', '', 'ABRIL 2021', 'HON-3164', 168, 2, 1, 6, 7, 1, 3000, 0, '0', '0', NULL),
(1638, 2, '01103010', '3222', '', '', 'ABRIL 2021', 'HON-3159', 59, 38, 68, 2, 11, 1, 1100, 1100, '0', '0', NULL),
(1637, 2, '01104000', '3222', '', '', 'ABRIL 2021', 'HON-3159', 59, 4, 3, 2, 13, 3, 2000, 2000, '0', '0', NULL),
(1636, 2, '01104000', '3222', '', '', 'ABRIL 2021', 'HON-3164', 59, 4, 3, 2, 13, 3, 750, 750, '0', '0', NULL),
(1635, 2, '41112001', '3222', '', '', 'ABRIL 2021', 'HON-3159', 59, 22, 74, 1, 11, 1, 300, 300, '0', '0', NULL),
(1634, 2, '41112001', '3222', '', '', 'ABRIL 2021', 'HON-3164', 59, 22, 74, 1, 11, 1, 200, 200, '0', '0', NULL),
(1633, 2, '01103004', '3222', '', '', 'ABRIL 2021', 'HON-3164', 59, 1, 6, 18, 11, 1, 150, 0, '0', '0', NULL),
(1632, 2, '11199000', '3222', '', '', 'ABRIL 2021', 'HON-3164', NULL, 24, 14, 1, 10, 1, 250, 250, '0', '0', NULL),
(1631, 2, '11199000', '3222', '', '', 'ABRIL 2021', 'HON-3164', NULL, 43, 73, 18, 10, 1, 250, 250, '0', '0', NULL),
(1630, 2, '11199000', '3222', '', '', 'ABRIL 2021', 'HON-3164', NULL, 4, 3, 2, 10, 1, 250, 250, '0', '0', NULL),
(1629, 2, '11199000', '3222', '', '', 'ABRIL 2021', 'HON-3164', NULL, 1, 6, 18, 10, 1, 250, 250, '0', '0', NULL),
(1628, 2, '01103000', '3222', '', '', 'ABRIL 2021', 'HON-3164', 59, 1, 6, 18, 13, 3, 375, 0, '0', '0', NULL),
(1627, 2, '13403000', '3222', '', '', 'ABRIL 2021', 'HON-3161', 67, 2, 1, 3, 11, 1, 1000, 0, '0', '0', NULL),
(1626, 2, '13403000', '3222', '', '', 'ABRIL 2021', 'HON-3151', 67, 2, 1, 3, 11, 1, 4250, 0, '0', '0', NULL),
(1625, 2, '00504047', '3222', '', '', 'ABRIL 2021', 'HON-3169', 51, 4, 14, 3, 11, 1, 1000, 1000, '0', '0', NULL),
(1624, 2, '00504048', '3222', '', '', 'ABRIL 2021', 'HON-3166', 51, 4, 2, 3, 11, 1, 250, 0, '0', '0', NULL),
(1623, 2, '00504041', '3222', '', '', 'ABRIL 2021', 'HON-3162', 51, 9, 32, 5, 11, 1, 500, 0, '0', '0', NULL),
(1622, 2, '40503002', '3222', '', '', 'ABRIL 2021', 'HON-3174', 51, 18, 24, 2, 7, 1, 10000, 10000, '0', '0', NULL),
(1621, 2, '40503001', '3222', '', '', 'ABRIL 2021', 'HON-3174', 51, 18, 24, 5, 7, 1, 10000, 0, '0', '0', NULL),
(1620, 2, '00504027', '3222', '', '', 'ABRIL 2021', 'HON-3166', 51, 4, 2, 2, 11, 1, 8000, 0, '0', '0', NULL),
(1619, 2, '00504026', '3222', '', '', 'ABRIL 2021', 'HON-3166', 51, 4, 2, 5, 11, 1, 4250, 0, '0', '0', NULL),
(1572, 4, '603004002', '3217', '', '', 'MARZO 2021', 'INT-H-1235', 88, 4, 3, 1, 7, 1, 240, 240, '0', '0', NULL),
(1571, 1, '10603007', '3217', '', '', 'MARZO 2021', 'HON-3137', 145, 36, 57, 6, 10, 1, 1000, 0, '0', '0', NULL),
(1570, 1, '10104150', '3217', '', '', 'MARZO 2021', 'HON-3134', 101, 44, 61, 4, 7, 1, 2000, 2000, '0', '0', NULL),
(1569, 1, '10104754', '3217', '', '', 'MARZO 2021', 'HON-3142', 101, 9, 37, 4, 7, 1, 800, 0, '0', '0', NULL),
(1568, 1, '10104752', '3217', '', '', 'MARZO 2021', 'HON-3142', 101, 16, 36, 4, 7, 1, 800, 0, '0', '0', NULL),
(1567, 1, '10104751', '3217', '', '', 'MARZO 2021', 'HON-3142', 101, 3, 35, 4, 7, 1, 4000, 0, '0', '0', NULL),
(1566, 1, '10104750', '3217', '', '', 'MARZO 2021', 'HON-3142', 101, 2, 5, 4, 7, 1, 2400, 2400, '0', '0', NULL),
(2717, 1, '9900004022', '3162', ' ', 'Puros Tripa Larga', 'JUNIO 2021', 'HON-2921', 53, 2, 1, 1, 10, 1, 2400, 2400, '120', '20', NULL),
(1563, 1, '00508003', '3217', '', '', 'MARZO 2021', 'HON-3142', 61, 9, 11, 1, 7, 1, 1200, 0, '0', '0', NULL),
(1556, 1, '00704001', '3217', '', '', 'MARZO 2021', 'HON-3142', 99, 4, 2, 6, 21, 3, 2000, 0, '0', '0', NULL),
(1555, 1, '00704003', '3217', '', '', 'MARZO 2021', 'HON-3142', 99, 4, 2, 6, 7, 1, 2000, 0, '0', '0', NULL),
(1554, 1, '00712004', '3217', '', '', 'MARZO 2021', 'HON-3135', 99, 22, 34, 6, 12, 1, 1250, 1250, '0', '0', NULL),
(1553, 1, '00712001', '3217', '', '', 'MARZO 2021', 'HON-3142', 99, 22, 34, 6, 21, 3, 1000, 1000, '0', '0', NULL),
(1552, 1, '00712003', '3217', '', '', 'MARZO 2021', 'HON-3142', 99, 22, 34, 6, 7, 1, 400, 400, '0', '0', NULL),
(1548, 1, '00705001', '3217', '', '', 'MARZO 2021', 'HON-3142', 99, 4, 14, 6, 21, 3, 1000, 0, '0', '0', NULL),
(1547, 1, '00705003', '3217', '', '', 'MARZO 2021', 'HON-3142', 99, 4, 14, 6, 7, 1, 1200, 0, '0', '0', NULL),
(1544, 1, '00508011', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 21, 33, 2, 19, 1, 1200, 0, '0', '0', NULL),
(1543, 1, '00508010', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 21, 33, 5, 19, 1, 1800, 0, '0', '0', NULL),
(1542, 1, '10104130', '3217', '', '', 'MARZO 2021', 'HON-3136', 51, 6, 67, 5, 7, 1, 500, 500, '0', '0', NULL),
(1541, 1, '00504150', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 4, 2, 15, 7, 1, 800, 0, '0', '0', NULL),
(1540, 1, '00504033', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 4, 14, 3, 7, 1, 400, 0, '0', '0', NULL),
(1539, 1, '00505019', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 4, 14, 3, 18, 1, 2000, 0, '0', '0', NULL),
(1538, 1, '00504032', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 4, 2, 3, 7, 1, 1600, 0, '0', '0', NULL),
(1537, 1, '005040103', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 22, 34, 2, 7, 1, 800, 800, '0', '0', NULL),
(1536, 1, '00504102', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 22, 34, 5, 7, 1, 400, 400, '0', '0', NULL),
(1534, 1, '00508001', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 9, 32, 2, 7, 3, 7200, 0, '0', '0', NULL),
(1531, 1, '00605003', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 14, 17, 2, 13, 3, 1500, 0, '0', '0', NULL),
(1530, 1, '00605002', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 14, 17, 5, 13, 3, 500, 500, '0', '0', NULL),
(1529, 1, '00504101', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 2, 1, 2, 7, 3, 3600, 0, '0', '0', NULL),
(1528, 1, '10104912', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 2, 1, 5, 23, 1, 14300, 14300, '0', '0', NULL),
(1525, 1, '00505003', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 4, 14, 2, 7, 3, 3200, 0, '0', '0', NULL),
(1524, 1, '00505007', '3217', '', '', 'MARZO 2021', 'HON-3142', 51, 4, 14, 2, 18, 3, 2000, 0, '0', '0', NULL),
(1521, 1, '00904038', '3217', '', '', 'MARZO 2021', 'HON-3142', 235, 4, 2, 3, 14, 1, 6300, 6300, '0', '0', NULL),
(1520, 1, '00904038', '3217', '', '', 'MARZO 2021', 'HON-3142', 236, 4, 2, 1, 14, 1, 6300, 6300, '0', '0', NULL),
(1519, 1, '00904038', '3217', '', '', 'MARZO 2021', 'HON-3142', 235, 4, 2, 5, 14, 1, 6300, 6300, '0', '0', NULL),
(1518, 1, '00904038', '3217', '', '', 'MARZO 2021', 'HON-3142', 235, 4, 2, 2, 14, 1, 6300, 6300, '0', '0', NULL),
(1511, 1, '00405000', '3217', '', '', 'MARZO 2021', 'HON-3142', 67, 16, 14, 3, 7, 3, 400, 0, '0', '0', NULL),
(1509, 1, '00408000', '3217', '', '', 'MARZO 2021', 'HON-3142', 67, 9, 40, 3, 7, 3, 400, 0, '0', '0', NULL),
(1508, 1, '00404000', '3217', '', '', 'MARZO 2021', 'HON-3142', 67, 3, 2, 3, 7, 3, 4400, 0, '0', '0', NULL),
(1507, 1, '00403000', '3217', '', '', 'MARZO 2021', 'HON-3142', 67, 2, 1, 3, 7, 3, 2800, 0, '0', '0', NULL),
(1506, 1, '00401000', '3217', '', '', 'MARZO 2021', 'HON-3142', 67, 19, 25, 3, 7, 3, 1200, 0, '0', '0', NULL),
(1505, 1, '00110277', '3217', '', '', 'MARZO 2021', 'HON-3129', 72, 2, 1, 2, 23, 7, 500, 500, '0', '0', NULL),
(1504, 1, '00110275', '3217', '', '', 'MARZO 2021', 'HON-3129', 72, 2, 1, 5, 23, 7, 500, 500, '0', '0', NULL),
(1503, 1, '00110276', '3217', '', '', 'MARZO 2021', 'HON-3129', 72, 2, 1, 6, 23, 7, 500, 500, '0', '0', NULL),
(1502, 1, '12503005', '3217', '', '', 'MARZO 2021', 'HON-3128', 63, 19, 30, 2, 7, 1, 800, 0, '0', '0', NULL),
(1501, 1, '12503010', '3217', '', '', 'MARZO 2021', 'HON-3128', 63, 1, 1, 1, 7, 1, 800, 0, '0', '0', NULL),
(1500, 1, '12503003', '3217', '', '', 'MARZO 2021', 'HON-3128', 63, 4, 2, 1, 7, 1, 800, 0, '0', '0', NULL),
(1499, 1, '10105005', '3217', '', '', 'MARZO 2021', 'HON-3126', 232, 5, 4, 2, 7, 1, 400, 0, '0', '0', NULL),
(1498, 1, '01606674', '3217', '', '', 'MARZO 2021', 'HON-3142', 40, 3, 2, 5, 7, 1, 5200, 0, '0', '0', NULL),
(1497, 1, '01606675', '3217', '', '', 'MARZO 2021', 'HON-3142', 40, 20, 30, 5, 7, 1, 6400, 0, '0', '0', NULL),
(1496, 1, '01604011', '3217', '', '', 'MARZO 2021', 'HON-3142', 109, 3, 2, 1, 7, 1, 400, 0, '0', '0', NULL),
(1495, 1, '01604012', '3217', '', '', 'MARZO 2021', 'HON-3142', 109, 28, 14, 1, 7, 1, 400, 0, '0', '0', NULL),
(1494, 1, '01604010', '3217', '', '', 'MARZO 2021', 'HON-3142', 109, 24, 41, 1, 7, 1, 400, 0, '0', '0', NULL),
(1493, 1, '00110063', '3217', '', '', 'MARZO 2021', 'HON-3144', 231, 22, 34, 6, 7, 1, 200, 200, '0', '0', NULL),
(1492, 1, '00110062', '3217', '', '', 'MARZO 2021', 'HON-3144', 231, 9, 11, 6, 7, 1, 200, 0, '0', '0', NULL),
(1491, 1, '00110061', '3217', '', '', 'MARZO 2021', 'HON-3144', 231, 4, 2, 6, 7, 1, 200, 0, '0', '0', NULL),
(1490, 1, '00110060', '3217', '', '', 'MARZO 2021', 'HON-3144', 231, 2, 1, 6, 7, 1, 200, 0, '0', '0', NULL),
(1489, 1, '9900004025', '3217', '', '', 'MARZO 2021', 'HON-3124', 230, 9, 16, 1, 7, 1, 1000, 1000, '0', '0', NULL),
(1480, 1, '9900004035', '3217', '', '', 'MARZO 2021', 'HON-3124', 229, 9, 16, 3, 7, 1, 500, 500, '0', '0', NULL),
(1479, 1, '9900004023', '3217', '', '', 'MARZO 2021', 'HON-3146', 53, 3, 2, 1, 10, 1, 1000, 1000, '0', '0', NULL),
(1468, 1, '9900009117', '3217', '', '', 'MARZO 2021', 'HON-3146', 93, 3, 27, 2, 10, 1, 1000, 0, '0', '0', NULL),
(1467, 1, '9900009111', '3217', '', '', 'MARZO 2021', 'HON-3124', 93, 3, 27, 2, 7, 1, 2000, 0, '0', '0', NULL),
(1464, 1, '15004001', '3217', '', '', 'MARZO 2021', 'HON-3127', 184, 5, 51, 2, 7, 1, 2000, 0, '0', '0', NULL),
(1463, 1, '15003000', '3217', '', '', 'MARZO 2021', 'HON-3127', 184, 24, 6, 2, 7, 1, 2000, 0, '0', '0', NULL),
(1462, 1, '00231000', '3217', '', '', 'MARZO 2021', 'FTT-1479', 62, 15, 18, 3, 15, 1, 1000, 1000, '0', '0', NULL),
(1459, 1, '603005752', '3217', '', '', 'MARZO 2021', 'HON-3142', 92, 9, 11, 1, 4, 1, 400, 400, '0', '0', NULL),
(1457, 1, '603005751', '3217', '', '', 'MARZO 2021', 'HON-3142', 92, 4, 2, 1, 4, 1, 1200, 1200, '0', '0', NULL),
(1456, 1, '10105556', '3217', '', '', 'MARZO 2021', 'FTT-1475', 227, 4, 2, 1, 10, 1, 2000, 2000, '0', '0', NULL),
(1455, 1, '10105555', '3217', '', '', 'MARZO 2021', 'FTT-1475', 227, 1, 1, 1, 10, 1, 2000, 2000, '0', '0', NULL),
(1454, 1, '10105561', '3217', '', '', 'MARZO 2021', 'FTT-1475', 227, 4, 2, 6, 10, 1, 2000, 2000, '0', '0', NULL),
(1453, 1, '10105560', '3217', '', '', 'MARZO 2021', 'FTT-1475', 227, 1, 1, 6, 10, 1, 2000, 2000, '0', '0', NULL),
(1452, 1, '10105551', '3217', '', '', 'MARZO 2021', 'FTT-1475', 227, 4, 2, 2, 10, 1, 6000, 6000, '0', '0', NULL),
(1451, 1, '10105550', '3217', '', '', 'MARZO 2021', 'FTT-1475', 227, 1, 1, 2, 10, 1, 6000, 6000, '0', '0', NULL),
(1450, 1, '10105566', '3217', '', '', 'MARZO 2021', 'FTT-1475', 227, 4, 2, 5, 10, 1, 2000, 2000, '0', '0', NULL),
(1449, 1, '10105565', '3217', '', '', 'MARZO 2021', 'FTT-1475', 227, 1, 1, 5, 10, 1, 2000, 2000, '0', '0', NULL),
(1447, 1, '00508022', '3217', '', '', 'MARZO 2021', 'HON-3142', 91, 9, 11, 10, 7, 1, 1200, 1200, '0', '0', NULL),
(1446, 1, '00508020', '3217', '', '', 'MARZO 2021', 'HON-3142', 91, 4, 2, 10, 7, 1, 62800, 23120, '0', '0', NULL),
(1444, 1, '20005007', '3217', '', '', 'MARZO 2021', 'HON-3142', 90, 9, 26, 3, 7, 1, 1200, 0, '0', '0', NULL),
(1443, 1, '20005005', '3217', '', '', 'MARZO 2021', 'HON-3142', 90, 34, 52, 3, 7, 1, 400, 0, '0', '0', NULL),
(1442, 1, '20005001', '3217', '', '', 'MARZO 2021', 'HON-3142', 90, 3, 3, 3, 7, 3, 8000, 0, '0', '0', NULL),
(1441, 1, '20005002', '3217', '', '', 'MARZO 2021', 'HON-3142', 90, 3, 21, 3, 7, 3, 4800, 0, '0', '0', NULL),
(1440, 1, '20005000', '3217', '', '', 'MARZO 2021', 'HON-3142', 90, 1, 6, 3, 7, 3, 4000, 4000, '0', '0', NULL),
(1437, 1, '603004002', '3217', '', '', 'MARZO 2021', 'HON-3142', 88, 4, 3, 1, 7, 1, 1200, 1200, '0', '0', NULL),
(1436, 3, '12003061', '3217', '', '', 'MARZO 2021', 'HON-3131', 105, 9, 11, 1, 12, 1, 2000, 0, '0', '0', NULL),
(1435, 3, '12003062', '3217', '', '', 'MARZO 2021', 'HON-3131', 105, 4, 14, 1, 12, 1, 1000, 0, '0', '0', NULL),
(1434, 3, '12003051', '3217', '', '', 'MARZO 2021', 'HON-3130', 105, 4, 14, 1, 7, 1, 2000, 0, '0', '0', NULL),
(1433, 3, '12003060', '3217', '', '', 'MARZO 2021', 'HON-3131', 105, 4, 2, 1, 12, 1, 6000, 0, '0', '0', NULL),
(1432, 3, '12003050', '3217', '', '', 'MARZO 2021', 'HON-3130', 105, 4, 2, 1, 7, 1, 4000, 0, '0', '0', NULL),
(1431, 3, '10610019', '3217', '', '', 'MARZO 2021', 'HON-3136', 162, 4, 2, 5, 22, 4, 750, 0, '0', '0', NULL),
(1426, 3, '09906037', '3217', '', '', 'MARZO 2021', 'HON-3140', 182, 3, 2, 3, 22, 4, 750, 0, '0', '0', NULL),
(1424, 3, '09906018', '3217', '', '', 'MARZO 2021', 'HON-3140', 181, 22, 34, 6, 20, 4, 480, 480, '0', '0', NULL),
(1423, 3, '09906012', '3217', '', '', 'MARZO 2021', 'HON-3140', 181, 4, 2, 6, 20, 4, 1920, 1920, '0', '0', NULL),
(1421, 3, '13403010', '3217', '', '', 'MARZO 2021', 'HON-3131', 135, 3, 2, 3, 12, 1, 6000, 0, '0', '0', NULL),
(1420, 3, '12303000', '3217', '', '', 'MARZO 2021', 'HON-3130', 135, 2, 1, 3, 7, 1, 2000, 2000, '0', '0', NULL),
(1419, 3, '12301000', '3217', '', '', 'MARZO 2021', 'HON-3130', 135, 19, 25, 3, 7, 1, 2000, 500, '0', '0', NULL),
(1418, 3, '11707003', '3217', '', '', 'MARZO 2021', 'FTT-1474', 138, 15, 48, 6, 17, 1, 19680, 19680, '0', '0', NULL),
(1417, 3, '12104000', '3217', '', '', 'MARZO 2021', 'HON-3130', 134, 3, 3, 5, 7, 1, 2400, 0, '0', '0', NULL),
(1415, 3, '11710055', '3217', '', '', 'MARZO 2021', 'HON-3131', 183, 2, 1, 3, 12, 1, 2000, 2000, '0', '0', NULL),
(1414, 3, '11710050', '3217', '', '', 'MARZO 2021', 'HON-3130', 183, 2, 1, 3, 7, 1, 1000, 1000, '0', '0', NULL),
(1413, 3, '12003007', '3217', '', '', 'MARZO 2021', 'HON-3130', 133, 22, 34, 2, 7, 1, 1000, 1000, '0', '0', NULL),
(1411, 3, '12003005', '3217', '', '', 'MARZO 2021', 'HON-3130', 133, 22, 34, 5, 7, 1, 1000, 1000, '0', '0', NULL),
(1410, 3, '12002998', '3217', '', '', 'MARZO 2021', 'HON-3131', 133, 4, 2, 2, 12, 1, 4000, 0, '0', '0', NULL),
(1409, 3, '12004000', '3217', '', '', 'MARZO 2021', 'HON-3130', 133, 4, 2, 2, 7, 1, 2000, 0, '0', '0', NULL),
(1408, 3, '12002999', '3217', '', '', 'MARZO 2021', 'HON-3131', 133, 4, 2, 5, 12, 1, 6000, 0, '0', '0', NULL),
(1407, 3, '12004001', '3217', '', '', 'MARZO 2021', 'HON-3130', 133, 4, 2, 5, 7, 1, 2000, 0, '0', '0', NULL),
(1402, 3, '11812008', '3217', '', '', 'MARZO 2021', 'HON-3131', 132, 31, 4, 6, 12, 1, 2000, 0, '0', '0', NULL),
(1401, 3, '11812010', '3217', '', '', 'MARZO 2021', 'HON-3131', 132, 4, 2, 6, 12, 1, 5000, 5000, '0', '0', NULL),
(1398, 2, '47801421', '3217', '', '', 'MARZO 2021', 'FTT-1472', 60, 4, 2, 8, 10, 1, 20000, 20000, '0', '0', NULL),
(1396, 2, '10104772', '3217', '', '', 'MARZO 2021', 'HON-3135', 101, 5, 38, 4, 12, 1, 1250, 1250, '0', '0', NULL),
(1394, 2, '10104778', '3217', '', '', 'MARZO 2021', 'HON-3139', 101, 2, 5, 4, 11, 1, 700, 700, '0', '0', NULL),
(1393, 2, '40503014', '3217', '', '', 'MARZO 2021', 'HON-3127', 61, 18, 24, 1, 11, 1, 2500, 0, '0', '0', NULL),
(1392, 2, '40503020', '3217', '', '', 'MARZO 2021', 'HON-3127', 61, 18, 24, 1, 9, 1, 3000, 0, '0', '0', NULL),
(1391, 2, '40503003', '3217', '', '', 'MARZO 2021', 'HON-3127', 61, 18, 24, 1, 7, 1, 10000, 0, '0', '0', NULL),
(1390, 2, '12506011', '3217', '', '', 'MARZO 2021', 'HON-3132', 61, 4, 14, 1, 12, 1, 1000, 0, '0', '0', NULL),
(1385, 2, '40503015', '3217', '', '', 'MARZO 2021', 'HON-3127', 99, 18, 80, 6, 11, 1, 2500, 2500, '0', '0', NULL),
(1384, 2, '40503021', '3217', '', '', 'MARZO 2021', 'HON-3127', 99, 18, 80, 6, 9, 1, 3000, 3000, '0', '0', NULL),
(1383, 2, '40503004', '3217', '', '', 'MARZO 2021', 'HON-3127', 99, 18, 80, 6, 7, 1, 10000, 10000, '0', '0', NULL),
(1382, 2, '00704004', '3217', '', '', 'MARZO 2021', 'HON-3138', 99, 4, 2, 6, 12, 1, 20000, 9000, '0', '0', NULL),
(1381, 2, '40503016', '3217', '', '', 'MARZO 2021', 'HON-3127', 51, 18, 80, 3, 11, 1, 2500, 0, '0', '0', NULL),
(1380, 2, '40503022', '3217', '', '', 'MARZO 2021', 'HON-3127', 51, 18, 80, 3, 9, 1, 3000, 0, '0', '0', NULL),
(1379, 2, '40503005', '3217', '', '', 'MARZO 2021', 'HON-3127', 51, 18, 80, 3, 7, 1, 10000, 0, '0', '0', NULL),
(1374, 2, '20018022', '3217', '', '', 'MARZO 2021', 'HON-3135', 113, 9, 11, 1, 12, 1, 1250, 0, '0', '0', NULL),
(1373, 2, '20018021', '3217', '', '', 'MARZO 2021', 'HON-3135', 113, 3, 2, 1, 12, 1, 1250, 0, '0', '0', NULL),
(1372, 2, '01103010', '3217', '', '', 'MARZO 2021', 'HON-3141', 59, 38, 68, 2, 11, 1, 1000, 1000, '0', '0', NULL),
(1371, 2, '01103006', '3217', '', '', 'MARZO 2021', 'HON-3141', 59, 4, 3, 2, 11, 1, 2500, 2500, '0', '0', NULL),
(1370, 2, '01104000', '3217', '', '', 'MARZO 2021', 'HON-3141', 59, 4, 3, 2, 13, 3, 1750, 1750, '0', '0', NULL),
(1369, 2, '41112001', '3217', '', '', 'MARZO 2021', 'HON-3141', 59, 22, 74, 1, 11, 1, 200, 200, '0', '0', NULL),
(1366, 2, '00404005', '3217', '', '', 'MARZO 2021', 'HON-3138', 67, 3, 2, 3, 12, 1, 5000, 0, '0', '0', NULL),
(1362, 2, '6030066060', '3217', '', '', 'MARZO 2021', 'FTT-1472', 56, 4, 2, 3, 9, 1, 1000, 1000, '0', '0', NULL),
(1355, 2, '14399005', '3217', '', '', 'MARZO 2021', 'HON-3141', 147, 2, 6, 3, 11, 3, 400, 400, '0', '0', NULL),
(1354, 2, '14399006', '3217', '', '', 'MARZO 2021', 'HON-3141', 147, 3, 3, 3, 11, 1, 4000, 0, '0', '0', NULL),
(1353, 2, '00904111', '3217', '', '', 'MARZO 2021', 'HON-3135', 186, 3, 3, 2, 9, 1, 500, 500, '0', '0', NULL),
(1352, 2, '00804065', '3217', '', '', 'MARZO 2021', 'HON-3139', 209, 18, 6, 2, 7, 1, 400, 0, '0', '0', NULL),
(1351, 2, '10499015', '3217', '', '', 'MARZO 2021', 'HON-3141', 754, 3, 2, 19, 11, 1, 500, 500, '0', '0', NULL),
(1350, 2, '10499015', '3217', '', '', 'MARZO 2021', 'HON-3141', 457, 3, 2, 19, 11, 1, 500, 500, '0', '0', NULL),
(1349, 2, '10499015', '3217', '', '', 'MARZO 2021', 'HON-3141', 15, 3, 3, 2, 11, 1, 500, 500, '0', '0', NULL),
(1346, 2, '20005006', '3217', '', '', 'MARZO 2021', 'HON-3138', 90, 3, 3, 3, 11, 1, 25000, 0, '0', '0', NULL),
(1344, 2, '10499060', '3217', '', '', 'MARZO 2021', 'HON-3141', 255, 45, 1, 19, 11, 1, 1000, 1000, '0', '0', NULL),
(1341, 2, '10499060', '3217', '', '', 'MARZO 2021', 'HON-3141', 67, 45, 1, 2, 11, 1, 1000, 1000, '0', '0', NULL),
(1338, 2, '47705002', '3217', '', '', 'MARZO 2021', 'HON-3141', 168, 3, 14, 6, 11, 1, 7500, 0, '0', '0', NULL),
(1337, 2, '47801002', '3217', '', '', 'MARZO 2021', 'HON-3141', 168, 3, 14, 6, 7, 1, 1200, 0, '0', '0', NULL),
(1336, 2, '47801561', '3217', '', '', 'MARZO 2021', 'FTT-1472', 166, 4, 2, 1, 10, 1, 39500, 39500, '0', '0', NULL),
(1335, 2, '47801563', '3217', '', '', 'MARZO 2021', 'FTT-1472', 166, 4, 2, 2, 10, 1, 30000, 30000, '0', '0', NULL),
(1334, 2, '603004050', '3217', '', '', 'MARZO 2021', 'HON-3139', 88, 4, 3, 2, 11, 1, 3000, 3000, '0', '0', NULL),
(1333, 2, '603004031', '3217', '', '', 'MARZO 2021', 'HON-3139', 88, 4, 3, 1, 11, 1, 750, 750, '0', '0', NULL),
(1332, 2, '603004023', '3217', '', '', 'MARZO 2021', 'HON-3138', 88, 4, 3, 1, 12, 1, 5000, 5000, '0', '0', NULL),
(1331, 2, '603004023', '3217', '', '', 'MARZO 2021', 'HON-3135', 88, 4, 3, 1, 12, 1, 1250, 1250, '0', '0', NULL),
(1324, 4, '10104751', '3207', '', '', 'FEBRERO 2021', 'INT-H-1231', 101, 3, 35, 4, 7, 1, 200, 200, '0', '0', NULL),
(1321, 2, '10104778', '3207', '', '', 'FEBRERO 2021', 'HON-3117', 101, 2, 5, 4, 11, 1, 1750, 1750, '0', '0', NULL),
(1315, 1, '10104750', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 101, 2, 5, 4, 7, 1, 400, 400, '0', '0', NULL),
(1297, 1, '12506011', '3207', '', '', 'FEBRERO 2021', 'HON-3107', 61, 4, 14, 1, 12, 1, 6000, 0, '0', '0', NULL),
(1287, 1, '003041635', '3207', '', '', 'FEBRERO 2021', 'HON-3106', 99, 25, 75, 6, 11, 7, 33000, 33000, '0', '0', NULL),
(1278, 1, '00704003', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 99, 4, 2, 6, 7, 1, 10500, 0, '0', '0', NULL),
(1277, 1, '00712004', '3207', '', '', 'FEBRERO 2021', 'HON-3109', 99, 22, 34, 6, 12, 1, 1500, 1500, '0', '0', NULL),
(1276, 1, '00712001', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 99, 22, 34, 6, 21, 3, 5000, 5000, '0', '0', NULL),
(1274, 1, '00712003', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 99, 22, 34, 6, 7, 1, 6000, 5000, '0', '0', NULL),
(1264, 1, '003041633', '3207', '', '', 'FEBRERO 2021', 'HON-3106', 51, 25, 75, 2, 11, 7, 33000, 33000, '0', '0', NULL),
(1263, 1, '003041634', '3207', '', '', 'FEBRERO 2021', 'HON-3106', 51, 25, 75, 5, 11, 7, 33000, 33000, '0', '0', NULL),
(1245, 1, '00504032', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 3, 7, 1, 11600, 0, '0', '0', NULL),
(1243, 1, '00504024', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 3, 18, 1, 68000, 0, '0', '0', NULL),
(1239, 1, '00508001', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 51, 9, 32, 2, 7, 3, 18000, 0, '0', '0', NULL),
(1228, 1, '10104912', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 51, 2, 1, 5, 23, 1, 26900, 26900, '0', '0', NULL),
(1214, 1, '00904038', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 96, 4, 2, 3, 14, 1, 45600, 45600, '0', '0', NULL),
(1213, 1, '00904038', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 114, 4, 2, 1, 14, 1, 45600, 45600, '0', '0', NULL),
(1212, 1, '00904038', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 96, 4, 2, 5, 14, 1, 45600, 45600, '0', '0', NULL),
(1211, 1, '00904038', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 51, 4, 2, 5, 14, 1, 45600, 45600, '0', '0', NULL),
(1210, 1, '00904038', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 96, 4, 2, 3, 14, 1, 1410, 1410, '0', '0', NULL),
(1209, 1, '00904038', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 114, 4, 2, 1, 14, 1, 1410, 1410, '0', '0', NULL),
(1208, 1, '00904038', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 96, 4, 2, 5, 14, 1, 1410, 1410, '0', '0', NULL),
(1207, 1, '00904038', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 96, 4, 2, 2, 14, 1, 1410, 1410, '0', '0', NULL),
(1178, 2, '01103006', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 59, 4, 3, 2, 11, 1, 250, 0, '0', '0', NULL),
(1177, 2, '41112001', '3207', '', '', 'FEBRERO 2021', 'HON-3102', 59, 22, 74, 1, 11, 1, 600, 600, '0', '0', NULL),
(1169, 1, '003041640', '3207', '', '', 'FEBRERO 2021', 'HON-3106', 67, 25, 75, 3, 11, 7, 17000, 9500, '0', '0', NULL),
(1164, 2, '00404009', '3207', '', '', 'FEBRERO 2021', 'HON-3102', 67, 3, 2, 3, 11, 1, 6000, 0, '0', '0', NULL),
(1163, 1, '00404005', '3207', '', '', 'FEBRERO 2021', 'HON-3112', 67, 3, 2, 3, 12, 1, 5000, 0, '0', '0', NULL),
(1160, 1, '00404000', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 67, 3, 2, 3, 7, 3, 7600, 0, '0', '0', NULL),
(1152, 4, '00401000', '3207', '', '', 'FEBRERO 2021', 'INT-H-1225', 67, 19, 25, 3, 7, 3, 100, 100, '0', '0', NULL),
(1147, 1, '12503519', '3207', '', '', 'FEBRERO 2021', 'FTT-1465', 111, 5, 4, 1, 10, 1, 1500, 1500, '0', '0', NULL),
(1146, 1, '12503518', '3207', '', '', 'FEBRERO 2021', 'FTT-1465', 111, 1, 1, 1, 10, 1, 500, 500, '0', '0', NULL),
(1144, 1, '12503512', '3207', '', '', 'FEBRERO 2021', 'FTT-1465', 111, 4, 14, 6, 10, 1, 1500, 1500, '0', '0', NULL),
(1143, 1, '12503511', '3207', '', '', 'FEBRERO 2021', 'FTT-1465', 111, 5, 4, 6, 10, 1, 600, 600, '0', '0', NULL),
(1141, 1, '12503503', '3207', '', '', 'FEBRERO 2021', 'FTT-1465', 111, 9, 39, 3, 10, 1, 3100, 3100, '0', '0', NULL),
(1140, 1, '12503502', '3207', '', '', 'FEBRERO 2021', 'FTT-1465', 111, 4, 14, 3, 10, 1, 4000, 4000, '0', '0', NULL),
(1139, 1, '12503501', '3207', '', '', 'FEBRERO 2021', 'FTT-1465', 111, 5, 4, 3, 10, 1, 6000, 6000, '0', '0', NULL),
(1138, 1, '12503500', '3207', '', '', 'FEBRERO 2021', 'FTT-1465', 111, 1, 1, 3, 10, 1, 6000, 6000, '0', '0', NULL),
(1131, 2, '47801891', '3207', '', '', 'FEBRERO 2021', 'FTT-1467', 57, 3, 14, 1, 9, 1, 2600, 2600, '0', '0', NULL),
(1126, 3, '09906037', '3207', '', '', 'FEBRERO 2021', 'HON-3119', 182, 3, 2, 3, 22, 4, 1500, 1500, '0', '0', NULL),
(1125, 3, '09906037', '3207', '', '', 'FEBRERO 2021', 'HON-3101', 182, 3, 2, 3, 22, 4, 2100, 0, '0', '0', NULL),
(1120, 3, '09906012', '3207', '', '', 'FEBRERO 2021', 'HON-3119', 181, 4, 2, 6, 20, 4, 1200, 0, '0', '0', NULL),
(1106, 2, '14399005', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 147, 2, 6, 3, 11, 1, 1100, 1100, '0', '0', NULL),
(1105, 2, '14399005', '3207', '', '', 'FEBRERO 2021', 'HON-3102', 147, 2, 6, 3, 11, 1, 700, 700, '0', '0', NULL),
(1103, 2, '14399006', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 147, 3, 3, 3, 11, 1, 3750, 0, '0', '0', NULL),
(1102, 2, '14399001', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 147, 3, 3, 3, 7, 1, 1800, 0, '0', '0', NULL),
(1101, 2, '14399001', '3207', '', '', 'FEBRERO 2021', 'HON-3101', 147, 3, 3, 3, 7, 1, 2400, 0, '0', '0', NULL),
(1096, 1, '00903004', '3207', '', '', 'FEBRERO 2021', 'HON-3105', 74, 18, 6, 5, 12, 1, 4350, 4350, '0', '0', NULL),
(1089, 1, '003041630', '3207', '', '', 'FEBRERO 2021', 'HON-3106', 40, 25, 75, 5, 11, 7, 33000, 0, '0', '0', NULL),
(1082, 1, '01604011', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 109, 3, 2, 1, 7, 1, 400, 0, '0', '0', NULL),
(1078, 1, '9900004022', '3207', '', '', 'FEBRERO 2021', 'HON-3125', 53, 26, 42, 1, 10, 1, 5000, 5000, '0', '0', NULL),
(1074, 4, '00107000', '3207', '', '', 'FEBRERO 2021', 'INT-H-1229', 141, 15, 53, 9, 15, 1, 300, 300, '0', '0', NULL),
(1073, 4, '00107000', '3207', '', '', 'FEBRERO 2021', 'INT-H-1225', 141, 15, 53, 9, 15, 1, 50, 50, '0', '0', NULL),
(2276, 1, '20005000', '3207', ' ', ' ', 'FEBRERO 2021', 'HON-3120', 90, 1, 6, 3, 7, 1, 20000, 0, '0', '0', NULL),
(1060, 1, '603005752', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 92, 9, 11, 1, 4, 1, 3500, 3500, '0', '0', NULL),
(1058, 1, '603005751', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 92, 4, 2, 1, 4, 1, 17000, 17000, '0', '0', NULL),
(1057, 2, '15403024', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 211, 4, 2, 6, 11, 1, 750, 750, '0', '0', NULL),
(1052, 2, '00804066', '3207', '', '', 'FEBRERO 2021', 'HON-3101', 209, 3, 3, 2, 7, 1, 480, 0, '0', '0', NULL),
(1043, 1, '12404015', '3207', '', '', 'FEBRERO 2021', 'HON-3110', 107, 3, 2, 5, 7, 1, 500, 0, '0', '0', NULL),
(1042, 1, '12404014', '3207', '', '', 'FEBRERO 2021', 'HON-3110', 107, 24, 1, 5, 7, 1, 500, 0, '0', '0', NULL),
(1041, 1, '19904007', '3207', '', '', 'FEBRERO 2021', 'HON-3110', 107, 42, 34, 6, 7, 1, 500, 0, '0', '0', NULL),
(1040, 1, '19904006', '3207', '', '', 'FEBRERO 2021', 'HON-3110', 107, 28, 14, 6, 7, 1, 200, 0, '0', '0', NULL),
(1039, 1, '19904005', '3207', '', '', 'FEBRERO 2021', 'HON-3110', 107, 3, 2, 6, 7, 1, 320, 0, '0', '0', NULL),
(1038, 1, '19904004', '3207', '', '', 'FEBRERO 2021', 'HON-3110', 107, 24, 1, 6, 7, 1, 200, 0, '0', '0', NULL),
(1023, 1, '20005001', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 90, 3, 3, 3, 7, 3, 16800, 0, '0', '0', NULL),
(1009, 1, '003041625', '3207', '', '', 'FEBRERO 2021', 'HON-3106', 90, 3, 35, 3, 11, 7, 18500, 18500, '0', '0', NULL),
(1004, 1, '13099014', '3207', '', '', 'FEBRERO 2021', 'HON-3108', 68, 3, 3, 3, 7, 1, 100, 0, '0', '0', NULL),
(1003, 1, '13099013', '3207', '', '', 'FEBRERO 2021', 'HON-3108', 68, 1, 6, 3, 7, 1, 100, 100, '0', '0', NULL),
(999, 1, '13099006', '3207', '', '', 'FEBRERO 2021', 'HON-3108', 64, 3, 3, 1, 7, 1, 200, 0, '0', '0', NULL),
(991, 2, '47801012', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 168, 9, 69, 6, 7, 1, 1000, 0, '0', '0', NULL),
(987, 2, '47801011', '3207', '', '', 'FEBRERO 2021', 'HON-3118', 168, 4, 2, 6, 11, 1, 7300, 0, '0', '0', NULL),
(976, 1, '10504018', '3207', '', '', 'FEBRERO 2021', 'HON-3108', 70, 1, 1, 6, 7, 1, 400, 0, '0', '0', NULL),
(975, 1, '10604072', '3207', '', '', 'FEBRERO 2021', 'HON-3113', 190, 39, 42, 6, 7, 1, 1000, 0, '0', '0', NULL),
(972, 2, '603004031', '3207', '', '', 'FEBRERO 2021', 'HON-3117', 88, 4, 3, 1, 11, 1, 500, 500, '0', '0', NULL),
(971, 1, '603004023', '3207', '', '', 'FEBRERO 2021', 'HON-3109', 88, 4, 3, 1, 12, 1, 3000, 3000, '0', '0', NULL),
(970, 1, '603004023', '3207', '', '', 'FEBRERO 2021', 'HON-3112', 88, 4, 3, 1, 12, 1, 5000, 0, '0', '0', NULL),
(969, 1, '603004002', '3207', '', '', 'FEBRERO 2021', 'HON-3120', 88, 4, 3, 1, 7, 1, 17600, 17600, '0', '0', NULL),
(956, 1, '10104750', '3201', '', '', 'ENERO 2021', 'HON-3100', 101, 2, 5, 4, 7, 1, 4300, 4300, '0', '0', NULL),
(926, 1, '00504032', '3201', '', '', 'ENERO 2021', 'HON-3100', 51, 4, 2, 3, 7, 1, 2400, 0, '0', '0', NULL),
(925, 1, '00504024', '3201', '', '', 'ENERO 2021', 'HON-3100', 51, 4, 2, 3, 18, 1, 18000, 0, '0', '0', NULL),
(922, 1, '00508001', '3201', '', '', 'ENERO 2021', 'HON-3100', 51, 9, 32, 2, 7, 3, 3360, -140, '0', '0', NULL),
(875, 1, '603004002', '3201', '', '', 'ENERO 2021', 'HON-3100', 88, 4, 3, 1, 7, 1, 3200, 3200, '0', '0', NULL),
(867, 4, '001105048', '3197', '', '', 'DICIEMBRE 2020', 'INT-H-1218', 115, 28, 43, 5, 20, 4, 160, 160, '0', '0', NULL),
(866, 4, '001105048', '3197', '', '', 'DICIEMBRE 2020', 'INT-H-1219-W', 115, 28, 43, 5, 20, 4, 640, 640, '0', '0', NULL),
(820, 1, '08503516', '3197', '', '', 'DICIEMBRE 2020', 'FTT-1456', 112, 4, 2, 2, 10, 1, 12000, 0, '0', '0', NULL),
(819, 1, '08503515', '3197', '', '', 'DICIEMBRE 2020', 'FTT-1456', 112, 1, 1, 2, 10, 1, 20000, 0, '0', '0', NULL),
(778, 1, '13105281', '3197', '', '', 'DICIEMBRE 2020', 'HON-3078', 163, 4, 66, 5, 7, 1, 2000, 0, '0', '0', NULL),
(777, 1, '13105280', '3197', '', '', 'DICIEMBRE 2020', 'HON-3078', 163, 2, 65, 5, 7, 1, 2000, 0, '0', '0', NULL),
(746, 4, '01606689', '3193', '', '', 'NOVIEMBRE 2020', 'INT-H-1212', 40, 2, 1, 5, 10, 1, 500, 500, '0', '0', NULL),
(731, 4, '01604011', '3193', '', '', 'NOVIEMBRE 2020', 'INT-H-1213', 109, 3, 2, 1, 7, 1, 1900, 1900, '0', '0', NULL),
(724, 4, '603005751', '3193', '', '', 'NOVIEMBRE 2020', 'INT-H-1214-W', 92, 4, 2, 1, 4, 1, 7710, 7710, '0', '0', NULL),
(720, 4, '00507001', '3193', '', '', 'NOVIEMBRE 2020', 'INT-H-1213', 159, 15, 62, 6, 15, 1, 2400, 2400, '0', '0', NULL),
(692, 4, '10104182', '3193', '', '', 'NOVIEMBRE 2020', 'INT-H-1210', 14, 6, 59, 3, 7, 1, 300, 300, '0', '0', NULL),
(625, 2, '47801434', '3193', '', '', 'NOVIEMBRE 2020', 'FTT-1450', 116, 4, 2, 2, 10, 1, 700, 700, '0', '0', NULL),
(577, 1, '00504032', '3193', '', '', 'NOVIEMBRE 2020', 'HON-3063', 51, 4, 2, 3, 7, 1, 1600, 0, '0', '0', NULL),
(527, 1, '01607601', '3193', '', '', 'NOVIEMBRE 2020', 'HON-3063', 95, 2, 1, 11, 7, 1, 100, 0, '0', '0', NULL),
(526, 1, '13105268', '3193', '', '', 'NOVIEMBRE 2020', 'HON-3057', 1462, 9, 16, 6, 7, 1, 500, 500, '0', '0', NULL),
(525, 1, '13105267', '3193', '', '', 'NOVIEMBRE 2020', 'HON-3057', 1462, 5, 4, 6, 7, 1, 500, 500, '0', '0', NULL),
(524, 1, '13105266', '3193', '', '', 'NOVIEMBRE 2020', 'HON-3057', 1462, 3, 2, 6, 7, 1, 500, 500, '0', '0', NULL),
(523, 1, '13105265', '3193', '', '', 'NOVIEMBRE 2020', 'HON-3057', 1462, 2, 1, 6, 7, 1, 500, 500, '0', '0', NULL),
(499, 1, '603005751', '3193', '', '', 'NOVIEMBRE 2020', 'HON-3063', 92, 4, 2, 1, 4, 1, 2400, 2400, '0', '0', NULL),
(445, 1, '603004002', '3193', '', '', 'NOVIEMBRE 2020', 'HON-3063', 88, 4, 3, 1, 7, 1, 800, 800, '0', '0', NULL),
(444, 1, '08503516', '3187', '', '', 'OCTUBRE 2020', 'FTT-1447', 112, 4, 2, 2, 10, 1, 11000, 11000, '0', '0', NULL),
(443, 1, '08503515', '3187', '', '', 'OCTUBRE 2020', 'FTT-1447', 112, 1, 1, 2, 10, 1, 10000, 10000, '0', '0', NULL),
(358, 1, '603005751', '3187', '', '', 'OCTUBRE 2020', 'HON-3039', 92, 4, 2, 1, 4, 1, 2600, 2600, '0', '0', NULL),
(138, 1, '08503515', '3187', '', '', 'OCTUBRE 2020', 'FTT-1447', 112, 1, 1, 2, 10, 1, 1000, 1000, '0', '0', NULL),
(71, 1, '603004002', '3187', '', '', 'OCTUBRE 2020', 'HON-3039', 88, 4, 3, 1, 7, 1, 1200, 1200, '0', '0', NULL),
(1, 1, '603004002', '3182', '', '', 'SEPTIEMBRE 2020', 'HON-3011', 88, 4, 3, 1, 7, 1, 1120, 1120, '0', '0', NULL),
(7, 1, '603005751', '3182', '', '', 'SEPTIEMBRE 2020', 'HON-3000', 92, 4, 2, 1, 4, 1, 7000, 7000, '0', '0', NULL),
(8, 1, '603005751', '3182', '', '', 'SEPTIEMBRE 2020', 'HON-3011', 92, 4, 2, 1, 4, 1, 5280, 5280, '0', '0', NULL),
(70, 1, '603004002', '3187', '', '', 'OCTUBRE 2020', 'HON-3030', 88, 4, 3, 1, 7, 1, 800, 800, '0', '0', NULL),
(2151, 1, '10104752', '3235', '', '', 'MAYO 2021', 'HON-3196', 101, 16, 36, 4, 7, 1, 1200, 1200, '0', '0', NULL),
(2150, 1, '10104750', '3235', '', '', 'MAYO 2021', 'HON-3196', 101, 2, 5, 4, 7, 1, 2400, 2400, '0', '0', NULL),
(2149, 1, '12506011', '3235', '', '', 'MAYO 2021', 'HON-3194', 61, 4, 14, 1, 12, 1, 250, 250, '0', '0', NULL),
(2148, 1, '12506021', '3235', '', '', 'MAYO 2021', 'HON-3196', 61, 4, 14, 1, 7, 1, 2800, 2800, '0', '0', NULL),
(2147, 1, '00508003', '3235', '', '', 'MAYO 2021', 'HON-3196', 61, 9, 11, 1, 7, 1, 400, 400, '0', '0', NULL),
(2146, 1, '12506010', '3235', '', '', 'MAYO 2021', 'HON-3194', 61, 4, 2, 1, 12, 1, 625, 625, '0', '0', NULL),
(2145, 1, '12506020', '3235', '', '', 'MAYO 2021', 'HON-3196', 61, 4, 2, 1, 7, 1, 5600, 5600, '0', '0', NULL),
(2144, 1, '12506001', '3235', '', '', 'MAYO 2021', 'HON-3196', 61, 4, 2, 1, 18, 1, 8000, 8000, '0', '0', NULL),
(2143, 1, '00508017', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 11, 12, 6, 4, 1, 400, 400, '0', '0', NULL),
(2142, 1, '00503012', '3235', '', '', 'MAYO 2021', 'HON-3200', 99, 31, 4, 6, 26, 1, 320, 320, '0', '0', NULL),
(2141, 1, '00504043', '3235', '', '', 'MAYO 2021', 'HON-3194', 99, 9, 11, 6, 11, 1, 1000, 1000, '0', '0', NULL),
(2140, 1, '00508002', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 9, 11, 6, 7, 1, 3600, 3600, '0', '0', NULL);
INSERT INTO `pendiente_empaque` (`id_pendiente`, `categoria`, `item`, `orden_del_sitema`, `observacion`, `presentacion`, `mes`, `orden`, `marca`, `vitola`, `nombre`, `capa`, `tipo_empaque`, `cello`, `pendiente`, `saldo`, `paquetes`, `unidades`, `id_pendiente_pedido`) VALUES
(2139, 1, '00704004', '3235', '', '', 'MAYO 2021', 'HON-3194', 99, 4, 2, 6, 12, 1, 500, 500, '0', '0', NULL),
(2138, 1, '00704001', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 4, 2, 6, 21, 3, 1000, 1000, '0', '0', NULL),
(2137, 1, '00704003', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 4, 2, 6, 7, 1, 6400, 6400, '0', '0', NULL),
(2136, 1, '00712004', '3235', '', '', 'MAYO 2021', 'HON-3194', 99, 22, 34, 6, 12, 1, 1250, 1250, '0', '0', NULL),
(2135, 1, '00712001', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 22, 34, 6, 21, 3, 3000, 3000, '0', '0', NULL),
(2134, 1, '00712003', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 22, 34, 6, 7, 1, 1200, 1200, '0', '0', NULL),
(2133, 1, '10104911', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 2, 1, 6, 23, 1, 200, 200, '0', '0', NULL),
(2132, 1, '00703001', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 2, 1, 6, 21, 3, 8000, 8000, '0', '0', NULL),
(2131, 1, '10515004', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 2, 1, 6, 4, 7, 1200, 1200, '0', '0', NULL),
(2130, 1, '00705001', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 4, 14, 6, 21, 3, 1000, 1000, '0', '0', NULL),
(2129, 1, '00705003', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 4, 14, 6, 7, 1, 1200, 1200, '0', '0', NULL),
(2128, 1, '00508016', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 11, 12, 2, 4, 1, 1200, 1200, '0', '0', NULL),
(2127, 1, '00508015', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 11, 12, 5, 4, 1, 600, 600, '0', '0', NULL),
(2126, 1, '00504150', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 2, 15, 7, 1, 2000, 2000, '0', '0', NULL),
(2125, 1, '00504038', '3235', '', '', 'MAYO 2021', 'HON-3194', 51, 4, 14, 3, 12, 1, 250, 250, '0', '0', NULL),
(2124, 1, '00504033', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 14, 3, 7, 1, 800, 800, '0', '0', NULL),
(2123, 1, '00505019', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 14, 3, 18, 1, 2000, 2000, '0', '0', NULL),
(2122, 1, '00504037', '3235', '', '', 'MAYO 2021', 'HON-3194', 51, 4, 2, 3, 12, 1, 500, 500, '0', '0', NULL),
(2121, 1, '00504032', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 2, 3, 7, 1, 2000, 2000, '0', '0', NULL),
(2120, 1, '00504024', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 2, 3, 18, 1, 10000, 10000, '0', '0', NULL),
(2119, 1, '005040103', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 22, 34, 2, 7, 1, 1200, 1200, '0', '0', NULL),
(2118, 1, '00504102', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 22, 34, 5, 7, 1, 800, 800, '0', '0', NULL),
(2117, 1, '00504042', '3235', '', '', 'MAYO 2021', 'HON-3194', 51, 9, 32, 2, 11, 1, 1500, 1500, '0', '0', NULL),
(2116, 1, '00508001', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 9, 32, 2, 7, 3, 6800, 6800, '0', '0', NULL),
(2115, 1, '00504041', '3235', '', '', 'MAYO 2021', 'HON-3194', 51, 9, 32, 5, 11, 1, 1500, 1500, '0', '0', NULL),
(2114, 1, '00508000', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 9, 32, 5, 7, 3, 5200, 5200, '0', '0', NULL),
(2113, 1, '00605003', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 14, 17, 2, 13, 3, 2000, 2000, '0', '0', NULL),
(2112, 1, '00503014', '3235', '', '', 'MAYO 2021', 'HON-3200', 51, 14, 17, 2, 26, 1, 320, 320, '0', '0', NULL),
(2111, 1, '00605002', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 14, 17, 5, 13, 3, 1500, 1500, '0', '0', NULL),
(2110, 1, '00503013', '3235', '', '', 'MAYO 2021', 'HON-3200', 51, 14, 17, 5, 26, 1, 2560, 2560, '0', '0', NULL),
(2109, 1, '00503010', '3235', '', '', 'MAYO 2021', 'HON-3200', 51, 31, 4, 2, 26, 1, 960, 960, '0', '0', NULL),
(2108, 1, '00503011', '3235', '', '', 'MAYO 2021', 'HON-3200', 51, 31, 4, 5, 26, 1, 320, 320, '0', '0', NULL),
(2107, 1, '00504101', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 2, 1, 2, 7, 3, 4000, 4000, '0', '0', NULL),
(2106, 1, '10515003', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 2, 1, 2, 4, 2, 200, 200, '0', '0', NULL),
(2105, 1, '10104912', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 2, 1, 5, 23, 1, 8000, 8000, '0', '0', NULL),
(2104, 1, '00504100', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 2, 1, 5, 7, 1, 6400, 6400, '0', '0', NULL),
(2103, 1, '10515002', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 2, 1, 5, 4, 7, 800, 800, '0', '0', NULL),
(2102, 1, '00505009', '3235', '', '', 'MAYO 2021', 'HON-3194', 51, 4, 14, 2, 12, 1, 500, 500, '0', '0', NULL),
(2101, 1, '00505003', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 14, 2, 7, 3, 1200, 1200, '0', '0', NULL),
(2100, 1, '00505007', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 14, 2, 18, 3, 6000, 6000, '0', '0', NULL),
(2099, 1, '00505002', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 14, 5, 7, 3, 3600, 3600, '0', '0', NULL),
(2098, 1, '00904038', '3235', '', '', 'MAYO 2021', 'HON-3196', 96, 4, 2, 3, 14, 1, 13200, 13200, '0', '0', NULL),
(2097, 1, '00904038', '3235', '', '', 'MAYO 2021', 'HON-3196', 97, 4, 2, 1, 14, 1, 13200, 13200, '0', '0', NULL),
(2096, 1, '00904038', '3235', '', '', 'MAYO 2021', 'HON-3196', 96, 4, 2, 5, 14, 1, 13200, 13200, '0', '0', NULL),
(2095, 1, '00904038', '3235', '', '', 'MAYO 2021', 'HON-3196', 96, 4, 2, 2, 14, 1, 13200, 13200, '0', '0', NULL),
(2094, 1, '00504010', '3235', '', '', 'MAYO 2021', 'HON-3194', 51, 4, 2, 2, 12, 1, 1250, 1250, '0', '0', NULL),
(2093, 1, '00504003', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 2, 2, 7, 3, 12800, 12800, '0', '0', NULL),
(2092, 1, '00504007', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 2, 2, 18, 3, 20000, 20000, '0', '0', NULL),
(2091, 1, '00504009', '3235', '', '', 'MAYO 2021', 'HON-3194', 51, 4, 2, 5, 12, 1, 500, 500, '0', '0', NULL),
(2090, 1, '00504002', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 2, 5, 7, 3, 12400, 12400, '0', '0', NULL),
(2089, 1, '00504006', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 4, 2, 5, 18, 3, 14000, 14000, '0', '0', NULL),
(2088, 1, '00405000', '3235', '', '', 'MAYO 2021', 'HON-3196', 67, 16, 14, 3, 7, 3, 400, 400, '0', '0', NULL),
(2087, 1, '00303007', '3235', '', '', 'MAYO 2021', 'HON-3196', 67, 25, 2, 3, 4, 2, 1600, 1600, '0', '0', NULL),
(2086, 1, '00408000', '3235', '', '', 'MAYO 2021', 'HON-3196', 67, 9, 40, 3, 7, 1, 400, 400, '0', '0', NULL),
(2085, 1, '00404000', '3235', '', '', 'MAYO 2021', 'HON-3196', 67, 3, 2, 3, 7, 3, 3200, 3200, '0', '0', NULL),
(2084, 1, '00403000', '3235', '', '', 'MAYO 2021', 'HON-3196', 67, 2, 1, 3, 7, 3, 4800, 4800, '0', '0', NULL),
(2083, 1, '00401000', '3235', '', '', 'MAYO 2021', 'HON-3196', 67, 19, 25, 3, 7, 1, 1600, 1600, '0', '0', NULL),
(2082, 1, '00110284', '3235', '', '', 'MAYO 2021', 'HON-3196', 72, 9, 11, 6, 10, 1, 400, 400, '0', '0', NULL),
(2081, 1, '00110286', '3235', '', '', 'MAYO 2021', 'HON-3196', 72, 4, 2, 2, 10, 1, 800, 800, '0', '0', NULL),
(2080, 1, '00110285', '3235', '', '', 'MAYO 2021', 'HON-3196', 72, 4, 2, 5, 10, 1, 800, 800, '0', '0', NULL),
(2079, 1, '581000250', '3235', '', '', 'MAYO 2021', 'HON-3185', 214, 3, 3, 3, 4, 1, 1500, 1500, '0', '0', NULL),
(2078, 1, '11220036', '3235', '', '', 'MAYO 2021', 'FTT-1503', 943, 4, 2, 6, 10, 1, 140, 140, '0', '0', NULL),
(2077, 1, '11220035', '3235', '', '', 'MAYO 2021', 'FTT-1503', 943, 4, 2, 1, 10, 1, 140, 140, '0', '0', NULL),
(2076, 1, '01606674', '3235', '', '', 'MAYO 2021', 'HON-3196', 40, 3, 2, 5, 7, 1, 7600, 7600, '0', '0', NULL),
(2075, 1, '01606676', '3235', '', '', 'MAYO 2021', 'HON-3196', 40, 2, 1, 5, 7, 1, 4800, 4800, '0', '0', NULL),
(2074, 1, '01606675', '3235', '', '', 'MAYO 2021', 'HON-3196', 40, 20, 30, 5, 7, 1, 6000, 6000, '0', '0', NULL),
(2073, 1, '1240300103', '3235', '', '', 'MAYO 2021', 'HON-3177', 66, 22, 34, 6, 10, 1, 500, 500, '0', '0', NULL),
(2072, 1, '1240300103', '3235', '', '', 'MAYO 2021', 'HON-3188', 66, 22, 34, 6, 10, 1, 1000, 1000, '0', '0', NULL),
(2071, 1, '12403007', '3235', '', '', 'MAYO 2021', 'HON-3177', 66, 22, 34, 6, 7, 1, 700, 700, '0', '0', NULL),
(2070, 1, '12403006', '3235', '', '', 'MAYO 2021', 'HON-3177', 66, 5, 4, 6, 7, 1, 300, 300, '0', '0', NULL),
(2069, 1, '1240300102', '3235', '', '', 'MAYO 2021', 'HON-3177', 66, 3, 14, 6, 10, 1, 200, 200, '0', '0', NULL),
(2068, 1, '12403005', '3235', '', '', 'MAYO 2021', 'HON-3177', 66, 3, 14, 6, 7, 1, 200, 200, '0', '0', NULL),
(2067, 1, '1240300101', '3235', '', '', 'MAYO 2021', 'HON-3188', 66, 3, 2, 6, 10, 1, 1000, 1000, '0', '0', NULL),
(2066, 1, '12403004', '3235', '', '', 'MAYO 2021', 'HON-3177', 66, 3, 2, 6, 7, 1, 600, 600, '0', '0', NULL),
(2065, 1, '12403004', '3235', '', '', 'MAYO 2021', 'HON-3188', 66, 3, 2, 6, 7, 1, 3000, 3000, '0', '0', NULL),
(2064, 1, '1240300100', '3235', '', '', 'MAYO 2021', 'HON-3177', 66, 2, 1, 6, 10, 1, 200, 200, '0', '0', NULL),
(2063, 1, '12403003', '3235', '', '', 'MAYO 2021', 'HON-3177', 66, 2, 1, 6, 7, 1, 300, 300, '0', '0', NULL),
(2062, 1, '12403003', '3235', '', '', 'MAYO 2021', 'HON-3188', 66, 2, 1, 6, 7, 1, 2400, 2400, '0', '0', NULL),
(2061, 1, '9900004025', '3235', '', '', 'MAYO 2021', 'HON-3184', 230, 9, 16, 1, 7, 1, 2000, 2000, '0', '0', NULL),
(2060, 1, '9900004030', '3235', '', '', 'MAYO 2021', 'HON-3204', 230, 2, 1, 1, 10, 1, 1000, 1000, '0', '0', NULL),
(2059, 1, '9900004030', '3235', '', '', 'MAYO 2021', 'HON-3187', 230, 2, 1, 1, 10, 1, 4000, 4000, '0', '0', NULL),
(2058, 1, '9900004027', '3235', '', '', 'MAYO 2021', 'HON-3184', 230, 2, 1, 1, 7, 1, 2000, 2000, '0', '0', NULL),
(2057, 1, '9900004031', '3235', '', '', 'MAYO 2021', 'HON-3187', 230, 3, 2, 1, 10, 1, 2000, 2000, '0', '0', NULL),
(2056, 1, '9900004031', '3235', '', '', 'MAYO 2021', 'HON-3204', 230, 3, 2, 1, 10, 1, 500, 500, '0', '0', NULL),
(2055, 1, '9900004028', '3235', '', '', 'MAYO 2021', 'HON-3184', 230, 3, 2, 1, 7, 1, 3000, 3000, '0', '0', NULL),
(2054, 1, '9900009187', '3235', '', '', 'MAYO 2021', 'HON-3202', 230, 3, 2, 1, 11, 1, 2000, 2000, '0', '0', NULL),
(2053, 1, '9900009187', '3235', '', '', 'MAYO 2021', 'HON-3202', 53, 3, 2, 1, 11, 1, 2000, 2000, '0', '0', NULL),
(2052, 1, '9900009187', '3235', '', '', 'MAYO 2021', 'HON-3202', 228, 3, 2, 1, 11, 1, 2000, 2000, '0', '0', NULL),
(2051, 1, '9900009187', '3235', '', '', 'MAYO 2021', 'HON-3202', 94, 25, 2, 2, 11, 1, 2000, 2000, '0', '0', NULL),
(2050, 1, '9900009187', '3235', '', '', 'MAYO 2021', 'HON-3202', 229, 3, 2, 3, 11, 1, 2000, 2000, '0', '0', NULL),
(2049, 1, '9900004040', '3235', '', '', 'MAYO 2021', 'HON-3187', 229, 3, 2, 3, 10, 1, 2000, 2000, '0', '0', NULL),
(2048, 1, '9900004040', '3235', '', '', 'MAYO 2021', 'HON-3201', 229, 3, 2, 3, 10, 1, 3000, 3000, '0', '0', NULL),
(2047, 1, '9900004040', '3235', '', '', 'MAYO 2021', 'HON-3204', 229, 3, 2, 3, 10, 1, 5000, 5000, '0', '0', NULL),
(2046, 1, '9900004038', '3235', '', '', 'MAYO 2021', 'HON-3184', 229, 3, 2, 3, 7, 1, 4000, 4000, '0', '0', NULL),
(2045, 1, '9900004039', '3235', '', '', 'MAYO 2021', 'HON-3204', 229, 2, 1, 3, 10, 1, 1000, 1000, '0', '0', NULL),
(2044, 1, '9900004039', '3235', '', '', 'MAYO 2021', 'HON-3187', 229, 2, 1, 3, 10, 1, 3000, 3000, '0', '0', NULL),
(2043, 1, '9900004037', '3235', '', '', 'MAYO 2021', 'HON-3184', 229, 2, 1, 3, 7, 1, 2000, 2000, '0', '0', NULL),
(2042, 1, '9900004035', '3235', '', '', 'MAYO 2021', 'HON-3184', 229, 9, 16, 3, 7, 1, 2000, 2000, '0', '0', NULL),
(2041, 1, '9900004023', '3235', '', '', 'MAYO 2021', 'HON-3204', 53, 3, 2, 1, 10, 1, 5000, 5000, '0', '0', NULL),
(2040, 1, '9900004023', '3235', '', '', 'MAYO 2021', 'HON-3187', 53, 3, 2, 1, 10, 1, 4000, 4000, '0', '0', NULL),
(2039, 1, '9900004020', '3235', '', '', 'MAYO 2021', 'HON-3184', 53, 3, 2, 1, 7, 1, 7000, 7000, '0', '0', NULL),
(2038, 1, '9900004022', '3235', '', '', 'MAYO 2021', 'HON-3203', 53, 2, 1, 1, 10, 1, 5000, 5000, '0', '0', NULL),
(2037, 1, '9900004022', '3235', '', '', 'MAYO 2021', 'HON-3204', 53, 2, 1, 1, 10, 1, 1000, 1000, '0', '0', NULL),
(2036, 1, '9900004019', '3235', '', '', 'MAYO 2021', 'HON-3184', 53, 2, 1, 1, 7, 1, 4000, 4000, '0', '0', NULL),
(2035, 1, '9900004013', '3235', '', '', 'MAYO 2021', 'HON-3184', 228, 9, 16, 1, 7, 1, 5000, 5000, '0', '0', NULL),
(2034, 1, '9900004016', '3235', '', '', 'MAYO 2021', 'HON-3187', 228, 3, 2, 1, 10, 1, 4000, 4000, '0', '0', NULL),
(2033, 1, '9900004016', '3235', '', '', 'MAYO 2021', 'HON-3204', 228, 3, 2, 1, 10, 1, 6000, 6000, '0', '0', NULL),
(2032, 1, '9900004012', '3235', '', '', 'MAYO 2021', 'HON-3184', 228, 3, 2, 1, 7, 1, 8000, 8000, '0', '0', NULL),
(2031, 1, '9900004016', '3235', '', '', 'MAYO 2021', 'HON-3204', 228, 2, 1, 1, 10, 1, 1000, 1000, '0', '0', NULL),
(2030, 1, '9900004016', '3235', '', '', 'MAYO 2021', 'HON-3187', 228, 2, 1, 1, 10, 1, 5000, 5000, '0', '0', NULL),
(2029, 1, '9900004011', '3235', '', '', 'MAYO 2021', 'HON-3184', 228, 2, 1, 1, 7, 1, 6000, 6000, '0', '0', NULL),
(2028, 1, '9900004005', '3235', '', '', 'MAYO 2021', 'HON-3204', 94, 25, 2, 2, 10, 1, 5000, 5000, '0', '0', NULL),
(2027, 1, '9900004005', '3235', '', '', 'MAYO 2021', 'HON-3187', 94, 25, 2, 2, 10, 1, 2000, 2000, '0', '0', NULL),
(2026, 1, '9900004003', '3235', '', '', 'MAYO 2021', 'HON-3184', 94, 25, 2, 2, 7, 1, 4000, 4000, '0', '0', NULL),
(2025, 1, '9900004004', '3235', '', '', 'MAYO 2021', 'HON-3187', 94, 2, 1, 2, 10, 1, 3000, 3000, '0', '0', NULL),
(2024, 1, '9900004004', '3235', '', '', 'MAYO 2021', 'HON-3204', 94, 2, 1, 2, 10, 1, 1000, 1000, '0', '0', NULL),
(2023, 1, '9900004002', '3235', '', '', 'MAYO 2021', 'HON-3184', 94, 2, 1, 2, 7, 1, 3000, 3000, '0', '0', NULL),
(2022, 1, '9900004000', '3235', '', '', 'MAYO 2021', 'HON-3184', 94, 9, 16, 2, 7, 1, 4000, 4000, '0', '0', NULL),
(2021, 1, '9900009112', '3235', '', '', 'MAYO 2021', 'HON-3184', 93, 9, 16, 2, 7, 1, 2000, 2000, '0', '0', NULL),
(2020, 1, '9900009117', '3235', '', '', 'MAYO 2021', 'HON-3204', 93, 3, 27, 2, 10, 1, 1000, 1000, '0', '0', NULL),
(2019, 1, '9900009117', '3235', '', '', 'MAYO 2021', 'HON-3187', 93, 3, 27, 2, 10, 1, 2000, 2000, '0', '0', NULL),
(2018, 1, '9900009111', '3235', '', '', 'MAYO 2021', 'HON-3184', 93, 3, 27, 2, 7, 1, 3000, 3000, '0', '0', NULL),
(2017, 1, '9900009118', '3235', '', '', 'MAYO 2021', 'HON-3187', 93, 2, 79, 2, 10, 1, 3000, 3000, '0', '0', NULL),
(2016, 1, '9900009118', '3235', '', '', 'MAYO 2021', 'HON-3204', 93, 2, 79, 2, 10, 1, 2500, 2500, '0', '0', NULL),
(2015, 1, '9900009110', '3235', '', '', 'MAYO 2021', 'HON-3184', 93, 2, 79, 2, 7, 1, 2000, 2000, '0', '0', NULL),
(2014, 1, '15004002', '3235', '', '', 'MAYO 2021', 'HON-3190', 184, 3, 3, 2, 7, 1, 4000, 4000, '0', '0', NULL),
(2013, 1, '15004001', '3235', '', '', 'MAYO 2021', 'HON-3190', 184, 5, 51, 2, 7, 1, 2000, 2000, '0', '0', NULL),
(2012, 1, '15003000', '3235', '', '', 'MAYO 2021', 'HON-3190', 184, 24, 6, 2, 7, 1, 2000, 2000, '0', '0', NULL),
(2011, 1, '00507001', '3235', '', '', 'MAYO 2021', 'FTT-1502', 159, 15, 62, 6, 15, 1, 4000, 4000, '0', '0', NULL),
(2010, 1, '00231000', '3235', '', '', 'MAYO 2021', 'FTT-1502', 62, 15, 18, 3, 15, 1, 3000, 3000, '0', '0', NULL),
(2009, 1, '00107000', '3235', '', '', 'MAYO 2021', 'FTT-1502', 141, 15, 53, 9, 15, 1, 3000, 3000, '0', '0', NULL),
(2008, 1, '00407000', '3235', '', '', 'MAYO 2021', 'FTT-1502', 158, 15, 46, 9, 15, 1, 3000, 3000, '0', '0', NULL),
(2007, 1, '603005750', '3235', '', '', 'MAYO 2021', 'HON-3196', 92, 2, 1, 1, 4, 1, 2000, 2000, '0', '0', NULL),
(2006, 1, '603005751', '3235', '', '', 'MAYO 2021', 'HON-3196', 92, 4, 2, 1, 4, 1, 400, 400, '0', '0', NULL),
(2005, 1, '13105120', '3235', '', '', 'MAYO 2021', 'HON-3196', 210, 2, 1, 3, 4, 7, 600, 600, '0', '0', NULL),
(2004, 1, '00508022', '3235', '', '', 'MAYO 2021', 'HON-3196', 91, 9, 11, 10, 7, 1, 2800, 2800, '0', '0', NULL),
(2003, 1, '20005007', '3235', '', '', 'MAYO 2021', 'HON-3196', 90, 9, 26, 3, 7, 1, 1600, 1600, '0', '0', NULL),
(2002, 1, '20005005', '3235', '', '', 'MAYO 2021', 'HON-3196', 90, 34, 52, 3, 7, 1, 800, 800, '0', '0', NULL),
(2001, 1, '01004012', '3235', '', '', 'MAYO 2021', 'HON-3194', 90, 3, 3, 3, 12, 1, 1250, 1250, '0', '0', NULL),
(2000, 1, '20005001', '3235', '', '', 'MAYO 2021', 'HON-3196', 90, 3, 3, 3, 7, 3, 14800, 14800, '0', '0', NULL),
(1999, 1, '20005002', '3235', '', '', 'MAYO 2021', 'HON-3196', 90, 3, 21, 3, 7, 3, 8800, 8800, '0', '0', NULL),
(1998, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3179', 101, 2, 5, 4, 9, 1, 10000, 10000, '0', '0', NULL),
(1994, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3179', 67, 2, 1, 3, 9, 1, 10000, 10000, '0', '0', NULL),
(1993, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3179', 51, 2, 1, 3, 9, 1, 10000, 10000, '0', '0', NULL),
(1992, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3179', 51, 2, 1, 2, 9, 1, 10000, 10000, '0', '0', NULL),
(1991, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3179', 61, 2, 1, 1, 9, 1, 10000, 10000, '0', '0', NULL),
(1990, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3179', 99, 2, 1, 6, 9, 1, 10000, 10000, '0', '0', NULL),
(1989, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3179', 90, 1, 6, 3, 9, 1, 10000, 10000, '0', '0', NULL),
(1988, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3196', 101, 2, 5, 4, 9, 1, 2300, 2300, '0', '0', NULL),
(1984, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3196', 67, 2, 1, 3, 9, 1, 2300, 2300, '0', '0', NULL),
(1983, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 2, 1, 3, 9, 1, 2300, 2300, '0', '0', NULL),
(1982, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3196', 51, 2, 1, 2, 9, 1, 2300, 2300, '0', '0', NULL),
(1981, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3196', 61, 2, 1, 1, 9, 1, 2300, 2300, '0', '0', NULL),
(1980, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3196', 99, 2, 1, 6, 9, 1, 2300, 2300, '0', '0', NULL),
(1979, 1, '10104940', '3235', '', '', 'MAYO 2021', 'HON-3196', 90, 1, 6, 3, 9, 1, 2300, 2300, '0', '0', NULL),
(1978, 1, '20005000', '3235', '', '', 'MAYO 2021', 'HON-3196', 90, 1, 6, 3, 7, 3, 9200, 9200, '0', '0', NULL),
(1977, 1, '00303023', '3235', '', '', 'MAYO 2021', 'HON-3186', 90, 3, 35, 3, 21, 2, 5000, 5000, '0', '0', NULL),
(1976, 1, '20005010', '3235', '', '', 'MAYO 2021', 'HON-3196', 90, 3, 35, 3, 4, 2, 1200, 1200, '0', '0', NULL),
(1975, 1, '00110226', '3235', '', '', 'MAYO 2021', 'HON-3199', 1015, 168, 2, 1, 7, 1, 400, 400, '0', '0', NULL),
(1974, 1, '00110225', '3235', '', '', 'MAYO 2021', 'HON-3199', 1015, 1, 1, 1, 7, 1, 400, 400, '0', '0', NULL),
(1973, 1, '603004004', '3235', '', '', 'MAYO 2021', 'HON-3196', 88, 17, 23, 1, 7, 1, 2000, 2000, '0', '0', NULL),
(1972, 1, '603004002', '3235', '', '', 'MAYO 2021', 'HON-3196', 88, 4, 3, 1, 7, 1, 6800, 6800, '0', '0', NULL),
(1971, 2, '47801405', '3235', '', '', 'MAYO 2021', 'FTT-1495', 153, 4, 2, 4, 10, 1, 3000, 3000, '0', '0', NULL),
(1970, 2, '10104772', '3235', '', '', 'MAYO 2021', 'HON-3198', 101, 5, 38, 4, 12, 1, 125, 125, '0', '0', NULL),
(1969, 2, '10104778', '3235', '', '', 'MAYO 2021', 'HON-3182', 101, 2, 5, 4, 11, 1, 750, 750, '0', '0', NULL),
(1968, 2, '10104112', '3235', '', '', 'MAYO 2021', 'HON-3189', 86, 6, 19, 6, 7, 1, 1000, 1000, '0', '0', NULL),
(1967, 2, '47801409', '3235', '', '', 'MAYO 2021', 'HON-1495', 664, 1, 1, 2, 10, 1, 12000, 12000, '0', '0', NULL),
(1966, 2, '12506011', '3235', '', '', 'MAYO 2021', 'HON-3198', 61, 4, 14, 1, 12, 1, 250, 250, '0', '0', NULL),
(1965, 2, '15506017', '3235', '', '', 'MAYO 2021', 'HON-3198', 61, 9, 11, 1, 11, 1, 200, 200, '0', '0', NULL),
(1964, 2, '12506010', '3235', '', '', 'MAYO 2021', 'HON-3193', 61, 4, 2, 1, 12, 1, 1250, 1250, '0', '0', NULL),
(1963, 2, '47801042', '3235', '', '', 'MAYO 2021', 'FTT-1500', 103, 4, 2, 6, 10, 1, 4000, 4000, '0', '0', NULL),
(1962, 2, '47801044', '3235', '', '', 'MAYO 2021', 'FTT-1500', 148, 4, 2, 3, 10, 1, 2000, 2000, '0', '0', NULL),
(1961, 2, '47801043', '3235', '', '', 'MAYO 2021', 'FTT-1500', 148, 4, 2, 1, 10, 1, 2000, 2000, '0', '0', NULL),
(1960, 2, '47801041', '3235', '', '', 'MAYO 2021', 'FTT-1500', 148, 4, 2, 2, 10, 1, 2000, 2000, '0', '0', NULL),
(1959, 2, '00504043', '3235', '', '', 'MAYO 2021', 'HON-3198', 99, 9, 11, 6, 11, 1, 200, 200, '0', '0', NULL),
(1958, 2, '00704004', '3235', '', '', 'MAYO 2021', 'HON-3198', 99, 4, 2, 6, 12, 1, 125, 125, '0', '0', NULL),
(1957, 2, '00504047', '3235', '', '', 'MAYO 2021', 'HON-3191', 51, 4, 14, 3, 11, 1, 350, 350, '0', '0', NULL),
(1956, 2, '00504042', '3235', '', '', 'MAYO 2021', 'HON-3198', 51, 9, 32, 2, 11, 1, 200, 200, '0', '0', NULL),
(1955, 2, '00504041', '3235', '', '', 'MAYO 2021', 'HON-3198', 51, 9, 32, 5, 11, 1, 200, 200, '0', '0', NULL),
(1954, 2, '40503002', '3235', '', '', 'MAYO 2021', 'HON-3190', 51, 18, 24, 2, 7, 1, 10000, 10000, '0', '0', NULL),
(1953, 2, '40503023', '3235', '', '', 'MAYO 2021', 'HON-3190', 51, 18, 24, 5, 9, 1, 3000, 3000, '0', '0', NULL),
(1952, 2, '40503001', '3235', '', '', 'MAYO 2021', 'HON-3190', 51, 18, 24, 5, 7, 1, 10000, 10000, '0', '0', NULL),
(1951, 2, '00503004', '3235', '', '', 'MAYO 2021', 'HON-3198', 51, 2, 1, 5, 12, 1, 250, 250, '0', '0', NULL),
(1950, 2, '00504010', '3235', '', '', 'MAYO 2021', 'HON-3198', 51, 4, 2, 2, 12, 1, 1250, 1250, '0', '0', NULL),
(1949, 2, '00504010', '3235', '', '', 'MAYO 2021', 'HON-3193', 51, 4, 2, 2, 12, 1, 1875, 1875, '0', '0', NULL),
(1948, 2, '00504009', '3235', '', '', 'MAYO 2021', 'HON-3193', 51, 4, 2, 5, 12, 1, 1875, 1875, '0', '0', NULL),
(1947, 2, '20018022', '3235', '', '', 'MAYO 2021', 'HON-3194', 113, 9, 11, 1, 12, 1, 1250, 1250, '0', '0', NULL),
(1946, 2, '01104000', '3235', '', '', 'MAYO 2021', 'HON-3183', 59, 4, 3, 2, 13, 3, 625, 625, '0', '0', NULL),
(1945, 2, '01103000', '3235', '', '', 'MAYO 2021', 'HON-3183', 59, 1, 6, 18, 13, 3, 750, 750, '0', '0', NULL),
(1944, 2, '01119000', '3235', '', '', 'MAYO 2021', 'HON-3192', 59, 24, 21, 2, 13, 3, 1375, 1375, '0', '0', NULL),
(1943, 2, '01103005', '3235', '', '', 'MAYO 2021', 'HON-3183', 59, 24, 21, 2, 11, 1, 250, 250, '0', '0', NULL),
(1942, 2, '13408000', '3235', '', '', 'MAYO 2021', 'HON-3182', 67, 9, 40, 3, 11, 1, 1250, 1250, '0', '0', NULL),
(1941, 2, '13403000', '3235', '', '', 'MAYO 2021', 'HON-3198', 67, 2, 1, 3, 11, 1, 500, 500, '0', '0', NULL),
(1940, 2, '603006642', '3235', '', '', 'MAYO 2021', 'FTT-1498', 56, 9, 11, 2, 11, 1, 2500, 2500, '0', '0', NULL),
(1939, 2, '603006649', '3235', '', '', 'MAYO 2021', 'FTT-1499', 56, 9, 11, 2, 9, 1, 10000, 10000, '0', '0', NULL),
(1938, 2, '603006632', '3235', '', '', 'MAYO 2021', 'FFT-1498', 56, 9, 11, 2, 7, 1, 10000, 10000, '0', '0', NULL),
(1937, 2, '603006641', '3235', '', '', 'MAYO 2021', 'FTT-1498', 56, 4, 2, 2, 11, 1, 2500, 2500, '0', '0', NULL),
(1936, 2, '603006647', '3235', '', '', 'MAYO 2021', 'FTT-1499', 56, 4, 2, 2, 9, 1, 10000, 10000, '0', '0', NULL),
(1935, 2, '603006645', '3235', '', '', 'MAYO 2021', 'FTT-1498', 56, 4, 2, 2, 12, 1, 10000, 10000, '0', '0', NULL),
(1934, 2, '603006631', '3235', '', '', 'MAYO 2021', 'FFT-1498', 56, 4, 2, 2, 7, 1, 10000, 10000, '0', '0', NULL),
(1933, 2, '603006640', '3235', '', '', 'MAYO 2021', 'FTT-1498', 56, 2, 1, 2, 11, 1, 2500, 2500, '0', '0', NULL),
(1932, 2, '603006646', '3235', '', '', 'MAYO 2021', 'FTT-1499', 56, 2, 1, 2, 9, 1, 5000, 5000, '0', '0', NULL),
(1931, 2, '603006630', '3235', '', '', 'MAYO 2021', 'FTT-1498', 56, 2, 1, 2, 7, 1, 10000, 10000, '0', '0', NULL),
(1930, 2, '01606878', '3235', '', '', 'MAYO 2021', 'FTT-1499', 56, 9, 11, 6, 9, 1, 10000, 10000, '0', '0', NULL),
(1929, 2, '603006614', '3235', '', '', 'MAYO 2021', 'FTT-1499', 56, 9, 11, 3, 9, 1, 10000, 10000, '0', '0', NULL),
(1928, 2, '01606877', '3235', '', '', 'MAYO 2021', 'FTT-1499', 56, 4, 2, 6, 9, 1, 10000, 10000, '0', '0', NULL),
(1927, 2, '08503501', '3235', '', '', 'MAYO 2021', 'HON-1495', 165, 4, 2, 5, 10, 1, 1600, 1600, '0', '0', NULL),
(1926, 2, '40923002', '3235', '', '', 'MAYO 2021', 'HON-3194', 186, 3, 3, 5, 9, 1, 1000, 1000, '0', '0', NULL),
(1925, 2, '00904111', '3235', '', '', 'MAYO 2021', 'HON-3194', 186, 3, 3, 2, 9, 1, 1000, 1000, '0', '0', NULL),
(1924, 2, '01605002', '3235', '', '', 'MAYO 2021', 'HON-3198', 109, 28, 14, 1, 12, 1, 125, 125, '0', '0', NULL),
(1923, 2, '01603005', '3235', '', '', 'MAYO 2021', 'HON-3198', 109, 38, 57, 1, 12, 1, 250, 250, '0', '0', NULL),
(1922, 2, '01104509', '3235', '', '', 'MAYO 2021', 'HON-3183', 151, 4, 2, 15, 11, 1, 400, 400, '0', '0', NULL),
(1921, 2, '01104500', '3235', '', '', 'MAYO 2021', 'HON-3183', 151, 4, 2, 15, 7, 1, 500, 500, '0', '0', NULL),
(1920, 2, '15406023', '3235', '', '', 'MAYO 2021', 'HON-3183', 167, 4, 2, 2, 11, 1, 250, 250, '0', '0', NULL),
(1919, 2, '00804065', '3235', '', '', 'MAYO 2021', 'HON-3182', 209, 18, 6, 2, 7, 1, 400, 400, '0', '0', NULL),
(1918, 2, '00804066', '3235', '', '', 'MAYO 2021', 'HON-3182', 209, 3, 3, 2, 7, 1, 400, 400, '0', '0', NULL),
(1917, 2, '20005006', '3235', '', '', 'MAYO 2021', 'HON-3176', 90, 3, 3, 3, 11, 1, 1250, 1250, '0', '0', NULL),
(1916, 2, '01004012', '3235', '', '', 'MAYO 2021', 'HON-3198', 90, 3, 3, 3, 12, 1, 1250, 1250, '0', '0', NULL),
(1915, 2, '01004013', '3235', '', '', 'MAYO 2021', 'HON-3198', 90, 3, 21, 3, 12, 1, 250, 250, '0', '0', NULL),
(1913, 2, '10499060', '3235', '', '', 'MAYO 2021', 'HON-3182', 200, 2, 1, 1, 11, 1, 400, 400, '0', '0', NULL),
(1910, 2, '10499060', '3235', '', '', 'MAYO 2021', 'HON-3182', 51, 2, 1, 1, 11, 1, 400, 400, '0', '0', NULL),
(1909, 2, '20005016', '3235', '', '', 'MAYO 2021', 'HON-3198', 90, 1, 6, 3, 11, 1, 500, 500, '0', '0', NULL),
(1908, 2, '47801000', '3235', '', '', 'MAYO 2021', 'HON-3183', 168, 2, 1, 6, 7, 1, 2000, 2000, '0', '0', NULL),
(1907, 2, '603004031', '3235', '', '', 'MAYO 2021', 'HON-3182', 88, 4, 3, 1, 11, 1, 1250, 1250, '0', '0', NULL),
(1905, 4, '603004002', '3222', '', '', 'ABRIL 2021', 'INT-H-1242', 88, 4, 3, 1, 7, 1, 200, 200, '0', '0', NULL),
(1891, 3, '19912000', '3222', '', '', 'ABRIL 2021', 'HON-3155', 889, 22, 34, 6, 12, 1, 750, 0, '0', '0', NULL),
(1890, 3, '19911999', '3222', '', '', 'ABRIL 2021', 'HON-3155', 889, 9, 16, 6, 12, 1, 400, 0, '0', '0', NULL),
(1889, 3, '09906039', '3222', '', '', 'ABRIL 2021', 'HON-3165', 182, 9, 40, 3, 22, 4, 900, 900, '0', '0', NULL),
(1887, 3, '09906037', '3222', '', '', 'ABRIL 2021', 'HON-3168', 182, 3, 2, 3, 22, 4, 2250, 2250, '0', '0', NULL),
(1886, 3, '09906037', '3222', '', '', 'ABRIL 2021', 'HON-3165', 182, 3, 2, 3, 22, 4, 900, 900, '0', '0', NULL),
(1884, 3, '09906036', '3222', '', '', 'ABRIL 2021', 'HON-3168', 161, 4, 14, 2, 20, 4, 2400, 0, '0', '0', NULL),
(1883, 3, '11707000', '3222', '', '', 'ABRIL 2021', 'FTT-1481', 136, 15, 46, 9, 17, 4, 24000, 24000, '0', '0', NULL),
(1882, 3, '11707003', '3222', '', '', 'ABRIL 2021', 'FTT-1481', 138, 15, 48, 6, 17, 4, 48000, 48000, '0', '0', NULL),
(1881, 3, '11707001', '3222', '', '', 'ABRIL 2021', 'FTT-1481', 75, 15, 22, 9, 17, 4, 24000, 24000, '0', '0', NULL),
(1880, 3, '09906008', '3222', '', '', 'ABRIL 2021', 'HON-3165', 219, 32, 97, 3, 24, 4, 240, 0, '0', '0', NULL),
(1879, 3, '09906020', '3222', '', '', 'ABRIL 2021', 'HON-3168', 219, 1, 6, 3, 24, 4, 1800, 0, '0', '0', NULL),
(1878, 3, '09906004', '3222', '', '', 'ABRIL 2021', 'HON-3168', 219, 9, 11, 3, 24, 4, 1800, 1800, '0', '0', NULL),
(1877, 3, '09906000', '3222', '', '', 'ABRIL 2021', 'HON-3185', 219, 3, 3, 3, 24, 4, 240, 0, '0', '0', NULL),
(1876, 3, '09906034', '3222', '', '', 'ABRIL 2021', 'HON-3168', 181, 2, 1, 6, 20, 4, 2400, 0, '0', '0', NULL),
(1875, 3, '09906018', '3222', '', '', 'ABRIL 2021', 'HON-3160', 181, 22, 34, 6, 20, 4, 640, 640, '0', '0', NULL),
(1874, 3, '09906016', '3222', '', '', 'ABRIL 2021', 'HON-3168', 181, 31, 4, 6, 20, 4, 2400, 2400, '0', '0', NULL),
(1873, 3, '09906014', '3222', '', '', 'ABRIL 2021', 'HON-3168', 181, 4, 14, 6, 20, 4, 2400, 0, '0', '0', NULL),
(1872, 3, '09906012', '3222', '', '', 'ABRIL 2021', 'HON-3165', 181, 4, 2, 6, 20, 4, 1760, 1760, '0', '0', NULL),
(1870, 3, '12003018', '3222', '', '', 'ABRIL 2021', 'HON-3149', 133, 9, 11, 2, 11, 1, 2000, 2000, '0', '0', NULL),
(1869, 3, '12003018', '3222', '', '', 'ABRIL 2021', 'HON-3149', 133, 9, 11, 2, 11, 1, 3000, 0, '0', '0', NULL),
(1868, 3, '12005003', '3222', '', '', 'ABRIL 2021', 'HON-3149', 133, 9, 11, 2, 7, 1, 4000, 0, '0', '0', NULL),
(1867, 3, '12004000', '3222', '', '', 'ABRIL 2021', 'HON-3149', 133, 4, 2, 2, 7, 1, 2000, 2000, '0', '0', NULL),
(1866, 3, '12004001', '3222', '', '', 'ABRIL 2021', 'HON-3149', 133, 4, 2, 5, 7, 1, 2000, 0, '0', '0', NULL),
(1865, 1, '9900004018', '3222', '', '', 'ABRIL 2021', 'HON-3178', 53, 28, 43, 1, NULL, 1, 2400, 2400, '0', '0', NULL),
(1864, 1, '12403100', '3222', '', '', 'ABRIL 2021', 'HON-3152', 1125, 3, 2, 6, 7, 1, 2000, 2000, '0', '0', NULL),
(1863, 1, '00504092', '3222', '', '', 'ABRIL 2021', 'HON-3150', 99, 25, 75, 6, 4, 2, 20000, 20000, '0', '0', NULL),
(1862, 1, '01606673', '3222', '', '', 'ABRIL 2021', 'HON-3150', 40, 25, NULL, 5, 4, 7, 15000, 15000, '0', '0', NULL),
(1861, 1, '00504091', '3222', '', '', 'ABRIL 2021', 'HON-3150', 51, 25, 75, 2, 4, 2, 20000, 20000, '0', '0', NULL),
(1860, 1, '00504090', '3222', '', '', 'ABRIL 2021', 'HON-3150', 51, 25, 75, 5, 4, 2, 20000, 20000, '0', '0', NULL),
(1859, 1, '13105281', '3222', '', '', 'ABRIL 2021', 'HON-3145', 163, 4, 66, 5, 7, 1, 500, 0, '0', '0', NULL),
(1858, 1, '13105280', '3222', '', '', 'ABRIL 2021', 'HON-3145', 163, 2, 65, 5, 7, 1, 500, 0, '0', '0', NULL),
(1857, 1, '12503521', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 9, 39, 1, 10, 1, 3000, 3000, '0', '0', NULL),
(1856, 1, '12503520', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 4, 14, 1, 10, 1, 3000, 3000, '0', '0', NULL),
(1855, 1, '12503519', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 5, 4, 1, 10, 1, 5000, 5000, '0', '0', NULL),
(1854, 1, '12503518', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 1, 1, 1, 10, 1, 3000, 3000, '0', '0', NULL),
(1853, 1, '12503513', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 9, 39, 6, 10, 1, 3000, 3000, '0', '0', NULL),
(1852, 1, '12503512', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 4, 14, 6, 10, 1, 3000, 3000, '0', '0', NULL),
(1851, 1, '12503511', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 5, 4, 6, 10, 1, 6000, 6000, '0', '0', NULL),
(1850, 1, '12503510', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 1, 1, 6, 10, 1, 6000, 6000, '0', '0', NULL),
(1849, 1, '12503503', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 9, 39, 3, 10, 1, 6000, 6000, '0', '0', NULL),
(1848, 1, '12503502', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 4, 14, 3, 10, 1, 3000, 3000, '0', '0', NULL),
(1847, 1, '12503501', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 5, 4, 3, 10, 1, 6000, 6000, '0', '0', NULL),
(1846, 1, '12503500', '3222', '', '', 'ABRIL 2021', 'FTT-1487', 111, 1, 1, 3, 10, 1, 3000, 3000, '0', '0', NULL),
(1845, 1, '01606686', '3222', '', '', 'ABRIL 2021', 'HON-3171', 40, 3, 2, 5, 11, 1, 2500, 2500, '0', '0', NULL),
(1844, 1, '01606674', '3222', '', '', 'ABRIL 2021', 'HON-3167', 40, 3, 2, 5, 7, 1, 6000, 0, '0', '0', NULL),
(1843, 1, '01606676', '3222', '', '', 'ABRIL 2021', 'HON-3167', 40, 2, 1, 5, 7, 1, 1600, 0, '0', '0', NULL),
(1842, 1, '01606675', '3222', '', '', 'ABRIL 2021', 'HON-3167', 40, 20, 30, 5, 7, 1, 4800, 4800, '0', '0', NULL),
(1841, 1, '603005752', '3222', '', '', 'ABRIL 2021', 'HON-3167', 92, 9, 11, 1, 4, 1, 9200, 9200, '0', '0', NULL),
(1840, 1, '00904005', '3222', '', '', 'ABRIL 2021', 'HON-3156', 74, 3, 3, 5, 12, 1, 12500, 0, '0', '0', NULL),
(1839, 1, '603005750', '3222', '', '', 'ABRIL 2021', 'HON-3167', 92, 2, 1, 1, 4, 1, 1400, 1400, '0', '0', NULL),
(1838, 1, '603005751', '3222', '', '', 'ABRIL 2021', 'HON-3167', 92, 4, 2, 1, 4, 1, 2600, 2600, '0', '0', NULL),
(1837, 1, '9900004023', '3222', '', '', 'ABRIL 2021', 'HON-3158', 53, 3, 2, 1, 10, 1, 2000, 2000, '0', '0', NULL),
(1836, 1, '9900009186', '3222', '', '', 'ABRIL 2021', 'HON-3172', 52, 2, 1, 5, 10, 1, 12500, 12500, '0', '0', NULL),
(1835, 1, '9900009186', '3222', '', '', 'ABRIL 2021', 'HON-3172', 90, 1, 6, 3, 10, 1, 12500, 12500, '0', '0', NULL),
(1834, 1, '9900009186', '3222', '', '', 'ABRIL 2021', 'HON-3172', 229, 2, 1, 3, 10, 1, 12500, 12500, '0', '0', NULL),
(1833, 1, '9900009186', '3222', '', '', 'ABRIL 2021', 'HON-3172', 53, 2, 1, 1, 10, 1, 12500, 12500, '0', '0', NULL),
(1832, 1, '9900004039', '3222', '', '', 'ABRIL 2021', 'HON-3157', 229, 2, 1, 3, 10, 1, 3000, 3000, '0', '0', NULL),
(1831, 1, '00508017', '3222', '', '', 'ABRIL 2021', 'HON-3167', 99, 11, 12, 6, 4, 1, 200, 200, '0', '0', NULL),
(1830, 1, '00508022', '3222', '', '', 'ABRIL 2021', 'HON-3167', 91, 9, 11, 10, 7, 1, 1600, 1600, '0', '0', NULL),
(1829, 1, '603004004', '3222', '', '', 'ABRIL 2021', 'HON-3167', 88, 17, 23, 1, 7, 1, 400, 400, '0', '0', NULL),
(1828, 1, '603004002', '3222', '', '', 'ABRIL 2021', 'HON-3167', 88, 4, 3, 1, 7, 1, 1600, 1600, '0', '0', NULL),
(1827, 1, '12506011', '3222', '', '', 'ABRIL 2021', 'HON-3147', 61, 4, 14, 1, 12, 1, 7500, 0, '0', '0', NULL),
(1826, 1, '12506021', '3222', '', '', 'ABRIL 2021', 'HON-3167', 61, 4, 14, 1, 7, 1, 4800, 0, '0', '0', NULL),
(1825, 1, '00508016', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 11, 12, 2, 4, 1, 1400, 1400, '0', '0', NULL),
(1824, 1, '00508015', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 11, 12, 5, 4, 1, 800, 800, '0', '0', NULL),
(1823, 1, '12506010', '3222', '', '', 'ABRIL 2021', 'HON-3147', 61, 4, 2, 1, 12, 1, 12500, 0, '0', '0', NULL),
(1822, 1, '12506020', '3222', '', '', 'ABRIL 2021', 'HON-3167', 61, 4, 2, 1, 7, 1, 5600, 0, '0', '0', NULL),
(1821, 1, '12506001', '3222', '', '', 'ABRIL 2021', 'HON-3167', 61, 4, 2, 1, 18, 1, 16000, 0, '0', '0', NULL),
(1820, 1, '00508011', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 21, 33, 2, 19, 1, 2400, 2400, '0', '0', NULL),
(1819, 1, '00508010', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 21, 33, 5, 19, 1, 7200, 1710, '0', '0', NULL),
(1818, 1, '13105120', '3222', '', '', 'ABRIL 2021', 'HON-3167', 210, 2, 1, 3, 4, 2, 400, 0, '0', '0', NULL),
(1817, 1, '00504150', '3222', '', '', 'ABRIL 2021', 'HON-3167', 51, 4, 2, 15, 7, 1, 2000, 2000, '0', '0', NULL),
(1816, 1, '10104754', '3222', '', '', 'ABRIL 2021', 'HON-3167', 101, 9, 37, 4, 7, 1, 1600, 1600, '0', '0', NULL),
(1815, 1, '10104752', '3222', '', '', 'ABRIL 2021', 'HON-3167', 101, 16, 36, 4, 7, 1, 1600, 1600, '0', '0', NULL),
(1814, 1, '10104751', '3222', '', '', 'ABRIL 2021', 'HON-3167', 101, 3, 35, 4, 7, 1, 7200, 7200, '0', '0', NULL),
(1813, 1, '10104750', '3222', '', '', 'ABRIL 2021', 'HON-3167', 101, 2, 5, 4, 7, 1, 2400, 2400, '0', '0', NULL),
(1812, 1, '50000159', '3222', '', '', 'ABRIL 2021', 'HON-3163', 265, 4, 2, 2, 12, 1, 500, 0, '0', '0', NULL),
(1811, 1, '00405000', '3222', '', '', 'ABRIL 2021', 'HON-3167', 67, 16, 14, 3, 7, 3, 400, 400, '0', '0', NULL),
(1809, 1, '12403007', '3222', '', '', 'ABRIL 2021', 'HON-3154', 66, 22, 34, 6, 7, 1, 200, 200, '0', '0', NULL),
(1808, 1, '12403006', '3222', '', '', 'ABRIL 2021', 'HON-3154', 66, 5, 4, 6, 7, 1, 200, 200, '0', '0', NULL),
(2152, 1, '10104754', '3235', '', '', 'MAYO 2021', 'HON-3196', 101, 9, 37, 4, 7, 1, 800, 800, '0', '0', NULL),
(2153, 1, '00303097', '3235', '', '', 'MAYO 2021', 'HON-3190', 101, 35, 56, 4, 9, 1, 5000, 5000, '0', '0', NULL),
(2154, 3, '09906000', '3235', '', '', 'MAYO 2021', 'HON-3181', 219, 3, 3, 3, 24, 4, 300, 0, '0', '0', NULL),
(2155, 3, '09906004', '3235', '', '', 'MAYO 2021', 'HON-3181', 219, 9, 11, 3, 24, 4, 240, 240, '0', '0', NULL),
(2156, 3, '09906010', '3235', '', '', 'MAYO 2021', 'HON-3181', 181, 9, 11, 6, 20, 4, 2400, 2400, '0', '0', NULL),
(2157, 3, '09906012', '3235', '', '', 'MAYO 2021', 'HON-3181', 181, 4, 2, 6, 20, 4, 800, 800, '0', '0', NULL),
(2158, 3, '09906018', '3235', '', '', 'MAYO 2021', 'HON-3181', 181, 22, 34, 6, 20, 4, 640, 640, '0', '0', NULL),
(2159, 3, '09906039', '3235', '', '', 'MAYO 2021', 'HON-3181', 182, 9, 40, 3, 22, 4, 900, 900, '0', '0', NULL),
(2160, 4, '20005057', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 90, 1, 5, 3, 7, 3, 4400, 4400, '0', '0', NULL),
(2163, 4, '20005002', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 90, 3, 21, 3, 7, 3, 2000, 2000, '0', '0', NULL),
(2169, 4, '603005751', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 92, 4, 2, 1, 4, 1, 4300, 4300, '0', '0', NULL),
(2170, 4, '603005751', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 92, 4, 2, 1, 4, 1, 200, 200, '0', '0', NULL),
(2171, 4, '603005750', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 92, 2, 1, 1, 4, 1, 5600, 5600, '0', '0', NULL),
(2172, 4, '603005750', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 92, 2, 1, 1, 4, 1, 200, 200, '0', '0', NULL),
(2173, 4, '603005752', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 92, 9, 11, 1, 4, 1, 200, 200, '0', '0', NULL),
(2174, 4, '00407000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 158, 15, 46, 9, 15, 1, 5500, 5500, '0', '0', NULL),
(2175, 4, '00107000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 141, 15, 53, 9, 15, 1, 6650, 6650, '0', '0', NULL),
(2176, 4, '00507001', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 159, 15, 62, 6, 15, 1, 11200, 11200, '0', '0', NULL),
(2177, 4, '00231001', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 160, 15, 64, 4, 15, 1, 5900, 5900, '0', '0', NULL),
(2178, 4, '01606675', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 40, 20, 30, 5, 7, 1, 3400, 3400, '0', '0', NULL),
(2179, 4, '01606676', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 40, 2, 1, 5, 7, 1, 7800, 7800, '0', '0', NULL),
(2180, 4, '01606677', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 40, 9, 11, 5, 7, 1, 3320, 3320, '0', '0', NULL),
(2181, 4, '01606677', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 40, 9, 11, 5, 7, 1, 200, 200, '0', '0', NULL),
(2182, 4, '01606674', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 40, 3, 2, 5, 7, 1, 2600, 2600, '0', '0', NULL),
(2183, 4, '01606674', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 40, 3, 2, 5, 7, 1, 200, 200, '0', '0', NULL),
(2185, 4, '01607602', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 95, 3, 2, 11, 7, 1, 700, 700, '0', '0', NULL),
(2186, 4, '01607602', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 95, 3, 2, 11, 7, 1, 200, 200, '0', '0', NULL),
(2187, 4, '01607603', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 95, 9, 11, 11, 7, 1, 1400, 1400, '0', '0', NULL),
(2188, 4, '00401000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 67, 19, 25, 3, 7, 3, 480, 480, '0', '0', NULL),
(2189, 4, '00403000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 67, 2, 1, 3, 7, 3, 4700, 4700, '0', '0', NULL),
(2190, 4, '00403000', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 67, 2, 1, 3, 7, 3, 100, 100, '0', '0', NULL),
(2191, 4, '00404000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 67, 3, 2, 3, 7, 3, 1200, 1200, '0', '0', NULL),
(2192, 4, '00404000', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 67, 3, 2, 3, 7, 3, 200, 200, '0', '0', NULL),
(2193, 4, '00408000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 67, 9, 40, 3, 7, 1, 1100, 1100, '0', '0', NULL),
(2194, 4, '00408000', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 67, 9, 40, 3, 7, 1, 600, 600, '0', '0', NULL),
(2195, 4, '00303007', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 67, 25, 2, 3, 4, 7, 1710, 1710, '0', '0', NULL),
(2196, 4, '00405000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 67, 16, 14, 3, 7, 3, 300, 300, '0', '0', NULL),
(2197, 4, '01607603', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 95, 9, 11, 11, 7, 1, 400, 400, '0', '0', NULL),
(2200, 4, '00504006', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 5, 18, 3, 1600, 1600, '0', '0', NULL),
(2201, 4, '00504006', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 51, 4, 2, 5, 18, 3, 200, 200, '0', '0', NULL),
(2202, 4, '00504002', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 5, 7, 1, 3000, 3000, '0', '0', NULL),
(2203, 4, '00504007', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 2, 18, 3, 3100, 3100, '0', '0', NULL),
(2204, 4, '00504003', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 2, 7, 3, 2900, 2900, '0', '0', NULL),
(2205, 4, '00504100', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 2, 1, 5, 7, 1, 3360, 3360, '0', '0', NULL),
(2206, 4, '00504101', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 2, 1, 2, 7, 1, 4460, 4460, '0', '0', NULL),
(2207, 4, '00605002', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 14, 17, 5, 13, 3, 1000, 1000, '0', '0', NULL),
(2208, 4, '00605003', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 14, 17, 2, 13, 3, 500, 500, '0', '0', NULL),
(2210, 4, '00508001', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 9, 32, 2, 7, 3, 1900, 1900, '0', '0', NULL),
(2211, 4, '00508001', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 51, 9, 32, 2, 7, 3, 200, 200, '0', '0', NULL),
(2214, 4, '00503009', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 6, 43, 5, 7, 1, 200, 200, '0', '0', NULL),
(2215, 4, '00504150', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 4, 2, 15, 7, 1, 4400, 4400, '0', '0', NULL),
(2216, 4, '00508010', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 21, 33, 5, 19, 1, 6120, 6120, '0', '0', NULL),
(2217, 4, '00508010', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 51, 21, 33, 5, 19, 1, 900, 900, '0', '0', NULL),
(2218, 4, '00508011', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 21, 33, 2, 19, 1, 3150, 3150, '0', '0', NULL),
(2219, 4, '00508011', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 51, 21, 33, 2, 19, 1, 600, 600, '0', '0', NULL),
(2220, 4, '00508015', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 11, 12, 5, 4, 1, 300, 300, '0', '0', NULL),
(2221, 4, '00508016', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 51, 11, 12, 2, 4, 1, 400, 400, '0', '0', NULL),
(2222, 4, '00703003', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 99, 2, 1, 6, 7, 1, 3500, 3500, '0', '0', NULL),
(2223, 4, '00704003', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 99, 4, 2, 6, 7, 1, 2400, 2400, '0', '0', NULL),
(2224, 4, '00508002', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 99, 9, 11, 6, 7, 1, 400, 400, '0', '0', NULL),
(2225, 4, '00702000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 99, 33, 30, 6, 7, 1, 3500, 3500, '0', '0', NULL),
(2227, 4, '12506001', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 61, 4, 2, 1, 18, 1, 800, 800, '0', '0', NULL),
(2228, 4, '12506020', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 61, 4, 2, 1, 7, 1, 15400, 15400, '0', '0', NULL),
(2229, 4, '00508003', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 61, 9, 11, 1, 7, 1, 2200, 2200, '0', '0', NULL),
(2230, 4, '12506021', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 61, 4, 14, 1, 7, 1, 1100, 1100, '0', '0', NULL),
(2232, 4, '10104224', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 3, 35, 2, 7, 1, 1000, 1000, '0', '0', NULL),
(2233, 4, '10104200', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 2, 6, 2, 7, 1, 9360, 9360, '0', '0', NULL),
(2235, 4, '10104207', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 15, 9, 37, 2, 7, 1, 2000, 2000, '0', '0', NULL),
(2236, 4, '10104181', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 6, 9, 2, 7, 1, 400, 400, '0', '0', NULL),
(2237, 4, '10104201', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 3, 3, 2, 7, 1, 1400, 1400, '0', '0', NULL),
(2238, 4, '10104202', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 16, 21, 2, 7, 1, 1000, 1000, '0', '0', NULL),
(2239, 4, '10104207', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 15, 9, 37, 2, 7, 1, 200, 200, '0', '0', NULL),
(2240, 4, '00303050', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 25, 35, 2, 4, 1, 1040, 1040, '0', '0', NULL),
(2241, 4, '10104199', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 2, 5, 2, 7, 1, 3600, 3600, '0', '0', NULL),
(2242, 4, '00303063', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 2, 5, 2, 10, 1, 5000, 5000, '0', '0', NULL),
(2243, 4, '10104228', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 15, 5, 38, 2, 7, 1, 840, 840, '0', '0', NULL),
(2246, 4, '00302001', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 2, 1, 6, 7, 1, 30900, 30900, '0', '0', NULL),
(2247, 4, '00303065', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 2, 1, 6, 10, 1, 5000, 5000, '0', '0', NULL),
(2248, 4, '00302002', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 19, 25, 6, 7, 1, 5300, 5300, '0', '0', NULL),
(2249, 4, '00302004', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 44, 61, 6, 7, 1, 4200, 4200, '0', '0', NULL),
(2250, 4, '00302000', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 27, 30, 6, 7, 1, 3000, 3000, '0', '0', NULL),
(2251, 4, '00302007', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 3, 2, 6, 7, 1, 4800, 4800, '0', '0', NULL),
(2252, 4, '00302005', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 16, 14, 6, 7, 1, 400, 400, '0', '0', NULL),
(2253, 4, '00302009', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 9, 11, 6, 7, 1, 3100, 3100, '0', '0', NULL),
(2255, 4, '00303052', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 25, 35, 6, 4, 7, 1720, 1720, '0', '0', NULL),
(2256, 4, '00302008', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 86, 6, 8, 6, 7, 1, 2600, 2600, '0', '0', NULL),
(2257, 4, '10104750', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 101, 2, 5, 4, 7, 1, 5720, 5720, '0', '0', NULL),
(2258, 4, '10104774', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 101, 2, 5, 4, 10, 1, 5000, 5000, '0', '0', NULL),
(2259, 4, '10104751', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 101, 3, 35, 4, 7, 1, 1300, 1300, '0', '0', NULL),
(2260, 4, '10104751', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 101, 3, 35, 4, 7, 1, 200, 200, '0', '0', NULL),
(2261, 4, '10104752', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 101, 16, 36, 4, 7, 1, 400, 400, '0', '0', NULL),
(2262, 4, '10104754', '3235', '', '', 'MAYO 2021', 'INT-H-1244-W', 101, 9, 37, 4, 7, 1, 2220, 2220, '0', '0', NULL),
(2263, 4, '10104754', '3235', '', '', 'MAYO 2021', 'INT-H-1246', 101, 9, 37, 4, 7, 1, 200, 200, '0', '0', NULL),
(1682, 2, '10499010', '3222', ' ', ' ', 'ABRIL 2021', 'FTT-1484', 177, 4, 2, 0, 25, 1, 0, 0, '0', '0', NULL),
(1662, 2, '19903027', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3164', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL),
(1663, 2, '19903027', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3164', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL),
(1664, 2, '19903027', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3164', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL),
(1652, 2, '19903027', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3161', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL),
(1653, 2, '19903027', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3161', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL),
(1654, 2, '19903027', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3161', 86, 2, 1, 6, 9, 1, 0, 3000, '0', '0', NULL),
(1985, 1, '10104940', '3235', ' ', ' ', 'MAYO 2021', 'HON-3196', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL),
(1986, 1, '10104940', '3235', ' ', ' ', 'MAYO 2021', 'HON-3196', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL),
(1987, 1, '10104940', '3235', ' ', ' ', 'MAYO 2021', 'HON-3196', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL),
(1795, 1, '10104940', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3179', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL),
(1796, 1, '10104940', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3179', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL),
(1797, 1, '10104940', '3222', ' ', ' ', 'ABRIL 2021', 'HON-3179', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL),
(1995, 1, '10104940', '3235', ' ', ' ', 'MAYO 2021', 'HON-3179', 15, 2, 1, 2, 9, 1, 0, 0, '0', '0', NULL),
(1996, 1, '10104940', '3235', ' ', ' ', 'MAYO 2021', 'HON-3179', 14, 2, 1, 3, 9, 1, 0, 0, '0', '0', NULL),
(1997, 1, '10104940', '3235', ' ', ' ', 'MAYO 2021', 'HON-3179', 86, 2, 1, 6, 9, 1, 0, 0, '0', '0', NULL),
(2722, 1, '00508017', '3217', ' ', ' ', 'MARZO 2021', 'HON-3142', 99, 11, 12, 6, 4, 1, 200, 0, '0', '0', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prograamacion`
--

DROP TABLE IF EXISTS `prograamacion`;
CREATE TABLE IF NOT EXISTS `prograamacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `mes_contenedor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `prograamacion`
--

INSERT INTO `prograamacion` (`id`, `fecha`, `mes_contenedor`) VALUES
(1, '2021-06-09', 'segundo contenedor de junio 2021'),
(2, '2021-06-06', 'factura aerea junio 2021');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `saldos_actuales`
--

DROP TABLE IF EXISTS `saldos_actuales`;
CREATE TABLE IF NOT EXISTS `saldos_actuales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pendiente` int(11) DEFAULT NULL,
  `saldo_pendiente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabla_codigo_programacions`
--

DROP TABLE IF EXISTS `tabla_codigo_programacions`;
CREATE TABLE IF NOT EXISTS `tabla_codigo_programacions` (
  `codigo` varchar(50) DEFAULT NULL,
  `presentacion` varchar(50) DEFAULT NULL,
  `marca` int(11) DEFAULT NULL,
  `nombre` int(11) DEFAULT NULL,
  `vitola` int(11) DEFAULT NULL,
  `capa` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tabla_codigo_programacions`
--

INSERT INTO `tabla_codigo_programacions` (`codigo`, `presentacion`, `marca`, `nombre`, `vitola`, `capa`, `updated_at`, `created_at`) VALUES
('P-00256', 'Puros Tripa Larga', 286, 1, 1, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-00257', 'Puros Tripa Larga', 286, 2, 25, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-00258', 'Puros Tripa Larga', 286, 14, 248, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-00261', 'Puros Tripa Larga', 286, 4, 13, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-01308', 'Puros Tripa Larga', 99, 14, 4, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-01314', 'Puros Tripa Larga', 141, 53, 15, 9, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02000', 'Puros Tripa Larga', 51, 2, 4, 5, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02001', 'Puros Tripa Larga', 51, 2, 4, 2, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('p-02002', 'Puros Tripa Larga', 51, 14, 4, 5, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02003', 'Puros Tripa Larga', 51, 14, 4, 2, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02004', 'Puros Tripa Larga', 51, 1, 2, 5, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02005', 'Puros Tripa Larga', 51, 1, 2, 2, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('p-02010', 'Puros Tripa Larga', 51, 17, 14, 5, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02011', 'Puros Tripa Larga', 51, 17, 14, 2, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02016', 'Puros Tripa Larga', 51, 32, 9, 5, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('p-02017', 'Puros Tripa Larga', 51, 32, 9, 2, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02018', 'Puros Tripa Larga', 51, 34, 22, 5, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02019', 'Puros Tripa Larga', 51, 34, 22, 2, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02020', 'Puros Tripa Larga', 51, 2, 4, 3, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02021', 'Puros Tripa Larga', 51, 14, 4, 3, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02024', 'Puros Tripa Larga', 99, 1, 2, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02025', 'Puros Tripa Larga', 99, 34, 22, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02028', 'Puros Tripa Larga', 99, 2, 4, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02029', 'Puros Tripa Larga', 90, 35, 3, 3, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02031', 'Puros Tripa Larga', 99, 11, 9, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02032', 'Puros Tripa Larga', 67, 25, 19, 3, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02033', 'Puros Tripa Larga', 67, 1, 2, 3, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02034', 'Puros Tripa Larga', 67, 2, 3, 3, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02040', 'Puros Tripa Larga', 67, 40, 9, 3, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02042', 'Puros Tripa Larga', 59, 73, 43, 18, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02047', 'Puros Tripa Larga', 59, 68, 38, 2, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02095', 'Puros Tripa Larga', 168, 1, 2, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02096', 'Puros Tripa Larga', 168, 2, 4, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02097', 'Puros Tripa Larga', 168, 14, 3, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02098', 'Puros Tripa Larga', 168, 4, 5, 6, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02147', 'Puros Tripa Larga', 186, 3, 3, 2, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02161', 'Puros Tripa Larga', 62, 18, 15, 3, '2021-05-04 13:40:26', '2021-05-04 13:40:26'),
('P-02162', 'Puros Tripa Larga', 158, 46, 15, 9, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02179', 'Puros Tripa Larga', 109, 41, 24, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02180', 'Puros Tripa Larga', 109, 57, 38, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02191', 'Puros Tripa Larga', 108, 1, 2, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02220', 'Puros Tripa Larga', 135, 2, 3, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02266', 'Puros Tripa Larga', 211, 4, 13, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02277', 'Puros Tripa Larga', 133, 2, 4, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02337', 'Puros Tripa Larga', 90, 6, 1, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02338', 'Puros Tripa Larga', 90, 21, 3, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02339', 'Puros Tripa Larga', 90, 3, 3, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02341', 'Puros Tripa Larga', 90, 52, 34, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02342', 'Puros Tripa Larga', 90, 26, 9, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02368', 'Puros Tripa Larga', 167, 2, 4, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02371', 'Puros Tripa Larga', 107, 2, 3, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02397', 'Puros Tripa Larga', 159, 62, 15, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02406', 'Puros Tripa Larga', 66, 1, 2, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02407', 'Puros Tripa Larga', 66, 2, 3, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02408', 'Puros Tripa Larga', 66, 14, 3, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02433', 'Puros Tripa Larga', 67, 2, 25, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02494', 'Puros Tripa Larga', 90, 44, 6, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02501', 'Puros Tripa Larga', 86, 1, 2, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02502', 'Puros Tripa Larga', 86, 25, 19, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02505', 'Puros Tripa Larga', 86, 30, 27, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02561', 'Puros Tripa Larga', 147, 51, 5, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02563', 'Puros Tripa Larga', 147, 21, 16, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02693', 'Puros Tripa Larga', 106, 2, 4, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02695', 'Puros Tripa Larga', 106, 1, 1, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02696', 'Puros Tripa Larga', 106, 30, 23, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02924', 'Puros Tripa Larga', 67, 14, 16, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02937', 'Puros Tripa Larga', 99, 4, 31, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02980', 'Puros Tripa Larga', 51, 43, 6, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02986', 'Puros Tripa Larga', 15, 9, 6, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-02993', 'Puros Tripa Larga', 15, 35, 25, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-03169', 'Puros Tripa Larga', 186, 3, 3, 5, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-03201', 'Puros Tripa Larga', 101, 5, 2, 4, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-03202', 'Puros Tripa Larga', 101, 35, 3, 4, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-03204', 'Puros Tripa Larga', 101, 37, 9, 4, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-03205', 'Puros Tripa Larga', 101, 38, 5, 4, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-03320', 'Puros Tripa Larga', 14, 58, 33, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-12651', 'Puros Tripa Larga', 601, 111, 9, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-14193', 'Puros Tripa Larga', 1066, 1, 1, 46, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22006', 'Puros Tripa Larga', 99, 30, 33, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22012', 'Puros Tripa Larga', 90, 9, 6, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22023', 'Puros Tripa Larga', 86, 8, 6, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22025', 'Puros Tripa Larga', 67, 8, 6, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22038', 'Puros Tripa Larga', 188, 0, 2, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22046', 'Puros Tripa Larga', 188, 2, 4, 5, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22060', 'Puros Tripa Larga', 72, 2, 4, 5, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22062', 'Puros Tripa Larga', 72, 2, 4, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22078', 'Puros Tripa Larga', 51, 2, 4, 15, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22157', 'Puros Tripa Larga', 210, 1, 2, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22167', 'Puros Tripa Larga', 160, 64, 15, 4, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22247', 'Puros Tripa Larga', 51, 33, 21, 5, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22248', 'Puros Tripa Larga', 51, 33, 21, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22251', 'Puros Tripa Larga', 61, 2, 4, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22263', 'Puros Tripa Larga', 61, 11, 9, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22264', 'Puros Tripa Larga', 72, 11, 9, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22288', 'Puros Tripa Larga', 51, 12, 11, 5, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22289', 'Puros Tripa Larga', 51, 12, 11, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22300', 'Puros Tripa Larga', 61, 14, 4, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22341', 'Puros Tripa Larga', 104, 2, 4, 12, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22359', 'Puros Tripa Larga', 105, 2, 4, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22360', 'Puros Tripa Larga', 105, 14, 4, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22368', 'Puros Tripa Larga', 91, 2, 4, 10, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22370', 'Puros Tripa Larga', 113, 1, 1, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22425', 'Puros Tripa Corta', 103, 2, 4, 5, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22489', 'Puros Tripa Corta', 115, 30, 27, 5, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22492', 'Puros Tripa Corta', 115, 14, 4, 5, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22503', 'Puros Tripa Larga', 138, 48, 15, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22510', 'Puros Tripa Larga', 136, 46, 15, 9, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22516', 'Puros Tripa Larga', 88, 63, 26, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22536', 'Puros Tripa Larga', 88, 23, 17, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22538', 'Puros Tripa Corta', 103, 2, 4, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22539', 'Puros Tripa Larga', 88, 44, 64, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22570', 'Puros Tripa Larga', 110, 16, 9, 4, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22592', 'Puros Tripa Larga', 168, 69, 9, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22597', 'Puros Tripa Larga', 188, 110, 2, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22602', 'Puros Tripa Larga', 139, 1, 1, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22611', 'Puros Tripa Corta', 153, 1, 1, 4, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22612', 'Puros Tripa Corta', 153, 2, 4, 4, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22620', 'Puros Tripa Larga', 91, 11, 9, 10, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22621', 'Puros Tripa Larga', 99, 12, 11, 6, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22622', 'Puros Tripa Larga', 113, 2, 4, 1, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22626', 'Puros Tripa Larga', 15, 3, 4, 2, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22627', 'Puros Tripa Larga', 147, 3, 4, 3, '2021-05-04 13:40:27', '2021-05-04 13:40:27'),
('P-22648', 'Puros Tripa Larga', 182, 40, 9, 3, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-22663', 'Puros Tripa Corta', 653, 14, 4, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-22694', 'Puros Tripa Larga', 684, 2, 4, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-22732', 'Puros Tripa Larga', 152, 1, 2, 8, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-22734', 'Puros Tripa Larga', 152, 69, 9, 8, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-22739', 'Puros Tripa Larga', 152, 4, 5, 8, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-22928', 'Puros Tripa Corta', 149, 2, 4, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-22932', 'Puros Tripa Corta', 165, 2, 4, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-22993', 'Puros Tripa Larga', 183, 14, 16, 3, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23019', 'Puros Tripa Larga', 87, 2, 3, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23024', 'Puros Tripa Corta', 112, 2, 4, 2, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23072', 'Puros Tripa Larga', 56, 1, 2, 3, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23191', 'Puros Tripa Larga', 152, 2, 4, 8, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23215', 'Puros Tripa Larga', 53, 2, 3, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23217', 'Puros Tripa Corta', 50, 2, 4, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23218', 'Puros Tripa Corta', 50, 2, 4, 2, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23219', 'Puros Tripa Corta', 146, 2, 4, 3, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23221', 'Puros Tripa Corta', 146, 4, 31, 3, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23223', 'Puros Tripa Corta', 149, 4, 5, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23224', 'Puros Tripa Corta', 112, 2, 4, 3, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23228', 'Puros Tripa Corta', 103, 2, 4, 3, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23229', 'Puros Tripa Corta', 103, 2, 4, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23232', 'Puros Tripa Larga', 144, 54, 4, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23233', 'Puros Tripa Larga', 144, 54, 4, 2, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23264', 'Puros Tripa Larga', 93, 16, 9, 2, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23360', 'Puros Tripa Larga', 116, 2, 4, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23361', 'Puros Tripa Larga', 116, 2, 4, 2, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23375', 'Puros Tripa Corta', 189, 1, 1, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23376', 'Puros Tripa Larga', 92, 2, 4, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23377', 'Puros Tripa Larga', 92, 1, 2, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23394', 'Puros Tripa Corta', 166, 1, 1, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23395', 'Puros Tripa Corta', 166, 2, 4, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23402', 'Puros Tripa Larga', 151, 2, 4, 15, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23411', 'Puros Tripa Larga', 74, 6, 18, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23412', 'Puros Tripa Larga', 74, 3, 3, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23429', 'Puros Tripa Larga', 57, 1, 2, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23431', 'Puros Tripa Larga', 57, 16, 9, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23432', 'Puros Tripa Larga', 92, 11, 9, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23555', 'Puros Tripa Larga', 188, 1, 2, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23566', 'Puros Tripa Corta', 60, 1, 1, 8, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23567', 'Puros Tripa Corta', 60, 2, 4, 8, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23568', 'Puros Tripa Larga', 87, 1, 2, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23626', 'Puros Tripa Larga', 95, 30, 20, 11, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23627', 'Puros Tripa Larga', 95, 1, 2, 11, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23628', 'Puros Tripa Larga', 95, 2, 3, 11, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23629', 'Puros Tripa Larga', 95, 11, 9, 11, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23635', 'Puros Tripa Larga', 95, 31, 5, 11, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23691', 'Puros Tripa Larga', 40, 30, 20, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23692', 'Puros Tripa Larga', 40, 1, 2, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23693', 'Puros Tripa Larga', 40, 11, 9, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23694', 'Puros Tripa Larga', 40, 2, 3, 5, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23759', 'Puros Tripa Larga', 56, 11, 9, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23767', 'Puros Tripa Larga', 111, 1, 1, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23768', 'Puros Tripa Larga', 111, 4, 5, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23769', 'Puros Tripa Larga', 111, 14, 4, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23770', 'Puros Tripa Larga', 111, 39, 9, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23771', 'Puros Tripa Larga', 111, 1, 1, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23772', 'Puros Tripa Larga', 111, 4, 5, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23773', 'Puros Tripa Larga', 111, 14, 4, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23774', 'Puros Tripa Larga', 111, 39, 9, 1, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-23802', 'Puros Tripa Larga', 52, 13, 12, 3, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-02207', 'Puros Tripa Larga', 132, 1, 2, 6, '2021-05-04 13:40:28', '2021-05-04 13:40:28'),
('P-02219', 'Puros Tripa Larga', 135, 1, 2, 3, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02272', 'Puros Tripa Larga', 211, 1, 1, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02273', 'Puros Tripa Larga', 133, 1, 2, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02274', 'Puros Tripa Larga', 133, 1, 2, 5, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02395', 'Puros Tripa Larga', 64, 1, 1, 1, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02401', 'Puros Tripa Larga', 65, 1, 1, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02481', 'Puros Tripa Larga', 133, 11, 9, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02509', 'Puros Tripa Larga', 86, 11, 9, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02611', 'Puros Tripa Larga', 181, 11, 9, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02616', 'Puros Tripa Larga', 181, 1, 2, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-02913', 'Puros Tripa Larga', 63, 1, 1, 1, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-03193', 'Puros Tripa Larga', 147, 11, 9, 3, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-03203', 'Puros Tripa Larga', 101, 36, 16, 4, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22061', 'Puros Tripa Larga', 72, 2, 4, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22193', 'Puros Tripa Larga', 162, 11, 9, 5, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22194', 'Puros Tripa Larga', 162, 11, 9, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22419', 'Puros Tripa Corta', 176, 2, 4, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22426', 'Puros Tripa Corta', 103, 2, 4, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22634', 'Puros Tripa Larga', 650, 14, 4, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22640', 'Puros Tripa Larga', 231, 1, 2, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22642', 'Puros Tripa Larga', 231, 11, 9, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22673', 'Puros Tripa Larga', 117, 43, 28, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22678', 'Puros Tripa Larga', 140, 1, 1, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22685', 'Puros Tripa Larga', 220, 1, 8, 13, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22797', 'Puros Tripa Larga', 56, 2, 4, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22870', 'Puros Tripa Larga', 229, 1, 2, 3, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-22871', 'Puros Tripa Larga', 229, 2, 3, 3, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23066', 'Puros Tripa Larga', 53, 1, 2, 1, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23234', 'Puros Tripa Larga', 144, 54, 4, 1, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23235', 'Puros Tripa Larga', 144, 55, 4, 1, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23248', 'Puros Tripa Larga', 94, 16, 9, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23249', 'Puros Tripa Larga', 94, 1, 2, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23250', 'Puros Tripa Larga', 94, 2, 25, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23366', 'Puros Tripa Larga', 116, 2, 4, 18, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23393', 'Puros Tripa Corta', 166, 2, 4, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23396', 'Puros Tripa Larga', 56, 2, 4, 3, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23430', 'Puros Tripa Larga', 57, 14, 3, 1, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23560', 'Puros Tripa Larga', 72, 1, 2, 5, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23561', 'Puros Tripa Larga', 72, 1, 2, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23697', 'Puros Tripa Larga', 164, 2, 4, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23698', 'Puros Tripa Larga', 164, 1, 1, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23700', 'Puros Tripa Larga', 164, 2, 4, 3, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23701', 'Puros Tripa Larga', 164, 2, 4, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23702', 'Puros Tripa Larga', 164, 1, 1, 6, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23708', 'Puros Tripa Corta', 227, 1, 1, 2, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23727', 'Puros Tripa Larga', 111, 1, 1, 3, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23730', 'Puros Tripa Larga', 111, 39, 9, 3, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23758', 'Puros Tripa Larga', 213, 2, 4, 9, '2021-05-04 13:40:29', '2021-05-04 13:40:29'),
('P-23813', 'Puros Tripa Larga', 143, 1, 2, 6, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23819', 'Puros Tripa Larga', 163, 65, 2, 5, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23820', 'Puros Tripa Larga', 163, 66, 4, 5, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23823', 'Puros Tripa Larga', 51, 2, 25, 5, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23824', 'Puros Tripa Larga', 51, 2, 25, 2, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23825', 'Puros Tripa Larga', 40, 2, 25, 5, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23826', 'Puros Tripa Larga', 99, 2, 25, 6, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23830', 'Puros Tripa Larga', 53, 152, 26, 1, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23831', 'Puros Tripa Larga', 51, 80, 18, 3, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23833', 'Puros Tripa Larga', 61, 24, 18, 1, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-00272', 'Puros Brocha', 1136, 81, 352, 1, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-02012', 'Puros Tripa Larga', 51, 24, 18, 5, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-02045', 'Puros Tripa Larga', 59, 3, 4, 2, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-02192', 'Puros Tripa Larga', 108, 14, 4, 6, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-02260', 'Puros Tripa Larga', 184, 6, 24, 2, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-02410', 'Puros Tripa Larga', 66, 34, 22, 6, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-02532', 'Puros Tripa Larga', 68, 51, 5, 3, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-11984', 'Puros Brocha', 439, 83, 352, 23, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-11985', 'Puros Brocha', 439, 0, 352, 23, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-11986', 'Puros Brocha', 439, 0, 352, 23, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-11987', 'Puros Brocha', 439, 0, 352, 23, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-11988', 'Puros Brocha', 439, 0, 352, 23, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-11989', 'Puros Brocha', 439, 107, 352, 23, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-12278', 'Puros Brocha', 439, 0, 352, 23, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-22601', 'Puros Tripa Larga', 139, 2, 4, 6, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-22603', 'Puros Tripa Larga', 139, 39, 9, 6, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-22832', 'Puros Tripa Larga', 228, 2, 3, 1, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23194', 'Puros Tripa Larga', 88, 23, 17, 13, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23263', 'Puros Tripa Larga', 93, 27, 3, 2, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-23413', 'Puros Tripa Larga', 74, 29, 9, 5, '2021-05-04 13:40:30', '2021-05-04 13:40:30'),
('P-02041', 'Puros Tripa Larga', 59, 6, 1, 18, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02077', 'Puros Tripa Larga', 55, 45, 29, 6, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02209', 'Puros Tripa Larga', 132, 2, 4, 6, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02252', 'Puros Tripa Larga', 15, 6, 2, 2, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02381', 'Puros Tripa Larga', 107, 69, 38, 6, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02382', 'Puros Tripa Larga', 107, 69, 38, 5, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02488', 'Puros Tripa Larga', 90, 102, 28, 3, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02507', 'Puros Tripa Larga', 86, 2, 3, 6, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02530', 'Puros Tripa Larga', 68, 6, 1, 3, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02533', 'Puros Tripa Larga', 68, 20, 4, 3, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02614', 'Puros Tripa Larga', 181, 4, 31, 6, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02615', 'Puros Tripa Larga', 181, 34, 22, 6, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02640', 'Puros Tripa Larga', 1398, 14, 17, 2, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02645', 'Puros Tripa Larga', 1398, 1, 18, 5, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02783', 'Puros Tripa Larga', 211, 14, 3, 6, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02987', 'Puros Tripa Larga', 15, 3, 3, 2, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-02998', 'Puros Tripa Larga', 14, 78, 33, 3, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-11157', 'Puros Tripa Larga', 188, 30, 386, 1, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-11215', 'Puros Tripa Larga', 188, 0, 26, 1, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22026', 'Puros Tripa Larga', 90, 102, 6, 3, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22052', 'Puros Tripa Larga', 188, 2, 4, 6, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22080', 'Puros Tripa Larga', 14, 84, 19, 3, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22158', 'Puros Tripa Larga', 14, 61, 44, 3, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22188', 'Puros Tripa Larga', 51, 67, 6, 3, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22325', 'Puros Tripa Larga', 61, 1, 2, 1, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22361', 'Puros Tripa Larga', 105, 11, 9, 1, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22371', 'Puros Tripa Larga', 113, 2, 3, 1, '2021-05-04 13:40:31', '2021-05-04 13:40:31'),
('P-22502', 'Puros Tripa Larga', 75, 22, 15, 9, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-22517', 'Puros Tripa Larga', 88, 44, 64, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-22593', 'Puros Tripa Larga', 88, 6, 1, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-22679', 'Puros Tripa Larga', 140, 4, 5, 6, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-22680', 'Puros Tripa Larga', 140, 14, 16, 6, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-22698', 'Puros Tripa Corta', 58, 4, 13, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-22781', 'Puros Tripa Larga', 51, 1, 2, 3, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23023', 'Puros Tripa Corta', 112, 1, 1, 2, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23388', 'Puros Tripa Larga', 209, 21, 17, 2, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23392', 'Puros Tripa Corta', 166, 1, 1, 2, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23398', 'Puros Tripa Larga', 13, 4, 5, 6, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23401', 'Puros Tripa Larga', 13, 2, 4, 6, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23406', 'Puros Tripa Larga', 13, 2, 4, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23423', 'Puros Tripa Larga', 53, 43, 28, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23433', 'Puros Tripa Larga', 943, 2, 4, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23583', 'Puros Tripa Larga', 953, 2, 4, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23625', 'Puros Tripa Larga', 761, 11, 9, 5, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23699', 'Puros Tripa Larga', 164, 1, 1, 3, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23704', 'Puros Tripa Larga', 188, 42, 26, 3, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23705', 'Puros Tripa Larga', 188, 42, 26, 2, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23706', 'Puros Tripa Corta', 227, 1, 1, 5, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23707', 'Puros Tripa Corta', 227, 2, 4, 5, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23713', 'Puros Tripa Corta', 227, 1, 1, 6, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23714', 'Puros Tripa Corta', 227, 2, 4, 6, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23715', 'Puros Tripa Corta', 227, 1, 1, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23716', 'Puros Tripa Corta', 227, 2, 4, 1, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23728', 'Puros Tripa Larga', 111, 4, 5, 3, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23729', 'Puros Tripa Larga', 111, 14, 4, 3, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23815', 'Puros Tripa Larga', 143, 4, 5, 6, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23816', 'Puros Tripa Larga', 143, 16, 9, 6, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23817', 'Puros Tripa Larga', 188, 30, 386, 2, '2021-05-04 13:40:32', '2021-05-04 13:40:32'),
('P-23818', 'Puros Tripa Larga', 188, 30, 386, 6, '2021-05-04 13:40:33', '2021-05-04 13:40:33'),
('P-02151', 'Puros Tripa Larga', 186, 21, 17, 2, '2021-05-04 13:40:33', '2021-05-04 13:40:33'),
('P-02197', 'Puros Tripa Larga', 14, 3, 3, 3, '2021-05-04 13:40:33', '2021-05-04 13:40:33'),
('P-02414', 'Puros Tripa Larga', 191, 1, 17, 4, '2021-05-04 13:40:33', '2021-05-04 13:40:33'),
('P-02432', 'Puros Tripa Larga', 67, 4, 31, 3, '2021-05-04 13:40:33', '2021-05-04 13:40:33'),
('P-02503', 'Puros Tripa Larga', 86, 61, 44, 6, '2021-05-04 13:40:33', '2021-05-04 13:40:33'),
('P-02508', 'Puros Tripa Larga', 86, 14, 16, 6, '2021-05-04 13:40:33', '2021-05-04 13:40:33'),
('P-02815', 'Puros Tripa Larga', 86, 35, 25, 6, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-11503', 'Puros Tripa Larga', 188, 0, 9, 3, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-11928', 'Puros Tripa Larga', 188, 0, 64, 1, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-13520', 'Puros Tripa Larga', 859, 1, 1, 54, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-13554', 'Puros Tripa Larga', 858, 112, 471, 53, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-13562', 'Puros Tripa Larga', 859, 2, 247, 54, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22005', 'Puros Tripa Larga', 99, 114, 14, 6, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22040', 'Puros Tripa Larga', 188, 115, 4, 1, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22067', 'Puros Tripa Larga', 188, 115, 9, 1, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22343', 'Puros Tripa Larga', 104, 11, 9, 12, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22376', 'Puros Tripa Larga', 535, 14, 3, 4, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22478', 'Puros Tripa Larga', 186, 14, 17, 6, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22595', 'Puros Tripa Larga', 61, 43, 6, 1, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22617', 'Puros Tripa Larga', 1385, 2, 16, 6, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22675', 'Puros Tripa Larga', 117, 40, 9, 2, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-22796', 'Puros Tripa Larga', 56, 1, 2, 6, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-23054', 'Puros Tripa Larga', 778, 11, 9, 1, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-23175', 'Puros Sandwich', 654, 2, 3, 5, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-23176', 'Puros Sandwich', 654, 14, 4, 5, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-23415', 'Puros Tripa Larga', 144, 145, 4, 3, '2021-05-04 13:40:34', '2021-05-04 13:40:34'),
('P-23565', 'Puros Tripa Corta', 951, 4, 5, 2, '2021-05-04 13:40:35', '2021-05-04 13:40:35'),
('P-23595', 'Puros Tripa Larga', 188, 0, 28, 1, '2021-05-04 13:40:35', '2021-05-04 13:40:35'),
('P-23621', 'Puros Tripa Larga', 761, 31, 5, 5, '2021-05-04 13:40:35', '2021-05-04 13:40:35'),
('P-01305', 'Puros Tripa Larga', 133, 14, 245, 2, '2021-05-04 13:40:35', '2021-05-04 13:40:35'),
('P-02367', 'Puros Tripa Larga', 167, 1, 17, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-02468', 'Puros Tripa Larga', 15, 101, 19, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-02796', 'Puros Tripa Larga', 167, 108, 3, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-02847', 'Puros Tripa Larga', 133, 34, 22, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-02985', 'Puros Tripa Larga', 15, 78, 33, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22089', 'Puros Tripa Larga', 15, 59, 6, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22107', 'Puros Tripa Larga', 15, 5, 1, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22138', 'Puros Tripa Larga', 15, 58, 33, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22139', 'Puros Tripa Larga', 15, 61, 44, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22374', 'Puros Tripa Larga', 535, 1, 1, 4, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22494', 'Puros Tripa Larga', 102, 1, 1, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22496', 'Puros Tripa Larga', 102, 42, 39, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22682', 'Puros Tripa Larga', 140, 4, 5, 14, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22683', 'Puros Tripa Larga', 140, 14, 16, 14, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22817', 'Puros Tripa Larga', 723, 134, 19, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22818', 'Puros Tripa Larga', 723, 135, 9, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22821', 'Puros Tripa Larga', 723, 136, 3, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22876', 'Puros Tripa Larga', 739, 139, 1, 3, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22877', 'Puros Tripa Larga', 739, 140, 4, 3, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22878', 'Puros Tripa Larga', 739, 141, 9, 3, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22895', 'Puros Tripa Larga', 771, 108, 17, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22944', 'Puros Tripa Larga', 781, 108, 24, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-22945', 'Puros Tripa Larga', 781, 142, 19, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23025', 'Puros Tripa Larga', 769, 25, 19, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23037', 'Puros Tripa Larga', 771, 6, 18, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23038', 'Puros Tripa Larga', 771, 3, 3, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23040', 'Puros Tripa Larga', 777, 1, 1, 6, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23044', 'Puros Tripa Larga', 777, 16, 9, 6, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23192', 'Puros Tripa Larga', 88, 44, 64, 13, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23193', 'Puros Tripa Larga', 88, 3, 4, 13, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23241', 'Puros Tripa Larga', 735, 1, 8, 2, '2021-05-04 13:40:36', '2021-05-04 13:40:36'),
('P-23255', 'Puros Tripa Larga', 1385, 2, 16, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-23277', 'Puros Tripa Corta', 653, 4, 13, 14, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-23709', 'Puros Tripa Corta', 227, 2, 4, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-23749', 'Puros Tripa Larga', 102, 39, 9, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-01301', 'Puros Tripa Larga', 90, 5, 1, 3, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-01304', 'Puros Tripa Larga', 90, 36, 3, 3, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-01325', 'Puros Tripa Larga', 59, 21, 24, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-01326', 'Puros Tripa Larga', 15, 84, 19, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-01330', 'Puros Tripa Corta', 1138, 85, 53, 6, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-01653', 'Puros Tripa Larga', 1140, 1, 64, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-01950', 'Puros Sandwich', 324, 1, 79, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-01952', 'Puros Sandwich', 324, 14, 4, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02030', 'Puros Tripa Larga', 99, 1, 28, 6, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02039', 'Puros Tripa Larga', 67, 30, 27, 3, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02049', 'Puros Tripa Larga', 1158, 93, 64, 5, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02054', 'Puros Tripa Larga', 1158, 94, 0, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02084', 'Puros Tripa Larga', 1338, 69, 38, 4, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02181', 'Puros Tripa Larga', 109, 14, 28, 1, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02193', 'Puros Tripa Larga', 14, 37, 9, 3, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02247', 'Puros Tripa Larga', 15, 35, 3, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02270', 'Puros Tripa Larga', 211, 30, 27, 6, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02304', 'Puros Tripa Larga', 1362, 30, 23, 9, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02373', 'Puros Tripa Larga', 107, 14, 28, 6, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02375', 'Puros Tripa Larga', 107, 1, 24, 5, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02377', 'Puros Tripa Larga', 107, 98, 28, 5, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02476', 'Puros Tripa Larga', 211, 42, 39, 6, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02506', 'Puros Tripa Larga', 86, 1, 1, 6, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02637', 'Puros Tripa Larga', 1397, 2, 3, 14, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02681', 'Puros Sandwich', 1404, 14, 4, 5, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02694', 'Puros Tripa Larga', 106, 14, 132, 3, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02729', 'Puros Tripa Larga', 107, 14, 17, 5, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02757', 'Puros Tripa Larga', 51, 42, 39, 5, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('p-02808', 'Puros Tripa Larga', 59, 36, 24, 2, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02912', 'Puros Tripa Larga', 135, 34, 22, 3, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-02977', 'Puros Tripa Larga', 51, 43, 6, 5, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-14110', 'Puros Tripa Larga', 1027, 1, 1, 82, '2021-05-04 13:40:37', '2021-05-04 13:40:37'),
('P-22082', 'Puros Tripa Larga', 14, 5, 1, 3, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22083', 'Puros Tripa Larga', 14, 35, 3, 3, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22094', 'Puros Tripa Larga', 90, 117, 32, 3, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22108', 'Puros Tripa Larga', 14, 59, 6, 3, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22201', 'Puros Tripa Larga', 416, 42, 20, 9, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22235', 'Puros Tripa Larga', 447, 121, 404, 6, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22305', 'Puros Tripa Larga', 416, 122, 18, 9, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22323', 'Puros Tripa Larga', 416, 1, 86, 9, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22373', 'Puros Tripa Larga', 113, 123, 26, 1, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22378', 'Puros Tripa Larga', 452, 1, 24, 6, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22514', 'Puros Tripa Larga', 67, 128, 26, 2, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22518', 'Puros Tripa Larga', 88, 3, 4, 1, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22537', 'Puros Tripa Larga', 104, 30, 33, 12, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22582', 'Puros Tripa Corta', 616, 43, 408, 6, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22585', 'Puros Tripa Corta', 616, 91, 20, 6, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22615', 'Puros Tripa Larga', 1385, 1, 1, 6, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22665', 'Puros Tripa Larga', 663, 43, 28, 1, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22687', 'Puros Tripa Larga', 447, 129, 213, 2, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22696', 'Puros Tripa Corta', 58, 2, 25, 1, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22730', 'Puros Tripa Larga', 675, 2, 168, 1, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22741', 'Puros Tripa Larga', 1158, 131, 235, 5, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22744', 'Puros Tripa Larga', 709, 132, 140, 2, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22816', 'Puros Tripa Larga', 722, 133, 167, 2, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22831', 'Puros Tripa Larga', 228, 1, 2, 1, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22838', 'Puros Tripa Larga', 726, 137, 93, 2, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22841', 'Puros Tripa Larga', 726, 138, 25, 2, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22861', 'Puros Tripa Larga', 733, 2, 36, 4, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22866', 'Puros Tripa Larga', 737, 2, 3, 3, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22875', 'Puros Tripa Larga', 738, 14, 169, 6, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-22905', 'Puros Tripa Larga', 745, 49, 20, 4, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-23003', 'Puros Tripa Larga', 761, 14, 24, 2, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-23005', 'Puros Tripa Larga', 764, 2, 3, 3, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-23049', 'Puros Tripa Larga', 53, 16, 9, 1, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-23187', 'Puros Tripa Corta', 58, 4, 5, 1, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-23216', 'Puros Tripa Larga', 91, 1, 2, 10, '2021-05-04 13:40:38', '2021-05-04 13:40:38'),
('P-23260', 'Puros Tripa Larga', 1385, 30, 33, 2, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23266', 'Puros Tripa Larga', 885, 2, 4, 6, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23400', 'Puros Tripa Larga', 13, 69, 9, 6, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23589', 'Puros Tripa Larga', 228, 16, 9, 1, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23609', 'Puros Tripa Larga', 964, 16, 9, 3, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23622', 'Puros Tripa Larga', 761, 30, 20, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23623', 'Puros Tripa Larga', 761, 1, 2, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23624', 'Puros Tripa Larga', 761, 2, 3, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23682', 'Puros Tripa Larga', 943, 16, 9, 1, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23690', 'Puros Tripa Larga', 40, 31, 5, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-23710', 'Puros Tripa Larga', 1005, 1, 1, 6, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02038', 'Puros Tripa Larga', 67, 92, 44, 3, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02046', 'Puros Tripa Larga', 59, 78, 107, 2, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02050', 'Puros Tripa Larga', 1158, 93, 64, 2, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02053', 'Puros Tripa Larga', 1158, 94, 0, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02063', 'Puros Tripa Larga', 1188, 30, 107, 2, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02064', 'Puros Tripa Larga', 1188, 25, 93, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02066', 'Puros Tripa Larga', 1188, 30, 27, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02073', 'Puros Tripa Larga', 55, 49, 235, 15, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02082', 'Puros Tripa Larga', 1338, 57, 192, 4, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02102', 'Puros Tripa Larga', 1340, 1, 2, 6, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02216', 'Puros Tripa Larga', 134, 2, 3, 2, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02224', 'Puros Tripa Larga', 1355, 95, 212, 1, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02376', 'Puros Tripa Larga', 107, 2, 3, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02413', 'Puros Tripa Larga', 191, 42, 39, 4, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02424', 'Puros Tripa Larga', 1376, 30, 33, 3, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02427', 'Puros Tripa Larga', 67, 42, 39, 3, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02459', 'Puros Tripa Larga', 134, 49, 32, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02460', 'Puros Tripa Larga', 134, 49, 32, 2, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02461', 'Puros Tripa Larga', 134, 42, 39, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02462', 'Puros Tripa Larga', 134, 42, 39, 2, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02479', 'Puros Tripa Larga', 133, 49, 32, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02480', 'Puros Tripa Larga', 133, 49, 32, 2, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02557', 'Puros Tripa Larga', 191, 14, 17, 4, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02586', 'Puros Tripa Larga', 1393, 25, 19, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02590', 'Puros Tripa Larga', 1393, 25, 19, 3, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02597', 'Puros Tripa Larga', 51, 43, 28, 5, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02635', 'Puros Tripa Larga', 1397, 103, 14, 14, '2021-05-04 13:40:39', '2021-05-04 13:40:39'),
('P-02676', 'Puros Sandwich', 1404, 1, 8, 2, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-02679', 'Puros Sandwich', 1404, 69, 38, 5, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-02682', 'Puros Sandwich', 1404, 14, 4, 2, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-02760', 'Puros Tripa Larga', 1188, 30, 153, 5, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-02927', 'Puros Tripa Larga', 277, 42, 39, 6, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-02976', 'Puros Tripa Larga', 110, 30, 33, 2, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-02978', 'Puros Tripa Larga', 51, 30, 33, 5, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-03194', 'Puros Tripa Larga', 86, 92, 44, 6, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-03322', 'Puros Tripa Larga', 361, 30, 153, 2, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22027', 'Puros Tripa Larga', 67, 43, 6, 3, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22081', 'Puros Tripa Larga', 14, 5, 2, 3, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22184', 'Puros Tripa Larga', 134, 14, 28, 5, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22372', 'Puros Tripa Larga', 113, 11, 9, 1, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22382', 'Puros Tripa Larga', 70, 42, 26, 3, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22384', 'Puros Tripa Larga', 70, 42, 26, 6, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('p-22499', 'Puros Tripa Larga', 1409, 1, 18, 14, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22574', 'Puros Tripa Larga', 152, 14, 3, 14, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22666', 'Puros Tripa Larga', 663, 1, 2, 1, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-22702', 'Puros Tripa Larga', 101, 0, 99, 4, '2021-05-04 13:40:40', '2021-05-04 13:40:40'),
('P-00468', 'Puros Brocha', 1302, 83, 352, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02742', 'Puros Brocha', 1302, 105, 352, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02743', 'Puros Brocha', 1302, 106, 352, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02744', 'Puros Brocha', 1302, 107, 352, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-23370', 'Puros Brocha', 188, 144, 458, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-23761', 'Puros Brocha', 1023, 150, 479, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02741', 'Puros Brocha', 1302, 104, 352, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-22724', 'Puros Brocha', 1419, 130, 458, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-23620', 'Puros Brocha', 973, 147, 458, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-23676', 'Puros Brocha', 997, 83, 458, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-23760', 'Puros Brocha', 1023, 149, 479, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-23762', 'Puros Brocha', 1023, 151, 479, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-23779', 'Puros Brocha', 188, 110, 479, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-00336', 'Puros Tripa Larga', 1184, 82, 23, 6, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-01654', 'Puros Tripa Larga', 1140, 1, 79, 2, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02061', 'Puros Tripa Larga', 1188, 25, 93, 2, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02065', 'Puros Tripa Larga', 1188, 1, 81, 5, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02067', 'Puros Tripa Larga', 1188, 42, 207, 5, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02074', 'Puros Tripa Larga', 55, 2, 25, 15, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02092', 'Puros Tripa Larga', 1339, 14, 247, 2, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02124', 'Puros Tripa Larga', 1344, 91, 361, 2, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02157', 'Puros Tripa Larga', 186, 70, 39, 2, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02159', 'Puros Tripa Larga', 186, 70, 39, 5, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02201', 'Puros Tripa Larga', 1353, 1, 18, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02226', 'Puros Tripa Larga', 1355, 96, 20, 1, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02267', 'Puros Tripa Larga', 211, 49, 32, 6, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02296', 'Puros Tripa Larga', 1163, 30, 107, 3, '2021-05-04 13:40:41', '2021-05-04 13:40:41');
INSERT INTO `tabla_codigo_programacions` (`codigo`, `presentacion`, `marca`, `nombre`, `vitola`, `capa`, `updated_at`, `created_at`) VALUES
('P-02302', 'Puros Tripa Larga', 1362, 25, 362, 9, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02307', 'Puros Tripa Larga', 1362, 30, 27, 9, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02400', 'Puros Tripa Larga', 65, 3, 3, 6, '2021-05-04 13:40:41', '2021-05-04 13:40:41'),
('P-02402', 'Puros Tripa Larga', 65, 50, 4, 6, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02411', 'Puros Tripa Larga', 191, 14, 3, 4, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02428', 'Puros Tripa Larga', 67, 100, 39, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02445', 'Puros Tripa Larga', 132, 4, 31, 6, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02464', 'Puros Tripa Larga', 135, 49, 32, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02466', 'Puros Tripa Larga', 135, 42, 39, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02485', 'Puros Tripa Larga', 1362, 25, 155, 9, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02517', 'Puros Tripa Larga', 1344, 14, 192, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02568', 'Puros Tripa Larga', 1392, 1, 24, 1, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02591', 'Puros Tripa Larga', 1393, 11, 9, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02636', 'Puros Tripa Larga', 1397, 1, 1, 14, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02675', 'Puros Sandwich', 1404, 1, 8, 5, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02685', 'Puros Tripa Larga', 1362, 25, 362, 6, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02735', 'Puros Tripa Larga', 1415, 1, 1, 27, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02761', 'Puros Tripa Larga', 340, 42, 39, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02764', 'Puros Tripa Larga', 209, 35, 3, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02770', 'Puros Tripa Larga', 1134, 1, 79, 1, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02782', 'Puros Tripa Larga', 51, 1, 81, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-02810', 'Puros Tripa Larga', 59, 14, 24, 1, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-03199', 'Puros Tripa Larga', 67, 49, 32, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-11008', 'Puros Tripa Larga', 188, 0, 1, 6, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-11128', 'Puros Tripa Larga', 359, 1, 1, 22, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-11298', 'Puros Tripa Larga', 188, 110, 3, 9, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-11650', 'Puros Tripa Larga', 188, 0, 4, 10, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-11768', 'Puros Tripa Larga', 405, 0, 4, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-11776', 'Puros Tripa Larga', 405, 0, 18, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-11816', 'Puros Tripa Larga', 405, 0, 24, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-11861', 'Puros Tripa Larga', 405, 0, 17, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22031', 'Puros Tripa Larga', 340, 70, 39, 13, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22032', 'Puros Tripa Larga', 340, 49, 32, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22034', 'Puros Tripa Larga', 340, 2, 3, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22035', 'Puros Tripa Larga', 340, 21, 3, 13, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22042', 'Puros Tripa Larga', 188, 115, 7, 5, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22050', 'Puros Tripa Larga', 188, 115, 25, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22056', 'Puros Tripa Larga', 191, 1, 18, 4, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22086', 'Puros Tripa Larga', 441, 21, 16, 4, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22093', 'Puros Tripa Larga', 51, 116, 39, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22098', 'Puros Tripa Larga', 90, 119, 28, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22102', 'Puros Tripa Larga', 186, 36, 17, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22109', 'Puros Tripa Larga', 186, 120, 6, 5, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22113', 'Puros Tripa Larga', 14, 120, 6, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22117', 'Puros Tripa Larga', 51, 42, 39, 5, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22207', 'Puros Tripa Larga', 188, 110, 238, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22395', 'Puros Tripa Larga', 405, 30, 107, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22396', 'Puros Tripa Larga', 405, 0, 18, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22398', 'Puros Tripa Larga', 405, 0, 43, 2, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22399', 'Puros Tripa Larga', 405, 0, 39, 1, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22400', 'Puros Tripa Larga', 405, 0, 43, 1, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22468', 'Puros Tripa Larga', 405, 0, 16, 3, '2021-05-04 13:40:42', '2021-05-04 13:40:42'),
('P-22618', 'Puros Tripa Larga', 1385, 14, 4, 6, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-22763', 'Puros Tripa Larga', 117, 2, 3, 23, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-02195', 'Puros Tripa Larga', 14, 21, 16, 3, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-02214', 'Puros Tripa Larga', 134, 14, 17, 5, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-02336', 'Puros Tripa Larga', 90, 97, 32, 3, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-02560', 'Puros Tripa Larga', 147, 3, 3, 3, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-02617', 'Puros Tripa Larga', 219, 3, 3, 3, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-14012', 'Puros Tripa Corta', 1278, 2, 4, 2, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-14013', 'Puros Tripa Corta', 1278, 4, 13, 2, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-22213', 'Puros Tripa Larga', 71, 6, 1, 3, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-22598', 'Puros Tripa Larga', 214, 3, 3, 3, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-23262', 'Puros Tripa Larga', 93, 79, 2, 2, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-01338', 'Puros Tripa Larga', 1138, 86, 118, 21, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-01358', 'Puros Tripa Larga', 1138, 89, 289, 6, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-01740', 'Puros Tripa Larga', 1138, 91, 185, 15, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('p-22651', 'Puros Tripa Corta', 653, 1, 1, 1, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('p-22652', 'Puros Tripa Corta', 653, 1, 1, 14, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-22661', 'Puros Tripa Corta', 653, 1, 1, 6, '2021-05-04 13:40:43', '2021-05-04 13:40:43'),
('P-23258', 'Puros Tripa Corta', 653, 14, 4, 1, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-23259', 'Puros Tripa Corta', 653, 14, 4, 14, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('p-23367', 'Puros Tripa Corta', 653, 4, 13, 1, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-22756', 'Puros Tripa Larga', 713, 8, 24, 23, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-22868', 'Puros Tripa Larga', 229, 16, 9, 3, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-23596', 'Puros Tripa Larga', 188, 1, 1, 19, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-02360', 'Puros Tripa Larga', 232, 4, 5, 2, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-02399', 'Puros Tripa Larga', 65, 38, 5, 6, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-02619', 'Puros Tripa Larga', 219, 11, 9, 3, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-22628', 'Puros Tripa Larga', 161, 2, 4, 2, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-22703', 'Puros Tripa Larga', 101, 56, 35, 4, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-23606', 'Puros Tripa Larga', 230, 2, 3, 1, '2021-05-04 13:40:44', '2021-05-04 13:40:44'),
('P-23763', 'Puros Tripa Larga', 230, 1, 2, 1, '2021-05-04 13:40:44', '2021-05-04 13:40:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_empaques`
--

DROP TABLE IF EXISTS `tipo_empaques`;
CREATE TABLE IF NOT EXISTS `tipo_empaques` (
  `id_tipo_empaque` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo_empaque` char(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_empaque_ingles` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_empaque`)
) ENGINE=MyISAM AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_empaques`
--

INSERT INTO `tipo_empaques` (`id_tipo_empaque`, `tipo_empaque`, `tipo_empaque_ingles`, `created_at`, `updated_at`) VALUES
(1, 'BOX 6', 'BOX 6', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(2, 'BOX 5', 'BOX 5', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(3, 'BOX 20', 'BOX 20', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(4, 'CAJAS 1/10', 'BOX 10', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(5, 'CAJAS 1/6', 'BOX 6', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(6, 'CAJAS 1/5', 'BOX 5', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(7, 'CAJAS 1/20', 'BOX 20', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(8, 'MAZOS 1/8', 'BUNDLE 8', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(9, 'MAZOS 1/10', 'BUNDLE 10', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(10, 'MAZOS 1/20', 'BUNDLE 20', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(11, 'MAZOS 1/5', 'BUNDLE 5', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(12, 'MAZOS 1/25', 'BUNDLE 25', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(13, 'CAJAS 1/25', 'BOX 25', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(14, 'PK 4', 'PK 4', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(15, 'TINS 1/5', 'TINS 1/5', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(16, 'CAJAS 1/100C', 'BOX 100C', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(17, 'CAJA 1/40', 'BOX 40', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(18, 'CAJAS 1/100', 'BOX 100', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(19, 'CAJAS 1/30', 'BOX 30', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(20, 'MAZOS 1/16', 'BUNDLE 16', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(21, 'CAJAS 1/50', 'BOX 50', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(22, 'MAZOS 1/15', 'BUNDLE 15', '2021-04-08 21:40:44', '2021-04-08 21:40:44'),
(23, 'Display 5', 'Display 5', '2021-04-08 21:40:45', '2021-04-08 21:40:45'),
(24, 'MAZOS 1/12', 'BUNDLE 12', '2021-04-08 21:40:45', '2021-04-08 21:40:45'),
(25, 'MAZOS 1/30', 'BUNDLE 30', '2021-04-08 21:40:45', '2021-04-08 21:40:45'),
(26, 'CAJAS 1/16', 'BOX 16', '2021-04-08 21:40:45', '2021-04-08 21:40:45'),
(27, 'N/D', 'N/D', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(28, 'CAJAS 1/21', 'BOX 21', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(29, 'CAJAS 1/13', 'BOX 13', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(30, 'CAJAS 1/22', 'BOX 22', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(31, 'CAJAS 1/27', 'BOX 27', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(32, 'CAJAS 1/55', 'BOX 55', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(33, 'MAZOS 1/24', 'BUNDLE 24', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(34, 'MAZOS 1/60', 'BUNDLE 60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(35, 'PK 8/8', 'PK 8/8', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(36, 'CAJA 1/28', 'BOX 28', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(37, 'MAZOS 1/22', 'BUNDLE 22', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(38, 'MAZOS 1/4', 'BUNDLE 4', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(39, 'CAJAS 1/3', 'BOX 3', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(40, 'CAJAS 1/7', 'BOX 7', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(41, 'ETCHE 1/20', 'ETCHE 1/20', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(42, 'PACK 10/8', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(43, 'CAJAS 1/15', 'BOX 15', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(44, 'CAJAS 1/12', 'BOX 12', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(45, 'PK-10/4', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(46, 'PK-TINS', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(47, 'CAJAS 1/24', 'BOX 24', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(48, 'CAJAS 1/48', 'BOX 48', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(49, 'MAZOS 1/50', 'BUNDLE 50', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(50, 'CAJAS 1/8', 'BOX 8', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(51, 'PK/60', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(52, 'CAJAS 1/26', 'BOX 26', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(53, 'MAZOS 1/6', 'BUNDLE 6', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(54, 'TINS/8', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(55, 'CAJA 1/4', 'BOX 4', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(56, 'MAZOS 1/27', 'BUNDLE 27', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(57, 'BOLSA 1/1', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(58, 'MAZOS 1/14', 'BUNDLE 14', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(59, 'MAZOS 1/48', 'BUNDLE 48', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(60, 'UPRIGHT 1/20', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(61, 'PK-2/2', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(62, 'CAJA 1/9', 'BOX 9', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(63, 'MAZOS 1/2', 'BUNDLE 2', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(64, 'PK /40', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(65, 'CAJAS 1/1', 'BOX 1', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(66, 'PK 4/5', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(67, 'MAZOS 1/9', 'BUNDLE 9', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(68, 'MAZOS 1/3', 'BUNDLE 3', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(69, 'CAJAS 1/18', 'BOX 18', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(70, 'PK 20/2', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(71, 'TINS 1/10', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(72, 'MAZOS 1/55', 'BUNDLE 55', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(73, 'MAZOS 1/21', 'BUNDLE 21', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(74, 'MAZOS 1/18', 'BUNDLE 18', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(75, 'CAJAS 1/725', 'BOX 725', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(76, 'MAZOS 1/19', 'BUNDLE 19', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(77, 'PK-6/8', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(78, 'MAZOS 1/11', 'BUNDLE 11', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(79, 'MAZOS 1/23', 'BUNDLE 23', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(80, 'PK-3/10', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(81, 'MAZOS 1/40', 'BUNDLE 40', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(82, 'CAJAS 1/60', 'BOX 60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(83, 'MAZOS 1/1', 'BUNDLE 1', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(84, 'MAZOS 1/28', 'BUNDLE 28', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(85, 'CAJAS 1/250', 'BOX 250', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(86, 'MAZOS 1/100', 'BUNDLE 100', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(87, 'MAZOS 1/7', 'BUNDLE 7', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(88, 'MAZOS 1/13', 'BUNDLE 13', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(89, 'CAJAS 1/14', 'BOX 14', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(90, 'CAJAS 1/75', 'BOX 75', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(91, 'BOLSA 1/3', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(92, 'TINS 1/7', NULL, '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(93, 'MAZOS 1/29', 'BUNDLE 29', '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(94, 'MOLDES 1/10', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(95, 'PK 5/8', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(96, 'Jars of 16', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(97, 'Jars of 20', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(98, 'CENICEROS 1/5', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(99, 'CAJA 1/36', 'BOX 36', '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(100, 'CAJON 1/160', '', '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(101, 'CAJON/140', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(102, 'MAZOS 1/150', 'BUNDLE 150', '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(103, 'BOLSA 1/4', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(104, 'PACK 1/35', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(105, 'PK-1/20', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(106, 'PK-1/25', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(107, 'PACK 1/10', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(108, 'PACK 1/5', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(109, 'Display 12', 'Display 12', '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(110, 'Displays/10', 'Displays/10', '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(111, 'PK/100', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(112, 'PK/12', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(113, 'PK/30', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07'),
(114, 'UP/15', NULL, '2021-04-28 20:52:07', '2021-04-28 20:52:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo` int(11) DEFAULT NULL,
  `rol` int(11) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `codigo`, `rol`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 'admin', 'admin@privado.com', 0, 0, NULL, '$2y$10$ILcbmV.tPOvMSVbYk6NaOe4SkhECWoV4o/2ZuAXfs1XRgFzGDFdCG', NULL, '2021-05-12 09:43:55', '2021-05-12 09:43:55'),
(4, 'Luis Moncada', 'lufmos10@gmail.com', 59, 0, NULL, '$2y$10$uQEH.nEUtzZd50IlP36Ja.WYPdXVS0NdZHFPRpcqwsmHejNTP9IRe', NULL, '2021-05-12 09:43:55', '2021-05-12 09:43:55'),
(5, 'Marvin Bruno', 'bmarbinalexis@gmail.com', 1217, 1, NULL, '$2y$10$Dar3GpscxbuNCxtgKeV2i./1Gi4mh2Wg2xXmKC9QWbIRenOspH2.q', NULL, '2021-06-04 01:16:56', '2021-06-04 01:16:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vitola_productos`
--

DROP TABLE IF EXISTS `vitola_productos`;
CREATE TABLE IF NOT EXISTS `vitola_productos` (
  `id_vitola` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `vitola` char(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_vitola`),
  UNIQUE KEY `vitola` (`vitola`)
) ENGINE=MyISAM AUTO_INCREMENT=510 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vitola_productos`
--

INSERT INTO `vitola_productos` (`id_vitola`, `vitola`, `created_at`, `updated_at`) VALUES
(1, '5X50', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(2, '5-1/2X50', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(3, '6-1/2X52', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(4, '6X52', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(5, '7X48', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(6, '4-1/2X54', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(7, '4-1/2X52', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(8, '5X52', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(9, '6X60', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(10, '6-1/2X53', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(11, '7X70', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(12, '5X58', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(13, '7X50', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(14, '5X48', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(15, '4X38', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(16, '6-1/4X52', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(17, '5X54', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(18, '5-1/2X54', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(19, '4-1/2X44', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(20, '6X44', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(21, '4-1/2X60', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(22, '7-1/2X52', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(23, '5-1/2X46', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(24, '5-1/2X52', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(25, '6X50', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(26, '7-1/2X38', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(27, '5-1/2X42', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(28, '4X54', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(29, '6-1/2X36X54 PIRAMIDE', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(30, '5-3/4X54', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(31, '7X49', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(32, '6-1/2X44', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(33, '5-1/2X44', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(34, '4-1/2X46', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(35, '5X60', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(36, '6-1/2X54', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(37, '4X48', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(38, '6X58', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(39, '7X38', '2021-04-08 21:40:33', '2021-04-08 21:40:33'),
(40, 'VARIADO', '2021-04-08 21:40:34', '2021-04-08 21:40:34'),
(41, 'Toro Red.', '2021-04-08 21:40:34', '2021-04-08 21:40:34'),
(42, '7-1/2X54', '2021-04-08 21:40:34', '2021-04-08 21:40:34'),
(43, '6-1/2X48', '2021-04-08 21:40:34', '2021-04-08 21:40:34'),
(44, '4-1/2X46X49', '2021-04-08 21:40:34', '2021-04-08 21:40:34'),
(45, 'NINGUNA', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(46, '3-1/2X20', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(47, '3-3/4X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(48, '3-3/4X44', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(49, '3-3/4X48', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(50, '3-3/8X48', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(51, '3-5/16X50', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(52, '3-7/8X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(53, '4-1/4X26', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(54, '4-1/2X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(55, '4-1/2X32', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(56, '4-1/2X34', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(57, '4-1/2X36', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(58, '4-1/2X38', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(59, '4-1/2X40', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(60, '4-1/2X41', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(61, '4-1/2X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(62, '4-1/2X43', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(63, '4-1/2X48', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(64, '4-1/2X50', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(65, '4-1/4X28X33', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(66, '4-1/4X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(67, '4-1/4X31', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(68, '4-1/4X38', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(69, '4-1/4X40', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(70, '4-1/4X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(71, '4-1/8X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(72, '4-1/8X31', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(73, '4-3/16X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(74, '4-3/4X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(75, '4-3/4X34', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(76, '4-3/4X36', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(77, '4-3/4X38', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(78, '4-3/4X48', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(79, '4-3/4X50', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(80, '4-3/4X52', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(81, '4-3/4X54', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(82, '4-3/4X60', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(83, '4-5/8X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(84, '4-7/8X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(85, '4-7/8X49', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(86, '4-7/8X50', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(87, '4-7/8X52', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(88, '4X20', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(89, '4X22', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(90, '4X28', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(91, '4X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(92, '4X31', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(93, '4X40', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(94, '4X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(95, '4X44', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(96, '4X46', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(97, '4X50', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(98, '4X52', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(99, '4X60', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(100, '4X64', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(101, '5-1/2X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(102, '5-1/2X32', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(103, '5-1/2X34', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(104, '5-1/2X36', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(105, '5-1/2X39', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(106, '5-1/2X40', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(107, '5-1/2X43', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(108, '5-1/2X48', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(109, '5-1/2X52X36', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(110, '5-1/2X36X54', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(111, '5-1/2X55', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(112, '5-1/2X56', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(113, '5-1/2X58', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(114, '5-1/2X60', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(115, '5-1/4X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(116, '5-1/4X40', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(117, '5-1/4X41', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(118, '5-1/4X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(119, '5-1/4X43', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(120, '5-1/4X50', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(121, '5-1/4X52', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(122, '5-1/8X52', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(123, '5-3/16X45', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(124, '5-3/4X34', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(125, '5-3/4X41', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(126, '5-3/4X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(127, '5-3/4X43', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(128, '5-3/4X44', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(129, '5-3/4X45', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(130, '5-3/4X46', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(131, '5-3/4X50', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(132, '5-3/4X52', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(133, '5-3/4X52X36', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(134, '5-3/4X54X36', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(135, '5-3/4X60', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(136, '5-3/8X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(137, '5-3/8X43', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(138, '5-5/8X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(139, '5-5/8X43', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(140, '5-5/8X46', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(141, '5-7/8X50', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(142, '5-7/8X52', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(143, '5-7/8X60', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(144, '5X28', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(145, '5X30', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(146, '5X31', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(147, '5X32', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(148, '5X34', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(149, '5X35', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(150, '5X36', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(151, '5X38', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(152, '5X40', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(153, '5X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(154, '5X43', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(155, '5X44', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(156, '5X56', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(157, '5X62', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(158, '5X64', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(159, '6-1/16X42', '2021-04-28 20:52:04', '2021-04-28 20:52:04'),
(160, '6-1/2X34', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(161, '6-1/2X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(162, '6-1/2X38', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(163, '6-1/2X40', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(164, '6-1/2X42', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(165, '6-1/2X43', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(166, '6-1/2X45', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(167, '6-1/2X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(168, '6-1/2X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(169, '6-1/2X52X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(170, '6-1/2X54 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(171, '6-1/2X55', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(172, '6-1/2X56', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(173, '6-1/2X56 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(174, '6-1/2X58', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(175, '6-1/2X60', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(176, '6-1/2X60 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(177, '6-1/2X62', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(178, '6-1/4X33', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(179, '6-1/4X34', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(180, '6-1/4X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(181, '6-1/4X38', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(182, '6-1/4X43', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(183, '6-1/4X44', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(184, '6-1/4X45', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(185, '6-1/4X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(186, '6-1/4X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(187, '6-1/4X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(188, '6-1/4X50 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(189, '6-1/4X51', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(190, '6-1/4X52 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(191, '6-1/4X52X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(192, '6-1/4X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(193, '6-1/4X54 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(194, '6-1/4X54X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(195, '6-1/4X64', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(196, '6-1/4X65', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(197, '6-1/8X34', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(198, '6-1/8X52', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(199, '6-1/8X52 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(200, '6-1/8X52 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(201, '6-1/8X54 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(202, '6-1/8X54 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(203, '6-3/16X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(204, '6-3/16X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(205, '6-3/4X34', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(206, '6-3/4X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(207, '6-3/4X38', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(208, '6-3/4X44', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(209, '6-3/4X45', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(210, '6-3/4X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(211, '6-3/4X47', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(212, '6-3/4X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(213, '6-3/4X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(214, '6-3/4X52', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(215, '6-3/4X52 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(216, '6-3/4X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(217, '6-3/4X54 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(218, '6-3/4X62', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(219, '6-3/8X47', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(220, '6-3/8X60', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(221, '6-3/8X62', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(222, '6-5/8X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(223, '6-5/8X44', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(224, '6-5/8X56', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(225, '6-5/8X56 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(226, '6-7/8X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(227, '6-7/8X49', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(228, '6-7/8X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(229, '6X29X43X49 FIGURADO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(230, '6X30', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(231, '6X34', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(232, '6X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(233, '6X40', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(234, '6X40 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(235, '6X42', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(236, '6X43', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(237, '6X44 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(238, '6X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(239, '6X46 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(240, '6X47', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(241, '6X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(242, '6X48 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(243, '6X50 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(244, '6X50 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(245, '6X52 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(246, '6X52X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(247, '6X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(248, '6X54 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(249, '6X54X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(250, '6X55', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(251, '6X56', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(252, '6X56 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(253, '6X60 FIGURADO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(254, '6X60 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(255, '6X64', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(256, '7-1/2X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(257, '7-1/2X38 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(258, '7-1/2X42', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(259, '7-1/2X44', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(260, '7-1/2X45', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(261, '7-1/2X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(262, '7-1/2X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(263, '7-1/2X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(264, '7-1/2X50 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(265, '7-1/2X52 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(266, '7-1/2X54X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(267, '7-1/2X56', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(268, '7-1/2X56 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(269, '7-1/2X58', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(270, '7-1/2X58 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(271, '7-1/2X60', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(272, '7-1/2X62', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(273, '7-1/2X62 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(274, '7-1/4X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(275, '7-1/4X38', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(276, '7-1/4X42', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(277, '7-1/4X43', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(278, '7-1/4X44', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(279, '7-1/4X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(280, '7-1/4X49', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(281, '7-1/4X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(282, '7-1/4X52', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(283, '7-1/4X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(284, '7-1/4X54 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(285, '7-1/4X54X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(286, '7-1/4X56', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(287, '7-1/4X60 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(288, '7-1/4X62', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(289, '7-1/8X42', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(290, '7-1/8X45', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(291, '7-1/8X45X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(292, '7-1/8X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(293, '7-3/16X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(294, '7-3/4X38', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(295, '7-3/4X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(296, '7-3/4X58', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(297, '7-3/4X58 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(298, '7-5/8X47', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(299, '7-5/8X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(300, '7-5/8X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(301, '7X34', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(302, '7X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(303, '7X36X52 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(304, '7X36X54 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(305, '7X42', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(306, '7X43', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(307, '7X43 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(308, '7X44', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(309, '7X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(310, '7X46 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(311, '7X47', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(312, '7X47 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(313, '7X48 FIGURADO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(314, '7X48 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(315, '7X50 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(316, '7X50 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(317, '7X52', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(318, '7X52 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(319, '7X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(320, '7X54 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(321, '7X56 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(322, '7X58 FIGURADO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(323, '7X58 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(324, '7X60 TORPEDO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(325, '8-1/2X38', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(326, '8-1/2X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(327, '8-1/2X52', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(328, '8-1/2X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(329, '8-1/4X38', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(330, '8-1/4X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(331, '8-3/4X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(332, '8-3/4X52', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(333, '8X38', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(334, '8X47', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(335, '8X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(336, '8X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(337, '8X52', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(338, '8X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(339, '8X54X36 PIRAMIDE', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(340, '8X56', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(341, '9-1/4X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(342, '9-1/4X52', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(343, '9X56', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(344, '10X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(345, '11X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(346, '11-1/2X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(347, '5X52 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(348, '6X60 RABITO', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(349, '6X49', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(350, '4-1/8X40', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(351, '5-1/8X50', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(352, '4-1/4X32', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(353, '7X54X36', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(354, '4X32', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(355, '3-1/2X22', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(356, '5X60X44', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(357, '4-1/2X28', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(358, '3-1/8X22', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(359, '4X26', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(360, '5-1/4X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(361, '6-1/2X47', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(362, '5X46', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(363, '2X42', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(364, '6X45', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(365, '4-1/2X44X48', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(366, '9-1/2X54', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(367, '4-1/2X26', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(368, '7X45', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(369, '3-1/4X20', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(370, '3-3/8X26', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(371, '5-1/8X33', '2021-04-28 20:52:05', '2021-04-28 20:52:05'),
(372, '5-3/4X22', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(373, '4-3/4X22', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(374, '5-7/8X22', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(375, '6X41', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(376, '3-3/4X22', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(377, '4X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(378, '4X58 TORPEDO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(379, '10X66', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(380, '7X60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(381, '4X34', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(382, '6X38', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(383, '4-3/4X42', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(384, '5-5/8X56', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(385, '6-1/8X50', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(386, '3-1/2X44', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(387, '3-7/8X32', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(388, '7-5/8X60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(389, '6-3/16X52', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(390, '5X26', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(391, '6-3/4X51', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(392, '5-1/4X46', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(393, '6-3/4X28X54X42', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(394, '6-3/8X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(395, '5-3/4X56', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(396, '6-3/16X54', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(397, '6-1/4X62', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(398, '3-1/2X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(399, '5-1/2X45', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(400, '6X68', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(401, '6-1/4X60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(402, '4-1/4X28', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(403, '4-3/16X36', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(404, '4-1/4X54', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(405, '8-7/16X40', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(406, '4-7/8X54', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(407, '5-1/4X28', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(408, '4-1/4X52', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(409, '3-1/2X54', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(410, '5-1/2X38', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(411, '3-1/2X56', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(412, '5-1/4X29', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(413, '5-1/4X45', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(414, '7X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(415, '3-1/2X50', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(416, '6-7/8X60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(417, '3-1/2X52', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(418, '3-3/4X52', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(419, '6-7/8X52', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(420, '6X32', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(421, '4-7/8X38', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(422, '5-7/8X40', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(423, '5X51', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(424, '3-3/4X50', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(425, '6X62', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(426, '4-1/2X56', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(427, '6-1/4X56', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(428, '6X70', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(429, '7X70 RABITO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(430, '3X52', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(431, '3-5/8X26', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(432, '4-3/4X45', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(433, '5X55', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(434, '7X77', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(435, '6-1/2X65', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(436, '8-1/2X60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(437, '6X70X42', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(438, '5-1/2X70', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(439, '5-1/2X80', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(440, '7X64', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(441, '6X80', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(442, '6X70 FIGURADO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(443, '5X70', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(444, '4X56', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(445, '4X43', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(446, '4-1/4X60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(447, '5X60 RABITO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(448, '7x30', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(449, '5X44 FIGURADO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(450, '5X48 FIGURADO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(451, '5-1/2X48 TORPEDO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(452, '4-3/4X28', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(453, '7-1/2X40', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(454, '7X56', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(455, '4-7/8X50 RABITO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(456, '4-3/4X40', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(457, '6-3/4X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(458, '9.7X11.7X4-1/8', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(459, '5-1/4X54 TORPEDO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(460, '5-3/4X50X36 Piramide', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(461, '6-3/16X48', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(462, '4-3/8X50', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(463, '3-15/16X46', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(464, '3-3/16X46', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(465, '6-3/16X50', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(466, '4-3/4X32', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(467, '4-1/4X48', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(468, '6-1/2X41', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(469, '5-1/8X42', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(470, '4-5/16X42', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(471, '5-15/16X52', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(472, '4-1/4X46', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(473, '4X60 TORPEDO', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(474, '4X48 Mini Torpedo', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(475, '3-1/2X46', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(476, '3-1/2X60', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(477, '6X49X43X24', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(478, '7-1/8X54', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(479, '3-3/4X13X10', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(480, '6-7/8X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(481, '8-3/4X47', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(482, '5-5/8X44', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(483, '4-7/8X48', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(484, '3-1/2X58 Moño', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(485, '4-1/2X52 Moño', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(486, '5-1/2X56 Moño', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(487, '6X52 Moño', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(488, '7X38 Moño', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(489, '7X50X58 Moño', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(490, '5X50 Rabito Cochino', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(491, '6X54 Rabito Cochino', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(492, '7-1/2X52 Rabito Cochino', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(493, '5X44 Rabito Cochino', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(494, '7X50X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(495, '5-1/4X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(496, '5-1/4X54 Prensado', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(497, '6-1/2X52 Prensado', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(498, '6-5/8X54', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(499, '6-1/8X46', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(500, '7X48 Prensado', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(501, '6-1/4X54 Prensado', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(502, '6-1/2X48 Prensado', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(503, '5-1/2X55 Prensado', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(504, '6-1/2X67', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(505, '3-1/2X30', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(506, '6-1/4X58', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(507, '6X50 Figurado', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(508, '5-1/8X55', '2021-04-28 20:52:06', '2021-04-28 20:52:06'),
(509, '50x5', NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
