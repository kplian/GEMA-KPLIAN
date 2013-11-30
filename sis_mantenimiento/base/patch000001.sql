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

CREATE TABLE gem.ttipo_mant (
  id_tipo_mant serial NOT NULL,
  codigo character varying(20),
  nombre character varying(100),
  CONSTRAINT pk_ttipo_mant__id_tipo_mant PRIMARY KEY (id_tipo_mant)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.ttipo_mant OWNER TO postgres;

CREATE TABLE gem.tmetodologia (
  id_metodologia serial NOT NULL,
  codigo character varying(20),
  nombre character varying(100),
  CONSTRAINT pk_tmetodologia__id_metodologia PRIMARY KEY (id_metodologia)
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
  CONSTRAINT pk_tlocalizacion__id_localizacion PRIMARY KEY(id_localizacion)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tmetodologia OWNER TO postgres;
 
CREATE TABLE gem.ttipo_equipo (
  id_tipo_equipo SERIAL, 
  codigo VARCHAR(20), 
  nombre VARCHAR(200), 
  descripcion TEXT, 
  CONSTRAINT pk_ttipo_equipo__id_tipo_equipo PRIMARY KEY(id_tipo_equipo)
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
  CONSTRAINT pk_tuni_cons__id_uni_cons PRIMARY KEY(id_uni_cons)
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
  CONSTRAINT pk_tuni_cons_comp__id_uni_cons_comp PRIMARY KEY(id_uni_cons_comp)
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
  CONSTRAINT pk_ttipo_variable__id_tipo_variable PRIMARY KEY(id_tipo_variable)
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
  CONSTRAINT pk_tequipo_variable__id_equipo_variable PRIMARY KEY(id_equipo_variable)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
 
CREATE TABLE gem.tfalla (  
  id_falla  SERIAL NOT NULL, 
  id_tipo_equipo int4, 
  codigo varchar(20), 
  nombre varchar(250),
  obs varchar ,
  CONSTRAINT pk_tfalla__id_falla PRIMARY KEY (id_falla)
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
	CONSTRAINT pk_tfalla_evento__id_falla_evento PRIMARY KEY (id_falla_evento),
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
  CONSTRAINT pk_tincidente_equipo__id_incidente_equipo PRIMARY KEY (id_incidente_equipo)
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
  CONSTRAINT pk_tmant_predef__id_mant_predef PRIMARY KEY (id_mant_predef)
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
  CONSTRAINT pk_tmant_predef_det__id_mant_predef_det PRIMARY KEY (id_mant_predef_det)
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
  CONSTRAINT pk_tdocumento__id_documento PRIMARY KEY (id_documento)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
ALTER TABLE gem.tdocumento OWNER TO postgres;

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
  CONSTRAINT pk_torden_trabajo__id_orden_trabajo PRIMARY KEY (id_orden_trabajo)
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
 
CREATE TABLE gem.tdiagrama_decision (
  id_diagrama_decision serial NOT NULL,
  id_metodologia integer,
  codigo character varying(20),
  nombre character varying(100),
  fecha_desde_validez timestamp without time zone,
  CONSTRAINT pk_tdiagrama_decision__id_diagrama_decision PRIMARY KEY (id_diagrama_decision)
)
INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tdiagrama_decision OWNER TO postgres;

CREATE TABLE gem.tfuncionario_honorario(
  id_funcionario_honorario serial not null,
  id_tipo_horario integer,
  id_funcionario integer,
  id_moneda integer,
  costo_hora numeric(18,2),
  CONSTRAINT pk_tfuncionario_honorario__funcionario_honorario PRIMARY KEY (id_funcionario_honorario)
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

--(2)
CREATE TABLE gem.tequipo_medicion(
	id_equipo_medicion  SERIAL NOT NULL,
	id_equipo_variable int4,
	fecha_medicion timestamp, 
	medicion varchar(100),
	observaciones varchar(2000), 
	CONSTRAINT pk_tequipo_medicion__id_equipo_medicion PRIMARY KEY (id_equipo_medicion)
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
	CONSTRAINT pk_tanalisis_mant__id_analisis_mant PRIMARY KEY (id_analisis_mant)
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
	CONSTRAINT pk_tfuncion__id_funcion PRIMARY KEY (id_funcion)
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
	CONSTRAINT pk_tfuncion_falla__id_funcion_falla PRIMARY KEY (id_funcion_falla)
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
  CONSTRAINT tuni_cons_mant_predef_pkey PRIMARY KEY(id_uni_cons_mant_predef)
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
    CONSTRAINT pk_tcalendario_planificado__id_calendario_planificado PRIMARY KEY (id_calendario_planificado)
)INHERITS (pxp.tbase)
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
    CONSTRAINT pk_tuni_cons_det__id_uni_cons_det PRIMARY KEY (id_uni_cons_det)
) INHERITS (pxp.tbase)
WITH OIDS;
 
CREATE TABLE gem.tmodo_falla (
  id_modo_falla SERIAL, 
  id_funcion_falla INTEGER, 
  modo_falla VARCHAR(1000), 
  efecto_falla VARCHAR(1000), 
  orden INTEGER, 
  CONSTRAINT pk_tmodo_falla__id_modo_falla PRIMARY KEY(id_modo_falla)
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
  CONSTRAINT pk_tplan_mant__id_plan_mant PRIMARY KEY(id_plan_mant)
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
  CONSTRAINT pk_ttarea__id_tarea PRIMARY KEY(id_tarea)
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
  CONSTRAINT pk_tuni_cons_archivo__id_uni_cons_archivo PRIMARY KEY(id_uni_cons_archivo)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tuni_cons_archivo OWNER TO postgres;

CREATE TABLE gem.tuni_cons_proveedor (
  id_uni_cons_proveedor SERIAL, 
  id_uni_cons INTEGER, 
  id_proveedor INTEGER, 
  CONSTRAINT pk_tuni_cons_proveedor__id_uni_cons_proveedor PRIMARY KEY(id_uni_cons_proveedor), 
  CONSTRAINT chk_tuni_cons_item__estado_reg CHECK ((estado_reg)::text = ANY ((ARRAY['activo'::character varying, 'inactivo'::character varying])::text[]))
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tuni_cons_proveedor OWNER TO postgres;

CREATE TABLE gem.tuni_cons_item (
  id_uni_cons_item SERIAL, 
  id_uni_cons INTEGER, 
  id_item INTEGER,
  CONSTRAINT pk_tuni_cons_item__id_uni_cons_item PRIMARY KEY(id_uni_cons_item),
  CONSTRAINT chk_tuni_cons_item__estado_reg CHECK ((estado_reg)::text = ANY ((ARRAY['activo'::character varying, 'inactivo'::character varying])::text[]))
) INHERITS (pxp.tbase)
WITH OIDS;
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
  CONSTRAINT pk_tactividad__id_actividad PRIMARY KEY (id_actividad)
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
  CONSTRAINT pk_trecurso__id_recurso PRIMARY KEY (id_recurso)
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
  CONSTRAINT pk_tlocalizacion_usuario__id_localizacion_usuario PRIMARY KEY (id_localizacion_usuario),
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
  CONSTRAINT pk_tcentro_costo__id_centro_costo PRIMARY KEY (id_centro_costo)
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
  CONSTRAINT pk_tinstruc_seg__id_instruc_seg PRIMARY KEY (id_instruc_seg)
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
add column tipo_unicons varchar(15);

alter table gem.tuni_cons
add constraint chk_tuni_cons__tipo_unicos check (tipo_unicons in ('estacion','planta'));

alter table gem.torden_trabajo
add column id_cat_estado integer;

alter table gem.torden_trabajo
add column id_cat_prior integer;

alter table gem.torden_trabajo
add column id_cat_tipo integer;

alter table gem.torden_trabajo
add column id_instruc_seg integer;


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
  ALTER COLUMN fecha_plan_ini TYPE DATE;

ALTER TABLE gem.tactividad
  ALTER COLUMN fecha_plan_fin TYPE DATE;
  
ALTER TABLE gem.tactividad
  ALTER COLUMN fecha_eje_ini TYPE DATE;
  
ALTER TABLE gem.tactividad
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
  CONSTRAINT pk_tanalisis_porque__id_analisis_porque PRIMARY KEY (id_analisis_porque)
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
  CONSTRAINT pk_tanalisis_porque_det__id_analisis_porque_det PRIMARY KEY (id_analisis_porque_det)
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
  CONSTRAINT pk_tanalisis_porque_sol__id_analisis_porque_sol PRIMARY KEY (id_analisis_porque_sol)
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
  CONSTRAINT pk_ttpm_tarjeta__id_tpm_tarjeta PRIMARY KEY (id_tpm_tarjeta)
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
  CONSTRAINT pk_ttpm_tarjeta_det__id_tpm_tarjeta_det PRIMARY KEY (id_tpm_tarjeta_det)
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
/***********************************F-SCP-FRH-GEM-49-27/11/2012*****************************************/

/***********************************I-SCP-RAC-GEM-60-04/12/2012*****************************************/

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
  CONSTRAINT pk_torden_trabajo_log__id_orden_trabajo_log PRIMARY KEY (id_orden_trabajo_log)
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.torden_trabajo_log OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-64-04/12/2012*****************************************/

/***********************************I-SCP-RCM-GEM-0-05/12/2012*****************************************/
alter table gem.tuni_cons_mant_predef
add column id_unidad_medida_estimado integer;

alter table gem.tuni_cons_mant_predef
add column tiempo_estimado numeric(18,2);

alter table gem.tmant_predef
add column id_unidad_medida_estimado integer;

alter table gem.tmant_predef
add column tiempo_estimado numeric(18,2);
/***********************************F-SCP-RCM-GEM-0-05/12/2012*****************************************/


/***********************************I-SCP-RAC-GEM-60-05/12/2012*****************************************/

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

CREATE TRIGGER trigger_torden_trabajo AFTER INSERT OR UPDATE 
ON gem.torden_trabajo FOR EACH ROW 
EXECUTE PROCEDURE gem.f_trg_torden_trabajo();
/***********************************F-SCP-AAO-GEM-5-05/12/2012*****************************************/

/***********************************I-SCP-RAC-GEM-21.1-06/12/2012*****************************************/
ALTER TABLE gem.tcalendario_planificado
  ADD COLUMN id_alarma INTEGER;
  
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
	CONSTRAINT pk_tlocalizacion_med__id_localizacion_med PRIMARY KEY (id_localizacion_med)
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tlocalizacion_med OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-73-07/12/2012*****************************************/

/***********************************I-SCP-AAO-GEM-69-13/12/2012*****************************************/
ALTER TABLE gem.torden_trabajo
  DROP COLUMN fecha_plan_fin;
  
ALTER TABLE gem.torden_trabajo
  DROP COLUMN planta_estacion;
/***********************************F-SCP-AAO-GEM-69-13/12/2012*****************************************/


/***********************************I-SCP-RAC-GEM-x-14/12/2012*****************************************/

--para aumentar filtro de usuarios autorizados
ALTER TABLE gem.tuni_cons
  ADD COLUMN id_usuarios INTEGER[];
  
  
/***********************************F-SCP-RAC-GEM-x-14/12/2012*****************************************/

/***********************************I-SCP-RCM-GEM-76-14/12/2012*****************************************/
CREATE TABLE gem.tdiagrama_decision_accion(
  id_diagrama_decision_accion  SERIAL NOT NULL,
  id_diagrama_decision int4,
  id_diagrama_decision_accion_fk int4,
  tipo varchar(15),
  codigo varchar(20),
  nombre varchar(200),
  CONSTRAINT pk_tdiagrama_decision_accion__id_diagrama_decision_accion PRIMARY KEY (id_diagrama_decision_accion)
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tdiagrama_decision_accion OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-76-14/12/2012*****************************************/

/***********************************I-SCP-AAO-GEM-82-18/12/2012*****************************************/
ALTER TABLE gem.trecurso
  ADD COLUMN id_unidad_medida INTEGER;

ALTER TABLE gem.trecurso
  ADD COLUMN hh_normal INTEGER;
  
ALTER TABLE gem.trecurso
  ADD COLUMN hh_extras INTEGER;
  
ALTER TABLE gem.trecurso
  ADD COLUMN hh_ext_mov INTEGER;
  
ALTER TABLE gem.torden_trabajo
  ADD COLUMN hora_eje_inicio TIME(0) WITHOUT TIME ZONE;
  
ALTER TABLE gem.torden_trabajo
  ADD COLUMN hora_eje_fin TIME(0) WITHOUT TIME ZONE;

/***********************************F-SCP-AAO-GEM-82-18/12/2012*****************************************/

/***********************************I-SCP-AAO-GEM-82-20/12/2012*****************************************/
ALTER TABLE gem.trecurso
  ADD COLUMN codigo VARCHAR(30);

ALTER TABLE gem.trecurso
  ADD COLUMN existencias VARCHAR(100);
/***********************************F-SCP-AAO-GEM-82-20/12/2012*****************************************/

/***********************************I-SCP-AAO-GEM-89-21/12/2012*****************************************/

ALTER TABLE gem.tuni_cons
  ADD COLUMN herramientas_especiales VARCHAR(1000);
  
ALTER TABLE gem.tuni_cons
  ADD COLUMN otros_datos_tec VARCHAR(1000);

CREATE TABLE gem.tuni_cons_doc_tec (
  id_documento_tec SERIAL,
  id_uni_cons INTEGER,
  nombre_documento VARCHAR(50), 
  adjunto BOOLEAN, 
  codigo VARCHAR(25), 
  observaciones VARCHAR(1000), 
  CONSTRAINT pk_tuni_cons_doc_tec__id_documento_tec PRIMARY KEY(id_documento_tec)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE gem.tuni_cons_doc_tec
  OWNER TO postgres;

/***********************************F-SCP-AAO-GEM-89-21/12/2012*****************************************/

/***********************************I-SCP-AAO-GEM-65-21/12/2012*****************************************/
ALTER TABLE gem.tuni_cons
  ADD COLUMN funcion VARCHAR(200);
  
ALTER TABLE gem.tuni_cons
  ADD COLUMN punto_recepcion_despacho VARCHAR(100);

/***********************************F-SCP-AAO-GEM-65-21/12/2012*****************************************/

/***********************************I-SCP-RCM-GEM-65-29/12/2012*****************************************/
-- Table: gem.torden_trabajo_sol

-- DROP TABLE gem.torden_trabajo_sol;

CREATE TABLE gem.torden_trabajo_sol (
  id_orden_trabajo_sol serial NOT NULL,
  id_solicitante integer,
  id_uni_cons integer,
  id_localizacion integer,
  id_unidad_medida_req integer,  
  id_uo integer,
  id_responsable integer,
  id_orden_trabajo integer,
  fecha date,
  fecha_requerida date,
  observacion character varying(1000),
  descripcion character varying(1000),
  descripcion_req character varying(1000),
  cantidad_req numeric(18,2),
  inspeccion_lugar character varying(2),
  inspeccion_exacto character varying(2),
  prioridad character varying(20),
  fecha_recepcion date,
  importancia character varying(20),
  nota character varying(1000),
  estado character varying(20),
  fecha_estimada date,
  fecha_real date,
  observaciones_resp character varying(1000),
  constraint pk_torden_trabajo_sol__id_orden_trabajo_sol primary key (id_orden_trabajo_sol)
)
INHERITS (pxp.tbase)
WITH (
  OIDS=FALSE
);
ALTER TABLE gem.torden_trabajo_sol OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-65-29/12/2012*****************************************/

/***********************************I-SCP-RCM-GEM-96-11/01/2013*****************************************/

alter table gem.tlocalizacion_med
add column observaciones varchar(500);

/***********************************F-SCP-RCM-GEM-96-11/01/2013*****************************************/

/***********************************I-SCP-AAO-GEM-104-21/01/2013*****************************************/
ALTER TABLE gem.torden_trabajo
  ADD COLUMN mensaje_estado VARCHAR(250);

ALTER TABLE gem.torden_trabajo_log
  ADD COLUMN mensaje_estado VARCHAR(250);
/***********************************F-SCP-AAO-GEM-104-21/01/2013*****************************************/

/***********************************I-SCP-RCM-GEM-110-23/01/2013*****************************************/
ALTER TABLE	gem.tuni_cons_archivo
  ADD COLUMN reporte varchar(2) DEFAULT 'no';
ALTER TABLE	gem.tuni_cons_archivo
  ADD CONSTRAINT chk_tuni_cons_archivo__reporte CHECK (reporte in ('si','no'));
/***********************************F-SCP-RCM-GEM-110-23/01/2013*****************************************/

/***********************************I-SCP-AAO-GEM-109-24/01/2013*****************************************/
ALTER TABLE gem.tuni_cons_archivo
  ADD COLUMN id_uni_cons INTEGER;

ALTER TABLE gem.tuni_cons_archivo
  ADD CONSTRAINT fk_tuni_cons_archivo__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-SCP-AAO-GEM-109-24/01/2013*****************************************/

/***********************************I-SCP-RCM-GEM-116-08/02/2013*****************************************/
alter table gem.tlocalizacion_med
add column num_paros_planif integer;
/***********************************F-SCP-RCM-GEM-116-08/02/2013*****************************************/

/***********************************I-SCP-RCM-GEM-122-17/02/2013*****************************************/
create table gem.torden_trabajo_sol_insumo (  
  id_orden_trabajo_sol_insumo serial NOT NULL,
  id_orden_trabajo_sol integer NOT NULL,
  id_unidad_medida integer,
  descripcion varchar(100),
  cant_insum numeric(18,2),
  CONSTRAINT pk_torden_trabajo_sol_insumo__id_orden_trabajo_sol_insumo PRIMARY KEY (id_orden_trabajo_sol_insumo)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.torden_trabajo_sol_insumo OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-122-17/02/2013*****************************************/

/***********************************I-SCP-RCM-GEM-123-18/02/2013*****************************************/
create table gem.tlocalizacion_correl (  
  id_localizacion_correl serial NOT NULL,
  id_localizacion integer,
  gestion integer NOT NULL,
  correl integer,
  codigo_formulario varchar(20),
  CONSTRAINT pk_tlocalizacion_correl__id_localizacion_correl PRIMARY KEY (id_localizacion_correl)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tlocalizacion_correl OWNER TO postgres;

alter table gem.torden_trabajo_sol
add column nro_sol varchar(20);

alter table gem.tlocalizacion
add column tipo_numeracion varchar(20);
/***********************************F-SCP-RCM-GEM-123-18/02/2013*****************************************/

/***********************************I-SCP-RCM-GEM-124-18/02/2013*****************************************/
alter table gem.tuni_cons_item
add column id_proveedor integer;
/***********************************F-SCP-RCM-GEM-124-18/02/2013*****************************************/

/***********************************I-SCP-RCM-GEM-125-19/02/2013*****************************************/
alter table gem.torden_trabajo
add column descripcion_causa varchar(1000);
alter table gem.torden_trabajo
add column prevension varchar(1000);
/***********************************F-SCP-RCM-GEM-125-19/02/2013*****************************************/

/***********************************I-SCP-RCM-GEM-120-05/03/2013*****************************************/
alter table gem.tuni_cons
add column horas_dia integer;

alter table gem.tuni_cons
drop constraint chk_tuni_cons__tipo_unicos;

alter table gem.ttipo_variable
add constraint chk_ttipo_variable__id_tipo_equipo__nombre unique (id_tipo_equipo,nombre);

alter table gem.tequipo_medicion
add constraint uq_tequipo_medicion__id_equipo_variable__fecha_medicion__hora
unique(id_equipo_variable, fecha_medicion, hora);
/***********************************F-SCP-RCM-GEM-120-05/03/2013*****************************************/

/***********************************I-SCP-RCM-GEM-124-10/03/2013*****************************************/
ALTER TABLE gem.trecurso
  ADD COLUMN concepto VARCHAR(50);
/***********************************F-SCP-RCM-GEM-124-10/03/2013*****************************************/

/***********************************I-SCP-RCM-GEM-132-19/03/2013*****************************************/
alter table gem.tmant_predef 
add column id_tipo_mant integer;
/***********************************F-SCP-RCM-GEM-132-19/03/2013*****************************************/

/***********************************I-SCP-RCM-GEM-133-19/03/2013*****************************************/
alter table gem.torden_trabajo 
add column descripcion_progresiva varchar(500);
/***********************************F-SCP-RCM-GEM-133-19/03/2013*****************************************/

/***********************************I-SCP-RCM-GEM-134-22/03/2013*****************************************/
CREATE TABLE gem.ttipo_equipo_col (  
  id_tipo_equipo_col serial NOT NULL,
  id_tipo_equipo integer NOT NULL,
  tipo_col varchar(20),
  id varchar(50),
  orden integer,
  CONSTRAINT pk_ttipo_equipo_col___id_tipo_equipo_col PRIMARY KEY (id_tipo_equipo_col)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.ttipo_equipo_col OWNER TO postgres;

alter table gem.ttipo_variable
add column formula varchar(200);
alter table gem.ttipo_variable
add column calculo varchar(15);
/***********************************F-SCP-RCM-GEM-134-22/03/2013*****************************************/

/***********************************I-SCP-RCM-GEM-135-14/04/2013*****************************************/
CREATE TABLE gem.tinstruc_seg_det (
  id_instruc_seg_det  SERIAL NOT NULL,
  id_instruc_seg integer not null,
  nro integer,
  descripcion varchar(1000),
  CONSTRAINT pk_tinstruc_seg_det__id_instruc_seg_det PRIMARY KEY (id_instruc_seg_det)
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE gem.tinstruc_seg_det OWNER TO postgres;

CREATE TABLE gem.tcuenta (
  id_cuenta SERIAL, 
  id_cuenta_padre INTEGER, 
  nro_cuenta VARCHAR(20), 
  nombre_cuenta VARCHAR(100), 
  nivel_cuenta INTEGER, 
  CONSTRAINT pk_tcuenta__id_cuenta PRIMARY KEY(id_cuenta)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE gem.tcuenta OWNER TO postgres;

alter table gem.tdiagrama_decision_accion
alter column tipo type varchar(25); 

alter table gem.torden_trabajo
add column id_cuenta integer;
/***********************************F-SCP-RCM-GEM-135-14/04/2013*****************************************/

/***********************************I-SCP-RCM-GEM-136-26/04/2013*****************************************/
CREATE TABLE gem.tparametro (
  id_parametro SERIAL, 
  tipo_proceso varchar, 
  valor VARCHAR(50), 
  CONSTRAINT pk_tparametro__id_parametro PRIMARY KEY(id_parametro)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE gem.tparametro OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-136-26/04/2013*****************************************/

/***********************************I-SCP-RCM-GEM-137-03/05/2013*****************************************/
ALTER TABLE gem.trecurso
ADD COLUMN id_orden_trabajo integer;
/***********************************F-SCP-RCM-GEM-137-03/05/2013*****************************************/

/***********************************I-SCP-RCM-GEM-138-11/05/2013*****************************************/
alter table gem.tdocumento
add tipo_doc varchar(20);

alter table gem.tanalisis_mant
add column id_funcionario_prep integer;
/***********************************F-SCP-RCM-GEM-138-11/05/2013*****************************************/

/***********************************I-SCP-RCM-GEM-138-14/05/2013*****************************************/
alter table gem.trecurso
add column hh_fer_dom numeric(18,2);

ALTER TABLE gem.trecurso ALTER COLUMN hh_normal TYPE NUMERIC(18,2);
ALTER TABLE gem.trecurso ALTER COLUMN hh_extras TYPE NUMERIC(18,2);
ALTER TABLE gem.trecurso ALTER COLUMN hh_ext_mov TYPE NUMERIC(18,2);

/***********************************F-SCP-RCM-GEM-138-14/05/2013*****************************************/

/***********************************I-SCP-RCM-GEM-0-17/05/2013*****************************************/
alter table gem.tdocumento
add column revision varchar(10);
alter table gem.tdocumento
add column fecha_autoriz date;
ALTER TABLE gem.tfuncion_falla
  ALTER COLUMN orden TYPE VARCHAR(15);
ALTER TABLE gem.tfuncion_falla
  ADD COLUMN falla VARCHAR(100);
ALTER TABLE gem.tfuncion_falla
  ALTER COLUMN id_falla_evento DROP NOT NULL;
alter table gem.tplan_mant
add column fecha_emision date;
/***********************************F-SCP-RCM-GEM-0-17/05/2013*****************************************/

/***********************************I-SCP-RCM-GEM-0-22/05/2013*****************************************/
ALTER TABLE gem.ttarea
  ALTER COLUMN id_uni_cons_hijo DROP NOT NULL;
/***********************************F-SCP-RCM-GEM-0-22/05/2013*****************************************/

/***********************************I-SCP-RCM-GEM-0-24/05/2013*****************************************/
alter table gem.tanalisis_mant
add column id_uni_cons_hijo integer;
alter table gem.tplan_mant
add column id_uni_cons_hijo integer;
ALTER TABLE gem.tanalisis_mant
  RENAME COLUMN id_funcionario_rev TO id_persona_rev;
ALTER TABLE gem.tanalisis_mant
  RENAME COLUMN id_funcionario_prep TO id_persona_prep;

alter table gem.tanalisis_mant
add column id_uo integer;
ALTER TABLE gem.tplan_mant
  RENAME COLUMN id_funcionario TO id_persona;
ALTER TABLE gem.tplan_mant
  RENAME COLUMN id_funcionario_rev TO id_persona_rev;
alter table gem.tplan_mant
add column id_uo integer;
alter table gem.torden_trabajo_sol
add column archivo bytea;
alter table gem.torden_trabajo_sol
add column extension varchar(10);
/***********************************F-SCP-RCM-GEM-0-24/05/2013*****************************************/

/***********************************I-SCP-RCM-GEM-141-29/05/2013*****************************************/
alter table gem.torden_trabajo
add column id_mant_predef integer;
/***********************************F-SCP-RCM-GEM-141-29/05/2013*****************************************/

/***********************************I-SCP-RCM-GEM-141-30/05/2013*****************************************/
alter table gem.tuni_cons
add column ficha_tecnica varchar(2) default 'Si';
/***********************************F-SCP-RCM-GEM-141-30/05/2013*****************************************/

/***********************************I-SCP-RCM-GEM-143-04/06/2013*****************************************/
create table gem.tpresupuesto(
	id_presupuesto serial,
	codigo varchar(30),
	nombre varchar(100),
	gestion integer,
	constraint pk_tpresupuesto__id_presupuesto primary key (id_presupuesto)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tpresupuesto OWNER TO postgres;

create table gem.tpresupuesto_loc(
	id_presupuesto_loc serial,
	id_presupuesto integer,
	id_localizacion integer,
	mes varchar(20),
	monto_prog numeric(18,2),
	monto_techo numeric(18,2),
	porcen_prog_techo numeric(18,2),
	monto_presup numeric(18,2),
	monto_ejec numeric(18,2),
    constraint pk_tpresupuesto_loc__id_presupuesto_loc primary key (id_presupuesto_loc)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tpresupuesto_loc OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-143-04/06/2013*****************************************/

/***********************************I-SCP-RCM-GEM-143-07/06/2013*****************************************/
alter table gem.ttipo_variable
add column orden integer;
/***********************************F-SCP-RCM-GEM-143-07/06/2013*****************************************/

/***********************************I-SCP-RCM-GEM-143-01/07/2013*****************************************/
create table gem.tpresupuesto_localizacion(
	id_presupuesto_localizacion serial not null,
	id_presupuesto integer,
	id_localizacion integer,
	constraint pk_tpresupuesto_localizacion__id_presupuesto_localizacion primary key (id_presupuesto_localizacion)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tpresupuesto_localizacion OWNER TO postgres;

ALTER TABLE gem.tpresupuesto
  ADD UNIQUE (codigo, gestion);
  
create table gem.tpresupuesto_localizacion_usuario(
	id_presupuesto_localizacion_usuario serial not null,
	id_presupuesto_localizacion integer,
	id_usuario integer,
	constraint pk_tpresupuesto_localizacion_usuario__id_presupuesto_localizacion_usuario primary key (id_presupuesto_localizacion_usuario)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE gem.tpresupuesto_localizacion_usuario OWNER TO postgres;
/***********************************F-SCP-RCM-GEM-143-01/07/2013*****************************************/

/***********************************I-SCP-RCM-GEM-35-08/07/2013*****************************************/
alter table gem.tlocalizacion_usuario
drop constraint chk_tlocalizacion_usuario__tipo;

alter table gem.tlocalizacion_usuario
add constraint chk_tlocalizacion_usuario__tipo check (tipo in ('Gerente','Ingeniero','Jefe','Operador','Asistente'));
/***********************************F-SCP-RCM-GEM-35-08/07/2013*****************************************/

/***********************************I-SCP-RCM-GEM-0-07/08/2013*****************************************/
alter table gem.torden_trabajo
add column id_orden_trabajo_sol integer;
/***********************************F-SCP-RCM-GEM-0-07/08/2013*****************************************/

/***********************************I-SCP-RCM-GEM-0-16/08/2013*****************************************/
CREATE TABLE gem.prov_aux (
  id SERIAL, 
  razon_social VARCHAR(200), 
  tipo VARCHAR(30), 
  nit VARCHAR(30) NOT NULL, 
  responsable VARCHAR(200), 
  direccion VARCHAR(1000), 
  telefono VARCHAR(50), 
  fax VARCHAR(50), 
  celular VARCHAR(50), 
  correo VARCHAR(300), 
  localidad VARCHAR(50), 
  id_lugar INTEGER, 
  id_persona INTEGER, 
  id_institucion INTEGER, 
  CONSTRAINT prov_aux_pkey PRIMARY KEY(id)
) WITHOUT OIDS;
/***********************************F-SCP-RCM-GEM-0-16/08/2013*****************************************/

/***********************************I-SCP-RCM-GEM-0-10/10/2013*****************************************/
CREATE TABLE gem.tmant_predef_item(
  id_mant_predef_item serial not null, 
  id_mant_predef integer,
  id_item integer,
  cantidad_item numeric(18,2),
  CONSTRAINT tmant_predef_item__id_mant_predef_item PRIMARY KEY(id_mant_predef_item)
) INHERITS(pxp.tbase) 
WITHOUT OIDS;
/***********************************F-SCP-RCM-GEM-0-10/10/2013*****************************************/