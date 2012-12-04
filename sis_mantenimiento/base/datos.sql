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
VALUES (6,4,1,'activo','EST-CBA-01','Sayari',8,null,'-66.28319940468748','-17.40843908149394');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (11,5,1,'activo','EST-SCZ-01','Unidad de Bombeo 1',8,null,'-63.23998651406248','-17.324554957334563');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (12,6,1,'activo','EST-CBA-01','Unidad de Bombeo 2',8,null,'-66.28319940468748','-17.40843908149394');
--Localizaciones -> Plantas
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (7,2,1,'activo','SCZ','Santa Cruz',7,'Of. Central','-63.01476678749998','-17.87433754489201');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (8,2,1,'activo','CBA','Cochabamba',7,'Regional Cochabamba','-66.17333612343748','-17.39271373509218');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (9,7,1,'activo','PLA-SCZ-01','Planta Warnes',8,null,'-63.17406854531248','-17.513240092854506');
INSERT INTO gem.tlocalizacion(id_localizacion,id_localizacion_fk,id_usuario_reg, estado_reg,codigo, nombre, coordenadas,desc_ubicacion, longitud,latitud)
VALUES (10,8,1,'activo','PLA-CBA-01','Planta Punata',8,null,'-65.83275995156248','-17.549906180561642');

--Persona
--INSERT INTO segu.tpersona(id_usuario_reg, estado_reg, id_persona, nombre, apellido_paterno)
--VALUES (1,  'activo', 2, 'Juan', 'Perez');

--Institución
--INSERT INTO param.tinstitucion(id_usuario_reg,  estado_reg, id_institucion, id_persona,doc_id,codigo,direccion,nombre)
--VALUES (1, 'activo', 1, 2, '234321','INS-01','Av. América #349','Los Alamos');

--Tipo Equipo
INSERT INTO gem.ttipo_equipo(id_usuario_reg,  estado_reg,id_tipo_equipo, codigo, nombre, descripcion)
VALUES (1,'activo',1,'MCB','Motor de Combustión','Motores de combustión');
INSERT INTO gem.ttipo_equipo(id_usuario_reg,estado_reg,id_tipo_equipo,codigo,nombre,descripcion)
VALUES (1,'activo',2,'SLB','Sistema de Lubricación','Sistema de Lubricación');
INSERT INTO gem.ttipo_equipo(id_usuario_reg,estado_reg,id_tipo_equipo,codigo,nombre,descripcion)
VALUES (1,'activo',3,'COM','Combustibles','Combustibles');

--EQUIPOS
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',1, null, null, 'MTCI', 'MOTOR DE COMBUSTIÓN INTERNA','tuc', 'aprobado', 'base', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',2, 1, null, 'MCBI', 'MOTOR DE COMBUSTIÓN INTERNA','tuc', 'borrador', 'raiz', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',3, 2, null, 'SLB', 'SISTEMA DE LUBRICACIÓN','tuc', 'borrador', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',4, 3, null, 'CCO', 'COMBUSTIBLES Y  CONSUMIBLES','tuc', 'borrador', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',5, null, 5, 'EST-SCZ-01', 'ESTACIÓN MONTERO','uc', 'registrado', 'base', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',6, 1, 11, 'MCBI-001', 'MOTOR DE COMBUSTIÓN INTERNA','uc', 'registrado', 'raiz', 2);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',7, 2, null, 'SLB', 'SISTEMA DE LUBRICACIÓN','uc', 'registrado', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',8, 3, null, 'CCO', 'COMBUSTIBLES Y  CONSUMIBLES','uc', 'registrado', 'rama', null);
INSERT INTO gem.tuni_cons(id_usuario_reg, estado_reg,id_uni_cons, id_tipo_equipo, id_localizacion, codigo, nombre,tipo, estado, tipo_nodo, id_plantilla)
VALUES (1,'activo',9, 1, 12, 'MCBI-002', 'MOTOR DE COMBUSTIÓN INTERNA','uc', 'registrado', 'raiz', 2);
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

