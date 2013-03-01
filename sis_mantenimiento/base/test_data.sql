/*
*	Author: RCM
*	Date: 06-11-2012
*	Description: Test data
*/

--USUARIOS
INSERT INTO segu.tusuario ("id_clasificador", "cuenta", "contrasena", "fecha_caducidad", "fecha_reg", "estilo", "contrasena_anterior", "id_persona", "estado_reg", "autentificacion")
VALUES (1, E'spanza2', E'533cd2ec574f9a6ded5801efbfee21ba', E'2014-02-28', E'2013-02-28', E'xtheme-blue.css', NULL, 3, E'activo', E'local');

/* Data for the 'param.tunidad_medida' table  (Records 1 - 11) */
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, NULL, E'2012-12-03 18:24:21.439', NULL, E'activo', 10, E'PSI', E'Presion', NULL);
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, NULL, E'2012-12-11 18:10:40.283', NULL, E'activo', 12, E'RPM', E'RPM', NULL);
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, NULL, E'2012-12-11 18:11:24.133', NULL, E'activo', 13, E'CAU', E'Caudal', NULL);
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:26:52', E'2012-12-19 18:00:08.498', E'activo', 1, E'hora', E'Hora', E'Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:29:13', E'2012-12-19 18:00:55.574', E'activo', 2, E'dia', E'Dia', E'Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:34:20', E'2012-12-19 18:01:24.560', E'activo', 3, E'semana', E'Semana', E'Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:29:13', E'2012-12-19 18:50:36.757', E'activo', 4, E'mes', E'Mes', E'Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:30:42', E'2012-12-19 19:05:56.585', E'activo', 5, E'año', E'Año', E'Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, NULL, E'2012-11-02 13:31:27', E'2012-11-02 13:31:27', E'activo', 9, E'kilometros', E'Kilometros', E'Longitud');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-12-11 18:10:16.274', E'2012-12-14 11:27:00.522', E'activo', 11, E'oC', E'Grados Centigrados', E'Longitud');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, NULL, E'2012-12-20 14:15:55.044', NULL, E'activo', 14, E'Litros', E'Litros', E'Masa');


/* Data for the 'gem.tmetodologia' table  (Records 1 - 1) */
INSERT INTO gem.tmetodologia ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_metodologia", "codigo", "nombre")
VALUES (1, NULL, E'2012-12-11 10:23:16.211', NULL, E'activo', 1, E'RCM', E'RCM');

INSERT INTO gem.tmetodologia ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_metodologia", "codigo", "nombre")
VALUES (1, NULL, E'2012-12-29 07:34:34.625', NULL, E'activo', 2, E'MET-2', E'METODOLOGIA RUP');

INSERT INTO gem.tmetodologia ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_metodologia", "codigo", "nombre")
VALUES (1, NULL, E'2012-12-29 07:34:57.719', NULL, E'activo', 3, E'MET-15', E'XP Y OTRA DE DESARROLLO AGIL');

INSERT INTO gem.tmetodologia ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_metodologia", "codigo", "nombre")
VALUES (1, NULL, E'2012-12-29 07:35:20.972', NULL, E'activo', 4, E'TMPD-123', E'SCRUM');


/* Data for the 'gem.ttipo_mant' table  (Records 1 - 4) */
INSERT INTO gem.ttipo_mant ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_mant", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2012-12-04 15:47:29.415', NULL, E'activo', 2, E'MBT', E'Mantenimiento Basado en Tiempo', E'planificado');
INSERT INTO gem.ttipo_mant ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_mant", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2012-12-04 15:47:52.412', NULL, E'activo', 3, E'MBC', E'Mantenimiento Basado en Condicion', E'planificado');
INSERT INTO gem.ttipo_mant ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_mant", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2012-12-04 15:48:16.719', NULL, E'activo', 4, E'MC', E'Mantenimiento Correctivo', E'no_planificado');
INSERT INTO gem.ttipo_mant ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_mant", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2012-12-04 15:48:34.163', NULL, E'activo', 5, E'INS', E'Inspeccion', E'planificado');


/* Data for the 'gem.ttipo_equipo' table  (Records 1 - 13) */
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2012-12-03 17:39:47.945', E'2012-12-03 17:39:47.945', E'activo', 2, E'SLB', E'Sistema de Lubricación', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2012-12-03 17:39:47.946', E'2012-12-03 17:39:47.946', E'activo', 3, E'COM', E'Combustibles', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2012-12-03 17:39:47.943', E'2012-12-04 17:55:50.304', E'activo', 1, E'MCB', E'Motor de Combustión a Gas', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2012-12-04 18:04:56.032', NULL, E'activo', 7, E'BO', E'BOMBA CENTRIFUGA', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2012-12-04 18:05:28.846', NULL, E'activo', 8, E'BO', E'BOMBA TRIPLEX VERTICAL', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2012-12-04 18:06:03.698', NULL, E'activo', 9, E'GE', E'GENERADOR ELECTRICO', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2012-12-05 16:55:09.667', E'2012-12-05 16:55:09.667', E'activo', 11, E'reg indirecto', E'ELECTROBOMBAS', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2012-12-05 19:14:59.974', NULL, E'activo', 12, E'VEH', E'Vehiculos', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2012-12-11 11:04:57.817', E'2012-12-14 10:43:11.922', E'activo', 13, E'VV', E'VARIADOR', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2012-12-11 11:06:27.460', E'2012-12-14 10:43:29.785', E'activo', 14, E'BO', E'BOMBA RECIPROCANTE', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2012-12-03 18:05:46.676', E'2012-12-14 10:43:44.928', E'activo', 4, E'ME', E'MOTOR ELECTRICO', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2012-12-03 18:07:30.450', E'2012-12-14 10:43:58.201', E'activo', 5, E'RE', E'REDUCTOR', NULL);
INSERT INTO gem.ttipo_equipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_equipo", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2012-12-04 17:56:55.702', E'2012-12-14 11:21:39.664', E'activo', 6, E'MC', E'MOTOR DE COMBUSTION INTERNA', NULL);


/* Data for the 'gem.tlocalizacion' table  (Records 1 - 74) */
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.931', E'2012-12-03 17:52:45.077', E'activo', 1, NULL, E'OCOLP', E'OCOLP', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.933', E'2012-12-04 15:59:34.580', E'activo', 2, NULL, E'PCPV', E'PCPV', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.934', E'2012-12-05 11:13:44.122', E'activo', 3, 1, E'E', E'ESTACION', E'7', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.935', E'2012-12-05 11:13:59.010', E'activo', 4, 1, E'P', E'PLANTA', E'7', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.937', E'2012-12-03 17:57:01.184', E'activo', 5, 3, E'ECBB', E'Cochabamba', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.937', E'2012-12-04 16:12:23.224', E'activo', 6, 4, E'PORU', E'Oruro', E'7', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.939', E'2012-12-05 11:14:11.150', E'activo', 7, 2, E'E', E'ESTACION', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.942', E'2012-12-05 11:14:18.720', E'activo', 8, 2, E'P', E'PLANTA', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.942', E'2012-12-04 16:14:28.998', E'activo', 9, 7, E'ECBB', E'Cochabamba', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.943', E'2012-12-05 11:11:00.089', E'activo', 10, 8, E'PCBB', E'Planta Cochabamba', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:39:47.938', E'2012-12-04 16:29:37.855', E'activo', 11, 5, E'UBO01', E'Unidad de Bombeo 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-03 17:39:47.938', E'2012-12-03 17:39:47.938', E'activo', 12, 6, E'EST-CBA-01', E'Unidad de Bombeo 2', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:57:25.375', E'2012-12-04 16:40:45.329', E'activo', 13, 3, E'ESAY', E'Sayari', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-03 17:57:44.334', E'2012-12-04 16:51:54.407', E'activo', 14, 3, E'EORU', E'Oruro', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:02:55.932', NULL, E'activo', 15, NULL, E'OCSZ-1', E'OCSZ-1', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:03:14.139', NULL, E'activo', 16, NULL, E'PCS', E'PCS', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:03:27.020', NULL, E'activo', 17, NULL, E'PSP', E'PSP', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:03:40.346', NULL, E'activo', 18, NULL, E'PVT', E'PVT', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:06:52.804', E'2012-12-05 11:15:47.268', E'activo', 20, 15, E'E', E'ESTACION', E'5', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:07:01.704', E'2012-12-05 11:16:02.166', E'activo', 21, 15, E'P', E'PLANTA', E'5', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:07:14.246', E'2012-12-05 11:16:54.566', E'activo', 22, 16, E'E', E'ESTACION', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:07:20.849', E'2012-12-05 11:17:08.339', E'activo', 23, 16, E'P', E'PLANTA', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:07:32.224', E'2012-12-05 11:18:35.618', E'activo', 24, 17, E'E', E'ESTACION', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:07:43.827', E'2012-12-05 11:18:47.860', E'activo', 25, 17, E'P', E'PLANTA', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:07:55.758', E'2012-12-05 11:19:31.742', E'activo', 26, 18, E'E', E'ESTACION', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:08:02.894', E'2012-12-05 11:19:49.014', E'activo', 27, 18, E'P', E'PLANTA', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:13:19.659', NULL, E'activo', 28, 4, E'PSKT', E'Senkata', E'7', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:31:05.634', NULL, E'activo', 29, 5, E'UBO02', E'Unidad de Bombeo 02', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:31:37.099', NULL, E'activo', 30, 5, E'UBO03', E'Unidad de Bombeo 03', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:33:46.098', NULL, E'activo', 31, 5, E'ABL01', E'Alimentacion Bombeo Liquido 01', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:34:28.323', NULL, E'activo', 32, 5, E'ABL02', E'Alimentacion Bombeo Liquido 02', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:35:04.856', NULL, E'activo', 33, 5, E'ABL03', E'Alimentacion Bombeo Liquido 03', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:35:47.904', NULL, E'activo', 34, 5, E'ABG01', E'Alimentacion Bombeo Glp 01', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:36:16.541', NULL, E'activo', 35, 5, E'UCA01', E'Unidad de Compresion de Aire 01', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-04 16:43:06.716', E'2012-12-04 16:50:44.585', E'activo', 36, 13, E'UBO01', E'Unidad de Bombeo 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:43:45.524', NULL, E'activo', 37, 13, E'UBO02', E'Unidad de Bombeo 02', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:44:05.502', NULL, E'activo', 38, 13, E'UBO03', E'Unidad de Bombeo 03', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:45:21.430', NULL, E'activo', 39, 13, E'GEE01', E'Generacion de Energia Electrica 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:45:51.119', NULL, E'activo', 40, 13, E'GEE02', E'Generacion de Energia Electrica 02', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:46:22.551', NULL, E'activo', 41, 13, E'UEN01', E'Unidad de Enfriamiento 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:46:44.633', NULL, E'activo', 42, 13, E'UEN02', E'Unidad de Enfriamiento 02', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:48:46.767', NULL, E'activo', 43, 13, E'SCI01', E'Sistema Contra Incendio 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:49:15.079', NULL, E'activo', 44, 13, E'BPC01', E'Bombeo Producto Contaminado 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:49:37.147', NULL, E'activo', 45, 13, E'PMG01', E'Puente de Medicion de Gas 01', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:52:50.148', NULL, E'activo', 46, 14, E'UBO01', E'UBO01- Unidad de Bombeo 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:53:17.338', NULL, E'activo', 47, 14, E'UBO02', E'UBO02-Unidad de Bombeo 02', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:53:59.734', NULL, E'activo', 48, 14, E'UTP01', E'UTP01-Unidad de Transferencia de Producto 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:54:35.195', NULL, E'activo', 49, 14, E'UCA01', E'UCA01-Unidad de Compresion de Aire 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:55:04.904', NULL, E'activo', 50, 14, E'UCA02', E'UCA02-Unidad de Compresion de Aire 02', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-04 16:55:47.835', NULL, E'activo', 51, 14, E'PGM01', E'PGM01-Puente de Medicion de Gas 01', E'8', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-05 11:05:16.875', E'2012-12-05 11:06:42.966', E'activo', 52, 7, E'EPVI', E'Puerto Villarroel', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:11:55.902', NULL, E'activo', 54, 8, E'PPVI', E'Planta Puerto Villarroel', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:12:28.872', NULL, E'activo', 55, 8, E'PTRI', E'Planta Trinidad', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:13:12.904', NULL, E'activo', 56, 8, E'PRIB', E'Planta Riberalta', E'7', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:21:02.844', NULL, E'activo', 57, 20, E'ECSC', E'Estacion Santa Cruz', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:21:46.453', NULL, E'activo', 58, 20, E'ECAB', E'Estacion Cabezas', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:22:13.359', NULL, E'activo', 59, 20, E'ETAT', E'Estacion Tatarenda', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:22:46.004', NULL, E'activo', 60, 20, E'ECCH', E'Estacion Chorety', E'6', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:29:24.737', NULL, E'activo', 61, 21, E'PSCZ', E'Planta Santa Cruz', E'5', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:31:00.321', NULL, E'activo', 62, 21, E'PCAM', E'Planta Camiri', E'10', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 11:33:38.455', NULL, E'activo', 63, 21, E'PSJC', E'Planta San Jose de Chiquitos', E'9', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 18:53:25.582', NULL, E'activo', 64, NULL, E'VEH', E'Vehiculos', E'', NULL, NULL, NULL, NULL);                            
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-05 18:55:05.534', E'2012-12-20 13:45:07.237', E'activo', 65, 64, E'AREA', E'OCCIDENTE', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-05 18:55:24.363', E'2012-12-20 13:46:41.590', E'activo', 66, 64, E'AREA', E'ORIENTE', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-05 18:55:44.264', E'2012-12-20 13:46:53.746', E'activo', 67, 64, E'AREA', E'SUR', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-05 18:59:21.931', E'2012-12-20 13:51:30.243', E'activo', 71, 65, E'OCOLP', E'OCOLP', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-05 18:59:31.954', E'2012-12-20 13:51:45.620', E'activo', 72, 65, E'PCPV', E'PCPV', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-05 19:12:54.266', NULL, E'activo', 75, 71, E'E', E'Estacion', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-20 14:02:41.718', NULL, E'activo', 76, 71, E'P', E'Planta', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-20 14:03:07.347', NULL, E'activo', 77, 71, E'D', E'Ducto', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-20 14:06:48.392', NULL, E'activo', 78, 71, E'M', E'Mantenimiento', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-20 14:08:08.065', NULL, E'activo', 79, 71, E'S', E'Superintendencia', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, NULL, E'2012-12-20 14:08:31.425', NULL, E'activo', 80, 71, E'P', E'Proyectos', E'', NULL, NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion", "id_localizacion_fk", "codigo", "nombre", "coordenadas", "ubicacion", "desc_ubicacion", "latitud", "longitud")
VALUES (1, 1, E'2012-12-20 15:09:25.081', E'2012-12-20 15:10:54.498', E'activo', 81, 64, E'C', E'CENTRO', E'', NULL, NULL, NULL, NULL);


