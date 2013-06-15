CREATE OR REPLACE FUNCTION gem.ft_recurso_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION:     gem.ft_recurso_sel
 DESCRIPCION:   Transacciones de retorno de datos para la tabla Recurso
 AUTOR:     aao
 FECHA:         26-11-2012 15:27:00
 COMENTARIOS: 
***************************************************************************/

DECLARE

  v_consulta        varchar;
  v_parametros      record;
  v_nombre_funcion    text;
  v_resp        varchar;
          
BEGIN

  v_nombre_funcion = 'gem.ft_recurso_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'GEM_RECACTI_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   aao
  #FECHA:   26-11-2012 15:28:00
  ***********************************/

  if(p_transaccion='GEM_RECACTI_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
                    rec.id_recurso,
                    rec.id_usuario_reg,
                    usu1.cuenta as usr_reg,
                    rec.id_usuario_mod,
                    usu2.cuenta as usr_mod,
                    rec.fecha_reg,
                    rec.fecha_mod,
                    rec.estado_reg,
                    rec.id_actividad,
                    rec.id_item,
                    itm.nombre as nombre_item,
                    rec.id_funcionario,
                    (pers.nombre || '' '' || pers.apellido_paterno)::varchar as nombre_funcionario,
                    rec.id_especialidad,
                    esp.nombre as nombre_especialidad,
                    rec.id_servicio,
                    serv.nombre as nombre_servicio,
                    rec.id_moneda,
                    mon.codigo as codigo_moneda,
                    rec.cantidad,
                    rec.costo,
                    rec.observaciones,
                    rec.id_unidad_medida,
                    unimed.codigo as codigo_unidad_medida,
                    rec.hh_normal,
                    rec.hh_extras,
                    rec.hh_ext_mov,
                    rec.codigo,
                    rec.existencias,
                    rec.concepto,
                    rec.id_orden_trabajo,
                    rec.hh_fer_dom
                    from gem.trecurso rec
                    inner join segu.tusuario usu1 on usu1.id_usuario = rec.id_usuario_reg
                    left join segu.tusuario usu2 on usu2.id_usuario = rec.id_usuario_mod
                    left join alm.titem itm on rec.id_item = itm.id_item
                    left join orga.tespecialidad esp on rec.id_especialidad = esp.id_especialidad
                    left join param.tservicio serv on rec.id_servicio = serv.id_servicio
                    left join orga.tfuncionario func on rec.id_funcionario = func.id_funcionario
                    left join segu.tpersona pers on func.id_persona = pers.id_persona
                    left join param.tmoneda mon on rec.id_moneda = mon.id_moneda
                    left join param.tunidad_medida unimed on rec.id_unidad_medida = unimed.id_unidad_medida
                    where ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GEM_RECACTI_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   aao 
  #FECHA:   26-11-2012 16:41:00
  ***********************************/

  elsif(p_transaccion='GEM_RECACTI_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(rec.id_recurso)
                    from gem.trecurso rec
                    inner join gem.tactividad acti on rec.id_actividad = acti.id_actividad
                    inner join segu.tusuario usu1 on usu1.id_usuario = rec.id_usuario_reg
                    left join segu.tusuario usu2 on usu2.id_usuario = rec.id_usuario_mod
                    left join alm.titem itm on rec.id_item = itm.id_item
                    left join orga.tespecialidad esp on rec.id_especialidad = esp.id_especialidad
                    left join param.tservicio serv on rec.id_servicio = serv.id_servicio
                    left join orga.tfuncionario func on rec.id_funcionario = func.id_funcionario
                    left join segu.tpersona pers on func.id_persona = pers.id_persona
                    left join param.tmoneda mon on rec.id_moneda = mon.id_moneda
                    left join param.tunidad_medida unimed on rec.id_unidad_medida = unimed.id_unidad_medida
                    where ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
  /*********************************    
  #TRANSACCION:  'GEM_RECOT_SEL'
  #DESCRIPCION: Obtiene recursos a partir de 1 OT.
  #AUTOR:   aao
  #FECHA:   17-12-2012 18:35:00
  ***********************************/

  elseif(p_transaccion='GEM_RECOT_SEL')then
            
      begin
        
          create temp table trecurso_oit(
            id_recurso integer,
            id_usuario_reg integer,
            id_usuario_mod integer,
            fecha_reg timestamp,
            fecha_mod timestamp,
            estado_reg varchar,
            id_actividad integer,
            id_item integer,
            id_funcionario integer,
            id_especialidad integer,
            id_servicio integer,
            id_moneda integer,
            cantidad numeric,
            costo numeric,
            observaciones varchar,
            id_unidad_medida integer,
            hh_normal numeric,
            hh_extras numeric,
            hh_ext_mov numeric,
            codigo varchar,
            existencias varchar,
            id_orden_trabajo integer,
            hh_fer_dom numeric
            ) on commit drop;
            
            --inserta los recursos directos de las OTS
            insert into trecurso_oit
            select
            rec.id_recurso,
            rec.id_usuario_reg,
            rec.id_usuario_mod ,
            rec.fecha_reg,
            rec.fecha_mod,
            rec.estado_reg,
            rec.id_actividad,
            rec.id_item,
            rec.id_funcionario,
            rec.id_especialidad,
            rec.id_servicio,
            rec.id_moneda ,
            rec.cantidad,
            rec.costo,
            rec.observaciones,
            rec.id_unidad_medida,
            rec.hh_normal,
            rec.hh_extras,
            rec.hh_ext_mov,
            rec.codigo,
            rec.existencias,
            rec.id_orden_trabajo,
            rec.hh_fer_dom
            from gem.trecurso rec
            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo::integer;
            
            --inserta los recursos por actividad
          	insert into trecurso_oit
            select
            rec.id_recurso,rec.id_usuario_reg,rec.id_usuario_mod,rec.fecha_reg,
            rec.fecha_mod,rec.estado_reg,rec.id_actividad,rec.id_item,
            rec.id_funcionario,rec.id_especialidad,rec.id_servicio,rec.id_moneda,
            rec.cantidad,rec.costo,rec.observaciones,rec.id_unidad_medida,
            rec.hh_normal,rec.hh_extras,rec.hh_ext_mov,rec.codigo,
            rec.existencias,rec.id_orden_trabajo,rec.hh_fer_dom
            from gem.trecurso rec
            inner join gem.tactividad act on act.id_actividad = rec.id_actividad
            where act.id_orden_trabajo = v_parametros.id_orden_trabajo::integer;
            
        --Sentencia de la consulta
      v_consulta:='select
                rec.id_recurso,
                rec.id_usuario_reg,
                usu1.cuenta as usr_reg,
                rec.id_usuario_mod,
                usu2.cuenta as usr_mod,
                rec.fecha_reg,
                rec.fecha_mod,
                rec.estado_reg,
                rec.id_actividad,
                rec.id_item,
                itm.nombre as nombre_item,
                rec.id_funcionario,
                (pers.nombre || '' '' || pers.apellido_paterno || '' '' || pers.apellido_materno)::varchar as nombre_funcionario,
                (select nombre_cargo from orga.tuo where id_uo = orga.f_obtener_uo_x_funcionario(rec.id_funcionario,''funcionario'',now()::date)) as cargo_funcionario,
                rec.id_especialidad,
                esp.nombre as nombre_especialidad,
                rec.id_servicio,
                serv.nombre as nombre_servicio,
                rec.id_moneda,
                mon.codigo as codigo_moneda,
                rec.cantidad,
                rec.costo,
                rec.observaciones,
                rec.id_unidad_medida,
                unimed.codigo as codigo_unidad_medida,
                rec.hh_normal,
                rec.hh_extras,
                rec.hh_ext_mov,
                rec.codigo,
                rec.existencias,
                rec.id_orden_trabajo,
                rec.hh_fer_dom,
                case 
                	when rec.id_item is not null then
                		rec.costo * rec.cantidad
                	when rec.id_funcionario is not null then
                		(select gem.f_get_funcionario_honorario(rec.id_funcionario,''HH Normal'') * coalesce(rec.hh_normal,0))+
                		(select gem.f_get_funcionario_honorario(rec.id_funcionario,''HH Extra'') * coalesce(rec.hh_extras,0))+
                		(select gem.f_get_funcionario_honorario(rec.id_funcionario,''HH Nocturno'') * coalesce(rec.hh_ext_mov,0))+
                		(select gem.f_get_funcionario_honorario(rec.id_funcionario,''HH Fer.y Dom.'') * coalesce(rec.hh_fer_dom,0))
                	else rec.costo
                end as costo_total
                from trecurso_oit rec
                left join segu.tusuario usu1 on usu1.id_usuario = rec.id_usuario_reg
                left join segu.tusuario usu2 on usu2.id_usuario = rec.id_usuario_mod
                left join alm.titem itm on rec.id_item = itm.id_item
                left join orga.tespecialidad esp on rec.id_especialidad = esp.id_especialidad
                left join param.tservicio serv on rec.id_servicio = serv.id_servicio
                left join orga.tfuncionario func on rec.id_funcionario = func.id_funcionario
                /*left join orga.tuo_funcionario uofun on rec.id_funcionario = uofun.id_funcionario
                left join orga.tuo uo on uofun.id_uo = uo.id_uo*/
                left join segu.tpersona pers on func.id_persona = pers.id_persona
                left join param.tmoneda mon on rec.id_moneda = mon.id_moneda
                left join param.tunidad_medida unimed on rec.id_unidad_medida = unimed.id_unidad_medida
                where ';
                
              --(uofun.estado_reg = ''activo'' or uofun.estado_reg is null) and 
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
raise notice '%',v_consulta;
      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GEM_RECACTI_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   aao 
  #FECHA:   26-11-2012 16:41:00
  ***********************************/

  elsif(p_transaccion='GEM_RECACTI_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(rec.id_recurso)
                    from gem.trecurso rec
                    inner join gem.tactividad acti on rec.id_actividad = acti.id_actividad
                    inner join segu.tusuario usu1 on usu1.id_usuario = rec.id_usuario_reg
                    left join segu.tusuario usu2 on usu2.id_usuario = rec.id_usuario_mod
                    left join alm.titem itm on rec.id_item = itm.id_item
                    left join orga.tespecialidad esp on rec.id_especialidad = esp.id_especialidad
                    left join param.tservicio serv on rec.id_servicio = serv.id_servicio
                    left join orga.tfuncionario func on rec.id_funcionario = func.id_funcionario
                    left join orga.tuo_funcionario uofun on rec.id_funcionario = uofun.id_funcionario
                    left join orga.tuo uo on uofun.id_uo = uo.id_uo
                    left join segu.tpersona pers on func.id_persona = pers.id_persona
                    left join param.tmoneda mon on rec.id_moneda = mon.id_moneda
                    left join param.tunidad_medida unimed on rec.id_unidad_medida = unimed.id_unidad_medida
                    where rec.id_actividad = ' || v_parametros.id_actividad || ' and ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
          
  else
               
    raise exception 'Transaccion inexistente';
                   
  end if;
          
EXCEPTION
          
  WHEN OTHERS THEN
      v_resp='';
      v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
      v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
      v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
      raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;