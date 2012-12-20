/***********************************I-SCP-RCM-KGE-0-10/12/2012*****************************************/
--Creación del subsistema
insert into segu.tsubsistema(codigo,nombre,prefijo,nombre_carpeta) values
('KGE','Kplian Gestión','KG','kgestion');

--Creación del menú de navegación
select pxp.f_insert_tgui ('Kplian - Gestión', '', 'KGE', 'si', 1, '', 1, '../../../lib/imagenes/gema32x32.png', '', 'KGE');
select pxp.f_insert_tgui ('Planificación y Seguimiento', 'Planificación y Seguimiento', 'KGE.1', 'si', 1, '', 2, '', '', 'KGE');
select pxp.f_insert_tgui ('Issues', 'Issues', 'KGE.1.1', 'si', 1, 'sis_kgestion/vista/issue/Issue.php', 3, '', 'Issue', 'KGE');

--Composición del menú
select pxp.f_insert_testructura_gui ('KGE', 'SISTEMA');
select pxp.f_insert_testructura_gui ('KGE.1', 'KGE');
select pxp.f_insert_testructura_gui ('KGE.1.1', 'KGE.1');

--Funciones
select pxp.f_insert_tfuncion ('ft_issue_sel', 'Funcion para tabla     ', 'KGE');
select pxp.f_insert_tfuncion ('ft_issue_ime', 'Funcion para tabla     ', 'KGE');

--Procedimientos
select pxp.f_insert_tprocedimiento ('KGE_ISSUE_INS', '	Insercion de registros', 'si', '', '', 'ft_issue_ime');
select pxp.f_insert_tprocedimiento ('KGE_ISSUE_MOD', '	Modificacion de registros', 'si', '', '', 'ft_issue_ime');
select pxp.f_insert_tprocedimiento ('KGE_ISSUE_ELI', '	Eliminacion de registros', 'si', '', '', 'ft_issue_ime');
select pxp.f_insert_tprocedimiento ('KGE_ISSUE_SEL', '	Consulta de datos', 'si', '', '', 'ft_issue_sel');
select pxp.f_insert_tprocedimiento ('KGE_ISSUE_CONT', '	Conteo de registros', 'si', '', '', 'ft_issue_sel');

--Creación de las tablas
create table kge.tissue(
    id_issue serial not null,
    nro_issue integer,
    titulo varchar(200),
    descripcion varchar(2000),
    developer varchar(100),
    labels varchar(100),
    fecha_cierre date,
    fecha_act date,
    milestone varchar(100),
    estado varchar(50),
    creador varchar(50),
    tiempo_hrs numeric(18,2),
    semana varchar(20),
    prioridad integer,
    constraint pk_tissue__id_issue primary key (id_issue)
) inherits (pxp.tbase)
 with (oids)
 /***********************************F-SCP-RCM-KGE-0-10/12/2012*****************************************/