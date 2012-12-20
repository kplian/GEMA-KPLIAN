/*
*	Author: RAC
*	Date: 21/12/2012
*	Description: Build the menu definition and the composition
*/


/*

Para  definir la la metadata, menus, roles, etc

1) sincronize ls funciones y procedimientos del sistema
2)  verifique que la primera linea de los datos sea la insercion del sistema correspondiente
3)  exporte los datos a archivo SQL (desde la interface de sistema en sis_seguridad), 
    verifique que la codificacion  se mantenga en UTF8 para no distorcionar los caracteres especiales
4)  remplaze los sectores correspondientes en este archivo en su totalidad:  (el orden es importante)  
                             menu, 
                             funciones, 
                             procedimietnos
*/


INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES (E'ALM', E'Sistema de Almacenes', E'2012-09-20', E'SAL', E'activo', E'ALMACENES', NULL);
  

-------------------------------------
--DEFINICION DE INTERFACES
-----------------------------------
  

select pxp.f_insert_tgui ('SISTEMA DE ALMACENES', '', 'ALM', 'si',1 , '', 1, '../../../lib/imagenes/alma32x32.png', '', 'ALM');
select pxp.f_insert_tgui ('Datos Generales', 'Datos Generales', 'ALDAGE', 'si', 1, '', 2, '', '', 'ALM');
select pxp.f_insert_tgui ('Catálogos', 'Catálogos', 'ALMAIN', 'si', 2, '', 2, '', '', 'ALM');
select pxp.f_insert_tgui ('Movimientos', 'Movimientos', 'ALMOVI', 'si', 3, '', 2, '', '', 'ALM');
select pxp.f_insert_tgui ('Creación de almacenes', 'Creación de almacenes', 'ALCRAL', 'si', 1, 'sis_almacenes/vista/almacen/Almacen.php', 3, '', 'Almacen', 'ALM');
select pxp.f_insert_tgui ('Materiales', 'Registro de Materiales', 'ALREMA', 'si', 1, 'sis_almacenes/vista/item/Item.php', 3, '', 'Item', 'ALM');
select pxp.f_insert_tgui ('Clasificación de materiales', 'Clasificación de materiales', 'ALCLMA', 'si', 1, 'sis_almacenes/vista/clasificacion/Clasificacion.php', 3, '', 'Clasificacion', 'ALM');
select pxp.f_insert_tgui ('Ingresos', 'Ingresos', 'ALINGR', 'si', 2, 'sis_almacenes/vista/movimiento/Ingreso.php
', 3, '', 'Ingreso', 'ALM');
select pxp.f_insert_tgui ('Salidas', 'Salidas', 'ALSAGR', 'si', 2, 'sis_almacenes/vista/movimiento/Salida.php
', 3, '', 'Salida', 'ALM');
select pxp.f_insert_tgui ('Transferencias', 'Transferencias', 'ALTRGR', 'si', 3, 'sis_almacenes/vista/movimiento/Transferencia.php', 3, '', 'Transferencia', 'ALM');
select pxp.f_insert_testructura_gui ('ALM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ALDAGE', 'ALM');
select pxp.f_insert_testructura_gui ('ALMAIN', 'ALM');
select pxp.f_insert_testructura_gui ('ALMOVI', 'ALM');
select pxp.f_insert_testructura_gui ('ALCRAL', 'ALDAGE');
select pxp.f_insert_testructura_gui ('ALREMA', 'ALMAIN');
select pxp.f_insert_testructura_gui ('ALCLMA', 'ALMAIN');
select pxp.f_insert_testructura_gui ('ALINGR', 'ALMOVI');
select pxp.f_insert_testructura_gui ('ALSAGR', 'ALMOVI');
select pxp.f_insert_testructura_gui ('ALTRGR', 'ALMOVI');



----------------------------------------------
--  DEF DE FUNCIONES
--------------------------------------------------



select pxp.f_insert_tfuncion ('alm.ft_movimiento_det_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_det_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_stock_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_stock_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_existencias_item', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_correlativo', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_clasificacion_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_clasificacion_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_item_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_num_mov', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_usuario_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_valorado_item', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_item_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_usuario_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_verificar_registro', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_sel', 'Funcion para tabla     ', 'ALM');



---------------------------------
--DEF DE PROCEDIMIETOS
---------------------------------




select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_ELI', 'Eliminacion de registros
', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_MOD', 'Modificacion de registros
', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_INS', 'Insercion de registros
', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_movimiento_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_movimiento_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_almacen_stock_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_almacen_stock_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_ELI', 'Eliminacion de registros
', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_MOD', 'Modificacion de registros
', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_INS', 'Insercion de registros
', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('ALM_CLA_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('ALM_CLA_ARB_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('ALM_CLA_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('SAL_CLA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_CLA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_CLA_INS', '	Insercion de registros
 	', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_ELI', 'Eliminacion de registros
', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_MOD', 'Modificacion de registros
', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_INS', 'Insercion de registros
', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_ELI', 'Eliminacion de registros
', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_MOD', 'Modificacion de registros
', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_INS', 'Insercion de registros
', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_MOD', '	Modificacion de registros
 	', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_INS', '	Insercion de registros
 	', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_FIN', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_ELI', 'Eliminacion de datos
', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_MOD', 'Modificacion de datos
', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_INS', 'Insercion de datos
', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOV_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEMNOTBASE_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEMNOTBASE_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ARB_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_CONT', '	Conteo de registros
 	', 'si', '', '', 'alm.ft_almacen_usuario_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_SEL', '	Consulta de datos
 	', 'si', '', '', 'alm.ft_almacen_usuario_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALM_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_almacen_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALM_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_almacen_sel');

-----------------------------------
--
---------------------------------------

-- Clasificacion
INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 10:36:14', '2012-11-13 10:36:14', 'activo', 1, NULL, 'EQUIP', 'Equipos', NULL, 'EQUIPOS');

INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 11:29:46', '2012-11-13 11:29:46', 'activo', 3, 1, 'ECOM', 'Equipos de computación', NULL, 'EQUIPOCOMP');

INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 10:37:30', '2012-11-13 10:37:30', 'activo', 2, 1, 'EQMED', 'Equipos Medicos', NULL, 'EQMEDICOS');


-- Almacen
INSERT INTO alm.talmacen (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_almacen, codigo, nombre, localizacion)
VALUES (1, NULL, '2012-11-13 09:16:48', '2012-11-13 09:16:48', 'activo', 1, 'ALM01', 'Almacen Cercado', NULL);

INSERT INTO alm.talmacen (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_almacen, codigo, nombre, localizacion)
VALUES (1, NULL, '2012-11-13 10:20:06', '2012-11-13 10:20:06', 'activo', 2, 'ALM02', 'Almacen Aduana Zofraco', NULL);


-- Item
INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:31:31', '2012-11-13 11:31:31', 'activo', 1, 2, 'HUM01', 'Humidificador Personal', NULL, NULL, NULL, NULL, NULL);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:32:06', '2012-11-13 11:32:06', 'activo', 2, 2, 'ECAR', 'Electrocardiógrafo avanzado pantalla táctil ', NULL, NULL, NULL, NULL, NULL);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:36:30', '2012-11-13 11:36:30', 'activo', 3, 3, 'LP001', 'Laptop Dell Latitude i7', 'RAM 8 GB, i7, HDD 750 GB', NULL, NULL, NULL, NULL);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:37:38', '2012-11-13 11:37:38', 'activo', 4, 3, 'IP001', 'Ipad 3ra Gen', NULL, NULL, NULL, NULL, NULL);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:38:14', '2012-11-13 11:38:14', 'activo', 5, 3, 'SW001', 'Switch Juniper SRX A1', NULL, NULL, NULL, NULL, NULL);


-- Movimiento_tipo
INSERT INTO alm.tmovimiento_tipo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_tipo, codigo, nombre)
VALUES (1, NULL, '2012-11-10 13:00:00', '2012-11-10 13:00:00', 'activo', 1, 'INGRESO', 'Ingreso de materiales a almacen');

INSERT INTO alm.tmovimiento_tipo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_tipo, codigo, nombre)
VALUES (1, NULL, '2012-11-10 13:01:46', '2012-11-10 13:01:46', 'activo', 2, 'SALIDA', 'Salida de materiales');


-- Movimiento
INSERT INTO alm.tmovimiento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento, id_movimiento_tipo, id_almacen, id_funcionario, id_proveedor, id_almacen_dest, fecha_mov, numero_mov, descripcion, observaciones, estado_mov)
VALUES (1, NULL, '2012-11-13 10:28:58', '2012-11-13 10:28:58', 'activo', 1, 1, 1, 1, 2, 1, '2012-11-13 12:00:00', 'ING001', 'Ingreso de Humidificados y cardiografos', NULL, 'borrador');

