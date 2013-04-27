/***********************************I-DAT-RAC-GEN-0-02/01/2013****************************************/
/*
*	Author: RAC
*	Date: 21/12/2012
*	Description: Build the menu definition and the composition
*/
/*

Para  definir la la metadata, menus, roles, etc

1) sincronice  las funciones y procedimientos del sistema
2)  verifique que la primera linea de los datos sea la insercion del sistema correspondiente
3)  exporte los datos   del sistema a archivo SQL (desde la interfaz del sistema en sis_seguridad), 
     verifique que la codificación  se mantenga en UTF8 para no distorsionar los caracteres especiales
4)  remplace los sectores correspondientes en el archivo datos.sql   (el orden es importante)  
                             menu, 
                             funciones, 
                             procedimietnos, etc

*/

insert into segu.tsubsistema(codigo,nombre,prefijo,nombre_carpeta) values
('GEM','Mantenimiento Industrial - Plantas y Estaciones','GM','mantenimiento');


-------------------------------------
--DEFINICION DE INTERFACES
-------------------------------------

select pxp.f_insert_tgui ('GESTIÓN DE MANTENIMIENTO - PLANTAS Y ESTACIONES', '', 'GEM', 'si', 1, '', 1, '../../../lib/imagenes/gema32x32.png', '', 'GEM');
select pxp.f_insert_tgui ('Catálogos', 'Catálogos varios', 'GEM.1', 'si', 1, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('Equipos, Planificación y Seguimiento', 'Datos detallados de los equipos y Planificación del Mantenimiento', 'GEM.2', 'si', 2, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('Documentación', 'Archivos, Procedimientos , Instructivos, etc.', 'GEM.3', 'si', 3, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('Proveedores', 'Registro de Proveedores', 'GEM.1.1', 'si', 1, 'sis_parametros/vista/proveedor/Proveedor.php', 3, '', 'proveedor', 'GEM');
select pxp.f_insert_tgui ('Metodologías', 'Registro de Metodologías', 'GEM.1.2', 'si', 3, 'sis_mantenimiento/vista/metodologia/Metodologia.php', 2, '', 'Metodologia', 'GEM');
select pxp.f_insert_tgui ('Tipos de Equipos', 'Registro de Tipos de Equipos', 'GEM.1.3', 'si', 3, 'sis_mantenimiento/vista/tipo_equipo/TipoEquipo.php', 3, '', 'TipoEquipo', 'GEM');
select pxp.f_insert_tgui ('Tipos de Mantenimiento', 'Registro de Tipos de Mantenimiento', 'GEM.1.4', 'si', 4, 'sis_mantenimiento/vista/tipo_mant/TipoMant.php', 3, '', 'TipoMant', 'GEM');
select pxp.f_insert_tgui ('Horarios', 'Registro de Horarios', 'GEM.1.5', 'si', 5, 'sis_organigrama/vista/tipo_horario/TipoHorario.php', 3, '', 'TipoHorario', 'GEM');
select pxp.f_insert_tgui ('Niveles Especialidades Técnicas', 'Registro de los niveles de especialidades técnicas', 'GEM.1.6', 'no', 6, 'sis_organigrama/vista/especialidad_nivel/EspecialidadNivel.php', 3, '', 'EspecialidadNivel', 'GEM');
select pxp.f_insert_tgui ('Especialidades Técnicas', 'Registro de especialidades técnicas', 'GEM.1.7', 'si', 7, 'sis_organigrama/vista/especialidad/Especialidad.php', 3, '', 'Especialidad', 'GEM');
select pxp.f_insert_tgui ('Funcionarios', 'Registro de Funcionarios', 'GEM.1.8', 'si', 8, 'sis_mantenimiento/vista/funcionario/Funcionario.php', 3, '', 'FuncionarioGem', 'GEM');
select pxp.f_insert_tgui ('Diagrama de Decisión', 'Registro Diagrama de Decisión', 'GEM.1.9', 'si', 9, 'sis_mantenimiento/vista/diagrama_decision/DiagramaDecision.php', 3, '', 'DiagramaDecision', 'GEM');
select pxp.f_insert_tgui ('Instrucciones de Seguridad', 'Registro de instrucciones de seguridad', 'GEM.1.10', 'si', 10, 'sis_mantenimiento/vista/instrucciones_seguridad/InstrucSeg.php', 3, '', 'InstrucSeg', 'GEM');
select pxp.f_insert_tgui ('Localizaciones', 'Registro de Localizaciones', 'GEM.2.1', 'si', 1, 'sis_mantenimiento/vista/localizacion/Localizacion.php', 3, '', 'Localizacion', 'GEM');
select pxp.f_insert_tgui ('Plantilla de Equipos', 'Registro Plantilla de Equipos', 'GEM.2.2', 'si', 2, 'sis_mantenimiento/vista/uni_cons/UniCons.php', 3, '', 'UniCons', 'GEM');
select pxp.f_insert_tgui ('Mantenimientos Predefinidos', 'Registro de Mantenimientos predefinidos', 'GEM.2.3', 'si', 3, 'sis_mantenimiento/vista/mant_predef/MantPredef.php', 3, '', 'MantPredef', 'GEM');
select pxp.f_insert_tgui ('Eventos/Incidentes por Equipo', 'Registro de Eventos/Incidentes por equipo', 'GEM.2.6', 'no', 6, 'sis_mantenimiento/vista/equipo_evento/EquipoEvento.php', 3, '', 'EquipoEvento', 'GEM');
select pxp.f_insert_tgui ('Procedimientos, Instructivos ...', 'Registro de Procedimientos, Instructivos, etc.', 'GEM.3.1', 'si', 1, 'sis_mantenimiento/vista/documento/Documento.php', 3, '', 'Documento', 'GEM');
select pxp.f_insert_tgui ('Fallas/Eventos Equipos...', 'Registro de Fallas/Eventos Equipos', 'GEM.3.11', 'si', 5, 'sis_mantenimiento/vista/falla_evento/FallaEventoExterno.php', 3, '', 'FallaEventoExterno', 'GEM');
select pxp.f_insert_tgui ('Ordenes de Trabajo', 'Ordenes de Trabajo', 'GEM.2.7', 'si', 1, '', 3, '', '', 'GEM');
select pxp.f_insert_tgui ('Emisión - Orden Trabajo', 'Emisión de Ordenes de Trabajo', 'GEM.2.7.1', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/RegistrarOT.php', 4, '', 'RegistrarOT', 'GEM');
select pxp.f_insert_tgui ('Ejecución - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.2', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/EjecutarOT.php', 4, '', 'EjecutarOT', 'GEM');
select pxp.f_insert_tgui ('Revisión - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.3', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/RevisarOT.php', 4, '', 'RevisarOT', 'GEM');
select pxp.f_insert_testructura_gui ('GEM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('GEM.3', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.2', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.1', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.3.11', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.10', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.9', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.8', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.7', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.6', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.5', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.4', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.3', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.2', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.1.1', 'GEM.1');
select pxp.f_insert_testructura_gui ('GEM.2.7', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.6', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.3', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.2', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.1', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.3.1', 'GEM.3');
select pxp.f_insert_testructura_gui ('GEM.2.7.3', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.2.7.2', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.2.7.1', 'GEM.2.7');


----------------------------------------------
--  DEF DE FUNCIONES
--------------------------------------------------

select pxp.f_insert_tfuncion ('gem.f_verifica_alarma_gem', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_tipo_mant_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_equipo_medicion_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_instruc_seg_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_analisis_porque_sol_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_modo_falla_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_verifica_calendario_equipo', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_tipo_equipo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_clon_unicons', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_localizacion_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_analisis_porque_sol_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_modo_falla_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_uni_cons_archivo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_incidente_equipo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_calendario_meses_det_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_localizacion_med_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_tpm_tarjeta_det_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_localizacion_usuario_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_actividad_ot_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_funcion_analisis_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_plan_mant_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_sinc_usuarios_uni_cons', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_actividad_ot_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_mant_predef_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_uni_cons_mant_predef_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_tipo_equipo_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_equipo_variable_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_falla_evento_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_orden_trabajo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_uni_cons_proveedor_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_uni_cons_mant_predef_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_equipo_variable_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_analisis_porque_det_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_metodologia_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_calendario_planificado_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_recurso_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_uni_cons_archivo_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_diagrama_decision_accion_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_centro_costo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_uni_cons_proveedor_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_funcionario_honorario_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_addunicon_recursivo', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_uni_cons_det_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_localizacion_med_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_analisis_mant_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_diagrama_decision_accion_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_instruc_seg_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_centro_costo_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_uni_cons_item_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_mant_predef_det_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_funcion_falla_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_trg_torden_trabajo', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_calendario_planificado_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_documento_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_formulas_indicadores', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_incidente_equipo_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_diagrama_decision_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_funcionario_honorario_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_falla_evento_externo_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_falla_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_tipo_variable_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_documento_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_metodologia_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_localizacion_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_funcion_falla_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_falla_evento_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_analisis_porque_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_orden_trabajo_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_mant_predef_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_falla_evento_externo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_recurso_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_tpm_tarjeta_det_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_plan_mant_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_equipo_medicion_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_uni_cons_item_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_diagrama_decision_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_uni_cons_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_genera_calendario_equipo', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_formula_indicadores_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_tpm_tarjeta_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_tarea_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_tpm_tarjeta_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_analisis_porque_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_analisis_porque_det_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_uni_cons_det_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_funcion_analisis_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_uni_cons_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_analisis_mant_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_mant_predef_det_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_tarea_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_falla_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_tipo_variable_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_llena_tt_calendario_equipo', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_localizacion_usuario_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_tipo_mant_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.f_generar_orden_trabajo', 'Funcion para tabla     ', 'GEM');



---------------------------------
--DEF DE PROCEDIMIETOS
---------------------------------


select pxp.f_insert_tprocedimiento ('GEM_GETIMA_INS', '	Insercion de registros', 'si', '', '', 'gem.f_tipo_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_GETIMA_MOD', '	Modificacion de registros', 'si', '', '', 'gem.f_tipo_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_GETIMA_ELI', '	Eliminacion de registros', 'si', '', '', 'gem.f_tipo_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMEDI_INS', '	Insercion de registros', 'si', '', '', 'gem.ft_equipo_medicion_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMEDI_MOD', '	Modificacion de registros', 'si', '', '', 'gem.ft_equipo_medicion_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMEDI_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_equipo_medicion_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQUMEDDIN_INS', '	Insercion de mediciones desde la interfaz equipo medicion dinamico
 	', 'si', '', '', 'gem.ft_equipo_medicion_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQUMEDDIN_ELI', '	Eliminacion de mediciones desde la interfaz equipo medicion dinamico
 	', 'si', '', '', 'gem.ft_equipo_medicion_ime');
select pxp.f_insert_tprocedimiento ('GM_INSEG_SEL', '	Consulta de datos', 'si', '', '', 'gem.ft_instruc_seg_sel');
select pxp.f_insert_tprocedimiento ('GM_INSEG_CONT', '	Conteo de registros', 'si', '', '', 'gem.ft_instruc_seg_sel');
select pxp.f_insert_tprocedimiento ('GM_PORSOL_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_analisis_porque_sol_sel');
select pxp.f_insert_tprocedimiento ('GM_PORSOL_REP', '	Consulta para reporte de datos
 	', 'si', '', '', 'gem.ft_analisis_porque_sol_sel');
select pxp.f_insert_tprocedimiento ('GM_PORSOL_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_sol_sel');
select pxp.f_insert_tprocedimiento ('GEM_MODFALLA_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_modo_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_MODFALLA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_modo_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_MODFALLA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_modo_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.f_tipo_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_tipo_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_tipo_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_loc_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_localizacion_sel');
select pxp.f_insert_tprocedimiento ('GEM_LOC_ARB_SEL', '	Consulta de datos en arbol para localizaciones
 	', 'si', '', '', 'gem.f_localizacion_sel');
select pxp.f_insert_tprocedimiento ('GEM_loc_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_localizacion_sel');
select pxp.f_insert_tprocedimiento ('GM_PORSOL_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_sol_ime');
select pxp.f_insert_tprocedimiento ('GM_PORSOL_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_sol_ime');
select pxp.f_insert_tprocedimiento ('GM_PORSOL_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_sol_ime');
select pxp.f_insert_tprocedimiento ('GEM_MODFALLA_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_modo_falla_sel');
select pxp.f_insert_tprocedimiento ('GEM_MODFALLA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_modo_falla_sel');
select pxp.f_insert_tprocedimiento ('GEM_UNIDOC_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_archivo_ime');
select pxp.f_insert_tprocedimiento ('GEM_UNIDOC_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_archivo_ime');
select pxp.f_insert_tprocedimiento ('GEM_UNIDOC_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_archivo_ime');
select pxp.f_insert_tprocedimiento ('GEM_UPARCH_MOD', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'gem.ft_uni_cons_archivo_ime');
select pxp.f_insert_tprocedimiento ('GEM_UPARCHVER_MOD', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'gem.ft_uni_cons_archivo_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEEQIN_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_incidente_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEEQIN_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_incidente_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEEQIN_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_incidente_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_CALMESDET_SEL', '	define las columnas de manrea dinamica del calendario planificado
 	', 'si', '', '', 'gem.f_calendario_meses_det_sel');
select pxp.f_insert_tprocedimiento ('GEM_PLANCALEQ_SEL', '	  consulta de manera recursica el calendario de los equipos
                      para la localizacion indicada
', 'si', '', '', 'gem.f_calendario_meses_det_sel');
select pxp.f_insert_tprocedimiento ('GEM_PLANCALEQ_CONT', '	  Contadora para la consulta de  recursica del calendario de los equipos
                      para la localizacion indicada
', 'si', '', '', 'gem.f_calendario_meses_det_sel');
select pxp.f_insert_tprocedimiento ('GM_LOCMED_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_localizacion_med_sel');
select pxp.f_insert_tprocedimiento ('GM_LOCMED_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_localizacion_med_sel');
select pxp.f_insert_tprocedimiento ('GM_INDICA_SEL', '	Devuelve los indicadores
 	', 'si', '', '', 'gem.ft_localizacion_med_sel');
select pxp.f_insert_tprocedimiento ('GM_INDICA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_localizacion_med_sel');
select pxp.f_insert_tprocedimiento ('GM_TARDET_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_det_sel');
select pxp.f_insert_tprocedimiento ('GM_TARDET_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_det_sel');
select pxp.f_insert_tprocedimiento ('GM_LOCUSU_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_localizacion_usuario_ime');
select pxp.f_insert_tprocedimiento ('GM_LOCUSU_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_localizacion_usuario_ime');
select pxp.f_insert_tprocedimiento ('GM_LOCUSU_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_localizacion_usuario_ime');
select pxp.f_insert_tprocedimiento ('GEM_ACTI_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_actividad_ot_sel');
select pxp.f_insert_tprocedimiento ('GEM_ACTI_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_actividad_ot_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFUNC_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_funcion_analisis_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFUNC_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_funcion_analisis_sel');
select pxp.f_insert_tprocedimiento ('GEM_PLAMA_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_plan_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_PLAMA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_plan_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_PLAMA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_plan_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_ACTI_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_actividad_ot_ime');
select pxp.f_insert_tprocedimiento ('GEM_ACTI_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_actividad_ot_ime');
select pxp.f_insert_tprocedimiento ('GEM_ACTI_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_actividad_ot_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMAPR_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_mant_predef_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMAPR_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_mant_predef_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMAPR_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_mant_predef_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEEQMA_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_uni_cons_mant_predef_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEEQMA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_uni_cons_mant_predef_sel');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_tipo_equipo_sel');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_tipo_equipo_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQV_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.f_equipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQV_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_equipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQV_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_equipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEV_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_falla_evento_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEV_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_falla_evento_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEOOTT_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_orden_trabajo_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEOOTT_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_orden_trabajo_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEOOTT_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_orden_trabajo_ime');
select pxp.f_insert_tprocedimiento ('GEM_PROCESSOT_MOD', '	Cambio de estado OIT
 	', 'si', '', '', 'gem.ft_orden_trabajo_ime');
select pxp.f_insert_tprocedimiento ('GEM_unipro_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_proveedor_ime');
select pxp.f_insert_tprocedimiento ('GEM_unipro_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_proveedor_ime');
select pxp.f_insert_tprocedimiento ('GEM_unipro_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_proveedor_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEEQMA_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_mant_predef_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEEQMA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_mant_predef_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEEQMA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_mant_predef_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQV_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_equipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQV_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_equipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQUVAR_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_equipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQUVAR_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_equipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GM_DET_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_det_ime');
select pxp.f_insert_tprocedimiento ('GM_DET_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_det_ime');
select pxp.f_insert_tprocedimiento ('GM_DET_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_det_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMETO_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.f_metodologia_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMETO_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_metodologia_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMETO_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_metodologia_ime');
select pxp.f_insert_tprocedimiento ('GEM_CALE_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.f_calendario_planificado_ime');
select pxp.f_insert_tprocedimiento ('GEM_CALE_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_calendario_planificado_ime');
select pxp.f_insert_tprocedimiento ('GEM_CALE_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_calendario_planificado_ime');
select pxp.f_insert_tprocedimiento ('GEM_OBTCALPLA_EMI', '	Obtiene datos del calendario planificado indicado
 	', 'si', '', '', 'gem.f_calendario_planificado_ime');
select pxp.f_insert_tprocedimiento ('GEM_UPDCALPLA_IME', '	Modifica el calendario planificado
 	', 'si', '', '', 'gem.f_calendario_planificado_ime');
select pxp.f_insert_tprocedimiento ('GEM_RECACTI_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_recurso_ime');
select pxp.f_insert_tprocedimiento ('GEM_RECACTI_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_recurso_ime');
select pxp.f_insert_tprocedimiento ('GEM_RECURSO_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_recurso_ime');
select pxp.f_insert_tprocedimiento ('GEM_UNIDOC_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_uni_cons_archivo_sel');
select pxp.f_insert_tprocedimiento ('GEM_ARCHVER_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_uni_cons_archivo_sel');
select pxp.f_insert_tprocedimiento ('GEM_UNIDOC_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_uni_cons_archivo_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDIAC_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_diagrama_decision_accion_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDIAC_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_diagrama_decision_accion_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDIARB_SEL', 'Consulta de datos
', 'si', '', '', 'gem.ft_diagrama_decision_accion_sel');
select pxp.f_insert_tprocedimiento ('GM_cencos_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('GM_cencos_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('GM_cencos_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('GEM_unipro_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_uni_cons_proveedor_sel');
select pxp.f_insert_tprocedimiento ('GEM_unipro_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_uni_cons_proveedor_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFUHO_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_funcionario_honorario_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFUHO_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_funcionario_honorario_sel');
select pxp.f_insert_tprocedimiento ('GM_UCDET_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.f_uni_cons_det_ime');
select pxp.f_insert_tprocedimiento ('GM_UCDET_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_uni_cons_det_ime');
select pxp.f_insert_tprocedimiento ('GM_UCDET_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_uni_cons_det_ime');
select pxp.f_insert_tprocedimiento ('GM_LOCMED_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_localizacion_med_ime');
select pxp.f_insert_tprocedimiento ('GM_LOCMED_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_localizacion_med_ime');
select pxp.f_insert_tprocedimiento ('GM_LOCMED_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_localizacion_med_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEANMA_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_analisis_mant_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEANMA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_analisis_mant_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDIAC_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_diagrama_decision_accion_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDIAC_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_diagrama_decision_accion_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDIAC_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_diagrama_decision_accion_ime');
select pxp.f_insert_tprocedimiento ('GM_INSEG_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_instruc_seg_ime');
select pxp.f_insert_tprocedimiento ('GM_INSEG_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_instruc_seg_ime');
select pxp.f_insert_tprocedimiento ('GM_INSEG_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_instruc_seg_ime');
select pxp.f_insert_tprocedimiento ('GM_cencos_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('GM_cencos_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('GEM_UNITEM_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_uni_cons_item_sel');
select pxp.f_insert_tprocedimiento ('GEM_UNITEM_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_uni_cons_item_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDETM_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_mant_predef_det_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDETM_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_mant_predef_det_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFALL_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_funcion_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFALL_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_funcion_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFALL_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_funcion_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_CALE_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_calendario_planificado_sel');
select pxp.f_insert_tprocedimiento ('GEM_CALE_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_calendario_planificado_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDOCU_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_documento_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDOCUVER_SEL', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_documento_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDOCU_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'gem.ft_documento_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEEQIN_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_incidente_equipo_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEEQIN_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_incidente_equipo_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDIDE_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_diagrama_decision_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDIDE_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_diagrama_decision_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDIDE_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_diagrama_decision_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFUHO_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_funcionario_honorario_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFUHO_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_funcionario_honorario_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFUHO_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_funcionario_honorario_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEVE_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_falla_evento_externo_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEVE_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_falla_evento_externo_sel');
select pxp.f_insert_tprocedimiento ('GEM_FAL_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_falla_sel');
select pxp.f_insert_tprocedimiento ('GEM_FAL_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_falla_sel');
select pxp.f_insert_tprocedimiento ('GEM_TVA_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.f_tipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_TVA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_tipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_TVA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_tipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDOCU_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDOCU_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDOCU_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('GEM_UPDOCU_MOD', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'gem.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('GEM_UPDOCVER_MOD', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'gem.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEMETO_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_metodologia_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEMETO_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_metodologia_sel');
select pxp.f_insert_tprocedimiento ('GEM_loc_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.f_localizacion_ime');
select pxp.f_insert_tprocedimiento ('GEM_loc_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_localizacion_ime');
select pxp.f_insert_tprocedimiento ('GEM_SINCUSUUNI_IME', '	Sincronizacion de usarios por localizacion y unidades contructivas
 	', 'si', '', '', 'gem.f_localizacion_ime');
select pxp.f_insert_tprocedimiento ('GEM_loc_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_localizacion_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFALL_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_funcion_falla_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFALL_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_funcion_falla_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEV_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_falla_evento_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEV_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_falla_evento_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEV_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_falla_evento_ime');
select pxp.f_insert_tprocedimiento ('GM_ANAPOR_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_ime');
select pxp.f_insert_tprocedimiento ('GM_ANAPOR_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_ime');
select pxp.f_insert_tprocedimiento ('GM_ANAPOR_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEOOTT_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_orden_trabajo_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEOOTT_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_orden_trabajo_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEMAPR_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_mant_predef_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEMAPR_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_mant_predef_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEMPUC_SEL', '	Consulta de datos para obtener los mant. predef en función del id_tipo_equipo a partir de id_uni_cons
 	', 'si', '', '', 'gem.ft_mant_predef_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEMPUC_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_mant_predef_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEVE_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_falla_evento_externo_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEVE_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_falla_evento_externo_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFAEVE_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_falla_evento_externo_ime');
select pxp.f_insert_tprocedimiento ('GEM_RECACTI_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_recurso_sel');
select pxp.f_insert_tprocedimiento ('GEM_RECOT_SEL', '	Obtiene recursos a partir de 1 OT.
 	', 'si', '', '', 'gem.ft_recurso_sel');
select pxp.f_insert_tprocedimiento ('GEM_RECACTI_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_recurso_sel');
select pxp.f_insert_tprocedimiento ('GM_TARDET_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_det_ime');
select pxp.f_insert_tprocedimiento ('GM_TARDET_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_det_ime');
select pxp.f_insert_tprocedimiento ('GM_TARDET_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_det_ime');
select pxp.f_insert_tprocedimiento ('GEM_PLAMA_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_plan_mant_sel');
select pxp.f_insert_tprocedimiento ('GEM_PLAMA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_plan_mant_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEMEDI_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_equipo_medicion_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEMEDI_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_equipo_medicion_sel');
select pxp.f_insert_tprocedimiento ('GEM_MEDGRA_SEL', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_equipo_medicion_sel');
select pxp.f_insert_tprocedimiento ('GEM_MEDGRA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_equipo_medicion_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQMEDI_SEL', '	  coonsulta dinamica a las mediciones del equipo indicado
', 'si', '', '', 'gem.ft_equipo_medicion_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQMEDI_CONT', '	Conteo de registros de la consulta dinamica de mediciones por quipo
 	', 'si', '', '', 'gem.ft_equipo_medicion_sel');
select pxp.f_insert_tprocedimiento ('GEM_UNITEM_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_item_ime');
select pxp.f_insert_tprocedimiento ('GEM_UNITEM_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_item_ime');
select pxp.f_insert_tprocedimiento ('GEM_UNITEM_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_uni_cons_item_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDIDE_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_diagrama_decision_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEDIDE_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_diagrama_decision_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUC_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUC_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCPLA_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCPLA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCPLAARB_SEL', '	para el litado de unidades constructivas desde el arbol de localizaciones
                    no tiene contador solo filtro por id_localizacion
 	', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCHIJO_SEL', '	Para listar las unidades cosntructivas segun el id_uni_cons_padre de la unidad constructiva
 	', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCGET_SEL', 'para obtener una unidad constructiva
', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCGET_CONT', 'Conteo de registros
', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCHIJOS_SEL', 'obtiene los hijos de una unidad constructiva en su primer nivel
', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCHIJOS_CONT', 'Conteo de registros
', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCDETALLE_SEL', 'obtiene los pares ordenados del detalle de una unidad constructiva
', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCDETALLE_CONT', 'Conteo de registros
', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUCLOC_SEL', 'Obtiene los registros de una unidades constructivas por localizacion
', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_FORIND_SEL', '	Resultado de las formulas de los indicadores
 	', 'si', '', '', 'gem.f_formula_indicadores_sel');
select pxp.f_insert_tprocedimiento ('GEM_FORIND_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_formula_indicadores_sel');
select pxp.f_insert_tprocedimiento ('GM_TARTPM_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_ime');
select pxp.f_insert_tprocedimiento ('GM_TARTPM_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_ime');
select pxp.f_insert_tprocedimiento ('GM_TARTPM_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_ime');
select pxp.f_insert_tprocedimiento ('GEM_TARE_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_tarea_ime');
select pxp.f_insert_tprocedimiento ('GEM_TARE_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_tarea_ime');
select pxp.f_insert_tprocedimiento ('GEM_TARE_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_tarea_ime');
select pxp.f_insert_tprocedimiento ('GM_TARTPM_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_sel');
select pxp.f_insert_tprocedimiento ('GM_TARTPM_REP', '	Consulta de datos para el reporte
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_sel');
select pxp.f_insert_tprocedimiento ('GM_TARTPM_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_tpm_tarjeta_sel');
select pxp.f_insert_tprocedimiento ('GM_ANAPOR_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_analisis_porque_sel');
select pxp.f_insert_tprocedimiento ('GM_ANAPOR_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_sel');
select pxp.f_insert_tprocedimiento ('GM_ANAPOR_REP', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_analisis_porque_sel');
select pxp.f_insert_tprocedimiento ('GM_DET_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_analisis_porque_det_sel');
select pxp.f_insert_tprocedimiento ('GM_DET_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_analisis_porque_det_sel');
select pxp.f_insert_tprocedimiento ('GM_UCDET_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_uni_cons_det_sel');
select pxp.f_insert_tprocedimiento ('GM_UCDET_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_uni_cons_det_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEFUNC_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_funcion_analisis_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFUNC_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_funcion_analisis_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEFUNC_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_funcion_analisis_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUC_INS', '	La interfaz funciona para TUC y UC
                    Insercion de Tipos de Unidades contructivas en estado borrador 
                    Inerta Unidad Contructivas
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUC_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUCGENCAL_MOD', '	Modificacion la unidad construtiva para incluir o no incluir en la generacion de calendario
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUCESTBL_MOD', '	Bloquea y Desbloquea, solo se utiliza para el tuc tipo raiz
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_ADDUC_MOD', '	Generate unicons fron template tipo_cuni_cons
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_VERCALGEN_MOD', '	Verifica si tiene calendario generados para lanzar un mensaje 
                     de advertencia si no tiene procesde con la generacion
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_GENCAL_MOD', '	Genera calendario para los quipos seleccionados
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUC_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_INACUC_UPD', '	Inactiva unidad constructiva
 	', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEANMA_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_analisis_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEANMA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_analisis_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEANMA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_analisis_mant_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDETM_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.ft_mant_predef_det_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDETM_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.ft_mant_predef_det_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEDETM_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.ft_mant_predef_det_ime');
select pxp.f_insert_tprocedimiento ('GEM_TARE_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_tarea_sel');
select pxp.f_insert_tprocedimiento ('GEM_TARE_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_tarea_sel');
select pxp.f_insert_tprocedimiento ('GEM_FAL_INS', '	Insercion de registros
 	', 'si', '', '', 'gem.f_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_FAL_MOD', '	Modificacion de registros
 	', 'si', '', '', 'gem.f_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_FAL_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'gem.f_falla_ime');
select pxp.f_insert_tprocedimiento ('GEM_TVA_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_tipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GEM_TVA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_tipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GM_LOCUSU_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.ft_localizacion_usuario_sel');
select pxp.f_insert_tprocedimiento ('GM_LOCUSU_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.ft_localizacion_usuario_sel');
select pxp.f_insert_tprocedimiento ('GEM_GETIMA_SEL', '	Consulta de datos
 	', 'si', '', '', 'gem.f_tipo_mant_sel');
select pxp.f_insert_tprocedimiento ('GEM_GETIMA_CONT', '	Conteo de registros
 	', 'si', '', '', 'gem.f_tipo_mant_sel');
select pxp.f_insert_tprocedimiento ('GEM_GENEOT_GEN', '	Insercion de registros
 	', 'si', '', '', 'gem.f_generar_orden_trabajo');
-----------------------------------
--DEF PROdecimientos por interfaz
---------------------------------- 




select pxp.f_insert_tprocedimiento_gui ('GEM_GETIMA_INS', 'GEM.1.4', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_GETIMA_SEL', 'GEM.1.4', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_GETIMA_MOD', 'GEM.1.4', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_GETIMA_CONT', 'GEM.1.4', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_GETIMA_ELI', 'GEM.1.4', 'si');



---------------------------------------
--DEF DE ROLES
---------------------------------- 


select pxp.f_insert_trol ('ROL para probar metaprocesos ', 'PROBAR ROLES', 'GEM');

select pxp.f_insert_tgui_rol ('GEM', 'PROBAR ROLES');
select pxp.f_insert_tgui_rol ('GEM.1', 'PROBAR ROLES');
select pxp.f_insert_tgui_rol ('GEM.1.4', 'PROBAR ROLES');



select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_GETIMA_INS', 'GEM.1.4');
select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_GETIMA_SEL', 'GEM.1.4');
select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_GETIMA_MOD', 'GEM.1.4');
select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_GETIMA_CONT', 'GEM.1.4');
select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_GETIMA_ELI', 'GEM.1.4');





------------------------------
--DEF DE CATALOGOS
-------------------------

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

-------------------------------------------
--DEF DE ALARMAS
-------------------------------------------

--RAC 06-12-2012


/* Data for the 'param.tconfig_alarma' table  (Records 1 - 2) */

INSERT INTO param.tconfig_alarma ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_config_alarma", "codigo", "descripcion", "dias", "id_subsistema")
VALUES (1, NULL, E'2012-12-06 00:00:00', NULL, E'activo', 2, E'torden_trabajo', NULL, 1, 6);

INSERT INTO param.tconfig_alarma ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_config_alarma", "codigo", "descripcion", "dias", "id_subsistema")
VALUES (1, 1, E'2012-12-06 00:00:00', E'2012-12-06 07:13:57.935', E'activo', 1, E'tcalendario_planificado', NULL, 3, 6);
/***********************************F-DAT-RAC-GEM-0-02/01/2013****************************************/

/***********************************I-DAT-RCM-GEM-36-02/01/2013****************************************/
--NUEVA INTERFAZ: SOLICITUD DE ORDEN DE TRABAJO
select pxp.f_insert_tgui ('Solicitud - Orden Trabajo', 'Registro de Solicitudes de Ordenes de Trabajo', 'GEM.2.7.4', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo_sol/OrdenTrabajoSol.php', 4, '', 'OrdenTrabajoSol', 'GEM');

select pxp.f_insert_testructura_gui ('GEM.2.7.4', 'GEM.2.7');

select pxp.f_insert_tfuncion ('gem.ft_orden_trabajo_sol_sel', 'Funcion para tabla', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_orden_trabajo_sol_ime', 'Funcion para tabla', 'GEM');

select pxp.f_insert_tprocedimiento ('GEM_SOLORD_INS', '	Insercion de registros', 'si', '', '', 'gem.ft_orden_trabajo_sol_ime');
select pxp.f_insert_tprocedimiento ('GEM_SOLORD_MOD', '	Modificacion de registros', 'si', '', '', 'gem.ft_orden_trabajo_sol_ime');
select pxp.f_insert_tprocedimiento ('GEM_SOLORD_ELI', '	Eliminacion de registros', 'si', '', '', 'gem.ft_orden_trabajo_sol_ime');
select pxp.f_insert_tprocedimiento ('GEM_SOLORD_SEL', '	Consulta de datos', 'si', '', '', 'gem.ft_orden_trabajo_sol_sel');
select pxp.f_insert_tprocedimiento ('GEM_SOLORD_CONT', '	Conteo de registros', 'si', '', '', 'gem.ft_orden_trabajo_sol_sel');

select pxp.f_insert_tprocedimiento_gui ('GEM_SOLORD_INS', 'GEM.2.7.4', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_SOLORD_SEL', 'GEM.2.7.4', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_SOLORD_MOD', 'GEM.2.7.4', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_SOLORD_CONT', 'GEM.2.7.4', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_SOLORD_ELI', 'GEM.2.7.4', 'si');

select pxp.f_insert_tgui_rol ('GEM.2.7.4', 'PROBAR ROLES');

select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_SOLORD_INS', 'GEM.2.7.4');
select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_SOLORD_SEL', 'GEM.2.7.4');
select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_SOLORD_MOD', 'GEM.2.7.4');
select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_SOLORD_CONT', 'GEM.2.7.4');
select pxp.f_insert_trol_procedimiento_gui ('PROBAR ROLES', 'GEM_SOLORD_ELI', 'GEM.2.7.4');

--Catálogos
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','1');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','2');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','3');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','4');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','5');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','6');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','7');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','8');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__prioridad','9');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__importancia','Alta');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__importancia','Media');
select pxp.f_add_catalog('GEM','torden_trabajo_sol__importancia','Baja');

/***********************************F-DAT-RCM-GEM-36-02/01/2013****************************************/

/***********************************I-DAT-AAO-GEM-106-18/01/2013****************************************/
select pxp.f_insert_tgui ('Órdenes de Trabajo', 'Registro Órdenes de Trabajo', 'GEM.2.4', 'si', 4, 'sis_mantenimiento/vista/orden_trabajo/ListadoGeneralOT.php', 3, '', 'ListadoGeneralOT', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.2.4', 'GEM.2');
/***********************************F-DAT-AAO-GEM-106-18/01/2013****************************************/

/***********************************I-DAT-RCM-GEM-97-06/02/2013****************************************/
update param.tmoneda set tipo_moneda = 'secundaria';
update param.tmoneda set tipo_moneda = 'base' where moneda ilike '%Bolivianos%';
/***********************************F-DAT-RCM-GEM-97-06/02/2013****************************************/

/***********************************I-DAT-RCM-GEM-119-16/02/2013****************************************/
select pxp.f_insert_tgui ('Equipos', 'Registro de Equipos', 'GEM.2.8', 'si', 2, 'sis_mantenimiento/vista/uni_cons/UniConsGral.php', 3, '', 'UniConsGral', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.2.8', 'GEM.2');

select pxp.f_insert_tprocedimiento ('GEM_EQGRAL_SEL', '	Consulta de datos', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQGRAL_CONT', '	Conteo de registros', 'si', '', '', 'gem.f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQGRAL_MOD', '	Modificación de datos', 'si', '', '', 'gem.f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQGRAL_ELI', '	Eliminación de datos', 'si', '', '', 'gem.f_uni_cons_ime');

select pxp.f_insert_tprocedimiento_gui ('GEM_EQGRAL_SEL', 'GEM.2.8', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_EQGRAL_CONT', 'GEM.2.8', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_EQGRAL_MOD', 'GEM.2.8', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_EQGRAL_ELI', 'GEM.2.8', 'si');
/***********************************F-DAT-RCM-GEM-119-16/02/2013****************************************/

/***********************************I-DAT-RCM-GEM-123-18/02/2013****************************************/
select pxp.f_add_catalog('GEM','tlocalizacion__cod_form','oit');
select pxp.f_add_catalog('GEM','tlocalizacion__cod_form','sol_oit');
select pxp.f_add_catalog('GEM','tlocalizacion__cod_form','oit, sol_oit');
/***********************************F-DAT-RCM-GEM-123-18/02/2013****************************************/

/***********************************I-DAT-RCM-GEM-120-07/03/2013****************************************/
select pxp.f_add_catalog('GEM','tuni_cons__tipo_unicons','Estacion');
select pxp.f_add_catalog('GEM','tuni_cons__tipo_unicons','Planta');
select pxp.f_add_catalog('GEM','tuni_cons__tipo_unicons','Vehiculo');
/***********************************F-DAT-RCM-GEM-120-07/03/2013****************************************/

/***********************************I-DAT-RCM-GEM-134-22/03/2013****************************************/
select pxp.f_add_catalog('GEM','ttipo_equipo_col__tipo_col','Ficha Tecnica');
select pxp.f_add_catalog('GEM','ttipo_equipo_col__tipo_col','Variables');
/***********************************F-DAT-RCM-GEM-134-22/03/2013****************************************/

/***********************************I-DAT-RCM-GEM-135-14/04/2013****************************************/
select pxp.f_add_catalog('GEM','tdiagrama_decision_accion','Fallo Oculto');
select pxp.f_add_catalog('GEM','tdiagrama_decision_accion','Seg. o Medio Ambiente');
select pxp.f_add_catalog('GEM','tdiagrama_decision_accion','Operacionales');
select pxp.f_add_catalog('GEM','tdiagrama_decision_accion','No Operacionales');
  
select pxp.f_insert_tgui ('Plan de Cuentas', 'Cuentas', 'GEM.1.11', 'si', 1, 'sis_mantenimiento/vista/cuenta/Cuenta.php', 10, '', 'Cuenta', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.1.11', 'GEM.1');


select pxp.f_insert_tfuncion ('gem.ft_cuenta_ime', 'Funcion para tabla', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_cuenta_sel', 'Funcion para tabla', 'GEM');

select pxp.f_insert_tprocedimiento ('GEM_CTA_INS', 'Insercion de registros', 'si', '', '', 'gem.ft_cuenta_ime');
select pxp.f_insert_tprocedimiento ('GEM_CTA_MOD', 'Modificacion de registros', 'si', '', '', 'gem.ft_cuenta_ime');
select pxp.f_insert_tprocedimiento ('GEM_CTA_ELI', 'Eliminacion de registros', 'si', '', '', 'gem.ft_cuenta_ime');
select pxp.f_insert_tprocedimiento ('GEM_CTA_SEL', 'Consulta de datos', 'si', '', '', 'gem.ft_cuenta_sel');
select pxp.f_insert_tprocedimiento ('GEM_CTA_CONT', 'Conteo de registros', 'si', '', '', 'gem.ft_cuenta_sel');
select pxp.f_insert_tprocedimiento ('GEM_CTA_ARB_SEL', 'Consulta de datos', 'si', '', '', 'gem.ft_cuenta_sel');

select pxp.f_insert_tprocedimiento_gui ('GEM_CTA_SEL', 'GEM.1.11', 'no');
select pxp.f_insert_tprocedimiento_gui ('GEM_CTA_INS', 'GEM.1.11', 'no');
select pxp.f_insert_tprocedimiento_gui ('GEM_CTA_MOD', 'GEM.1.11', 'no');
select pxp.f_insert_tprocedimiento_gui ('GEM_CTA_ELI', 'GEM.1.11', 'no');
select pxp.f_insert_tprocedimiento_gui ('GEM_CTA_ARB_SEL', 'GEM.1.11', 'no');

/***********************************F-DAT-RCM-GEM-135-14/04/2013****************************************/

/***********************************I-DAT-RCM-GEM-136-29/04/2013****************************************/
INSERT INTO gem.tparametro ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_parametro", "tipo_proceso", "valor")
VALUES (1, NULL, E'2013-04-26 21:37:37', E'2013-04-26 21:37:37', E'activo', 1, NULL, E'no_abrir');
/***********************************F-DAT-RCM-GEM-136-29/04/2013****************************************/