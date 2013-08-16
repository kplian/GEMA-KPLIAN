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
select pxp.f_insert_tgui ('Lista Maestra de Documentos', 'Archivos, Procedimientos , Instructivos, etc.', 'GEM.3', 'si', 3, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('TPM', 'Registro de documentos TPM', 'GEM.4', 'si', 4, '', 2, '', '', 'GEM');

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
select pxp.f_insert_tgui ('Ordenes de Trabajo', 'Ordenes de Trabajo', 'GEM.2.7', 'si', 1, '', 3, '', '', 'GEM');

select pxp.f_insert_tgui ('Emisión - Orden Trabajo', 'Emisión de Ordenes de Trabajo', 'GEM.2.7.1', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/RegistrarOT.php', 4, '', 'RegistrarOT', 'GEM');
select pxp.f_insert_tgui ('Ejecución - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.2', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/EjecutarOT.php', 4, '', 'EjecutarOT', 'GEM');
select pxp.f_insert_tgui ('Revisión - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.3', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/RevisarOT.php', 4, '', 'RevisarOT', 'GEM');

select pxp.f_insert_tgui ('Procedimientos, Instructivos ...', 'Registro de Procedimientos, Instructivos, etc.', 'GEM.3.1', 'si', 1, 'sis_mantenimiento/vista/documento/Documento.php', 3, '', 'Documento', 'GEM');
select pxp.f_insert_tgui ('Manuales', 'Registro de Manuales', 'GEM.3.2', 'si', 2, 'sis_mantenimiento/vista/documento/Manual.php', 3, '', 'Manual', 'GEM');
select pxp.f_insert_tgui ('Procedimientos', 'Registro de Procedimientos', 'GEM.3.3', 'si', 2, 'sis_mantenimiento/vista/documento/Procedimiento.php', 3, '', 'Procedimiento', 'GEM');
select pxp.f_insert_tgui ('Instructivos', 'Registro de Instructivos', 'GEM.3.4', 'si', 2, 'sis_mantenimiento/vista/documento/Instructivo.php', 3, '', 'Instructivo', 'GEM');
select pxp.f_insert_tgui ('Planes', 'Registro de Planes', 'GEM.3.5', 'si', 2, 'sis_mantenimiento/vista/documento/Plan.php', 3, '', 'Plan', 'GEM');
select pxp.f_insert_tgui ('Registros', 'Registros', 'GEM.3.6', 'si', 2, 'sis_mantenimiento/vista/documento/Registro.php', 3, '', 'Registro', 'GEM');
select pxp.f_insert_tgui ('Formularios', 'Registro de Formularios', 'GEM.3.7', 'si', 2, 'sis_mantenimiento/vista/documento/Formulario.php', 3, '', 'Formulario', 'GEM');

select pxp.f_insert_tgui ('Fallas/Eventos Equipos...', 'Registro de Fallas/Eventos Equipos', 'GEM.3.11', 'si', 5, 'sis_mantenimiento/vista/falla_evento/FallaEventoExterno.php', 3, '', 'FallaEventoExterno', 'GEM');

select pxp.f_insert_tgui ('Formularios TPM', 'Registro de Formularios TPM', 'GEM.4.1', 'si', 2, 'sis_mantenimiento/vista/documento/FormularioTPM.php', 3, '', 'FormularioTPM', 'GEM');

select pxp.f_insert_testructura_gui ('GEM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('GEM.4', 'GEM');
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
select pxp.f_insert_testructura_gui ('GEM.3.2', 'GEM.3');
select pxp.f_insert_testructura_gui ('GEM.3.3', 'GEM.3');
select pxp.f_insert_testructura_gui ('GEM.3.4', 'GEM.3');
select pxp.f_insert_testructura_gui ('GEM.3.5', 'GEM.3');
select pxp.f_insert_testructura_gui ('GEM.3.6', 'GEM.3');
select pxp.f_insert_testructura_gui ('GEM.3.7', 'GEM.3');
select pxp.f_insert_testructura_gui ('GEM.2.7.3', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.2.7.2', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.2.7.1', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.4.1', 'GEM.4');


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

/***********************************I-DAT-RAC-GEM-00-26/04/2013****************************************/
--inserta disparador de alarma
INSERT INTO param.tgenerador_alarma ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "funcion")
VALUES (1, NULL, E'2013-04-26 06:38:08.055', NULL, E'activo', E'gem.f_verifica_alarma_gem');
/***********************************F-DAT-RAC-GEM-00-26/04/2013****************************************/

/***********************************I-DAT-RCM-GEM-137-12/05/2013****************************************/
select pxp.f_add_catalog('GEM','tdocumento__tipo_doc','manual');
select pxp.f_add_catalog('GEM','tdocumento__tipo_doc','procedimiento');
select pxp.f_add_catalog('GEM','tdocumento__tipo_doc','instructivo');
select pxp.f_add_catalog('GEM','tdocumento__tipo_doc','plan');
select pxp.f_add_catalog('GEM','tdocumento__tipo_doc','registro');

select pxp.f_add_catalog('GEM','ttarea__sn','S');
select pxp.f_add_catalog('GEM','ttarea__sn','N');
/***********************************F-DAT-RCM-GEM-137-12/05/2013****************************************/

/***********************************I-DAT-RCM-GEM-0-20/05/2013****************************************/
select pxp.f_insert_tgui ('Organigrama', 'Registro de Organigrama', 'GEM.1.12', 'si', 8, 'sis_mantenimiento/vista/funcionario/EstructuraUoGem.php', 3, '', 'EstructuraUoGem', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.1.12', 'GEM.1');
/***********************************F-DAT-RCM-GEM-20/05/2013****************************************/

/***********************************I-DAT-RCM-GEM-0-24/05/2013****************************************/
select pxp.f_add_catalog('GEM','tanalisis_mant__preparado_por','Organigrama');
select pxp.f_add_catalog('GEM','tanalisis_mant__preparado_por','Persona');
/***********************************F-DAT-RCM-GEM-0-24/05/2013****************************************/

/***********************************I-DAT-RCM-GEM-143-11/06/2013****************************************/
select pxp.f_insert_tgui ('Presupuestos', 'Presupuestos', 'GEM.1.13', 'si', 1, 'sis_mantenimiento/vista/presupuesto/Presupuesto.php', 10, '', 'Cuenta', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.1.13', 'GEM.1');

select pxp.f_insert_tfuncion ('gem.ft_presupuesto_ime', 'Funcion para tabla', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_presupuesto_sel', 'Funcion para tabla', 'GEM');

select pxp.f_insert_tprocedimiento ('GEM_GEPRES_INS', 'Insercion de registros', 'si', '', '', 'gem.ft_presupuesto_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEPRES_MOD', 'Modificacion de registros', 'si', '', '', 'gem.ft_presupuesto_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEPRES_ELI', 'Eliminacion de registros', 'si', '', '', 'gem.ft_presupuesto_ime');
select pxp.f_insert_tprocedimiento ('GEM_GEPRES_SEL', 'Consulta de datos', 'si', '', '', 'gem.ft_presupuesto_sel');
select pxp.f_insert_tprocedimiento ('GEM_GEPRES_CONT', 'Conteo de registros', 'si', '', '', 'gem.ft_presupuesto_sel');

select pxp.f_insert_tprocedimiento_gui ('GEM_GEPRES_SEL', 'GEM.1.13', 'no');
select pxp.f_insert_tprocedimiento_gui ('GEM_GEPRES_INS', 'GEM.1.13', 'no');
select pxp.f_insert_tprocedimiento_gui ('GEM_GEPRES_MOD', 'GEM.1.13', 'no');
select pxp.f_insert_tprocedimiento_gui ('GEM_GEPRES_ELI', 'GEM.1.13', 'no');

/***********************************F-DAT-RCM-GEM-143-11/06/2013****************************************/

/***********************************I-DAT-RCM-GEM-144-11/06/2013****************************************/
select pxp.f_add_catalog('PARAM','tgral__mes','01 - Enero');
select pxp.f_add_catalog('PARAM','tgral__mes','02 - Febrero');
select pxp.f_add_catalog('PARAM','tgral__mes','03 - Marzo');
select pxp.f_add_catalog('PARAM','tgral__mes','04 - Abril');
select pxp.f_add_catalog('PARAM','tgral__mes','05 - Mayo');
select pxp.f_add_catalog('PARAM','tgral__mes','06 - Junio');
select pxp.f_add_catalog('PARAM','tgral__mes','07 - Julio');
select pxp.f_add_catalog('PARAM','tgral__mes','08 - Agosto');
select pxp.f_add_catalog('PARAM','tgral__mes','09 - Septiembre');
select pxp.f_add_catalog('PARAM','tgral__mes','10 - Octubre');
select pxp.f_add_catalog('PARAM','tgral__mes','11 - Noviembre');
select pxp.f_add_catalog('PARAM','tgral__mes','12 - Diciembre');

select pxp.f_insert_tgui ('Aprobación Solicitud de Orden de Trabajo', 'Aprobación Solicitud de Orden de Trabajo', 'GEM.2.7.5', 'si', 5, 'sis_mantenimiento/vista/orden_trabajo_sol/OrdenTrabajoSolAprob.php', 4, '', 'OrdenTrabajoSolAprob', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.2.7.5', 'GEM.2.7');

select pxp.f_insert_tprocedimiento ('GEM_SOLAPR_MOD', '	Modificacion de registros', 'si', '', '', 'gem.ft_orden_trabajo_sol_ime');

select pxp.f_insert_tprocedimiento_gui ('GEM_SOLORD_SEL', 'GEM.2.7.5', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_SOLORD_MOD', 'GEM.2.7.5', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_SOLORD_CONT', 'GEM.2.7.5', 'si');
select pxp.f_insert_tprocedimiento_gui ('GEM_SOLAPR_MOD', 'GEM.2.7.5', 'si');


/***********************************F-DAT-RCM-GEM-144-11/06/2013****************************************/

/***********************************I-DAT-RCM-GEM-0-08/07/2013****************************************/
ALTER TABLE gem.tuni_cons
  ALTER COLUMN horas_dia SET DEFAULT 24;
  
select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Asistente');
/***********************************F-DAT-RCM-GEM-0-08/07/2013****************************************/

/***********************************I-DAT-RCM-GEM-0-29/07/2013****************************************/
select pxp.f_insert_tgui ('Vehículos', 'Vehículos', 'GEM.2.8', 'si', 7, 'sis_mantenimiento/vista/localizacion/LocalizacionVeh.php', 3, '', 'LocalizacionVeh', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.2.8', 'GEM.2');

select pxp.f_insert_tgui ('Registro de Mediciones', 'Registro de Mediciones', 'GEM.2.9', 'si', 8, 'sis_mantenimiento/vista/uni_cons/UniConsOperador.php', 3, '', 'UniConsOperador', 'GEM');
select pxp.f_insert_testructura_gui ('GEM.2.9', 'GEM.2');
/***********************************F-DAT-RCM-GEM-0-29/07/2013****************************************/



/***********************************I-DAT-RCM-GEM-0-16/08/2013****************************************/
INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (83, E'OISSCO S.A.', E'persona juridica', E'1015467024', E'CARLOS ROBERTO CAPRILES TEJADA', NULL, E'333-3735', E'333-3772', E'', NULL, E'Santa Cruz', 2, 3127, 4303);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (88, E'PETROPLUS BOLIVIA S.R.L.', E'persona juridica', E'1014965028', E'MARCELO DE LA ROSA DAZA', NULL, E'355-5800', E'354-4474', E'', NULL, E'Santa Cruz', 2, 3128, 4304);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (89, E'PETROVISA S.R.L.', E'persona juridica', E'1024957025', E'HORACIO SARDELIE', NULL, E'358-4844', E'358-4844', E'', NULL, E'Santa Cruz', 2, 3129, 4305);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (91, E'IMPORTADORA PROAGI S.R.L.', E'persona juridica', E'1025007026', E'PAUL GONZALES', NULL, E'3423153  77394632', E'423153', E'', NULL, E'Santa Cruz', 2, 3130, 4306);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (93, E'PROMISA S.A.', E'persona juridica', E'1028791027', E'DAVID QUNTANILLA', NULL, E'3432322', E'3425272', E'', NULL, E'Santa Cruz', 2, 3131, 4307);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (94, E'PROSERTEC S.R.L.', E'persona juridica', E'1015211029', E'MAURICIO RIOS ROCA', NULL, E'3559618', E'3117427', E'', NULL, E'Santa Cruz', 2, 3132, 4308);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (102, E'ROGHUR S.A.', E'persona juridica', E'1028445023', E'ROGER HURTADO VILLA', NULL, E'336-9494', E'3377774', E'', NULL, E'Santa Cruz', 2, 3133, 4309);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (103, E'SERPETROL LTDA', E'persona juridica', E'1028683029', E'MAURICIO  COGNIGNI', NULL, E'355-8100', E'3112707', E'', NULL, E'Santa Cruz', 2, 3134, 4310);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (104, E'SERVIPETROL LTDA', E'persona juridica', E'1015577024', E'CARLOS EDUARDO ORTIZ MERCADO', NULL, E'352-3293', E'353-1824', E'', NULL, E'Santa Cruz', 2, 3135, 4311);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (55, E'IMPORTACIONES E&M', E'persona juridica', E'', E'LEXIN RUIZ CABRERA', NULL, E'', E'346-4629', E'', NULL, E'Santa Cruz', 2, 3136, 4313);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (57, E'IMPRENTA ROSAS', E'persona juridica', E'', E'FRANZ ROSAS', NULL, E'481683', E'529658', E'', NULL, E'Santa Cruz', 2, 3137, 4314);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (92, E'PROINTER', E'persona juridica', E'', NULL, NULL, E'346-6161', E'346-6161', E'', NULL, E'Santa Cruz', 2, NULL, 4315);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (97, E'RANSA', E'persona juridica', E'', E'NALDA BALDARRAGO GUEVARA', NULL, E'00105154-781756', E'00105154-782141', E'', NULL, E'Santa Cruz', 2, 3153, 4332);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (98, E'RAPSA', E'persona juridica', E'', E'JOSE CARLOS VACA', NULL, E'3438500', E'438600', E'', NULL, E'Santa Cruz', 2, 3083, 4333);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (99, E'RECORD', E'persona juridica', E'', E'VICTOR ALFREDO LARAN', NULL, E'3362636', E'329303', E'', NULL, E'Santa Cruz', 2, 3154, 4334);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (100, E'RETENES ROME', E'persona juridica', E'', E'', NULL, E'355-6272', E'355-6272', E'', NULL, E'Santa Cruz', 2, NULL, 4335);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (101, E'RIBEPAR', E'persona juridica', E'', E'INGRY TORRICO', NULL, E'346-7070', E'344-2929', E'', NULL, E'Santa Cruz', 2, 3155, 4336);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (85, E'PENNZOIL', E'persona juridica', E'', NULL, NULL, E'353-1226', E'353-1226', E'', NULL, E'Santa Cruz', 2, NULL, 4337);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (82, E'MUL-T-LOCK', E'persona juridica', E'', NULL, NULL, E' 353-7750', E' 353-7750', E'', NULL, E'Santa Cruz', 2, NULL, 4338);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (109, E'SOUTHTEC S.R.L.', E'persona juridica', E'1007001023', E'JUAN CARLOS DE LA REZA GALINDO', NULL, E'3335874', E'3335874', E'', NULL, E'Santa Cruz', 2, 3156, 4339);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (110, E'EXPROTEC SRL.', E'persona juridica', E'1013949021', E'JUAN FREDDY SANDY SOLIZ', NULL, E'357-6688', E'3576649', E'', NULL, E'Santa Cruz', 2, 3157, 4340);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (113, E'TECNO  REPRESENTACION SERVICIOS S.R.L.', E'persona juridica', E'1012815021', E'JAVIER ARMANDO INCHAUISTI VACA', NULL, E'352-6586', E'352-6586 / 311-8670', E'', NULL, E'Santa Cruz', 2, 3158, 4341);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (115, E'TEKON LTDA', E'persona juridica', E'1026537021', E'CAMILO CLAUDIO RAMIREZ ERNEST.', NULL, E'342-0257', E'3-435244', E'', NULL, E'Santa Cruz', 2, 3159, 4342);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (167, E'CIMATEL IMPORTACIONES SRL', E'persona juridica', E'1020791028', E'NORMA TERÁN', NULL, E'4246027', E'4242116', E'', NULL, E'Santa Cruz', 2, 3196, 4388);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3, E'AMERICA HOMECENTER', E'persona juridica', E'1025475028', E'AMERICA HOMECENTER', NULL, E'343-4141', E'343-4142', E'', NULL, E'Santa Cruz', 2, 3079, 4244);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (116, E'TERVAP LTDA.', E'persona juridica', E'1015119022', E'ROLANDO CEREZO CIVERA', NULL, E'346-5842 346-6118', E'349-3121', E'', NULL, E'Santa Cruz', 2, 3160, 4343);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (118, E'THOMPSON', E'persona juridica', E'', E'ANA THOMPSON', NULL, E'332-2619', E'332-9662', E'', NULL, E'Santa Cruz', 2, 3161, 4344);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (122, E'TRITEC S.R.L.', E'persona juridica', E'1007885027', E'ROY MODESTO RICO MERCADO', NULL, E'425-6993', E'425-0981', E'', NULL, E'Santa Cruz', 2, 3162, 4345);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (124, E'VARGAS FERNANDO', E'persona natural', E'', E'', NULL, E'3363089', E'', E'', NULL, E'Santa Cruz', 2, 3163, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (154, E'DETRO CUMMINS S.R.L.', E'persona juridica', E'161486025', E'ENRIQUE ROSAS ORELLANA', NULL, E'352-1329', E'352-7252', E'', NULL, E'Santa Cruz', 2, 3172, 4354);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (151, E'COMERCIAL SODIMAC', E'persona juridica', E'', E'GERÓNIMO MACÍAS ORTEGA', NULL, E'6263481', E'6263481', E'', NULL, E'Santa Cruz', 2, 3173, 4356);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (155, E'FERRETERIA EL INFLADOR', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4357);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (140, E'FERROSCAM', E'persona juridica', E'', E'ERICK GAITY', NULL, E'3422062', E'6422062', E'', NULL, E'Santa Cruz', 2, 3112, 4358);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (144, E'FLEXOCRUZ', E'persona juridica', E'', E'SERGIO GUTIERREZ JUSINIANO', NULL, E'333-6488', E'333-9506', E'', NULL, E'Santa Cruz', 2, 3174, 4359);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (131, E'GLOBAL TRADING', E'persona juridica', E'', E'MARIO CASTELLON', NULL, E'337-1012', E'', E'', NULL, E'Santa Cruz', 2, 3175, 4360);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (145, E'IMPORTADORA CALIFORNIA', E'persona juridica', E'', E'', NULL, E'3334945', E'3330494', E'', NULL, E'Santa Cruz', 2, NULL, 4361);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (148, E'IMPORTADORA RIVERO', E'persona juridica', E'', E'OLFI RIVERO', NULL, E'3491942 (77333253)', E'3491942', E'', NULL, E'Santa Cruz', 2, 3176, 4362);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (147, E'TOOLMEX', E'persona juridica', E'', NULL, NULL, E'3140131', E'3532183', E'', NULL, E'Santa Cruz', 2, NULL, 4363);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (132, E'LASSER RODAMIENTOS COCHABAMBA', E'persona juridica', E'', E'', NULL, E'458-0113', E'411-8897', E'', NULL, E'Santa Cruz', 2, NULL, 4364);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (133, E'MOVILCOM', E'persona juridica', E'', E'ROXANA DAHER CANEDO  773-54654', NULL, E'3336668', E'3964065', E'', NULL, E'Santa Cruz', 2, 3177, 4365);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (111, E'INSTASQUELEC', E'persona juridica', E'', E'ROBERTO TASQUER', NULL, E'357-6600', E'355-5600', E'', NULL, E'Santa Cruz', 2, 3178, 4366);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (146, E'SEIRE', E'persona juridica', E'', E'', NULL, E'350-4094', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4367);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (108, E'SFS', E'persona juridica', E'', E'JEAN PAUL QUEZADA', NULL, E'334-0499', E'337-7393', E'', NULL, E'Santa Cruz', 2, 3179, 4368);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (105, E'SICI (SERVICIO INTEGRAL CONTRA INCENDIO SRL)', E'persona juridica', E'', E'GUSTAVO PEREIRA', NULL, E'3556962', E'3556962', E'', NULL, E'Santa Cruz', 2, 3180, 4369);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (156, E'SIFON SANTA CRUZ', E'persona juridica', E'', E'', NULL, E'349-1415', E'349-1516', E'', NULL, E'Santa Cruz', 2, NULL, 4370);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (106, E'SIS', E'persona juridica', E'', E'ERICK LORBERG', NULL, E'3492606', E'3492767', E'', NULL, E'Santa Cruz', 2, 3181, 4371);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (143, E'SITE', E'persona juridica', E'', E'EDUARDO ALEJANDRO GUERRA CANDIA', NULL, E'77009013', E'', E'', NULL, E'Santa Cruz', 2, 3182, 4372);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (107, E'SIT SERVICES', E'persona juridica', E'', E'CINTHIA VERDUGUEZ', NULL, E'3-641914', E'3-641914', E'', NULL, E'Santa Cruz', 2, 3183, 4373);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (247, E'GLOBAL M&Y', E'persona juridica', E'', E'', NULL, E'425-1852', E'425-1852', E'', NULL, E'Santa Cruz', 2, NULL, 4374);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (162, E'DARIO ALBERTO CASANUEVA (MASTER TOOLS)', E'persona natural', E'', E'LUIS CARLOS CLAROS CAMPOS', NULL, E'3123859 (71642885)', E'3123859', E'', NULL, E'Santa Cruz', 2, 3194, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (165, E'COACOM SRL', E'persona juridica', E'1028689025', E'JOSÉ SAID HINOJOSA SAAVEDRA', NULL, E'332-3311', E'332-3312', E'', NULL, E'Santa Cruz', 2, 3195, 4387);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (172, E'D&D TRACTOR PARTS', E'persona juridica', E'122829028', E'BOLIVIA', NULL, E'342-9060', E'345-9262', E'', NULL, E'Santa Cruz', 2, 3196, 4389);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (173, E'C.R.M. SRL', E'persona juridica', E'1008625025', E'ORLANDO RODRIGUEZ TORRICO', NULL, E'4-4242051', E'4-4249863', E'', NULL, E'Santa Cruz', 2, 3197, 4390);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (176, E'INVERSIONES MUNCHEN LTDA', E'persona juridica', E'1016389027', E'JOSE FRANCISCO ESTRELLA GRIJALVA', NULL, E'3334459', E'3642299', E'', NULL, E'Santa Cruz', 2, 3198, 4391);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (187, E'AGINBOL', E'persona juridica', E'', E'DANTE ROMERO', NULL, E'343-0921', E'343-0923', E'', NULL, E'Santa Cruz', 2, 3199, 4392);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (206, E'PERNOSUR- WILLY OSVALDO ZEBALLOS CRUZ', E'persona juridica', E'1880808013', E'WILLY OSVALDO ZEBALLOS CRUZ', NULL, E'4236952', E'4236952', E'', NULL, E'Chuquisaca', 6, 3200, 4393);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (211, E'DISMATEC S.A.', E'persona juridica', E'1027967025', E'JULIO JR. MONTÍVEROS AYALA', NULL, E'347-3030', E'347-3031', E'', NULL, E'Santa Cruz', 2, 3201, 4394);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (212, E'PLEXUS AUTOMACION', E'persona juridica', E'1026601023', E'EULALIA JOHNSON', NULL, E'333-4167', E'3418930', E'', NULL, E'Santa Cruz', 2, 3202, 4395);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (204, E'ALTEN ENGINEERING DIVISION', E'persona juridica', E'', E'JIM LOGUE', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3203, 4396);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (205, E'ASEA BROWN  BOVERI LTDA', E'persona juridica', E'', E'JOSÉ ANTONIO CASTELLÓN', NULL, E'3432349', E'3441733  71639655', E'', NULL, E'Santa Cruz', 2, 3204, 4397);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (186, E'M & M STORE', E'persona juridica', E'', NULL, NULL, E'3335544', E'3113102', E'', NULL, E'Santa Cruz', 2, NULL, 4398);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (210, E'BG BOLIVIA', E'persona juridica', E'', E'ENRIQUE RESSE', NULL, E'71647548', E'355-1000', E'', NULL, E'Santa Cruz', 2, 3205, 4399);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (182, E'BOLIVIAN RADIUS', E'persona juridica', E'', E'NINOSKA JUDITH CAERO ADRIAN', NULL, E'4425-3192', E'4425-2781', E'', NULL, E'Santa Cruz', 2, 3206, 4400);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (160, E'VISAL', E'persona juridica', E'', E'JOSE CESPEDES', NULL, E'3414141', E'3414600', E'', NULL, E'Santa Cruz', 2, 3228, 4401);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (170, E'INDUSTRIAS ELECTROMATIC', E'persona juridica', E'', E'LEONARDO URIOSTE', NULL, E'3541001', E'3541001', E'', NULL, E'Santa Cruz', 2, 3214, 4416);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (169, E'INDUSTRIAS LUJAN SRL', E'persona juridica', E'', E'JANETH ANTEZANA CORTEZ', NULL, E'4280278', E'4240527', E'', NULL, E'Santa Cruz', 2, 3215, 4417);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (202, E'INTEC PRO', E'persona juridica', E'3209124013', E'ALIO MAURICIO LOPEZ', NULL, E'3340172', E'3340172', E'', NULL, E'Santa Cruz', 2, 3216, 4418);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (185, E'INTER SANTA CRUZ', E'persona juridica', E'', E'', NULL, E'342-2828', E'342-0752', E'', NULL, E'Santa Cruz', 2, NULL, 4419);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (178, E'LABORATORIO GAMBOA', E'persona juridica', E'', E'HUMBERTO GAMBOA', NULL, E'4428-4821', E'4428-4821', E'', NULL, E'Santa Cruz', 2, 3217, 4420);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (184, E'LUBRIQUIP, INC', E'persona juridica', E'', E'ROGER SANTILLAN', NULL, E'1-525553735571', E'1-525553735655', E'', NULL, E'Santa Cruz', 2, 3218, 4421);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (213, E'LUSSAC', E'persona juridica', E'', E'ROBERT VELASQUEZ', NULL, E'4250105', E'4123845', E'', NULL, E'Santa Cruz', 2, 3219, 4422);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (192, E'MANUFACTURAS PETROLERAS S.A.', E'persona juridica', E'', E'MANUEL VALDIVIESO', NULL, E'3524107', E'3557555', E'', NULL, E'Santa Cruz', 2, 3220, 4423);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (189, E'SERVI - TRAC', E'persona juridica', E'', E'ERNESTO ROCHA', NULL, E'3626960', E'3626960', E'', NULL, E'Santa Cruz', 2, 3221, 4424);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (168, E'M ROYO', E'persona juridica', E'', E'JUAN MANZELLI', NULL, E'5411 4919 9788/8776', E'5411 49183503', E'', NULL, E'Santa Cruz', 2, 3222, 4425);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (177, E'MUNDOGRAFIA', E'persona juridica', E'', E'', NULL, E'3530869', E'3533748', E'', NULL, E'Santa Cruz', 2, NULL, 4426);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (197, E'PAPELERIA FUNES', E'persona juridica', E'', E'', NULL, E'4251340', E'4251340', E'', NULL, E'Santa Cruz', 2, NULL, 4427);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (163, E'BALLYCO SRL', E'persona juridica', E'', E'RAMIRO HUARACHI', NULL, E'3551200', E'3551200', E'', NULL, E'Santa Cruz', 2, 3223, 4428);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (199, E'SHELL BOLIVIA S.A.', E'persona juridica', E'', E'', NULL, E'343-6787', E'343-6640', E'', NULL, E'Santa Cruz', 2, NULL, 4429);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (157, E'SIDEX INTERNACIONAL', E'persona juridica', E'', E'OLIMPIA CUELLAR', NULL, E'71627311', E'333-0612', E'', NULL, E'Santa Cruz', 2, 3224, 4430);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (164, E'SISCOBOL LTDA', E'persona juridica', E'', E'SANDRA DE LOS SANTOS C.', NULL, E'3363737', E'336-6201', E'', NULL, E'Santa Cruz', 2, 3225, 4431);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (193, E'SURI MANUFACTURAS', E'persona juridica', E'', E'TERESA PEREDO', NULL, E'3649650-750-02189', E'364-9650', E'', NULL, E'Santa Cruz', 2, 3226, 4432);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (220, E'PETROCONSULT', E'persona juridica', E'', E'RICARDO MICHEL', NULL, E'3582390', E'3531176', E'', NULL, E'Santa Cruz', 2, 3267, 4480);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (252, E'SAN MARTIN DE PORRES', E'persona juridica', E'', E'', NULL, E'3350047', E'3339247', E'', NULL, E'Santa Cruz', 2, NULL, 4481);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (4, E'ANGLARILL COMPAÑÍA LTDA', E'persona juridica', E'1026929023', E'RICHARD ERLAN ANGLARILL ARENALES', NULL, E'3333219', E'3345955', E'', NULL, E'Santa Cruz', 2, 3080, 4245);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (171, E'TOYOSA S.A.', E'persona juridica', E'', E'', NULL, E'425-4214', E'425-4214', E'', NULL, E'Santa Cruz', 2, NULL, 4433);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (174, E'VIALUX', E'persona juridica', E'', E'', NULL, E'3421304', E'3421304', E'', NULL, E'Santa Cruz', 2, NULL, 4434);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (161, E'VICAR', E'persona juridica', E'', E'MARIA ELENA PELAEZ', NULL, E'337-5335', E'334-8048', E'', NULL, E'Santa Cruz', 2, 3227, 4435);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (175, E'VIDCLA', E'persona juridica', E'', E'', NULL, E'332-6790', E'332-6523', E'', NULL, E'Santa Cruz', 2, NULL, 4436);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (266, E'CIVERAS SRL', E'persona juridica', E'156178024', E'ARLEM CIVERA VARGAS', NULL, E'3649528 - 70999778', E'', E'', NULL, E'Santa Cruz', 2, 3239, 4447);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (267, E'FANGIO REPRESENTACIONES', E'persona juridica', E'136889022', E'EDGAR FIENGO', NULL, E'351-0048', E'351-0048', E'', NULL, E'Santa Cruz', 2, 3240, 4448);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (261, E'AMC IMPORTACIONES Y SERVICIOS SRL', E'persona juridica', E'', E'MARIA JOSÉ AGUILAR', NULL, E'3371727', E'3367393', E'', NULL, E'Santa Cruz', 2, 3241, 4449);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (219, E'APLISAC', E'persona juridica', E'', E'FEDERICO ARANA', NULL, E'(511) 797-6984', E'(511) 271-8331', E'', NULL, E'Santa Cruz', 2, 3242, 4450);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (217, E'ASCOR', E'persona juridica', E'', E'MONICA PALACIOS', NULL, E'3377350', E'3335837', E'', NULL, E'Santa Cruz', 2, 3243, 4451);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (245, E'BATA INDUSTRIAL', E'persona juridica', E'1023149021', E'RONALD MERCADO', NULL, E'339-5150', E'339-5150', E'', NULL, E'Santa Cruz', 2, 3244, 4452);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (250, E'BATERIAS ULTRA', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4453);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (254, E'BOLPEGAS SRL', E'persona juridica', E'', E'ROBERTO ORDOÑEZ', NULL, E'3577373', E'3546262', E'', NULL, E'Santa Cruz', 2, 3245, 4454);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (222, E'CHRISTIAN AUTOMOTORS', E'persona juridica', E'', E'OMAR SANCHEZ', NULL, E'3340705', E'', E'', NULL, E'Santa Cruz', 2, 3246, 4455);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (246, E'COMERCIAL HERMES', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4456);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (226, E'COMERCIAL HP', E'persona juridica', E'', E'HUARITA PINEDO FREDDY', NULL, E'64-44739', E'64-44739', E'', NULL, E'Santa Cruz', 2, 3247, 4457);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (223, E'COMERCIAL LOURDES', E'persona juridica', E'', E'', NULL, E'6453541', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4458);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (238, E'COMERCIAL PANAMERICANA', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4459);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (270, E'CRAM ELECTRO S.A.', E'persona juridica', E'', E'RUBÉN MOSCOVICH', NULL, E'54-11 4629-0600', E'', E'', NULL, E'Santa Cruz', 2, 3248, 4460);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (231, E'DIMACO', E'persona juridica', E'', E'MARCELO LUNA', NULL, E'4426060', E'4426060', E'', NULL, E'Santa Cruz', 2, 3249, 4461);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (253, E'DISBOSUR', E'persona juridica', E'', E'ALBERTO LASTRA', NULL, E'464-60218', E'464-60218', E'', NULL, E'Santa Cruz', 2, 3250, 4462);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (249, E'EMPRESA DE SERV PETROLEROS RIO NUEVO', E'persona juridica', E'', E'JORGE CUETO', NULL, E'3535509', E'3535509', E'', NULL, E'Santa Cruz', 2, 3251, 4463);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (229, E'EQUIPETROL', E'persona juridica', E'', E'JAVIER MUÑOZ', NULL, E'3578787', E'3578777', E'', NULL, E'Santa Cruz', 2, 3252, 4464);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (227, E'NIBOL', E'persona juridica', E'1028787021', E'CARLOS PAZ', NULL, E'3361909', E'3341289', E'', NULL, E'Santa Cruz', 2, 3264, 4477);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (258, E'NOTEBOOKS Y ACCESORIOS', E'persona juridica', E'', E'PABLO CORRAL', NULL, E'70813497', E'', E'', NULL, E'Santa Cruz', 2, 3265, 4478);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (269, E'OFFICE COMPUTER SRL', E'persona juridica', E'', E'ROXANA ZABALA', NULL, E'3418191', E'3418340', E'', NULL, E'Santa Cruz', 2, 3266, 4479);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (260, E'SERVICIOS NACIONALES E INTERNACIONALES', E'persona juridica', E'', E'SANTIAGO AVALOS', NULL, E'3580403', E'', E'', NULL, E'Santa Cruz', 2, 3268, 4482);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (241, E'PLASTICOS JUANCHO', E'persona juridica', E'1537607019', NULL, NULL, E'332-6477', E'332-6477', E'', NULL, E'Santa Cruz', 2, NULL, 4483);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (240, E'TERMOPAR', E'persona juridica', E'', E'WILLIAMS PAREDES BENITES', NULL, E'347-6828', E'360-4299', E'', NULL, E'Santa Cruz', 2, 3269, 4484);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (295, E'SOTCO LTDA', E'persona juridica', E'', E'MARCO IMAÑA DAZA', NULL, E'2285739-2285690', E'2285422', E'', NULL, E'Santa Cruz', 2, 3314, 4536);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (59, E'IMPRESIONES SILOE', E'persona juridica', E'1863441013', E'VICTOR GOMEZ', NULL, E'333-7803', E'333-7803', E'', NULL, E'Santa Cruz', 2, 3138, 4246);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (214, E'TTI - TRANSPORT TRADING IN L INC', E'persona juridica', E'', E'MIRTHALA CARDENAS', NULL, E'2-1-281-440-0320', E'1-281-440-8403', E'', NULL, E'Santa Cruz', 2, 3270, 4485);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (233, E'UNIGRAF SRL.', E'persona juridica', E'', E'', NULL, E'347-1010', E'347-1010', E'', NULL, E'Santa Cruz', 2, NULL, 4486);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (264, E'VISION', E'persona juridica', E'', E'ENRIQUE BÖHRT ARANIBAR', NULL, E'3410973', E'', E'', NULL, E'Santa Cruz', 2, 3271, 4487);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (215, E'TECNO FRIO', E'persona juridica', E'', NULL, NULL, E'349-7972', E'347-6735', E'', NULL, E'Santa Cruz', 2, NULL, 4488);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (281, E'IMPORCAM', E'persona juridica', E'1975529018', E'SIXTO ORTUÑO ROJAS', NULL, E'3460259', E'3464140', E'', NULL, E'Santa Cruz', 2, 3272, 4489);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (308, E'FERRETERIA HERRASUR', E'persona juridica', E'30134320', E'HURTADO SEJAS JAIME', NULL, E'421-8150', E'423-6952', E'', NULL, E'Santa Cruz', 2, 3273, 4490);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (317, E'MAQUITEX', E'persona juridica', E'137395022', E'GENY BEDA RODRIGUEZ', NULL, E'351-0156', E'351-0156', E'', NULL, E'Santa Cruz', 2, 3274, 4491);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (319, E'FLUSITEC BOLIVIA S.R.L.', E'persona juridica', E'121905023', E'CARLOS EDUARDO ORTIZ MERCADO', NULL, E'3523293', E'3514800', E'', NULL, E'Santa Cruz', 2, 3135, 4492);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (274, E'COTHEZ', E'persona juridica', E'', E'MAXIMO FELIPEZ', NULL, E'44445802', E'4445802', E'', NULL, E'Santa Cruz', 2, 3286, 4505);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (315, E'COUNSEL SRL', E'persona juridica', E'', E'FREDDY OSSIO', NULL, E'2456687', E'2456687', E'', NULL, E'Santa Cruz', 2, 3287, 4506);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (302, E'DISMACON', E'persona juridica', E'', E'JOSÉ DELGADILLO', NULL, E'46440444', E'464404444', E'', NULL, E'Santa Cruz', 2, 3288, 4507);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (287, E'DURALIT S.A.', E'persona juridica', E'', E'', NULL, E'347-5525', E'348-0364', E'', NULL, E'Santa Cruz', 2, NULL, 4508);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (304, E'EL PALACIO DE LAS GORRAS', E'persona juridica', E'', E'OSCAR DE LA FUENTE', NULL, E'3322269', E'3366364', E'', NULL, E'Santa Cruz', 2, 3289, 4509);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (318, E'EMCO WHEATON GMBH', E'persona juridica', E'', E'CHRISTIANE WALDEN', NULL, E'(49) 64 22 84 0', E'(49) 64 22 51 00', E'', NULL, E'Santa Cruz', 2, 3290, 4510);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (280, E'EQUIMOTORS SRL.', E'persona juridica', E'', E'MARTHA LUZ RODRIGUEZ TORRICO', NULL, E'422-8523', E'', E'', NULL, E'Santa Cruz', 2, 3291, 4511);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (289, E'FC TRADE GROUP SRL', E'persona juridica', E'', E'JHONNY CASTEDO R.', NULL, E'332-7717', E'339-1797', E'', NULL, E'Santa Cruz', 2, 3292, 4512);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (320, E'FERRETERIA FUFITA', E'persona juridica', E'', E'LUIS INCHAUSTE', NULL, E'3-852-2827', E'3-852-2405', E'', NULL, E'Santa Cruz', 2, 3293, 4513);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (286, E'FERRETERIA LA COLMENA', E'persona juridica', E'', E'WALTER DEHNE FRANCO', NULL, E'422-4370', E'422-4370', E'', NULL, E'Santa Cruz', 2, 3294, 4514);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (324, E'FERRETERIA SAN ANTONIO', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4515);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (303, E'FERRETERIA SOL NACIENTE', E'persona juridica', E'', E'VIVIANA CALLE MAMANI', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3295, 4516);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (314, E'FPL SUMINISTROS PETROLEROS E INDUSTRIALES', E'persona juridica', E'', E'JUAN CARLOS ESCUDERO', NULL, E'3550056 (70979879)', E'3550056', E'', NULL, E'Santa Cruz', 2, 3296, 4517);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (305, E'FRATEXA', E'persona juridica', E'', E'SUSANA ABUAWAD', NULL, E'3461758', E'3464837', E'', NULL, E'Santa Cruz', 2, 3297, 4518);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (271, E'GARDCO (PAUL GARDNER CO., INC.)', E'persona juridica', E'', E'JENNIFER ZULLO', NULL, E'(954) 946-9454', E'(954) 946-9309', E'', NULL, E'Santa Cruz', 2, 3298, 4519);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (277, E'GENELEC S.R.L.', E'persona juridica', E'', E'MARIA LUISA BUTRÓN B.', NULL, E'349-6161', E'349-6161', E'', NULL, E'Santa Cruz', 2, 3299, 4520);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (326, E'SUNPOWER SYSTEM', E'persona juridica', E'', E'HERMAN CORNER', NULL, E'3323222', E'3323222', E'', NULL, E'Santa Cruz', 2, 3315, 4537);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (306, E'TEST EQUIPMENT DEPOT', E'persona juridica', E'', E'', NULL, E'800 517 8431', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4538);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (292, E'WARA SEGURIDAD INDUSTRIAL', E'persona juridica', E'', E'ALVARO D. MONTOYA MÁLAGA', NULL, E'71517152', E'', E'', NULL, E'Santa Cruz', 2, 3316, 4539);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (328, E'GEOEQUIPOS', E'persona juridica', E'', E'ALBERTO URIOSTE', NULL, E'343-0389', E'343-0389', E'', NULL, E'Santa Cruz', 2, 3344, 4565);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (357, E'GLADYMAR S.A.', E'persona juridica', E'', E'', NULL, E'3468383', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4566);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (6, E'AUTOPIEZAS CONTRERAS LTDA', E'persona juridica', E'1013059020', E'MARCIA ELENA CONTRERAS BRITTEZ', NULL, E'332-4003', E'332-9436', E'', NULL, E'Santa Cruz', 2, 3081, 4247);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (296, E'WINARG SRL', E'persona juridica', E'', E'SILVINA ROPOLO', NULL, E'3330854', E'3340111', E'', NULL, E'Santa Cruz', 2, 3317, 4540);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (293, E'WW-TRADE', E'persona juridica', E'2960191015', E'CLAUDIA RIBERA MARCOS', NULL, E'320-1709 707-84446', E'320-1709', E'', NULL, E'Santa Cruz', 2, 3318, 4541);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (330, E'MONOPOL LTDA', E'persona juridica', E'1020525025', E'PATRICIA CAROLINA REZNICEK FALKENSTEIN', NULL, E'347-0707', E'346-3394', E'', NULL, E'Santa Cruz', 2, 3319, 4542);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (340, E'HILLER ELECTRIC S.A.', E'persona juridica', E'1028647022', E'NORBERT HONNEN', NULL, E'352-4484', E'352-6404', E'', NULL, E'Santa Cruz', 2, 3320, 4543);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (343, E'FINNING BOLIVIA S.A.', E'persona juridica', E'1028337028', E'CARLOS EDUARDO CARRASCO BLACUTT', NULL, E'342-9688', E'342-0556', E'', NULL, E'Santa Cruz', 2, 3321, 4544);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (348, E'ROCHI SERVICIOS', E'persona juridica', E'1596738016', E'ROSIO ELIZABETH  AKAMINE DE DICK', NULL, E'3-532253', E'341-3422', E'', NULL, E'Santa Cruz', 2, 3322, 4545);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (355, E'MAYSER HNOS SRL', E'persona juridica', E'1012431023', E'MARYLIN  MAYSER DE NAYAR', NULL, E'3327485 - 72143059', E'334-7104', E'', NULL, E'Santa Cruz', 2, 3323, 4546);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (347, E'COMERCIAL GERDAU  S.A.', E'persona juridica', E'128261027', E'HENRY ARNOFF', NULL, E'314-3005', E'314-3010', E'', NULL, E'Santa Cruz', 2, 3334, 4555);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (359, E'COSERELEC S.A.', E'persona juridica', E'', E'ROBERTO CABRAL IBAÑEZ', NULL, E'3-4620948', E'3-4621654', E'', NULL, E'Santa Cruz', 2, 3335, 4556);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (339, E'CROWN LTDA', E'persona juridica', E'1023113020', E'RODRIGO AVILA', NULL, E'332-3800', E'335-4488', E'', NULL, E'Santa Cruz', 2, 3336, 4557);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (342, E'DATABOL', E'persona juridica', E'', E'MARCELO PINTO', NULL, E'3643973', E'3476030', E'', NULL, E'Santa Cruz', 2, 3337, 4558);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (344, E'EMSI', E'persona juridica', E'', E'EDUARDO TORRICOS', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3338, 4559);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (371, E'E.S.E.I.R.', E'persona juridica', E'', E'ENRIQUE ROBLEDO', NULL, E'6630846', E'6630846', E'', NULL, E'Santa Cruz', 2, 3339, 4560);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (335, E'ESE LTDA', E'persona juridica', E'1028185024', E'ARTURO VERA', NULL, E'3460561', E'3462564', E'', NULL, E'Santa Cruz', 2, 3340, 4561);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (368, E'FERRETERIA LOS TAMARINDOS', E'persona juridica', E'1737534013', E'VIDAL RICARDO HUANACO LEIVA', NULL, E'462-1972', E'462-1972', E'', NULL, E'Santa Cruz', 2, 3341, 4562);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (361, E'FERRETERIA SAN AGUSTIN', E'persona juridica', E'584701014', E'VITALIA FLORES QUISPE', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3342, 4563);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (345, E'FUELTECH SA', E'persona juridica', E'', E'BOB CHRZANOWSKI', NULL, E'1-321-268-2065', E'1-321-264-0107', E'', NULL, E'Santa Cruz', 2, 3343, 4564);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (364, E'GOMA LON', E'persona juridica', E'3769993011', E'MARÍA COCÓ MORATÓ TORRICO', NULL, E'6645911', E'', E'', NULL, E'Santa Cruz', 2, 3345, 4567);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (362, E'IMPORT TELECOM', E'persona juridica', E'5323436012', E'ANISETO SEGOBIA T.', NULL, E'46472783', E'', E'', NULL, E'Santa Cruz', 2, 3346, 4568);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (387, E'FERROS M.T.P.', E'persona juridica', E'', E'MARISOL TORREJON', NULL, E'70873083', E'', E'', NULL, E'Santa Cruz', 2, 3379, 4609);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (417, E'GEOGROUP', E'persona juridica', E'2920141018', E'ERICH JORGE FISHER MERCADO', NULL, E'3997077', E'3997076', E'', NULL, E'Santa Cruz', 2, 3380, 4610);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (8, E'BATERIAS CENTRAL', E'persona juridica', E'6293058019', E'OSCAR PERALTA', NULL, E'3421191', E'3421348', E'', NULL, E'Santa Cruz', 2, 3082, 4248);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (60, E'INBOLPACK', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4249);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (370, E'LIBRERÍA PAPELERIA GENESIS', E'persona juridica', E'', E'UREÑA DURAN MARIA LUZ', NULL, E'450-1462', E'450-1462', E'', NULL, E'Santa Cruz', 2, 3347, 4569);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (412, E'BARRACA \\\"EL TUNAL\\\"', E'persona juridica', E'1871255013', E'DOLORES ZAMBRANA RUEDA', NULL, E'66-40571', E'66-40571', E'', NULL, E'Santa Cruz', 2, 3368, 4570);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (358, E'TALLER UGARTE', E'persona juridica', E'5558334015', E'JOSÉ A UGARTE', NULL, E'6943015', E'', E'', NULL, E'Santa Cruz', 2, 3357, 4581);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (337, E'TDE', E'persona juridica', E'', E'ORIS MUÑOZ', NULL, E'4259529', E'4259521', E'', NULL, E'Santa Cruz', 2, 3358, 4582);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (374, E'ZOOM & OFFICE', E'persona juridica', E'3604423015', E'CARLOS EDWIN MAGNE IQUIZE', NULL, E'455-9086', E'455-9926', E'', NULL, E'Santa Cruz', 2, 3359, 4583);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (373, E'CASA FERNANDO AYARDE', E'persona juridica', E'1248129013', NULL, NULL, E'466-37392', E'466-37392', E'', NULL, E'Santa Cruz', 2, NULL, 4584);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (378, E'TERESA CARDOZO ROCHA', E'persona natural', E'629827010', E'TERESA CARDOZO ROCHA', NULL, E'252 - 73 272', E'252 - 79255', E'', NULL, E'Santa Cruz', 2, 3360, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (388, E'MAIDA INTERNATIONAL, LTD', E'persona juridica', E'', E'ROBERT JAROSINSKI', NULL, E'1.516.676.3079', E'1.516.676.3199', E'', NULL, E'Santa Cruz', 2, 3361, 4585);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (389, E'CATERCU S.R.L.', E'persona juridica', E'152274029', E'ENRIQUE ROSAS ORELLANA', NULL, E'342-5222', E'342-5222', E'', NULL, E'Santa Cruz', 2, 3172, 4586);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (392, E'LEMANS LTDA', E'persona juridica', E'1028551027', E'BRIDYN RUIZ', NULL, E'3466409', E'3466401', E'', NULL, E'Santa Cruz', 2, 3362, 4587);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (402, E'CONFEXT SRL', E'persona juridica', E'134629020', E'JULY RIVAS', NULL, E'341-7447', E'', E'', NULL, E'Santa Cruz', 2, 3332, 4588);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (405, E'SOLINPET', E'persona juridica', E'3277454012', E'JOSÉ TOMÁS SALAZAR VEGA', NULL, E'351-8024', E'351-0849', E'', NULL, E'Santa Cruz', 2, 3363, 4589);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (413, E'MARISOL TORREJON PEDRAZA', E'persona natural', E'5403353014', E'BENIGNA MARISOL TORREJON PEDRAZA', NULL, E'77662176', E'', E'', NULL, E'Santa Cruz', 2, 3364, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (415, E'LINEATEX SRL', E'persona juridica', E'142821023', E'ROBERTO NAZRALA', NULL, E'343-4918', E'343-4918', E'', NULL, E'Santa Cruz', 2, 3365, 4590);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (421, E'SAN JUAN REPRESENTACIONES', E'persona juridica', E'5837530018', E'EDUARDO SAN JUAN', NULL, E'3354127', E'3303143', E'', NULL, E'Santa Cruz', 2, 3366, 4591);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (422, E'EMELEC S.R.L.', E'persona juridica', E'1007853025', E'ROGER ARMANDO ZAMBRANA MORALES', NULL, E'3370017', E'', E'', NULL, E'Santa Cruz', 2, 3367, 4592);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (380, E'AGENCIA OFICIAL DE CEMENTO FANCESA N° 72', E'persona juridica', E'', E'', NULL, E'665-2106', E'665-2106', E'', NULL, E'Santa Cruz', 2, NULL, 4593);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (384, E'ENGINEERED SOFTWARE, INC.', E'persona juridica', E'', E'PAUL KELLY', NULL, E'(360) 412-0702 X130', E'(360) 412-0672', E'', NULL, E'Santa Cruz', 2, 3377, 4606);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (385, E'EQUIPO HOGAR', E'persona juridica', E'', E'CARLOS GUTIERREZ', NULL, E'4-425 -7433', E'4-450-7495', E'', NULL, E'Santa Cruz', 2, 3378, 4607);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (395, E'FERRETERIA CENTER', E'persona juridica', E'', E'', NULL, E'425-5329', E'425-5329', E'', NULL, E'Santa Cruz', 2, NULL, 4608);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (381, E'IHS GLOBAL', E'persona juridica', E'', E'RODRIGO PLATA', NULL, E'800-624-3974', E'303-397-2730', E'', NULL, E'Santa Cruz', 2, 3381, 4611);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (397, E'INTTEL', E'persona juridica', E'', E'JHONY TOLABA', NULL, E'3514353', E'3514353', E'', NULL, E'Santa Cruz', 2, 3382, 4612);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (455, E'DPS COMPUTER', E'persona juridica', E'', E'MARCELO DIEGO HINOJOSA FRANCO', NULL, E'3518214', E'3596406', E'', NULL, E'Santa Cruz', 2, 3411, 4646);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (470, E'EMPSAAT', E'persona juridica', E'10238070236', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4647);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (9, E'BEICRUZ S.A.', E'persona juridica', E'1027325028', E'JOSE CARLOS VACA', NULL, E'343-8500 INT. 105', E'343-8600', E'', NULL, E'Santa Cruz', 2, 3083, 4250);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (399, E'ISE & E', E'persona juridica', E'', E'FERNANDO RIBERTY R', NULL, E'4451195', E'4451195', E'', NULL, E'Santa Cruz', 2, 3383, 4613);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (407, E'LIBRERÍA EL ESCRITORIO', E'persona juridica', E'1884360017', E'', NULL, E'664-3908', E'664-7666', E'', NULL, E'Santa Cruz', 2, NULL, 4614);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (423, E'LOGYTRONIC TECNOLOGIA ELETRONICA', E'persona juridica', E'4821490010', E'MARLENE CONDE ZANCA', NULL, E'3300694', E'', E'', NULL, E'Santa Cruz', 2, 3384, 4615);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (420, E'MICROSOFT', E'persona juridica', E'', E'JONATHAN COSSIO', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3385, 4616);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (425, E'PLASTICOS CARMEN S.R.L.', E'persona juridica', E'', E'', NULL, E'3332762', E'3473472', E'', NULL, E'Santa Cruz', 2, NULL, 4617);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (410, E'ROCHESTER MEXICO', E'persona juridica', E'', E'SERGIO ZARAZÚA', NULL, E'5255 3003 0970', E'5255 3003 0986', E'', NULL, E'Santa Cruz', 2, 3349, 4618);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (391, E'SIDE AUTOMATION', E'persona juridica', E'2049423012', E'PATRICIO VILLA', NULL, E'3537419 70933737', E'3537419', E'', NULL, E'Santa Cruz', 2, 3386, 4619);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (408, E'TALLER ELECTRICO HERBAS', E'persona juridica', E'938496015', E'CELSO HERBAS ZAMBRANA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3387, 4620);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (403, E'TAYLOR & FRANCIS CRC PRESS', E'persona juridica', E'', E'', NULL, E'1-561-994-0555', E'1-561-361-6018', E'', NULL, E'Santa Cruz', 2, NULL, 4621);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (439, E'IMPORTADORA COMERCIAL PARMAT LTDA', E'persona juridica', E'140873025', E'WALTER EDUARDO IRAOLA SORUCO', NULL, E'357-1003', E'359-8200', E'', NULL, E'Santa Cruz', 2, 3396, 4629);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (465, E'VIDAL SOLANO FARFAN', E'persona natural', E'1659691012', E'VIDAL SOLANO FARFAN', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3397, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (468, E'SATURNINO PEREZ REYES', E'persona natural', E'1789990015', E'SATURNINO PEREZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3398, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (477, E'LIBRERÍA NUEVOS TIEMPOS', E'persona juridica', E'1607181019', E'LETICIA ALTAMIRANO DE ROSSEL', NULL, E'S/N', E'', E'', NULL, E'Santa Cruz', 2, 3399, 4630);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (478, E'MORKEN BOLIVIA S.R.L.', E'persona juridica', E'1026083023', E'LUIS ALBERTO GRIMBERG', NULL, E'3354732', E'', E'', NULL, E'Santa Cruz', 2, 3400, 4631);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (489, E'KUKER SRL DISEÑO Y AMOBLAMIENTO', E'persona juridica', E'148556020', E'PEDRO RIVERA', NULL, E'3340110', E'3396743', E'', NULL, E'Santa Cruz', 2, 3402, 4632);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (454, E'AMOBLAMIENTO IMPERIAL', E'persona juridica', E'', E'AMADEO ROING', NULL, E'3341085', E'', E'', NULL, E'Santa Cruz', 2, 3403, 4633);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (456, E'CASA FUENTES', E'persona juridica', E'', E'AIDA GUTIERREZ', NULL, E'6722017', E'', E'', NULL, E'Santa Cruz', 2, 3404, 4634);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (472, E'CERAMICA ELVIA', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4636);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (435, E'CIAC STORE', E'persona juridica', E'', E'', NULL, E'3362864', E'3333074', E'', NULL, E'Santa Cruz', 2, NULL, 4637);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (461, E'COMERCIAL GABRIEL', E'persona juridica', E'', E'MARLENE ORELLANA', NULL, E'77045488', E'', E'', NULL, E'Santa Cruz', 2, 3405, 4638);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (482, E'COMERCIAL LUTINO', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4639);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (485, E'COMERCIAL VALDEZ', E'persona juridica', E'', E'SANDRALIT DELGADO', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3406, 4640);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (438, E'COMERCIAL WILDE', E'persona juridica', E'', E'DELIA MINOR', NULL, E'71857027', E'', E'', NULL, E'Santa Cruz', 2, 3407, 4641);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (483, E'CONFECCIONES RUTH', E'persona juridica', E'', E'RUTH TALAMAS', NULL, E'3424984', E'', E'', NULL, E'Santa Cruz', 2, 3408, 4642);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (464, E'DATA CONSULT', E'persona juridica', E'5258001016', E'RICARDO DENYS MENDIETA RODRIGUEZ', NULL, E'4550781', E'', E'', NULL, E'Santa Cruz', 2, 3409, 4643);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (480, E'DATA LEADER CONSULTANTS SRL', E'persona juridica', E'', E'MAXIMO CARREÑO', NULL, E'332-8822', E'332-8822', E'', NULL, E'Santa Cruz', 2, 3410, 4644);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (458, E'DISTRIBUIDORA DE MATERIALES DE CONSTRUCCION EN GRAL.', E'persona juridica', E'', E'', NULL, E'4623137', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4645);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (462, E'ENTEL S.A.', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4648);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (473, E'EQUIMPORT', E'persona juridica', E'', E'GROVER QUINTEROS', NULL, E'3642924', E'2642924', E'', NULL, E'Santa Cruz', 2, 3412, 4649);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (512, E'COMERCIAL YOLANDA', E'persona juridica', E'4132263017', E'YOLANDA CABALLERO', NULL, E'6723846', E'', E'', NULL, E'Santa Cruz', 2, 3446, 4701);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (484, E'TONY ROA', E'persona natural', E'', E'TONY ROA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3401, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (488, E'KARTER', E'persona juridica', E'', E'ROSEMBERG ZABALA', NULL, E'3324271', E'3324271', E'', NULL, E'Santa Cruz', 2, 3417, 4666);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (441, E'LA CASA DEL TOYOTA', E'persona juridica', E'', E'', NULL, E'4259733', E'4580326', E'', NULL, E'Santa Cruz', 2, NULL, 4667);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (490, E'LUZAN IMPORTACIONES', E'persona juridica', E'', E'', NULL, E'6643177', E'6645904', E'', NULL, E'Santa Cruz', 2, NULL, 4668);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (451, E'MOTOR PARTS MATEO', E'persona juridica', E'', E'', NULL, E'3344213', E'3323071', E'', NULL, E'Santa Cruz', 2, NULL, 4669);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (466, E'MUEBLERIA LA PAZ', E'persona juridica', E'5095309019', E'VICKI VASQUEZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3418, 4670);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (447, E'MUEBLES URKUPIÑA', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4671);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (450, E'NATUREZA', E'persona juridica', E'', E'DANIELA JORDAN', NULL, E'4470476', E'4470476', E'', NULL, E'Santa Cruz', 2, 3419, 4672);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (463, E'PAIPE', E'persona juridica', E'1070375015', E'AURELIO PERALTA', NULL, E'46440128', E'', E'', NULL, E'Santa Cruz', 2, 3420, 4673);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (448, E'PINEDOS.COM', E'persona juridica', E'', E'', NULL, E'46444739', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4674);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (475, E'PLANTA DE ARIDOS VARGAS', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4675);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (469, E'RIVEK', E'persona juridica', E'', E'', NULL, E'3421741', E'3145171', E'', NULL, E'Santa Cruz', 2, NULL, 4676);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (426, E'SAIMONS', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4677);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (445, E'SERVILLANTAS', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4678);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (453, E'SOFTBUILDERS', E'persona juridica', E'', E'CINTHIA VERDUGUEZ', NULL, E'3641914', E'3641914', E'', NULL, E'Santa Cruz', 2, 3183, 4679);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (446, E'EMADE - MADERAS Y MUEBLES', E'persona juridica', E'', E'ERNESTO BORDA ORELLANA', NULL, E'44553207 -44553207', E'', E'', NULL, E'Santa Cruz', 2, 3421, 4680);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (497, E'ADOLFO TEJERINA', E'persona natural', E'1852407014', E'ADOLFO TEJERINA', NULL, E'6723433', E'', E'', NULL, E'Santa Cruz', 2, 3422, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (501, E'CLIP ARTICULOS PARA OFICINA Y SEGURIDAD INDUSTRIAL', E'persona juridica', E'150470028', E'GUILLERMO MONTENEGRO', NULL, E'358-7678', E'358-7678', E'', NULL, E'Santa Cruz', 2, 3423, 4681);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (503, E'LABAGUA IMPORT SERVICE S.R.L.', E'persona juridica', E'124715024', E'GABY SAUCEDO ZEBALLOS', NULL, E'3394609', E'3376248', E'', NULL, E'Santa Cruz', 2, 3424, 4682);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (504, E'GREGORIA RODRIGUEZ', E'persona natural', E'6285900015', E'GREGORIA RODRIGUEZ', NULL, E'73445249', E'', E'', NULL, E'Santa Cruz', 2, 3425, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (508, E'FERRETERIA ARCELOR', E'persona juridica', E'5643716013', E'JOSE LUIS MAMANI YAPURA', NULL, E'6432903', E'', E'', NULL, E'Santa Cruz', 2, 3426, 4683);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (509, E'MERCEDES NUÑEZ PINTO', E'persona natural', E'', E'', NULL, E'6446066', E'', E'', NULL, E'Santa Cruz', 2, 3427, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (517, E'CHEVRON', E'persona juridica', E'', E'ALEJANDRO CUELLAR', NULL, E'3427979', E'3426448', E'', NULL, E'Santa Cruz', 2, 19, 20);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (519, E'ELECTRORED BOLIVIA S.R.L.', E'persona juridica', E'1020281024', E'RENE JALLAZA MALLCO', NULL, E'3145957', E'3145956', E'', NULL, E'Santa Cruz', 2, 3428, 4684);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (523, E'DICO TEC', E'persona juridica', E'1550105018', E'FERNANDO REYES', NULL, E'3341818', E'3332075', E'', NULL, E'Santa Cruz', 2, 3429, 4685);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (530, E'JHONNY CUEVAS CASTRO', E'persona natural', E'5074544', E'JHONNY CUEVAS CASTRO', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3430, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (500, E'COMERCIAL BUTRON', E'persona juridica', E'', E'JHONY BUTRON', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3441, 4695);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (545, E'COMERCIAL EFROCAR', E'persona juridica', E'', E'', NULL, E'8522586', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4696);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (502, E'COMERCIAL FANNY', E'persona juridica', E'', E'FANNY MENDEZ DE RAMIREZ', NULL, E'6722694', E'', E'', NULL, E'Santa Cruz', 2, 3442, 4697);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (506, E'COMERCIAL FERNANDA', E'persona juridica', E'', E'ELVIRA FERNANDEZ', NULL, E'6635314', E'', E'', NULL, E'Santa Cruz', 2, 3443, 4698);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (511, E'COMERCIAL MARY', E'persona juridica', E'1880264017', E'MARIA LUIZA BETANCUR', NULL, E'46646230', E'', E'', NULL, E'Santa Cruz', 2, 3444, 4699);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (538, E'COMERCIAL STADIUM', E'persona juridica', E'1657159017', E'RENE MONTELLANO MENDEZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3445, 4700);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (498, E'CORPORACION INDUSTRIAL SABAYA SRL', E'persona juridica', E'', E'GERARDO FRANCO', NULL, E'6636939', E'6636939', E'', NULL, E'Santa Cruz', 2, 3447, 4702);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (522, E'CRM SRL', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4703);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (573, E'VENTICRUZ INGENIERIA', E'persona juridica', E'1030641029', E'RICARDO ALFREDO RIPA', NULL, E'3509368', E'3501016', E'', NULL, E'Santa Cruz', 2, 3476, 4738);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (12, E'BOLIVIAN CENTER´S SRL.', E'persona juridica', E'3877156010', E'MARIA ADELA SUAREZ RIBERA', NULL, E'336-8960', E'333-1420', E'', NULL, E'Santa Cruz', 2, 3084, 4251);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (537, E'DISTRIBUIDORA EL CORCHO', E'persona juridica', E'', E'VICTORIA PLAZA DAZA', NULL, E'46427675', E'', E'', NULL, E'Santa Cruz', 2, 3448, 4704);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (513, E'EDUARDO RIVERA', E'persona juridica', E'', E'EDUARDO RIVERA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3449, 4705);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (541, E'ELECTRONICA NEW STAR', E'persona juridica', E'5306646017', E'VIDAL VARGAS', NULL, E'44251797', E'', E'', NULL, E'Santa Cruz', 2, 3450, 4706);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (491, E'ELECTRO TARIJA', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4707);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (540, E'EMISA', E'persona juridica', E'', E'ZENAIDA TORREZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3451, 4708);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (525, E'EMPRESA DURAN', E'persona juridica', E'', E'CLEMENTE MUR', NULL, E'3507946', E'3507946', E'', NULL, E'Santa Cruz', 2, 3452, 4709);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (510, E'EQUIPAMIENTO MODULAR', E'persona juridica', E'3873287019', E'ANGELA JUANA MORALES FLORES', NULL, E'3431495', E'3431495', E'', NULL, E'Santa Cruz', 2, 3453, 4710);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (492, E'FERRETERIA BELEN', E'persona juridica', E'3415857811', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4711);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (507, E'FEDERICO RUEDA', E'persona natural', E'1576255010', E'FEDERICO RUEDA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3454, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (521, E'FERRETERIA Y ASERRADERO BARRIENTOS', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4712);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (527, E'ROBERTO OROS PINTO', E'persona natural', E'', NULL, NULL, E'76170575', E'', E'', NULL, E'Santa Cruz', 2, 3455, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (516, E'FERRO - COMERCIAL TAJIBAL', E'persona juridica', E'', E'', NULL, E'4623137', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4713);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (499, E'FUNDICION METALURGICA', E'persona juridica', E'', E'ZONON ALANOCA', NULL, E'2811419', E'2811331', E'', NULL, E'Santa Cruz', 2, 3456, 4714);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (518, E'HIVAL COMERCIALIZADORES', E'persona juridica', E'4082713011', E'VICTORIA PLAZA DAZA', NULL, E'6442467', E'469-13131', E'', NULL, E'Santa Cruz', 2, 3448, 4715);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (515, E'ILUMINACION LORETO', E'persona juridica', E'', E'', NULL, E'4624369', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4716);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (555, E'TRISERVI SRL', E'persona juridica', E'130017023', E'EDWIN ARANA CABRERA', NULL, E'3647676', E'3647677', E'', NULL, E'Santa Cruz', 2, 3468, 4730);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (556, E'EUROCOM', E'persona juridica', E'1026647026', E'IVAN CERNA GARCIA', NULL, E'3522723', E'3578483', E'', NULL, E'Santa Cruz', 2, 3469, 4731);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (557, E'DISTRIBUIDORA CUMMINS S.A.', E'persona juridica', E'1013135029', E'JORGE ALBERTO GUIOMAR', NULL, E'3120279', E'3518191', E'', NULL, E'Santa Cruz', 2, 3470, 4732);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (558, E'IMPRENTA SANTANDER', E'persona juridica', E'5416930015', E'ALFREDO SANTANDER', NULL, E'3372877', E'3393043', E'', NULL, E'Santa Cruz', 2, 3471, 4733);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (565, E'TECNOLOGIA INTEGRAL S.A. (INTEC S.A.)', E'persona juridica', E'1012085025', E'JORGE ARTIEDA FLORES', NULL, E'3537772', E'3547996', E'', NULL, E'Santa Cruz', 2, 3472, 4734);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (566, E'MULTIMEQ', E'persona juridica', E'3257155016', E'JUDITH JACKELINE VACA GUTIERREZ', NULL, E'3372219', E'3322363', E'', NULL, E'Santa Cruz', 2, 3473, 4735);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (569, E'MARIENCO SRL', E'persona juridica', E'1006971028', E'MAURICIO LEMA', NULL, E'3390500', E'3475762', E'', NULL, E'Santa Cruz', 2, 3474, 4736);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (570, E'MERTIND LTDA', E'persona juridica', E'1026247020', E'JAIME LIJERÓN EGUEZ', NULL, E'3367676', E'3367676', E'', NULL, E'Santa Cruz', 2, 3475, 4737);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (574, E'OPERLOGIC SRL', E'persona juridica', E'147512023', E'RAFAEL LEONIDAS ZAVALLA CARBO', NULL, E'3417264', E'3416128', E'', NULL, E'Santa Cruz', 2, 3477, 4739);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (575, E'YVER REQUE HERBAS', E'persona natural', E'2853777016', E'YVER REQUE HERBAS', NULL, E'3533740', E'3550001', E'', NULL, E'Santa Cruz', 2, 3478, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (593, E'DATA CONSUL', E'persona juridica', E'5923570019', E'MAGDALENA VERA COCA', NULL, E'4558137', E'', E'', NULL, E'Santa Cruz', 2, 3491, 4749);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (589, E'EL MUNDO DEL PAPEL', E'persona juridica', E'', E'GROVER REQUE', NULL, E'44681316', E'', E'', NULL, E'Santa Cruz', 2, 3492, 4750);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (571, E'EL PALACIO DE LAS POLERAS', E'persona juridica', E'3229121011', E'ROLANDO CUELLAR CASTRO', NULL, E'3542836', E'', E'', NULL, E'Santa Cruz', 2, 3493, 4751);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (561, E'EMPRESA DE SERVICIOS COMPUTARIZADOS', E'persona juridica', E'1031017022', E'OSCAR PAZ SEVERICHE', NULL, E'3340578', E'3376889', E'', NULL, E'Santa Cruz', 2, 3494, 4752);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (564, E'EMPRESA DE SERVICIOS INFORMATICOS', E'persona juridica', E'2982610015', E'ELVIO JUSTINIANO HEREDIA', NULL, E'NO INDICA', E'NO INDICA', E'', NULL, E'Santa Cruz', 2, 3495, 4753);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (576, E'FERRETERIA IRAOLA', E'persona juridica', E'', E'', NULL, E'5277542', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4754);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (591, E'FERRO ACEROS', E'persona juridica', E'5882660011', E'MARIA NELLY AGUILERA', NULL, E'3511720', E'3567559', E'', NULL, E'Santa Cruz', 2, 3496, 4755);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (578, E'GIS PLAN S.R.L', E'persona juridica', E'153174028', E'BRAULIO RENGEL NAVARRO', NULL, E'3572042 71688877', E'3372469', E'', NULL, E'Santa Cruz', 2, 3497, 4756);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (572, E'GRAFICA BOSTON', E'persona juridica', E'', E'GERMAN ANTORIANO', NULL, E'3365113', E'3365113', E'', NULL, E'Santa Cruz', 2, 3498, 4757);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (560, E'INDUSTRIA TEXTIL GRIGOTA S.A.', E'persona juridica', E'1015333029', E'EWALDO FISHER', NULL, E'3882424', E'3382225', E'', NULL, E'Santa Cruz', 2, 3499, 4758);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (563, E'INTERTEK TESTING SERVICES BOLIVIA S.A.', E'persona juridica', E'122037024', E'EDUARDO WENDT PADILLA', NULL, E'3511414', E'3516394', E'', NULL, E'Santa Cruz', 2, 3500, 4759);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (577, E'INTSAI S.R.L.', E'persona juridica', E'154764025', E'ARTURO GARVIZU', NULL, E'3417469', E'3417469', E'', NULL, E'Santa Cruz', 2, 3501, 4760);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (567, E'MANACO MANUFACTURA BOLIVIANA S.A.', E'persona juridica', E'1023149021', E'MARIA TERESA ABASTO PEREZ', NULL, E'4262900', E'4263013', E'', NULL, E'Santa Cruz', 2, 3502, 4761);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (587, E'MIL METALES', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4762);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (590, E'OPTICA VISCARRA', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4763);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (588, E'RODOS REPRESENTACIONES', E'persona juridica', E'1885983017', E'CINTIA LORENA CHAVEZ TORREZ DE RODO', NULL, E'6831203 76614806', E'', E'', NULL, E'Santa Cruz', 2, 3503, 4764);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (632, E'PETROLEO DESARROLLO E IMPORTACIONES S.A. PRODIMSA', E'persona juridica', E'1015361024', E'LUIS FERNANDO GUARDIA SANCHEZ', NULL, E'342-1084', E'342-0674', E'', NULL, E'Santa Cruz', 2, 3513, 4774);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (634, E'SINOPURE', E'persona juridica', E'3293711011', E'JOSÉ LUIS CALLAU VACA', NULL, E'3509248', E'3509248', E'', NULL, E'Santa Cruz', 2, 3514, 4775);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (635, E'AJ VIERCI', E'persona juridica', E'1028783024', E'ANIBAL FRANCO', NULL, E'3-145910', E'3-145911', E'', NULL, E'Santa Cruz', 2, 3515, 4776);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (630, E'AGROPECUARIA GRAN CHACO', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4777);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (648, E'BELCOM', E'persona juridica', E'', E'HELEN ALVAREZ', NULL, E'3515456', E'3515456', E'', NULL, E'Santa Cruz', 2, 3516, 4778);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (641, E'CASA DE PINTURAS FARBEN', E'persona juridica', E'3792054012', E'LUCIANO PACOLI BEJARANO', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3517, 4779);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (650, E'C.E. YOVENO', E'persona juridica', E'3555626015', E'NOGALES VERA ERICK NELSON', NULL, E'4556695', E'4556695', E'', NULL, E'Santa Cruz', 2, 3518, 4780);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (609, E'COMERCIAL ALFHER', E'persona juridica', E'', E'YOLANDA HEREDIA', NULL, E'46442320', E'', E'', NULL, E'Santa Cruz', 2, 3519, 4781);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (614, E'COMERCIAL CHOCAMANI', E'persona juridica', E'1110658015', E'SATURNINO CHOCAMANI', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3520, 4782);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (615, E'COMERCIAL DC DE LA CRUZ', E'persona juridica', E'1109637010', E'EVARISTO DE LA CRUZ CRUZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3521, 4783);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (619, E'COMERCIAL LIDER', E'persona juridica', E'2407162015', E'PLACIDA CONDORI TRUJILLO', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3522, 4784);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (640, E'COMERCIAL ROMINA', E'persona juridica', E'1392712010', E'MARIA ALICIA T.DE AUZA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3523, 4785);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (692, E'MCL S.R.L. SUMINISTROS  EQUIPOS PETROLEROS', E'persona juridica', E'1027035026', E'MARCELO CUELLAR LANDIVAR', NULL, E'3540036', E'3539090', E'', NULL, E'Santa Cruz', 2, 3559, 4829);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (697, E'IMPORTADORA MUNDOCRUZ', E'persona juridica', E'', E'ROMER PARDO', NULL, E'364-2962', E'3-642962', E'', NULL, E'Santa Cruz', 2, 3560, 4830);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (13, E'BOLIVIAN ELECTRIC', E'persona juridica', E'1583343017', E'MARIA ANGELA MONTENEGRO DE URCULLO', NULL, E'348-7575', E'498300', E'', NULL, E'Santa Cruz', 2, 3085, 33);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (606, E'COMPUTER PLACE', E'persona juridica', E'3832736015', E'MARIA CATALINA AJHUACHO LAPACA', NULL, E'3325545', E'3371717', E'', NULL, E'Santa Cruz', 2, 3524, 4786);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (601, E'COMUNICACIONES AMERICA S.RL.', E'persona juridica', E'1012059029', E'PATRICIA DE AVILA', NULL, E'3343664', E'3343664', E'', NULL, E'Santa Cruz', 2, 3525, 4787);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (647, E'COPIAS MITA', E'persona juridica', E'', E'', NULL, E'3365275', E'3325112', E'', NULL, E'Santa Cruz', 2, NULL, 4788);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (625, E'CUMORAN SERVICIOS GENERALES', E'persona juridica', E'4023036011', E'JHONNY CHOQUE ROJAS', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3526, 4789);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (602, E'LIBRERÍA OLIMPIA', E'persona juridica', E'1020159021', E'ANA GABRIELA SANDINO', NULL, E'2330303', E'2314386', E'', NULL, E'Santa Cruz', 2, 3538, 4802);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (607, E'LIBRERÍA PRU-ROBIN S.R.L.', E'persona juridica', E'1020193020', E'', NULL, E'2245140', E'2240152', E'', NULL, E'Santa Cruz', 2, NULL, 4803);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (643, E'LIBRERÍA SANTA CRUZ', E'persona juridica', E'1630962011', E'LUIS ROBERTO DE LA VEGA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3539, 4804);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (627, E'MC INDUSTRIAL SUPLY CO.', E'persona juridica', E'3275736010', E'LUIS MAURICIO CABALLERO VARGAS', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3540, 4805);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (622, E'MULTISERVICIOS  VALLEGRANDE', E'persona juridica', E'2836449013', E'NORMA HERRERA DE RIOS', NULL, E'3120129', E'', E'', NULL, E'Santa Cruz', 2, 3541, 4806);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (652, E'NEXYS DE BOLIVIA S.A.', E'persona juridica', E'', E'NEXYS DE BOLIVIA S.A.', NULL, E'3360777', E'3360777', E'', NULL, E'Santa Cruz', 2, 3542, 4807);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (636, E'POWER TRACK', E'persona juridica', E'534560018', E'JOSE CARLOS ROCA PAZ', NULL, E'3-551871', E'3-551871', E'', NULL, E'Santa Cruz', 2, 3543, 4808);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (599, E'PROAN', E'persona juridica', E'1027261020', E'WALTER YAÑEZ', NULL, E'3420257', E'3435244', E'', NULL, E'Santa Cruz', 2, 3544, 4809);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (645, E'PROVEEDOR EVENTUAL I', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4810);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (624, E'R.C.M. FOTOCOPIA - LIBRERÍA', E'persona juridica', E'982372016', E'RENE CAMACHO ROJAS', NULL, E'4229148', E'', E'', NULL, E'Santa Cruz', 2, 3545, 4811);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (613, E'R Y C COMERCIO', E'persona juridica', E'3826469014', E'RUDY CALATAYUD', NULL, E'3642255', E'3642255', E'', NULL, E'Santa Cruz', 2, 3546, 4812);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (623, E'SHOPPING PC', E'persona juridica', E'3503776018', E'EUGENIO SOLARES VILLANUEVA', NULL, E'3120129', E'', E'', NULL, E'Santa Cruz', 2, 3547, 4813);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (618, E'SUR LINK', E'persona juridica', E'3234508019', E'MIRANDA GARCIA EUSEBIO EDUARDO', NULL, E'3418324', E'3145932', E'', NULL, E'Santa Cruz', 2, 3548, 4814);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (639, E'VITAGUA', E'persona juridica', E'', E'', NULL, E'3354764', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4815);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (651, E'IMPORTADORA IMAGEN DIGITAL FOINFA S.R.L.', E'persona juridica', E'161812025', NULL, NULL, E'3582028', E'3582028', E'', NULL, E'Santa Cruz', 2, NULL, 4816);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (653, E'ICOM SRL', E'persona juridica', E'152826022', E'FREDDY OSINAGA', NULL, E'3649549-3649561', E'3649593', E'', NULL, E'Santa Cruz', 2, 3098, 4817);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (689, E'BOLIVIA TOTAL SERVICES LTDA', E'persona juridica', E'', E'IGOR ANTONIO IVANOVIC MUSTO', NULL, E'34590000', E'3449344', E'', NULL, E'Santa Cruz', 2, 3557, 4827);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (691, E'M.I.C. IMPORTACIONES Y REPRESENTACIONES', E'persona juridica', E'', E'IVAR REYNALDO TORRICO', NULL, E'3512320', E'3511122', E'', NULL, E'Santa Cruz', 2, 3558, 4828);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (701, E'ALMACEN CLHB SUCRE', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4831);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (688, E'ATLAS WORLD', E'persona juridica', E'', E'TITO JOSE MONASTERIO BELLOT', NULL, E'33354979', E'3354974', E'', NULL, E'Santa Cruz', 2, 3561, 4832);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (720, E'MULTILINEAS IMPORTADORA', E'persona juridica', E'3273440015', E'JOSE AUGUSTO PLAZA', NULL, E'351-9044', E'351-9044', E'', NULL, E'Santa Cruz', 2, 3589, 4867);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (15, E'CARLOS CABALLERO', E'persona natural', E'', E'CARLOS CABALLERO', NULL, E'492929', E'492929', E'', NULL, E'Santa Cruz', 2, 3086, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (670, E'AUTOPARTES CADIZ', E'persona juridica', E'', E'VICTOR CADIZ C.', NULL, E'344-1947', E'343-4518', E'', NULL, E'Santa Cruz', 2, 3562, 4833);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (655, E'CASA EICO', E'persona juridica', E'', E'CASA EICO', NULL, E'3358430', E'3358430', E'', NULL, E'Santa Cruz', 2, 3563, 4834);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (668, E'CEINA LTDA', E'persona juridica', E'1025511029', E'JUAN ALVARO DURAN', NULL, E'352-1242', E'352-0258', E'', NULL, E'Santa Cruz', 2, 3564, 4835);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (661, E'CHATAS LOLY', E'persona juridica', E'', E'REMBERTO CESPEDEZ', NULL, E'3401369', E'3401369', E'', NULL, E'Santa Cruz', 2, 3565, 4836);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (675, E'CLIN SRL ACCESORIOS PARA BAÑOS', E'persona juridica', E'1000873021', E'IVEHE ALEJANDRA BUSTILLO RIOS', NULL, E'278-2200', E'278-2200', E'', NULL, E'Santa Cruz', 2, 3566, 4837);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (659, E'CONFECCIONES UNIVERSAL', E'persona juridica', E'', E'HONORATO CHOQUE', NULL, E'4222836', E'4222836', E'', NULL, E'Santa Cruz', 2, 3567, 4838);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (678, E'CORCELSA', E'persona juridica', E'', E'RODRIGO GARCIA', NULL, E'4280683', E'4480279', E'', NULL, E'Santa Cruz', 2, 3568, 4839);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (698, E'EDITORIAL MOCA', E'persona juridica', E'', E'', NULL, E'4228558', E'4588480', E'', NULL, E'Santa Cruz', 2, NULL, 4840);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (699, E'RODATRACK', E'persona juridica', E'', E'ANDERSON CESCONCETO', NULL, E'344-2602', E'', E'', NULL, E'Santa Cruz', 2, 3579, 4852);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (674, E'ROPARTS', E'persona juridica', E'1599731011', E'ALBERTO RODA', NULL, E'3452796', E'3452725', E'', NULL, E'Santa Cruz', 2, 3580, 4853);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (672, E'RULEMAN', E'persona juridica', E'', E'MAMERTO SUAREZ', NULL, E'336-8673', E'336-8156', E'', NULL, E'Santa Cruz', 2, 3581, 4854);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (694, E'SMC PNEUMATICS BOLIVIA S.R.L.', E'persona juridica', E'', E'ERNESTO PERALTA', NULL, E'3449900', E'3448383', E'', NULL, E'Santa Cruz', 2, 3582, 4855);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (700, E'SOFYSTRADE', E'persona juridica', E'', E'ROSMERY CRESPO ROJAS', NULL, E'4426331', E'4226231', E'', NULL, E'Santa Cruz', 2, 3583, 4856);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (665, E'TAKE IT TECHNOLOGY', E'persona juridica', E'', E'', NULL, E'3303773', E'3358986', E'', NULL, E'Santa Cruz', 2, NULL, 4857);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (662, E'TALLER MILENIUM', E'persona juridica', E'', E'', NULL, E'3402167', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4858);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (664, E'TALLER TREBOL', E'persona juridica', E'', E'', NULL, E'3405270', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4859);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (663, E'TCIR CONSULTING SRL', E'persona juridica', E'', E'', NULL, E'3648394', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4860);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (680, E'WAISSE INSUMOS INDUSTRIALES SRL', E'persona juridica', E'165262020', E'JOSE LUIS WAISS', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3584, 4861);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (666, E'BATERIAS ARROYO', E'persona juridica', E'2829049013', NULL, NULL, E'346-8912', E'346-8912', E'', NULL, E'Santa Cruz', 2, NULL, 4862);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (654, E'TECHNOLOGY POINT', E'persona juridica', E'', NULL, NULL, E'3517363', E'3517363', E'', NULL, E'Santa Cruz', 2, NULL, 4863);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (703, E'INGELUB SRL', E'persona juridica', E'160326020', E'VERONICA AMUSQUIVAR', NULL, E'341-9909', E'341-9909', E'', NULL, E'Santa Cruz', 2, 3585, 4864);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (708, E'FLUICONST SRL', E'persona juridica', E'', E'LUIS CLAROS CAMPOS', NULL, E'76799051', E'2248578', E'', NULL, E'Santa Cruz', 2, 3586, 4865);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (718, E'SERMEI LTDA.', E'persona juridica', E'1014377027', E'MARCELO BUTRON', NULL, E'364-1595', E'364-1595', E'', NULL, E'Santa Cruz', 2, 3587, 4866);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (719, E'JUAN GILBERTO  ROJAS ARTEAGA -SEALS', E'persona natural', E'4331698014', E'JUAN ROJAS ARTEAGA', NULL, E'3305772', E'70446466', E'', NULL, E'Santa Cruz', 2, 3588, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (745, E'AB PETROVALVE S.R.L.', E'persona juridica', E'145494021', E'FRANCISCO AGUILERA SERRATE', NULL, E'351-1720', E'351-1720', E'', NULL, E'Santa Cruz', 2, 3596, 4875);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (728, E'AGENCIA FANCESA', E'persona juridica', E'1016259020', E'LUIS EDGAR TABOADA', NULL, E'644-1314', E'644-1314', E'', NULL, E'Santa Cruz', 2, 3530, 4876);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (770, E'MATSERVICE PETROLEO S.R.L.', E'persona juridica', E'171628023', E'MARCELO PANIAGUA SALINAS', NULL, E'344-4041', E'344-4041', E'', NULL, E'Santa Cruz', 2, 3623, 4908);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (61, E'INBUSTRADE', E'persona juridica', E'', E'JUAN CARLOS TERAN', NULL, E'3454255-3334515', E'3112283', E'', NULL, E'Santa Cruz', 2, 3139, 4252);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (716, E'ALMACEN  LA PAZ', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4877);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (717, E'ALMACEN TARIJA', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4878);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (733, E'BARRACA SAN ANTONIO', E'persona juridica', E'1141927015', E'OLGA DE CORONADO', NULL, E'646-0917', E'646-0917', E'', NULL, E'Santa Cruz', 2, 3599, 4879);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (704, E'CATERING INTERNATIONAL Y SERVICIOS SRL', E'persona juridica', E'1028681027', E'', NULL, E'3390739', E'3390616', E'', NULL, E'Santa Cruz', 2, NULL, 4880);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (712, E'RODAGRO', E'persona juridica', E'1592472010', E'LUIS DANIEL OROPEZA TURNER', NULL, E'3368673', E'3368156', E'', NULL, E'Santa Cruz', 2, 3600, 4881);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (735, E'COMERCIAL MUNDO COLOR', E'persona juridica', E'3869057011', E'ALBERTO FUENTES', NULL, E'646-2900', E'646-2900', E'', NULL, E'Santa Cruz', 2, 3601, 4882);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (734, E'COMERCIAL O Y R', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4883);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (731, E'COMERCIAL SEÑOR DE MAICA', E'persona juridica', E'3625867012', E'SANDRA CHUMACERO ESCALANTE', NULL, E'642-1959', E'642-1959', E'', NULL, E'Santa Cruz', 2, 3602, 4884);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (713, E'COMERCIAL SUVINIL', E'persona juridica', E'3103718017', E'VERONICA CRISTINA TORRA', NULL, E'6462532', E'', E'', NULL, E'Santa Cruz', 2, 3603, 4885);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (730, E'COMERCIAL LILI', E'persona juridica', E'7466262018', NULL, NULL, E'645-5037', E'643-4421', E'', NULL, E'Santa Cruz', 2, NULL, 4886);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (715, E'EL TREBOL SRL LIBRERÍA Y PAPELERIA', E'persona juridica', E'1008569027', E'VICTOR JHONY VELASCO', NULL, E'4251014', E'4223537', E'', NULL, E'Santa Cruz', 2, 3604, 4887);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (732, E'FERMA OR', E'persona juridica', E'1085898013', E'RUTH ORTUÑO E.', NULL, E'645-7903', E'645-7903', E'', NULL, E'Santa Cruz', 2, 3605, 4888);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (742, E'FERRETERIA LA POPULAR LTDA', E'persona juridica', E'', E'HUMBERTO ROCHA', NULL, E'3337460', E'3337460', E'', NULL, E'Santa Cruz', 2, 3606, 4889);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (726, E'IMPORTACIONES PALENQUE', E'persona juridica', E'3655409017', E'FELIX PALENQUE', NULL, E'646-62937', E'646-62937', E'', NULL, E'Santa Cruz', 2, 3607, 4890);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (737, E'IMPORTADORA DE LLANTAS ORNET SRL IMPORNET', E'persona juridica', E'', E'MIRIAN MONTOYA DE MONTAÑO', NULL, E'3469263', E'3469263', E'', NULL, E'Santa Cruz', 2, 3608, 4891);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (707, E'D&L FACOCELT', E'persona juridica', E'', E'HERLAND BANEGAS', NULL, E'357-1123', E'357-1123', E'', NULL, E'Santa Cruz', 2, 3461, 4902);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (727, E'COMERCIAL MULTISUR', E'persona juridica', E'7476458011', NULL, NULL, E'644-4157', E'644-4157', E'', NULL, E'Santa Cruz', 2, NULL, 4903);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (750, E'WILMA  ZURITA BARRIOS  DE TERAN', E'persona natural', E'920751018', E'WILMA  ZURITA BARRIOS  DE TERAN', NULL, E'3392584', E'3392584', E'', NULL, E'Santa Cruz', 2, 3618, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (754, E'PEMAC-JORGE P. MACLEAN ARCE', E'persona juridica', E'2314297010', E'JORGE P MACLEAN ARCE', NULL, E'3419921', E'721151515', E'', NULL, E'Santa Cruz', 2, 3619, 4904);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (761, E'ACEROS HERMAN S.R.L.', E'persona juridica', E'126211025', E'MANELITO RIBEIRO ANTUNES', NULL, E'3625351', E'3498804', E'', NULL, E'Santa Cruz', 2, 3620, 4905);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (763, E'ENERGY TECHNOLOGIES TRADING LTDA', E'persona juridica', E'1025225027', E'ANGEL PRIDA GARCIA', NULL, E'3553505-3572230', E'3122472-71630340', E'', NULL, E'Santa Cruz', 2, 3621, 4906);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (766, E'YPFB  REFINACION S.A.', E'persona juridica', E'1028255024', E'GUILLERMO LUIS ACHA MORALES', NULL, E'44762300', E'44216029', E'', NULL, E'Santa Cruz', 2, 3622, 4907);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (771, E'EQUIPOS TECNICOS INTERNACIONAL S.R.L.', E'persona juridica', E'1005871020', E'PABLO LUIS WEISS', NULL, E'214-5062', E'214-5063', E'', NULL, E'Santa Cruz', 2, 3624, 4909);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (791, E'SIEMENS-SOLUCIONES TECNOLOGICAS S.A.', E'persona juridica', E'146438029', E'VICTOR MANUEL TAMAYO CORREA', NULL, E'..', E'..', E'', NULL, E'Santa Cruz', 2, 3660, 4945);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (16, E'CASA JERUSALEN LTDA', E'persona juridica', E'120397022', E'CASA JERUSALEN LTDA', NULL, E'334-7470', E'336-6757', E'', NULL, E'Santa Cruz', 2, 3087, 4253);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (773, E'PROSERMACO SRL', E'persona juridica', E'150546029', E'RAMIRO GUZMAN CALVO', NULL, E'3597103', E'3599456', E'', NULL, E'Santa Cruz', 2, 3625, 4910);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (774, E'FLOW-ENG SRL', E'persona juridica', E'170352026', E'WALTER RAMIRO PEÑA MONTERO', NULL, E'74650898', E'', E'', NULL, E'Santa Cruz', 2, 3626, 4911);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (777, E'FUXION S.R.L.', E'persona juridica', E'146862026', E'ROCIO JUSTINIANO RIBERA', NULL, E'3399911', E'3116178', E'', NULL, E'Santa Cruz', 2, 3627, 4912);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (778, E'FERRETERIA HERRAMIENTA INDUSTRIALES- BEATRIL MONICA GANDARILLAS GIL', E'persona juridica', E'5878106017', E'BEATRIZ MONICA GANDARILLAS GIL', NULL, E'3461412', E'3481412', E'', NULL, E'Santa Cruz', 2, 3638, 4921);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (758, E'FERRETERIA PANAMERICANA SRL', E'persona juridica', E'', E'JESUS LEAÑOS REA', NULL, E'3331618', E'3335094', E'', NULL, E'Santa Cruz', 2, 3639, 4922);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (759, E'FERRETERIA PROGRESO', E'persona juridica', E'', E'MARTIN CARLOS JUSTINIANO ROYOS', NULL, E'3337097', E'3332852', E'', NULL, E'Santa Cruz', 2, 3640, 4923);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1001, E'GISER', E'persona juridica', E'6305428018', E'REMY EFRAÍN MICHEL JAEN', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3641, 4924);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (768, E'G&L SERVICIOS GENERALES SRL', E'persona juridica', E'', E'LUIS CAPOBIANCO', NULL, E'348-2413', E'349-1425', E'', NULL, E'Santa Cruz', 2, 3642, 4925);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (751, E'IMPORTADORA NACIONAL DE MATERIALES ELECTRICOS COCHABAMBA SRL', E'persona juridica', E'139147029', E'MARCO ANTONIO TERRAZAS', NULL, E'4246395', E'4404938', E'', NULL, E'Santa Cruz', 2, 3643, 4926);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (760, E' MIC IMPORTACIONES & REPRESENTACIONES', E'persona juridica', E'', NULL, NULL, E'351-2320', E'3512320', E'', NULL, E'Santa Cruz', 2, NULL, 4927);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (779, E'KAA-IYA LTDA', E'persona juridica', E'', E'PATRICIA BELTRAN- ALBERTO OROZA', NULL, E'344-6027', E'344-6032', E'', NULL, E'Santa Cruz', 2, 3644, 4928);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (767, E'KLOCNER', E'persona juridica', E'', E'MARCELO ORELLANA', NULL, E'473-6914', E'473-6913', E'', NULL, E'Santa Cruz', 2, 3645, 4929);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (769, E'KLOCNER-JULIETA ALCAZAR HUAYLLAS', E'persona juridica', E'625274015', E'JULIETA ALCAZAR HUAYLLAS', NULL, E'4736913-79974361', E'4736914', E'', NULL, E'Santa Cruz', 2, 3646, 4930);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (757, E'LIMBERG HEREDIA TERCEROS -IMPORTACIONES Y REPRESENTACIONES HEREDIA', E'persona juridica', E'3885455012', E'LIMBERG HEREDIA TERCEROS', NULL, E'3602334-79465774-60031779', E'3602334', E'', NULL, E'Santa Cruz', 2, 3647, 4931);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (762, E'LITORAL- FRANCISCA MAMANI MOYA', E'persona juridica', E'2662468015', E'FRANCISCA MAMANI MOYA', NULL, E'3488138', E'3488069', E'', NULL, E'Santa Cruz', 2, 3648, 4932);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (995, E'PECAGAS S.A.', E'persona juridica', E'823926013', E'JEANNETTE CORDOVA CRUZ', NULL, E'44574662', E'', E'', NULL, E'Trinidad', 10, 3649, 4933);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (789, E'HP MEDICAL-CECILIA HURTADO PEREDO', E'persona juridica', E'3884269019', E'CECILIA HURTADO PEREDO', NULL, E'3559454', E'3559454', E'', NULL, E'Santa Cruz', 2, 3659, 4944);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (792, E'AMERICAN PRINTER SRL', E'persona juridica', E'127095021', E'WALTER JORGE FERRUFINO  PONCE', NULL, E'4500362-4502574', E'4500362', E'', NULL, E'Santa Cruz', 2, 3661, 4946);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (786, E'L & B EQUIPOS INSTRUMENTOS Y REPUESTOS - LUIS BARBA BANZER', E'persona juridica', E'1568623012', E'LUIS BARBA BANZER', NULL, E'3326364', E'79941579', E'', NULL, E'Santa Cruz', 2, 3684, 4971);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (819, E'ALMACEN SUCRE', E'persona juridica', E'..', NULL, NULL, E'..', E'..', E'', NULL, E'Santa Cruz', 2, NULL, 4972);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (17, E'CASA KOREA', E'persona juridica', E'', E'CASA KOREA', NULL, E'3367171', E'3334715', E'', NULL, E'Santa Cruz', 2, 3088, 4254);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (795, E'AGROSACO-MARIA TERESA SOLIZ DE CORTES', E'persona juridica', E'3857821014', E'MARIA TERESA SOLIZ DE CORTEZ', NULL, E'3484112', E'3645807', E'', NULL, E'Santa Cruz', 2, 3662, 4947);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (796, E'TECNOELECTRIC URCULLO SRL', E'persona juridica', E'164026023', E'NEIFER MANUEL URCULLO DIEZ', NULL, E'3496652-3496653', E'349-6654', E'', NULL, E'Santa Cruz', 2, 3663, 4948);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (797, E'BALLSER  IMPORT- EXPORT/ BALLESTEROS SIERRA NUBIA YANNETH', E'persona juridica', E'171534022', E'BALLESTEROS SIERRA NUBIA YANNETH', NULL, E'327-925', E'3201393', E'', NULL, E'Santa Cruz', 2, 3664, 4949);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (801, E'TECZONA S.R.L. SUMINISTROS INDUSTRIALES Y SERVICIOS  DE MANTENIMIENTO', E'persona juridica', E'133843021', E'ROSARIO LOURDES ORDOÑEZ PEINADO', NULL, E'345-59139', E'..', E'', NULL, E'Santa Cruz', 2, 3665, 4950);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (803, E'PALMERAS S.R.L', E'persona juridica', E'1012659025', E'EDGAR CARLOS PEREZ VON BORRIES', NULL, E'3487837', E'3487837', E'', NULL, E'Santa Cruz', 2, 3666, 4951);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (804, E'CASTRILLON ALEIXES ARLEY', E'persona natural', E'1026837027', E'CASTRILLON ALEIXES ARLEY', NULL, E'33423194', E'3-3423194', E'', NULL, E'Santa Cruz', 2, 3667, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (798, E'SERPROIND SRL', E'persona juridica', E'167542028', NULL, NULL, E'360-8633', E'3498211', E'', NULL, E'Santa Cruz', 2, NULL, 4960);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (812, E'ALMACEN SANTA CRUZ', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4961);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (811, E'ALMACEN COCHABAMBA', E'persona juridica', E'………..', NULL, NULL, E'.', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4962);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (794, E'CATERBOL-JORGE  TOMAS LOPEZ PANTOJA', E'persona juridica', E'2640575017', E'JORGE TOMAS LOPE PANTOJA', NULL, E'75236054', E'75236054', E'', NULL, E'Santa Cruz', 2, 3676, 4963);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (814, E'NAJARRO CONSTRUCCIONES S.R.L.', E'persona juridica', E'160114021', E'AMERICO CLIMACO NAJARRO CASTRO', NULL, E'356-7624', E'70973330', E'', NULL, E'Santa Cruz', 2, 3677, 4964);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (805, E'DELAROCHA ASOCIADOS SRL', E'persona juridica', E'1001875021', E'DELAROCHA ASOCIADOS  SRL', NULL, E'22787175', E'22787497', E'', NULL, E'Santa Cruz', 2, 3678, 4965);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (799, E'ELECTROSAN  SRL', E'persona juridica', E'1021737022', E'JORGE SAN MIGUEL CACERES', NULL, E'423-0886/  423-0887-4119311-4119312', E'4589387', E'', NULL, E'Santa Cruz', 2, 3679, 4966);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (818, E'EXTERRAN BOLIVIA  S.R.L.', E'persona juridica', E'1028331027', E'RAUL ALVAREZ EGUEZ', NULL, E'33443636', E'', E'', NULL, E'Santa Cruz', 2, 3680, 4967);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (788, E'GLOBAL DEALER- RAQUEL VIRGINIA GUZMAN GUTIERREZ', E'persona juridica', E'378342015', E'RAQUEL VIRGINIA GUZMAN GUTIERREZ', NULL, E'4526940', E'72200774', E'', NULL, E'Santa Cruz', 2, 3681, 4968);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (807, E'HOSE INDUSTRIAL SERVICES LTDA', E'persona juridica', E'167002025', E'PEDRO MORENO AGUILAR', NULL, E'..', E'..', E'', NULL, E'Santa Cruz', 2, 3682, 4969);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (787, E'ITAQUERA LTDA', E'persona juridica', E'175848022', E'FABIO ALVES DOS SANTOS', NULL, E'33406633', E'33272606', E'', NULL, E'Santa Cruz', 2, 3683, 4970);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (829, E'TONKA S.R.L.', E'persona juridica', E'182652022', E'RIDER ANDRES CHAVEZ JUSTINIANO', NULL, E'3 3434655', E'3 3438584', E'', NULL, E'Santa Cruz', 2, 3691, 4982);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (828, E'KODIA- JORGE APAZA LOPEZ', E'persona juridica', E'6722998011', E'JORGE APAZA LOPEZ', NULL, E'3240602', E'3240602', E'', NULL, E'Santa Cruz', 2, 3717, 5004);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (860, E'SERVICIOS Y SUMINISTRO SERSUP- ZURITA  LUCUY RAUL', E'persona juridica', E'3260881015', E'ZURITA  LUCUY RAUL', NULL, E'3596871', E'3596871', E'', NULL, E'Santa Cruz', 2, 3718, 5005);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (19, E'COMERCIAL DE FILTROS MANN', E'persona juridica', E'1012817029', E'JULIO C. AGUIRRE - MIGUEL A. RIBERA', NULL, E'3333302', E'3332335', E'', NULL, E'Santa Cruz', 2, 3088, 4255);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (63, E'INSE ', E'persona juridica', E'', E'JORGE SOSA', NULL, E'336-0700', E'332-2260', E'', NULL, E'Santa Cruz', 2, 3140, 4256);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (830, E'PETROCOMPANY-MANUEL MORALES PEDRAZA', E'persona juridica', E'3903149013', E'MANUEL MORALES PEDRAZA', NULL, E'763-55388', E'77316678', E'', NULL, E'Santa Cruz', 2, 3692, 4983);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (831, E'TECNION  LTDA', E'persona juridica', E'1014253024', E'ELENA ELBIRT VDA DE KAVLIN', NULL, E'3537750', E'3537750', E'', NULL, E'Santa Cruz', 2, 3693, 4984);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (832, E'FORMAS Y TENDENCIAS FORTEN SRL', E'persona juridica', E'190138028', E'JUAN CARLOS PEDRAZA GURIBANA', NULL, E'345-3600', E'345-3600', E'', NULL, E'Santa Cruz', 2, 3694, 4985);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (833, E'ANTELO SERVICES IMPORT EXPORT', E'persona juridica', E'3175303011', E'CARLOS ALBERTO ANTELO JIMENEZ', NULL, E'3345750', E'', E'', NULL, E'Santa Cruz', 2, 3695, 4986);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (834, E'MUEBLES Y HERRAMIENTAS DE MADERA FATIMA LTDA', E'persona juridica', E'1011821022', E'JAIME POMMIER GOMEZ', NULL, E'333-3895', E'', E'', NULL, E'Santa Cruz', 2, 3696, 4987);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (835, E'ENGYSER-JOSE ANDRADE PEREDO', E'persona juridica', E'3923408014', E'JOSE ANDRADE PEREDO', NULL, E'3446287', E'3446287', E'', NULL, E'Santa Cruz', 2, 3697, 4988);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (836, E'ANTCORP S.R.L.', E'persona juridica', E'199658023', E'Jorge S. Antelo Justiniano', NULL, E'3242981', E'.', E'', NULL, E'Santa Cruz', 2, 3698, 4989);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (837, E'MULTILLANTAS ROBLES PEÑA S.R.L.', E'persona juridica', E'172374025', E'MAURO ROBLES MENDEZ', NULL, E'3474252', E'', E'', NULL, E'', NULL, 3699, 4990);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (838, E'ERWIN ECHAVARIA VELASCO', E'persona natural', E'6202626018', E'ERWIN ECHAVARIA VELASCO', NULL, E'3421191', E'', E'', NULL, E'', NULL, 3700, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (840, E'AGRO IMPACTO  IVAR GUERRA SALAZAR', E'persona juridica', E'90444633017', E'IVAR GUERRA SALAZAR', NULL, E'75656523', E'', E'', NULL, E'', NULL, 3701, 4991);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (854, E'ALMACEN ARANIBAR-VICTORIA DELGADO DE ARANIBAR CALLAHUANCA', E'persona juridica', E'1070693011', E'VICTORIA DELGADO DE ARANIBAR CALLAHUANCA', NULL, E'6461139', E'6461139', E'', NULL, E'Chuquisaca', 6, 3711, 5000);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (855, E'JULIA CHOQUE TITO', E'persona natural', E'1347398018', E'JULIA CHOQUE TITO', NULL, E'.', E'.', E'', NULL, E'Tarija', 7, 3712, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (856, E'CARMEN GLADYS LEDEZMA DE MUÑOZ', E'persona natural', E'2830202019', E'CARMEN GLADYS LEDEZMA DE MUÑOZ', NULL, E'.', E'.', E'', NULL, E'Tarija', 7, 3713, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (857, E'LIBRERIA - PAPELERIA GENESIS - MARIA LUZ UREÑA DURAN', E'persona juridica', E'3578339010', E'MARIA LUZ UREÑA DURAN', NULL, E'4501462', E'', E'', NULL, E'', NULL, 3714, 5001);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (858, E'TAPICERIA VALDEZ-BLAS EDIL VALDEZ HURTADO', E'persona juridica', E'2937850012', E'BLAS EDIL VALDEZ HURTADO', NULL, E'3195156', E'', E'', NULL, E'Santa Cruz', 2, 3715, 5002);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (859, E'MARELLI BOLIVIA SRL', E'persona juridica', E'1030991027', E'MARCO ANTONIO JUSTINIANO MOLINA', NULL, E'3598808', E'', E'', NULL, E'Santa Cruz', 2, 3716, 5003);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (846, E'CREDICENTER', E'persona juridica', E'4712984017', E'ESMERALDA CHAVEZ TIBY', NULL, E'852-3900', E'', E'', NULL, E'', NULL, 3719, 5006);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (20, E'COMSERTEC S.A.', E'persona juridica', E'1028193024', E'CARLOS JAVIER BALCAZAR ORTIZ', NULL, E'352-4430', E'352-4466', E'', NULL, E'Santa Cruz', 2, 3089, 4257);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (844, E'SETECPETROL SRL', E'persona juridica', E'191946023', NULL, NULL, E'4736290', E'', E'', NULL, E'Cochabamba', 3, NULL, 5007);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (843, E'IMPORMAQ', E'persona juridica', E'1986293012', NULL, NULL, E'3368496', E'', E'', NULL, E'', NULL, NULL, 5008);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (841, E'PROIRIX SRL', E'persona juridica', E'163874028', NULL, NULL, E'44584987', E'', E'', NULL, E'', NULL, NULL, 5009);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (839, E'SULDERY', E'persona juridica', E'3229862019', NULL, NULL, E'3650378', E'', E'', NULL, E'', NULL, NULL, 5010);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (861, E'LIBUS BOLIVIA S.R.L', E'persona juridica', E'161136028', E'ARTEAGA PEREZ CINTHIA', NULL, E'351-5267-351-8741', E'351-5267', E'', NULL, E'Santa Cruz', 2, 3720, 5011);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (863, E'Empresa De Servicios En Instrumentación Control y Analitica ICASERV GROUP S.R.L.', E'persona juridica', E'153124025', E'Miriam Zareth Parra Sejas', NULL, E'(591) 4 531790', E'', E'', NULL, E'Cochabamba', 3, 3721, 5012);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (882, E'LEONIDAS GARCIA', E'persona juridica', E'0', E'LEONIDAS GARCÍA RUIZ', NULL, E'46938224', E'', E'', NULL, E'Trinidad', 10, 3759, 5013);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (888, E'LUIS ALBERTO AGUILAR', E'persona natural', E'5113975011', E'LUIS ALBERTO AGUILAR QUISPE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3733, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (890, E'WILMA AGUILERA', E'persona natural', E'3651212013', E'WILMA AGUILERA CERVANTES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3734, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (892, E'JORGE HUAYLLA', E'persona natural', E'1052680013', E'', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3736, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (893, E'GREGORIO MURILLO', E'persona natural', E'3305883013', E'GREGORIO YOHNNY MURILLO ALMENDRAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3737, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (894, E'LUIS ALBERTO RIVERA', E'persona natural', E'5647807016', E'LUIS ALBERTO RIVERA DELGADO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3738, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (896, E'ANGEL FERNANDEZ', E'persona natural', E'1107104017', E'ANGEL FERNÁNDEZ VARGAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3739, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (903, E'HUMBERTO MARTINEZ', E'persona natural', E'399701019', E'HUMBERTO MARTINEZ VELIZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3740, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (904, E'JUAN LINARES', E'persona natural', E'4319120015', E'JUAN FELIPE LINARES CALISAYA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3741, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (907, E'JORGE VASQUEZ', E'persona natural', E'655291018', E'JORGE VASQUEZ FLORES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3742, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (909, E'MAGALY LOPEZ', E'persona natural', E'2574239013', E'MAGALY LÓPEZ VARGAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3743, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (911, E'GROVER CHOQUE', E'persona natural', E'3727652010', E'GROVER ALEX CHOQUE AGUILERA', NULL, E'4338353', E'', E'', NULL, E'Trinidad', 10, 3744, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (912, E'MARIO MONTES', E'persona natural', E'2616674012', E'MARIO ARTURO MONTES FERNANDEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3745, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (900, E'CARELLI CATERING Y EVENTOS', E'persona juridica', E'4138961018', E'CARMEN SISSEL LINDEF', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3746, 5015);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (872, E'CATERING MANA', E'persona juridica', E'1856061019', E'PETHY BORDA VALDEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3747, 5016);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (868, E'CATERIN SANTOS D', E'persona juridica', E'3855395017', E'JUAN MARTI FLORES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3748, 5017);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (881, E'CELTA MOTORES', E'persona juridica', E'1939259010', E'JORGE MARTINEZ CASTRO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3749, 5018);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (889, E'CIUDAD BLANCA', E'persona juridica', E'1278077016', E'LURDES MOREIRA DE PAREDES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3750, 5019);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (895, E'DOMINGA KECAÑO', E'persona juridica', E'3652997014', E'DOMINGA KECAÑO SALAZAR', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3751, 5020);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (879, E'EMPRESA FLN', E'persona juridica', E'993880012', E'FELIX LAMAS NOGALES', NULL, E'4218345', E'', E'', NULL, E'Trinidad', 10, 3752, 5021);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (866, E'ESTACION DE SERVICIO CORDILLERA LA WILLAMS', E'persona juridica', E'1975265012', E'ELVIRA MENDOZA DURAN', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3753, 5022);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (878, E'ESTACION DE SERVICIO CRISTO REDENTOR', E'persona juridica', E'1305318018', E'ROSARIO DEL CARPIO', NULL, E'2851097', E'', E'', NULL, E'Trinidad', 10, 3754, 5023);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (886, E'ESTACION DE SERVICIO POTOSI', E'persona juridica', E'1667558018', E'SIXTO MAMANI MAGNE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3755, 5024);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (910, E'ESTACION DE SERVICIO TICTI', E'persona juridica', E'804793016', E'LUCIO VIDAL GARCIA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3756, 5025);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (867, E'GRUPO AUXILIAR SEGURIDAD GAS', E'persona juridica', E'1146527011', E'JHONNY VARGAS RIVAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3757, 5026);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (24, E'DAHER IMPORTACIONES  EXPORTACIONES Y REPRESENTACIONES', E'persona juridica', E'1574277011', E'MARIA JUDITH NAZRALA DE DAHER', NULL, E'334-5830    333-8184', E'334-1424', E'', NULL, E'Santa Cruz', 2, 3090, 4258);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (25, E'DICO SYS', E'persona juridica', E'1103075019', E'RENE PINTO MEDRANO', NULL, E'337-2760', E'337-2760', E'', NULL, E'Santa Cruz', 2, 3091, 4259);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (906, E'LAS RETAMAS', E'persona juridica', E'583776010', E'MARTHA GLADIS VIDAL ZAPATA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3758, 5027);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (915, E'FERNANDO TIBI', E'persona natural', E'1917447013', E'FERNANDO TIBI ROCA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3771, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (916, E'ANANIAS CAMPOS', E'persona natural', E'1966329011', E'ANANIAS CAMPOS DE VILLARROEL', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3772, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (922, E'JORGE ANTONIO REYES', E'persona natural', E'141403115', E'JORGE ANTONIO REYES ANDRADE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3773, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (925, E'MARIEL QUIROZ', E'persona natural', E'3234752013', E'MARIEL CARMEN LETICIA QUIROZ RIVERA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3774, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (930, E'MARIA DEL ROSARIO QUINTANILLA', E'persona natural', E'3657539013', E'MARIA DEL ROSARIO QUINTANILLA ZURITA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3775, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (931, E'VIRGINIA APAZA RAMIREZ', E'persona natural', E'5844358016', E'VIRGINIA APAZA RAMIREZ DE COLQUE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3776, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (933, E'ALEXANDER CUELLAR', E'persona natural', E'6207284015', E'ALEXANDER CUELLAR', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3777, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (940, E'JUAN CARLOS ARONI', E'persona natural', E'1391648018', E'JUAN CARLOS ARONI MAMANI', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3778, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (944, E'VANIA PAMELA ESTRADA VASQUEZ', E'persona natural', E'3802469', E'VANIA PAMELA ESTRADA VASQUEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3779, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (951, E'ZENON MARTINEZ VELASCO', E'persona natural', E'2407476', E'ZENON MARTINEZ VELASCO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3780, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (952, E'MIGUEL ANGEL ROCA LECARO', E'persona natural', E'1738493016', E'MIGUEL ANGEL ROCA LECARO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3781, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (954, E'BENITO BENEDICTO PAIRUMANI CASSAS', E'persona natural', E'2017194018', E'BENITO BENEDICTO PAIRUMANI', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3782, NULL);


/* Data for the 'gem.prov_aux' table  (Records 501 - 1000) */

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (955, E'WILBER CHOQUE CASTRO', E'persona natural', E'4086577016', E'WILBER CHOQUE CASTRO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3783, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (919, E'BIOPETROL', E'persona juridica', E'10208207024', E'SONIA MARLENE SUAREZ ALCOBA', NULL, E'3527899', E'', E'', NULL, E'Trinidad', 10, 3784, 5037);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (953, E'CAIGUAMI', E'persona juridica', E'1028943011', E'JAVIER FRANCISCO IRADY ROMERO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3785, 5038);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (943, E'CATERING & EVENTOS \\\" CARTA BLANCA\\\"', E'persona juridica', E'3572207014', E'VICTOR HUGO OLIVARES ANDRADE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3786, 5039);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (934, E'COGNOS SOLUCIONES Y SERVICIOS', E'persona juridica', E'1014381027', E'MARCO ANTONIO ERLWEIN', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3787, 5040);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (917, E'DATALAN', E'persona juridica', E'2551631010', E'SANTOS RAUL CHIPANA VARGAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3788, 5041);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (949, E'EVENTOS REYNALDO', E'persona juridica', E'2379165015', E'DAVID REYNADO HERRERA FERNANDEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3789, 5042);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (950, E'EL EMPEDRADILLO-PUB RESTAURANTE', E'persona juridica', E'5100344017', E'MARTÍN BRUNO ARCE MENDEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3790, 5043);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (936, E'INDENV', E'persona juridica', E'3832563017', E'CHARLES BISMARK VARGAS MONTAÑO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3791, 5044);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3037, E'RESTAURANT ACATRAZ', E'persona juridica', E'5060836019', E'PAOLA GABRIELA CASTELLÓN GARCIA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3801, 5055);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (923, E'SECONAL, SERVICIO DE COMIDA NACIONAL', E'persona juridica', E'2687968013', E'OSCAR HENRRY CHOQUE AGUILAR', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3802, 5056);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (939, E'SERCAT S.R.L.', E'persona juridica', E'136139028', E'MARIOLY COLQUE EGUEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3803, 5057);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (926, E'SERVICIOS GENERALES SOIGOCA', E'persona juridica', E'4594543016', E'SONIA ELIZABETH ITURRY BALCAZAR', NULL, E'39523031', E'', E'', NULL, E'Trinidad', 10, 3804, 5058);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (30, E'ELECTRIC MUNDIAL S.R.L.', E'persona juridica', E'1026977023', E'JORGE URCULLO MIRANDA', NULL, E'333-2833', E'332-9091', E'', NULL, E'', NULL, 3092, 4260);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (31, E'ELECTROGIS', E'persona juridica', E'1028713025', E'BOLIVIA', NULL, E'336-5599', E'334-9949', E'', NULL, E'Santa Cruz', 2, 3092, 4261);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (32, E'ELECTROHOGAR', E'persona juridica', E'1028769023', E'TERESA PARADA DE PAZ', NULL, E'336-5500', E'3378641', E'', NULL, E'Santa Cruz', 2, 3093, 4262);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (33, E'EQUIBOL', E'persona juridica', E'1001227020', E'GONZALO PATIÑO', NULL, E'2442758 - 2128722', E'013-22442874', E'', NULL, E'Santa Cruz', 2, 3094, 4263);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (37, E'FARMACIA TELCHI', E'persona juridica', E'1015307021', E'BEATRIZ TELCHI', NULL, E'336-5555', E'333-9719', E'', NULL, E'Santa Cruz', 2, 3095, 4264);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (38, E'FERRETERIA UNIVERSAL LTDA', E'persona juridica', E'1028263020', E'FANOR QUEVEDO VILLAGOMEZ', NULL, E'346-5445', E'346-9169', E'', NULL, E'Santa Cruz', 2, 3096, 4265);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (39, E'FERROBLACK', E'persona juridica', E'2720642014', E'CARLOS BLACUT', NULL, E'3367210', E'3336441', E'', NULL, E'Santa Cruz', 2, 3097, 4266);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (41, E'FERROTODO', E'persona juridica', E'1028373024', E'FREDDY OSINAGA', NULL, E'371-1000', E'342-7586', E'', NULL, E'Santa Cruz', 2, 3098, 4267);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (43, E'FINI LAGER  S.A.', E'persona juridica', E'1028629027', E'RODOLFO RIBERA ALCANTARA', NULL, E'3534488', E'3544101', E'', NULL, E'Santa Cruz', 2, 3099, 4268);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (945, E'SERVICIOS VEMA', E'persona juridica', E'5758417013', E'VIANNEY EUGENIA MONTOYA ARAMAYO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3805, 5059);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (941, E'TALLER MICHAEL', E'persona juridica', E'3297363017', E'MICHAEL DÁVALOS LOPEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3806, 29);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (929, E'THAIMI', E'persona juridica', E'7625008013', E'DEVORA QUETEGUARI SANJINEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3807, 5060);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (937, E'THOMPSON COMUNICACIONES SRL', E'persona juridica', E'1028597025', E'JUAN CARLOS THOMPSON OTERO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3808, 5061);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (921, E'UNIDAD DE SEGURIDAD FISICA EL ALTO', E'persona juridica', E'121989025', E'JUAN OSCAR TORRICO AMELLER', NULL, E'2817060', E'2817161', E'', NULL, E'Trinidad', 10, 3809, 5062);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3038, E'GETRUDES VIRGINIAN REVOLLO CLAROS', E'persona natural', E'6475224014', E'GETRUDES VIRGINIA REVOLLO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3810, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3058, E'CARLOS JIMÉNEZ MOYA', E'persona natural', E'7872024', E'CARLOS JIMÉNES MOYA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3811, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3065, E'CLOTILDE VILLEGAS AGUIRRE', E'persona natural', E'3684597014', E'CLOTILDE VILLEGAS AGUIRRE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3812, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (959, E'MARGARITA ROSA ORGANIVIA LANCHI DE ZABALA', E'persona natural', E'977953012', E'MARGARITA ROSA ORGANIVIA LANCHI DE ZABALA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3813, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (44, E'FULL OFFICE', E'persona juridica', E'', E'CINDY ORSI', NULL, E'337-6640', E'337-6648', E'', NULL, E'Santa Cruz', 2, 3100, 4269);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (49, E'HANSA', E'persona juridica', E'1020343027', E'MARCO VIDAL', NULL, E'342-4000', E'342-3233', E'', NULL, E'Santa Cruz', 2, 3101, 12);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1007, E'HUMBERTO ARRIATA', E'persona natural', E'', E'HUMBERTO ARRIATA LEON', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3102, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (7, E'BAGUA CONSTRUCCIONES', E'persona juridica', E'', E'VICTOR HUGO KRAYASICH', NULL, E'3372132 - 3372132 DOM', E'3372132', E'', NULL, E'Santa Cruz', 2, 3103, 4270);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (10, E'BEST OFFICE PENCIL S.R.L.', E'persona juridica', E'1014331020', E'', NULL, E'339-0584', E'311-3101', E'', NULL, E'Santa Cruz', 2, NULL, 4271);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (11, E'BISA', E'persona juridica', E'', E'MARCELO QUINTANA', NULL, E'365050', E'331819', E'', NULL, E'Santa Cruz', 2, 3104, 4272);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (18, E'COGNOS', E'persona juridica', E'', E'', NULL, E'333-3212', E'333-3212', E'', NULL, E'Santa Cruz', 2, NULL, 4273);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (21, E'CONSTRUCCIONES PETETE (GUIDO BRAVO)', E'persona juridica', E'', E'RODRIGO MOSCOSO', NULL, E'354-2400', E'354-2400', E'', NULL, E'Santa Cruz', 2, 3105, 4274);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (22, E'COPENAC', E'persona juridica', E'', E'JORGE CALBIMONTE', NULL, E'3335858', E'535631', E'', NULL, E'Santa Cruz', 2, 3106, 4275);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (26, E'DISMAC', E'persona juridica', E'', E'FERNANDO PAYO', NULL, E'347-3030', E'347-3031', E'', NULL, E'Santa Cruz', 2, 3107, 4276);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (27, E'DMC', E'persona juridica', E'', E'JOSE BARRANCOS', NULL, E'543000', E'543637', E'', NULL, E'Santa Cruz', 2, 3108, 4277);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (14, E'E.C.A.S.', E'persona juridica', E'', E'PABLO CAPESTAGNY', NULL, E'337-5460', E'337-5460', E'', NULL, E'Santa Cruz', 2, 3109, 4278);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (29, E'EL PORVENIR', E'persona juridica', E'', E'', NULL, E'336-3000', E'332-2289', E'', NULL, E'Santa Cruz', 2, NULL, 4279);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (34, E'ERGOVIAL', E'persona juridica', E'', E'JULIO AÑES', NULL, E'344-3349', E'342-6841', E'', NULL, E'Santa Cruz', 2, 3110, 4280);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (35, E'ESIER', E'persona juridica', E'', E'LUIS ENRIQUE MONTAÑO', NULL, E'3-467474', E'3-467474', E'', NULL, E'Santa Cruz', 2, 3111, 4281);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (36, E'EUROCAR', E'persona juridica', E'', E'', NULL, E'3425856', E'3425856', E'', NULL, E'Santa Cruz', 2, NULL, 4282);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (40, E'FERROSUR', E'persona juridica', E'', E'ERICK GAITY', NULL, E'3224821', E'', E'', NULL, E'Santa Cruz', 2, 3112, 4283);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (42, E'FIL PARTS', E'persona juridica', E'1027661026', E'', NULL, E'361080', E'333976', E'', NULL, E'Santa Cruz', 2, NULL, 4284);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (47, E'GONELLA E HIJO', E'persona juridica', E'', E'ENRIQUE AYUP', NULL, E'421256', E'426928', E'', NULL, E'Santa Cruz', 2, 3113, 4285);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (48, E'HANOVER BOLIVIA', E'persona juridica', E'', E'ALFREDO COSTA', NULL, E'580985', E'580981', E'', NULL, E'Santa Cruz', 2, 3114, 4286);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (45, E'NEXTEL BOLIVIA S.R.L . (GALLYAS)', E'persona juridica', E'127623020', E'SERGIO LUIS PRIETO NUÑEZ', NULL, E'337-1444', E'337-1444', E'', NULL, E'Santa Cruz', 2, 3115, 4287);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (961, E'MARCO ANTONIO FERNANDEZ VILLA', E'persona natural', E'4141238017', E'MARCO ANTONIO FERNANDEZ VILLA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3814, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (962, E'HUMBERTO DANIEL SANJINEZ CRESPO', E'persona natural', E'376553018', E'HUMBERTO DANIEL SANJENÉZ CRESPO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3815, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (963, E'FREDDY IVAN SALAZAR REYES', E'persona natural', E'1112344019', E'FREDDY IVÁN SALAZAR REYES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3816, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (964, E'WILLIAM SANIZO CHALLHUA', E'persona natural', E'5277950011', E'WILLIAM SANIZO CHALLHUA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3817, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (28, E'PETROBRAS', E'persona juridica', E'', E'DORIAN PEREYRA', NULL, E'366-7226', E'366-7160', E'', NULL, E'Santa Cruz', 2, 3116, 4288);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (65, E'INTERGAS', E'persona juridica', E'', E'', NULL, E'3532000', E'3528870', E'', NULL, E'Santa Cruz', 2, NULL, 4289);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (966, E'JOSE LUCIO FLORES ORTIZ', E'persona natural', E'3658000010', E'JOSE LUCIO FLORES ORTIZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3818, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (967, E'HERMOGENES AYMA QUISPE', E'persona natural', E'5532117', E'HERMOGENES AYMA QUISPE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3819, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (957, E'RESTAURANT Y CATERING DON MIGUEL D&M', E'persona juridica', E'3793451017', E'WILMER ERICK NOGALES BLACUT', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3832, 5071);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (974, E'YPFB', E'persona juridica', E'1020269020', E'CARLOS VILLEGAS QUIROGA', NULL, E'2356540', E'2356540', E'', NULL, E'Trinidad', 10, 3834, 5072);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (979, E'PETHY BORDA VALDEZ', E'persona natural', E'1856061', E'PETHY BORDA VALDEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3747, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (980, E'DANIA CANDELARIA DAZA DOMÍNGUEZ', E'persona natural', E'4116714010', E'DANIA CANDELARIA DAZA DOMÍNGUEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3835, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (981, E'VICTOR ILLANES ROCHA', E'persona natural', E'6229046019', E'VICTOR ILLANES ROCA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3836, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (982, E'MONICA PAULA MONTERO ROCABADO', E'persona natural', E'4189377017', E'MONICA PAULA MONTERO ROCABADO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3837, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3095, E'CARLOS ALBERTO PAZ WEIDLING', E'persona natural', E'', E'CARLOS ALBERTO PAZ WEIDLING', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3838, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (989, E'MARIA LUISA SOLANO FONCECA', E'persona natural', E'4042984019', E'MARIA LUISA SOLANO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3841, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (990, E'ROOSVELT CUBA PAREDES', E'persona natural', E'4508344', E'ROOSVELT CUBA PAREDES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3842, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (993, E'JAVIER ACEBEY ROMERO', E'persona natural', E'4161924012', E'JAVIER ACEBEY ROMERO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3843, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (994, E'JORGE LUIS HURTADO', E'persona natural', E'7843792016', E'JORGE LUIS HURTADO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3844, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3051, E'YERSOM GOREM NINA ENDARA', E'persona natural', E'6180507010', E'YERSOM GOREM NINA ENDARA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3833, 4168);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1021, E'JORGE CABRERA SENZANO', E'persona natural', E'', E'JORGE CABRERA SENZANO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3858, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1022, E'PORFIDIO VELASQUEZ', E'persona natural', E'', E'PORFIDIO VELÁSQUEZ VARGAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3859, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1026, E'AYDEN ARTEAGA PADILLA', E'persona natural', E'', E'AYDEN ARTEAGA PADILLA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3860, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1027, E'RUBEN ERNESTO VILLAZON AÑEZ', E'persona natural', E'', E'RUBÉN ERNESTO VILLAZÓN AÑEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3861, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1029, E'MARTIN AYMA ARRATIA', E'persona natural', E'', E'MARTIN AYMA ARRATIA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3862, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1030, E'DMD S.R.L.', E'persona juridica', E'156812026', E'DOMINGO MONTENEGRO DELGADILLO', NULL, E'3561624', E'3561624', E'', NULL, E'Santa Cruz', 2, 3839, 5079);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1031, E'INGENIERIA Y SERVICIOS TECNICOS IST. LTDA.', E'persona juridica', E'1023209024', E'CARLOS VICTOR PEREZ QUISPE', NULL, E'44260891', E'44261141', E'', NULL, E'Cochabamba', NULL, 3840, 5080);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1033, E'VOLCAN S.A.', E'persona juridica', E'1020467020', E'CHRISTIAN ALEJANDRO CLAURE VARGAS', NULL, E'77796900 - 22306304', E'22306312', E'', NULL, E'Santa Cruz', 2, 3864, 5082);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1034, E'SUDAMERICANA SRL CORREDORES Y ASES SEG.', E'persona juridica', E'1018797029', E'JUAN EDUARDO OLIVO GAMARRA', NULL, E'800103070', E'', E'', NULL, E'La Paz', 4, 3865, 5083);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (723, E'3M BOLIVIA', E'persona juridica', E'', E'GONZALO ARANO ALCAZAR', NULL, E'34112195', E'3412196', E'', NULL, E'Santa Cruz', 2, 3867, 5084);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (775, E'ABB BOLIVIA', E'persona juridica', E'', E'JOSE CASTELLON', NULL, E'341-9600', E'311-9272', E'', NULL, E'Santa Cruz', 2, 3868, 5085);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (800, E'ASOCIADOS BOLPER AUTOMARIZACION SRL', E'persona juridica', E'178976028', E'ADRIANA JALDIN MOYA', NULL, E'356-2880', E'72154284', E'', NULL, E'Santa Cruz', 2, 3880, 5100);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (740, E'ATCORP-KING AMERICAN TRADING CORPORATION -KING', E'persona juridica', E'', E'TANG LI', NULL, E'3422000', E'3422000', E'', NULL, E'Santa Cruz', 2, 3881, 5101);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (5, E'ATLANTIDA', E'persona juridica', E'1500566016', E'PETRONILDA SALAZAR', NULL, E'336-6387', E'3334257', E'', NULL, E'Santa Cruz', 2, 3882, 5102);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (948, E'BAR RESTAURANT CHERROÁS', E'persona juridica', E'494300016', E'ANA MARIA MOSCOSO ALFARO DE CRUZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3883, 5103);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1023, E'HOTEL JR HOTEL', E'persona juridica', E'', E'JOSÉ BEJARANO CHÁVEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3884, 5104);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (23, E'CORRETEN', E'persona juridica', E'1025265028', NULL, NULL, E'3339430', E'3360627', E'', NULL, E'Santa Cruz', 2, NULL, 4290);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (50, E'HERGO LTDA', E'persona juridica', E'1000991026', NULL, NULL, E'228-5854', E'212-6286', E'', NULL, E'Santa Cruz', 2, NULL, 4291);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1, E'AGSA S.A.', E'persona juridica', E'', E'ORLANDO SMITH', NULL, E'332-2021', E'332-2021', E'', NULL, E'Santa Cruz', 2, 3117, 4292);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (51, E'HERRACRUZ S.A.', E'persona juridica', E'157724021', E'CARLOS SILES CESPEDEZ', NULL, E'354-1073', E'354-1397', E'', NULL, E'Santa Cruz', 2, 3118, 4293);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (66, E'ISEGAS LTDA', E'persona juridica', E'', E'AMADO VALDIV.', NULL, E'3420257', E'3435244', E'', NULL, E'Santa Cruz', 2, 3141, 4294);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1024, E'HOTEL TURUBO', E'persona juridica', E'', E'CARLOS DORIA MEDINA BALBIAN', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3885, 5105);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1009, E'INVERSIONES JANA S. A.', E'persona juridica', E'', E'PABLO MARCEL MELGAREJO NAVA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3886, 5106);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1016, E'RANSABOL', E'persona juridica', E'', E'JOHN EDWARD LEIGH DEL CAMPO', NULL, E'3442657', E'3442657', E'', NULL, E'Trinidad', 10, 3887, 5107);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1018, E'SGS BOLIVIA S.A. \\\"SOCIEDAD GENERAL DE SUPERINTENDENCIA\\\"', E'persona juridica', E'', E'VILMA FILOMENA HURTADO DE RICALDEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3888, 5108);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1019, E'SOLUTEL', E'persona juridica', E'', E'GENARO ROBERTO LUIS QUINTANILLA CATALANO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3889, 5109);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1020, E'YPFB (Tarija)', E'persona juridica', E'', E'CARLOS VILLEGAS QUIROGA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3834, 5110);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (562, E'EMPRESA DE FUMIGACION MATADOR', E'persona juridica', E'1584192014', E'JULIO FERNANDO LANDIVAR BOWLES', NULL, E'3430342', E'3430342', E'', NULL, E'Santa Cruz', 2, 3899, 5121);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (235, E'FERRETERIA CAROLINA', E'persona juridica', E'1823498017', E'MARIBEL ALVIS ARANCIBIA', NULL, E'672-2223', E'672-2223', E'', NULL, E'Santa Cruz', 2, 3900, 5122);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (633, E'GAIA SYSTEMS LTDA.', E'persona juridica', E'1026511023', E'WILMA WINKELER VELARDE', NULL, E'3442-6526', E'3-432364', E'', NULL, E'Santa Cruz', 2, 3901, 5123);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (46, E'GENERAL OIL SERVICE SRL', E'persona juridica', E'126533029', E'ALEJANDRO RON', NULL, E'351-6120', E'351-6120 CEL. 710-45127', E'', NULL, E'Santa Cruz', 2, 3902, 5124);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (528, E'GLOBAL HIDROCARBUROS BOLIVIANOS S.A.', E'persona juridica', E'152682020', E'ENRIQUE ALEJANDRO GUTIERREZ', NULL, E'3416767', E'3417541', E'', NULL, E'Santa Cruz', 2, 3903, 5125);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (53, E'GOMA CRUZ SRL', E'persona juridica', E'1985926014', E'', NULL, E'3426375', E'3441391', E'', NULL, E'Santa Cruz', 2, NULL, 5126);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (149, E'HI - FLO SERVICIOS DE PRECISIÓN BOLIVIA S.R.L.', E'persona juridica', E'', E'RAMIRO HUARACHI', NULL, E'3551200', E'3551200', E'', NULL, E'Santa Cruz', 2, 3223, 5127);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (52, E'HORIZONTE BOLIVIANO S. R. L.', E'persona juridica', E'120679024', E'JUAN CARLOS RODRIGUEZ CH.', NULL, E'3599533 - 3599534', E'3593540', E'', NULL, E'Santa Cruz', 2, 3904, 5128);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (349, E'IMPORTADORA DUCRYL', E'persona juridica', E'3022383016', E'', NULL, E'4221282', E'4118794', E'', NULL, E'Santa Cruz', 2, NULL, 5129);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (820, E'IMPORTADORA SOCME- JORGE A. VARGAS LASERNA', E'persona juridica', E'5219305013', E'JORGE ALVARO VARGAS LASERNA', NULL, E'3297249', E'3602464', E'', NULL, E'Santa Cruz', 2, 3905, 5130);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (481, E'IMPORTADORA SUDAMERICANA LTDA', E'persona juridica', E'134517021', E'', NULL, E'4599200', E'4252495', E'', NULL, E'Santa Cruz', 2, NULL, 5131);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (62, E'INCA S.R.L.', E'persona juridica', E'1028765028', E'GASTON ARRIETA CORNEJO', NULL, E'351-5151 / 351-5658', E'3515660', E'', NULL, E'Santa Cruz', 2, 3119, 4295);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (64, E'INSERTEC LTDA.', E'persona juridica', E'1028635027', E'GONZALO JESUS MALDONADO OTTERBURG', NULL, E'347-2121', E'346-1755', E'', NULL, E'Santa Cruz', 2, 3120, 4296);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (68, E'JORVI REPRESENTACIONES SRL', E'persona juridica', E'1015391025', E'FELIX ANDRADE ARRAYA', NULL, E'345-9266', E'312-1082', E'', NULL, E'Santa Cruz', 2, 3121, 4297);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (70, E'LA CUISINE', E'persona juridica', E'1028583022', E'GONSALO VARGAS DELOS', NULL, E'348247', E'348247', E'', NULL, E'Santa Cruz', 2, 3122, 4298);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (71, E'LAVAYEN MOTORS', E'persona juridica', E'1591300016', E'JAIME LAVAYEN', NULL, E'352-4251', E'352-4241', E'', NULL, E'Santa Cruz', 2, 3123, 4299);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (74, E'MATIALPLAST LTDA', E'persona juridica', E'120943029', E'GLORIA PASCUAL NELDA', NULL, E'3367453', E'', E'', NULL, E'Santa Cruz', 2, 3124, 4300);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (76, E'MCA- REPRESENTACIONES', E'persona juridica', E'1028137023', E'BEATRIZ CRISTINA MONTERO DE COGNIGNI', NULL, E'3552366', E'3552366', E'', NULL, E'Santa Cruz', 2, 3125, 4301);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (77, E'MERCANTIL LEON', E'persona juridica', E'143953021', E'JOSE CARLOS ESTATUTI', NULL, E'3364244', E'3368672', E'', NULL, E'Santa Cruz', 2, 3126, 4302);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (58, E'IMPRENTA SIRENA', E'persona juridica', E'', NULL, NULL, E'3366030', E'334-7774', E'', NULL, E'Santa Cruz', 2, NULL, 4312);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (67, E'JIMENEZ SRL', E'persona juridica', E'', E'EDUARDO VALDIVIA', NULL, E'355-9131', E'336-4030', E'', NULL, E'Santa Cruz', 2, 3142, 4316);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (69, E'KORIGOMA', E'persona juridica', E'', E'MELBA ROXANA RANZA', NULL, E'3460691', E'', E'', NULL, E'Santa Cruz', 2, 3143, 4317);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (72, E'LAS LOMAS', E'persona juridica', E'', E'', NULL, E'3426905', E'3425776', E'', NULL, E'Santa Cruz', 2, NULL, 4318);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (73, E'LUMITEC', E'persona juridica', E'', E'', NULL, E'3362300', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4319);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (75, E'MATREQ', E'persona juridica', E'', E'MARIO BERGHUSEN', NULL, E'429688', E'429445', E'', NULL, E'Santa Cruz', 2, 3144, 4320);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (78, E'METALES DAR SRL.', E'persona juridica', E'', E'', NULL, E'344-9426', E'342-5381', E'', NULL, E'Santa Cruz', 2, NULL, 4321);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (80, E'MITSUBA', E'persona juridica', E'', E'MARCELA AÑEZ', NULL, E'3345177', E'3367379', E'', NULL, E'Santa Cruz', 2, 3145, 4322);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (81, E'MULTIPETROL', E'persona juridica', E'', E'ARMANDO LOPEZ', NULL, E'3372113', E'', E'', NULL, E'Santa Cruz', 2, 3146, 4323);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (56, E'IMPORTADORA MONTERREY', E'persona juridica', E'', E'JONNY DEL CASTILLO', NULL, E'347-1960 INT 109', E'3471028', E'', NULL, E'Santa Cruz', 2, 3147, 4324);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (84, E'OVANDO', E'persona juridica', E'', E'', NULL, E'336-3100', E'332-5212', E'', NULL, E'Santa Cruz', 2, NULL, 4325);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (54, E'INGENIUM SRL', E'persona juridica', E'1028475029', NULL, NULL, E'3452424', E'3452424', E'', NULL, E'Santa Cruz', 2, NULL, 4326);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (86, E'PERSIALUMINIO', E'persona juridica', E'', E'FANNY MENDOZA', NULL, E'346-5259', E'346-1359', E'', NULL, E'Santa Cruz', 2, 3148, 4327);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (87, E'PETRO SUPPLY', E'persona juridica', E'', E'JUAN MONTES', NULL, E'428114', E'420709', E'', NULL, E'Santa Cruz', 2, 3149, 4328);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (90, E'PLASTICOS ART', E'persona juridica', E'', E'EUFRONIO CUBA', NULL, E'3462416', E'', E'', NULL, E'Santa Cruz', 2, 3150, 4329);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (95, E'PROSERVICIOS', E'persona juridica', E'', E'HANS VOSS', NULL, E'335-4003', E'332-8796', E'', NULL, E'Santa Cruz', 2, 3151, 4330);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (96, E'RADIUS COM', E'persona juridica', E'', E'JUAN CARLOS CLADERA', NULL, E'334-9014', E'334-9087', E'', NULL, E'Santa Cruz', 2, 3152, 4331);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (126, E'XEROBOL S.A.', E'persona juridica', E'1020205028', E'JAVIER TABORGA IBARGUEN', NULL, E'332-9001', E'335-0273', E'', NULL, E'Santa Cruz', 2, 3164, 4346);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (128, E'MARGOTH  DE ROMERO', E'persona natural', E'', E'MARGOTH  DE ROMERO', NULL, E'3580047', E'', E'', NULL, E'Santa Cruz', 2, 3165, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (130, E'COMERCIAL ADAMA', E'persona juridica', E'933005019', E'ESTHER REVOLLO', NULL, E'4228510', E'4250450', E'', NULL, E'Santa Cruz', 2, 3166, 4347);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (134, E'LA JUVENTUD LTDA', E'persona juridica', E'1023235020', E'ERNESTO RODRIGUEZ CAMACHO', NULL, E'3341166', E'3329730', E'', NULL, E'Santa Cruz', 2, 3167, 4348);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (137, E'MULTIPARTES SANTA CRUZ SRL', E'persona juridica', E'120143028', E'FABIOLA', NULL, E'3424101', E'3424142', E'', NULL, E'Santa Cruz', 2, 3167, 4349);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (139, E'WESTERN', E'persona juridica', E'', E'JOSÉ ZAMORA', NULL, E'344-7505', E'344-7674', E'', NULL, E'Santa Cruz', 2, 3168, 4350);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (141, E'SKILL S.R.L', E'persona juridica', E'1025845026', E'JANETH PADILLA DE WAISS', NULL, E'332-7002', E'334-2588', E'', NULL, E'Santa Cruz', 2, 3169, 4351);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (150, E'PRIMEX LTDA', E'persona juridica', E'', E'NOBUAKI ROLANDO WATANABE', NULL, E'333-5068', E'332-8639', E'', NULL, E'Santa Cruz', 2, 3170, 4352);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (152, E'MULTICENTER', E'persona juridica', E'1028341029', E'RONALD REA MERCADO', NULL, E'343-1700', E'342-2600', E'', NULL, E'Santa Cruz', 2, 3171, 4353);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (136, E'CIA DE PLASTICOS ART LTDA', E'persona juridica', E'', E'', NULL, E'3462416', E'3468285', E'', NULL, E'Santa Cruz', 2, NULL, 4355);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (142, E'SUMINISTROS INDUSTRIALES PETROLEROS', E'persona juridica', E'4575728018', E'SARAH ANIVARRO GUZMAN', NULL, E'333-4129', E'333-4129', E'', NULL, E'Santa Cruz', 2, 3184, 4375);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (114, E'TECNOMAT', E'persona juridica', E'', E'JOSE GARCIA', NULL, E'337-8329', E'337-8329', E'', NULL, E'Santa Cruz', 2, 3185, 4376);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (117, E'THE BEST OFFICE', E'persona juridica', E'', E'AMADEO ROI', NULL, E'3341085', E'', E'', NULL, E'Santa Cruz', 2, 3186, 4377);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (112, E'TECNIMEX', E'persona juridica', E'', NULL, NULL, E'357-8624', E'357-8624', E'', NULL, E'Santa Cruz', 2, NULL, 4378);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (120, E'TOYOSA', E'persona juridica', E'', E'EDWIN ROCABADO', NULL, E'3425227', E'3432773', E'', NULL, E'Santa Cruz', 2, 3187, 4379);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (121, E'TRACTOR FIAT SRL.', E'persona juridica', E'', E'', NULL, E'3420959', E'342-4278', E'', NULL, E'Santa Cruz', 2, NULL, 4380);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (123, E'TUBOS DEL CARIBE S.A.', E'persona juridica', E'', E'YAMILE NUR', NULL, E'(571) 226-1247', E'(571) 226-1248', E'', NULL, E'Santa Cruz', 2, 3188, 4381);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (129, E'URRUTIBEHETY', E'persona juridica', E'', E'ALICIA VELAZCO', NULL, E'3546868', E'', E'', NULL, E'Santa Cruz', 2, 3189, 4382);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (125, E'VESTON SPORT', E'persona juridica', E'', E'HERMAN ROMÁN', NULL, E'342-8753', E'342-8753', E'', NULL, E'Santa Cruz', 2, 3190, 4383);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (138, E'SPARTAN BOLIVIA', E'persona juridica', E'1028431028', E'ANTONIO QUERO F.', NULL, E'352-9809', E'352-9809', E'', NULL, E'Santa Cruz', 2, 3191, 4384);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (119, E'TOTAL SERVICES', E'persona juridica', E'1014815022', E'EDGARD LAU', NULL, E'3459000', E'344-9344 INT 123', E'', NULL, E'Santa Cruz', 2, 3192, 4385);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (127, E'PETROLEO & GAS SRL', E'persona juridica', E'', E'JUAN CARLOS DE AVILA', NULL, E'3535722', E'3572388', E'', NULL, E'Santa Cruz', 2, 3193, 4386);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (195, E'COMERCIAL J ESTIVARIZ', E'persona juridica', E'938082016', E'JORGE EDMUNDO ESTIVARIZ ASCARRUNZ', NULL, E'4224050', E'4224050', E'', NULL, E'Santa Cruz', 2, 3207, 4402);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (203, E'COMERCIAL SANTIAGO', E'persona juridica', E'', E'', NULL, E'4-425-6375', E'4-425-6375', E'', NULL, E'Santa Cruz', 2, NULL, 4403);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (183, E'COMERCIAL VICTORIA', E'persona juridica', E'', E'LUIS ALBERTO VIVADO', NULL, E'422-9408', E'', E'', NULL, E'Santa Cruz', 2, 3208, 4404);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (209, E'CONPROPET', E'persona juridica', E'', E'DANIEL ZORRILLA Ó MARIO ROSSELL', NULL, E'352-4777', E'352-5432', E'', NULL, E'Santa Cruz', 2, 3209, 4405);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (188, E'COREBOL', E'persona juridica', E'', E'JUAN CARLOS GUARDIA JORDÁN', NULL, E'352-6453', E'', E'', NULL, E'Santa Cruz', 2, 3210, 4406);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (181, E'ELECTRONIC CENTER', E'persona juridica', E'', E'', NULL, E'4259487', E'4259487', E'', NULL, E'Santa Cruz', 2, NULL, 4407);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (166, E'ELTEC', E'persona juridica', E'', E'', NULL, E'425-4754   425-0959', E'425-0160', E'', NULL, E'Santa Cruz', 2, NULL, 4408);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (207, E'FERRETERIA IBAÑEZ', E'persona juridica', E'', E'', NULL, E'77691509', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4409);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (158, E'FORTALEZA', E'persona juridica', E'', E'ALESSANDRA NAVIA D', NULL, E'3443363', E'3123353 (77081126)', E'', NULL, E'Santa Cruz', 2, 3211, 4410);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (159, E'GAJOS', E'persona juridica', E'', E'IVER GAITY JOFFRE', NULL, E'358-2213', E'358-2213', E'', NULL, E'Santa Cruz', 2, 3212, 4411);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (200, E'HIDROGAS', E'persona juridica', E'4732974011', E'JUAN SANTIAGO SANDOVAL', NULL, E'3581131', E'', E'', NULL, E'Santa Cruz', 2, 3213, 4412);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (179, E'ILUMINACION TOTAL', E'persona juridica', E'', E'', NULL, E'422-4419', E'423-0211', E'', NULL, E'Santa Cruz', 2, NULL, 4413);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (196, E'IMPORTADORA FERNANDO', E'persona juridica', E'', E'', NULL, E'3542525', E'3542526', E'', NULL, E'Santa Cruz', 2, NULL, 4414);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (180, E'INDEMEC', E'persona juridica', E'', E'', NULL, E'424-6395', E'440-9338', E'', NULL, E'Santa Cruz', 2, NULL, 4415);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (194, E'WINTERS INSTRUMENTS', E'persona juridica', E'', E'MARIANO ALEJANDRO REGIS', NULL, E'54 11 4792-8070', E'54 11 4733-0572', E'', NULL, E'Santa Cruz', 2, 3229, 4437);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (191, E'MOXOS', E'persona juridica', E'', NULL, NULL, E'462-4646', E'465-2041', E'', NULL, E'Santa Cruz', 2, NULL, 4438);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (216, E'BECAR REPUESTOS  SRL.', E'persona juridica', E'1013667027', E'PEDRO : MIGUEL', NULL, E'333-2767', E'337-1440', E'', NULL, E'Santa Cruz', 2, 3230, 4439);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (221, E'IMCRUZ', E'persona juridica', E'1026469026', E'JENNY SARAVIA', NULL, E'336-6660', E'353-1226', E'', NULL, E'Santa Cruz', 2, 3231, 4440);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (224, E'CORREAS CENTER LTDA', E'persona juridica', E'1026763029', E'PETER JESSEN P.', NULL, E'353-4857', E'353-4857', E'', NULL, E'Santa Cruz', 2, 3232, 4441);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (228, E'HELIOS SRL', E'persona juridica', E'1012133029', E'JAVIER GONZALES (LUIS ENRIQUE ROJAS', NULL, E'3492603', E'3492603', E'', NULL, E'Santa Cruz', 2, 3233, 4442);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (236, E'ERNESTO SOLIZ', E'persona natural', E'', E'ERNESTO SOLIZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3234, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (239, E'KATYA IMPORT - EXPORT', E'persona juridica', E'1471782010', E'ALONSO RODRIGUEZ VARGAS', NULL, E'3460416', E'3463099', E'', NULL, E'Santa Cruz', 2, 3235, 4443);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (251, E'FARMACORP S.A', E'persona juridica', E'', E'MARIA RENEE GUTIERREZ', NULL, E'355-5555', E'351-5081', E'', NULL, E'Santa Cruz', 2, 3236, 4444);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (259, E'AGRO STIHL', E'persona juridica', E'1026435027', E'LUIS ALBERTO REYES', NULL, E'3339043', E'3343357', E'', NULL, E'Santa Cruz', 2, 3237, 4445);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (263, E'CONTAC COMPUTERS', E'persona juridica', E'5429663013', E'JUSBERTH BARRIENTOS BERRIOS', NULL, E'336-5807', E'336-5807', E'', NULL, E'Santa Cruz', 2, 3238, 4446);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (234, E'IBM DE BOLIVIA S.A.', E'persona juridica', E'', E'ESTEBAN LAMI', NULL, E'3362232', E'', E'', NULL, E'Santa Cruz', 2, 3253, 4465);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (225, E'INDUSTRIAS GRÁFICAS  FIAT GRAF', E'persona juridica', E'', E'RAUL HERBAS B.', NULL, E'710-88842', E'', E'', NULL, E'Santa Cruz', 2, 3254, 4466);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (257, E'INDUSTRIAS SER', E'persona juridica', E'', E'', NULL, E'3468745', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4467);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (248, E'INFLUBOL', E'persona juridica', E'', E'DAMPIER CABALLERO PONTE', NULL, E'3120986', E'3120986', E'', NULL, E'Santa Cruz', 2, 3255, 4468);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (232, E'J & R COMPUTER', E'persona juridica', E'', E'SANDRA BUENO MINDANI', NULL, E'355-2313', E'355-2313', E'', NULL, E'Santa Cruz', 2, 3256, 4469);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (218, E'KERANA', E'persona juridica', E'141389029', E'ELIZABETH URQUIDI', NULL, E'3460691', E'3476557', E'', NULL, E'Santa Cruz', 2, 3257, 4470);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (237, E'LIQUID DRIVE CORPORATION', E'persona juridica', E'', E'GARY BROWN', NULL, E'248-634-5382', E'248-634-5720', E'', NULL, E'Santa Cruz', 2, 3258, 4471);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (255, E'METALOCK BOLVIVA', E'persona juridica', E'', E'RENE ESCALERA FERNANDEZ', NULL, E'44721717 CBB/ 3565474 SCZ', E'44720416 CBB/ 3565473 SCZ', E'', NULL, E'Santa Cruz', 2, 3259, 4472);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (256, E'METROTECH CORPORATION', E'persona juridica', E'', E'BROOKE CUNNINGHAM', NULL, E'1-408-734-1400', E'1-408-734-1415', E'', NULL, E'Santa Cruz', 2, 3260, 4473);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (230, E'MEVA SERVICIOS GRÁFICOS', E'persona juridica', E'', E'EUNICE VASQUEZ DE MENESES', NULL, E'333-5979', E'353-8921', E'', NULL, E'Santa Cruz', 2, 3261, 4474);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (262, E'MILLIPORE CORPORATION', E'persona juridica', E'', E'MARY-JO GALLANT', NULL, E'1-781-533-8697', E'1-781-533-8630', E'', NULL, E'Santa Cruz', 2, 3262, 4475);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (268, E'MOVITEL', E'persona juridica', E'', E'LOLA MORENO PARADA', NULL, E'336-3424', E'336-3424', E'', NULL, E'Santa Cruz', 2, 3263, 4476);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (323, E'SIKA BOLIVIA  SA', E'persona juridica', E'1006905020', E'JUAN MANUEL RODRIGUEZ', NULL, E'3367756', E'3370594', E'', NULL, E'Santa Cruz', 2, 3275, 4493);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (282, E'AMPEX INTERNATIONAL', E'persona juridica', E'', E'ERNESTO ROCHA', NULL, E'3410029', E'3410029', E'', NULL, E'Santa Cruz', 2, 3221, 4494);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (284, E'BARRACA CRISMAR PLUZ', E'persona juridica', E'5489332012', E'CELIA GRACIELA SILVA GUTIÉRREZ', NULL, E'46432528', E'', E'', NULL, E'Santa Cruz', 2, 3276, 4495);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (299, E'BARRACA LOS ALAMOS', E'persona juridica', E'', E'CLORINDA DE ZAMBRANA', NULL, E'46455236', E'', E'', NULL, E'Santa Cruz', 2, 3277, 4496);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (275, E'BARRACA SAN RAFAEL', E'persona juridica', E'1006100015', E'MARIO NAVA', NULL, E'46460318', E'', E'', NULL, E'Santa Cruz', 2, 3278, 4497);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (312, E'BATERIAS FISHER', E'persona juridica', E'', E'LOURDES GUARACHI MURILLO', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3279, 4498);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (309, E'BEL STAR S.R.L.', E'persona juridica', E'', E'JHON ALEXANDER CORDOBA', NULL, E'330-2940', E'330-2940', E'', NULL, E'Santa Cruz', 2, 3280, 4499);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (276, E'BOLIVIANA D.C.N.', E'persona juridica', E'', E'MARIA CLAURE', NULL, E'2833560', E'2866560', E'', NULL, E'Santa Cruz', 2, 3281, 4500);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (300, E'CKB COMUNICACIONES KENWOOD BOLIVIA', E'persona juridica', E'', E'ELIZABETH PATRICIA CAERO ADRIAN', NULL, E'4425-3192', E'4425-2781', E'', NULL, E'Santa Cruz', 2, 3282, 4501);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (310, E'COMERCIAL ALBERTO', E'persona juridica', E'', E'FERNANDO AYARDE', NULL, E'6637392', E'6637392', E'', NULL, E'Santa Cruz', 2, 3283, 4502);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (316, E'COMERCIAL CHURUQUELLA', E'persona juridica', E'35939335015', E'CARMEN TAPIA', NULL, E'46442117', E'', E'', NULL, E'Santa Cruz', 2, 3284, 4503);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (285, E'COMPAÑÍA QUIMICA DEL ESTE', E'persona juridica', E'', E'JORGE FIDEL TORRICOS', NULL, E'3532584', E'3540960', E'', NULL, E'Santa Cruz', 2, 3285, 4504);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (273, E'GENESIS', E'persona juridica', E'', E'GONZALO GUTIERREZ', NULL, E'332-4935', E'332-4935', E'', NULL, E'Santa Cruz', 2, 3300, 4521);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (297, E'GS BATERIAS', E'persona juridica', E'', E'FREDDY HUARITA PINEDO', NULL, E'464-60404', E'464-60404', E'', NULL, E'Santa Cruz', 2, 3301, 4522);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (298, E'HMT INC', E'persona juridica', E'', E'JUAN CARLOS GUARDIA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3302, 4523);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (283, E'IMPRESO SRL', E'persona juridica', E'', E'JUDITH ORTIZ LLANOS', NULL, E'339-0550', E'339-0550', E'', NULL, E'Santa Cruz', 2, 3303, 4524);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (327, E'KAISER', E'persona juridica', E'', E'JAIME NUÑEZ DEL PRADO', NULL, E'342-6111', E'334-0111', E'', NULL, E'Santa Cruz', 2, 3304, 4525);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (322, E'LUBRICANTES VIDAL', E'persona juridica', E'', E'JUAN CABRERA AVILA', NULL, E'3463624', E'', E'', NULL, E'Santa Cruz', 2, 3305, 4526);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (278, E'MIRAFLORES', E'persona juridica', E'', E'EFRAIN BUTRON GARCIA', NULL, E'455-3288', E'455-3288', E'', NULL, E'Santa Cruz', 2, 3306, 4527);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (279, E'MUNDO ELECTRICO', E'persona juridica', E'', E'', NULL, E'2821482', E'2821482', E'', NULL, E'Santa Cruz', 2, NULL, 4528);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (301, E'PLASMAR S.A.', E'persona juridica', E'', E'CLARA NATELO', NULL, E'3463095', E'3463095', E'', NULL, E'Santa Cruz', 2, 3307, 4529);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (288, E'ROMA CONFECCIONES', E'persona juridica', E'', E'MARISOL ESCALANTE', NULL, E'341-0834 (71066634', E'341-0834', E'', NULL, E'Santa Cruz', 2, 3308, 4530);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (321, E'ROSITEX CORPORATION', E'persona juridica', E'', E'OSCAR BENITEZ', NULL, E'3475517', E'3475517', E'', NULL, E'Santa Cruz', 2, 3309, 4531);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (313, E'SATCOM SRL', E'persona juridica', E'', E'JOEMI SANCHEZ', NULL, E'4432-3000', E'4412-3102', E'', NULL, E'Santa Cruz', 2, 3310, 4532);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (290, E'SATT INTERNATIONAL CORPORATION', E'persona juridica', E'', E'JURGEN SATT', NULL, E'3428270', E'3453239', E'', NULL, E'Santa Cruz', 2, 3311, 4533);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (291, E'SHS SOLUTION', E'persona juridica', E'', E'MARCELO HINOJOSA', NULL, E'3364967', E'3364967', E'', NULL, E'Santa Cruz', 2, 3312, 4534);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (311, E'SOLUSOFT BOLIVIA', E'persona juridica', E'', E'SEVERINO VILLAROEL', NULL, E'3323225', E'3323226', E'', NULL, E'Santa Cruz', 2, 3313, 4535);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (360, E'GLOBAL INK PRINT INFORMATICA Y LIBRERIA', E'persona juridica', E'3277600016', E'JOSE LUIS SAUCEDO SEVERICHE', NULL, E'339-5563', E'339-5563', E'', NULL, E'Santa Cruz', 2, 3324, 4547);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (363, E'DHD', E'persona juridica', E'5336557017', E'JUAN CARLOS RODRIGUEZ VARGAS', NULL, E'341-9622  708-67457', E'341-9622', E'', NULL, E'Santa Cruz', 2, 3325, 4548);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (365, E'IPS', E'persona natural', E'1014543022', E'FRANCISCO NAVARRETE', NULL, E'351-4363', E'70046433', E'', NULL, E'Santa Cruz', 2, 3326, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (369, E'SUDAMERICANA', E'persona juridica', E'6764556016', E'RITA BEATRIZ GUERRERO TEJADA', NULL, E'2494303', E'2494303', E'', NULL, E'Santa Cruz', 2, 3327, 4549);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (372, E'GRUPO LARCOS INDUSTRIAL LTDA', E'persona juridica', E'1020461021', E'WALTER ADOLFO COSTAS ROCABADO', NULL, E'335-5331', E'339-5033', E'', NULL, E'Santa Cruz', 2, 3328, 4550);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (376, E'SAOL IMOORT EXPORT', E'persona natural', E'', E'ALFONZO OLIVARES', NULL, E'3503234 71600068', E'', E'', NULL, E'Santa Cruz', 2, 3329, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (367, E'GRUPO EMPRESARIAL MAXIKING SRL', E'persona juridica', E'1025905020', E'RICARDO GOMEZ', NULL, E'344-4016', E'344-4016', E'', NULL, E'Santa Cruz', 2, 3330, 4551);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (333, E'CENTRO DE SEGURIDAD', E'persona juridica', E'3824983017', E'RUBÉN DARÍO MORENO V.', NULL, E'3421385', E'3421385', E'', NULL, E'Santa Cruz', 2, 3331, 4552);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (336, E'COLECCIÓN PRIVADA', E'persona juridica', E'1.00999E+11', E'JULY RIVAS', NULL, E'343-4918', E'343-4918', E'', NULL, E'Santa Cruz', 2, 3332, 4553);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (350, E'COMERCIAL CRUZ', E'persona juridica', E'', E'WILLY MAMANI', NULL, E'46453950', E'', E'', NULL, E'Santa Cruz', 2, 3333, 4554);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (334, E'LUQUE AMOBLAMIENTOS', E'persona juridica', E'1482084010', E'MERCEDES IVETTE TERCEROS DE LUQUE', NULL, E'334-0110', E'3396743', E'', NULL, E'Santa Cruz', 2, 3348, 4571);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (346, E'MEDIDORES INTERNACIONALES ROCHESTER, S.A. DE C.V.', E'persona juridica', E'', E'SERGIO ZARAZÚA', NULL, E'(5255) 3003 0970', E'(5255) 3003 0785', E'', NULL, E'Santa Cruz', 2, 3349, 4572);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (329, E'MULTIPERNOS ANDIA', E'persona juridica', E'', E'ARTURO ANDIA', NULL, E'351-0497', E'351-0497', E'', NULL, E'Santa Cruz', 2, 3350, 4573);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (351, E'MUNDI OFFICE', E'persona juridica', E'4414711018', E'VANIA G. GUZMÁN RODRÍGUEZ', NULL, E'458-0798', E'458-0798', E'', NULL, E'Santa Cruz', 2, 3351, 4574);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (354, E'NAHI S.R.L.', E'persona juridica', E'1021311021', E'JHANET QUISPE CHAVEZ', NULL, E'426-6135', E'428-0159', E'', NULL, E'Santa Cruz', 2, 3352, 4575);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (341, E'NOSIGLIA SPORT S.A.', E'persona juridica', E'', E'WALTER NOSIGLIA', NULL, E'2-2794904', E'2-2771395', E'', NULL, E'Santa Cruz', 2, 3353, 4576);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (352, E'PALACIO DEL NIPLE', E'persona juridica', E'', E'', NULL, E'464-23390', E'464-32127', E'', NULL, E'Santa Cruz', 2, NULL, 4577);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (353, E'PROTEC', E'persona juridica', E'1696708014', E'JUAN JOSÉ HINOJOSA', NULL, E'3482199 - 71625035', E'3482199', E'', NULL, E'Santa Cruz', 2, 3354, 4578);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (331, E'SERVICIOS GENERALES', E'persona juridica', E'', E'RAFAEL RÍOS', NULL, E'72100647', E'3559911', E'', NULL, E'Santa Cruz', 2, 3355, 4579);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (356, E'SIGMA', E'persona juridica', E'1526914017', E'SAMUEL MÉNDEZ JUNSTINIANO', NULL, E'348-1275', E'348-1275', E'', NULL, E'Santa Cruz', 2, 3356, 4580);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (393, E'BRIGHSTAR BOLIVIA', E'persona juridica', E'', E'CHRISTIAN VRSALOVIC C', NULL, E'3377249', E'3377028', E'', NULL, E'Santa Cruz', 2, 3369, 4594);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (416, E'CADECORP', E'persona juridica', E'3853232016', E'MARIOLI VACA AÑEZ', NULL, E'3628481', E'3628481', E'', NULL, E'Santa Cruz', 2, 3370, 4595);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (382, E'CASA DEL CONSTRUCTOR', E'persona juridica', E'', E'JAVIER VEDIA  SANCHEZ', NULL, E'6640799', E'6640799', E'', NULL, E'Santa Cruz', 2, 3371, 4596);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (386, E'CASA DEL FIERRO', E'persona juridica', E'2931554016', E'FREDDY CRONEMBOLD SUÁREZ', NULL, E'346-7954', E'346-7954', E'', NULL, E'Santa Cruz', 2, 3372, 4597);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (400, E'CASA TOKYO', E'persona juridica', E'1024989023', E'HIROKO NAKAMURA SAKAGUSHI', NULL, E'333-2960  :  335-0393', E'336-1564', E'', NULL, E'Santa Cruz', 2, 3373, 4598);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (418, E'CENTRO DE BATERIAS \\\"MORALES\\\"', E'persona juridica', E'4466386016', E'ELIODORO CONDORI CONDOLI', NULL, E'4-4588590', E'', E'', NULL, E'Santa Cruz', 2, 3374, 4599);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (406, E'COSUBO LTDA.', E'persona juridica', E'', E'', NULL, E'4-422-9167', E'4-425-0162', E'', NULL, E'Santa Cruz', 2, NULL, 4600);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (404, E'DISTRIBUIDORA EL CAINE SRL.', E'persona juridica', E'', E'', NULL, E'425-4618', E'425-0257', E'', NULL, E'Santa Cruz', 2, NULL, 4601);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (377, E'DOT USA', E'persona juridica', E'', E'', NULL, E'4255024', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4602);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (379, E'ELECTRIC MERCANTIL', E'persona juridica', E'', E'PATRICIA CHAMBI', NULL, E'4448368', E'4448369', E'', NULL, E'Santa Cruz', 2, 3375, 4603);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (411, E'E.M.C. (ESPECIALISTA EN MÁQUINAS COPIADORAS)', E'persona juridica', E'115116010', E'', NULL, E'475-1404', E'475-1404', E'', NULL, E'Santa Cruz', 2, NULL, 4604);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (401, E'EMSIC', E'persona juridica', E'', E'JAVIER VIDAL', NULL, E'3323489', E'3332583', E'', NULL, E'Santa Cruz', 2, 3376, 4605);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (424, E'TEC', E'persona juridica', E'', E'RONALD CAVERO', NULL, E'4400917', E'44286002', E'', NULL, E'Santa Cruz', 2, 3388, 4622);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (396, E'TOYODA AUTOMOTORS', E'persona juridica', E'1100575012', E'SCHUGAIR DUERI YUSEF MARIO', NULL, E'3334413 - 72105134', E'3334413', E'', NULL, E'Santa Cruz', 2, 3389, 4623);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (398, E'VICTEL COMUNICACIONES', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4624);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (419, E'PROVEEDURIA INDUSTRIAL', E'persona juridica', E'140915026', E'ALEJANDRO GONZALES', NULL, E'3397550 - 70863475', E'3397550', E'', NULL, E'Santa Cruz', 2, 3390, 4625);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (390, E'IMPORTADORA CERVANTES SRL.', E'persona juridica', E'120557020', NULL, NULL, E'334-0551', E'3369063', E'', NULL, E'Santa Cruz', 2, NULL, 4626);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (409, E'TECNILLANTAS DEL ORIENTE', E'persona juridica', E'1209295027', NULL, NULL, E'348-7037', E'348-7037', E'', NULL, E'Santa Cruz', 2, NULL, 4627);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (427, E'PASCUAL CALLISAYA QUISPE', E'persona natural', E'2447801013', E'', NULL, E'44250271', E'44558024', E'', NULL, E'Santa Cruz', 2, 3391, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (428, E'ANDIA FERNANDEZ', E'persona natural', E'4433694015', E'CARLOS ANDIA FERNANDEZ', NULL, E'44283739 - 4420084', E'', E'', NULL, E'Santa Cruz', 2, 3392, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (431, E'ROSY MAR', E'persona natural', E'2883495013', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3393, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (432, E'JUAN ROCHA FLORES', E'persona natural', E'3533108011', E'JUAN ROCHA FLORES', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3394, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (433, E'LUBRILLANTAS', E'persona juridica', E'3168320012', E'CLAUDIA INES PORRAS SUAREZ', NULL, E'3364536', E'3364536', E'', NULL, E'Santa Cruz', 2, 3395, 4628);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (476, E'CASA GRANDE', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4635);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (437, E'EXPERTIA', E'persona juridica', E'', E'CARLOS RECACOCHEA', NULL, E'3414638', E'3414638', E'', NULL, E'Santa Cruz', 2, 3413, 4650);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (430, E'FANAGOM INDUSTRIA DEL CAUCHO', E'persona juridica', E'', E'', NULL, E'22851113-22853250', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4651);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (479, E'FERRETERIA BRAYAN', E'persona juridica', E'1076636012', E'', NULL, E'46432420', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4652);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (452, E'FERRETERIA CABRERA', E'persona juridica', E'', E'', NULL, E'4620612', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4653);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (444, E'FERRETERIA CARRILO', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4654);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (429, E'FERRETERIA COPACABANA', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4655);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (467, E'FERRETERIA MAIR', E'persona juridica', E'3604920010', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4656);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (457, E'FERRETERIA MONTERREY', E'persona juridica', E'', E'', NULL, E'4628147', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4657);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (486, E'FERRETERIA NACIONAL', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4658);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (460, E'FERRETERIA ROSARIO', E'persona juridica', E'', E'', NULL, E'9524237-71036999', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4659);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (487, E'FERROMAC', E'persona juridica', E'1093320018', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4660);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (471, E'FERROVIDRIO', E'persona juridica', E'3719085012', E'JAVIER CORTEZ CRUZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3414, 4661);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (459, E'IMPORT EXPORT GRAN CHACO', E'persona juridica', E'4671783017', E'ADHEMAR AGUILER', NULL, E'3491425', E'3491425', E'', NULL, E'Santa Cruz', 2, 3415, 4662);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (449, E'INGENIERIA Y SERVICIOS INTEGRALES', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4663);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (442, E'J & M', E'persona juridica', E'', E'JAVIER DELGADO', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3416, 4664);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (434, E'JMG SRL', E'persona juridica', E'', E'', NULL, E'3547935', E'3547935', E'', NULL, E'Santa Cruz', 2, NULL, 4665);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (531, E'BOMBAS PINTINI S.R.L.', E'persona juridica', E'155350021', E'ELDA SAAVEDRA ANTEZANA', NULL, E'3358835', E'3358835', E'', NULL, E'Santa Cruz', 2, 3431, 4686);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (533, E'ECOPRINT', E'persona juridica', E'1026015024', E'CLEVERSON JOSE BUTZGE', NULL, E'3391702', E'', E'', NULL, E'Santa Cruz', 2, 3432, 4687);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (534, E'M.S.M. SOLUCIONES INFORMÁTICAS', E'persona juridica', E'4639923015', E'DAVID L. MOLINA GUZMAN', NULL, E'3415591', E'', E'', NULL, E'Santa Cruz', 2, 3433, 4688);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (536, E'JOSE ANTONIO TERRAZAS', E'persona natural', E'3048005015', E'JOSE ANTONIO TERRAZAS', NULL, E'44254170', E'', E'', NULL, E'Santa Cruz', 2, 3434, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (542, E'JULIO OMAR VELIZ', E'persona natural', E'3501405013', E'JULIO OMAR VELIZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3435, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (548, E'CARLOS ESTRADA SALINAS', E'persona natural', E'', E'', NULL, E'5284967', E'5285438', E'', NULL, E'Santa Cruz', 2, 3436, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (514, E'ASERRADERO BARRIENTOS', E'persona juridica', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4689);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (549, E'ASOCIACION DE VOLQUETAS DE IVIRGARZAMA', E'persona juridica', E'', E'BERNARDO ADRIAZOLA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3437, 4690);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (493, E'BARRACA HERRERA', E'persona juridica', E'1629707010', E'AUGUSTO HERRERA', NULL, E'46631827', E'', E'', NULL, E'Santa Cruz', 2, 3438, 4691);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (544, E'BOLIVIANA DISEÑO Y CONFECCIÓN', E'persona juridica', E'4744490017', E'ZULEMA CRUZ ALAVE', NULL, E'02 2833560', E'02 2833560', E'', NULL, E'Santa Cruz', 2, 3439, 4692);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (539, E'CALZADOS MUR E HIJOS', E'persona juridica', E'1024851025', E'EDUARDO RAFAEL MUR MAESTRE', NULL, E'3577763', E'3551592', E'', NULL, E'Santa Cruz', 2, 3440, 4693);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (529, E'CERABOL', E'persona juridica', E'1028509021', E'', NULL, E'3462315', E'3461647', E'', NULL, E'Santa Cruz', 2, NULL, 4694);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (546, E'INCEROR', E'persona juridica', E'1023489020', E'VICTOR HUGO CESPEDES', NULL, E'5252553', E'5253966', E'', NULL, E'Santa Cruz', 2, 3457, 4717);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (543, E'MADERA BIBOSI', E'persona juridica', E'3375937010', E'HERNAN LUCIO FERRUFINO', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3458, 4718);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (494, E'ROAD CC SRL', E'persona juridica', E'', E'ELVIN ORLANDO OVANDO GARECA', NULL, E'46660379', E'', E'', NULL, E'Santa Cruz', 2, 3459, 4719);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (505, E'SERVICIOS HSG', E'persona juridica', E'1105099017', E'SANDRA ANAHI POPPE DE HERRERA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3460, 4720);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (526, E'SOBOCE', E'persona juridica', E'', E'ZENAIDA TORREZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3451, 4721);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (532, E'SOCOSER S.R.L', E'persona juridica', E'', E'HERLAND BANEGAS', NULL, E'4411088', E'4411088', E'', NULL, E'Santa Cruz', 2, 3461, 4722);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (496, E'TECNO GAS HUGO', E'persona juridica', E'', E'HUGO HUANCA', NULL, E'73119089', E'76070550', E'', NULL, E'Santa Cruz', 2, 3462, 4723);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (520, E'TOOLS', E'persona juridica', E'3705458013', E'XIMENA ESCALERA', NULL, E'44225328', E'', E'', NULL, E'Santa Cruz', 2, 3463, 4724);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (535, E'TUMPAR LTDA', E'persona juridica', E'1015225028', E'', NULL, E'3424031', E'3452986', E'', NULL, E'Santa Cruz', 2, NULL, 4725);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (524, E'FERRINDUS IMPOR- EXPOR', E'persona juridica', E'', NULL, NULL, E'3463460', E'3463860', E'', NULL, E'Santa Cruz', 2, NULL, 4726);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (550, E'WIDMAN INTERNATIONAL SRL', E'persona juridica', E'1015559025', E'OMAR LINARES', NULL, E'3442233', E'3442233', E'', NULL, E'Santa Cruz', 2, 3464, 4727);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (551, E'ALTEKPOINT SRL', E'persona juridica', E'1013823026', E'EVELIN CESPEDES', NULL, E'351-5824', E'', E'', NULL, E'Santa Cruz', 2, 3465, 4728);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (553, E'SAYCO', E'persona juridica', E'3580632015', E'FERNANDO IVAN MAYORGA LAZCANO', NULL, E'3442516', E'3442516', E'', NULL, E'Santa Cruz', 2, 3466, 4729);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (554, E'LUCIO TICONA', E'persona natural', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3467, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (579, E'RETIS', E'persona juridica', E'4643328011', E'MILTON RUEDA VALDIVIA', NULL, E'3517929', E'3517929', E'', NULL, E'Santa Cruz', 2, 3479, 4740);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (580, E'EDGAR BAUTISTA CRUZ', E'persona natural', E'', E'', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3480, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (581, E'SESIGA BUHOS SA', E'persona juridica', E'1025699023', E'ALDO ORIEL AUDIVERT PEDRIEL', NULL, E'3555355', E'3704019', E'', NULL, E'Santa Cruz', 2, 3481, 4741);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (584, E'ORJAVI SRL', E'persona juridica', E'145252020', E'JUAN ORELLANA MAMANI', NULL, E'3487682 - 73169983', E'', E'', NULL, E'Santa Cruz', 2, 3482, 4742);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (596, E'BETTY ALVAREZ', E'persona natural', E'', E'BETTY ALVAREZ', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3483, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (597, E'RODOLFO FERRERA', E'persona natural', E'', E'RODOLFO FERRERA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3484, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (598, E'TERY REA MORALES', E'persona natural', E'', E'TERY REA MORALES', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3485, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (592, E'ATCOMP', E'persona juridica', E'1885414013', E'MARLENE JUSTINIANO (ALEJANDDRA ORTIZ)', NULL, E'3352634', E'3303527', E'', NULL, E'Santa Cruz', 2, 3486, 4743);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (586, E'BAZAR LIBRERIA EL EJECUTIVO', E'persona juridica', E'', E'', NULL, E'6631927', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4744);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (568, E'BEST STORE CITY', E'persona juridica', E'157802026', E'JOSE MENDIETA', NULL, E'3390584', E'3113101', E'', NULL, E'Santa Cruz', 2, 3487, 4745);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (552, E'COMERCIAL JAIMES', E'persona juridica', E'3156647018', E'EDWIN JAIMES', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3488, 4746);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (583, E'COMIND', E'persona juridica', E'1580008010', E'ERNESTO CÉSPEDES ARAUZ', NULL, E'3561923', E'3561923', E'', NULL, E'Santa Cruz', 2, 3489, 4747);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (559, E'CONMOSER', E'persona juridica', E'1020939021', E'MAURICIO DE UGARTE', NULL, E'3343299', E'2233299', E'', NULL, E'Santa Cruz', 2, 3490, 4748);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (585, E'SANTA LUCIA', E'persona juridica', E'3935026014', E'LUCIA SABEJH BECHARA MUKLED', NULL, E'3348798', E'3348798', E'', NULL, E'Santa Cruz', 2, 3504, 4765);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (594, E'URBANTEX MODA URBANA', E'persona juridica', E'3495093019', E'ALVARO RICARDO LOAYZA CAREAGA', NULL, E'3415566', E'', E'', NULL, E'Santa Cruz', 2, 3505, 4766);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (595, E'TECFLUX BOLIVIA S.R.L.', E'persona juridica', E'138001027', NULL, NULL, E'3538422', E'3589299', E'', NULL, E'Santa Cruz', 2, NULL, 4767);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (605, E'LIBRERÍA  Y PAPELERIA CRISTINA', E'persona juridica', E'1988123015', E'MARIA CRISTINA ORTIZ DE LEON', NULL, E'3341331', E'3368331', E'', NULL, E'Santa Cruz', 2, 3506, 4768);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (612, E'SOCIEDAD COMERCIAL LA LLAVE S.A.', E'persona juridica', E'160890029', E'CARLOS ENRIQUE KEMPFF BRUNO', NULL, E'33419575', E'3419581', E'', NULL, E'Santa Cruz', 2, 3507, 4769);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (620, E'FREMAR MONTAÑO SRL', E'persona natural', E'1021025029', E'FREDDY ESTEBAN MONTAÑO', NULL, E'3330787', E'3333168', E'', NULL, E'Santa Cruz', 2, 3508, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (626, E'JV IMPORTACIONES REPRESENTACIONES S.RL.', E'persona juridica', E'166538023', E'MARITEN GUZMAN', NULL, E'3576444', E'6576415', E'', NULL, E'Santa Cruz', 2, 3509, 4770);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (628, E'TOTAL SERVICE S.R.L.', E'persona juridica', E'159294023', E'OSCAR GABRIEL BURELA DURAN', NULL, E'3463341', E'', E'', NULL, E'Santa Cruz', 2, 3510, 4771);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (629, E'AGROVET', E'persona juridica', E'4579555018', E'HAROLD ALCIDES BLANCO', NULL, E'3324245', E'', E'', NULL, E'Santa Cruz', 2, 3511, 4772);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (631, E'AGROVET ORIENTAL', E'persona juridica', E'1576892015', E'ENRIQUE SILVA RUIZ', NULL, E'3352191', E'', E'', NULL, E'Santa Cruz', 2, 3512, 4773);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (611, E'ECHAZU & ASOCIADOS', E'persona juridica', E'1486668010', E'AURELIO F. ECHAZU SALMON', NULL, E'3361160', E'3360074', E'', NULL, E'Santa Cruz', 2, 3527, 4790);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (649, E'EMPACAR SA', E'persona juridica', E'1028123025', E'CARLOS SALAUES', NULL, E'3465525', E'3461883', E'', NULL, E'Santa Cruz', 2, 3528, 4791);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (603, E'E.S.C.', E'persona juridica', E'', E'OSCAR PAZ', NULL, E'3340578', E'3331349', E'', NULL, E'Santa Cruz', 2, 3494, 4792);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (638, E'EUROSUDAMERICANA S.R.L.', E'persona juridica', E'', E'SERGIO CHAIN', NULL, E'3399121', E'', E'', NULL, E'Santa Cruz', 2, 3529, 4793);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (610, E'FANCESA', E'persona juridica', E'1016259020', E'LUIS EDGAR TABOADA', NULL, E'64-41314', E'', E'', NULL, E'Santa Cruz', 2, 3530, 4794);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (616, E'FERRETERIA CORAL', E'persona juridica', E'3388493012', E'JUAN ANGEL MACHACA', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3531, 4795);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (621, E'HIPER PLAST S.R.L.', E'persona juridica', E'139669024', E'CARMEN ALICIA', NULL, E'3602674', E'', E'', NULL, E'Santa Cruz', 2, 3532, 4796);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (608, E'IBT', E'persona juridica', E'', E'MAURICIO JORDAN', NULL, E'3338563', E'3327562', E'', NULL, E'Santa Cruz', 2, 3533, 4797);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (646, E'INDANA  S.R.L', E'persona juridica', E'150138022', E'LUIS MORENO', NULL, E'3598632', E'3596966', E'', NULL, E'Santa Cruz', 2, 3534, 4798);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (637, E'INGENIERIA & SERVICIOS', E'persona juridica', E'1593211018', E'MARCO ANTONIO ORTIZ JUSTINIANO', NULL, E'3412818', E'3428170', E'', NULL, E'Santa Cruz', 2, 3535, 4799);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (600, E'INGETEL', E'persona juridica', E'', E'IBDKA ZENZANO', NULL, E'3363608', E'3322427', E'', NULL, E'Santa Cruz', 2, 3536, 4800);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (642, E'LIBRERIA J.R.M.', E'persona juridica', E'288959019', E'JUAN MENDOZA ROJAS', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3537, 4801);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (656, E'SACI', E'persona juridica', E'1029831027', E'ANA QUINO', NULL, E'3423388  -  3420575', E'3423427', E'', NULL, E'Santa Cruz', 2, 3549, 4818);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (658, E'ROGAL', E'persona juridica', E'', E'EDUARDO SAN JUAN', NULL, E'3597617', E'3597617', E'', NULL, E'Santa Cruz', 2, 3366, 4819);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (660, E'ALGAR S.A.', E'persona juridica', E'1028535024', E'RUBEN CARRASCO', NULL, E'346-7676  347-3463', E'347-3460', E'', NULL, E'Santa Cruz', 2, 3550, 4820);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (667, E'MILLIET SRL', E'persona juridica', E'122897022', E'ENRIQUE GUTIERREZ', NULL, E'231-0621', E'231-0597', E'', NULL, E'Santa Cruz', 2, 3551, 4821);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (669, E'EMPRESA DE IMPORTACIONES Y  EXPORTACIONES \\\"PROFIMAR\\\" LTDA.', E'persona juridica', E'1011893026', E'LEONARDO DAVID MARTINEZ SAUCEDO', NULL, E'342-7599', E'342-2465', E'', NULL, E'Santa Cruz', 2, 3552, 4822);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (673, E'BATE JUNIOR', E'persona juridica', E'3266611017', E'DOUGLAS HERRERA', NULL, E'3371095', E'3371095', E'', NULL, E'Santa Cruz', 2, 3553, 4823);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (677, E'EDUARDO S.A.', E'persona juridica', E'1028297029', E'ALFREDO FRANCISCO KILIBARDA.', NULL, E'346-2655  -  346-2899', E'346-1344', E'', NULL, E'Santa Cruz', 2, 3554, 4824);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (679, E'LARCOS', E'persona juridica', E'', E'HENRY SOTO', NULL, E'3355331', E'3355332', E'', NULL, E'Santa Cruz', 2, 3555, 4825);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (682, E'BLUE BAY INTERNATIONAL LTDA', E'persona juridica', E'167614023', E'SERGIO GONZALES', NULL, E'72179371', E'', E'', NULL, E'Santa Cruz', 2, 3556, 4826);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (685, E'ELECTRICOS MARCERVI', E'persona juridica', E'', E'FERNANDO GEMIO', NULL, E'77498359', E'', E'', NULL, E'Santa Cruz', 2, 3569, 4841);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (686, E'EMPORIUM', E'persona juridica', E'155574020', E'LUIS FERNANDO OROPEZA', NULL, E'3305628', E'', E'', NULL, E'Santa Cruz', 2, 3570, 4842);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (687, E'EXPERTS SYSTEMS', E'persona juridica', E'5411867011', E'', NULL, E'3360353', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4843);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (681, E'FERRETERIA MICKY', E'persona juridica', E'', E'YOBANA', NULL, E'3529870', E'3529840', E'', NULL, E'Santa Cruz', 2, 3571, 4844);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (684, E'HARDLINE LTDA.', E'persona juridica', E'120437024', E'ZULMA IRIARTE', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3572, 4845);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (696, E'LA CASA DEL MUELLE', E'persona juridica', E'', E'VALENTIN CESPEDES GARCIA', NULL, E'3532144', E'3527823', E'', NULL, E'Santa Cruz', 2, 3573, 4846);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (671, E'MY OFFICE', E'persona juridica', E'', E'CARLOS MOSTACEDO M.', NULL, E'333-2334', E'334-0004', E'', NULL, E'Santa Cruz', 2, 3574, 4847);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (695, E'PER-BOL IMPORTACIONES LTDA', E'persona juridica', E'', E'BENIGNO RAMON INFANTAS  GALLEGOS', NULL, E'3327508', E'3362927', E'', NULL, E'Santa Cruz', 2, 3575, 4848);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (690, E'PERTEC S.A.', E'persona juridica', E'', E'GONZALO RAUL VARGAS RIVERA', NULL, E'3470113', E'3488143', E'', NULL, E'Santa Cruz', 2, 3576, 4849);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (676, E'PROGRECRUZ', E'persona juridica', E'', E'FERNANDO FERNANDEZ', NULL, E'333-7097', E'333-2852', E'', NULL, E'Santa Cruz', 2, 3577, 4850);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (693, E'PROIMPETROL IMPORT EXPORT S.R.L', E'persona juridica', E'', E'ELIZABETH AVILA', NULL, E'3646000', E'3475517', E'', NULL, E'Santa Cruz', 2, 3578, 4851);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (721, E'PROYECTOS DE COMPUTACION LTDA. PROCOM LTDA', E'persona juridica', E'1015345022', E'MIGUEL BARRIOS DELGADO', NULL, E'343-2942', E'343-2943', E'', NULL, E'Santa Cruz', 2, 3590, 4868);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (722, E'FERRETERIA HERRAMUNDO INDUSTRIAL', E'persona juridica', E'5853868019', E'NANCY LAURA LOPEZ MONASTERIO', NULL, E'346-0433', E'346-0433', E'', NULL, E'Santa Cruz', 2, 3591, 4869);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (729, E'FERRETERIA ACERO- ISAIAS MAMANI SANABRIA', E'persona juridica', E'4118301017', E'ISAIAS MAMANI ZANABRIA', NULL, E'643-1346', E'643-1346', E'', NULL, E'Santa Cruz', 2, 3592, 4870);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (738, E'TODO LLANTAS  LTDA', E'persona juridica', E'', E'CANTEIRO CHAMBI', NULL, E'3431104', E'3435319', E'', NULL, E'Santa Cruz', 2, 3593, 4871);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (741, E'FERRETERIA ALEMANA BERLIN SRL', E'persona juridica', E'120747021', E'HEIDY MARIA BOHEME ARZR', NULL, E'3329345', E'33329345', E'', NULL, E'Santa Cruz', 2, 3594, 4872);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (743, E'S&S INDUSTRIAL SRL', E'persona juridica', E'1013277021', E'RAMONA ROCA PEDRIEL', NULL, E'3390114', E'3354347', E'', NULL, E'Santa Cruz', 2, 3595, 4873);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (744, E'FRANCISCO  AGUILERA SERRATE -TRACTO FIERRO JR', E'persona natural', E'534217008', E'FRANCISCO  AGUILERA SERRATE', NULL, E'3569981', E'3569981', E'', NULL, E'Santa Cruz', 2, 3596, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (746, E'MARIA NELLY AGUILERA SERRATE', E'persona natural', E'5882660011', E'MARIA NELLY AGUILERA SERRATE', NULL, E'356-7559', E'356-7559', E'', NULL, E'Santa Cruz', 2, 3597, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (748, E'MARTIN PACHECO BARRANCOS -JAVNUR TRANS TOURS SERVICE', E'persona juridica', E'2287061013', E'MARTIN PACHECO  BARRANCOS', NULL, E'354-0122', E'3540122', E'', NULL, E'Santa Cruz', 2, 3598, 4874);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (710, E'IMPRENTA HIPER GRAFICA', E'persona juridica', E'', E'ISRAEL RODRIGUEZ', NULL, E'336-5670', E'311-8305', E'', NULL, E'Santa Cruz', 2, 3609, 4892);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (706, E'IMPRENTA LANDIVAR S.R.L.', E'persona juridica', E'', E'WIDEN ORTIZ', NULL, E'336-7300', E'332-6213', E'', NULL, E'Santa Cruz', 2, 3610, 4893);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (709, E'IMPRENTA SILVANA', E'persona juridica', E'', E'', NULL, E'333-2793', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4894);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (739, E' INTER SANTA CRUZ SRL', E'persona juridica', E'', E'DANIEL ZALZER CUELLAR', NULL, E'3422828', E'3420752', E'', NULL, E'Santa Cruz', 2, 3611, 4895);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (724, E'LIBERTAD AGENTES DE NEGOCIOS SRL', E'persona juridica', E'', E'MARIA CRISTINA CHAVEZ HURTADO', NULL, E'3512985', E'3530628', E'', NULL, E'Santa Cruz', 2, 3612, 4896);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (747, E'LOGITRUCK¨ S SERVICE S.R.L.', E'persona juridica', E'1012195023', E'MARCELO FIORILO ZELAYA', NULL, E'3410533', E'3410534', E'', NULL, E'Santa Cruz', 2, 3613, 4897);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (725, E'REPRESENTACIONES LITORAL', E'persona juridica', E'6.44908E+11', E'FRANKLIN MOYA', NULL, E'691-9659', E'691-9659', E'', NULL, E'Santa Cruz', 2, 3614, 4898);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (705, E'SIGNA INGENIEROS S.R.L.', E'persona juridica', E'151662024', E'JOSE LUIS BEJARANO', NULL, E'3599955', E'3599955', E'', NULL, E'Santa Cruz', 2, 3615, 4899);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (736, E'SUMINISTROS,ACCESORIOS Y EQUIPAMIENTO DE SEGURIDAD SAES S.A.', E'persona juridica', E'142319020', E'JUAN CARLOS CAREW', NULL, E'3578771', E'3578765-71639084', E'', NULL, E'Santa Cruz', 2, 3616, 4900);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (711, E'VINILCUT', E'persona juridica', E'3242474016', E'FERNANDO CHAVEZ', NULL, E'355-9378', E'355-9378', E'', NULL, E'Santa Cruz', 2, 3617, 4901);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (780, E'DISOBOL-WALTER FERNANDO SORIANO  NORIEGA', E'persona juridica', E'2815315018', E'WALTER FERNANDO SORIANO NORIEGA', NULL, E'3341781', E'3341781', E'', NULL, E'Santa Cruz', 2, 3628, 4913);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (997, E'ELVA PEREZ CHOQUE', E'persona natural', E'1372522012', E'ELVA PEREZ CHOQUE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3629, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (999, E'LEDY DIMELZA VELARDE', E'persona natural', E'6665027015', E'LEDY DIMELZA VELARDE OLGUIN', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3630, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1003, E'REINA ISABEL VILLALBA', E'persona natural', E'5651576017', E'REINA ISABEL VILLALBA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3631, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1006, E'JUAN GORENA', E'persona natural', E'', E'JUAN GORENA BARRIENTOS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3632, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (749, E'ALMACENES GRALS DE DEPOSITO ALTRASER S.A', E'persona juridica', E'1015161027', E'DAVID TERCEROS BANZER', NULL, E'3463038-3466013', E'3463934', E'', NULL, E'Santa Cruz', 2, 3633, 4914);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (755, E'CHROMATOGRAPHY SRL', E'persona juridica', E'1013591027', E'OMAR QUEZADA ROJAS', NULL, E'346-4803', E'33623212', E'', NULL, E'Santa Cruz', 2, 3634, 4915);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (765, E'INDUSERVIS', E'persona juridica', E'', NULL, NULL, E'3649818', E'3649818-77066504', E'', NULL, E'Santa Cruz', 2, NULL, 4916);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1002, E'CONSTRUCCIONES ROMERO ORTIZ', E'persona juridica', E'4132319012', E'LUCIO ROMERO ORTIZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3635, 4917);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (772, E'COPLANOS', E'persona juridica', E'', E'VERONICA RIBERA', NULL, E'336-6135', E'336.6135', E'', NULL, E'Santa Cruz', 2, 3636, 4918);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (752, E'EL BOSQUE', E'persona juridica', E'3933005012', E'', NULL, E'357-8478', E'3578478', E'', NULL, E'Santa Cruz', 2, NULL, 4919);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1005, E'ESTACION DE SERVICIO SAN JOSE OBRERO', E'persona juridica', E'', E'VICTOR EDUARDO AILLON MENDOZA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3637, 4920);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (996, E'ROQUI GAS SRL', E'persona juridica', E'121863029', E'CARLOS ELVYS CAMPOS QUIROGA', NULL, E'44701370', E'', E'', NULL, E'Trinidad', 10, 3650, 4934);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1000, E'SERVICIO GENERALES SUCUARA', E'persona juridica', E'173334025', E'JESÚS RICARDO MENDIA PARADA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3651, 4935);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (756, E'SUMITOMO - LUIS ALBERT MONTAÑO MONTOYA', E'persona juridica', E'121851023', E'LUIS ALBERT MONTAÑO MONTOYA', NULL, E'3644337', E'3644377', E'', NULL, E'Santa Cruz', 2, 3652, 4936);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (776, E'TALLERES GUILLERMO BLEIF SRL', E'persona juridica', E'', E'GUILLERMO BLEIF', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3653, 4937);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (764, E'TECNOMARG-ROLANDO ANTONIO RODRIGUEZ ARENAS', E'persona juridica', E'450778012', E'ROLANDO ANTONIO RODRIGUEZ ARENAS', NULL, E'3433756', E'2795371', E'', NULL, E'Santa Cruz', 2, 3654, 4938);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (753, E'COLHER GROUP  S.R.L.', E'persona juridica', E'163328020', NULL, NULL, E'3369090', E'3369090', E'', NULL, E'Santa Cruz', 2, NULL, 4939);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (781, E'TERMOSELLADO BOLIVIANO S.R.L.', E'persona juridica', E'1008759024', E'FELIX RODRIGUEZ SERRANO', NULL, E'4501038', E'72239773', E'', NULL, E'Santa Cruz', 2, 3655, 4940);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (783, E'ON GROUP TRANSPORTES Y REPRESENTACIONES SRL', E'persona juridica', E'162586025', E'FREDERICK ENRIQUE KELLEY GALINDO', NULL, E'3373137', E'3373147', E'', NULL, E'Santa Cruz', 2, 3656, 4941);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (784, E'RADIOTEL SRL', E'persona juridica', E'133423020', E'LUIS ALBERTO FLORES', NULL, E'351-9293', E'721-09046', E'', NULL, E'Santa Cruz', 2, 3657, 4942);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (785, E'ABENDROTH INTERNACIONAL COMERCIAL E INDUSTRIAL S.A.', E'persona juridica', E'1007035021', E'KURT GERD  ABENDROTH S.A.', NULL, E'3349096', E'33392954', E'', NULL, E'Santa Cruz', 2, 3658, 4943);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (806, E'NCD BOLIVIA S.A.', E'persona juridica', E'1026871020', E'HUMBERTO SALVADOR AVILES', NULL, E'358-8952', E'358-8828', E'', NULL, E'Santa Cruz', 2, 3668, 4952);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (808, E'DYSER SRL', E'persona juridica', E'1001853024', E'JOSE MARIA FERNANDEZ IRAHOLA', NULL, E'249-1611', E'2490749', E'', NULL, E'Santa Cruz', 2, 3669, 4953);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (809, E'MENASHE P. IMPORT- EXPORT S.R.L', E'persona juridica', E'174342020', E'MENASHE PEDRAZA SUANY  STEPHANIE', NULL, E'3273356', E'3355472', E'', NULL, E'Santa Cruz', 2, 3670, 4954);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (810, E'JN IMPORTACIONES- JOSE ANGEL ANTEZANA OLIVERA', E'persona juridica', E'4385640011', E'JOSE ANGEL ANTEZANA OLIVERA', NULL, E'348-8906', E'753-01642', E'', NULL, E'Santa Cruz', 2, 3671, 4955);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (813, E'MERCANTIL PC -  MARIA ROSARIO PAZ FIGUEROA', E'persona juridica', E'3282094016', E'MARIA ROSARIO PAZ FIGUEROA', NULL, E'3353547', E'3603185', E'', NULL, E'Santa Cruz', 2, 3672, 4956);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (815, E'TRIPLEX LTDA', E'persona juridica', E'1031083026', E'MARIA ELVA  ISABEL LANDIVAR DE FERRERO', NULL, E'3365666-3364692', E'33360072', E'', NULL, E'Santa Cruz', 2, 3673, 4957);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (816, E'HOERBIGER DE ARGENTINA S.A. SUCURSAL BOLIVIA', E'persona juridica', E'1027049024', E'JUAN ALEJANDRO BARRIOS ZERAIN', NULL, E'343-7272-343-7273', E'', E'', NULL, E'Santa Cruz', 2, 3674, 4958);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (817, E'URZACOM SRL', E'persona juridica', E'155100020', E'URIBE RIVERO IVAN NICOLAS', NULL, E'3427979', E'(591 3) 3426448', E'', NULL, E'Santa Cruz', 2, 3675, 4959);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (802, E'TSG SERVICIOS GENERALES SRL', E'persona juridica', E'146536027', E'ALBERTO  ANDRES GUTIERREZ MANSILLA', NULL, E'…', E'..', E'', NULL, E'Santa Cruz', 2, 3685, 4973);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (782, E'PROVEEDOR EVENTUAL VI', E'persona juridica', E'', NULL, NULL, E'.', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4974);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (790, E'CONTRESER LTDA', E'persona juridica', E'.', NULL, NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, NULL, 4975);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (821, E'IMPORTADORA HUAILLA S.R.L.', E'persona juridica', E'188312022', E'WILLY HUAYLLA CABEZAS', NULL, E'3435778', E'3435778', E'', NULL, E'Santa Cruz', 2, 3686, 4976);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (822, E'SINOPEC INTERNATIONAL PETROLEUM SERVICE ECUADOR S.A.( SUCURSAL BOLIVIA)', E'persona juridica', E'175184029', E'YANG CHENG', NULL, E'3415757-  3415758', E'3415757', E'', NULL, E'Santa Cruz', 2, 3687, 4977);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (823, E'HILLER S.A. COMERCIO E INDUSTRIA', E'persona juridica', E'1028693020', E'HONNEN MEYER NORBERT', NULL, E'352-2520 Y 352-6404', E'352-6404', E'', NULL, E'Santa Cruz', 2, 3688, 4978);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (824, E'EMP. COMERCIAL SEG. IND. MINERA EMCOSIM  SRL', E'persona juridica', E'1023363024', E'FELIX RODRIGUEZ SERRANO', NULL, E'4501038', E'D', E'', NULL, E'Santa Cruz', 2, 3655, 4979);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (825, E'PLUSOIL BOLIVIA SRL', E'persona juridica', E'195986021', E'ERICK JAIME GARCIA SORUCO', NULL, E'355-5800', E'70290362', E'', NULL, E'Santa Cruz', 2, 3689, 4980);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (826, E'COMTEC SRL', E'persona juridica', E'1002347027', E'ALVARO ROSENBLUTH  FERNANDEZ', NULL, E'243-1012', E'2434335', E'', NULL, E'Santa Cruz', 2, 3690, 4981);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (842, E'EDITORIAL IMPRENTA EL PAIS S.R.L.', E'persona juridica', E'120905027', E'RICARDO ROBERTO SERRANO HERBAS', NULL, E'3-334104', E'3-343996', E'', NULL, E'Santa Cruz', 2, 3702, 4992);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (845, E'CONSTRUMENT-CINTHIA SOLIZ MONTERO', E'persona juridica', E'6275937019', E'CINTHIA SOLIZ MONTERO', NULL, E'4220082', E'', E'', NULL, E'', NULL, 3703, 4993);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (847, E'COMERCIAL SALAZAR-RICARDO CHOQUEVILLCA SALAZAR', E'persona juridica', E'1149207013', E'RICARDO CHOQUEVILLCA SALAZAR', NULL, E'40714', E'.', E'', NULL, E'Chuquisaca', 6, 3704, 4994);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (848, E'CELIA LLANQUE LLANQUE DE AYAVIRI', E'persona natural', E'5659520', E'CELIA LLANQUE LLANQUE DE AYAVIRI', NULL, E'68280920', E'..', E'', NULL, E'Chuquisaca', 6, 3705, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (849, E'MUÑOZ DIAZ MAQUINARIAS S.R.L.', E'persona juridica', E'169248023', E'CESAR AUGUSTO MUÑOZ DIAZ', NULL, E'.', E'.', E'', NULL, E'Santa Cruz', 2, 3706, 4995);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (850, E'FERRETERIA 25 DE MAYO', E'persona juridica', E'4106296019', E'GUALBERTO LAZCANO', NULL, E'64-66008', E'.', E'', NULL, E'Chuquisaca', 6, 3707, 4996);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (851, E'MUNDO J.L.G.', E'persona juridica', E'5631862018', E'JOSE SANTOS UÑO F.', NULL, E'76128330', E'.', E'', NULL, E'Chuquisaca', 6, 3708, 4997);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (852, E'COMERCIAL PADILLA', E'persona juridica', E'5860953917', E'JORGE MONTES', NULL, E'5439326', E'.', E'', NULL, E'Chuquisaca', 6, 3709, 4998);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (853, E'EUGENIA SANDRA LLAVE HURTADO-COMERCIAL SANDRA', E'persona juridica', E'1112492018', E'EUGENIA SANDRA LLAVE HUTADO', NULL, E'64-23201', E'7032570', E'', NULL, E'Chuquisaca', 6, 3710, 4999);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (864, E'SERVICIOS DE AUTOMATIZACIÓN INDUSTRIAL SAIND LTDA.', E'persona juridica', E'206796028', E'WILLAMS JESUS ZEBALLOS SALAZAR', NULL, E'79494749', E'3275318', E'', NULL, E'Santa Cruz', 2, 3722, 5014);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (865, E'JULIO CESAR ZARATE YUSGRA', E'persona natural', E'4641596012', E'JULIO CESAR ZARATE YUSGRA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3723, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (869, E'CRISPIN FLORES ROCABADO', E'persona natural', E'1821829017', E'CRISPÍN FLORES ROCABADO', NULL, E'6644699', E'', E'', NULL, E'Trinidad', 10, 3724, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (870, E'FRANCISCO PEREZ CARDOZO', E'persona natural', E'1319420016', E'FRANCISCO PEREZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3725, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (871, E'AGUSTINA QUIMAYA', E'persona natural', E'4649177019', E'AGUSTINA QUIMAYA VARGAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3726, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (874, E'MIRIAN GLADYS JARAMILLO', E'persona natural', E'4707575014', E'MIRIAN GLADYS JARAMILLO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3727, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (875, E'JUAN CASTRO VILLEGAS', E'persona natural', E'1258038018', E'JUAN CASTRO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3728, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (877, E'JOSE FERNANDO AMURRIO VIDAURRE', E'persona natural', E'4400079016', E'JOSÉ FERNANDO AMURRIO', NULL, E'4296554', E'', E'', NULL, E'Trinidad', 10, 3729, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (880, E'CARLOS JAVIER TORRICO', E'persona natural', E'3753450014', E'CARLOS TORRICO ROCHA', NULL, E'4300157', E'', E'', NULL, E'Trinidad', 10, 3730, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (884, E'MILTON  WILSON BONILLA', E'persona natural', E'7462879016', E'WILSON BONILLA MOYA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3731, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (885, E'RODOLFO RODRIGUEZ', E'persona natural', E'3977563018', E'RODOLFO RODRIGUEZ VELIZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3732, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (891, E'WILSON VILLEGAS', E'persona natural', E'1143216019', E'', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3735, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (898, E'OUTSOURCING CORPOR', E'persona juridica', E'4139222010', E'SANDRO SIMON ALVARADO ROMERO', NULL, E'6630949', E'', E'', NULL, E'Trinidad', 10, 3760, 5028);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (908, E'PAQUIAS  RESTAURANT', E'persona juridica', E'4482226010', E'JENNY ALISON ALVARADO LOPEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3761, 5029);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (897, E'REA MOTORS', E'persona juridica', E'239960011', E'MARCIAL REA GODOY', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3763, 5030);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (887, E'RESTAURANT 16 DE JULIO', E'persona juridica', E'233248011', E'YOLANDA CRESPO DE SANJINES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3764, 5031);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (899, E'RESTAURANT CUCCINA', E'persona juridica', E'2365093011', E'ALFREDO CABALLERO ARAMAYO', NULL, E'6943486', E'', E'', NULL, E'Trinidad', 10, 3765, 5032);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (902, E'SERVICIO AUTOMOTRIZ S.O.S.', E'persona juridica', E'2720674019', E'ROLANDO RAUL MENDIETA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3766, 5033);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (905, E'SERVINUT LTDA', E'persona juridica', E'146412029', E'MIRIAN JUANA MENDOZA ORDÓÑEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3767, 5034);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (883, E'SNACK ROBERTO FORTUN', E'persona juridica', E'3650694014', E'ROBERTO FORTUN CASTRO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3768, 5035);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (873, E'TIMBOY RESTAURANT', E'persona juridica', E'1106567014', E'GILDA SORAYA ZAMBRANA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3769, 5036);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (913, E'ELEODORO AMORRAGA', E'persona natural', E'613496617', E'ELEODORO AMORRAGA ALARCÓN', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3770, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (920, E'GRUPO INTEGRAL PRIVADO DE SEGURIDAD   GIPS', E'persona juridica', E'820540019', E'JHONNY FERNANDO BURGOA ARZABE', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3792, 5045);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (942, E'INPESER S.R.L.', E'persona juridica', E'164872023', E'EIDA AYALA BARBA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3793, 5046);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (924, E'INTER CLEAN SRL', E'persona juridica', E'148892027', E'CARLOS RAMIRO MENDOZA RADA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3794, 5047);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (938, E'LEGAL S. C.', E'persona juridica', E'3143557', E'', NULL, E'4529592', E'44529592', E'', NULL, E'Trinidad', 10, NULL, 5048);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (918, E'LHS WOLRDWIDE SRL', E'persona juridica', E'1003813029', E'JOSÉ ANTONIO BLANCO FLORES', NULL, E'2431077', E'2444243', E'', NULL, E'Trinidad', 10, 3795, 5049);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (932, E'MULTISERVICIOS EL CEIBO', E'persona juridica', E'5787619010', E'FERNADO GAITE DÍAZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3796, 5050);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (928, E'MUNDO MOTORS', E'persona juridica', E'155966028', E'JAIME OMAR VACA MORALES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3797, 5051);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (946, E'NEWREST BOLIVIA SOPORTE S.R.L.', E'persona juridica', E'156330025', E'JOSÉ MIGUEL NOTARIO ARECHAVALETA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3798, 5052);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (927, E'NUTRIDIETA', E'persona juridica', E'5865807011', E'CARLA DANIELA BLADÉS VALLEJO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3799, 5053);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (947, E'PROLIMPIO', E'persona juridica', E'1017597029', E'ANA ELISABETH ROJAS ROJAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3800, 5054);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (956, E'ESTACION DE SERVICIO SEÑOR DE LA VERA CRUZ', E'persona juridica', E'1155290017', E'ORLANDO CAREAGA MOLINA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3828, 5067);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (977, E'FLAMAGAS S.A.', E'persona juridica', E'1015431028', E'FERNANDO PEREIRA MONTES', NULL, E'33564541', E'33564544', E'', NULL, E'Trinidad', 10, 3829, 5068);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (968, E'VICENTA ROJAS', E'persona natural', E'5635497018', E'VICENTA ROJAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3820, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (969, E'WILIAN CONDORI TORREZ', E'persona natural', E'5538512013', E'WILIAN CONDORI TORREZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3821, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (973, E'INÉS FANNY MICHEL RODRIGUEZ', E'persona natural', E'3702568011', E'INÉS FANNY MICHEL RODRIGUEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3822, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (978, E'RONALD JHONNY RAMIREZ CALVETTY', E'persona natural', E'8578268011', E'RONALD JHONNY RAMIREZ CALVETTY', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3823, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3055, E'AUZTEC', E'persona juridica', E'4118808', E'CARLOS ALBERTO AUZA PAZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3824, 5063);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (975, E'COOPERATIVA ELECTRICA RIBERALTA LTDA.', E'persona juridica', E'1015781022', E'CARLOS ANTONIO NUÑEZ VELA RODRIGUEZ', NULL, E'8523375', E'8523166', E'', NULL, E'Trinidad', 10, 3825, 5064);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (960, E'ESTACION DE SERVICIO NAYLER', E'persona juridica', E'2900647011', E'ROSARIO ALCOCER DE ARCIENEGA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3826, 5065);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (965, E'ESTACION DE SERVICIO PAROTANI', E'persona juridica', E'1023071029', E'NICOLAS GÓMEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3827, 5066);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (972, E'FORTUN CONSULTORA Y SERVICIOS', E'persona juridica', E'398833013', E'RAUL FERNANDO FORTÚN DE LA QUINTANA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3830, 5069);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (976, E'MINERA MANQUIRI S.A.', E'persona juridica', E'1017233026', E'ANTONIO DE JESÚS ADAMES REYES', NULL, E'6279985', E'', E'', NULL, E'Trinidad', 10, 3831, 5070);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1032, E'EMP. DE TRANSPORTE PESADO VERA CRUZ S.R.L. (E.T.P.E.V.E.C. S.R.L.)', E'persona juridica', E'1010805022', E'LUIS EDGAR PEREIRA RODRIGUEZ', NULL, E'62-25573', E'', E'', NULL, E'Potosí', 8, 3863, 5081);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (243, E'ACEROS \\\"EL MUTUN\\\"', E'persona juridica', E'', E'', NULL, E'4-6644600', E'4-6113713', E'', NULL, E'Santa Cruz', 2, NULL, 5086);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (986, E'AMERICAN GOURMENT EVENTOS Y CONCESIONES', E'persona juridica', E'4361306015', E'GUSTAVO LOPEZ GAMARRA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3845, 5073);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3071, E'REFINERÍA ORO NEGRO S.A.', E'persona juridica', E'1012187024', E'FRANZ LINO ALURRALDE', NULL, E'33578686', E'33524317', E'', NULL, E'Trinidad', 10, 3846, 5074);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (987, E'RESTAURANT AMAZONAS', E'persona juridica', E'3602495017', E'HUGO FERNANDEZ FERNANDEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3847, 5075);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3075, E'RESTAURANT EL FOGON', E'persona juridica', E'', E'JUAN CARLOS BARRIGA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3848, 5076);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (3078, E'SANTIAGO TARDIO', E'persona juridica', E'', E'SANTIAGO TARDIO VASQUEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3849, 5077);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (992, E'SERVICIOS MECÁNICOS NEMER', E'persona juridica', E'7519917015', E'CARMEN ROSA CALVO FLORES', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3850, 5078);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (985, E'ENDE', E'persona natural', E'1023187029', E'ADOLFO PEREZ ARAMAYO', NULL, E'44530217', E'44520318', E'', NULL, E'Trinidad', 10, 3851, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1010, E'LUIS CACERES', E'persona natural', E'', E'LUIS CACERES CUETO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3852, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1012, E'JUAN CACERES', E'persona natural', E'', E'JUAN CACERES RIVERA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3853, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1013, E'JUAN IBER BARRIENTOS', E'persona natural', E'', E'JUAN IBER BARRIENTOS LARA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3854, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1014, E'ZAIDA SILVANA SUAREZ', E'persona natural', E'', E'ZAIDA SILVANA SUAREZ VARGAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3855, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1015, E'RAFAEL ROCA', E'persona natural', E'', E'RAFAEL ROCA RIVERO', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3856, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1017, E'ERLAN CARDOZO', E'persona natural', E'', E'ERLAN CARDOZO RIOJAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3857, NULL);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (683, E'ARTES ELECTRONICAS S.R.L.', E'persona juridica', E'', E'AQUILINO MORON', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3878, 5098);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (383, E'AERATION ARGENTINA S.A.', E'persona juridica', E'', E'ROBERTO B. DEROSA', NULL, E'011.541.1.4742.9559', E'011.541.1.4742.6886', E'', NULL, E'Santa Cruz', 2, 3869, 5087);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (366, E'AGIRA', E'persona juridica', E'', E'LUDWING SCHOEPFER', NULL, E'3454857', E'3454857', E'', NULL, E'Santa Cruz', 2, 3870, 5088);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (644, E'AGROPECUARIA CAMPO VERDE', E'persona juridica', E'', E'', NULL, E'3536577', E'3536577', E'', NULL, E'Santa Cruz', 2, NULL, 5089);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (876, E'AGUILAR CATERING PETROLERO', E'persona juridica', E'2340738018', E'RICARDO AGUILAR BAUTISTA', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3871, 5090);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (190, E'A & J COMPUTERS', E'persona juridica', E'', E'', NULL, E'524-8417', E'525-4323', E'', NULL, E'Santa Cruz', 2, NULL, 5091);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (702, E'ALMACEN CLHB COCHABAMBA', E'persona juridica', E'', E'ROLANDO REQUE', NULL, E'', E'', E'', NULL, E'Santa Cruz', 2, 3872, 5092);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (2, E'ALPHA SYSTEMS', E'persona juridica', E'', E'MARCO/ VICTOR HUGO', NULL, E'334-1027', E' 334-5108', E'', NULL, E'Santa Cruz', 2, 3873, 5093);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (135, E'ALVILS', E'persona juridica', E'', E'MARLON ALANES', NULL, E'358-5305', E'358-5305', E'', NULL, E'Santa Cruz', 2, 3874, 5094);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (244, E'AMERICAN EMBLEM', E'persona juridica', E'', E'GONZALO SORIA', NULL, E'3641681   360-8614', E'3641681 3640-8614', E'', NULL, E'Santa Cruz', 2, 3875, 5095);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (474, E'AMERICAN PETROLEUM SERVICES', E'persona juridica', E'', E'', NULL, E'305-477-8677', E'305-471-0773', E'', NULL, E'Santa Cruz', 2, NULL, 5096);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (495, E'AMX LOGISTICA', E'persona juridica', E'', E'ESTEBAN ARZE DIAS', NULL, E'3416767', E'3417541', E'', NULL, E'Santa Cruz', 2, 3877, 5097);


/* Data for the 'gem.prov_aux' table  (Records 1001 - 1025) */

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (582, E'ASERRADERO PARABOL', E'persona juridica', E'1027489021', E'SERGIO DUARTE VELAZQUEZ', NULL, E'3510056 - 71041359', E'3510056', E'', NULL, E'Santa Cruz', 2, 3879, 5099);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (983, E'AIR BP BOLIVIA S.A.', E'persona juridica', E'1015497027', E'DAEN HUGO ROLANDO IPORRE MAURICE', NULL, E'33437100', E'33437200', E'', NULL, E'Trinidad', 10, 3890, 5111);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (338, E'BATEBOL LTDA', E'persona juridica', E'', E'VICTOR HUGO JIMENEZ APONTE.', NULL, E'346-1370    346-8903', E'346-3341', E'', NULL, E'Santa Cruz', 2, 3891, 5112);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (294, E'BRENNTAG BOLIVIA S.R.L.', E'persona juridica', E'', E'MADELAINE ARCE', NULL, E'385-3121', E'385-3123', E'', NULL, E'Santa Cruz', 2, 3866, 5113);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (604, E'BRIMARTEC', E'persona juridica', E'', E'BRISSA PANIAGUA CABRERA', NULL, E'70827962', E'', E'', NULL, E'Santa Cruz', 2, 3892, 5114);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (935, E'CARROÁS SERVICE', E'persona juridica', E'1119973012', E'JOSÉ DANIEL SOLARES SANCHEZ', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3893, 5115);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (958, E'CENTRO INTEGRAL DE FUMIGACIONES Y JARDINERIA- SOLUCION', E'persona juridica', E'1593353019', E'CARMELO SOLETO PALACIOS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3894, 5116);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (208, E'CIENSA LTDA', E'persona juridica', E'1023117021', E'VICTOR HUGO ANTEZANA', NULL, E'364-1783', E'346-4807', E'', NULL, E'Santa Cruz', 2, 3895, 5117);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (1025, E'COMPAÑIA BOLIVIANA DE INGENIERIA CONTRATISTAS GENERALES S. A. CBI S.A.', E'persona juridica', E'', E'GONZALO ALBORTA DE VILLEGAS', NULL, E'', E'', E'', NULL, E'Trinidad', 10, 3896, 5118);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (547, E'CONSTRUCTORA VELIZ', E'persona juridica', E'', E'HUGO OMAR VELIZ', NULL, E'72492057', E'5278604', E'', NULL, E'Santa Cruz', 2, 3897, 5119);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (862, E'DCT-BOLIVIANA-CRUZ ALAVE MARIA ZULEMA', E'persona juridica', E'4744490017', E'CRUZ ALAVE MARIA ZULEMA', NULL, E'2-2833560', E'2-2833560', E'', NULL, E'La Paz', 4, 3898, 5120);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (201, E'J & C CHROMATOGRAPHY SRL', E'persona juridica', E'1013591027', E'FERMIN GUERRERO', NULL, E'364803', E'3623212', E'', NULL, E'Santa Cruz', 2, 3906, 5132);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (79, E'MG CORPORATION SRL.', E'persona juridica', E'', E'GABRIEL MARTINEZ', NULL, E'342-8170 - 77634099', E'342-9478', E'', NULL, E'Santa Cruz', 2, 3907, 5133);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (793, E'REVESTA-AZURDUY TORREZ FABIOLA ANGELA', E'persona juridica', E'4118883012', E'FABIOLA ANGELA AZURDUY TORREZ', NULL, E'33488902', E'33488902', E'', NULL, E'Santa Cruz', 2, 3908, 5134);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (414, E'TECHSTREET SUBSCRIPTIONS', E'persona juridica', E'', E'', NULL, E'(734) 913-3930', E'(734) 913-3946', E'', NULL, E'Santa Cruz', 2, NULL, 5135);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (242, E'TEMCO INTERNATIONAL CORP', E'persona juridica', E'', E'MARI TERE SOLARES', NULL, E'1-305-234-7851', E'1-305-234-7854', E'', NULL, E'Santa Cruz', 2, 3909, 5136);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (325, E'TENARIS PIPELINE SERVICES', E'persona juridica', E'', E'RICHARD MARIACA', NULL, E'3120603', E'3120604', E'', NULL, E'Santa Cruz', 2, 3910, 5137);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (827, E'FABRICA NACIONAL DE CEMENTO  S.A.', E'persona juridica', E'1016259020', NULL, NULL, E'64-33642', E'.', E'', NULL, E'Santa Cruz', 2, NULL, 5138);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (272, E'HYROMEC', E'persona juridica', E'', E'ALBERTO ANTELO HURTADO', NULL, E'46432121', E'46432121', E'', NULL, E'Santa Cruz', 2, 3911, 5139);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (198, E'TEXACO BOLIVIA INC.', E'persona juridica', E'', E'ALEJANDRO CUELLAR DIPINTO', NULL, E'342-7979', E'344-2737', E'', NULL, E'Santa Cruz', 2, 3912, 5140);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (436, E'COMSYS COMPUTER SYSTEM', E'persona juridica', E'3170041012', NULL, NULL, E'3487723', E'3491114', E'', NULL, E'Santa Cruz', 2, NULL, 5141);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (657, E'DELTA PLUS BOLIVIA-WAISS INSUMOS INDUSTRIALES SRL', E'persona juridica', E'165262020', E'JOSE LUIS WAISS', NULL, E'', E'3571584', E'', NULL, E'Santa Cruz', 2, 3584, 5142);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (440, E'SAESSA', E'persona juridica', E'142319020', E'PABLO BERNABE RAMON CRIVELLO', NULL, E'3519387', E'3519387', E'', NULL, E'Santa Cruz', 2, 3913, 5143);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (617, E'RECOATING S.R.L.', E'persona juridica', E'157870022', NULL, NULL, E'3599456', E'3599456', E'', NULL, E'Santa Cruz', 2, NULL, 5144);

INSERT INTO gem.prov_aux ("id", "razon_social", "tipo", "nit", "responsable", "direccion", "telefono", "fax", "celular", "correo", "localidad", "id_lugar", "id_persona", "id_institucion")
VALUES (714, E'LIBRERÍA Y PAPELERIA VICTORIA-ROBERT RICHART SEJAS URQUIETA', E'persona juridica', E'', E'ROBERT SEJAS URQUIETA', NULL, E'10793446', E'455377', E'', NULL, E'Santa Cruz', 2, 3914, 5145);
/***********************************F-DAT-RCM-GEM-0-16/08/2013****************************************/