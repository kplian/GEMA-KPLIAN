CREATE OR REPLACE FUNCTION gem.ft_localizacion_med_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_localizacion_med_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tlocalizacion_med'
 AUTOR: 		 (admin)
 FECHA:	        07-12-2012 14:20:30
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
	v_ids_loc			varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_localizacion_med_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_LOCMED_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		07-12-2012 14:20:30
	***********************************/

	if(p_transaccion='GM_LOCMED_SEL')then
     				
    	begin
    	
    		--Obtiene todos los id_localizacion
			WITH RECURSIVE t(id,id_fk,nombre,n) AS (
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
					FROM gem.tlocalizacion l 
					WHERE l.id_localizacion = v_parametros.id_localizacion
					UNION ALL
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
					FROM gem.tlocalizacion l, t
					WHERE l.id_localizacion_fk = t.id
				)
			SELECT pxp.list(id::text)
			into v_ids_loc
			FROM t;
    		
    		--Sentencia de la consulta
			v_consulta:='select
						locmed.id_localizacion_med,
						locmed.id_localizacion,
						locmed.id_uni_cons,
						locmed.tiempo_mnp_hrs,
						locmed.estado_reg,
						locmed.tiempo_standby_hrs,
						locmed.num_paros,
						locmed.tiempo_op_hrs,
						locmed.fecha_med,
						locmed.tiempo_mpp_hrs,
						locmed.fecha_reg,
						locmed.id_usuario_reg,
						locmed.id_usuario_mod,
						locmed.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						(unicon.codigo || ''-'' || unicon.nombre)::varchar as desc_uni_cons,
						locmed.observaciones,
						locmed.num_paros_planif	
						from gem.tlocalizacion_med locmed
						inner join segu.tusuario usu1 on usu1.id_usuario = locmed.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = locmed.id_usuario_mod
						left join gem.tuni_cons unicon on unicon.id_uni_cons = locmed.id_uni_cons
				        where locmed.id_localizacion in ('||v_ids_loc||') and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
	
    /*********************************    
 	#TRANSACCION:  'GM_LOCMED_REP'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			Gonzalo Sarmiento Sejas	
 	#FECHA:			04-01-2013
	***********************************/

	elsif(p_transaccion='GM_LOCMED_REP')then
     				
    	begin
    	
    		--Obtiene todos los id_localizacion
			WITH RECURSIVE t(id,id_fk,nombre,n) AS (
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
					FROM gem.tlocalizacion l 
					WHERE l.id_localizacion = v_parametros.id_localizacion
					UNION ALL
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
					FROM gem.tlocalizacion l, t
					WHERE l.id_localizacion_fk = t.id
				)
			SELECT pxp.list(id::text)
			into v_ids_loc
			FROM t;
    		
    		--Sentencia de la consulta
			v_consulta:='select                    
                        loc.nombre as nombre_sistema,
                        locpad.nombre as nombre_localizacion,
                        loc.codigo,
						locmed.tiempo_mnp_hrs,
						locmed.estado_reg,
						locmed.tiempo_standby_hrs,
						locmed.num_paros,
						locmed.tiempo_op_hrs,
						to_char(locmed.fecha_med,''Month'')as mes_literal,
                        to_char(locmed.fecha_med,''mm'')as mes,
						to_char(locmed.fecha_med,''YY'')as anio,
						replace(to_char(locmed.fecha_med,''dd-Month-YYYY''),'' '','''') as fecha_med,
						locmed.tiempo_mpp_hrs,
						to_char(locmed.fecha_reg,''dd-mm-YYYY'') as fecha_reg,
						to_char(locmed.fecha_mod,''dd-mm-YYYY'') as fecha_mod,
						locmed.num_paros_planif,
                        to_char(locmed.fecha_med,''dd-mm-YYYY'') as fecha_med_real
						from gem.tlocalizacion_med locmed
                        inner join gem.tlocalizacion loc on loc.id_localizacion = locmed.id_localizacion
                        inner join gem.tlocalizacion locpad on locpad.id_localizacion = loc.id_localizacion_fk
				        where locmed.id_localizacion in ('||v_ids_loc||') and 
                        locmed.fecha_med between '''||v_parametros.fecha_ini||''' and '''||v_parametros.fecha_fin||''' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
    /*********************************    
 	#TRANSACCION:  'GM_LOCMED_REP_ANUAL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			Gonzalo Sarmiento Sejas	
 	#FECHA:			09-01-2013
	***********************************/

	elsif(p_transaccion='GM_LOCMED_REP_ANUAL')then
     				
    	begin
    	
    		--Obtiene todos los id_localizacion
			WITH RECURSIVE t(id,id_fk,nombre,n) AS (
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
					FROM gem.tlocalizacion l 
					WHERE l.id_localizacion = v_parametros.id_localizacion
					UNION ALL
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
					FROM gem.tlocalizacion l, t
					WHERE l.id_localizacion_fk = t.id
				)
			SELECT pxp.list(id::text)
			into v_ids_loc
			FROM t;
    		
    		--Sentencia de la consulta
			v_consulta:='select                    
                        (sum(locmed.num_paros))::varchar as num_paros,
						(sum(locmed.tiempo_op_hrs))::varchar as tiempo_op_hrs,                        
						(sum(locmed.tiempo_standby_hrs))::varchar as tiempo_standby_hrs,                        
						(sum(locmed.tiempo_mnp_hrs))::varchar as tiempo_mnp_hrs,                        
						(sum(locmed.tiempo_mpp_hrs))::varchar as tiempo_mpp_hrs,
                        (date_part(''month'',locmed.fecha_med))::varchar as mes,
                        (count(locmed.id_localizacion_med))::varchar as dias,
						loc.nombre as nombre_sistema,
                        locpad.nombre as nombre_localizacion,
                        loc.codigo,
                        (sum(locmed.num_paros_planif))::varchar as num_paros_planif						
						from gem.tlocalizacion_med locmed
                        inner join gem.tlocalizacion loc on loc.id_localizacion = locmed.id_localizacion
                        inner join gem.tlocalizacion locpad on locpad.id_localizacion = loc.id_localizacion_fk
				        where locmed.id_localizacion in ('||v_ids_loc||') and 
                        locmed.fecha_med between '''||v_parametros.fecha_ini||''' and '''||v_parametros.fecha_fin||'''
                        group by date_part(''month'',locmed.fecha_med), loc.codigo,nombre_sistema,nombre_localizacion, loc.codigo ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||' order by (date_part(''month'',locmed.fecha_med)) ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
raise notice '%', v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
    
	/*********************************    
 	#TRANSACCION:  'GM_LOCMED_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		07-12-2012 14:20:30
	***********************************/

	elsif(p_transaccion='GM_LOCMED_CONT')then

		begin
			--Obtiene todos los id_localizacion
			WITH RECURSIVE t(id,id_fk,nombre,n) AS (
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
					FROM gem.tlocalizacion l 
					WHERE l.id_localizacion = v_parametros.id_localizacion
					UNION ALL
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
					FROM gem.tlocalizacion l, t
					WHERE l.id_localizacion_fk = t.id
				)
			SELECT pxp.list(id::text)
			into v_ids_loc
			FROM t;
			
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_localizacion_med)
					    from gem.tlocalizacion_med locmed
					    inner join segu.tusuario usu1 on usu1.id_usuario = locmed.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = locmed.id_usuario_mod
						left join gem.tuni_cons unicon on unicon.id_uni_cons = locmed.id_uni_cons
					    where locmed.id_localizacion in ('||v_ids_loc||') and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	
	/*********************************    
 	#TRANSACCION:  'GM_INDICA_SEL'
 	#DESCRIPCION:	Devuelve los indicadores
 	#AUTOR:		rcm	
 	#FECHA:		16-12-2012
	***********************************/

	elsif(p_transaccion='GM_INDICA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						nombre, indicador, observaciones
						from gem.f_formulas_indicadores('||
						v_parametros.id_localizacion||','||
						v_parametros.num_dias||','''||
						v_parametros.fecha_ini||''','||
						v_parametros.fecha_fin||''')
						as (nombre varchar,indicador numeric,observaciones varchar)';
			
			--Devuelve la respuesta
			return v_consulta;
						
		end;
		
	/*********************************    
 	#TRANSACCION:  'GM_INDICA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rcm	
 	#FECHA:		16-12-2012
	***********************************/

	elsif(p_transaccion='GM_INDICA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select
						count(nombre)
						from gem.f_formulas_indicadores('||
						v_parametros.id_localizacion||','||
						v_parametros.num_dias||','''||
						v_parametros.fecha_ini||''','||
						v_parametros.fecha_fin||''')
						as (nombre varchar,indicador numeric,observaciones varchar)';
						
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