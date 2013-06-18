CREATE OR REPLACE FUNCTION gem.ft_funcion_analisis_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION:     gem.ft_funcion_analisis_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tfuncion'
 AUTOR:      (admin)
 FECHA:         30-09-2012 21:41:09
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
  v_id_funcion integer;
  v_id_funcion_falla integer;
  v_id_modo_falla integer;
  v_fun_orden varchar;
  v_fun_descripcion varchar;
  v_ffall_orden varchar;
  v_ffall_falla varchar;
  v_rec record;
  v_cond varchar;
          
BEGIN

  v_nombre_funcion = 'gem.ft_funcion_analisis_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'GEM_GEFUNC_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   30-09-2012 21:41:09
  ***********************************/

  if(p_transaccion='GEM_GEFUNC_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
            gefunc.id_funcion,
            gefunc.id_analisis_mant,
            gefunc.descripcion,
            gefunc.orden,
            gefunc.estado_reg,
            gefunc.id_usuario_reg,
            gefunc.fecha_reg,
            gefunc.fecha_mod,
            gefunc.id_usuario_mod,
            usu1.cuenta as usr_reg,
            usu2.cuenta as usr_mod  
            from gem.tfuncion gefunc
            inner join segu.tusuario usu1 on usu1.id_usuario = gefunc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = gefunc.id_usuario_mod
            where ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GEM_GEFUNC_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   admin 
  #FECHA:   30-09-2012 21:41:09
  ***********************************/

  elsif(p_transaccion='GEM_GEFUNC_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_funcion)
              from gem.tfuncion gefunc
            inner join segu.tusuario usu1 on usu1.id_usuario = gefunc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = gefunc.id_usuario_mod
                where ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
    
  /*********************************    
  #TRANSACCION:  'GEM_REPANA_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   30-09-2012 21:41:09
  ***********************************/

  elsif(p_transaccion='GEM_REPANA_SEL')then
            
      begin
        
        --Creación de tabla temporal
        create temp table tt_ana_mant(
          fun_orden varchar,
          fun_descripcion varchar,
          ffall_orden varchar,
          ffall_falla varchar,
          mfall_orden varchar,
          modo_falla varchar,
          efecto_falla varchar
        ) on commit drop;
        
        --Sentencia de la consulta
        v_consulta:='select
                  fun.id_funcion, coalesce(ffall.id_funcion_falla,-1) as id_funcion_falla,
                  coalesce(mfall.id_modo_falla,-1) as id_modo_falla,
                  fun.orden as fun_orden,
                  fun.descripcion as fun_descripcion,
                  ffall.orden as ffall_orden,
                  ffall.falla as ffall_falla,
                  mfall.orden as mfall_orden,
                  mfall.modo_falla,
                  mfall.efecto_falla 
                  from gem.tanalisis_mant amant
                  left join gem.tfuncion fun
                  on fun.id_analisis_mant = amant.id_analisis_mant
                  left join gem.tfuncion_falla ffall
                  on ffall.id_funcion = fun.id_funcion
                  left join gem.tmodo_falla mfall
                  on mfall.id_funcion_falla = ffall.id_funcion_falla
                  where amant.id_analisis_mant = '||v_parametros.id_analisis_mant || ' and ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
      
--      raise notice '%',v_consulta;
--      raise notice '%',v_parametros.id_analisis_mant;
      
      v_id_funcion=0;
      v_id_funcion_falla=0;
      v_id_modo_falla=0;

      for v_rec in execute(v_consulta) loop
          if v_id_funcion <> v_rec.id_funcion then
            v_fun_orden = v_rec.fun_orden::varchar;
            v_fun_descripcion = v_rec.fun_descripcion;
            v_id_funcion = v_rec.id_funcion;
          else
              v_fun_orden = '';
              v_fun_descripcion = '';
          end if;
          
          if v_id_funcion_falla <> v_rec.id_funcion_falla then
            v_ffall_orden = v_rec.ffall_orden;
            v_ffall_falla = v_rec.ffall_falla;
            v_id_funcion_falla = v_rec.id_funcion_falla;
          else
              v_ffall_orden = '';
              v_ffall_falla = '';
          end if;
          
          insert into tt_ana_mant values(
          v_fun_orden, v_fun_descripcion,v_ffall_orden, v_ffall_falla,
          v_rec.mfall_orden, v_rec.modo_falla, v_rec.efecto_falla
          );
          
      end loop;
      
      v_consulta = 'select * from tt_ana_mant';
      

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GEM_EQFUNC_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   rcm 
  #FECHA:   28/05/2013
  ***********************************/
  elsif(p_transaccion='GEM_EQFUNC_SEL')then
            
      begin

		if pxp.f_existe_parametro(p_tabla,'id_uni_cons_hijo') then
        	if v_parametros.id_uni_cons_hijo is null then
            	v_cond = 'amant.id_uni_cons = ' || v_parametros.id_uni_cons;
            else
            	v_cond = 'amant.id_uni_cons_hijo = ' || v_parametros.id_uni_cons_hijo;
            end if;
		else
			v_cond = 'amant.id_uni_cons = ' || v_parametros.id_uni_cons;
		end if;

		--Sentencia de la consulta
      v_consulta:='select
            gefunc.id_funcion,
            gefunc.id_analisis_mant,
            gefunc.descripcion,
            gefunc.orden,
            gefunc.estado_reg,
            gefunc.id_usuario_reg,
            gefunc.fecha_reg,
            gefunc.fecha_mod,
            gefunc.id_usuario_mod,
            usu1.cuenta as usr_reg,
            usu2.cuenta as usr_mod  
            from gem.tfuncion gefunc
            inner join segu.tusuario usu1 on usu1.id_usuario = gefunc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = gefunc.id_usuario_mod
			inner join gem.tanalisis_mant amant on amant.id_analisis_mant = gefunc.id_analisis_mant
            where ' || v_cond || ' and ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;

	  end;

  /*********************************    
  #TRANSACCION:  'GEM_EQFUNC_CONT'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   rcm 
  #FECHA:   28/05/2013
  ***********************************/
  elsif(p_transaccion='GEM_EQFUNC_CONT')then
            
      begin

		if pxp.f_existe_parametro(p_tabla,'id_uni_cons_hijo') then
        	if v_parametros.id_uni_cons_hijo is null then
            	v_cond = 'amant.id_uni_cons = ' || v_parametros.id_uni_cons;
            else
            	v_cond = 'amant.id_uni_cons_hijo = ' || v_parametros.id_uni_cons_hijo;
            end if;
		else
			v_cond = 'amant.id_uni_cons = ' || v_parametros.id_uni_cons;
		end if;

		--Sentencia de la consulta
      v_consulta:='select
            count(gefunc.id_funcion) as total 
            from gem.tfuncion gefunc
            inner join segu.tusuario usu1 on usu1.id_usuario = gefunc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = gefunc.id_usuario_mod
			inner join gem.tanalisis_mant amant on amant.id_analisis_mant = gefunc.id_analisis_mant
            where ' || v_cond || ' and ';
      
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