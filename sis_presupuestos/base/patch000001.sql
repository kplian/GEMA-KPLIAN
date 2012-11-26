/***********************************I-SCP-GSS-PRE-31-23/11/2012****************************************/

/**	Author: Gonzalo Sarmiento Sejas
*	Date: 11/2012
*	Description: Build the menu definition and composition
*/
 
/* (1) Tables creation */

--Presupuestos

CREATE TABLE pre.tpresupuesto (
  id_presupuesto  SERIAL NOT NULL,
  codigo varchar(20),
  descripcion varchar(200),
  gestion integer,
  estado varchar(15),
  CONSTRAINT tpresupuesto__id_presupuesto PRIMARY KEY (id_presupuesto)
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE pre.tpresupuesto OWNER TO postgres;


CREATE TABLE pre.tpartida (
  id_partida SERIAL, 
  id_partida_fk integer, 
  codigo VARCHAR(20), 
  descripcion VARCHAR(200), 
  tipo varchar(15),
  CONSTRAINT tpartida__id_partida PRIMARY KEY(id_partida),
  CONSTRAINT chk_tpartida__tipo check (tipo in ('trans','no_trans')),
  CONSTRAINT fk_tpartida__id_partida_fk FOREIGN KEY (id_partida_fk)
  	  REFERENCES pre.tpartida (id_partida) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE pre.tpartida OWNER TO postgres;


CREATE TABLE pre.tpresup_partida (
  id_presup_partida  SERIAL NOT NULL,
  id_presupuesto integer,
  id_partida integer,
  id_centro_costo integer,
  id_moneda integer,
  fecha_hora timestamp,
  importe numeric(18,2),
  tipo varchar(15),
  CONSTRAINT tpresup_partida__id_presup_partida PRIMARY KEY (id_presup_partida),
  CONSTRAINT fk_tpresup_partida__id_presupuesto FOREIGN KEY (id_presupuesto)
      REFERENCES pre.tpresupuesto (id_presupuesto) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tpresup_partida__id_partida FOREIGN KEY (id_partida)
      REFERENCES pre.tpartida (id_partida) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tpresup_partida__id_centro_costo FOREIGN KEY (id_centro_costo)
      REFERENCES gem.tcentro_costo (id_centro_costo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tpresup_partida__id_moneda FOREIGN KEY (id_moneda)
      REFERENCES param.tmoneda (id_moneda) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT chk_tpresup_partida__tipo check (tipo in ('presupuestado','ejecutado'))
) INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE pre.tpresup_partida OWNER TO postgres;


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

/***********************************F-SCP-GSS-PRE-31-23/11/2012*****************************************/
