
 
 /*
 
 requisitos en el esquema orga
 */
 
 CREATE TABLE orga.ttipo_horario (
  id_tipo_horario SERIAL, 
  codigo VARCHAR(255), 
  nombre VARCHAR(255), 
  estado_reg VARCHAR(10), 
  id_usuario_reg INTEGER, 
  fecha_reg DATE DEFAULT now() NOT NULL, 
  id_usuario_mod INTEGER, 
  fecha_mod DATE DEFAULT now(), 
  CONSTRAINT ttipo_horario_pkey PRIMARY KEY(id_tipo_horario)
) WITHOUT OIDS;
 
 CREATE TABLE orga.tespecialidad_nivel (
  id_especialidad_nivel SERIAL, 
  codigo VARCHAR(20) NOT NULL, 
  nombre VARCHAR(100) NOT NULL, 
  CONSTRAINT tespecialidad_nivel_pkey PRIMARY KEY(id_especialidad_nivel)
) INHERITS (pxp.tbase)
WITH OIDS;


CREATE TABLE orga.tespecialidad
(
  id_especialidad serial NOT NULL,
  codigo character varying(20) NOT NULL,
  nombre character varying(150) NOT NULL,
  id_especialidad_nivel integer,
  CONSTRAINT tespecialidad_pkey PRIMARY KEY (id_especialidad),
  CONSTRAINT fk_tespecialidad__id_especialidad_nivel FOREIGN KEY (id_especialidad_nivel)
      REFERENCES orga.tespecialidad_nivel (id_especialidad_nivel) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE orga.tespecialidad OWNER TO postgres;
 
 


CREATE TABLE orga.tfuncionario_especialidad
(
  id_funcionario_especialidad serial NOT NULL,
  id_funcionario integer NOT NULL,
  id_especialidad integer NOT NULL,
  CONSTRAINT tfuncionario_especialidad_pkey PRIMARY KEY (id_funcionario_especialidad),
  CONSTRAINT uq__id_funcionario_especialidad UNIQUE (id_funcionario, id_especialidad)
) INHERITS (pxp.tbase) WITH ( OIDS=TRUE);
ALTER TABLE orga.tfuncionario_especialidad OWNER TO postgres;




CREATE TABLE param.tproveedor_item_servicio
( id_proveedor_item serial NOT NULL,
  id_proveedor integer NOT NULL,
  id_item integer,
  id_servicio integer,
  CONSTRAINT tproveedor_item_servicio_pkey PRIMARY KEY (id_proveedor_item),
  CONSTRAINT chk_tproveedor_item_servivio__id_item__id_servicio CHECK (id_item IS NULL AND id_servicio IS NOT NULL OR id_servicio IS NULL AND id_item IS NOT NULL)
)
INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE param.tproveedor_item_servicio OWNER TO postgres;



 
 /*SISTEMA DE MANTENIMIENTO*/
 
 
 

-- Table: gem.ttipo_mant



-- DROP TABLE gem.ttipo_mant;








CREATE TABLE gem.ttipo_mant
(


-- Heredado from table tbase:  

id_usuario_reg integer,


-- Heredado from table tbase:  

id_usuario_mod integer,

-- Heredado from table tbase:  fecha_reg timestamp without time zone DEFAULT now(),


-- Heredado from table tbase:  fecha_mod timestamp without time zone DEFAULT now(),

-- Heredado from table tbase:  estado_reg character varying(10) DEFAULT 'activo'::character varying,
  
id_tipo_mant serial NOT NULL,
 
codigo character varying(20),
  
nombre character varying(100),
  
CONSTRAINT ttipo_mant_pkey PRIMARY KEY (id_tipo_mant)
)
INHERITS (pxp.tbase)

WITH (
  OIDS=TRUE
);


-- Table: gem.tmetodologia

-- DROP TABLE gem.tmetodologia;





CREATE TABLE gem.tmetodologia
(


-- Heredado from table tbase:  id_usuario_reg integer,
-- Heredado from table tbase:  id_usuario_mod integer,


-- Heredado from table tbase:  fecha_reg timestamp without time zone DEFAULT now(),

-- Heredado from table tbase:  fecha_mod timestamp without time zone DEFAULT now(),

-- Heredado from table tbase:  estado_reg character varying(10) DEFAULT 'activo'::character varying,
  
id_metodologia serial NOT NULL,
  codigo character varying(20),
  nombre character varying(100),
  

CONSTRAINT tmetodologia_pkey PRIMARY KEY (id_metodologia)
)
INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);



 
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


