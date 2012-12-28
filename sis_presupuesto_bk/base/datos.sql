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

insert into segu.tsubsistema(codigo,nombre,prefijo,nombre_carpeta) values
('PRE','Sistema de presupuesto','PRE','presupuestos');
	


-------------------------------------
--DEFINICION DE INTERFACES
-----------------------------------

select pxp.f_insert_tgui ('SISTEMA DE PRESUPUESTO', '', 'PRE', 'si', 1, '', 1, '', '', 'PRE');
select pxp.f_insert_tgui ('Catálogos', 'Catálogos varios', 'PRE.1', 'si', 1, '', 2, '', '', 'PRE');
select pxp.f_insert_tgui ('Presupuestos', 'Presupuestos varios', 'PRE.2', 'si', 2, '', 2, '', '', 'PRE');
select pxp.f_insert_tgui ('Partidas', 'Registro de partidas', 'PRE.1.1', 'si', 1, 'sis_presupuestos/vista/partida/Partida.php', 3, '', 'Partida', 'PRE');
select pxp.f_insert_tgui ('Presupuestos', 'Registro de presupuestos', 'PRE.2.1', 'si', 1, 'sis_presupuestos/vista/presupuesto/Presupuesto.php', 3, '', 'Presupuesto', 'PRE');

select pxp.f_insert_testructura_gui ('PRE', 'SISTEMA');
select pxp.f_insert_testructura_gui ('PRE.1', 'PRE');
select pxp.f_insert_testructura_gui ('PRE.2', 'PRE');
select pxp.f_insert_testructura_gui ('PRE.1.1', 'PRE.1');
select pxp.f_insert_testructura_gui ('PRE.2.1', 'PRE.2');

----------------------------------------------
--  DEF DE FUNCIONES
--------------------------------------------------
select pxp.f_insert_tfuncion ('pre.ft_presupuesto_ime', 'Funcion para tabla     ', 'PRE');
select pxp.f_insert_tfuncion ('pre.ft_partida_ime', 'Funcion para tabla     ', 'PRE');
select pxp.f_insert_tfuncion ('pre.ft_partida_sel', 'Funcion para tabla     ', 'PRE');
select pxp.f_insert_tfuncion ('pre.ft_presupuesto_sel', 'Funcion para tabla     ', 'PRE');
select pxp.f_insert_tfuncion ('pre.ft_presup_partida_ime', 'Funcion para tabla     ', 'PRE');
select pxp.f_insert_tfuncion ('pre.ft_presup_partida_sel', 'Funcion para tabla     ', 'PRE');



---------------------------------
--DEF DE PROCEDIMIETOS
---------------------------------



select pxp.f_insert_tprocedimiento ('PRE_PAR_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'pre.ft_partida_ime');
select pxp.f_insert_tprocedimiento ('PRE_PAR_MOD', '	Modificacion de registros
 	', 'si', '', '', 'pre.ft_partida_ime');
select pxp.f_insert_tprocedimiento ('PRE_PAR_INS', '	Insercion de registros
 	', 'si', '', '', 'pre.ft_partida_ime');
select pxp.f_insert_tprocedimiento ('PRE_PAR_CONT', '	Conteo de registros
 	', 'si', '', '', 'pre.ft_partida_sel');
select pxp.f_insert_tprocedimiento ('PRE_PAR_ARB_SEL', 'Consulta de datos
', 'si', '', '', 'pre.ft_partida_sel');
select pxp.f_insert_tprocedimiento ('PRE_PAR_SEL', '	Consulta de datos
 	', 'si', '', '', 'pre.ft_partida_sel');
select pxp.f_insert_tprocedimiento ('PRE_SALPRE_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'pre.ft_presupuesto_sel');
select pxp.f_insert_tprocedimiento ('PRE_PRE_CONT', '	Conteo de registros
 	', 'si', '', '', 'pre.ft_presupuesto_sel');
select pxp.f_insert_tprocedimiento ('PRE_PRE_SEL', '	Consulta de datos
 	', 'si', '', '', 'pre.ft_presupuesto_sel');
select pxp.f_insert_tprocedimiento ('PRE_PREPAR_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'pre.ft_presup_partida_ime');
select pxp.f_insert_tprocedimiento ('PRE_PREPAR_MOD', '	Modificacion de registros
 	', 'si', '', '', 'pre.ft_presup_partida_ime');
select pxp.f_insert_tprocedimiento ('PRE_PREPAR_INS', '	Insercion de registros
 	', 'si', '', '', 'pre.ft_presup_partida_ime');
select pxp.f_insert_tprocedimiento ('PRE_PREPAR_CONT', '	Conteo de registros
 	', 'si', '', '', 'pre.ft_presup_partida_sel');
select pxp.f_insert_tprocedimiento ('PRE_PREPAR_SEL', '	Consulta de datos
 	', 'si', '', '', 'pre.ft_presup_partida_sel');
select pxp.f_insert_tprocedimiento ('PRE_PRE_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'pre.ft_presupuesto_ime');
select pxp.f_insert_tprocedimiento ('PRE_PRE_MOD', '	Modificacion de registros
 	', 'si', '', '', 'pre.ft_presupuesto_ime');
select pxp.f_insert_tprocedimiento ('PRE_PRE_INS', '	Insercion de registros
 	', 'si', '', '', 'pre.ft_presupuesto_ime');





-------------------------------------
--DEFINICION DE OTROS DATOS
-----------------------------------



