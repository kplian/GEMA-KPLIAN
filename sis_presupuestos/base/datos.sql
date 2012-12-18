/*
*	Author: Gonzalo Sarmiento Sejas
*	Date: 23/11/2012
*	Description: Build the menu definition and the composition
*/

insert into segu.tsubsistema(codigo,nombre,prefijo,nombre_carpeta) values
('PRE','Sistema de presupuesto','PRE','presupuestos');

/* (2) Menu definition */

---------
--Level 1
---------
select pxp.f_insert_tgui ('SISTEMA DE PRESUPUESTO', '', 'PRE', 'si', 1, '', 1, '', '', 'PRE');

---------
--Level 2
---------
select pxp.f_insert_tgui ('Catálogos', 'Catálogos varios', 'PRE.1', 'si', 1, '', 2, '', '', 'PRE');
select pxp.f_insert_tgui ('Presupuestos', 'Presupuestos varios', 'PRE.2', 'si', 2, '', 2, '', '', 'PRE');

---------
--Level 3
---------
select pxp.f_insert_tgui ('Partidas', 'Registro de partidas', 'PRE.1.1', 'si', 1, 'sis_presupuestos/vista/partida/Partida.php', 3, '', 'Partida', 'PRE');
select pxp.f_insert_tgui ('Presupuestos', 'Registro de presupuestos', 'PRE.2.1', 'si', 1, 'sis_presupuestos/vista/presupuesto/Presupuesto.php', 3, '', 'Presupuesto', 'PRE');

/* Composition */

---------
--Lvel 1
---------
select pxp.f_insert_testructura_gui ('PRE', 'SISTEMA');

---------
--Level 2
---------
select pxp.f_insert_testructura_gui ('PRE.1', 'PRE');
select pxp.f_insert_testructura_gui ('PRE.2', 'PRE');

---------
--Level 3
---------

select pxp.f_insert_testructura_gui ('PRE.1.1', 'PRE.1');
select pxp.f_insert_testructura_gui ('PRE.2.1', 'PRE.2');