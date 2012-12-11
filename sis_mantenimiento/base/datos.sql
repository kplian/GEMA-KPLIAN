select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Borrador');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Listo');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Abierto');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Cerrado');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_estado','Revisado');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_prior','Alta');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_prior','Media');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_prior','Baja');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_tipo','Preventivo');
select pxp.f_add_catalog('GEM','torden_trabajo_cat_tipo','Correctivo');
select pxp.f_add_catalog('GEM','ttpm_tarjeta_cat_tipo_instalacion','Estacion');
select pxp.f_add_catalog('GEM','ttpm_tarjeta_cat_tipo_instalacion','Planta');
select pxp.f_add_catalog('GEM','tanalisis_porque_cat_estado_analisis_porque','En proceso');
select pxp.f_add_catalog('GEM','tanalisis_porque_cat_estado_analisis_porque','Terminado');

select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Gerente');
select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Ingeniero');
select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Jefe');
select pxp.f_add_catalog('GEM','tlocalizacion_usuario','Operador');


--RAC 06-12-2012


/* Data for the 'param.tconfig_alarma' table  (Records 1 - 2) */

INSERT INTO param.tconfig_alarma ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_config_alarma", "codigo", "descripcion", "dias", "id_subsistema")
VALUES (1, NULL, E'2012-12-06 00:00:00', NULL, E'activo', 2, E'torden_trabajo', NULL, 1, 6);

INSERT INTO param.tconfig_alarma ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_config_alarma", "codigo", "descripcion", "dias", "id_subsistema")
VALUES (1, 1, E'2012-12-06 00:00:00', E'2012-12-06 07:13:57.935', E'activo', 1, E'tcalendario_planificado', NULL, 3, 6);