INSERT INTO alm.tmovimiento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento, id_movimiento_tipo, id_almacen, id_funcionario, id_proveedor, id_almacen_dest, fecha_mov, numero_mov, descripcion, observaciones, estado_mov)
VALUES (1, NULL, '2012-11-13 11:40:56', '2012-11-13 11:40:56', 'activo', 2, 1, 1, 1, 1, 1, '2012-11-13 11:44:02', 'ING002', 'Ingreso equipos de computacion', NULL, 'borrador');

INSERT INTO alm.tmovimiento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento, id_movimiento_tipo, id_almacen, id_funcionario, id_proveedor, id_almacen_dest, fecha_mov, numero_mov, descripcion, observaciones, estado_mov)
VALUES (1, NULL, '2012-11-13 11:42:38', '2012-11-13 11:42:38', 'activo', 3, 1, 1, 1, 1, 2, '2012-11-13 11:47:16', 'ING003', 'Ingreso equipos de computacion', NULL, 'finalizado');

INSERT INTO alm.tmovimiento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento, id_movimiento_tipo, id_almacen, id_funcionario, id_proveedor, id_almacen_dest, fecha_mov, numero_mov, descripcion, observaciones, estado_mov)
VALUES (1, NULL, '2012-11-13 11:51:08', '2012-11-13 11:51:08', 'activo', 4, 2, 1, 1, NULL, NULL, '2012-11-13 11:54:07', 'SAL001', 'Salida de equipos de computacion', NULL, 'finalizado');

