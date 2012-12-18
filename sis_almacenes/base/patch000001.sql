/***********************************I-SCP-JRR-ALM-1-19/11/2012****************************************/
/*
*	Author: JRR
*	Date: 11/2012
*	Description: Build the menu definition and composition
*/
--
-- Structure for table tclasificacion (OID = 688286) :
--

CREATE TABLE alm.tclasificacion (
    id_clasificacion serial NOT NULL,
    id_clasificacion_fk integer,
    codigo varchar(20),
    nombre varchar(200),
    descripcion varchar(1000),
    codigo_largo varchar(20)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table talmacen (OID = 688562) :
--
CREATE TABLE alm.talmacen (
    id_almacen serial NOT NULL,
    codigo varchar(10),
    nombre varchar(100),
    localizacion varchar(100)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table titem (OID = 688573) :
--
CREATE TABLE alm.titem (
    id_item serial NOT NULL,
    id_clasificacion integer,
    codigo varchar(20),
    nombre varchar(100),
    descripcion varchar(1000),
    palabras_clave varchar(1000),
    codigo_fabrica varchar(100),
    observaciones varchar(1000),
    numero_serie varchar(100)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table talmacen_stock (OID = 688592) :
--
CREATE TABLE alm.talmacen_stock (
    id_almacen_stock serial NOT NULL,
    id_almacen integer NOT NULL,
    id_item integer,
    cantidad_min numeric(18,2),
    cantidad_alerta_amarilla numeric(18,2),
    cantidad_alerta_roja numeric(18,2)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tmovimiento_tipo (OID = 688613) :
--
CREATE TABLE alm.tmovimiento_tipo (
    id_movimiento_tipo serial NOT NULL,
    codigo varchar(20),
    nombre varchar(100)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tmovimiento (OID = 688624) :
--
CREATE TABLE alm.tmovimiento (
    id_movimiento serial NOT NULL,
    id_movimiento_tipo integer,
    id_almacen integer,
    id_funcionario integer,
    id_proveedor integer,
    id_almacen_dest integer,
    fecha_mov timestamp without time zone,
    numero_mov varchar(30),
    descripcion varchar(1000),
    observaciones varchar(1000),
    estado_mov varchar(10)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tmovimiento_det (OID = 785635) :
--
CREATE TABLE alm.tmovimiento_det (
    id_movimiento_det serial NOT NULL,
    id_movimiento integer,
    id_item integer,
    cantidad numeric(18,6),
    costo_unitario numeric(18,6),
    fecha_caducidad date
)
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Definition for index tclasificacion_pkey (OID = 688296) :
--
ALTER TABLE ONLY alm.tclasificacion
    ADD CONSTRAINT tclasificacion_pkey
    PRIMARY KEY (id_clasificacion);
--
-- Definition for index fk_tclasificacion__id_clasificacion_fk (OID = 688298) :
--
ALTER TABLE ONLY alm.tclasificacion
    ADD CONSTRAINT fk_tclasificacion__id_clasificacion_fk
    FOREIGN KEY (id_clasificacion_fk) REFERENCES alm.tclasificacion(id_clasificacion);
--
-- Definition for index talmacen_pkey (OID = 688569) :
--
ALTER TABLE ONLY alm.talmacen
    ADD CONSTRAINT talmacen_pkey
    PRIMARY KEY (id_almacen);
--
-- Definition for index titem_pkey (OID = 688583) :
--
ALTER TABLE ONLY alm.titem
    ADD CONSTRAINT titem_pkey
    PRIMARY KEY (id_item);
--
-- Definition for index fk_titem__id_clasificacion (OID = 688585) :
--
ALTER TABLE ONLY alm.titem
    ADD CONSTRAINT fk_titem__id_clasificacion
    FOREIGN KEY (id_clasificacion) REFERENCES alm.tclasificacion(id_clasificacion);
--
-- Definition for index talmacen_stock_pkey (OID = 688599) :
--
ALTER TABLE ONLY alm.talmacen_stock
    ADD CONSTRAINT talmacen_stock_pkey
    PRIMARY KEY (id_almacen_stock);
--
-- Definition for index fk_talmacen_stock__id_almacen (OID = 688601) :
--
ALTER TABLE ONLY alm.talmacen_stock
    ADD CONSTRAINT fk_talmacen_stock__id_almacen
    FOREIGN KEY (id_almacen) REFERENCES alm.talmacen(id_almacen);
--
-- Definition for index fk_talmacen_stock__id_item (OID = 688606) :
--
ALTER TABLE ONLY alm.talmacen_stock
    ADD CONSTRAINT fk_talmacen_stock__id_item
    FOREIGN KEY (id_item) REFERENCES alm.titem(id_item);
--
-- Definition for index tmovimiento_tipo_pkey (OID = 688620) :
--
ALTER TABLE ONLY alm.tmovimiento_tipo
    ADD CONSTRAINT tmovimiento_tipo_pkey
    PRIMARY KEY (id_movimiento_tipo);
--
-- Definition for index tmovimiento_pkey (OID = 688634) :
--
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT tmovimiento_pkey
    PRIMARY KEY (id_movimiento);
--
-- Definition for index fk_tmovimiento__id_movimiento_tipo (OID = 688636) :
--
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_movimiento_tipo
    FOREIGN KEY (id_movimiento_tipo) REFERENCES alm.tmovimiento_tipo(id_movimiento_tipo);
--
-- Definition for index fk_tmovimiento__id_almacen (OID = 688641) :
--
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_almacen
    FOREIGN KEY (id_almacen) REFERENCES alm.talmacen(id_almacen);
--
-- Definition for index fk_tmovimiento__id_funcionario (OID = 688646) :
--
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_funcionario
    FOREIGN KEY (id_funcionario) REFERENCES orga.tfuncionario(id_funcionario);
--
-- Definition for index fk_tmovimiento__id_proveedor (OID = 688651) :
--
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_proveedor
    FOREIGN KEY (id_proveedor) REFERENCES param.tproveedor(id_proveedor);
--
-- Definition for index fk_tmovimiento__id_almacen_dest (OID = 688656) :
--
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_almacen_dest
    FOREIGN KEY (id_almacen_dest) REFERENCES alm.talmacen(id_almacen);
--
-- Definition for index tmovimiento_det_pkey (OID = 785642) :
--
ALTER TABLE ONLY alm.tmovimiento_det
    ADD CONSTRAINT tmovimiento_det_pkey
    PRIMARY KEY (id_movimiento_det);
--
-- Definition for index fk_tmovimiento_det__id_movimiento (OID = 785644) :
--
ALTER TABLE ONLY alm.tmovimiento_det
    ADD CONSTRAINT fk_tmovimiento_det__id_movimiento
    FOREIGN KEY (id_movimiento) REFERENCES alm.tmovimiento(id_movimiento);
--
-- Definition for index fk_tmovimiento_det__id_item (OID = 785649) :
--
ALTER TABLE ONLY alm.tmovimiento_det
    ADD CONSTRAINT fk_tmovimiento_det__id_item
    FOREIGN KEY (id_item) REFERENCES alm.titem(id_item);
    
   

CREATE TABLE alm.talmacen_usuario (
  id_almacen_usuario SERIAL, 
  id_usuario INTEGER, 
  CONSTRAINT talmacen_usuario_pkey PRIMARY KEY(id_almacen_usuario), 
  CONSTRAINT fk_talmacen_usuario__id_usuario FOREIGN KEY (id_usuario)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.talmacen
  ADD COLUMN id_almacen_usuario INTEGER,
  ADD CONSTRAINT fk_talmacen__id_almacen_usuario FOREIGN KEY (id_almacen_usuario)
    REFERENCES alm.talmacen_usuario(id_almacen_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
CREATE TABLE alm.talmacen_correlativo (
  id_almacen_correl SERIAL, 
  id_almacen INTEGER, 
  id_movimiento_tipo INTEGER, 
  periodo VARCHAR, 
  correl_act INTEGER DEFAULT 0, 
  correl_sig INTEGER DEFAULT 1, 
  CONSTRAINT talmacen_correlativo_pkey PRIMARY KEY(id_almacen_correl), 
  CONSTRAINT fk_talmacen__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT fk_tmovimiento_tipo__id_movimiento_tipo FOREIGN KEY (id_movimiento_tipo)
    REFERENCES alm.tmovimiento_tipo(id_movimiento_tipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-JRR-ALM-1-19/11/2012****************************************/

    