--UNIDADES DE MEDIDA
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion")
VALUES (1, NULL, E'2012-11-02 13:31:27', E'2012-11-02 13:31:27', E'activo', 9, E'kilometros', E'Kilometros');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion")
VALUES (1, 1, E'2012-11-02 13:29:13', E'2012-11-03 09:42:35.594', E'activo', 2, E'dia', E'Dia');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion")
VALUES (1, 1, E'2012-11-02 13:26:52', E'2012-11-03 09:42:43.275', E'activo', 1, E'hora', E'Hora');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion")
VALUES (1, 1, E'2012-11-02 13:30:42', E'2012-11-03 09:42:54.058', E'activo', 5, E'año', E'Año');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion")
VALUES (1, 1, E'2012-11-02 13:29:13', E'2012-11-03 09:43:44.843', E'activo', 4, E'mes', E'Mes');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion")
VALUES (1, 1, E'2012-11-02 13:34:20', E'2012-11-03 09:46:29.882', E'activo', 3, E'semana', E'Semana');

--MANTENIMIENTOS PREDEFINIDOS
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo")
VALUES (1, NULL, E'2012-11-06 12:26:37.546', NULL, E'activo', 1, E'MPP01', E'Mantenimiento Preventivo Planificado 01', NULL, 1);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo")
VALUES (1, NULL, E'2012-11-06 12:26:37.546', NULL, E'activo', 2, E'MPP02', E'Mantenimiento Preventivo Planificado 02', NULL, 1);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo")
VALUES (1, NULL, E'2012-11-06 12:26:37.546', NULL, E'activo', 3, E'MPP03', E'Mantenimiento Preventivo Planificado 03', NULL, 1);


--MANTENIMIENTOS PREDEFINIDOS DETALLE
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-11-06 12:26:50.745', NULL, E'activo', 1, 1, E'Revisión de la compresión del motor', E'Revisión de la compresión del motor', E'');
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-11-06 12:27:00.244', NULL, E'activo', 2, 1, E'Cambio de filtro de aceite', E'Cambio de filtro de aceite', E'');

INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-11-06 12:26:50.745', NULL, E'activo', 3, 2, E'Revisión de la compresión del motor', E'Revisión de la compresión del motor', E'');
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-11-06 12:27:00.244', NULL, E'activo', 4, 2, E'Cambio de filtro de aceite', E'Cambio de filtro de aceite', E'');

INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-11-06 12:26:50.745', NULL, E'activo', 5, 3, E'Revisión de la compresión del motor', E'Revisión de la compresión del motor', E'');
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-11-06 12:27:00.244', NULL, E'activo', 6, 3, E'Cambio de filtro de aceite', E'Cambio de filtro de aceite', E'');

--NIVELES DE ESPECIALIDADES
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 1, 'PHD', 'Doctorado');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 2, 'MGR', 'Maestría');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 3, 'ING', 'Ingeniería');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 4, 'LIC', 'Licenciatura');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 5, 'UNI', 'Universitario');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 6, 'BAC', 'Bachiller');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 7, 'TSU', 'Técnico Superior');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 8, 'TMD', 'Técnico Medio');

--TIPOS DE MANTENIMIENTO - AAO
INSERT INTO gem.ttipo_mant ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_mant", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2012-11-23 16:41:18.149', NULL, E'activo', 1, E'MT-1', E'Mantenimiento de Balbulas', E'planificado');

--ORDEN DE TRABAJO - AAO
INSERT INTO gem.torden_trabajo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo", "id_uni_cons_mant_predef", "id_uni_cons", "id_tipo_mant", "id_unidad_medida", "id_funcionario_sol", "id_funcionario_asig", "fecha_plan_ini", "fecha_plan_fin", "fecha_eje_ini", "fecha_eje_fin", "descripcion", "fecha_emision", "num_oit", "codigo_oit", "planta_estacion", "prioridad", "ubicacion_tecnica", "periodicidad", "acumulado", "observacion", "nota_tecnico_equipo", "nota_tecnico_loc", "id_cat_estado", "id_cat_prior", "id_cat_tipo", "id_instruc_seg")
VALUES (1, NULL, E'2012-11-23 16:50:35.765', NULL, E'activo', 2, NULL, 6, 1, 2, 1, 1, E'2012-11-25', E'2012-11-26', NULL, NULL, E'Matenimiento de las balbulas principales de combustión', E'2012-11-23', E'1', E'OIT-1', E'planta', E'1', E'Subestación S3', '20', NULL, E'máximo de retraso de 3 dias', E'', E'SS1-S3', NULL, NULL, NULL, NULL);

