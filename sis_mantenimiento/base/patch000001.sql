/***********************************I-SCP-JRR-GEM-1-19/11/2012****************************************/
/*
*	Author: RAC
*	Date: 11/2012
*	Description: Build the menu definition and composition
*
*	Review: RCM
*	Date: 03/11/2012
*	Description: Restructuring
*/
 
 /* (1) Table creation*/
CREATE TABLE param.tproveedor_item_servicio (  
  id_proveedor_item serial NOT NULL,
  id_proveedor integer NOT NULL,
  id_item integer,
  id_servicio integer,
  CONSTRAINT tproveedor_item_servicio_pkey PRIMARY KEY (id_proveedor_item),
  CONSTRAINT chk_tproveedor_item_servivio__id_item__id_servicio CHECK (id_item IS NULL AND id_servicio IS NOT NULL OR id_servicio IS NULL AND id_item IS NOT NULL)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE param.tproveedor_item_servicio OWNER TO postgres;

CREATE TABLE gem.ttipo_mant (
  id_tipo_mant serial NOT NULL,
  codigo character varying(20),
  nombre character varying(100),
  CONSTRAINT ttipo_mant_pkey PRIMARY KEY (id_tipo_mant)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.ttipo_mant OWNER TO postgres;

CREATE TABLE gem.tmetodologia (
  id_metodologia serial NOT NULL,
  codigo character varying(20),
  nombre character varying(100),
  CONSTRAINT tmetodologia_pkey PRIMARY KEY (id_metodologia)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tmetodologia OWNER TO postgres;

CREATE TABLE gem.tlocalizacion (
  id_localizacion SERIAL, 
  id_localizacion_fk INTEGER, 
  codigo VARCHAR(30), 
  nombre VARCHAR(150), 
  coordenadas VARCHAR(200), 
  ubicacion VARCHAR(500), 
  desc_ubicacion VARCHAR(2000), 
  latitud TEXT, 
  longitud TEXT, 
  CONSTRAINT tlocalizacion_pkey PRIMARY KEY(id_localizacion), 
  CONSTRAINT tlocalizacion_fk FOREIGN KEY (id_localizacion_fk)
    REFERENCES gem.tlocalizacion(id_localizacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tmetodologia OWNER TO postgres;
 
CREATE TABLE gem.ttipo_equipo (
  id_tipo_equipo SERIAL, 
  codigo VARCHAR(20), 
  nombre VARCHAR(200), 
  descripcion TEXT, 
  CONSTRAINT ttipo_equipo_pkey PRIMARY KEY(id_tipo_equipo), 
  CONSTRAINT ttipo_equipo_fk FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT ttipo_equipo_fk1 FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.tmetodologia OWNER TO postgres;
 
CREATE TABLE gem.tuni_cons (
  id_uni_cons SERIAL, 
  id_tipo_equipo INTEGER, 
  id_localizacion INTEGER, 
  codigo VARCHAR(20), 
  nombre VARCHAR(200), 
  tipo VARCHAR(15), 
  estado VARCHAR(20), 
  CONSTRAINT tuni_cons_pkey PRIMARY KEY(id_uni_cons), 
  CONSTRAINT tuni_cons_fk FOREIGN KEY (id_tipo_equipo)
    REFERENCES gem.ttipo_equipo(id_tipo_equipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT tuni_cons_fk1 FOREIGN KEY (id_localizacion)
    REFERENCES gem.tlocalizacion(id_localizacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT tuni_cons_fk2 FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT tuni_cons_fk3 FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.tuni_cons OWNER TO postgres;

ALTER TABLE gem.tuni_cons
  ADD COLUMN tipo_nodo VARCHAR(20);

CREATE TABLE gem.tuni_cons_comp (
  id_uni_cons_comp SERIAL, 
  id_uni_cons_hijo INTEGER NOT NULL, 
  id_uni_cons_padre INTEGER NOT NULL, 
  opcional VARCHAR(2) DEFAULT 'no'::character varying NOT NULL, 
  cantidad INTEGER, 
  CONSTRAINT tuni_cons_comp_pkey PRIMARY KEY(id_uni_cons_comp), 
  CONSTRAINT tuni_cons_comp_fk FOREIGN KEY (id_uni_cons_hijo)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT tuni_cons_comp_fk1 FOREIGN KEY (id_uni_cons_padre)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.tuni_cons_comp OWNER TO postgres;


CREATE UNIQUE INDEX ttipo_equipo_idx ON gem.ttipo_equipo
  USING btree (estado_reg, nombre);
  
CREATE TABLE gem.ttipo_variable (
  id_tipo_variable SERIAL, 
  id_tipo_equipo INTEGER, 
  id_unidad_medida INTEGER, 
  nombre VARCHAR(50), 
  descripcion VARCHAR, 
  CONSTRAINT ttipo_variable_pkey PRIMARY KEY(id_tipo_variable)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.ttipo_variable OWNER TO postgres;
  
CREATE TABLE gem.tequipo_variable (
  id_equipo_variable SERIAL, 
  id_uni_cons INTEGER, 
  id_tipo_variable INTEGER, 
  obs VARCHAR, 
  valor_min NUMERIC(18,2), 
  valor_max NUMERIC(18,2), 
  CONSTRAINT tequipo_variable_pkey PRIMARY KEY(id_equipo_variable)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
 
CREATE TABLE gem.tfalla (  
  id_falla  SERIAL NOT NULL, 
  id_tipo_equipo int4, 
  codigo varchar(20), 
  nombre varchar(250),
  obs varchar ,
  PRIMARY KEY (id_falla)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.tfalla OWNER TO postgres;

--analisis rcm fallas
CREATE TABLE gem.tfalla_evento(
	id_falla_evento  SERIAL NOT NULL, 
	id_tipo_equipo int4, 
	codigo varchar(20), 
	nombre varchar(100), 
	tipo varchar(10),
	PRIMARY KEY (id_falla_evento),
	CONSTRAINT fk_tfalla_evento__id_tipo_equipo FOREIGN KEY (id_tipo_equipo)
      REFERENCES gem.ttipo_equipo (id_tipo_equipo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT chk_tfalla_evento__tipo check (tipo in ('falla','evento'))
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);

CREATE TABLE gem.tincidente_equipo(
  id_incidente_equipo  SERIAL NOT NULL,
  id_uni_cons int4,
  id_falla_evento int4 NOT NULL,
  descripcion varchar(2000),
  fecha_desde timestamp,
  fecha_hasta timestamp,
  PRIMARY KEY (id_incidente_equipo),
  CONSTRAINT fk_tincidente_equipo__id_uni_cons FOREIGN KEY (id_uni_cons)
      REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tincidente_equipo__id_falla_evento FOREIGN KEY (id_falla_evento)
      REFERENCES gem.tfalla_evento (id_falla_evento) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tincidente_equipo OWNER TO postgres;

 

/*
Author: RCM
Date: 16:51
Content:
1) Create the table gem.tmant_predef
2) Create the table gem.tmant_predef_det
3) Create the table gem.tdocumento
4) Create the table gem.torden_trabajo
5) Adding a check constraint for table gem.torden_trabajo
*/

--
--1)
--
CREATE TABLE gem.tmant_predef (
  id_mant_predef  SERIAL NOT NULL,
  codigo varchar(20),
  nombre varchar(100),
  descripcion varchar(1000),
  PRIMARY KEY (id_mant_predef)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.tmant_predef OWNER TO postgres;

--
--2)
--
CREATE TABLE gem.tmant_predef_det (
  id_mant_predef_det  SERIAL NOT NULL,
  id_mant_predef int4,
  nombre varchar(100),
  descripcion varchar(2000),
  observacion varchar(2000),
  PRIMARY KEY (id_mant_predef_det)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
alter table gem.tmant_predef_det owner to postgres;

--
--3)
--
CREATE TABLE gem.tdocumento(
  id_documento  SERIAL NOT NULL,
  id_documento_padre int4,
  codigo varchar(40),
  nombre varchar(150),
  nombre_archivo varchar(100),
  resumen varchar(1000),
  extension varchar(10),
  palabras_clave varchar(3000),
  archivo bytea,
  PRIMARY KEY (id_documento)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.tdocumento OWNER TO postgres;

ALTER TABLE gem.tdocumento
ADD CONSTRAINT fk_tdocumento__id_documento_padre FOREIGN KEY (id_documento_padre) REFERENCES gem.tdocumento (id_documento);

--
--4)
--
CREATE TABLE gem.torden_trabajo(
  id_orden_trabajo  SERIAL NOT NULL,
  id_uni_cons_mant_predef int4,
  id_uni_cons int4 NOT NULL,
  id_tipo_mant int4 NOT NULL,
  id_unidad_medida int4 NOT NULL,
  id_funcionario_sol int4 NOT NULL,
  id_funcionario_asig int4 NOT NULL,
  fecha_plan_ini date NOT NULL,
  fecha_plan_fin date NOT NULL,
  fecha_eje_ini date,
  fecha_eje_fin date,
  descripcion varchar(5000),
  fecha_emision date,
  num_oit varchar(20),
  codigo_oit varchar(20),
  planta_estacion varchar(10),
  prioridad varchar(15),
  ubicacion_tecnica varchar(1500),
  periodicidad numeric(18, 2),
  acumulado numeric(18, 2),
  observacion varchar(5000),
  nota_tecnico_equipo varchar(1000),
  nota_tecnico_loc varchar(1000),
  PRIMARY KEY (id_orden_trabajo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.torden_trabajo OWNER TO postgres;

--
--5)
--
--alter table gem.torden_trabajo
--add constraint chk_torden_trabajo check (planta_estacion in ('planta','estacion'))

--adiciona columna en tabla uni_con para saber a partir de que plantilla se registro

ALTER TABLE gem.tuni_cons
  ADD COLUMN id_plantilla INTEGER;
 
alter table param.tproveedor
add constraint fk_tproveedor__id_lugar foreign key(id_lugar) references param.tlugar(id_lugar);

CREATE TABLE gem.tdiagrama_decision (
  id_diagrama_decision serial NOT NULL,
  id_metodologia integer,
  codigo character varying(20),
  nombre character varying(100),
  fecha_desde_validez timestamp without time zone,
  CONSTRAINT tdiagrama_decision_pkey PRIMARY KEY (id_diagrama_decision),
  CONSTRAINT fk_tdiagrama_decision__id_metodologia FOREIGN KEY (id_metodologia)
      REFERENCES gem.tmetodologia (id_metodologia) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tdiagrama_decision OWNER TO postgres;

--Diagrama de decisión
/*
CREATE TABLE gem.tdiagrama_decision(
	id_diagrama_decision  SERIAL NOT NULL, 
	id_metodologia int4, 
	codigo varchar(20), 
	nombre varchar(100), 
	fecha_desde_validez timestamp, 
	PRIMARY KEY (id_diagrama_decision),
	CONSTRAINT fk_tdiagrama_decision__id_metodologia FOREIGN KEY (id_metodologia)
      REFERENCES gem.tmetodologia (id_metodologia) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
*/

CREATE OR REPLACE VIEW param.vproveedor AS 
 SELECT provee.id_proveedor, provee.id_persona, provee.codigo, provee.numero_sigma,
 provee.tipo, provee.id_institucion, 
 pxp.f_iif(provee.id_persona IS NOT NULL, person.nombre_completo1::character varying,
 ((instit.codigo::text || '-'::text) || instit.nombre::text)::character varying) AS desc_proveedor,
 provee.nit, provee.id_lugar, lug.nombre as lugar, param.f_obtener_padre_lugar(provee.id_lugar,'pais') as pais
   FROM param.tproveedor provee
   LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
   LEFT JOIN param.tinstitucion instit ON instit.id_institucion = provee.id_institucion
   LEFT JOIN param.tlugar lug ON lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo'::text;
ALTER TABLE param.vproveedor OWNER TO postgres;

CREATE TABLE gem.tfuncionario_honorario(
  id_funcionario_honorario serial not null,
  id_tipo_horario integer,
  id_funcionario integer,
  id_moneda integer,
  costo_hora numeric(18,2),
  CONSTRAINT tfuncionario_honorario_pkey PRIMARY KEY (id_funcionario_honorario),
  CONSTRAINT fk_tfuncionario_honorario__id_tipo_horario FOREIGN KEY (id_tipo_horario)
      REFERENCES orga.ttipo_horario (id_tipo_horario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tfuncionario_honorario__id_funcionario FOREIGN KEY (id_funcionario)
      REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tfuncionario_honorario__id_moneda FOREIGN KEY (id_moneda)
      REFERENCES param.tmoneda (id_moneda) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tfuncionario_honorario OWNER TO postgres;



/*
Author: RCM
Date: 26/09/2012
Description: 
(1)Adding a relation with the Kinds of Equipment (id_tipo_equipo)
(2) Creating the view for register variable measures
*/

--(1)
alter table gem.tmant_predef
add column id_tipo_equipo integer;
alter table gem.tmant_predef
add constraint fk_tmant_predef__id_tipo_equipo foreign key (id_tipo_equipo) references gem.ttipo_equipo (id_tipo_equipo);

--(2)
CREATE TABLE gem.tequipo_medicion(
	id_equipo_medicion  SERIAL NOT NULL,
	id_equipo_variable int4,
	fecha_medicion timestamp, 
	medicion varchar(100),
	observaciones varchar(2000), 
	PRIMARY KEY (id_equipo_medicion),
	CONSTRAINT fk_tequipo_medicion__id_equipo_variable FOREIGN KEY (id_equipo_variable)
      REFERENCES gem.tequipo_variable (id_equipo_variable) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tequipo_medicion OWNER TO postgres;

alter table gem.tequipo_variable
drop column valor_min;
alter table gem.tequipo_variable
drop column valor_max;
alter table gem.tequipo_variable
add column valor_min numeric(18,2);
alter table gem.tequipo_variable
add column valor_max numeric(18,2);
  
  
--ADDING FOREIGN KEYS
alter table gem.ttipo_variable
add constraint fk_ttipo_variable__id_tipo_equipo foreign key (id_tipo_equipo)
references gem.ttipo_equipo (id_tipo_equipo);
alter table gem.ttipo_variable
add constraint fk_ttipo_variable__id_unidad_medida foreign key (id_unidad_medida)
references param.tunidad_medida (id_unidad_medida);
alter table gem.tequipo_medicion
drop column fecha_medicion;
alter table gem.tequipo_medicion
add column fecha_medicion timestamp;
alter table gem.tequipo_medicion
drop column medicion;
alter table gem.tequipo_medicion
add column medicion numeric(18,2);

--ANALIS RCM
CREATE TABLE gem.tanalisis_mant(
	id_analisis_mant  SERIAL NOT NULL,
	id_uni_cons int4, 
	id_tipo_mant int4,
	id_funcionario_rev int4, 
	fecha_emision date, 
	fecha_rev date, 
	descripcion varchar(100), 
	PRIMARY KEY (id_analisis_mant),
	CONSTRAINT fk_tanalisis_mant__id_uni_cons FOREIGN KEY (id_uni_cons)
      REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_tanalisis_mant__id_tipo_mant FOREIGN KEY (id_tipo_mant)
      REFERENCES gem.ttipo_mant (id_tipo_mant) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_tanalisis_mant__id_empleado_rev FOREIGN KEY (id_funcionario_rev)
      REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);

--ANALISIS RCM FUNCION
CREATE TABLE gem.tfuncion(
	id_funcion  SERIAL NOT NULL, 
	id_analisis_mant int4, 
	descripcion varchar(1000), 
	orden int4, 
	PRIMARY KEY (id_funcion),
	CONSTRAINT fk_tfuncion__id_analisis_mant FOREIGN KEY (id_analisis_mant)
      REFERENCES gem.tanalisis_mant (id_analisis_mant) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);

CREATE TABLE gem.tfuncion_falla(
	id_funcion_falla  SERIAL NOT NULL,
	id_funcion int4 NOT NULL,
	id_falla_evento int4 NOT NULL,
	modo_falla varchar(1000),
	efecto_falla varchar(1000),
	orden int4,
	PRIMARY KEY (id_funcion_falla),
	CONSTRAINT fk_tfuncion_falla__id_funcion FOREIGN KEY (id_funcion)
      REFERENCES gem.tfuncion (id_funcion) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_tfuncion_falla__id_falla_evento FOREIGN KEY (id_falla_evento)
      REFERENCES gem.tfalla_evento (id_falla_evento) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);


--CREACION DE TABLAS PARA CALENDARIO --
--rac 3 de noviembre


CREATE TABLE gem.tuni_cons_mant_predef (
  id_uni_cons_mant_predef SERIAL, 
  id_mant_predef INTEGER NOT NULL, 
  id_uni_cons INTEGER NOT NULL, 
  id_unidad_medida INTEGER NOT NULL, 
  frecuencia NUMERIC(18,2), 
  fecha_ini TIMESTAMP WITHOUT TIME ZONE, 
  ult_fecha_mant TIMESTAMP WITHOUT TIME ZONE, 
  CONSTRAINT tuni_cons_mant_predef_pkey PRIMARY KEY(id_uni_cons_mant_predef), 
  CONSTRAINT fk_tuni_cons_mant_predef__id_mant_predef FOREIGN KEY (id_mant_predef)
    REFERENCES gem.tmant_predef(id_mant_predef)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_tuni_cons_mant_predef__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_tuni_cons_mant_predef__id_unidad_medida FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida(id_unidad_medida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;
    
--------------- SQL ---------------

ALTER TABLE gem.tuni_cons_mant_predef
  ADD COLUMN horas_dia INTEGER;
  
 ALTER TABLE gem.tuni_cons_mant_predef
  ALTER COLUMN horas_dia SET DEFAULT 24;
    

CREATE TABLE gem.tcalendario_planificado(
    id_calendario_planificado SERIAL NOT NULL,
    id_uni_cons_mant_predef int4,
    fecha_ini date,
    fecha_fin int4,
    estado varchar(20),
    tipo varchar(25),
    observaciones varchar(1000),
    PRIMARY KEY (id_calendario_planificado))INHERITS (pxp.tbase)
    WITH OIDS;

/*

RAC
8/11/2012

modificacion de columnas tipo variable para evitar datos nulos



*/
--------------- SQL ---------------

ALTER TABLE gem.ttipo_variable
  ALTER COLUMN id_tipo_equipo SET NOT NULL;
  
--------------- SQL ---------------

ALTER TABLE gem.ttipo_variable
  ALTER COLUMN id_unidad_medida SET NOT NULL;  
  
  /*
  RAC
  08-11-2012
  */
  
 CREATE TABLE gem.tuni_cons_det(
    id_uni_cons_det SERIAL NOT NULL,
    id_unidad_medida int4,
    id_uni_cons int4,
    codigo varchar(20),
    nombre varchar(100),
    descripcion varchar(2000),
    valor varchar(2000),
    PRIMARY KEY (id_uni_cons_det))
    INHERITS (pxp.tbase)
WITH OIDS;

--------------- SQL ---------------

ALTER TABLE gem.tuni_cons_det
  ADD CONSTRAINT tuni_cons_det_id_unidad_medida_fk FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida(id_unidad_medida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

--------------- SQL ---------------

ALTER TABLE gem.tuni_cons_det
  ADD CONSTRAINT tuni_cons_det_id_uni_cons_fk FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

  
  

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

/*
*	Author: RCM
*	Date: 03/11/2012
*	Description: Register the functions and procedures
*/


/* (1) Functions*/
select pxp.f_insert_tfuncion ('gem.f_addunicon_recursivo.sql', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_equipo_variable_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_equipo_variable_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_falla_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_falla_sel', 'Funcion para tabla     ', 'GEM');

select pxp.f_insert_tfuncion ('f_localizacion_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_localizacion_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_tipo_equipo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_tipo_equipo_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_tipo_variable_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_tipo_variable_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_uni_cons_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_uni_cons_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_analisis_mant_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_analisis_mant_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_diagrama_decision_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_diagrama_decision_sel', 'Funcion para tabla     ', 'GEM');
--select pxp.f_insert_tfuncion ('ft_documento_ime', 'Funcion para tabla     ', 'GEM');
--select pxp.f_insert_tfuncion ('ft_documento_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_equipo_medicion_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_equipo_medicion_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_falla_evento_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_falla_evento_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_funcion_falla_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_funcion_falla_sel', 'Funcion para tabla     ', 'GEM');
--select pxp.f_insert_tfuncion ('ft_funcion_sel', 'Funcion para tabla     ', 'GEM');
--select pxp.f_insert_tfuncion ('ft_funcion_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_funcionario_honorario_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_funcionario_honorario_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_mant_predef_det_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_mant_predef_det_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_mant_predef_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_mant_predef_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_orden_trabajo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('ft_orden_trabajo_sel', 'Funcion para tabla     ', 'GEM');

/* (2) Procedures*/


select pxp.f_insert_tprocedimiento ('GEM_loc_INS', '	Insercion de registros
 	', 'si', '', '', 'f_localizacion_ime');
select pxp.f_insert_tprocedimiento ('GEM_loc_MOD', '	Modificacion de registros
 	', 'si', '', '', 'f_localizacion_ime');
select pxp.f_insert_tprocedimiento ('GEM_loc_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'f_localizacion_ime');
select pxp.f_insert_tprocedimiento ('GEM_loc_SEL', '	Consulta de datos
 	', 'si', '', '', 'f_localizacion_sel');
select pxp.f_insert_tprocedimiento ('GEM_loc_CONT', '	Conteo de registros
 	', 'si', '', '', 'f_localizacion_sel');
select pxp.f_insert_tprocedimiento ('GEM_LOC_ARB_SEL', '	Consulta de datos en arbol para localizaciones
 	', 'si', '', '', 'f_localizacion_sel');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_INS', '	Insercion de registros
 	', 'si', '', '', 'f_tipo_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_MOD', '	Modificacion de registros
 	', 'si', '', '', 'f_tipo_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'f_tipo_equipo_ime');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_SEL', '	Consulta de datos
 	', 'si', '', '', 'f_tipo_equipo_sel');
select pxp.f_insert_tprocedimiento ('GEM_TEQ_CONT', '	Conteo de registros
 	', 'si', '', '', 'f_tipo_equipo_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUC_INS', '	La interfaz funciona para TUC y UC
                    Insercion de Tipos de Unidades contructivas en estado borrador 
                    Inerta Unidad Contructivas
 	', 'si', '', '', 'f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUC_MOD', '	Modificacion de registros
 	', 'si', '', '', 'f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUCESTBL_MOD', '	Bloquea y Desbloquea, solo se utiliza para el tuc tipo raiz
 	', 'si', '', '', 'f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUC_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'f_uni_cons_ime');
select pxp.f_insert_tprocedimiento ('GEM_TUC_SEL', '	Consulta de datos
 	', 'si', '', '', 'f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TUC_CONT', '	Conteo de registros
 	', 'si', '', '', 'f_uni_cons_sel');
select pxp.f_insert_tprocedimiento ('GEM_TVA_INS', '	Insercion de registros
 	', 'si', '', '', 'f_tipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_TVA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'f_tipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_TVA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'f_tipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQV_SEL', '	Consulta de datos
 	', 'si', '', '', 'f_equipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQV_CONT', '	Conteo de registros
 	', 'si', '', '', 'f_equipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GEM_TVA_SEL', '	Consulta de datos
 	', 'si', '', '', 'f_tipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GEM_TVA_CONT', '	Conteo de registros
 	', 'si', '', '', 'f_tipo_variable_sel');
select pxp.f_insert_tprocedimiento ('GEM_EQV_INS', '	Insercion de registros
 	', 'si', '', '', 'f_equipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQV_MOD', '	Modificacion de registros
 	', 'si', '', '', 'f_equipo_variable_ime');
select pxp.f_insert_tprocedimiento ('GEM_EQV_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'f_equipo_variable_ime');

 
 CREATE TABLE gem.tmodo_falla (
  id_modo_falla SERIAL, 
  id_funcion_falla INTEGER, 
  modo_falla VARCHAR(1000), 
  efecto_falla VARCHAR(1000), 
  orden INTEGER, 
  CONSTRAINT tmodo_falla_pkey PRIMARY KEY(id_modo_falla), 
  CONSTRAINT fk_tmodo_falla__id_funcion_falla FOREIGN KEY (id_funcion_falla)
    REFERENCES gem.tfuncion_falla(id_funcion_falla)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tmodo_falla OWNER TO postgres;
	
 CREATE TABLE gem.tplan_mant (
  id_plan_mant SERIAL, 
  id_uni_cons INTEGER, 
  id_tipo_mant INTEGER, 
  id_funcionario INTEGER, 
  id_funcionario_rev INTEGER, 
  fecha TIMESTAMP WITHOUT TIME ZONE, 
  descripcion VARCHAR(500), 
  CONSTRAINT tplan_mant_pkey PRIMARY KEY(id_plan_mant), 
  CONSTRAINT fk_tplan_mant__id_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_tplan_mant__id_funcionario_rev FOREIGN KEY (id_funcionario_rev)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_tplan_mant__id_tipo_mant FOREIGN KEY (id_tipo_mant)
    REFERENCES gem.ttipo_mant(id_tipo_mant)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_tplan_mant__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tplan_mant OWNER TO postgres;

CREATE TABLE gem.ttarea (
  id_tarea SERIAL, 
  id_plan_mant INTEGER, 
  id_falla_evento INTEGER, 
  id_uni_cons INTEGER NOT NULL, 
  id_uni_cons_hijo INTEGER NOT NULL, 
  id_modo_falla INTEGER, 
  id_especialidad INTEGER, 
  id_unidad_medida INTEGER, 
  tareas VARCHAR(1000), 
  frecuencia NUMERIC(18,2), 
  col_h VARCHAR(2), 
  col_s VARCHAR(2), 
  col_o VARCHAR(2), 
  col_n VARCHAR(2), 
  col_hson1 VARCHAR(2), 
  col_hson2 VARCHAR(2), 
  col_hson3 VARCHAR(2), 
  col_h4 VARCHAR(2), 
  col_h5 VARCHAR(2), 
  col_s4 VARCHAR(2), 
  CONSTRAINT ttarea_pkey PRIMARY KEY(id_tarea), 
  CONSTRAINT fk_ttarea__id_falla_evento FOREIGN KEY (id_falla_evento)
    REFERENCES gem.tfalla_evento(id_falla_evento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_ttarea__id_modo_falla FOREIGN KEY (id_modo_falla)
    REFERENCES gem.tmodo_falla(id_modo_falla)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_ttarea__id_plan_mant FOREIGN KEY (id_plan_mant)
    REFERENCES gem.tplan_mant(id_plan_mant)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_ttarea__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_ttarea__id_uni_cons_hijo FOREIGN KEY (id_uni_cons_hijo)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_ttarea__id_unidad_medida FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida(id_unidad_medida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.ttarea OWNER TO postgres;

CREATE TABLE gem.tuni_cons_archivo (
  id_uni_cons_archivo SERIAL, 
  id_uni_cons_archivo_padre INTEGER, 
  nombre VARCHAR(150), 
  nombre_archivo VARCHAR(100), 
  resumen VARCHAR(1000), 
  extension VARCHAR(10), 
  palabras_clave VARCHAR(3000), 
  codigo VARCHAR(40), 
  archivo BYTEA, 
  tipo VARCHAR(10) DEFAULT 'padre'::character varying, 
  CONSTRAINT tuni_cons_archivo_pkey PRIMARY KEY(id_uni_cons_archivo), 
  CONSTRAINT fk_tuni_cos_archivo__id_uni_cons_archivo_padre FOREIGN KEY (id_uni_cons_archivo_padre)
    REFERENCES gem.tuni_cons_archivo(id_uni_cons_archivo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tuni_cons_archivo OWNER TO postgres;

CREATE TABLE gem.tuni_cons_proveedor (
  id_uni_cons_proveedor SERIAL, 
  id_uni_cons INTEGER, 
  id_proveedor INTEGER, 
  CONSTRAINT tuni_cons_proveedor_pkey PRIMARY KEY(id_uni_cons_proveedor), 
  CONSTRAINT chk_tuni_cons_item__estado_reg CHECK ((estado_reg)::text = ANY ((ARRAY['activo'::character varying, 'inactivo'::character varying])::text[])), 
  CONSTRAINT fk_tuni_cons_item__id_proveedor FOREIGN KEY (id_proveedor)
    REFERENCES param.tproveedor(id_proveedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_tuni_cons_proveedor__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tuni_cons_proveedor OWNER TO postgres;

CREATE TABLE gem.tuni_cons_item (
  id_uni_cons_item SERIAL, 
  id_uni_cons INTEGER, 
  id_item INTEGER,
  CONSTRAINT tuni_cons_item_pkey PRIMARY KEY(id_uni_cons_item),
    CONSTRAINT chk_tuni_cons_item__estado_reg CHECK ((estado_reg)::text = ANY ((ARRAY['activo'::character varying, 'inactivo'::character varying])::text[]))
) INHERITS (pxp.tbase)
WITH OIDS;

ALTER TABLE gem.tuni_cons_item ADD
  CONSTRAINT fk_tuni_cons_item__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
 ADD CONSTRAINT fk_tuni_cons_item__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
ALTER TABLE gem.tuni_cons_item OWNER TO postgres;

ALTER TABLE gem.tdocumento
ADD COLUMN tipo VARCHAR(10) DEFAULT 'padre'::character varying;

  
--------------- SQL ---------------

ALTER TABLE gem.tequipo_medicion
  ALTER COLUMN fecha_medicion TYPE DATE;  


CREATE TABLE gem.tactividad (
  id_actividad  SERIAL NOT NULL,
  id_orden_trabajo integer,
  id_usuario_resp integer,
  estado varchar(10),
  descripcion varchar(2000),
  observaciones varchar(2000),
  fecha_plan_ini timestamp,
  fecha_plan_fin timestamp,
  fecha_eje_ini timestamp,
  fecha_eje_fin timestamp,
  CONSTRAINT tactividad__id_actividad PRIMARY KEY (id_actividad),
  CONSTRAINT fk_tactividad__id_orden_trabajo FOREIGN KEY (id_orden_trabajo)
      REFERENCES gem.torden_trabajo (id_orden_trabajo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tactividad__id_usuario_resp FOREIGN KEY (id_usuario_resp)
      REFERENCES segu.tusuario (id_usuario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tactividad OWNER TO postgres;

--Table: gem.trecurso

CREATE TABLE gem.trecurso (
  id_recurso serial NOT NULL,
  id_item integer,
  id_funcionario integer,
  id_especialidad integer,
  id_servicio integer,
  id_tarea integer,
  id_actividad integer,
  id_moneda integer,
  cantidad numeric(18,2),
  costo numeric(18,2),
  observaciones varchar(2000),
  CONSTRAINT trecurso__id_recurso PRIMARY KEY (id_recurso),
  CONSTRAINT fk_trecurso__id_item FOREIGN KEY (id_item)
      REFERENCES alm.titem (id_item) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_trecurso__id_funcionario FOREIGN KEY (id_funcionario)
      REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_trecurso__id_especialidad FOREIGN KEY (id_especialidad)
      REFERENCES orga.tespecialidad (id_especialidad) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_trecurso__id_servicio FOREIGN KEY (id_servicio)
      REFERENCES param.tservicio (id_servicio) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_trecurso__id_tarea FOREIGN KEY (id_tarea)
      REFERENCES gem.ttarea (id_tarea) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,    
  CONSTRAINT fk_trecurso__id_actividad FOREIGN KEY (id_actividad)
      REFERENCES gem.tactividad (id_actividad) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,    
  CONSTRAINT fk_trecurso__id_moneda FOREIGN KEY (id_moneda)
      REFERENCES param.tmoneda (id_moneda) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.trecurso OWNER TO postgres;


--Table; gem.tlocalizacion_usuario

CREATE TABLE gem.tlocalizacion_usuario (
  id_localizacion_usuario  SERIAL NOT NULL,
  id_localizacion integer,
  id_usuario integer,
  tipo varchar(15),
  CONSTRAINT tlocalizacion_usuario__id_localizacion_usuario PRIMARY KEY (id_localizacion_usuario),
  CONSTRAINT fk_tlocalizacion_usuario__id_localizacion FOREIGN KEY (id_localizacion)
      REFERENCES gem.tlocalizacion (id_localizacion) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tlocalizacion_usuario__id_usuario FOREIGN KEY (id_usuario)
      REFERENCES segu.tusuario (id_usuario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT chk_tlocalizacion_usuario__tipo CHECK (tipo in ('gerente','ingeniero','jefe','operador'))
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tlocalizacion_usuario OWNER TO postgres;


--Table: gem.tcentro_costo

CREATE TABLE gem.tcentro_costo (
  id_centro_costo  SERIAL NOT NULL,
  codigo varchar(20),
  descripcion varchar(200),
  tipo varchar(15),
  codigo_anh varchar(20),
  descripcion_anh varchar(100),
  CONSTRAINT tcentro_costo__id_centro_costo PRIMARY KEY (id_centro_costo)
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tcentro_costo OWNER TO postgres;


--Table: gem.tinstruc_seg

CREATE TABLE gem.tinstruc_seg (
  id_instruc_seg  SERIAL NOT NULL,
  codigo varchar(20),
  descripcion varchar(200),
  CONSTRAINT tinstruc_seg__id_instruc_seg PRIMARY KEY (id_instruc_seg)
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tinstruc_seg OWNER TO postgres;


--Adición de columna tipo gem.ttipo_mant
alter table gem.ttipo_mant
add column tipo varchar(20);
alter table gem.ttipo_mant
add constraint chk_ttipo_mant__tipo check (tipo in ('planificado','no_planificado'));

--Nuevos campos para orden de trabajo
/*
alter table gem.torden_trabajo
add column id_cat_prior integer, 
add column id_cat_estado integer,
add column id_instruc_seg integer,
add column id_cat_tipo integer;
*/
--Se aumenta campo tipo_unicons
alter table gem.tuni_cons
add column tipo_unicons varchar(15),add constraint chk_tuni_cons__tipo_unicos check (tipo_unicons in ('estacion','planta'));

alter table gem.torden_trabajo
add column id_cat_estado integer,
add column id_cat_prior integer,
add column id_cat_tipo integer,
add column id_instruc_seg integer,
add constraint fk_torden_trabajo__id_cat_estado foreign key(id_cat_estado) references param.tcatalogo(id_catalogo),
add constraint fk_torden_trabajo__id_cat_prior foreign key(id_cat_prior) references param.tcatalogo(id_catalogo),
add constraint fk_torden_trabajo__id_cat_tipo foreign key(id_cat_tipo) references param.tcatalogo(id_catalogo),
add constraint fk_torden_trabajo__id_instruc_seg foreign key(id_instruc_seg) references gem.tinstruc_seg(id_instruc_seg);

/***********************************F-SCP-JRR-GEM-1-19/11/2012****************************************/

/***********************************I-SCP-RAC-GEM-40-22/11/2012*****************************************/


--RAC 13 11 2012
--aumenta el campo time en la tabla de equipo_medicion

ALTER TABLE gem.tequipo_medicion
  ADD COLUMN hora TIME(0) WITHOUT TIME ZONE;

ALTER TABLE gem.tequipo_medicion
  ALTER COLUMN hora SET DEFAULT now();
  
--------------- SQL ---------------

ALTER TABLE gem.tequipo_medicion
  ALTER COLUMN fecha_medicion TYPE DATE;  
  
 ALTER TABLE gem.tequipo_variable
  ADD COLUMN tipo VARCHAR(10) DEFAULT 'numeric' NOT NULL; 


ALTER TABLE gem.tuni_cons_item
  ADD COLUMN observaciones VARCHAR(2000);


--RAC 19-11-2012
--agregar campo en la tabla  para marcar la unidades 
--que se consideran en la generacion de calendario
ALTER TABLE gem.tuni_cons
  ADD COLUMN incluir_calgen BOOLEAN DEFAULT false NOT NULL;
  
/***********************************F-SCP-RAC-GEM-40-22/11/2012*****************************************/

/***********************************I-SCP-AAO-GEM-7-22/11/2012*****************************************/
ALTER TABLE gem.tactividad
  ALTER COLUMN fecha_plan_ini TYPE DATE,
  ALTER COLUMN fecha_plan_fin TYPE DATE,
  ALTER COLUMN fecha_eje_ini TYPE DATE,
  ALTER COLUMN fecha_eje_fin TYPE DATE;
/***********************************F-SCP-AAO-GEM-7-22/11/2012*****************************************/

/***********************************I-SCP-RCM-GEM-41-23/11/2012*****************************************/
alter table gem.ttipo_variable
add column observaciones varchar(300);
/***********************************F-SCP-RCM-GEM-41-23/11/2012*****************************************/

/***********************************I-SCP-GSS-GEM-17-28/11/2012*****************************************/
create table gem.tanalisis_porque (
  id_analisis_porque serial not null,
  id_uni_cons integer,
  numero integer,
  problema varchar(2000),
  fecha timestamp,
  estado varchar(15),
  operadores varchar(1000),
  tecnicos varchar(1000),
  coordinadores varchar(1000),
  CONSTRAINT tanalisis_porque__id_analisis_porque PRIMARY KEY (id_analisis_porque),
  CONSTRAINT fk_tanalisis_porque__id_uni_cons FOREIGN KEY (id_uni_cons)
      REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)  inherits (pxp.tbase)
with (
  oids=true
);
alter table gem.tanalisis_porque owner to postgres;

create table gem.tanalisis_porque_det (
  id_analisis_porque_det serial not null,
  id_analisis_porque integer,
  porque varchar(2000),
  respuesta varchar(3000),
  solucion varchar(3000),
  CONSTRAINT tanalisis_porque_det__id_analisis_porque_det PRIMARY KEY (id_analisis_porque_det),
  CONSTRAINT fk_tanalisis_porque_det__id_analisis_porque FOREIGN KEY (id_analisis_porque)
      REFERENCES gem.tanalisis_porque (id_analisis_porque) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)  inherits (pxp.tbase)
with (
  oids=true
);
alter table gem.tanalisis_porque_det owner to postgres;

create table gem.tanalisis_porque_sol (
  id_analisis_porque_sol serial not null,
  id_analisis_porque integer,
  id_funcionario integer,
  descripcion varchar(2000),
  fecha timestamp,
  estado varchar(15),
  CONSTRAINT tanalisis_porque_sol__id_analisis_porque_sol PRIMARY KEY (id_analisis_porque_sol),
  CONSTRAINT fk_tanalisis_porque_sol__id_analisis_porque FOREIGN KEY (id_analisis_porque)
      REFERENCES gem.tanalisis_porque (id_analisis_porque) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tanalisis_porque_sol__id_funcionario FOREIGN KEY (id_funcionario)
      REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)  inherits (pxp.tbase)
with (
  oids=true
);
alter table gem.tanalisis_porque_sol owner to postgres;

CREATE TABLE gem.ttpm_tarjeta (
  id_tpm_tarjeta serial NOT NULL,
  id_localizacion integer,
  codigo varchar(15),
  revision integer,
  fecha_emision date,
  tipo varchar(100),
  CONSTRAINT pk_ttpm_tarjeta__id_tpm_tarjeta PRIMARY KEY (id_tpm_tarjeta),
  CONSTRAINT fk_ttpm_tarjeta__id_localizacion FOREIGN KEY (id_localizacion)
      REFERENCES gem.tlocalizacion (id_localizacion) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.ttpm_tarjeta OWNER TO postgres;

CREATE TABLE gem.ttpm_tarjeta_det (
  id_tpm_tarjeta_det serial NOT NULL,
  id_tpm_tarjeta integer,
  id_funcionario_detec integer,
  id_funcionario_efec integer,
  id_uni_cons integer,
  descripcion varchar(2000),
  acceso_dificil varchar(2),
  cond_inseg varchar(2),
  contaminacion varchar(2),
  falla_me varchar(2),
  falla_el varchar(2),
  falla_ist varchar(2),
  falla_ne varchar(2),
  falla_hi varchar(2),
  oportunidad_mejora varchar(500),
  fecha_coloc date,
  fecha_retiro date,
  observaciones varchar(1000),
  CONSTRAINT pk_ttpm_tarjeta_det__id_tpm_tarjeta_det PRIMARY KEY (id_tpm_tarjeta_det),
  CONSTRAINT fk_ttpm_tarjeta_det__id_tpm_tarjeta FOREIGN KEY (id_tpm_tarjeta)
      REFERENCES gem.ttpm_tarjeta (id_tpm_tarjeta) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_ttpm_tarjeta_det__id_funcionario_detec FOREIGN KEY (id_funcionario_detec)
      REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_ttpm_tarjeta_det__id_funcionario_efec FOREIGN KEY (id_funcionario_efec)
      REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_ttpm_tarjeta_det__id_uni_cons FOREIGN KEY (id_uni_cons)
      REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) 
INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.ttpm_tarjeta_det OWNER TO postgres;

/***********************************F-SCP-GSS-GEM-17-28/11/2012*****************************************/

/***********************************I-SCP-FRH-GEM-49-27/11/2012*****************************************/
ALTER TABLE gem.tfalla_evento
  ADD COLUMN descripcion VARCHAR(2000);

---------
--Level 3
---------
 
select pxp.f_insert_tgui ('Fallas/Eventos Equipos...', 'Registro de Fallas/Eventos Equipos', 'GEM.3.11', 'si', 5, 'sis_mantenimiento/vista/falla_evento/FallaEventoExterno.php', 3, '', 'FallaEventoExterno', 'GEM');

select pxp.f_insert_testructura_gui ('GEM.3.11', 'GEM.1');

/* (1) Functions */ 
select pxp.f_insert_tfuncion ('gem.ft_falla_evento_externo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('gem.ft_falla_evento_externo_sel', 'Funcion para tabla     ', 'GEM');

/* (2) Procedures*/



/***********************************F-SCP-FRH-GEM-49-27/11/2012*****************************************/

/***********************************I-SCP-RAC-GEM-60-04/12/2012*****************************************/

--------------- SQL ---------------

ALTER TABLE gem.tuni_cons
  ALTER COLUMN codigo TYPE VARCHAR(150) COLLATE pg_catalog."default";
 
 ALTER TABLE gem.torden_trabajo
  ALTER COLUMN id_tipo_mant DROP NOT NULL;
  
  ALTER TABLE gem.torden_trabajo
  ALTER COLUMN id_funcionario_sol DROP NOT NULL;
  
  ALTER TABLE gem.torden_trabajo
  ALTER COLUMN id_funcionario_asig DROP NOT NULL;
  ALTER TABLE gem.torden_trabajo
  ALTER COLUMN fecha_plan_fin DROP NOT NULL;
  
  ALTER TABLE gem.torden_trabajo
  ALTER COLUMN fecha_plan_ini DROP NOT NULL; 
  

/***********************************F-SCP-RAC-GEM-60-04/12/2012*****************************************/
  
/***********************************I-SCP-AAO-GEM-4-04/12/2012*****************************************/

--------------- SQL ---------------
ALTER TABLE gem.torden_trabajo
  DROP CONSTRAINT fk_torden_trabajo__id_cat_estado RESTRICT;

ALTER TABLE gem.torden_trabajo
  DROP CONSTRAINT fk_torden_trabajo__id_cat_prior RESTRICT;

ALTER TABLE gem.torden_trabajo
  DROP CONSTRAINT fk_torden_trabajo__id_cat_tipo RESTRICT;

--------------- SQL ---------------
  
ALTER TABLE gem.torden_trabajo
  RENAME COLUMN id_cat_estado TO cat_estado;

ALTER TABLE gem.torden_trabajo
  ALTER COLUMN cat_estado TYPE VARCHAR(50);

ALTER TABLE gem.torden_trabajo
  RENAME COLUMN id_cat_prior TO cat_prior;

ALTER TABLE gem.torden_trabajo
  ALTER COLUMN cat_prior TYPE VARCHAR(50);
    
ALTER TABLE gem.torden_trabajo
  RENAME COLUMN id_cat_tipo TO cat_tipo;

ALTER TABLE gem.torden_trabajo
  ALTER COLUMN cat_tipo TYPE VARCHAR(50);

--------------- SQL ---------------

ALTER TABLE gem.torden_trabajo
  DROP COLUMN prioridad;
   
/***********************************F-SCP-AAO-GEM-4-04/12/2012*****************************************/

/***********************************I-SCP-RCM-GEM-64-04/12/2012*****************************************/
create table gem.torden_trabajo_log(
  id_orden_trabajo_log serial not null,
  id_orden_trabajo integer,
  estado_ini varchar(30),
  estado_fin varchar(30),
  fecha timestamp default now(),
  CONSTRAINT pk_torden_trabajo_log__id_orden_trabajo_log PRIMARY KEY (id_orden_trabajo_log),
  CONSTRAINT fk_torden_trabajo_log__id_orden_trabajo FOREIGN KEY (id_orden_trabajo)
      REFERENCES gem.torden_trabajo (id_orden_trabajo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.torden_trabajo_log OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-64-04/12/2012*****************************************/

/***********************************I-SCP-RCM-GEM-0-05/12/2012*****************************************/
alter table gem.tuni_cons_mant_predef add column id_unidad_medida_estimado integer;
alter table gem.tuni_cons_mant_predef add column tiempo_estimado numeric(18,2) ;
alter table gem.tmant_predef add column id_unidad_medida_estimado integer;
alter table gem.tmant_predef add column tiempo_estimado numeric(18,2);
/***********************************F-SCP-RCM-GEM-0-05/12/2012*****************************************/


/***********************************I-SCP-RAC-GEM-60-05/12/2012*****************************************/
--------------- SQL ---------------

ALTER TABLE gem.torden_trabajo
  ADD COLUMN id_calendario_planificacion INTEGER;
  
/***********************************F-SCP-RAC-GEM-60-05/12/2012*****************************************/



/***********************************I-SCP-RCM-GEM-28-05/12/2012*****************************************/
alter table gem.tlocalizacion_usuario
drop constraint chk_tlocalizacion_usuario__tipo;
alter table gem.tlocalizacion_usuario
add constraint chk_tlocalizacion_usuario__tipo check (tipo in ('Gerente','Ingeniero','Jefe','Operador'));
--Validación para que no se repita usuario, localizacion, tipo
alter table gem.tlocalizacion_usuario
add constraint uq_tlocalizacion_usuario__id_localizacion__id_usuario__tipo unique (id_localizacion,id_usuario,tipo);
/***********************************F-SCP-RCM-GEM-28-05/12/2012*****************************************/

/***********************************I-SCP-AAO-GEM-5-05/12/2012*****************************************/
select pxp.f_insert_tgui ('Ordenes de Trabajo', 'Ordenes de Trabajo', 'GEM.2.7', 'si', 1, '', 3, '', '', 'GEM');

select pxp.f_insert_tgui ('Registro - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.1', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/RegistrarOT.php', 4, '', 'RegistrarOT', 'GEM');
select pxp.f_insert_tgui ('Ejecución - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.2', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/EjecutarOT.php', 4, '', 'EjecutarOT', 'GEM');
select pxp.f_insert_tgui ('Revisión - Orden Trabajo', 'Registro de Ordenes de Trabajo', 'GEM.2.7.3', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/RevisarOT.php', 4, '', 'RevisarOT', 'GEM');

select pxp.f_insert_testructura_gui ('GEM.2.7', 'GEM.2');

select pxp.f_insert_testructura_gui ('GEM.2.7.1', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.2.7.2', 'GEM.2.7');
select pxp.f_insert_testructura_gui ('GEM.2.7.3', 'GEM.2.7');

CREATE TRIGGER trigger_torden_trabajo AFTER INSERT OR UPDATE 
ON gem.torden_trabajo FOR EACH ROW 
EXECUTE PROCEDURE gem.f_trg_torden_trabajo();
/***********************************F-SCP-AAO-GEM-5-05/12/2012*****************************************/

/***********************************I-SCP-RAC-GEM-21.1-06/12/2012*****************************************/
--------------- SQL ---------------
ALTER TABLE gem.tcalendario_planificado
  ADD COLUMN id_alarma INTEGER;
  
  --------------- SQL ---------------

ALTER TABLE gem.torden_trabajo
  ADD COLUMN id_alarma INTEGER;
  
    
/***********************************F-SCP-RAC-GEM-21.1-06/12/2012*****************************************/

/***********************************I-SCP-RAC-GEM-21.1-10/12/2012*****************************************/
  
ALTER TABLE gem.tcalendario_planificado
  DROP COLUMN id_alarma;
  
  ALTER TABLE gem.tcalendario_planificado
  ADD COLUMN id_alarma INTEGER[];  
  
  
ALTER TABLE gem.torden_trabajo
  DROP COLUMN id_alarma;
  
  
ALTER TABLE gem.torden_trabajo
  ADD COLUMN id_alarma INTEGER[];
  
/***********************************F-SCP-RAC-GEM-21.1-10/12/2012*****************************************/

/***********************************I-SCP-AAO-GEM-69-11/12/2012*****************************************/
alter table gem.torden_trabajo
add column id_localizacion integer;
alter table gem.torden_trabajo
add column descripcion_lugar varchar(100);
alter table gem.torden_trabajo
add column id_centro_costo integer;
alter table gem.torden_trabajo
add column especialidades varchar(300);
alter table gem.torden_trabajo
add column tiempo_estimado numeric(18,2);
alter table gem.torden_trabajo
add column id_funcionario_aprob integer;
alter table gem.torden_trabajo
add column id_funcionario_recib integer;
alter table gem.torden_trabajo
add column comentarios varchar(5000);
alter table gem.torden_trabajo
add column accidentes varchar(1000);
alter table gem.torden_trabajo
add column reclamos varchar(1000);
alter table gem.torden_trabajo
add column otros varchar(1000);

ALTER TABLE gem.torden_trabajo
  DROP COLUMN periodicidad;

/***********************************F-SCP-AAO-GEM-69-11/12/2012*****************************************/

/***********************************I-SCP-RCM-GEM-73-07/12/2012*****************************************/
CREATE TABLE gem.tlocalizacion_med(
	id_localizacion_med  SERIAL NOT NULL, 
	id_localizacion int4, 
	id_uni_cons integer,
	fecha_med date,
	num_paros integer,
	tiempo_op_hrs numeric(18,2),
	tiempo_standby_hrs numeric(18,2),
	tiempo_mnp_hrs numeric(18,2),
	tiempo_mpp_hrs numeric(18,2), 
	CONSTRAINT pk_tlocalizacion_med__id_localizacion_med PRIMARY KEY (id_localizacion_med),
	CONSTRAINT fk_tlocalizacion_med__id_localizacion FOREIGN KEY (id_localizacion)
      REFERENCES gem.tlocalizacion (id_localizacion) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_tlocalizacion_med__id_uni_cons FOREIGN KEY (id_uni_cons)
      REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tlocalizacion_med OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-73-07/12/2012*****************************************/