/* Data for the 'gem.tuni_cons' table  (Records 1 - 68) */
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 17:39:47.950', E'2012-12-03 17:39:47.950', E'activo', 3, 2, NULL, E'SLB', E'SISTEMA DE LUBRICACIÓN', E'tuc', E'borrador', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 17:39:47.951', E'2012-12-03 17:39:47.951', E'activo', 4, 3, NULL, E'CCO', E'COMBUSTIBLES Y  CONSUMIBLES', E'tuc', E'borrador', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 17:39:47.953', E'2012-12-03 17:39:47.953', E'activo', 7, 2, NULL, E'SLB', E'SISTEMA DE LUBRICACIÓN', E'uc', E'registrado', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 17:39:47.954', E'2012-12-03 17:39:47.954', E'activo', 8, 3, NULL, E'CCO', E'COMBUSTIBLES Y  CONSUMIBLES', E'uc', E'registrado', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 17:39:47.954', E'2012-12-03 17:39:47.954', E'activo', 9, 1, 12, E'MCBI-002', E'MOTOR DE COMBUSTIÓN INTERNA', E'uc', E'registrado', E'raiz', 2, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 17:39:47.955', E'2012-12-03 17:39:47.955', E'activo', 10, 2, NULL, E'SLB', E'SISTEMA DE LUBRICACIÓN', E'uc', E'registrado', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 17:39:47.956', E'2012-12-03 17:39:47.956', E'activo', 11, 3, NULL, E'CCO', E'COMBUSTIBLES Y  CONSUMIBLES', E'uc', E'registrado', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 18:31:43.519', E'2012-12-03 18:31:43.519', E'activo', 18, NULL, 6, E'EST-CBA-01', E'SAYARI', E'uc', E'registrado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-03 18:31:43.519', E'2012-12-03 18:31:43.519', E'activo', 19, 4, 6, E'ME98', E'MOTOR ELECTRICO', E'uc', E'registrado', E'raiz', 12, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 17:39:47.951', E'2012-12-04 17:00:16.142', E'activo', 5, NULL, 5, E'ECBB', E'ESTACION COCHABAMBA', E'uc', E'registrado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 18:10:08.909', E'2012-12-04 17:03:52.643', E'activo', 14, NULL, 11, E'ESAY', E'ESTACION SAYARI', E'uc', E'registrado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-11 11:08:51.918', E'2012-12-11 11:11:12.964', E'inactivo', 36, 14, 11, E'del1_ECBB-UBO01-BO', E'BOMBA', E'uc', E'registrado', E'raiz', 33, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 17:39:47.952', E'2012-12-05 16:29:37.191', E'inactivo', 6, 1, 11, E'del1_M', E'MOTOR DE COMBUSTIÓN INTERNA A GAS', E'uc', E'registrado', E'raiz', 2, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 18:10:08.909', E'2012-12-05 16:29:41.701', E'inactivo', 15, 4, 11, E'del1_ME01', E'MOTOR ELECTRICO', E'uc', E'registrado', E'raiz', 12, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-11 11:08:42.549', E'2012-12-11 11:11:17.442', E'inactivo', 35, 13, 11, E'del1_ECBB-UBO01-VV', E'VARIADOR', E'uc', E'registrado', E'raiz', 32, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 18:28:27.185', E'2012-12-05 16:29:45.766', E'inactivo', 16, 4, 11, E'del1_ME02', E'MOTOR ELECTRICO', E'uc', E'registrado', E'raiz', 12, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 18:29:43.310', E'2012-12-05 16:29:49.749', E'inactivo', 17, 4, 11, E'del1_ME03', E'MOTOR ELECTRICO', E'uc', E'registrado', E'raiz', 12, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:12:13.075', E'2012-12-11 11:12:13.075', E'activo', 38, 13, 11, E'ECBB-UBO01-VV01', E'VARIADOR', E'uc', E'registrado', E'raiz', 32, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-05 16:55:09.667', NULL, E'inactivo', 21, 11, NULL, E'EBO', E'ELECTROBOMBA', E'tuc', E'borrador', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-05 17:30:14.249', NULL, E'activo', 23, 3, NULL, E'CC', E'COMBUSTIBLE Y CONSUMIBLES', E'tuc', E'borrador', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 18:07:30.450', E'2012-12-19 16:20:41.384', E'activo', 13, 5, NULL, E'RE1', E'REDUCTOR', E'tuc', E'borrador', E'raiz', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 25, 2, NULL, E'ECBB-UBO01-ME01-', E'SISTEMA DE LUBRICACION', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 26, 3, NULL, E'ECBB-UBO01-ME01-CC', E'COMBUSTIBLE Y CONSUMIBLES', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 27, NULL, 29, E'ECBB-UBO02', E'UNIDAD DE BOMBEO 02', E'uc', E'registrado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 29, 2, NULL, E'ECBB-UBO02-ME02-', E'SISTEMA DE LUBRICACION', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 30, 3, NULL, E'ECBB-UBO02-ME02-CC', E'COMBUSTIBLE Y CONSUMIBLES', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-05 17:35:15.544', E'2012-12-05 17:46:43.610', E'activo', 28, 4, 29, E'ECBB-UBO02-ME02', E'MOTOR ELECTRICO', E'uc', E'registrado', E'raiz', 12, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 17:39:47.947', E'2012-12-05 19:16:28.097', E'activo', 1, NULL, NULL, E'EQU', E'EQUIPOS ', E'tuc', E'aprobado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-05 16:55:49.922', E'2012-12-11 11:08:01.875', E'activo', 22, 11, NULL, E'EBO', E'ELECTROBOMBA', E'tuc', E'aprobado', E'raiz', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-11 11:04:57.817', E'2012-12-11 11:08:10.167', E'activo', 32, 13, NULL, E'VV', E'VARIADOR', E'tuc', E'aprobado', E'raiz', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-05 19:15:39.735', E'2012-12-20 13:55:12.646', E'activo', 31, 12, NULL, E'VEH', E'VEHICULOS', E'tuc', E'aprobado', E'raiz', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:14:29.899', E'2012-12-11 11:14:29.899', E'activo', 40, 5, 29, E'ECBB-UBO02-RE02', E'REDUCTOR', E'uc', E'registrado', E'raiz', 13, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:14:38.798', E'2012-12-11 11:14:38.798', E'activo', 41, 13, 29, E'ECBB-UBO02-VV02', E'VARIADOR', E'uc', E'registrado', E'raiz', 32, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-20 13:55:42.101', E'2012-12-20 13:55:42.101', E'activo', 59, NULL, 71, E'AREA-OCOLP', E'OCOLP', E'uc', E'registrado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:14:48.515', E'2012-12-11 11:14:48.515', E'activo', 42, 14, 29, E'ECBB-UBO02-BO02', E'BOMBA', E'uc', E'registrado', E'raiz', 33, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-11 11:08:33.796', E'2012-12-11 11:10:42.345', E'inactivo', 34, 5, 11, E'del1_ECBB-UBO01-RE', E'REDUCTOR', E'uc', E'registrado', E'raiz', 13, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 51, 3, NULL, E'ECBB-UBO01-RE01-CC', E'COMBUSTIBLE Y CONSUMIBLES', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 43, NULL, 30, E'ECBB-UBO03', E'UNIDAD DE BOMBEO 03', E'uc', E'registrado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 44, 4, 30, E'ECBB-UBO03-ME03', E'MOTOR ELECTRICO', E'uc', E'registrado', E'raiz', 12, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 45, 2, NULL, E'ECBB-UBO03-ME03-', E'SISTEMA DE LUBRICACION', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 46, 3, NULL, E'ECBB-UBO03-ME03-CC', E'COMBUSTIBLE Y CONSUMIBLES', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:15:35.997', E'2012-12-11 11:15:35.997', E'activo', 47, 5, 30, E'ECBB-UBO03-RE03', E'REDUCTOR', E'uc', E'registrado', E'raiz', 13, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:18:04.776', E'2012-12-11 11:18:04.776', E'activo', 48, 13, 30, E'ECBB-UBO03-VV03', E'VARIADOR', E'uc', E'registrado', E'raiz', 32, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 11:18:22.451', E'2012-12-11 11:18:22.451', E'activo', 49, 14, 30, E'ECBB-UBO03-BO03', E'BOMBA', E'uc', E'registrado', E'raiz', 33, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-05 16:39:35.260', E'2012-12-11 11:32:39.787', E'activo', 20, 2, NULL, E'SL', E'SISTEMA DE LUBRICACION', E'tuc', E'borrador', E'rama', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 52, 2, NULL, E'ECBB-UBO01-RE01-SL', E'SISTEMA DE LUBRICACION', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-11 11:12:00.550', E'2012-12-11 16:09:54.827', E'inactivo', 37, 5, 11, E'del1_ECBB-UBO01-RE01', E'REDUCTOR', E'uc', E'registrado', E'raiz', 13, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 18:05:46.676', E'2012-12-18 21:18:01.193', E'activo', 12, 4, NULL, E'ME', E'MOTOR ELECTRICO', E'tuc', E'borrador', E'raiz', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-14 11:12:23.385', NULL, E'activo', 54, 6, NULL, E'', E'MOTOR DE COMBUSTION', E'tuc', E'borrador', E'raiz', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-14 11:11:48.070', NULL, E'inactivo', 53, NULL, NULL, E'M', E'MOTOR DE COMBUSTION', E'tuc', E'borrador', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-14 11:17:44.495', E'2012-12-14 11:17:44.495', E'activo', 55, NULL, 36, E'ESAY-UBO01', E'UNIDAD DE BOMBEO 01', E'uc', E'registrado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-03 17:39:47.948', E'2012-12-14 11:17:26.289', E'activo', 2, 1, NULL, E'MC', E'MOTOR DE COMBUSTIÓN INTERNA', E'tuc', E'aprobado', E'raiz', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-14 11:17:44.495', E'2012-12-14 11:17:44.495', E'activo', 56, 1, 36, E'ESAY-UBO01-MC01', E'MOTOR DE COMBUSTIÓN INTERNA', E'uc', E'registrado', E'raiz', 2, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-14 11:17:44.495', E'2012-12-14 11:17:44.495', E'activo', 57, 2, NULL, E'ESAY-UBO01-MC01-SLB', E'SISTEMA DE LUBRICACIÓN', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-14 11:17:44.495', E'2012-12-14 11:17:44.495', E'activo', 58, 3, NULL, E'ESAY-UBO01-MC01-CCO', E'COMBUSTIBLES Y  CONSUMIBLES', E'uc', E'registrado', E'rama', NULL, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-11 11:12:24.083', E'2012-12-18 18:20:44.392', E'activo', 39, 14, 11, E'ECBB-UBO01-BO01', E'BOMBA', E'uc', E'registrado', E'raiz', 33, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-05 17:32:25.789', E'2012-12-18 18:20:48.651', E'activo', 24, 4, 11, E'ECBB-UBO01-ME01', E'MOTOR ELECTRICO', E'uc', E'registrado', E'raiz', 12, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-11 16:10:18.256', E'2012-12-18 18:20:52.201', E'activo', 50, 4, 11, E'ECBB-UBO01-RE01', E'REDUCTOR', E'uc', E'registrado', E'raiz', 12, NULL, True, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-11 11:06:27.460', E'2012-12-19 16:44:04.845', E'activo', 33, 14, NULL, E'BO', E'BOMBA', E'tuc', E'aprobado', E'raiz', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-20 13:55:42.101', E'2012-12-20 13:58:09.539', E'inactivo', 60, 12, 71, E'del1_AREA-OCOLP-VEH', E'VEHICULOS', E'uc', E'registrado', E'raiz', 31, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-20 13:59:48.095', E'2012-12-20 13:59:48.095', E'activo', 61, NULL, 75, E'OCOLP-E', E'ESTACION', E'uc', E'registrado', E'base', NULL, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, 1, E'2012-12-20 13:59:48.095', E'2012-12-20 14:02:08.337', E'inactivo', 62, 12, 75, E'del1_OCOLP-E-VEH-533-FHR', E'VEHICULOS', E'uc', E'registrado', E'raiz', 31, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-20 14:04:39.960', E'2012-12-20 14:04:39.960', E'activo', 63, 12, 75, E'OCOLP-E-VEH-533-FNG', E'VEHICULOS', E'uc', E'registrado', E'raiz', 31, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-20 14:09:51.679', E'2012-12-20 14:09:51.679', E'activo', 64, 12, 75, E'OCOLP-E-VEH-533-FTY', E'VEHICULOS', E'uc', E'registrado', E'raiz', 31, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-20 14:10:24.330', E'2012-12-20 14:10:24.330', E'activo', 65, 12, 75, E'OCOLP-E-VEH-948-IDD', E'VEHICULOS', E'uc', E'registrado', E'raiz', 31, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-20 14:10:51.880', E'2012-12-20 14:10:51.880', E'activo', 66, 12, 75, E'OCOLP-E-VEH-948-IBU', E'VEHICULOS', E'uc', E'registrado', E'raiz', 31, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-20 14:11:17.336', E'2012-12-20 14:11:17.336', E'activo', 67, 12, 75, E'OCOLP-E-VEH-1283-KHU', E'VEHICULOS', E'uc', E'registrado', E'raiz', 31, NULL, False, NULL, NULL, NULL, NULL, NULL);
INSERT INTO gem.tuni_cons ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons", "id_tipo_equipo", "id_localizacion", "codigo", "nombre", "tipo", "estado", "tipo_nodo", "id_plantilla", "tipo_unicons", "incluir_calgen", "id_usuarios", "herramientas_especiales", "otros_datos_tec", "funcion", "punto_recepcion_despacho")
VALUES (1, NULL, E'2012-12-20 14:11:52.512', E'2012-12-20 14:11:52.512', E'activo', 68, 12, 75, E'OCOLP-E-VEH-1299-IFD', E'VEHICULOS', E'uc', E'registrado', E'raiz', 31, NULL, False, NULL, NULL, NULL, NULL, NULL);