INSERT INTO alm.tmovimiento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento, id_movimiento_tipo, id_almacen, id_funcionario, id_proveedor, id_almacen_dest, fecha_mov, numero_mov, descripcion, observaciones, estado_mov)
VALUES (1, NULL, '2012-11-13 11:52:49', '2012-11-13 11:52:49', 'activo', 5, 2, 1, 1, NULL, NULL, '2012-11-13 11:55:34', 'SAL002', 'Salida de equipos medicos', NULL, 'borrador');

INSERT INTO alm.tmovimiento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento, id_movimiento_tipo, id_almacen, id_funcionario, id_proveedor, id_almacen_dest, fecha_mov, numero_mov, descripcion, observaciones, estado_mov)
VALUES (1, NULL, '2012-11-13 11:40:56', '2012-11-13 11:40:56', 'activo', 6, 1, 1, 1, 1, 1, '2012-11-13 11:44:02', 'ING003', 'Ingreso equipos de red', NULL, 'borrador');

INSERT INTO alm.tmovimiento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento, id_movimiento_tipo, id_almacen, id_funcionario, id_proveedor, id_almacen_dest, fecha_mov, numero_mov, descripcion, observaciones, estado_mov)
VALUES (1, NULL, '2012-11-13 11:52:49', '2012-11-13 11:52:49', 'activo', 7, 2, 1, 1, NULL, NULL, '2012-11-13 11:55:34', 'SAL003', 'Salida de equipo de red', NULL, 'borrador');


-- Movimiento_det
INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:39:59', '2012-11-13 11:39:59', 'activo', 2, 1, 2, 5.000000, 20000.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 10:35:12', '2012-11-13 10:35:12', 'activo', 1, 1, 1, 10.000000, 2600.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:46:00', '2012-11-13 11:46:00', 'activo', 3, 2, 3, 20.000000, 11000.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:46:47', '2012-11-13 11:46:47', 'activo', 4, 2, 4, 4.000000, 3500.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:47:21', '2012-11-13 11:47:21', 'activo', 5, 3, 5, 10.000000, 21000.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:54:08', '2012-11-13 11:54:08', 'activo', 6, 4, 4, 2.000000, 3500.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:55:00', '2012-11-13 11:55:00', 'activo', 7, 4, 5, 1.000000, 21000.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:55:26', '2012-11-13 11:55:26', 'activo', 8, 5, 1, 4.000000, 2600.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:55:26', '2012-11-13 11:55:26', 'activo', 9, 5, 5, 1.000000, 20000.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:55:26', '2012-11-13 11:55:26', 'activo', 10, 6, 5, 2.000000, 20000.000000, NULL);

INSERT INTO alm.tmovimiento_det (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_movimiento_det, id_movimiento, id_item, cantidad, costo_unitario, fecha_caducidad)
VALUES (1, NULL, '2012-11-13 11:55:26', '2012-11-13 11:55:26', 'activo', 11, 7, 5, 1.000000, 21500.000000, NULL);

-- Actalizacion de Secuencias

/* SET search_path = segu, pg_catalog;
SELECT pg_catalog.setval('tpersona_id_persona_seq', 2, true);
--
-- Data for sequence param.tinstitucion_id_institucion_seq (OID = 1407919)
--
SET search_path = param, pg_catalog;
SELECT pg_catalog.setval('tinstitucion_id_institucion_seq', 3, true);
--
-- Data for sequence param.tproveedor_id_proveedor_seq (OID = 1408012)
--
SELECT pg_catalog.setval('tproveedor_id_proveedor_seq', 2, true);
--
-- Data for sequence orga.tfuncionario_id_funcionario_seq (OID = 1408268)
--
SET search_path = orga, pg_catalog;
SELECT pg_catalog.setval('tfuncionario_id_funcionario_seq', 1, true);
--
-- Data for sequence alm.tclasificacion_id_clasificacion_seq (OID = 1409018)
--
SET search_path = alm, pg_catalog;
SELECT pg_catalog.setval('tclasificacion_id_clasificacion_seq', 3, true);
--
-- Data for sequence alm.talmacen_id_almacen_seq (OID = 1409030)
--
SELECT pg_catalog.setval('talmacen_id_almacen_seq', 2, true);
--
-- Data for sequence alm.titem_id_item_seq (OID = 1409039)
--
SELECT pg_catalog.setval('titem_id_item_seq', 5, true);
--
-- Data for sequence alm.tmovimiento_tipo_id_movimiento_tipo_seq (OID = 1409060)
--
SELECT pg_catalog.setval('tmovimiento_tipo_id_movimiento_tipo_seq', 2, true);
--
-- Data for sequence alm.tmovimiento_id_movimiento_seq (OID = 1409069)
--
SELECT pg_catalog.setval('tmovimiento_id_movimiento_seq', 7, true);
--
-- Data for sequence alm.tmovimiento_det_id_movimiento_det_seq (OID = 1409081)
--
SELECT pg_catalog.setval('tmovimiento_det_id_movimiento_det_seq', 11, true);*/
