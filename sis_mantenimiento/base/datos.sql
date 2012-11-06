/*
*	Author: RCM
*	Date: 06-11-2012
*	Description: Test data
*/

--Localizaciones
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (1,null,1,'activo','EST','Estaciones',6,'Contenedor de todas las Estaciones de YPFB Logística','-63.028656318749995','-17.891894001828973');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (2,null,1,'activo','PLA','Plantas',6,'Contenedor de todas las Plantas de YPFB Logística','-62.99260753124997','-17.864509872994322');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (3,1,1,'activo','SCZ','Santa Cruz',7,'Of. Central','-63.01476678749998','-17.87433754489201');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (4,1,1,'activo','CBA','Cochabamba',7,'Regional Cochabamba','-66.17333612343748','-17.39271373509218');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (5,3,1,'activo','EST-SCZ-01','Estación Montero',8,null,'-63.23998651406248','-17.324554957334563');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (6,4,1,'activo','EST-CBA-01','Estación Quillacollo',8,null,'-66.28319940468748','-17.40843908149394');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (7,2,1,'activo','SCZ','Santa Cruz',7,'Of. Central','-63.01476678749998','-17.87433754489201');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (8,2,1,'activo','CBA','Cochabamba',7,'Regional Cochabamba','-66.17333612343748','-17.39271373509218');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (9,7,1,'activo','PLA-SCZ-01','Planta Warnes',8,null,'-63.17406854531248','-17.513240092854506');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (10,8,1,'activo','PLA-CBA-01','Planta Punata',8,null,'-65.83275995156248','-17.549906180561642');

--Persona
INSERT INTO segu.tpersona(id_usuario_reg, estado_reg, id_persona, nombre, apellido_paterno)
VALUES (1,  'activo', 2, 'Juan', 'Perez');

--Institución
INSERT INTO param.tinstitucion(id_usuario_reg,  estado_reg, id_institucion, id_persona,doc_id,codigo,direccion,nombre)
VALUES (1, 'activo', 1, 2, '234321','INS-01','Av. América #349','Los Alamos');

--Tipo Equipo
INSERT INTO gem.ttipo_equipo(id_usuario_reg,  estado_reg,id_tipo_equipo, codigo, nombre, descripcion)
VALUES (1,'activo',1,'MCB','Motor de Combustión','Motores de combustión');
INSERT INTO gem.ttipo_equipo(id_usuario_reg,estado_reg,id_tipo_equipo,codigo,nombre,descripcion)
VALUES (1,'activo',2,'SLB','Sistema de Lubricación','Sistema de Lubricación');
INSERT INTO gem.ttipo_equipo(id_usuario_reg,estado_reg,id_tipo_equipo,codigo,nombre,descripcion)
VALUES (1,'activo',3,'COM','Combustibles','Combustibles');

--EQUIPOS
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',1, null, null, 'MTCI', 'MOTOR DE COMBUSTIÓN INTERNA','tuc', 'borrador', 'base', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',2, 1, null, 'MCBI', 'MOTOR DE COMBUSTIÓN INTERNA','tuc', 'borrador', 'raiz', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',3, 2, null, 'SLB', 'SISTEMA DE LUBRICACIÓN','tuc', 'borrador', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',4, 3, null, 'CCO', 'COMBUSTIBLES Y  CONSUMIBLES','tuc', 'borrador', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',5, null, 5, 'EST-SCZ-01', 'ESTACIÓN MONTERO','uc', 'registrado', 'base', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',6, 1, 5, 'MCBI-001', 'MOTOR DE COMBUSTIÓN INTERNA','uc', 'registrado', 'raiz', 2);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',7, 2, null, 'SLB', 'SISTEMA DE LUBRICACIÓN','uc', 'registrado', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',8, 3, null, 'CCO', 'COMBUSTIBLES Y  CONSUMIBLES','uc', 'registrado', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',9, 1, 5, 'MCBI-002', 'MOTOR DE COMBUSTIÓN INTERNA','uc', 'registrado', 'raiz', 2);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',10, 2, null, 'SLB', 'SISTEMA DE LUBRICACIÓN','uc', 'registrado', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',11, 3, null, 'CCO', 'COMBUSTIBLES Y  CONSUMIBLES','uc', 'registrado', 'rama', null);

--EQUIPOS COMPOSICIÓN
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',1, 2, 1, 'no',1);
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',2, 3, 2, 'no',1);
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',3, 4, 2, 'no',1);
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',4, 6, 5, 'no',1);
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',5, 7, 6, 'no',1);
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',6, 8, 6, 'no',1);
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',7, 9, 5, 'no',1);
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',8, 10, 9, 'no',1);
INSERT INTO gem.tuni_cons_comp(id_usuario_reg, estado_reg,id_uni_cons_comp,id_uni_cons_hijo,id_uni_cons_padre,opcional,cantidad)
VALUES (1,'activo',9, 11, 9, 'no',1);