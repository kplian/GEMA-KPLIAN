CREATE OR REPLACE FUNCTION gem.ft_estructura_uo_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION:     GEM.ft_estructura_uo_sel
 DESCRIPCIÓN:  listado de uo
 AUTOR:       rcm  
 FECHA:       18/05/2013  
 COMENTARIOS: 
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:   
 FECHA:   
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;


v_condicion     varchar;
v_ids varchar;

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='rhum.ft_estructura_uo_sel';
    

         
     /*******************************
     #TRANSACCION:  GEM_FUNUO_SEL
     #DESCRIPCION:  Listado de funcionarios por UO
     #AUTOR:    RCM
     #FECHA:    17/05/2013  
     ***********************************/
     if(par_transaccion='GE_FUNUO_SEL')then

          
          BEGIN

              --Obtención de los IDs de Unidad Organizacional
              WITH RECURSIVE t(id,id_fk,n) AS (
                  SELECT l.id_uo_hijo,l.id_uo_padre, 1
                  FROM orga.testructura_uo l
                  WHERE l.id_uo_padre = v_parametros.id_uo
                  UNION ALL
                  SELECT l.id_uo_hijo,l.id_uo_padre,n+1
                  FROM orga.testructura_uo l, t
                  WHERE l.id_uo_padre = t.id
              )
              SELECT v_parametros.id_uo || ',' ||(pxp.list(id::text))::varchar
              INTO v_ids
              FROM t;
              
              if v_ids is null then
                v_ids = v_parametros.id_uo;
              end if;
               
               
               v_consulta:='select
                            uofun.id_uo_funcionario, vfun.desc_funcionario1,
                            fun.codigo,uo.nombre_cargo,vfun.ci,fun.fecha_ingreso,
                            fun.email_empresa,fun.telefono_ofi,fun.interno,per.telefono1 || '', '' || per.telefono2,
                            per.celular1 || '', '' || per.celular2, per.correo,
                            coalesce((select costo_hora from gem.tfuncionario_honorario where id_funcionario = fun.id_funcionario and id_tipo_horario = 3),0) as horario1,
                            coalesce((select costo_hora from gem.tfuncionario_honorario where id_funcionario = fun.id_funcionario and id_tipo_horario = 6),0) as horario2,
                            coalesce((select costo_hora from gem.tfuncionario_honorario where id_funcionario = fun.id_funcionario and id_tipo_horario = 4),0) as horario3,
                            coalesce((select costo_hora from gem.tfuncionario_honorario where id_funcionario = fun.id_funcionario and id_tipo_horario = 5),0) as horario4
                            from orga.tuo_funcionario uofun
                            inner join orga.tuo uo on uo.id_uo = uofun.id_uo
                            inner join orga.vfuncionario vfun on vfun.id_funcionario = uofun.id_funcionario
                            inner join orga.tfuncionario fun on fun.id_funcionario = vfun.id_funcionario
                            inner join segu.tpersona per on per.id_persona = fun.id_persona
                            where ((''' || v_parametros.fecha || ''' between uofun.fecha_asignacion and uofun.fecha_finalizacion)
                            or (uofun.fecha_finalizacion is null and ''' || v_parametros.fecha || ''' >= uofun.fecha_asignacion and uofun.estado_reg = ''activo''))
                            and uofun.id_uo in ('||v_ids||')
                            and  ';
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

               raise notice '%',v_consulta;
               return v_consulta;


         END;
         
      /*******************************
     #TRANSACCION:  GEM_FUNUO_CONT
     #DESCRIPCION:  Conteo de listado de funcionarios por uo
     #AUTOR:    RCM
     #FECHA:    17/05/2013  
    ***********************************/
     elsif(par_transaccion='GE_FUNUO_CONT')then

          BEGIN
          
              --Obtención de los IDs de Unidad Organizacional
              WITH RECURSIVE t(id,id_fk,n) AS (
                  SELECT l.id_uo_hijo,l.id_uo_padre, 1
                  FROM orga.testructura_uo l
                  WHERE l.id_uo_padre = v_parametros.id_uo
                  UNION ALL
                  SELECT l.id_uo_hijo,l.id_uo_padre,n+1
                  FROM orga.testructura_uo l, t
                  WHERE l.id_uo_padre = t.id
              )
              SELECT v_parametros.id_uo || ',' ||(pxp.list(id::text))::varchar
              INTO v_ids
              FROM t;
              
              if v_ids is null then
                v_ids = v_parametros.id_uo;
              end if;

              v_consulta:='select
                            count(uofun.id_uo_funcionario)
                            from orga.tuo_funcionario uofun
                            inner join orga.tuo uo on uo.id_uo = uofun.id_uo
                            inner join orga.vfuncionario vfun on vfun.id_funcionario = uofun.id_funcionario
                            inner join orga.tfuncionario fun on fun.id_funcionario = vfun.id_funcionario
                            inner join segu.tpersona per on per.id_persona = fun.id_persona
                            where ((''' || v_parametros.fecha || ''' between uofun.fecha_asignacion and uofun.fecha_finalizacion)
                            or (uofun.fecha_finalizacion is null and ''' || v_parametros.fecha || ''' >= uofun.fecha_asignacion and uofun.estado_reg = ''activo''))
                            and uofun.id_uo in ('||v_ids||')
                            and ';
               
               v_consulta:=v_consulta||v_parametros.filtro;
               
               return v_consulta;
         END;
     else
         raise exception 'No existe la opcion';

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