CREATE OR REPLACE FUNCTION gem.ft_calculo_indicadores_graf_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Mantenimiento Industrial - Plantas y Estaciones
 FUNCION:     gem.ft_calculo_indicadores_graf_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tcentro_costo'
 AUTOR:     rcm
 FECHA:         21-04-2013
 COMENTARIOS: 
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/

DECLARE

  v_consulta        varchar;
  v_parametros      record;
  v_nombre_funcion    text;
  v_resp        varchar;
    v_fecha_ini     date;
    v_fecha_fin     date;
    v_ids_loc     varchar;
    v_sql         varchar;
    v_cond        varchar;
          
BEGIN

  v_nombre_funcion = 'gem.ft_calculo_indicadores_graf_sel';
    v_parametros = pxp.f_get_record(p_tabla);
    
    --Verifica los parámetros de id_localizacion e id_uni_cons
    if v_parametros.id_localizacion is not null then
      v_ids_loc = gem.f_get_id_localizaciones(v_parametros.id_localizacion);
        v_cond = ' and ucons.id_localizacion in ('||v_ids_loc||')';
    elsif v_parametros.id_uni_cons is not null then
      v_cond = ' and ucons.id_uni_cons = '||v_parametros.id_uni_cons;
    else
      raise exception 'Localización o Equipo no puede ser nulo';
    end if;

  /*********************************    
  #TRANSACCION:  'GM_GRATMA_SEL'
  #DESCRIPCION: Indicador de Tipo de Mantenimiento
  #AUTOR:     RCM
  #FECHA:     21-04-2013
  ***********************************/

  if(p_transaccion='GM_GRATMA_SEL')then
            
      begin
        
          --Procesa las fechas de inicio y fin
            v_fecha_ini = pxp.f_get_fecha_ult_pri(v_parametros.mes_ini,v_parametros.gestion_ini,'primero');
            v_fecha_fin = pxp.f_get_fecha_ult_pri(v_parametros.mes_fin,v_parametros.gestion_fin,'ultimo');
            
        --Sentencia de la consulta
      v_consulta:='select
                        tman.nombre as tipo, count(ot.id_orden_trabajo) as total
                        from gem.torden_trabajo ot
                        inner join gem.ttipo_mant tman
                        on tman.id_tipo_mant = ot.id_tipo_mant
                        inner join gem.tuni_cons ucons
                        on ucons.id_uni_cons = ot.id_uni_cons
                        where ot.cat_estado in (''Revisado'',''Cerrado'')
                        and ot.fecha_eje_ini between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin || '''';
            v_consulta:=v_consulta || v_cond || '
                        group by tman.nombre';

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GM_GRACOS_SEL'
  #DESCRIPCION: Indicador de Costos de Mantenimiento
  #AUTOR:     RCM
  #FECHA:     21-04-2013
  ***********************************/

  elsif(p_transaccion='GM_GRACOS_SEL')then
            
      begin
        
          --Procesa las fechas de inicio y fin
            v_fecha_ini = pxp.f_get_fecha_ult_pri(v_parametros.mes_ini,v_parametros.gestion_ini,'primero');
            v_fecha_fin = pxp.f_get_fecha_ult_pri(v_parametros.mes_fin,v_parametros.gestion_fin,'ultimo');

		--Sentencia de la consulta
      	v_consulta:='select
                        ''Materiales'' as tipo, coalesce(sum(coalesce(rec.costo,0)*coalesce(rec.cantidad,0)),0) as total
                        from gem.torden_trabajo ot
                        inner join gem.tuni_cons ucons
                        on ucons.id_uni_cons = ot.id_uni_cons
                        inner join gem.trecurso rec
                        on rec.id_orden_trabajo = ot.id_orden_trabajo
                        where ot.cat_estado in (''Revisado'',''Cerrado'')
                        and rec.id_item is not null
                        and ot.fecha_eje_fin between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin || '''';
                        
            v_consulta:=v_consulta || v_cond || '
                        union
                        select
                        ''Mano de Obra'' as tipo, 
                        coalesce(sum(gem.f_get_funcionario_honorario(rec.id_funcionario,''HH Normal'')*coalesce(rec.hh_normal,0)+
                        gem.f_get_funcionario_honorario(rec.id_funcionario,''HH Extra'')*coalesce(rec.hh_extras,0)+
                        gem.f_get_funcionario_honorario(rec.id_funcionario,''HH Nocturno'')*coalesce(rec.hh_ext_mov,0)+
                        gem.f_get_funcionario_honorario(rec.id_funcionario,''HH Fer.y Dom.'')*coalesce(rec.hh_fer_dom,0)
                        ),0) as total
                        from gem.torden_trabajo ot
                        inner join gem.tuni_cons ucons
                        on ucons.id_uni_cons = ot.id_uni_cons
                        inner join gem.trecurso rec
                        on rec.id_orden_trabajo = ot.id_orden_trabajo
                        where ot.cat_estado in (''Revisado'',''Cerrado'')
                        and rec.id_funcionario is not null
                        and ot.fecha_eje_fin between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin || '''';
                        
            v_consulta:=v_consulta || v_cond || '
                        union
                        select
                        ''Servicios OTT'' as tipo, coalesce(sum(rec.costo),0) as total
                        from gem.torden_trabajo ot
                        inner join gem.tuni_cons ucons
                        on ucons.id_uni_cons = ot.id_uni_cons
                        inner join gem.trecurso rec
                        on rec.id_orden_trabajo = ot.id_orden_trabajo
                        left join param.tservicio ser
                        on ser.id_servicio = rec.id_servicio
                        where ot.cat_estado in (''Revisado'',''Cerrado'')
                        and rec.concepto = ''servicios_ott''
                        and ot.fecha_eje_fin between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin || '''';
            
            v_consulta:=v_consulta || v_cond || '
                        union
                        select
                        ''Otros'' as tipo, coalesce(sum(rec.costo),0) as total
                        from gem.torden_trabajo ot
                        inner join gem.tuni_cons ucons
                        on ucons.id_uni_cons = ot.id_uni_cons
                        inner join gem.trecurso rec
                        on rec.id_orden_trabajo = ot.id_orden_trabajo
                        left join param.tservicio ser
                        on ser.id_servicio = rec.id_servicio
                        where ot.cat_estado in (''Revisado'',''Cerrado'')
                        and (rec.id_servicio is not null or rec.concepto = ''hotel'' or rec.concepto = ''alimentacion'')
                        and ot.fecha_eje_fin between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin || '''';
                        
            v_consulta:=v_consulta || v_cond || ' order by 1';
            raise notice '%',v_consulta;

      --Devuelve la respuesta
      return v_consulta;
            
    end;
        
    /*********************************    
  #TRANSACCION:  'GM_GRAEJM_SEL'
  #DESCRIPCION: Indicador de Ejecucion de Mantenimiento
  #AUTOR:     RCM
  #FECHA:     21-04-2013
  ***********************************/

  elsif(p_transaccion='GM_GRAEJM_SEL')then
            
      begin
        
          --Procesa las fechas de inicio y fin
            v_fecha_ini = pxp.f_get_fecha_ult_pri(v_parametros.mes_ini,v_parametros.gestion_ini,'primero');
            v_fecha_fin = pxp.f_get_fecha_ult_pri(v_parametros.mes_fin,v_parametros.gestion_fin,'ultimo');

            --Crea una tabla temporal
            create temp table tt_graf_indicadores(
                id_orden_trabajo integer,
                    fecha date,
                    estado varchar
                ) on commit drop;
            
        --Sentencia de la consulta
            v_consulta = 'insert into tt_graf_indicadores
                    select
                    ot.id_orden_trabajo, ot.fecha_emision,''Planificado''
                    from gem.torden_trabajo ot
                    inner join gem.ttipo_mant tman
                    on tman.id_tipo_mant = ot.id_tipo_mant
                    inner join gem.tuni_cons ucons
                    on ucons.id_uni_cons = ot.id_uni_cons
                    where ot.cat_estado in (''Pendiente'',''Abierto'',''Cerrado'',''Revisado'')
                    and ot.fecha_emision between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin || '''';
            v_consulta:=v_consulta || v_cond;
            
            execute(v_consulta);
            
            v_consulta = 'insert into tt_graf_indicadores
                    select
                    ot.id_orden_trabajo, ot.fecha_eje_fin,''Ejecutado''
                    from gem.torden_trabajo ot
                    inner join gem.ttipo_mant tman
                    on tman.id_tipo_mant = ot.id_tipo_mant
                    inner join gem.tuni_cons ucons
                    on ucons.id_uni_cons = ot.id_uni_cons
                    where ot.cat_estado in (''Revisado'',''Cerrado'')
                    and ot.fecha_emision between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin || '''';
            v_consulta:=v_consulta || v_cond;
            
            execute(v_consulta);
            
            v_consulta = 'select 
                PLA.fecha, sum(PLA.total) as total_pla, sum(EJE.total) as total_eje
                from (select
                	to_char(fecha,''mm/yyyy'') as fecha,count(id_orden_trabajo) as total
                	from tt_graf_indicadores
                    where estado = ''Planificado''
                    group by to_char(fecha,''mm/yyyy'')) PLA
                left join (select
                	to_char(fecha,''mm/yyyy'') as fecha,count(id_orden_trabajo) as total
                	from tt_graf_indicadores
                	where estado = ''Ejecutado''
                    group by to_char(fecha,''mm/yyyy'')) EJE
                on PLA.fecha = EJE.fecha
                group by PLA.fecha
                order by 1';

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