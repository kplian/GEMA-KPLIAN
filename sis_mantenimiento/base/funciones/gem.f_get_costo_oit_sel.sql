CREATE OR REPLACE FUNCTION gem.f_get_costo_oit_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS SETOF record AS
$body$
/**************************************************************************
 PXP - KPLIAN
***************************************************************************
 SCRIPT:    gem.f_get_costo_oit_sel
 DESCRIPCIÓN:   
 AUTOR:     RCM
 FECHA:     18/02/2013
 COMENTARIOS: 
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCIÓN:
 AUTOR:       
 FECHA:      

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

-- PARÁMETROS FIJOS
/*
pm_id_usuario                               integer (si)
pm_ip_origen                                varchar(40) (si)
pm_mac_maquina                              macaddr (si)
pm_log_error                                varchar -- log -- error //variable interna (si)
pm_codigo_procedimiento                     varchar  // valor que identifica el tipo
                                                        de operacion a realizar
                                                        insert  (insertar)
                                                        delete  (eliminar)
                                                        update  (actualizar)
                                                        select  (visualizar)
pm_proc_almacenado                          varchar  // para colocar el nombre del procedimiento en caso de ser llamado
                                                        por otro procedimiento
*/

DECLARE

    v_consulta    varchar;
    v_parametros      record;
    v_nombre_funcion    text;
    v_resp      varchar;
    g_registros  record;
    v_rec record;
    v_sql varchar;
    v_repuestos numeric;
    v_repuestos_rec numeric;
    v_hn  numeric;
    v_he1 numeric;
    v_he2 numeric;
    v_he3 numeric;
    v_tot_func numeric;
    v_servicio    numeric;
    v_servicio_rec    numeric;
    v_total     numeric;
    v_aux numeric;
    v_hotel numeric;
    v_hotel_rec numeric;
    v_alimentacion numeric;
    v_alimentacion_rec numeric;
    v_servicio_ott numeric;
    v_servicio_ott_rec numeric;
    v_sw_oit varchar;