/* Data for the 'gem.tinstruc_seg' table  (Records 1 - 1) */
INSERT INTO gem.tinstruc_seg ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_instruc_seg", "codigo", "descripcion")
VALUES (1, NULL, E'2012-12-14 10:45:10.720', NULL, E'activo', 1, E'Trabajo en Alturas', E'1');


/* Data for the 'gem.tlocalizacion_med' table  (Records 1 - 29) */
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:55:15.399', NULL, E'activo', 4, 11, NULL, E'2012-11-01', 1, '20', '0', '4', '0');
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:56:12.244', NULL, E'activo', 5, 11, NULL, E'2012-11-02', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:56:25.003', NULL, E'activo', 6, 11, NULL, E'2012-11-03', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:56:57.698', NULL, E'activo', 7, 11, NULL, E'2012-11-04', 2, '10', NULL, NULL, '14');
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:57:20.246', NULL, E'activo', 8, 11, NULL, E'2012-11-05', 1, '22', NULL, '2', NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:57:35.646', NULL, E'activo', 9, 11, NULL, E'2012-11-06', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:57:52.463', NULL, E'activo', 10, 11, NULL, E'2012-11-07', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:58:03.830', NULL, E'activo', 11, 11, NULL, E'2012-11-08', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:58:17.166', NULL, E'activo', 12, 11, NULL, E'2012-11-09', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:58:28.191', NULL, E'activo', 13, 11, NULL, E'2012-11-10', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:58:49.323', NULL, E'activo', 14, 11, NULL, E'2012-11-11', 1, '12', NULL, '12', NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:59:06.814', NULL, E'activo', 15, 11, NULL, E'2012-11-13', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 10:59:22.940', NULL, E'activo', 16, 11, NULL, E'2012-11-14', 1, '20', NULL, NULL, '4');
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:01:40.672', NULL, E'activo', 17, 11, NULL, E'2012-11-15', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:01:57.701', NULL, E'activo', 18, 11, NULL, E'2012-11-16', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:02:09.478', NULL, E'activo', 19, 11, NULL, E'2012-11-17', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:02:53.198', NULL, E'activo', 20, 11, NULL, E'2012-11-18', 3, '8', NULL, '10', '6');
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:03:13.135', NULL, E'activo', 21, 11, NULL, E'2012-11-19', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:03:23.626', NULL, E'activo', 22, 11, NULL, E'2012-11-20', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:03:35.630', NULL, E'activo', 23, 11, NULL, E'2012-11-21', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:03:45.628', NULL, E'activo', 24, 11, NULL, E'2012-11-22', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:03:56.879', NULL, E'activo', 25, 11, NULL, E'2012-11-23', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:04:13.547', NULL, E'activo', 26, 11, NULL, E'2012-11-24', 1, '20', NULL, NULL, '4');
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:04:31.695', NULL, E'activo', 27, 11, NULL, E'2012-11-25', 1, '22', NULL, '2', NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:04:44.261', NULL, E'activo', 28, 11, NULL, E'2012-11-26', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:04:57.448', NULL, E'activo', 29, 11, NULL, E'2012-11-27', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:05:12.044', NULL, E'activo', 30, 11, NULL, E'2012-11-28', 1, '10', NULL, NULL, '14');
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:05:35.108', NULL, E'activo', 31, 11, NULL, E'2012-11-29', 0, '24', NULL, NULL, NULL);
INSERT INTO gem.tlocalizacion_med ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_localizacion_med", "id_localizacion", "id_uni_cons", "fecha_med", "num_paros", "tiempo_op_hrs", "tiempo_standby_hrs", "tiempo_mnp_hrs", "tiempo_mpp_hrs")
VALUES (1, NULL, E'2012-12-14 11:05:49.711', NULL, E'activo', 32, 11, NULL, E'2012-11-30', 1, '20', NULL, '4', NULL);


