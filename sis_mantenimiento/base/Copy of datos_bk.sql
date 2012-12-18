----------------------------METADATOS-----------------
/*
*	Author: RCM
*	Date: 03/11/2012
*	Description: Build the menu definition and the composition
*/

insert into segu.tsubsistema(codigo,nombre,prefijo,nombre_carpeta) values
('GEM','Mantenimiento Industrial - Plantas y Estaciones','GM','mantenimiento');

/* (1) Menu definition*/

---------
--Level 1
---------
select pxp.f_insert_tgui ('GESTIÓN DE MANTENIMIENTO - PLANTAS Y ESTACIONES', '', 'GEM', 'si', 1, '', 1, '../../../lib/imagenes/gema32x32.png', '', 'GEM');

---------
--Level 2
---------
select pxp.f_insert_tgui ('Catálogos', 'Catálogos varios', 'GEM.1', 'si', 1, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('Equipos, Planificación y Seguimiento', 'Datos detallados de los equipos y Planificación del Mantenimiento', 'GEM.2', 'si', 2, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('Documentación', 'Archivos, Procedimientos , Instructivos, etc.', 'GEM.3', 'si', 3, '', 2, '', '', 'GEM');

---------
--Level 3
---------
select pxp.f_insert_tgui ('Proveedores', 'Registro de Proveedores', 'GEM.1.1', 'si', 1, 'sis_parametros/vista/proveedor/Proveedor.php', 3, '', 'proveedor', 'GEM');
select pxp.f_insert_tgui ('Metodologías', 'Registro de Metodologías', 'GEM.1.2', 'si', 3, 'sis_mantenimiento/vista/metodologia/Metodologia.php', 2, '', 'Metodologia', 'GEM');
select pxp.f_insert_tgui ('Tipos de Equipos', 'Registro de Tipos de Equipos', 'GEM.1.3', 'si', 3, 'sis_mantenimiento/vista/tipo_equipo/TipoEquipo.php', 3, '', 'TipoEquipo', 'GEM');
select pxp.f_insert_tgui ('Tipos de Mantenimiento', 'Registro de Tipos de Mantenimiento', 'GEM.1.4', 'si', 4, 'sis_mantenimiento/vista/tipo_mant/TipoMant.php', 3, '', 'TipoMant', 'GEM');
select pxp.f_insert_tgui ('Horarios', 'Registro de Horarios', 'GEM.1.5', 'si', 5, 'sis_organigrama/vista/tipo_horario/TipoHorario.php', 3, '', 'TipoHorario', 'GEM');
select pxp.f_insert_tgui ('Niveles Especialidades Técnicas', 'Registro de los niveles de especialidades técnicas', 'GEM.1.6', 'no', 6, 'sis_organigrama/vista/especialidad_nivel/EspecialidadNivel.php', 3, '', 'EspecialidadNivel', 'GEM');
select pxp.f_insert_tgui ('Especialidades Técnicas', 'Registro de especialidades técnicas', 'GEM.1.7', 'si', 7, 'sis_organigrama/vista/especialidad/Especialidad.php', 3, '', 'Especialidad', 'GEM');
select pxp.f_insert_tgui ('Funcionarios', 'Registro de Funcionarios', 'GEM.1.8', 'si', 8, 'sis_organigrama/vista/funcionario/Funcionario.php', 3, '', 'funcionario', 'GEM');
select pxp.f_insert_tgui ('Diagrama de Decisión', 'Registro Diagrama de Decisión', 'GEM.1.9', 'si', 9, 'sis_mantenimiento/vista/diagrama_decision/DiagramaDecision.php', 3, '', 'DiagramaDecision', 'GEM');
select pxp.f_insert_tgui ('Instrucciones de Seguridad', 'Registro de instrucciones de seguridad', 'GEM.1.10', 'si', 10, 'sis_mantenimiento/vista/instrucciones_seguridad/InstrucSeg.php', 3, '', 'InstrucSeg', 'GEM');

select pxp.f_insert_tgui ('Localizaciones', 'Registro de Localizaciones', 'GEM.2.1', 'si', 1, 'sis_mantenimiento/vista/localizacion/Localizacion.php', 3, '', 'Localizacion', 'GEM');
select pxp.f_insert_tgui ('Plantilla de Equipos', 'Registro Plantilla de Equipos', 'GEM.2.2', 'si', 2, 'sis_mantenimiento/vista/uni_cons/UniCons.php', 3, '', 'UniCons', 'GEM');
select pxp.f_insert_tgui ('Mantenimientos Predefinidos', 'Registro de Mantenimientos predefinidos', 'GEM.2.3', 'si', 3, 'sis_mantenimiento/vista/mant_predef/MantPredef.php', 3, '', 'MantPredef', 'GEM');
select pxp.f_insert_tgui ('Órdenes de Trabajo', 'Registro Órdenes de Trabajo', 'GEM.2.4', 'si', 4, 'sis_mantenimiento/vista/orden_trabajo/OrdenTrabajo.php', 3, '', 'OrdenTrabajo', 'GEM');
select pxp.f_insert_tgui ('Mediciones por Equipo', 'Registro de Mediciones por Equipo', 'GEM.2.5', 'si', 5, 'sis_mantenimiento/vista/equipo_medicion/EquipoMedicion.php', 3, '', 'EquipoMedicion', 'GEM');
select pxp.f_insert_tgui ('Eventos/Incidentes por Equipo', 'Registro de Eventos/Incidentes por equipo', 'GEM.2.6', 'si', 6, 'sis_mantenimiento/vista/equipo_evento/EquipoEvento.php', 3, '', 'EquipoEvento', 'GEM');

select pxp.f_insert_tgui ('Procedimientos, Instructivos ...', 'Registro de Procedimientos, Instructivos, etc.', 'GEM.3.1', 'si', 1, 'sis_mantenimiento/vista/documento/Documento.php', 3, '', 'Documento', 'GEM');
/*(2) Composition*/

---------
--Lvel 1
---------
select pxp.f_insert_testructura_gui ('GEM', 'SISTEMA');

---------
--Level 2
---------
select pxp.f_insert_testructura_gui ('GEM.1', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.2', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.3', 'GEM');

---------
--Level 3
---------
select pxp.f_insert_testructura_gui ('GEM.1.1', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.2', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.3', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.4', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.5', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.6', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.7', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.8', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.9', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.10', 'GEM.1');

select pxp.f_insert_testructura_gui ('GEM.2.1', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.2', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.3', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.4', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.5', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.6', 'GEM.2');

select pxp.f_insert_testructura_gui ('GEM.3.1', 'GEM.3');


select pxp.f_insert_tgui ('Ordenes de Trabajo', 'Ordenes de Trabajo', 'GEM.2.7', 'si', 1, '', 3, '', '', 'GEM');

select pxp.f_insert_tgui ('Registro - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.1', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/RegistrarOT.php', 4, '', 'RegistrarOT', 'GEM');
select pxp.f_insert_tgui ('Ejecución - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.2', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/EjecutarOT.php', 4, '', 'EjecutarOT', 'GEM');
select pxp.f_insert_tgui ('Revisión - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.3', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/RevisarOT.php', 4, '', 'RevisarOT', 'GEM');

select pxp.f_insert_testructura_gui ('GEM.2.7', 'GEM.2');

select pxp.f_insert_testructura_gui ('GEM.2.7.1', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.2.7.2', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.2.7.3', 'GEM.2.7')






--------------------- FIN METADATOS-----------------





select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Borrador');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Listo');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Abierto');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Cerrado');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Revisado');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_prior','Alta');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_prior','Media');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_prior','Baja');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_tipo','Preventivo');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_tipo','Correctivo');
select pxp.f_add_catalog('GEM','ttpm_tarjeta_cat_tipo_instalacion','Estacion');
select pxp.f_add_catalog('GEM','ttpm_tarjeta_cat_tipo_instalacion','Planta');
select pxp.f_add_catalog('GEM','tanalisis_porque_cat_estado_analisis_porque','En proceso');
select pxp.f_add_catalog('GEM','tanalisis_porque_cat_estado_analisis_porque','Terminado');

select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Gerente');
select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Ingeniero');
select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Jefe');
select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Operador');


--RAC 06-12-2012


/* Data for the 'param.tconfig_alarma' table  (Records 1 - 2) */

INSERT INTO param.tconfig_alarma ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_config_alarma", "codigo", "descripcion", "dias", "id_subsistema")
VALUES (1, NULL, E'2012-12-06 00:00:00', NULL, E'activo', 2, E'torden_trabajo', NULL, 1, 6);

INSERT INTO param.tconfig_alarma ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_config_alarma", "codigo", "descripcion", "dias", "id_subsistema")
VALUES (1, 1, E'2012-12-06 00:00:00', E'2012-12-06 07:13:57.935', E'activo', 1, E'tcalendario_planificado', NULL, 3, 6);