BEGIN

  v_nombre_funcion = 'gem.f_get_costo_oit_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'GEM_CTOIT_SEL'
  #DESCRIPCION: Costo OIT
  #AUTOR:     RCM
  #FECHA:     18-02-2013
  ***********************************/

  IF(p_transaccion='GEM_CTOIT_SEL')then
      begin
          --Inicializa variables
            v_repuestos=0;
            v_hn=0;
            v_he1=0;
            v_he2=0;
            v_he3=0;
            v_servicio=0;
            v_total=0;
            v_aux=0;
            v_tot_func=0;
            v_alimentacion = 0;
            
            --Verifica el parametro de OIT
            v_sw_oit='no';
            if pxp.f_existe_parametro(p_tabla,'sw_oit') then
            	v_sw_oit = v_parametros.sw_oit;
            end if;
            
            select 
            coalesce(sum(rec.cantidad*rec.costo),0)
            into v_repuestos
            from gem.trecurso rec
            inner join gem.tactividad act
            on act.id_actividad = rec.id_actividad
            where act.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.id_item is not null;
            
            select 
            coalesce(sum(rec.cantidad*rec.costo),0)
            into v_repuestos_rec
            from gem.trecurso rec
            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.id_item is not null;
            
            v_repuestos = v_repuestos + v_repuestos_rec;
            
            select 
            coalesce(sum(rec.costo),0)
            into v_servicio
            from gem.trecurso rec
            inner join gem.tactividad act
            on act.id_actividad = rec.id_actividad
            where act.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.id_servicio is not null;
            
            select 
            coalesce(sum(rec.costo),0)
            into v_servicio_rec
            from gem.trecurso rec
            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.id_servicio is not null;
            
            v_servicio = v_servicio + v_servicio_rec;
            
            --honorarios por actividad y funcionario
            for v_rec in (select *
                      		from gem.trecurso rec
                            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo
                            and rec.id_funcionario is not null) loop
                raise notice '%, %, %',v_rec.hh_normal,v_rec.hh_extras,v_rec.hh_ext_mov;
                if coalesce(v_rec.hh_normal,0) > 0 then
                  select coalesce(coalesce(costo_hora,0) * coalesce(v_rec.hh_normal,0),0)
                    into v_aux
                    from gem.tfuncionario_honorario fho
                    inner join orga.ttipo_horario hor
                    on hor.id_tipo_horario = fho.id_tipo_horario
                    where id_funcionario = v_rec.id_funcionario
                    and codigo = 'HH Normal';
                    v_hn = v_hn + coalesce(v_aux,0);
                    raise notice 'cant horas:%, costo: %',v_rec.hh_normal,v_aux;
                end if;
                if coalesce(v_rec.hh_extras,0) > 0 then
                  select coalesce(coalesce(costo_hora,0) * coalesce(v_rec.hh_extras,0),0)
                    into v_aux
                    from gem.tfuncionario_honorario fho
                    inner join orga.ttipo_horario hor
                    on hor.id_tipo_horario = fho.id_tipo_horario
                    where id_funcionario = v_rec.id_funcionario
                    and codigo = 'HH Extra';
                    v_he1 = v_he1 + coalesce(v_aux,0);
                    raise notice 'cant horas:%, costo: %',v_rec.hh_extras,v_aux;                    
                end if;
                if coalesce(v_rec.hh_ext_mov,0) > 0 then
                  select coalesce(coalesce(costo_hora,0) * coalesce(v_rec.hh_ext_mov,0),0)
                    into v_aux
                    from gem.tfuncionario_honorario fho
                    inner join orga.ttipo_horario hor
                    on hor.id_tipo_horario = fho.id_tipo_horario
                    where id_funcionario = v_rec.id_funcionario
                    and codigo = 'HH Nocturno';
                    v_he2 = v_he2 + coalesce(v_aux,0);
                    raise notice 'cant horas:%, costo: %',v_rec.hh_ext_mov,v_aux;                    
                end if;
                if coalesce(v_rec.hh_fer_dom,0) > 0 then
                  select coalesce(coalesce(costo_hora,0) * coalesce(v_rec.hh_fer_dom,0),0)
                    into v_aux
                    from gem.tfuncionario_honorario fho
                    inner join orga.ttipo_horario hor
                    on hor.id_tipo_horario = fho.id_tipo_horario
                    where id_funcionario = v_rec.id_funcionario
                    and codigo = 'HH Fer.y Dom.';
                    v_he3 = v_he3 + coalesce(v_aux,0);
                    raise notice 'cant horas:%, costo: %',v_rec.hh_fer_dom,v_aux;                    
                end if;
            end loop;
            
            for v_rec in (select *
                            from gem.trecurso rec
                            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo
                            and rec.id_funcionario is not null) loop
                raise notice '%, %, %',v_rec.hh_normal,v_rec.hh_extras,v_rec.hh_ext_mov;
                if coalesce(v_rec.hh_normal,0) > 0 then
                  select coalesce(coalesce(costo_hora,0) * coalesce(v_rec.hh_normal,0),0)
                    into v_aux
                    from gem.tfuncionario_honorario fho
                    inner join orga.ttipo_horario hor
                    on hor.id_tipo_horario = fho.id_tipo_horario
                    where id_funcionario = v_rec.id_funcionario
                    and codigo = 'HN';
                    v_hn = v_hn + coalesce(v_aux,0);
                    raise notice 'cant horas:%, costo: %',v_rec.hh_normal,v_aux;
                end if;
                if coalesce(v_rec.hh_extras,0) > 0 then
                  select coalesce(coalesce(costo_hora,0) * coalesce(v_rec.hh_extras,0),0)
                    into v_aux
                    from gem.tfuncionario_honorario fho
                    inner join orga.ttipo_horario hor
                    on hor.id_tipo_horario = fho.id_tipo_horario
                    where id_funcionario = v_rec.id_funcionario
                    and codigo = 'HE1';
                    v_he1 = v_he1 + coalesce(v_aux,0);
                    raise notice 'cant horas:%, costo: %',v_rec.hh_extras,v_aux;                    
                end if;
                if coalesce(v_rec.hh_ext_mov,0) > 0 then
                  select coalesce(coalesce(costo_hora,0) * coalesce(v_rec.hh_ext_mov,0),0)
                    into v_aux
                    from gem.tfuncionario_honorario fho
                    inner join orga.ttipo_horario hor
                    on hor.id_tipo_horario = fho.id_tipo_horario
                    where id_funcionario = v_rec.id_funcionario
                    and codigo = 'HE2';
                    v_he2 = v_he2 + coalesce(v_aux,0);
                    raise notice 'cant horas:%, costo: %',v_rec.hh_ext_mov,v_aux;                    
                end if;
                if coalesce(v_rec.hh_fer_dom,0) > 0 then
                  select coalesce(coalesce(costo_hora,0) * coalesce(v_rec.hh_fer_dom,0),0)
                    into v_aux
                    from gem.tfuncionario_honorario fho
                    inner join orga.ttipo_horario hor
                    on hor.id_tipo_horario = fho.id_tipo_horario
                    where id_funcionario = v_rec.id_funcionario
                    and codigo = 'HE3';
                    v_he3 = v_he3 + coalesce(v_aux,0);
                    raise notice 'cant horas:%, costo: %',v_rec.hh_fer_dom,v_aux;                    
                end if;
            end loop;
            
            v_tot_func=v_hn+v_he1+v_he2+v_he3;
            
            select 
            coalesce(sum(rec.costo),0)
            into v_hotel
            from gem.trecurso rec
            inner join gem.tactividad act
            on act.id_actividad = rec.id_actividad
            where act.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.concepto = 'hotel';
            
            select 
            coalesce(sum(rec.costo),0)
            into v_hotel_rec
            from gem.trecurso rec
            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.concepto = 'hotel';
            
            v_hotel = v_hotel + v_hotel_rec; 
            
            select 
            coalesce(sum(rec.costo),0)
            into v_alimentacion
            from gem.trecurso rec
            inner join gem.tactividad act
            on act.id_actividad = rec.id_actividad
            where act.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.concepto = 'alimentacion';
            
            select 
            coalesce(sum(rec.costo),0)
            into v_alimentacion_rec
            from gem.trecurso rec
            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.concepto = 'alimentacion';
            
            v_alimentacion = v_alimentacion + v_alimentacion_rec;
            
            select 
            coalesce(sum(rec.costo),0)
            into v_servicio_ott
            from gem.trecurso rec
            inner join gem.tactividad act
            on act.id_actividad = rec.id_actividad
            where act.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.concepto = 'servicios_ott';
            
            select 
            coalesce(sum(rec.costo),0)
            into v_servicio_ott_rec
            from gem.trecurso rec
            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo
            and rec.concepto = 'servicios_ott';
            
            v_servicio_ott = v_servicio_ott + v_servicio_ott_rec;
            
            v_total = v_repuestos + v_tot_func + v_servicio + v_hotel + v_alimentacion + v_servicio_ott;
            
            --Creación de tabla temporal para almacenamiento de los costos
            create temporary table tt_costo_oit(
        descripcion varchar,
        costo numeric
      ) on commit drop;
            
            --Inserción de los datos
            if v_sw_oit = 'no' then
	            insert into tt_costo_oit(descripcion, costo) values('Repuestos',v_repuestos);
	            insert into tt_costo_oit(descripcion, costo) values('Mano de Obra',v_tot_func);
            end if;
            insert into tt_costo_oit(descripcion, costo) values('Servicios OTT',v_servicio_ott);
            insert into tt_costo_oit(descripcion, costo) values('Otros servicios',v_servicio);
            insert into tt_costo_oit(descripcion, costo) values('Hotel',v_hotel);
            insert into tt_costo_oit(descripcion, costo) values('Alimentación',v_alimentacion);
            insert into tt_costo_oit(descripcion, costo) values('TOTAL COSTO OIT',v_total);
            
            raise notice '%',v_parametros.id_orden_trabajo;
            
            for v_rec in (select descripcion,round(costo,2) from tt_costo_oit) loop
              return next v_rec;
            end loop;
            
            return;
        
      end;
        
  /*********************************    
  #TRANSACCION:  'GEM_CTOIT_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:     rcm
  #FECHA:     18-02-2013
  ***********************************/

  elsif(p_transaccion='GEM_CTOIT_CONT')then

    begin
      FOR g_registros in (select 1) LOOP
           RETURN NEXT g_registros;
      END LOOP;
            
            return;

    end;

  ELSE
               
    raise exception 'Transaccion inexistente';
    
  END IF;


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
COST 100 ROWS 1000;