/* Data for the 'gem.tmant_predef' table  (Records 1 - 17) */
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, 1, E'2012-11-06 12:26:37.546', E'2012-12-04 17:47:39.468', E'activo', 2, E'MPP2', E'Mantenimiento Preventivo Planificado 2', NULL, 4, NULL, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, 1, E'2012-11-06 12:26:37.546', E'2012-12-04 17:57:25.912', E'activo', 3, E'MPP1', E'Mantenimiento Preventivo Planificado 1', NULL, 6, NULL, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-04 17:59:35.790', NULL, E'activo', 4, E'MPP2', E'Mantenimiento Preventivo Planificado 2', NULL, 6, NULL, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-04 18:00:09.389', NULL, E'activo', 5, E'MPP3', E'Mantenimiento Preventivo Planificado 3', NULL, 6, NULL, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-04 18:00:44.132', NULL, E'activo', 6, E'MPP4', E'Mantenimiento Preventivo Planificado 4', NULL, 6, NULL, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-04 18:07:59.054', NULL, E'activo', 7, E'MPP1', E'Mantenimiento Preventivo Planificado 1', NULL, 7, NULL, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-04 18:08:30.421', NULL, E'activo', 8, E'MPP2', E'Mantenimeinto Preventivo Planificado 2', NULL, 7, NULL, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 18:19:30.710', NULL, E'activo', 9, E'INS', E'Inspeccion', NULL, 14, 1, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 18:54:56.658', NULL, E'activo', 11, E'VIB', E'Analisis de Vibracion', NULL, 4, 1, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 18:57:27.041', NULL, E'activo', 12, E'LIM', E'Limpieza General', NULL, 4, 5, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 18:58:26.607', NULL, E'activo', 13, E'MPP1', E'MPP1', NULL, 13, 1, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 18:59:05.023', NULL, E'activo', 14, E'MPP2', E'MPP2', NULL, 13, 1, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, 1, E'2012-12-19 18:54:01.142', E'2012-12-19 19:02:51.381', E'activo', 10, E'VER', E'Verificar protector de fase', NULL, 4, 4, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, 1, E'2012-11-06 12:26:37.546', E'2012-12-20 08:26:41.281', E'activo', 1, E'MPP1', E'MPP1', NULL, 4, 1, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-20 08:35:34.979', NULL, E'activo', 15, E'VIB', E'Analisis de Vibracion', NULL, 13, 1, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-20 08:36:28.216', NULL, E'activo', 16, E'MPP', E'MPP3', NULL, 13, 1, NULL);
INSERT INTO gem.tmant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef", "codigo", "nombre", "descripcion", "id_tipo_equipo", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-20 08:37:17.238', NULL, E'activo', 17, E'MPP', E'MPP1', NULL, 5, 1, NULL);


/* Data for the 'gem.tmant_predef_det' table  (Records 1 - 16) */
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-11-06 12:26:50.745', NULL, E'activo', 5, 3, E'Revisión de la compresión del motor', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-11-06 12:27:00.244', NULL, E'activo', 6, 3, E'Cambio de filtro de aceite', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:33:24.703', NULL, E'activo', 7, 1, E'Verificar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:34:02.332', NULL, E'activo', 8, 1, E'Detectar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:34:50.598', NULL, E'activo', 9, 1, E'Detectar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:35:13.962', NULL, E'activo', 10, 1, E'Detectar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:35:35.778', NULL, E'activo', 11, 1, E'Detectar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:36:01.361', NULL, E'activo', 12, 1, E'Verificar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:37:33.493', NULL, E'activo', 13, 1, E'Mantenimiento', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:40:38.876', NULL, E'activo', 14, 1, E'Alineamiento', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:40:59.767', NULL, E'activo', 15, 1, E'Verificar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:41:19.902', NULL, E'activo', 16, 1, E'Verificar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:41:41.666', NULL, E'activo', 17, 1, E'Verificar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:42:39.722', NULL, E'activo', 18, 1, E'Inspeccion', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:43:13.769', NULL, E'activo', 19, 1, E'Verificar', NULL, NULL);
INSERT INTO gem.tmant_predef_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_mant_predef_det", "id_mant_predef", "nombre", "descripcion", "observacion")
VALUES (1, NULL, E'2012-12-04 17:43:43.195', NULL, E'activo', 20, 1, E'Prueba', NULL, NULL);


/* Data for the 'gem.tuni_cons_comp' table  (Records 1 - 58) */
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.957', E'2012-12-03 17:39:47.957', E'activo', 1, 2, 1, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.958', E'2012-12-03 17:39:47.958', E'activo', 2, 3, 2, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.960', E'2012-12-03 17:39:47.960', E'activo', 3, 4, 2, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.960', E'2012-12-03 17:39:47.960', E'activo', 4, 6, 5, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.962', E'2012-12-03 17:39:47.962', E'activo', 5, 7, 6, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.962', E'2012-12-03 17:39:47.962', E'activo', 6, 8, 6, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.963', E'2012-12-03 17:39:47.963', E'activo', 7, 9, 5, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.963', E'2012-12-03 17:39:47.963', E'activo', 8, 10, 9, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 17:39:47.964', E'2012-12-03 17:39:47.964', E'activo', 9, 11, 9, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 18:05:46.676', NULL, E'activo', 10, 12, 1, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 18:07:30.450', NULL, E'activo', 11, 13, 1, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 18:10:08.909', NULL, E'activo', 12, 15, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 18:28:27.185', NULL, E'activo', 13, 16, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 18:29:43.310', NULL, E'activo', 14, 17, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-03 18:31:43.519', NULL, E'activo', 15, 19, 18, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 16:39:35.260', NULL, E'activo', 16, 20, 12, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 16:55:09.667', NULL, E'inactivo', 17, 21, 12, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 16:55:49.922', NULL, E'activo', 18, 22, 1, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 17:30:14.249', NULL, E'activo', 19, 23, 12, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', NULL, E'activo', 20, 24, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', NULL, E'activo', 21, 25, 24, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', NULL, E'activo', 22, 26, 24, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', NULL, E'activo', 23, 28, 27, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', NULL, E'activo', 24, 29, 28, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', NULL, E'activo', 25, 30, 28, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-05 19:15:39.735', NULL, E'activo', 26, 31, 1, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:04:57.817', NULL, E'activo', 27, 32, 1, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:06:27.460', NULL, E'activo', 28, 33, 1, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:08:33.796', NULL, E'activo', 29, 34, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:08:42.549', NULL, E'activo', 30, 35, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:08:51.918', NULL, E'activo', 31, 36, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:12:00.550', NULL, E'activo', 32, 37, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:12:13.075', NULL, E'activo', 33, 38, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:12:24.083', NULL, E'activo', 34, 39, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:14:29.899', NULL, E'activo', 35, 40, 27, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:14:38.798', NULL, E'activo', 36, 41, 27, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:14:48.515', NULL, E'activo', 37, 42, 27, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', NULL, E'activo', 38, 44, 43, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', NULL, E'activo', 39, 45, 44, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', NULL, E'activo', 40, 46, 44, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:15:35.997', NULL, E'activo', 41, 47, 43, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:18:04.776', NULL, E'activo', 42, 48, 43, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 11:18:22.451', NULL, E'activo', 43, 49, 43, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', NULL, E'activo', 44, 50, 14, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', NULL, E'activo', 45, 51, 50, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', NULL, E'activo', 46, 52, 50, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-14 11:12:23.385', NULL, E'activo', 47, 54, 1, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-14 11:17:44.495', NULL, E'activo', 48, 56, 55, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-14 11:17:44.495', NULL, E'activo', 49, 57, 56, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-14 11:17:44.495', NULL, E'activo', 50, 58, 56, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-20 13:55:42.101', NULL, E'activo', 51, 60, 59, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-20 13:59:48.095', NULL, E'activo', 52, 62, 61, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-20 14:04:39.960', NULL, E'activo', 53, 63, 61, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-20 14:09:51.679', NULL, E'activo', 54, 64, 61, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-20 14:10:24.330', NULL, E'activo', 55, 65, 61, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-20 14:10:51.880', NULL, E'activo', 56, 66, 61, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-20 14:11:17.336', NULL, E'activo', 57, 67, 61, E'no', 1);
INSERT INTO gem.tuni_cons_comp ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_comp", "id_uni_cons_hijo", "id_uni_cons_padre", "opcional", "cantidad")
VALUES (1, NULL, E'2012-12-20 14:11:52.512', NULL, E'activo', 58, 68, 61, E'no', 1);