--------------- SQL ---------------

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
  

 
 CREATE TABLE gem.tequipo_variable (
  id_equipo_variable SERIAL, 
  id_uni_cons INTEGER, 
  id_tipo_variable INTEGER, 
  valor_min INTEGER, 
  valor_max INTEGER, 
  obs VARCHAR, 
  CONSTRAINT tequipo_variable_pkey PRIMARY KEY(id_equipo_variable)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
 

 
 
 CREATE TABLE 
gem.tfalla
 (id_falla  SERIAL NOT NULL, 
 id_tipo_equipo int4, 
 codigo varchar(20), 
 nombre varchar(250),
 obs varchar ,
 PRIMARY KEY (id_falla)) INHERITS (pxp.tbase);
 
 
 






-- Table: orga.tfuncionario_especialidad

-- DROP TABLE orga.tfuncionario_especialidad;




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
) inherits(pxp.tbase) with oids;

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
) inherits(pxp.tbase) with oids;

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
)inherits(pxp.tbase) with oids;

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
) inherits(pxp.tbase) with oids;

ALTER TABLE gem.torden_trabajo OWNER TO postgres;

--
--5)
--
--alter table gem.torden_trabajo
--add constraint chk_torden_trabajo check (planta_estacion in ('planta','estacion'))


-------------- SQL ---------------


--adiciona columna en tabla uni_con para saber a partir de que plantilla se registro

ALTER TABLE gem.tuni_cons
  ADD COLUMN id_plantilla INTEGER;
  
  
  --Adding new column to table param.tproveedor
alter table param.tproveedor
add column id_lugar integer;
alter table param.tproveedor
add constraint fk_tproveedor__id_lugar foreign key(id_lugar) references param.tlugar(id_lugar);

-- View: param.vproveedor

-- DROP VIEW param.vproveedor;

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



-- View: param.vproveedor

-- DROP VIEW param.vproveedor;

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
///////////////
INSERCION DE REGISTROS PARA LA INTERFAZ DE USUARIO
/////////////////////
*/

/*
INSERT INTO segu.tsubsistema ("id_subsistema", "codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES (27, E'SAL', E'Sistema de Almacenes', E'2012-09-20', E'SAL', E'activo', E'ALMACENES', NULL);


INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (998, E'SISTEMA DE ALMACENES', E'', E'2012-09-20', E'SAL', E'si', 1, NULL, 1, NULL, 27, NULL, E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (372, 998, 0, E'2012-09-20', E'activo');



INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (1000, E'Datos Generales', E'Datos Generales', E'2012-09-20', E'ALDAGE', E'si', 1, E'', 2, E'', NULL, E'', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (373, 999, 998, E'2012-09-20', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (374, 1000, 998, E'2012-09-20', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (375, 1001, 998, E'2012-09-20', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (376, 1002, 999, E'2012-09-20', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (377, 1003, 999, E'2012-09-20', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (378, 1004, 1000, E'2012-09-20', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (379, 1005, 1001, E'2012-09-20', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (380, 1006, 1001, E'2012-09-20', E'activo');

INSERT INTO segu.testructura_gui ("id_estructura_gui", "id_gui", "fk_id_gui", "fecha_reg", "estado_reg")
VALUES (381, 1007, 1001, E'2012-09-20', E'activo');



INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (1001, E'Movimientos', E'Movimientos', E'2012-09-20', E'ALMOVI', E'si', 3, E'', 2, E'', NULL, E'', E'activo');

INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (1002, E'Materiales', E'Registro de Materiales', E'2012-09-20', E'ALREMA', E'si', 1, E'sis_almacenes/vista/item/Item.php\n', 3, E'', NULL, E'Item', E'activo');

INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (1003, E'Clasificaci�n de materiales', E'Clasificaci�n de materiales', E'2012-09-20', E'ALCLMA', E'si', 1, E'sis_almacenes/vista/clasificacion/Clasificacion.php\n', 3, E'', NULL, E'Clasificacion', E'activo');

INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (1004, E'Creaci�n de almacenes', E'Creaci�n de almacenes', E'2012-09-20', E'ALCRAL', E'si', 1, E'sis_almacenes/vista/almacen/Almacen.php\n', 3, E'', NULL, E'Almacen', E'activo');

INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (1005, E'Ingresos', E'Ingresos', E'2012-09-20', E'ALINGR', E'si', 1, E'sis_almacenes/vista/movimiento/Ingreso.php\n', 3, E'', NULL, E'Ingreso', E'activo');

INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (1006, E'Salidas', E'Salidas', E'2012-09-20', E'ALSAGR', E'si', 2, E'sis_almacenes/vista/movimiento/Salida.php\n', 3, E'', NULL, E'Salida', E'activo');

INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg")
VALUES (1007, E'Transferencias', E'Transferencias', E'2012-09-20', E'ALTRGR', E'si', 3, E'sis_almacenes/vista/movimiento/Transferencia.php\n', 3, E'', NULL, E'Transferencia', E'activo');


*/
/*
///////////////////////
CREACION DEL ESQUEMA ALM
///////////////////////
*/
CREATE SCHEMA alm AUTHORIZATION postgres;

