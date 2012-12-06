CREATE OR REPLACE FUNCTION "gem"."ft_mant_predef_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_mant_predef_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tmant_predef'
 AUTOR: 		 (admin)
 FECHA:	        28-08-2012 20:25:32
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
			    
BEGIN

	v_nombre_funcion = 'gem.ft_mant_predef_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEMAPR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 20:25:32
	***********************************/

	if(p_transaccion='GEM_GEMAPR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gemapr.id_mant_predef,
						gemapr.codigo,
						gemapr.descripcion,
						gemapr.nombre,
						gemapr.estado_reg,
						gemapr.id_usuario_reg,
						gemapr.fecha_reg,
						gemapr.fecha_mod,
						gemapr.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						gemapr.id_tipo_equipo,
						getieq.nombre as desc_tipo_equipo,
						gemapr.id_unidad_medida_estimado,
						gemapr.tiempo_estimado,
						unimed.descripcion as desc_unidad_medida_estimado	
						from gem.tmant_predef gemapr
						inner join segu.tusuario usu1 on usu1.id_usuario = gemapr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gemapr.id_usuario_mod
						inner join gem.ttipo_equipo getieq on getieq.id_tipo_equipo = gemapr.id_tipo_equipo
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = gemapr.id_unidad_medida_estimado
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMAPR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 20:25:32
	***********************************/

	elsif(p_transaccion='GEM_GEMAPR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_mant_predef)
					    from gem.tmant_predef gemapr
					    inner join segu.tusuario usu1 on usu1.id_usuario = gemapr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gemapr.id_usuario_mod
						inner join gem.ttipo_equipo getieq on getieq.id_tipo_equipo = gemapr.id_tipo_equipo
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = gemapr.id_unidad_medida_estimado
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	/*********************************    
 	#TRANSACCION:  'GEM_GEMPUC_SEL'
 	#DESCRIPCION:	Consulta de datos para obtener los mant. predef en función del id_tipo_equipo a partir de id_uni_cons
 	#AUTOR:		rcm	
 	#FECHA:		06-12-2012
	***********************************/

	elsif(p_transaccion='GEM_GEMPUC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gemapr.id_mant_predef,
						gemapr.codigo,
						gemapr.descripcion,
						gemapr.nombre,
						gemapr.estado_reg,
						gemapr.id_usuario_reg,
						gemapr.fecha_reg,
						gemapr.fecha_mod,
						gemapr.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						gemapr.id_tipo_equipo,
						getieq.nombre as desc_tipo_equipo,
						gemapr.id_unidad_medida_estimado,
						gemapr.tiempo_estimado,
						unimed.descripcion as desc_unidad_medida_estimado	
						from gem.tmant_predef gemapr
						inner join segu.tusuario usu1 on usu1.id_usuario = gemapr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gemapr.id_usuario_mod
						inner join gem.ttipo_equipo getieq on getieq.id_tipo_equipo = gemapr.id_tipo_equipo
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = gemapr.id_unidad_medida_estimado
				        where gemapr.id_tipo_equipo in (select id_tipo_equipo
				        								from gem.tuni_cons
				        								where id_uni_cons = ' || v_parametros.id_uni_cons || ') and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
		
	/*********************************    
 	#TRANSACCION:  'GEM_GEMPUC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rcm	
 	#FECHA:		06-12-2012
	***********************************/

	elsif(p_transaccion='GEM_GEMPUC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_mant_predef)
					    from gem.tmant_predef gemapr
					    inner join segu.tusuario usu1 on usu1.id_usuario = gemapr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gemapr.id_usuario_mod
						inner join gem.ttipo_equipo getieq on getieq.id_tipo_equipo = gemapr.id_tipo_equipo
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = gemapr.id_unidad_medida_estimado
					    where gemapr.id_tipo_equipo in (select id_tipo_equipo
				        								from gem.tuni_cons
				        								where id_uni_cons = ' || v_parametros.id_uni_cons || ') and ';
			
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "gem"."ft_mant_predef_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