/* Data for the 'gem.tuni_cons_det' table  (Records 1 - 221) */
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-03 18:29:43.310', E'2012-12-03 18:29:43.310', E'activo', 5, 2, 17, E'0001', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-03 18:29:43.310', E'2012-12-03 18:29:43.310', E'activo', 6, 2, 17, E'0002', E'Categoria de Operacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-03 18:31:43.519', E'2012-12-03 18:31:43.519', E'activo', 7, 2, 19, E'0001', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-03 18:31:43.519', E'2012-12-03 18:31:43.519', E'activo', 8, 2, 19, E'0002', E'Categoria de Operacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-03 18:28:27.185', E'2012-12-03 18:34:28.719', E'activo', 3, 2, 16, E'0001', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-03 18:21:21.493', E'2012-12-11 11:22:03.712', E'activo', 2, 2, 12, E'0002', E'Categoria de Operacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:18:18.720', NULL, E'activo', 12, NULL, 12, E'', E'Horas acumuladas', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:18:44.866', NULL, E'activo', 13, NULL, 12, E'', E'Periodo de Monitoreo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:24:02.928', NULL, E'activo', 22, NULL, 12, E'', E'Nema Desg.', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:24:21.466', NULL, E'activo', 25, NULL, 12, E'', E'Corriente de Arranque', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:24:46.590', NULL, E'activo', 28, NULL, 12, E'', E'Año de fabricacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:24:49.822', NULL, E'activo', 29, NULL, 12, E'', E'Ratio', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:25:10.744', NULL, E'activo', 32, NULL, 12, E'', E'Telefono fabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:25:44.985', NULL, E'activo', 34, NULL, 12, E'', E'Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:25:56.149', E'2012-12-05 17:26:15.526', E'activo', 36, NULL, 12, E'', E'Telefono Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:26:30.328', NULL, E'activo', 38, NULL, 12, E'', E'RPM Maximo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:26:35.891', NULL, E'activo', 39, NULL, 12, E'', E'RPM Minimo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:27:35.291', NULL, E'activo', 40, NULL, 12, E'', E'Combustible', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:27:40.847', NULL, E'activo', 41, NULL, 12, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:30:31.248', NULL, E'activo', 47, NULL, 23, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:30:39.020', NULL, E'activo', 48, NULL, 23, E'', E'Presion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:30:47.402', NULL, E'activo', 49, NULL, 23, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 50, NULL, 25, E'', E'Lubricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 51, NULL, 25, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 52, NULL, 25, E'', E'Cantidad', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 53, NULL, 25, E'', E'Metodo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 54, NULL, 26, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 55, NULL, 26, E'', E'Presion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 56, NULL, 26, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 57, 2, 24, E'0001', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 58, 2, 24, E'0002', E'Categoria de Operacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 59, NULL, 24, E'', E'Horas acumuladas', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 60, NULL, 24, E'', E'Periodo de Monitoreo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 61, NULL, 24, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 62, NULL, 24, E'', E'Aplicacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 63, NULL, 24, E'', E'Categoria de Instalacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 64, NULL, 24, E'', E'Marca', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 65, NULL, 24, E'', E'Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 66, NULL, 24, E'', E'Modelo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 67, NULL, 24, E'', E'Tension Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 68, NULL, 24, E'', E'Nema Desg.', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 69, NULL, 24, E'', E'Corriente Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 70, NULL, 24, E'', E'Serie', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 71, NULL, 24, E'', E'Corriente de Arranque', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 72, NULL, 24, E'', E'Arreglo del motor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 73, NULL, 24, E'', E'No de fases', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 74, NULL, 24, E'', E'Año de fabricacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 75, NULL, 24, E'', E'Ratio', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 76, NULL, 24, E'', E'Frabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 77, NULL, 24, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 78, NULL, 24, E'', E'Telefono fabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 79, NULL, 24, E'', E'Temp. Ambiente Max', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 80, NULL, 24, E'', E'Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 81, NULL, 24, E'', E'Factor de Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 82, NULL, 24, E'', E'Telefono Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 83, NULL, 24, E'', E'RPM Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 84, NULL, 24, E'', E'RPM Maximo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 85, NULL, 24, E'', E'RPM Minimo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-03 18:19:57.289', E'2012-12-11 11:21:32.351', E'activo', 1, 2, 12, E'0001', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:19:07.451', E'2012-12-11 11:23:29.362', E'activo', 14, NULL, 12, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:19:15.784', E'2012-12-11 11:23:46.180', E'activo', 15, NULL, 12, E'', E'Aplicacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:19:28.203', E'2012-12-11 11:24:10.949', E'activo', 16, NULL, 12, E'', E'Categoria de Instalacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:23:43.138', E'2012-12-11 11:25:04.376', E'activo', 19, NULL, 12, E'', E'Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:19:47.696', E'2012-12-11 11:24:43.293', E'activo', 17, NULL, 12, E'', E'Marca', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:23:47.463', E'2012-12-11 11:25:21.334', E'activo', 20, NULL, 12, E'', E'Modelo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:23:52.807', E'2012-12-11 11:25:39.059', E'activo', 21, NULL, 12, E'', E'Tension Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:24:09.230', E'2012-12-11 11:26:06.077', E'activo', 23, NULL, 12, E'', E'Corriente Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:24:12.676', E'2012-12-11 11:26:22.657', E'activo', 24, NULL, 12, E'', E'Serie', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:24:28.360', E'2012-12-11 11:29:01.700', E'activo', 26, NULL, 12, E'', E'Arreglo del motor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:24:35.722', E'2012-12-11 11:29:17.102', E'activo', 27, NULL, 12, E'', E'No de fases', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:24:57.548', E'2012-12-11 11:29:43.988', E'activo', 30, NULL, 12, E'', E'Frabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:25:01.885', E'2012-12-11 11:30:10.224', E'activo', 31, NULL, 12, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:25:38.331', E'2012-12-11 11:30:28.036', E'activo', 33, NULL, 12, E'', E'Temp. Ambiente Max', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:25:51.510', E'2012-12-11 11:30:50.704', E'activo', 35, NULL, 12, E'', E'Factor de Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:26:24.801', E'2012-12-11 11:31:10.116', E'activo', 37, NULL, 12, E'', E'RPM Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:27:54.343', E'2012-12-11 11:31:56.596', E'activo', 42, NULL, 12, E'', E'Tipo de Mantenimiento', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:29:11.739', E'2012-12-11 11:35:04.141', E'activo', 44, NULL, 20, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:29:15.949', E'2012-12-11 11:35:13.011', E'activo', 45, NULL, 20, E'', E'Cantidad', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:29:20.856', E'2012-12-11 11:35:29.455', E'activo', 46, NULL, 20, E'', E'Metodo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-05 17:29:06.915', E'2012-12-11 11:35:52.552', E'activo', 43, NULL, 20, E'', E'Lubricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 86, NULL, 24, E'', E'Combustible', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 87, NULL, 24, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 88, NULL, 24, E'', E'Tipo de Mantenimiento', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 89, NULL, 29, E'', E'Lubricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 90, NULL, 29, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 91, NULL, 29, E'', E'Cantidad', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 92, NULL, 29, E'', E'Metodo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 93, NULL, 30, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 94, NULL, 30, E'', E'Presion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 95, NULL, 30, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 96, 2, 28, E'0001', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 97, 2, 28, E'0002', E'Categoria de Operacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 98, NULL, 28, E'', E'Horas acumuladas', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 99, NULL, 28, E'', E'Periodo de Monitoreo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 100, NULL, 28, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 101, NULL, 28, E'', E'Aplicacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 102, NULL, 28, E'', E'Categoria de Instalacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 103, NULL, 28, E'', E'Marca', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 104, NULL, 28, E'', E'Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 105, NULL, 28, E'', E'Modelo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 106, NULL, 28, E'', E'Tension Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 107, NULL, 28, E'', E'Nema Desg.', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 108, NULL, 28, E'', E'Corriente Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 109, NULL, 28, E'', E'Serie', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 110, NULL, 28, E'', E'Corriente de Arranque', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 111, NULL, 28, E'', E'Arreglo del motor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 112, NULL, 28, E'', E'No de fases', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 113, NULL, 28, E'', E'Año de fabricacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 114, NULL, 28, E'', E'Ratio', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 115, NULL, 28, E'', E'Frabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 116, NULL, 28, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 117, NULL, 28, E'', E'Telefono fabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 118, NULL, 28, E'', E'Temp. Ambiente Max', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 119, NULL, 28, E'', E'Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 120, NULL, 28, E'', E'Factor de Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 121, NULL, 28, E'', E'Telefono Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 122, NULL, 28, E'', E'RPM Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 123, NULL, 28, E'', E'RPM Maximo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 124, NULL, 28, E'', E'RPM Minimo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 125, NULL, 28, E'', E'Combustible', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 126, NULL, 28, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 127, NULL, 28, E'', E'Tipo de Mantenimiento', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 128, NULL, 45, E'', E'Lubricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 129, NULL, 45, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 130, NULL, 45, E'', E'Cantidad', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 131, NULL, 45, E'', E'Metodo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 132, NULL, 46, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 133, NULL, 46, E'', E'Presion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 134, NULL, 46, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 135, 2, 44, E'0001', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 136, 2, 44, E'0002', E'Categoria de Operacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 137, NULL, 44, E'', E'Horas acumuladas', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 138, NULL, 44, E'', E'Periodo de Monitoreo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 139, NULL, 44, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 140, NULL, 44, E'', E'Aplicacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 141, NULL, 44, E'', E'Categoria de Instalacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 142, NULL, 44, E'', E'Marca', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 143, NULL, 44, E'', E'Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 144, NULL, 44, E'', E'Modelo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 145, NULL, 44, E'', E'Tension Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 146, NULL, 44, E'', E'Nema Desg.', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 147, NULL, 44, E'', E'Corriente Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 148, NULL, 44, E'', E'Serie', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 149, NULL, 44, E'', E'Corriente de Arranque', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 150, NULL, 44, E'', E'Arreglo del motor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 151, NULL, 44, E'', E'No de fases', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 152, NULL, 44, E'', E'Año de fabricacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 153, NULL, 44, E'', E'Ratio', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 154, NULL, 44, E'', E'Frabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 155, NULL, 44, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 156, NULL, 44, E'', E'Telefono fabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 157, NULL, 44, E'', E'Temp. Ambiente Max', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 158, NULL, 44, E'', E'Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 159, NULL, 44, E'', E'Factor de Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 160, NULL, 44, E'', E'Telefono Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 161, NULL, 44, E'', E'RPM Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 162, NULL, 44, E'', E'RPM Maximo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 163, NULL, 44, E'', E'RPM Minimo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 164, NULL, 44, E'', E'Combustible', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 165, NULL, 44, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 166, NULL, 44, E'', E'Tipo de Mantenimiento', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 168, NULL, 51, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 169, NULL, 51, E'', E'Presion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 170, NULL, 51, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 171, NULL, 52, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 172, NULL, 52, E'', E'Cantidad', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 173, NULL, 52, E'', E'Metodo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 174, NULL, 52, E'', E'Lubricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 175, 2, 50, E'0002', E'Categoria de Operacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 176, NULL, 50, E'', E'Horas acumuladas', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 177, NULL, 50, E'', E'Periodo de Monitoreo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 178, NULL, 50, E'', E'Nema Desg.', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 179, NULL, 50, E'', E'Corriente de Arranque', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 180, NULL, 50, E'', E'Año de fabricacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 181, NULL, 50, E'', E'Ratio', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 182, NULL, 50, E'', E'Telefono fabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 183, NULL, 50, E'', E'Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 184, NULL, 50, E'', E'Telefono Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 185, NULL, 50, E'', E'RPM Maximo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 186, NULL, 50, E'', E'RPM Minimo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 187, NULL, 50, E'', E'Combustible', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 188, NULL, 50, E'', E'Caudal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 189, 2, 50, E'0001', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 190, NULL, 50, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 191, NULL, 50, E'', E'Aplicacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 192, NULL, 50, E'', E'Categoria de Instalacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 193, NULL, 50, E'', E'Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 194, NULL, 50, E'', E'Marca', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 195, NULL, 50, E'', E'Modelo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 196, NULL, 50, E'', E'Tension Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 197, NULL, 50, E'', E'Corriente Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 198, NULL, 50, E'', E'Serie', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 199, NULL, 50, E'', E'Arreglo del motor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 200, NULL, 50, E'', E'No de fases', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 201, NULL, 50, E'', E'Frabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 202, NULL, 50, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 203, NULL, 50, E'', E'Temp. Ambiente Max', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 204, NULL, 50, E'', E'Factor de Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 205, NULL, 50, E'', E'RPM Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 206, NULL, 50, E'', E'Tipo de Mantenimiento', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, 1, E'2012-12-19 15:53:50.147', E'2012-12-19 16:02:21.868', E'activo', 207, NULL, 38, E'', E'Clase', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:03:06.875', NULL, E'activo', 208, NULL, 38, E'', E'Categoria de Operacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:03:27.935', NULL, E'activo', 209, NULL, 38, E'', E'Horas Acumuladas', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:03:44.908', NULL, E'activo', 210, NULL, 38, E'', E'Periodo de Monitoreo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:03:54.219', NULL, E'activo', 211, NULL, 38, E'', E'Tipo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:04:02.245', NULL, E'activo', 212, NULL, 38, E'', E'Aplicacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:04:11.234', NULL, E'activo', 213, NULL, 38, E'', E'Categoria de Instalacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:04:20.493', NULL, E'activo', 214, NULL, 38, E'', E'Marca', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:04:35.853', NULL, E'activo', 215, NULL, 38, E'', E'Potencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:05:06.808', NULL, E'activo', 216, NULL, 38, E'', E'Modelo', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:05:27.407', NULL, E'activo', 217, NULL, 38, E'', E'Serie', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:05:54.898', NULL, E'activo', 218, NULL, 38, E'', E'Ratio', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:06:01.426', NULL, E'activo', 219, NULL, 38, E'', E'Frecuencia', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:06:41.971', NULL, E'activo', 220, NULL, 38, E'', E'Año de Fabricacion', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:06:56.966', NULL, E'activo', 221, NULL, 38, E'', E'Fabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:07:22.381', NULL, E'activo', 222, NULL, 38, E'', E'Telefono Fabricante', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:07:52.841', NULL, E'activo', 223, NULL, 38, E'', E'Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:08:01.854', NULL, E'activo', 224, NULL, 38, E'', E'Telefono Proveedor', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:08:24.259', NULL, E'activo', 225, NULL, 38, E'', E'RPM Nominal', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 16:08:55.264', NULL, E'activo', 226, NULL, 38, E'', E'Tipo de Mantenimiento', NULL, NULL);
INSERT INTO gem.tuni_cons_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_det", "id_unidad_medida", "id_uni_cons", "codigo", "nombre", "descripcion", "valor")
VALUES (1, NULL, E'2012-12-19 19:27:28.308', NULL, E'activo', 227, 11, 2, E'', E'Temperatura', NULL, NULL);