CREATE TABLE alm.tclasificacion (
	id_clasificacion  SERIAL NOT NULL,
	id_clasificacion_fk int4,
	codigo varchar(20),
	nombre varchar(200),
	descripcion varchar(1000),
	PRIMARY KEY (id_clasificacion)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.tclasificacion
ADD CONSTRAINT fk_tclasificacion__id_clasificacion_fk FOREIGN KEY (id_clasificacion_fk) REFERENCES alm.tclasificacion (id_clasificacion);

CREATE TABLE alm.talmacen (
	id_almacen  SERIAL NOT NULL,
	codigo varchar(10),
	nombre varchar(100),
	localizacion varchar(100),
	PRIMARY KEY (id_almacen)
)INHERITS (pxp.tbase) WITHOUT OIDS;

CREATE TABLE alm.titem(
	id_item SERIAL NOT NULL,
    id_clasificacion int4 NOT NULL,
    codigo varchar(20),
    nombre varchar(100),
    descripcion varchar(1000),
    palabras_clave varchar(1000),
    codigo_fabrica varchar(100),
    observaciones varchar(1000),
    numero_serie varchar(100),
    PRIMARY KEY(id_item)
) INHERITS (pxp.tbase) WITHOUT OIDS;
ALTER TABLE alm.titem
 ADD CONSTRAINT fk_titem__id_clasificacion FOREIGN KEY (id_clasificacion) REFERENCES alm.tclasificacion(id_clasificacion);
 


CREATE TABLE alm.talmacen_stock (
	id_almacen_stock  SERIAL NOT NULL,
	id_almacen int4 NOT NULL,
	id_item int4,
	cantidad_min numeric(18, 2),
	cantidad_alerta_amarilla numeric(18, 2),
	cantidad_alerta_roja numeric(18, 2),
	PRIMARY KEY (id_almacen_stock)
)INHERITS (pxp.tbase) WITHOUT OIDS;
ALTER TABLE alm.talmacen_stock
ADD CONSTRAINT fk_talmacen_stock__id_almacen FOREIGN KEY (id_almacen) REFERENCES alm.talmacen (id_almacen);
ALTER TABLE alm.talmacen_stock
ADD CONSTRAINT fk_talmacen_stock__id_item FOREIGN KEY (id_item) REFERENCES alm.titem (id_item);

CREATE TABLE alm.tmovimiento_tipo (
	id_movimiento_tipo  SERIAL NOT NULL,
	codigo varchar(20),
	nombre varchar(100), 
	PRIMARY KEY (id_movimiento_tipo)
)INHERITS (pxp.tbase) WITHOUT OIDS;


CREATE TABLE alm.tmovimiento (
	id_movimiento  SERIAL NOT NULL,
	id_movimiento_tipo int4,
	id_almacen int4,
	id_funcionario int4,
	id_proveedor int4,
	id_almacen_dest int4,
	fecha_mov timestamp,
	numero_mov varchar(30),
	descripcion varchar(1000),
	observaciones varchar(1000),
	PRIMARY KEY (id_movimiento)
)INHERITS (pxp.tbase) WITHOUT OIDS;
ALTER TABLE alm.tmovimiento
ADD CONSTRAINT fk_tmovimiento__id_movimiento_tipo FOREIGN KEY (id_movimiento_tipo) REFERENCES alm.tmovimiento_tipo (id_movimiento_tipo);
ALTER TABLE alm.tmovimiento
ADD CONSTRAINT fk_tmovimiento__id_almacen FOREIGN KEY (id_almacen) REFERENCES alm.talmacen (id_almacen);
ALTER TABLE alm.tmovimiento
ADD CONSTRAINT fk_tmovimiento__id_funcionario FOREIGN KEY (id_funcionario) REFERENCES orga.tfuncionario (id_funcionario);
ALTER TABLE alm.tmovimiento
ADD CONSTRAINT fk_tmovimiento__id_proveedor FOREIGN KEY (id_proveedor) REFERENCES param.tproveedor (id_proveedor);
ALTER TABLE alm.tmovimiento
ADD CONSTRAINT fk_tmovimiento__id_almacen_dest FOREIGN KEY (id_almacen_dest) REFERENCES alm.talmacen (id_almacen);

CREATE TABLE alm.tmovimiento_det (
	id_movimiento_det  SERIAL NOT NULL,
	id_movimiento int4,
	id_item int4,
	cantidad numeric(18, 6),
	costo_unitario numeric(18, 6),
	fecha_caducidad date, 
	PRIMARY KEY (id_movimiento_det)
)INHERITS (pxp.tbase) WITHOUT OIDS;
ALTER TABLE alm.tmovimiento_det
ADD CONSTRAINT fk_tmovimiento_det__id_movimiento FOREIGN KEY (id_movimiento) REFERENCES alm.tmovimiento (id_movimiento);
ALTER TABLE alm.tmovimiento_det
ADD CONSTRAINT fk_tmovimiento_det__id_item FOREIGN KEY (id_item) REFERENCES alm.titem (id_item);


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

ALTER TABLE alm.titem
  ALTER COLUMN id_clasificacion DROP NOT NULL;
  
  ALTER TABLE alm.tclasificacion
  ADD COLUMN codigo_largo VARCHAR(20);
  
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


--Diagrama de decisión
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
    observaciones int4,
    PRIMARY KEY (id_calendario_planificado))INHERITS (pxp.tbase)
    WITH OIDS;




