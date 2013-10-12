/***********************************I-DEP-RCM-GEM-0-07/01/2013*****************************************/
alter table gem.tlocalizacion
add CONSTRAINT fk_tlocalizacion___id_localizacion_fk FOREIGN KEY (id_localizacion_fk)
    REFERENCES gem.tlocalizacion(id_localizacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.ttipo_equipo
add CONSTRAINT fk_ttipo_equipo__id_usuario_reg FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.ttipo_equipo
add CONSTRAINT fk_ttipo_equipo__id_usuario_mod FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons
add CONSTRAINT fk_tuni_cons__id_tipo_equipo FOREIGN KEY (id_tipo_equipo)
    REFERENCES gem.ttipo_equipo(id_tipo_equipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons
add CONSTRAINT fk_tuni_cons__id_localizacion FOREIGN KEY (id_localizacion)
    REFERENCES gem.tlocalizacion(id_localizacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons  
add CONSTRAINT fk_tuni_cons__id_usuario_reg FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons   
add CONSTRAINT fk_tuni_cons__id_usuario_mod FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons_comp
add CONSTRAINT fk_tuni_cons_comp__id_uni_cons_hijo FOREIGN KEY (id_uni_cons_hijo)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons_comp
add CONSTRAINT fk_tuni_cons_comp__id_uni_cons_padre FOREIGN KEY (id_uni_cons_padre)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;    
    
alter table gem.tfalla_evento
add	CONSTRAINT fk_tfalla_evento__id_tipo_equipo FOREIGN KEY (id_tipo_equipo)
    REFERENCES gem.ttipo_equipo (id_tipo_equipo) MATCH SIMPLE
    ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT DEFERRABLE;
	
alter table gem.tincidente_equipo
add CONSTRAINT fk_tincidente_equipo__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.tincidente_equipo
add CONSTRAINT fk_tincidente_equipo__id_falla_evento FOREIGN KEY (id_falla_evento)
    REFERENCES gem.tfalla_evento (id_falla_evento) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.tmant_predef_det
add CONSTRAINT fk_tmant_predef_det__id_mant_predef FOREIGN KEY (id_mant_predef)
    REFERENCES gem.tmant_predef (id_mant_predef) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.tdocumento
add CONSTRAINT fk_tdocumento__id_documento_padre FOREIGN KEY (id_documento_padre)
    REFERENCES gem.tdocumento (id_documento) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.torden_trabajo
add CONSTRAINT fk_torden_trabajo__id_uni_cons_mant_predef FOREIGN KEY (id_uni_cons_mant_predef)
    REFERENCES gem.tuni_cons_mant_predef (id_uni_cons_mant_predef) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;    
    
alter table gem.torden_trabajo
add CONSTRAINT fk_torden_trabajo__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

alter table gem.torden_trabajo
add CONSTRAINT fk_torden_trabajo__id_tipo_mant FOREIGN KEY (id_tipo_mant)
    REFERENCES gem.ttipo_mant (id_tipo_mant) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.torden_trabajo
add CONSTRAINT fk_torden_trabajo__id_unidad_medida FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida (id_unidad_medida) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.torden_trabajo
add CONSTRAINT fk_torden_trabajo__id_funcionario_sol FOREIGN KEY (id_funcionario_sol)
    REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.torden_trabajo
add CONSTRAINT fk_torden_trabajo__id_funcionario_asig FOREIGN KEY (id_funcionario_asig)
    REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

alter table gem.tdiagrama_decision
add CONSTRAINT fk_tdiagrama_decision__id_metodologia FOREIGN KEY (id_metodologia)
    REFERENCES gem.tmetodologia (id_metodologia) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.tfuncionario_honorario
add CONSTRAINT fk_tfuncionario_honorario__id_tipo_horario FOREIGN KEY (id_tipo_horario)
      REFERENCES orga.ttipo_horario (id_tipo_horario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table gem.tfuncionario_honorario
add CONSTRAINT fk_tfuncionario_honorario__id_funcionario FOREIGN KEY (id_funcionario)
      REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table gem.tfuncionario_honorario
add CONSTRAINT fk_tfuncionario_honorario__id_moneda FOREIGN KEY (id_moneda)
      REFERENCES param.tmoneda (id_moneda) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
alter table gem.tequipo_medicion
add CONSTRAINT fk_tequipo_medicion__id_equipo_variable FOREIGN KEY (id_equipo_variable)
      REFERENCES gem.tequipo_variable (id_equipo_variable) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
alter table gem.ttipo_variable
add constraint fk_ttipo_variable__id_tipo_equipo foreign key (id_tipo_equipo)
	references gem.ttipo_equipo (id_tipo_equipo);

alter table gem.ttipo_variable
add constraint fk_ttipo_variable__id_unidad_medida foreign key (id_unidad_medida)
	references param.tunidad_medida (id_unidad_medida);
	
alter table gem.tanalisis_mant
add CONSTRAINT fk_tanalisis_mant__id_uni_cons FOREIGN KEY (id_uni_cons)
      REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table gem.tanalisis_mant
add CONSTRAINT fk_tanalisis_mant__id_tipo_mant FOREIGN KEY (id_tipo_mant)
      REFERENCES gem.ttipo_mant (id_tipo_mant) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table gem.tanalisis_mant
add CONSTRAINT fk_tanalisis_mant__id_persona_rev FOREIGN KEY (id_persona_rev)
      REFERENCES segu.tpersona (id_persona) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table gem.tfuncion
add CONSTRAINT fk_tfuncion__id_analisis_mant FOREIGN KEY (id_analisis_mant)
      REFERENCES gem.tanalisis_mant (id_analisis_mant) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
alter table gem.tfuncion_falla
add CONSTRAINT fk_tfuncion_falla__id_funcion FOREIGN KEY (id_funcion)
      REFERENCES gem.tfuncion (id_funcion) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table gem.tfuncion_falla      
add CONSTRAINT fk_tfuncion_falla__id_falla_evento FOREIGN KEY (id_falla_evento)
      REFERENCES gem.tfalla_evento (id_falla_evento) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
alter table gem.tuni_cons_mant_predef
add CONSTRAINT fk_tuni_cons_mant_predef__id_mant_predef FOREIGN KEY (id_mant_predef)
    REFERENCES gem.tmant_predef(id_mant_predef)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons_mant_predef
add CONSTRAINT fk_tuni_cons_mant_predef__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons_mant_predef
add CONSTRAINT fk_tuni_cons_mant_predef__id_unidad_medida FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida(id_unidad_medida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tcalendario_planificado
add CONSTRAINT fk_tcalendario_planificado__id_uni_cons_mant_predef FOREIGN KEY (id_uni_cons_mant_predef)
    REFERENCES gem.tuni_cons_mant_predef(id_uni_cons_mant_predef)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE gem.tuni_cons_det
  ADD CONSTRAINT tuni_cons_det_id_unidad_medida_fk FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida(id_unidad_medida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE gem.tuni_cons_det
  ADD CONSTRAINT tuni_cons_det_id_uni_cons_fk FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tmodo_falla
add CONSTRAINT fk_tmodo_falla__id_funcion_falla FOREIGN KEY (id_funcion_falla)
    REFERENCES gem.tfuncion_falla(id_funcion_falla)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tplan_mant
add CONSTRAINT fk_tplan_mant__id_persona FOREIGN KEY (id_persona)
    REFERENCES segu.tpersona(id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

alter table gem.tplan_mant
add CONSTRAINT fk_tplan_mant__id_persona_rev FOREIGN KEY (id_persona_rev)
    REFERENCES segu.tpersona(id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tplan_mant
add CONSTRAINT fk_tplan_mant__id_tipo_mant FOREIGN KEY (id_tipo_mant)
    REFERENCES gem.ttipo_mant(id_tipo_mant)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tplan_mant
add CONSTRAINT fk_tplan_mant__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.ttarea
add CONSTRAINT fk_ttarea__id_falla_evento FOREIGN KEY (id_falla_evento)
    REFERENCES gem.tfalla_evento(id_falla_evento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.ttarea
add CONSTRAINT fk_ttarea__id_modo_falla FOREIGN KEY (id_modo_falla)
    REFERENCES gem.tmodo_falla(id_modo_falla)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.ttarea
add CONSTRAINT fk_ttarea__id_plan_mant FOREIGN KEY (id_plan_mant)
    REFERENCES gem.tplan_mant(id_plan_mant)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.ttarea
add CONSTRAINT fk_ttarea__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.ttarea
add CONSTRAINT fk_ttarea__id_uni_cons_hijo FOREIGN KEY (id_uni_cons_hijo)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.ttarea
add CONSTRAINT fk_ttarea__id_unidad_medida FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida(id_unidad_medida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons_archivo
add CONSTRAINT fk_tuni_cos_archivo__id_uni_cons_archivo_padre FOREIGN KEY (id_uni_cons_archivo_padre)
    REFERENCES gem.tuni_cons_archivo(id_uni_cons_archivo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons_proveedor
add CONSTRAINT fk_tuni_cons_item__id_proveedor FOREIGN KEY (id_proveedor)
    REFERENCES param.tproveedor(id_proveedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tuni_cons_proveedor
add CONSTRAINT fk_tuni_cons_proveedor__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
           
ALTER TABLE gem.tuni_cons_item
add CONSTRAINT fk_tuni_cons_item__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE gem.tuni_cons_item
add CONSTRAINT fk_tuni_cons_item__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.tactividad
add CONSTRAINT fk_tactividad__id_orden_trabajo FOREIGN KEY (id_orden_trabajo)
    REFERENCES gem.torden_trabajo (id_orden_trabajo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
      
alter table gem.tactividad
add CONSTRAINT fk_tactividad__id_usuario_resp FOREIGN KEY (id_usuario_resp)
    REFERENCES segu.tusuario (id_usuario) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.trecurso
add CONSTRAINT fk_trecurso__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem (id_item) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.trecurso
add CONSTRAINT fk_trecurso__id_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.trecurso
add CONSTRAINT fk_trecurso__id_especialidad FOREIGN KEY (id_especialidad)
    REFERENCES orga.tespecialidad (id_especialidad) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION;
    
alter table gem.trecurso
add CONSTRAINT fk_trecurso__id_servicio FOREIGN KEY (id_servicio)
    REFERENCES param.tservicio (id_servicio) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.trecurso
add CONSTRAINT fk_trecurso__id_tarea FOREIGN KEY (id_tarea)
    REFERENCES gem.ttarea (id_tarea) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.trecurso
add CONSTRAINT fk_trecurso__id_actividad FOREIGN KEY (id_actividad)
    REFERENCES gem.tactividad (id_actividad) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.trecurso
add CONSTRAINT fk_trecurso__id_moneda FOREIGN KEY (id_moneda)
    REFERENCES param.tmoneda (id_moneda) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.tlocalizacion_usuario
add CONSTRAINT fk_tlocalizacion_usuario__id_localizacion FOREIGN KEY (id_localizacion)
      REFERENCES gem.tlocalizacion (id_localizacion) MATCH SIMPLE
      ON UPDATE NO ACTION 
      ON DELETE NO ACTION;
      
alter table gem.tlocalizacion_usuario
add CONSTRAINT fk_tlocalizacion_usuario__id_usuario FOREIGN KEY (id_usuario)
      REFERENCES segu.tusuario (id_usuario) MATCH SIMPLE
      ON UPDATE NO ACTION
      ON DELETE NO ACTION;
      
alter table gem.torden_trabajo
add constraint fk_torden_trabajo__id_instruc_seg foreign key(id_instruc_seg)
	references gem.tinstruc_seg(id_instruc_seg);
	
alter table gem.tanalisis_porque
add CONSTRAINT fk_tanalisis_porque__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION;
    
alter table gem.tanalisis_porque_det
add CONSTRAINT fk_tanalisis_porque_det__id_analisis_porque FOREIGN KEY (id_analisis_porque)
    REFERENCES gem.tanalisis_porque (id_analisis_porque) MATCH SIMPLE
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION;
    
alter table gem.tanalisis_porque_sol
add CONSTRAINT fk_tanalisis_porque_sol__id_analisis_porque FOREIGN KEY (id_analisis_porque)
    REFERENCES gem.tanalisis_porque (id_analisis_porque) MATCH SIMPLE
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION;
    
alter table gem.tanalisis_porque_sol
add CONSTRAINT fk_tanalisis_porque_sol__id_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION;
    
alter table gem.ttpm_tarjeta
add CONSTRAINT fk_ttpm_tarjeta__id_localizacion FOREIGN KEY (id_localizacion)
    REFERENCES gem.tlocalizacion (id_localizacion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.ttpm_tarjeta_det
add CONSTRAINT fk_ttpm_tarjeta_det__id_tpm_tarjeta FOREIGN KEY (id_tpm_tarjeta)
    REFERENCES gem.ttpm_tarjeta (id_tpm_tarjeta) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION;
    
alter table gem.ttpm_tarjeta_det
add CONSTRAINT fk_ttpm_tarjeta_det__id_funcionario_detec FOREIGN KEY (id_funcionario_detec)
    REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION;
    
alter table gem.ttpm_tarjeta_det
add CONSTRAINT fk_ttpm_tarjeta_det__id_funcionario_efec FOREIGN KEY (id_funcionario_efec)
    REFERENCES orga.tfuncionario (id_funcionario) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION;
    
alter table gem.ttpm_tarjeta_det
add CONSTRAINT fk_ttpm_tarjeta_det__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION;
    
alter table gem.torden_trabajo_log
add CONSTRAINT fk_torden_trabajo_log__id_orden_trabajo FOREIGN KEY (id_orden_trabajo)
    REFERENCES gem.torden_trabajo (id_orden_trabajo) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION;
    
alter table gem.tlocalizacion_med
add CONSTRAINT fk_tlocalizacion_med__id_localizacion FOREIGN KEY (id_localizacion)
    REFERENCES gem.tlocalizacion (id_localizacion) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table gem.tlocalizacion_med
add CONSTRAINT fk_tlocalizacion_med__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons (id_uni_cons) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION;
    
alter table gem.tdiagrama_decision_accion
add CONSTRAINT fk_tdiagrama_decision_accion__id_diagrama_decision_accion_fk FOREIGN KEY (id_diagrama_decision_accion_fk)
    REFERENCES gem.tdiagrama_decision_accion (id_diagrama_decision_accion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
alter table gem.tdiagrama_decision_accion
add CONSTRAINT fk_tdiagrama_decision_accion__id_diagrama_decision FOREIGN KEY (id_diagrama_decision)
    REFERENCES gem.tdiagrama_decision (id_diagrama_decision) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
    
ALTER TABLE gem.trecurso
ADD CONSTRAINT fk_trecurso__id_unidad_medida FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida(id_unidad_medida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE gem.tuni_cons_doc_tec
  ADD CONSTRAINT fk_tuni_cos_doc_tec__id_uni_cons FOREIGN KEY (id_uni_cons)
    REFERENCES gem.tuni_cons(id_uni_cons)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
alter table gem.torden_trabajo_sol
add constraint fk_torden_trabajo_sol__id_solicitante foreign key (id_solicitante)
    references orga.tfuncionario (id_funcionario) match simple
    on update no action on delete no action;
      
alter table gem.torden_trabajo_sol
add constraint fk_torden_trabajo_sol__id_uni_cons foreign key (id_uni_cons)
    references gem.tuni_cons (id_uni_cons) match simple
    on update no action on delete no action;
    
alter table gem.torden_trabajo_sol
add constraint fk_torden_trabajo_sol__id_responsable foreign key (id_responsable)
    references orga.tfuncionario (id_funcionario) match simple
    on update no action on delete no action;
    
alter table gem.torden_trabajo_sol
add constraint fk_torden_trabajo_sol__id_unidad_medida_req foreign key (id_unidad_medida_req)
    references param.tunidad_medida (id_unidad_medida) match simple
    on update no action on delete no action;
    
alter table gem.torden_trabajo_sol
add constraint fk_torden_trabajo_sol__id_uo foreign key (id_uo)
    references orga.tuo (id_uo) match simple
    on update no action on delete no action;
    
alter table gem.torden_trabajo_sol
add constraint fk_torden_trabajo_sol__id_localizacion foreign key (id_localizacion)
    references gem.tlocalizacion (id_localizacion) match simple
    on update no action on delete no action;
    
alter table gem.torden_trabajo_sol
add constraint fk_torden_trabajo_sol__id_orden_trabajo foreign key (id_orden_trabajo)
    references gem.torden_trabajo (id_orden_trabajo) match simple
    on update no action on delete no action;
    
alter table param.tproveedor
add constraint fk_tproveedor__id_lugar foreign key(id_lugar)
	references param.tlugar(id_lugar);

alter table gem.tmant_predef
add constraint fk_tmant_predef__id_tipo_equipo foreign key (id_tipo_equipo)
	references gem.ttipo_equipo (id_tipo_equipo);
    
/***********************************F-DEP-RCM-GEM-0-07/01/2013*****************************************/

/***********************************I-DEP-RCM-GEM-122-17/02/2013*****************************************/
alter table gem.torden_trabajo_sol_insumo
add constraint fk_torden_trabajo_sol_insumo__id_orden_trabajo_sol
foreign key (id_orden_trabajo_sol) references gem.torden_trabajo_sol (id_orden_trabajo_sol);
/***********************************F-DEP-RCM-GEM-122-17/02/2013*****************************************/

/***********************************I-DEP-RCM-GEM-123-18/02/2013*****************************************/
alter table gem.tlocalizacion_correl
add constraint fk_tlocalizacion_correl__id_localizacion foreign key (id_localizacion)
references gem.tlocalizacion (id_localizacion);
/***********************************F-DEP-RCM-GEM-123-18/02/2013*****************************************/

/***********************************I-DEP-RCM-GEM-124-18/02/2013*****************************************/
alter table gem.tuni_cons_item
add constraint fk_tuni_cons_item__id_proveedor foreign key (id_proveedor)
references param.tproveedor (id_proveedor);
/***********************************F-DEP-RCM-GEM-124-18/02/2013*****************************************/

/***********************************I-DEP-RCM-GEM-132-19/02/2013*****************************************/
alter table gem.tmant_predef
add constraint fk_tmant_predef__id_tipo_mant foreign key(id_tipo_mant)
references gem.ttipo_mant(id_tipo_mant);
/***********************************F-DEP-RCM-GEM-132-19/02/2013*****************************************/

/***********************************I-DEP-RCM-GEM-134-22/03/2013*****************************************/
alter table gem.ttipo_equipo_col
add constraint fk_ttipo_equipo_col__id_tipo_equipo foreign key (id_tipo_equipo)
references gem.ttipo_equipo (id_tipo_equipo);
/***********************************F-DEP-RCM-GEM-134-22/03/2013*****************************************/

/***********************************I-DEP-RCM-GEM-135-14/04/2013*****************************************/
alter table gem.tinstruc_seg_det
add constraint fk_tinstruc_seg_det__id_instruc_seg foreign key (id_instruc_seg)
references gem.tinstruc_seg (id_instruc_seg);

alter table gem.torden_trabajo
add constraint fk_torden_trabajo__id_cuenta foreign key (id_cuenta)
references gem.tcuenta (id_cuenta);
/***********************************F-DEP-RCM-GEM-135-14/04/2013*****************************************/

/***********************************I-DEP-RCM-GEM-137-03/05/2013*****************************************/
alter table gem.trecurso
add constraint fk_trecurso__id_orden_trabajo foreign key (id_orden_trabajo)
references gem.torden_trabajo (id_orden_trabajo);

alter table gem.tanalisis_mant
add constraint fk_tanalisis_mant__id_persona_prep foreign key (id_persona_prep)
references segu.tpersona (id_persona);
/***********************************F-DEP-RCM-GEM-137-03/05/2013*****************************************/

/***********************************I-DEP-RCM-GEM-0-24/05/2013*****************************************/
alter table gem.tanalisis_mant
add constraint fk_tanalisis_mant__id_uni_cons_hijo
foreign key (id_uni_cons_hijo) references gem.tuni_cons (id_uni_cons);
alter table gem.tplan_mant
add constraint fk_tplan_mant__id_uni_cons_hijo
foreign key (id_uni_cons_hijo) references gem.tuni_cons (id_uni_cons);
/***********************************F-DEP-RCM-GEM-0-24/05/2013*****************************************/

/***********************************I-DEP-RCM-GEM-141-29/05/2013*****************************************/
alter table gem.torden_trabajo
add constraint fk_torden_trabajo__id_mant_predef
foreign key (id_mant_predef) references gem.tmant_predef (id_mant_predef);
/***********************************F-DEP-RCM-GEM-141-29/05/2013*****************************************/

/***********************************I-DEP-RCM-GEM-0-01/07/2013*****************************************/
alter table gem.tpresupuesto_loc
add constraint fk_tpresupuesto_loc__id_presupuesto
foreign key (id_presupuesto) references gem.tpresupuesto (id_presupuesto);

alter table gem.tpresupuesto_loc
add constraint fk_tpresupuesto_loc__id_localizacion
foreign key (id_localizacion) references gem.tlocalizacion (id_localizacion);

alter table gem.tpresupuesto_localizacion
add constraint fk_tpresupuesto_localizacion__id_presupuesto
foreign key (id_presupuesto) references gem.tpresupuesto (id_presupuesto);

alter table gem.tpresupuesto_localizacion
add constraint fk_tpresupuesto_localizacion__id_localizacion
foreign key (id_localizacion) references gem.tlocalizacion (id_localizacion);

/***********************************F-DEP-RCM-GEM-0-01/07/2013*****************************************/

/***********************************I-DEP-RCM-GEM-0-09/07/2013*****************************************/
alter table gem.torden_trabajo
add constraint fk_torden_trabajo__id_calendario_planificacion
foreign key (id_calendario_planificacion) references gem.tcalendario_planificado (id_calendario_planificado);

alter table gem.torden_trabajo
add constraint fk_torden_trabajo__id_centro_costo
foreign key (id_centro_costo) references gem.tcentro_costo (id_centro_costo);

alter table gem.torden_trabajo
add constraint fk_torden_trabajo__id_funcionario_aprob
foreign key (id_funcionario_aprob) references orga.tfuncionario (id_funcionario);

alter table gem.torden_trabajo
add constraint fk_torden_trabajo__id_funcionario_recib
foreign key (id_funcionario_recib) references orga.tfuncionario (id_funcionario);

alter table gem.torden_trabajo
add constraint fk_torden_trabajo__id_localizacion
foreign key (id_localizacion) references gem.tlocalizacion (id_localizacion);
/***********************************F-DEP-RCM-GEM-0-09/07/2013*****************************************/

/***********************************I-DEP-RCM-GEM-0-25/07/2013*****************************************/
ALTER TABLE gem.torden_trabajo
  ADD CONSTRAINT fk_torden_trabajo__id_orden_trabajo_sol FOREIGN KEY (id_orden_trabajo_sol)
    REFERENCES gem.torden_trabajo_sol(id_orden_trabajo_sol)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-RCM-GEM-0-25/07/2013*****************************************/

/***********************************I-DEP-RCM-GEM-0-10/10/2013*****************************************/
ALTER TABLE gem.tmant_predef_item
  ADD CONSTRAINT fk_tmant_predef_item__id_mant_predef FOREIGN KEY (id_mant_predef)
    REFERENCES gem.tmant_predef(id_mant_predef)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE gem.tmant_predef_item
  ADD CONSTRAINT fk_tmant_predef_item__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-RCM-GEM-0-10/10/2013*****************************************/