/* Data for the 'gem.tuni_cons_mant_predef' table  (Records 1 - 11) */
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-05 17:44:12.583', NULL, E'activo', 1, 7, 28, 1, '2000', NULL, NULL, 24, 2, '2');
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-05 17:44:47.960', NULL, E'activo', 2, 8, 28, 1, '5000', NULL, NULL, 24, 1, '6');
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 18:14:22.342', NULL, E'activo', 3, 1, 24, 1, '4000', E'2012-12-19 00:00:00', NULL, 24, 1, NULL);
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 18:20:22.242', NULL, E'activo', 5, 9, 39, 1, '1500', E'2012-12-19 00:00:00', NULL, 24, 1, NULL);
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 19:03:27.709', NULL, E'activo', 8, 10, 24, 4, '6', E'2012-12-19 00:00:00', NULL, 24, 4, NULL);
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 19:13:29.384', NULL, E'activo', 9, 13, 38, 1, '2500', E'2012-12-19 00:00:00', NULL, 24, 1, NULL);
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-19 19:13:53.246', NULL, E'activo', 10, 14, 38, 5, '5000', E'2012-12-19 00:00:00', NULL, 24, 1, NULL);
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, 1, E'2012-12-19 19:01:25.376', E'2012-12-19 19:14:36.355', E'activo', 7, 12, 24, 2, '365', E'2012-12-19 00:00:00', NULL, 24, 2, NULL);
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, 1, E'2012-12-19 19:00:41.936', E'2012-12-20 08:22:19.178', E'activo', 6, 11, 24, 1, '4000', E'2013-12-19 00:00:00', NULL, 24, 1, NULL);
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, 1, E'2012-12-19 18:16:28.185', E'2012-12-20 08:29:45.260', E'activo', 4, 2, 24, 1, '16000', E'2012-12-31 00:00:00', NULL, 24, 1, NULL);
INSERT INTO gem.tuni_cons_mant_predef ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_uni_cons_mant_predef", "id_mant_predef", "id_uni_cons", "id_unidad_medida", "frecuencia", "fecha_ini", "ult_fecha_mant", "horas_dia", "id_unidad_medida_estimado", "tiempo_estimado")
VALUES (1, NULL, E'2012-12-20 08:39:07.645', NULL, E'activo', 11, 16, 38, 1, '25000', E'2013-04-18 00:00:00', NULL, 24, 1, NULL);


/* Data for the 'gem.ttipo_variable' table  (Records 1 - 9) */
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-03 18:25:21.543', E'2012-12-03 18:25:21.543', E'activo', 1, 4, 10, E'Presion', NULL, NULL);
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-13 18:25:59.113', E'2012-12-13 18:25:59.113', E'activo', 2, 1, 11, E'temperatura', NULL, NULL);
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-14 11:22:33.755', NULL, E'activo', 3, 6, 12, E'RPM', NULL, NULL);
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-14 11:22:53.203', NULL, E'activo', 4, 6, 10, E'PRE', NULL, NULL);
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-14 11:26:21.356', NULL, E'activo', 5, 6, 11, E'Temperatura', NULL, NULL);
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-14 11:35:59.821', NULL, E'activo', 6, 4, 11, E'Temperatura', NULL, NULL);
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-20 14:13:39.672', E'2012-12-20 14:13:39.672', E'activo', 7, 12, 13, E'Conbustible', NULL, NULL);
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-20 14:14:05.024', E'2012-12-20 14:14:05.024', E'activo', 8, 12, 9, E'Kilometraje', NULL, NULL);
INSERT INTO gem.ttipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_variable", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones")
VALUES (1, NULL, E'2012-12-20 14:16:57.268', E'2012-12-20 14:16:57.268', E'activo', 9, 12, 14, E'Combustible', NULL, NULL);


/* Data for the 'gem.tequipo_variable' table  (Records 1 - 15) */
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-03 18:25:21.543', NULL, E'activo', 1, 12, 1, NULL, '30', '56', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-03 18:28:27.185', E'2012-12-03 18:28:27.185', E'activo', 2, 16, 1, NULL, '30', '56', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-03 18:29:43.310', E'2012-12-03 18:29:43.310', E'activo', 3, 17, 1, NULL, '30', '56', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-03 18:31:43.519', E'2012-12-03 18:31:43.519', E'activo', 4, 19, 1, NULL, '30', '56', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-05 17:32:25.789', E'2012-12-05 17:32:25.789', E'activo', 5, 24, 1, NULL, '30', '56', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-05 17:35:15.544', E'2012-12-05 17:35:15.544', E'activo', 6, 28, 1, NULL, '30', '56', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-11 11:15:25.292', E'2012-12-11 11:15:25.292', E'activo', 7, 44, 1, NULL, '30', '56', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-11 16:10:18.256', E'2012-12-11 16:10:18.256', E'activo', 8, 50, 1, NULL, '30', '56', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-13 18:25:14.561', NULL, E'activo', 9, 9, 1, NULL, '3', '10', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-13 18:25:59.113', NULL, E'activo', 10, 9, 2, NULL, '6', '45', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-19 19:25:31.433', NULL, E'activo', 11, 2, 2, NULL, '100', '200', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-19 19:26:28.082', NULL, E'activo', 12, 2, 3, NULL, '1000', '1500', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-20 09:41:42.772', NULL, E'activo', 13, 24, 6, NULL, '100', '200', E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, NULL, E'2012-12-20 14:14:05.024', NULL, E'activo', 15, 31, 8, NULL, NULL, NULL, E'numeric');
INSERT INTO gem.tequipo_variable ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_variable", "id_uni_cons", "id_tipo_variable", "obs", "valor_min", "valor_max", "tipo")
VALUES (1, 1, E'2012-12-20 14:13:39.672', E'2012-12-20 14:16:57.268', E'activo', 14, 31, 9, NULL, NULL, NULL, E'numeric');


/* Data for the 'gem.tequipo_medicion' table  (Records 1 - 19) */
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-03 18:32:49.564', E'2012-12-03 18:32:49.564', E'estado', 1, 4, NULL, E'2012-12-04', '123', E'02:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-03 18:33:05.101', E'2012-12-03 18:33:05.101', E'estado', 2, 4, NULL, E'2012-12-11', '700', E'01:45:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-03 18:33:25.349', E'2012-12-03 18:33:25.349', E'estado', 3, 4, NULL, E'2012-12-31', '9', E'00:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-13 18:26:17.772', E'2012-12-13 18:26:17.772', E'estado', 4, 9, NULL, E'2012-12-13', '45', E'01:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-13 18:26:17.772', E'2012-12-13 18:26:17.772', E'estado', 5, 10, NULL, E'2012-12-13', '45', E'01:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-13 18:26:30.888', E'2012-12-13 18:26:30.888', E'estado', 6, 9, NULL, E'2012-12-15', '12', E'02:15:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-13 18:26:30.888', E'2012-12-13 18:26:30.888', E'estado', 7, 10, NULL, E'2012-12-15', '34', E'02:15:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-14 11:32:46.139', E'2012-12-14 11:32:46.139', E'estado', 8, 1, NULL, E'2012-12-14', '56', E'06:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-14 11:33:07.462', E'2012-12-14 11:33:07.462', E'estado', 9, 1, NULL, E'2012-12-14', '56', E'07:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-14 11:33:20', E'2012-12-14 11:33:20', E'estado', 10, 1, NULL, E'2012-12-14', '56', E'08:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-19 19:29:33.688', E'2012-12-19 19:29:33.688', E'estado', 11, 5, NULL, E'2012-12-19', '12', E'06:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-19 19:29:51.138', E'2012-12-19 19:29:51.138', E'estado', 12, 5, NULL, E'2012-12-19', '12', E'07:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-19 19:30:06.634', E'2012-12-19 19:30:06.634', E'estado', 13, 5, NULL, E'2012-12-19', '13', E'08:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-19 19:31:01.949', E'2012-12-19 19:31:01.949', E'estado', 14, 5, NULL, E'2012-12-19', '12', E'09:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-20 09:42:44.806', E'2012-12-20 09:42:44.806', E'estado', 15, 13, NULL, E'2012-12-19', '110', E'06:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-20 09:43:05.892', E'2012-12-20 09:43:05.892', E'estado', 16, 13, NULL, E'2012-12-19', '150', E'07:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-20 09:43:23.440', E'2012-12-20 09:43:23.440', E'estado', 17, 13, NULL, E'2012-12-19', '130', E'08:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-20 11:30:06.659', E'2012-12-20 11:30:06.659', E'estado', 18, 5, NULL, E'2012-12-20', '34', E'09:00:00');
INSERT INTO gem.tequipo_medicion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_equipo_medicion", "id_equipo_variable", "observaciones", "fecha_medicion", "medicion", "hora")
VALUES (1, NULL, E'2012-12-20 11:30:06.659', E'2012-12-20 11:30:06.659', E'estado', 19, 13, NULL, E'2012-12-20', '145', E'09:00:00');


