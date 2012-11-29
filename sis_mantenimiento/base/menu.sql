/*
*	Author: RCM
*	Date: 03/11/2012
*	Description: Build the menu definition and the composition
*/


/* (1) Menu definition*/

---------
--Level 1
---------
select pxp.f_insert_tgui ('GESTIÓN DE MANTENIMIENTO - PLANTAS Y ESTACIONES', '', 'GEM', 'si', 1, '', 1, '', '', 'GEM');

---------
--Level 2
---------
select pxp.f_insert_tgui ('Catálogos', 'catalogos', 'GEM.1', 'si', 2, '', 1, '', '', 'GEM');
select pxp.f_insert_tgui ('Equipos, Planificación y Seguimiento', 'Datos detallados de los equipos y Planificación del Mantenimiento', 'GEM.2', 'si', 2, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('Documentación', 'Archivos, Procedimientos , Instructivos, etc.', 'GEM.3', 'si', 2, '', 3, '', '', 'GEM');

---------
--Level 3
---------
select pxp.f_insert_tgui ('Proveedores', 'Registro de Proveedores', 'GEM.1.1', 'si', 3, 'sis_matenimiento/vista/proveedor/Proveedor.php', 1, '', 'Proveedor', 'GEM');
select pxp.f_insert_tgui ('Metodologías', 'Registro de Metodologías', 'GEM.1.2', 'si', 3, 'sis_mantenimiento/vista/metodologia/Metodologia.php', 2, '', 'Meotodologia', 'GEM');
select pxp.f_insert_tgui ('Tipos de Equipos', 'Registro de Tipos de Equipos', 'GEM.1.3', 'si', 3, 'sis_mantenimiento/vista/tipo_equipo/TipoEquipo.php', 3, '', 'TipoEquipo', 'GEM');
select pxp.f_insert_tgui ('Tipos de Mantenimiento', 'Registro de Tipos de Mantenimiento', 'GEM.1.4', 'si', 3, 'sis_mantenimiento/vista/tipo_mant/TipoMant.php', 4, '', 'TipoMant', 'GEM');
select pxp.f_insert_tgui ('Horarios', 'Registro de Horarios', 'GEM.1.5', 'si', 3, 'sis_recursos_humanos/vista/horario/Horario.php', 5, '', 'Horario', 'GEM');
select pxp.f_insert_tgui ('Niveles Especialidades Técnicas', 'Registro de los niveles de especialidades técnicas', 'GEM.1.6', 'si', 3, 'sis_recursos_humanos/vista/especialidad_nivel/EspecialidadNivel.php', 6, '', 'EspecialidadNivel', 'GEM');
select pxp.f_insert_tgui ('Especialidades Técnicas', 'Registro de especialidades técnicas', 'GEM.1.7', 'si', 3, 'sis_recursos_humanos/vista/especialidad/Especialidad.php', 7, '', 'Especialidad', 'GEM');
select pxp.f_insert_tgui ('Funcionarios', 'Registro de Funcionarios', 'GEM.1.8', 'si', 3, 'sis_recursos_humanos/vista/funcionario/Funcionario.php', 8, '', 'Funcionario', 'GEM');
select pxp.f_insert_tgui ('Diagrama de Decisión', 'Registro Diagrama de Decisión', 'GEM.1.9', 'si', 3, 'sis_mantenimiento/vista/diagrama_decision/DiagramaDecision.php', 8, '', 'DiagramaDecision', 'GEM');

select pxp.f_insert_tgui ('Localizaciones', 'Registro de Localizaciones', 'GEM.2.1', 'si', 3, 'sis_mantenimiento/vista/localizacion/Localizacion.php', 1, '', 'Localizacion', 'GEM');
select pxp.f_insert_tgui ('Plantilla de Equipos', 'Registro Plantilla de Equipos', 'GEM.2.2', 'si', 3, 'sis_mantenimiento/vista/plantilla_equipo/PlantillaEquipo.php', 2, '', 'PlantillaEquipo', 'GEM');
select pxp.f_insert_tgui ('Mantenimientos Predefinidos', 'Registro de Mantenimientos predefinidos', 'GEM.2.3', 'si', 3, 'sis_mantenimiento/vista/mant_predef/MantPredef.php', 3, '', 'MantPredef', 'GEM');
select pxp.f_insert_tgui ('Órdenes de Trabajo', 'Registro Órdenes de Trabajo', 'GEM.2.4', 'si', 3, 'sis_mantenimiento/vista/orden_trabajo/OrdenTrabajo.php', 4, '', 'OrdenTrabajo', 'GEM');
select pxp.f_insert_tgui ('Mediciones por Equipo', 'Registro de Mediciones por Equipo', 'GEM.2.5', 'si', 3, 'sis_mantenimiento/vista/equipo_medicion/EquipoMedicion.php', 5, '', 'EquipoMedicion', 'GEM');
select pxp.f_insert_tgui ('Eventos/Incidentes por Equipo', 'Registro de Eventos/Incidentes por equipo', 'GEM.2.6', 'si', 3, 'sis_mantenimiento/vista/equipo_evento/EquipoEvento.php', 6, '', 'EquipoEvento', 'GEM');

select pxp.f_insert_tgui ('Procedimientos, Instructivos ...', 'Registro de Procedimientos, Instructivos, etc.', 'GEM.3.1', 'si', 3, 'sis_mantenimiento/vista/documento/Documento.php', 3, '', 'Documento', 'GEM');
--FRH
select pxp.f_insert_tgui ('Procedimientos, Instructivos ...', 'Registro de Procedimientos, Instructivos, etc.', 'GEM.3.10', 'si', 5, 'sis_mantenimiento/vista/falla_evento/FallaEventoExterno.php', 3, '', 'FallaEventoExterno', 'GEM');
--FRH
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

select pxp.f_insert_testructura_gui ('GEM.2.1', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.2', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.3', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.4', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.5', 'GEM.2');
select pxp.f_insert_testructura_gui ('GEM.2.6', 'GEM.2');

select pxp.f_insert_testructura_gui ('GEM.3.1', 'GEM.3');