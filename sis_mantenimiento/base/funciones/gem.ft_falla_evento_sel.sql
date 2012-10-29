CREATE OR REPLACE FUNCTION "gem"."ft_falla_evento_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_falla_evento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tfalla_evento'
 AUTOR: 		 (admin)
 FECHA:	        30-09-2012 21:41:31
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

	v_nombre_funcion = 'gem.ft_falla_evento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEFAEV_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:41:31
	***********************************/

	if(p_transaccion='GEM_GEFAEV_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gefaev.id_falla_evento,
						gefaev.id_tipo_equipo,
						gefaev.tipo,
						gefaev.estado_reg,
						gefaev.nombre,
						gefaev.codigo,
						gefaev.fecha_reg,
						gefaev.id_usuario_reg,
						gefaev.id_usuario_mod,
						gefaev.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tfalla_evento gefaev
						inner join segu.tusuario usu1 on usu1.id_usuario = gefaev.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gefaev.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEFAEV_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:41:31
	***********************************/

	elsif(p_transaccion='GEM_GEFAEV_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_falla_evento)
					    from gem.tfalla_evento gefaev
					    inner join segu.tusuario usu1 on usu1.id_usuario = gefaev.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gefaev.id_usuario_mod
					    where ';
			
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
ALTER FUNCTION "gem"."ft_falla_evento_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