/* Data for the 'gem.tfalla_evento' table  (Records 1 - 2) */
INSERT INTO gem.tfalla_evento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_falla_evento", "id_tipo_equipo", "codigo", "nombre", "tipo", "descripcion")
VALUES (1, NULL, E'2012-12-19 14:50:59.665', NULL, E'activo', 2, 4, E'VIB', E'Vibracion excesiva', E'falla', NULL);
INSERT INTO gem.tfalla_evento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_falla_evento", "id_tipo_equipo", "codigo", "nombre", "tipo", "descripcion")
VALUES (1, NULL, E'2012-12-19 14:51:46.399', NULL, E'activo', 3, 4, E'DES', E'Desalineacion', E'falla', NULL);


/* Data for the 'gem.tcalendario_planificado' table  (Records 1 - 34) */
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-05 17:47:27.633', E'2012-12-05 17:47:27.633', E'activo', 1, 1, E'2012-12-05', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 184, 3, E'2012-12-19', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 185, 3, E'2013-06-04', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 186, 3, E'2013-11-18', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 187, 8, E'2012-12-19', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-05 17:47:27.633', E'2012-12-05 17:47:27.633', E'activo', 7, 2, E'2012-12-05', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 190, 7, E'2012-12-19', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 10, 1, E'2012-12-11', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 11, 1, E'2013-03-04', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 12, 1, E'2013-05-26', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 13, 1, E'2013-08-17', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 14, 1, E'2013-11-08', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 15, 1, E'2014-01-30', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 16, 1, E'2014-04-23', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 17, 1, E'2014-07-15', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 18, 1, E'2014-10-06', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 19, 2, E'2012-12-11', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 20, 2, E'2013-07-07', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 21, 2, E'2014-01-31', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-11 18:14:31.604', E'2012-12-11 18:14:31.604', E'activo', 22, 2, E'2014-08-27', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 191, 7, E'2013-12-19', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 192, 6, E'2012-12-19', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 195, 4, E'2012-12-19', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 196, 5, E'2012-12-19', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 197, 5, E'2013-02-20', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 198, 5, E'2013-04-24', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 199, 5, E'2013-06-26', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 200, 5, E'2013-08-28', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 201, 5, E'2013-10-30', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, NULL, E'2012-12-20 10:34:50.222', E'2012-12-20 10:34:50.222', E'activo', 202, 5, E'2014-01-01', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, 1, E'2012-12-20 10:34:50.222', E'2012-12-20 10:40:28.470', E'activo', 189, 8, E'2014-06-15', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, 1, E'2012-12-20 10:34:50.222', E'2012-12-20 10:40:28.470', E'activo', 188, 8, E'2013-12-17', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, 1, E'2012-12-20 10:34:50.222', E'2012-12-20 11:54:22.998', E'activo', 194, 6, E'2014-01-01', NULL, E'generado', E'planificado', NULL, NULL);
INSERT INTO gem.tcalendario_planificado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_calendario_planificado", "id_uni_cons_mant_predef", "fecha_ini", "fecha_fin", "estado", "tipo", "observaciones", "id_alarma")
VALUES (1, 1, E'2012-12-20 10:34:50.222', E'2012-12-20 11:54:22.998', E'activo', 193, 6, E'2013-07-18', NULL, E'generado', E'planificado', NULL, NULL);

--CENTRO COSTO - AAO
INSERT INTO gem.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "codigo", "descripcion", "tipo", "codigo_anh", "descripcion_anh")
VALUES (1, 1, E'2012-12-15 16:54:17', E'2012-12-15 16:54:17', E'activo', 1, E'cc1', E'ninguna', E'costo', E'asd', E'asd');
INSERT INTO gem.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "codigo", "descripcion", "tipo", "codigo_anh", "descripcion_anh")
VALUES (1, NULL, E'2012-12-15 16:54:48', E'2012-12-15 16:54:48', E'activo', 2, E'cc2', E'nones', E'cost', E'213', E'asdf');

----------------------------
-- autor:RAC  
-- FECHA: 20 12 2012
-- para probar y crear roles
-------------------------

/*

INSERT INTO segu.tusuario ("id_usuario", "id_clasificador", "cuenta", "contrasena", "fecha_caducidad", "fecha_reg", "estilo", "contrasena_anterior", "id_persona", "estado_reg", "autentificacion")
VALUES (2, 1, E'spanza', E'533cd2ec574f9a6ded5801efbfee21ba', E'2016-05-07', E'2012-12-20', E'xtheme-blue.css', NULL, 3, E'activo', E'local');

INSERT INTO segu.tusuario_rol ("id_usuario_rol", "id_rol", "id_usuario", "fecha_reg", "estado_reg")
VALUES (2, 2, 2, NULL, 'activo');*/


-- FUNCIONARIO HONORARIO
INSERT INTO gem.tfuncionario_honorario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario_honorario", "id_tipo_horario", "id_funcionario", "id_moneda", "costo_hora")
VALUES (1, NULL, E'2012-12-29 15:17:29.003', E'2012-12-29 15:17:29.003', E'activo', 1, 3, 2, 1, '20');

INSERT INTO gem.tfuncionario_honorario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario_honorario", "id_tipo_horario", "id_funcionario", "id_moneda", "costo_hora")
VALUES (1, NULL, E'2012-12-29 15:18:12.431', E'2012-12-29 15:18:12.431', E'activo', 3, 4, 3, 1, '20');

INSERT INTO gem.tfuncionario_honorario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario_honorario", "id_tipo_horario", "id_funcionario", "id_moneda", "costo_hora")
VALUES (1, NULL, E'2012-12-29 15:19:50.693', E'2012-12-29 15:19:50.693', E'activo', 4, 3, 4, 1, '20');

INSERT INTO gem.tfuncionario_honorario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario_honorario", "id_tipo_horario", "id_funcionario", "id_moneda", "costo_hora")
VALUES (1, 1, E'2012-12-29 15:17:29.003', E'2012-12-29 15:31:18.429', E'activo', 2, 5, 2, 1, '20.5');


--ORDEN DE TRABAJO - AAO

INSERT INTO gem.torden_trabajo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo", "id_uni_cons_mant_predef", "id_uni_cons", "id_tipo_mant", "id_unidad_medida", "id_funcionario_sol", "id_funcionario_asig", "fecha_plan_ini", "fecha_eje_ini", "fecha_eje_fin", "descripcion", "fecha_emision", "num_oit", "codigo_oit", "ubicacion_tecnica", "acumulado", "observacion", "nota_tecnico_equipo", "nota_tecnico_loc", "cat_estado", "cat_prior", "cat_tipo", "id_instruc_seg", "id_calendario_planificacion", "id_alarma", "id_localizacion", "descripcion_lugar", "id_centro_costo", "especialidades", "tiempo_estimado", "id_funcionario_aprob", "id_funcionario_recib", "comentarios", "accidentes", "reclamos", "otros", "hora_eje_inicio", "hora_eje_fin")
VALUES (1, 1, E'2012-12-30 02:22:46.203', E'2012-12-30 03:51:06.424', E'activo', 12, NULL, 6, 2, 1, 4, 3, E'2013-01-02', NULL, NULL, E'', E'2012-12-30', E'1', E'OIT-001', E'', NULL, E'La computadora no prende. y si prende está muy lenta', E'', E'', E'Revisado', E'Alta', E'Correctivo', NULL, NULL, NULL, 34, E'UMPA LUMPA', 1, E'Mantenimiento de Computadoras', '10', NULL, NULL, E'', E'', E'', E'', NULL, NULL);

INSERT INTO gem.torden_trabajo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo", "id_uni_cons_mant_predef", "id_uni_cons", "id_tipo_mant", "id_unidad_medida", "id_funcionario_sol", "id_funcionario_asig", "fecha_plan_ini", "fecha_eje_ini", "fecha_eje_fin", "descripcion", "fecha_emision", "num_oit", "codigo_oit", "ubicacion_tecnica", "acumulado", "observacion", "nota_tecnico_equipo", "nota_tecnico_loc", "cat_estado", "cat_prior", "cat_tipo", "id_instruc_seg", "id_calendario_planificacion", "id_alarma", "id_localizacion", "descripcion_lugar", "id_centro_costo", "especialidades", "tiempo_estimado", "id_funcionario_aprob", "id_funcionario_recib", "comentarios", "accidentes", "reclamos", "otros", "hora_eje_inicio", "hora_eje_fin")
VALUES (1, NULL, E'2012-12-30 02:24:28.138', NULL, E'activo', 13, NULL, 17, 3, 1, 3, 2, E'2013-01-03', NULL, NULL, E'', E'2012-12-30', E'2', E'OIT-002', E'', NULL, E'Tiene un sonido muy fuerte y feo.', E'', E'', E'Borrador', E'Media', E'Correctivo', NULL, NULL, NULL, 33, E'UMPA LUMPA', 2, E'Inspección y corrección del motor eléctrico', '20', NULL, NULL, E'', E'', E'', E'', NULL, NULL);

INSERT INTO gem.torden_trabajo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo", "id_uni_cons_mant_predef", "id_uni_cons", "id_tipo_mant", "id_unidad_medida", "id_funcionario_sol", "id_funcionario_asig", "fecha_plan_ini", "fecha_eje_ini", "fecha_eje_fin", "descripcion", "fecha_emision", "num_oit", "codigo_oit", "ubicacion_tecnica", "acumulado", "observacion", "nota_tecnico_equipo", "nota_tecnico_loc", "cat_estado", "cat_prior", "cat_tipo", "id_instruc_seg", "id_calendario_planificacion", "id_alarma", "id_localizacion", "descripcion_lugar", "id_centro_costo", "especialidades", "tiempo_estimado", "id_funcionario_aprob", "id_funcionario_recib", "comentarios", "accidentes", "reclamos", "otros", "hora_eje_inicio", "hora_eje_fin")
VALUES (1, NULL, E'2012-12-30 02:26:03.066', NULL, E'activo', 14, NULL, 9, 4, 1, 2, 3, E'2013-01-02', NULL, NULL, E'', E'2012-12-30', E'3', E'OIT-003', E'', NULL, E'EL motor de combustión interna no prende, y si prende lo unico que prende es fuego xD', E'', E'', E'Borrador', E'Alta', E'Correctivo', NULL, NULL, NULL, 58, E'UMPA LUMPA', 1, E'Mantenimiento de Servidores', '15', NULL, NULL, E'', E'', E'', E'', NULL, NULL);