--insercion de MENU sistema de mantenimiento



select pxp.f_insert_tfuncion ('f_localizacion_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_localizacion_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_tipo_equipo_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_tipo_equipo_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_uni_cons_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_uni_cons_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_tipo_variable_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_equipo_variable_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_tipo_variable_sel', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tfuncion ('f_equipo_variable_ime', 'Funcion para tabla     ', 'GEM');
select pxp.f_insert_tgui ('Registrar Tipos de Equipo', 'Registro de Tipos de Equipo', 'TEQ', 'si', 2, 'sis_mantenimiento/vista/tipo_equipo/TipoEquipo.php', 2, '', 'TipoEquipo', 'GEM');
select pxp.f_insert_tgui ('Eventos/Incidentes por Equipo', 'Registro de Eventos/Incidentes por equipo', 'EQUINC', 'si', 1, 'sis_mantenimiento/vista/equipo_evento/EquipoEvento.php', 3, '', 'EquipoEvento', 'GEM');
select pxp.f_insert_tgui ('Indicadores', 'Consulta de indicadores', 'GEMIND', 'si', 1, 'sis_mantenimiento/vista/indicador/Indicador.php', 3, '', 'Indicador', 'GEM');
select pxp.f_insert_tgui ('Calendario de Planificación', 'Calendario de Planificación', 'GEMCAL', 'si', 1, 'sis_mantenimiento/vista/calendario_plan/CalendarioPlan.php', 3, '', 'CalendarioPlan', 'GEM');
select pxp.f_insert_tgui ('Mediciones por Equipo', 'Registro de Mediciones por Equipo', 'MEDEQU', 'si', 1, 'sis_mantenimiento/vista/equipo_medicion/EquipoMedicion.php', 3, '', 'EquipoMedicion', 'GEM');
select pxp.f_insert_tgui ('Órdenes de Trabajo', 'Registro Órdenes de Trabajo', 'OOIITT', 'si', 1, 'sis_mantenimiento/vista/orden_trabajo/OrdenTrabajo.php', 3, '', 'OrdenTrabajo', 'GEM');
select pxp.f_insert_tgui ('Plantilla de Equipos', 'Registro Plantilla de Equipos', 'PLAEQU', 'si', 1, 'sis_mantenimiento/vista/plantilla_equipo/PlantillaEquipo.php', 3, '', 'PlantillaEquipo', 'GEM');
select pxp.f_insert_tgui ('Equipos', 'Registro Equipos', 'EQUIPO', 'si', 1, 'sis_mantenimiento/vista/equipo/Equipo.php', 3, '', 'Equipo', 'GEM');
select pxp.f_insert_tgui ('Diagrama de Decisión', 'Registro Diagrama de Decisión', 'DIADEC', 'si', 1, 'sis_mantenimiento/vista/diagrama_decision/DiagramaDecision.php', 3, '', 'DiagramaDecision', 'GEM');
select pxp.f_insert_tgui ('Localizaciones', 'Registro de Localizaciones', 'LOCALI', 'si', 1, 'sis_mantenimiento/vista/localizacion/Localizacion.php', 3, '', 'Localizacion', 'GEM');
select pxp.f_insert_tgui ('Funcionarios', 'Registro de Funcionarios', 'GEMFUN', 'si', 1, 'sis_recursos_humanos/vista/funcionario/Funcionario.php', 3, '', 'Funcionario', 'GEM');
select pxp.f_insert_tgui ('Metodologías', 'Registro de Metodologías', 'METODO', 'si', 1, 'sis_mantenimiento/vista/metodologia/Metodologia.php', 3, '', 'Meotodologia', 'GEM');
select pxp.f_insert_tgui ('Tipos de Equipos', 'Registro de Tipos de Equipos', 'TIPEQU', 'si', 1, 'sis_mantenimiento/vista/tipo_equipo/TipoEquipo.php', 3, '', 'TipoEquipo', 'GEM');
select pxp.f_insert_tgui ('Tipos de Mantenimiento', 'Registro de Tipos de Mantenimiento', 'TIPMAN', 'si', 1, 'sis_mantenimiento/vista/tipo_mantenimiento/TipoMantenimiento.php', 3, '', 'Horario', 'GEM');
select pxp.f_insert_tgui ('Horarios', 'Registro de Horarios', 'GEMHOR', 'si', 1, 'sis_recursos_humanos/vista/horario/Horario.php', 3, '', 'Horario', 'GEM');
select pxp.f_insert_tgui ('Especialidades Técnicas', 'Registro de especialidades técnicas', 'GEMEST', 'si', 1, 'sis_recursos_humanos/vista/especialidad/Especialidad.php', 3, '', 'Especialidad', 'GEM');
select pxp.f_insert_tgui ('Proveedores', 'Registro de Proveedores', 'GEMPRO', 'si', 1, 'sis_matenimiento/vista/proveedor/Proveedor.php', 3, '', 'Proveedor', 'GEM');
select pxp.f_insert_tgui ('Catalogos Varios', 'catalogos', 'cata', 'si', 3, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('Equipos y Planificación', 'Datos detallados de los equipos y Planificación del Mantenimiento', 'EQUPLA', 'si', 2, '', 2, '', '', 'GEM');
select pxp.f_insert_tgui ('Ejecución y Seguimiento del Mantenimiento', 'Ejecución y Seguimiento del Mantenimiento', 'EJESEG', 'si', 3, '', 2, '', '""', 'GEM');
select pxp.f_insert_tgui ('Def. de Equipo', 'Definicion de equipos', 'TUC', 'si', 3, 'sis_mantenimiento/vista/uni_cons/UniCons.php', 2, '', 'UniCons', 'GEM');
select pxp.f_insert_tgui ('SISTEMA DE GESTION DE MANTENIMIENTO', '', 'GEM', 'si', 10, '', 1, '', '', 'GEM');
select pxp.f_insert_tgui ('Localizacion', 'Localizacion', 'loc', 'si', 1, 'sis_mantenimiento/vista/localizacion/Localizacion.php', 2, '', 'Localizacion', 'GEM');

select pxp.f_insert_testructura_gui ('loc', 'EQUPLA');
select pxp.f_insert_testructura_gui ('TEQ', 'EQUPLA');
select pxp.f_insert_testructura_gui ('TUC', 'EQUPLA');
select pxp.f_insert_testructura_gui ('EQUINC', 'EJESEG');
select pxp.f_insert_testructura_gui ('GEMIND', 'EJESEG');
select pxp.f_insert_testructura_gui ('GEMCAL', 'EJESEG');
select pxp.f_insert_testructura_gui ('MEDEQU', 'EJESEG');
select pxp.f_insert_testructura_gui ('OOIITT', 'EJESEG');
select pxp.f_insert_testructura_gui ('PLAEQU', 'EQUPLA');
select pxp.f_insert_testructura_gui ('EQUIPO', 'EQUPLA');
select pxp.f_insert_testructura_gui ('DIADEC', 'EQUPLA');
select pxp.f_insert_testructura_gui ('LOCALI', 'EQUPLA');
select pxp.f_insert_testructura_gui ('GEMFUN', 'cata');
select pxp.f_insert_testructura_gui ('METODO', 'cata');
select pxp.f_insert_testructura_gui ('TIPEQU', 'cata');
select pxp.f_insert_testructura_gui ('TIPMAN', 'cata');
select pxp.f_insert_testructura_gui ('GEMHOR', 'cata');
select pxp.f_insert_testructura_gui ('GEMEST', 'cata');
select pxp.f_insert_testructura_gui ('GEMPRO', 'cata');
select pxp.f_insert_testructura_gui ('cata', 'GEM');
select pxp.f_insert_testructura_gui ('EQUPLA', 'GEM');
select pxp.f_insert_testructura_gui ('EJESEG', 'GEM');
select pxp.f_insert_testructura_gui ('GEM', 'SISTEMA');
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