INSERT INTO gem.torden_trabajo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo", "id_uni_cons_mant_predef", "id_uni_cons", "id_tipo_mant", "id_unidad_medida", "id_funcionario_sol", "id_funcionario_asig", "fecha_plan_ini", "fecha_eje_ini", "fecha_eje_fin", "descripcion", "fecha_emision", "num_oit", "codigo_oit", "ubicacion_tecnica", "acumulado", "observacion", "nota_tecnico_equipo", "nota_tecnico_loc", "cat_estado", "cat_prior", "cat_tipo", "id_instruc_seg", "id_calendario_planificacion", "id_alarma", "id_localizacion", "descripcion_lugar", "id_centro_costo", "especialidades", "tiempo_estimado", "id_funcionario_aprob", "id_funcionario_recib", "comentarios", "accidentes", "reclamos", "otros", "hora_eje_inicio", "hora_eje_fin")
VALUES (1, 1, E'2012-12-30 02:27:14', E'2012-12-30 03:42:43.278', E'activo', 15, NULL, 6, 4, 1, 4, 1, E'2013-01-04', NULL, NULL, E'', E'2012-12-30', E'3', E'OIT-003', E'', NULL, E'Se huele a gasssss....', E'', E'', E'Cerrado', E'Alta', E'Correctivo', NULL, NULL, NULL, 9, E'SACABA', 2, E'Inspector de balbulas', '24', NULL, NULL, E'', E'', E'', E'', NULL, NULL);

--LOG ORDEN TRABAJO - AAO

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 02:22:46.203', NULL, E'activo', 16, 12, NULL, E'Borrador', E'2012-12-30 02:22:46.203');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 02:24:28.138', NULL, E'activo', 17, 13, NULL, E'Borrador', E'2012-12-30 02:24:28.138');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 02:26:03.066', NULL, E'activo', 18, 14, NULL, E'Borrador', E'2012-12-30 02:26:03.066');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 02:27:14', NULL, E'activo', 19, 15, NULL, E'Borrador', E'2012-12-30 02:27:14');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 02:39:03.145', NULL, E'activo', 20, 12, E'Borrador', E'Pendiente', E'2012-12-30 02:39:03.145');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 03:04:33.548', NULL, E'activo', 21, 15, E'Borrador', E'Pendiente', E'2012-12-30 03:04:33.548');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 03:05:41.286', NULL, E'activo', 22, 12, E'Pendiente', E'Abierto', E'2012-12-30 03:05:41.286');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 03:05:55.248', NULL, E'activo', 23, 15, E'Pendiente', E'Abierto', E'2012-12-30 03:05:55.248');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 03:28:31.856', NULL, E'activo', 24, 15, E'Abierto', E'Cerrado', E'2012-12-30 03:28:31.856');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 03:28:46.206', NULL, E'activo', 25, 12, E'Abierto', E'Cerrado', E'2012-12-30 03:28:46.206');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 03:34:23.335', NULL, E'activo', 26, 15, E'Cerrado', E'Abierto', E'2012-12-30 03:34:23.335');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 03:42:43.278', NULL, E'activo', 27, 15, E'Abierto', E'Cerrado', E'2012-12-30 03:42:43.278');

INSERT INTO gem.torden_trabajo_log ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_orden_trabajo_log", "id_orden_trabajo", "estado_ini", "estado_fin", "fecha")
VALUES (1, NULL, E'2012-12-30 03:51:06.424', NULL, E'activo', 28, 12, E'Cerrado', E'Revisado', E'2012-12-30 03:51:06.424');

-- ACTIVIDAD OT - AAO
INSERT INTO gem.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_orden_trabajo", "id_usuario_resp", "estado", "descripcion", "observaciones", "fecha_plan_ini", "fecha_plan_fin", "fecha_eje_ini", "fecha_eje_fin")
VALUES (1, NULL, E'2012-12-30 02:32:15.325', NULL, E'activo', 5, 12, 2, E'', E'Inspección inicial e informe del estado actual', E'', E'2013-01-03', E'2013-01-03', NULL, NULL);

INSERT INTO gem.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_orden_trabajo", "id_usuario_resp", "estado", "descripcion", "observaciones", "fecha_plan_ini", "fecha_plan_fin", "fecha_eje_ini", "fecha_eje_fin")
VALUES (1, NULL, E'2012-12-30 02:32:49.391', NULL, E'activo', 6, 12, 2, E'', E'Mantenimiento del motor del equipo y engrase de los componentes del mismo.', E'', E'2013-01-03', E'2013-01-04', NULL, NULL);

INSERT INTO gem.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_orden_trabajo", "id_usuario_resp", "estado", "descripcion", "observaciones", "fecha_plan_ini", "fecha_plan_fin", "fecha_eje_ini", "fecha_eje_fin")
VALUES (1, NULL, E'2012-12-30 02:38:47.746', NULL, E'activo', 7, 12, 2, E'', E'Rectificación de los tubos de enganche', E'tener cuidado al sacar puesto que son muy frágiles', E'2013-01-03', E'2013-01-04', NULL, NULL);

INSERT INTO gem.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_orden_trabajo", "id_usuario_resp", "estado", "descripcion", "observaciones", "fecha_plan_ini", "fecha_plan_fin", "fecha_eje_ini", "fecha_eje_fin")
VALUES (1, NULL, E'2012-12-30 03:03:29.045', NULL, E'activo', 8, 15, 1, E'', E'Inspección y emisión del informe del estado de los componentes del motor de combustión a gas.', E'Evacuar todo el gas del equipo para evitar explosiones', E'2013-01-03', E'2013-01-03', NULL, NULL);

INSERT INTO gem.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "id_orden_trabajo", "id_usuario_resp", "estado", "descripcion", "observaciones", "fecha_plan_ini", "fecha_plan_fin", "fecha_eje_ini", "fecha_eje_fin")
VALUES (1, NULL, E'2012-12-30 03:04:15.290', NULL, E'activo', 9, 15, 1, E'', E'Ajustes a las bábulas de inyección.', E'', E'2013-01-03', E'2013-01-07', NULL, NULL);


-- RECURSO OT - AAO
INSERT INTO gem.trecurso ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_recurso", "id_item", "id_funcionario", "id_especialidad", "id_servicio", "id_tarea", "id_actividad", "id_moneda", "cantidad", "costo", "observaciones", "id_unidad_medida", "hh_normal", "hh_extras", "hh_ext_mov", "codigo", "existencias")
VALUES (1, NULL, E'2012-12-30 03:09:38.622', NULL, E'activo', 1, 4, NULL, NULL, NULL, NULL, 5, 2, '20', '50', E'ninguna', 11, NULL, NULL, NULL, E'IPD-3ra', E'En algun lugar.');

INSERT INTO gem.trecurso ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_recurso", "id_item", "id_funcionario", "id_especialidad", "id_servicio", "id_tarea", "id_actividad", "id_moneda", "cantidad", "costo", "observaciones", "id_unidad_medida", "hh_normal", "hh_extras", "hh_ext_mov", "codigo", "existencias")
VALUES (1, NULL, E'2012-12-30 03:10:05.642', NULL, E'activo', 2, 4, NULL, NULL, NULL, NULL, 5, 2, '20', '50', E'ninguna', 11, NULL, NULL, NULL, E'IPD-3ra', E'En algun lugar.');

INSERT INTO gem.trecurso ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_recurso", "id_item", "id_funcionario", "id_especialidad", "id_servicio", "id_tarea", "id_actividad", "id_moneda", "cantidad", "costo", "observaciones", "id_unidad_medida", "hh_normal", "hh_extras", "hh_ext_mov", "codigo", "existencias")
VALUES (1, NULL, E'2012-12-30 03:11:25.667', NULL, E'activo', 3, NULL, 3, NULL, NULL, NULL, 6, NULL, NULL, NULL, E'ninguna', NULL, 12, 5, 1, E'', E'');

INSERT INTO gem.trecurso ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_recurso", "id_item", "id_funcionario", "id_especialidad", "id_servicio", "id_tarea", "id_actividad", "id_moneda", "cantidad", "costo", "observaciones", "id_unidad_medida", "hh_normal", "hh_extras", "hh_ext_mov", "codigo", "existencias")
VALUES (1, NULL, E'2012-12-30 03:11:40.706', NULL, E'activo', 4, NULL, 4, NULL, NULL, NULL, 6, NULL, NULL, NULL, E'', NULL, 20, 12, 1, E'', E'');

INSERT INTO gem.trecurso ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_recurso", "id_item", "id_funcionario", "id_especialidad", "id_servicio", "id_tarea", "id_actividad", "id_moneda", "cantidad", "costo", "observaciones", "id_unidad_medida", "hh_normal", "hh_extras", "hh_ext_mov", "codigo", "existencias")
VALUES (1, NULL, E'2012-12-30 03:12:24.618', NULL, E'activo', 5, 1, NULL, NULL, NULL, NULL, 7, 2, '18', '20', E'', 13, NULL, NULL, NULL, E'HUM-P', E'Almacen C-21');

INSERT INTO gem.trecurso ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_recurso", "id_item", "id_funcionario", "id_especialidad", "id_servicio", "id_tarea", "id_actividad", "id_moneda", "cantidad", "costo", "observaciones", "id_unidad_medida", "hh_normal", "hh_extras", "hh_ext_mov", "codigo", "existencias")
VALUES (1, NULL, E'2012-12-30 03:12:45.266', NULL, E'activo', 6, NULL, 4, NULL, NULL, NULL, 7, NULL, NULL, NULL, E'', NULL, 20, 10, 1, E'', E'');

-- PROVEEDOR ITEM SERVICIO - AAO

INSERT INTO param.tproveedor_item_servicio ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_proveedor_item", "id_proveedor", "id_item", "id_servicio")
VALUES (1, NULL, E'2012-12-29 14:54:23.478', NULL, E'activo', 1, 2, 1, NULL);

INSERT INTO param.tproveedor_item_servicio ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_proveedor_item", "id_proveedor", "id_item", "id_servicio")
VALUES (1, NULL, E'2012-12-29 14:54:35.624', NULL, E'activo', 2, 2, NULL, 6);

INSERT INTO param.tproveedor_item_servicio ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_proveedor_item", "id_proveedor", "id_item", "id_servicio")
VALUES (1, NULL, E'2012-12-29 14:54:46.325', NULL, E'activo', 3, 1, 7, NULL);

INSERT INTO param.tproveedor_item_servicio ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_proveedor_item", "id_proveedor", "id_item", "id_servicio")
VALUES (1, NULL, E'2012-12-29 14:54:53.990', NULL, E'activo', 4, 1, NULL, 1);