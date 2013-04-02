CREATE OR REPLACE FUNCTION "gem"."ft_tipo_equipo_col_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_tipo_equipo_col_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.ttipo_equipo_col'
 AUTOR: 		 (admin)
 FECHA:	        19-03-2013 11:20:37
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

	v_nombre_funcion = 'gem.ft_tipo_equipo_col_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_TEQCOL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 11:20:37
	***********************************/

	if(p_transaccion='GM_TEQCOL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						teqcol.id_tipo_equipo_col,
						teqcol.estado_reg,
						teqcol.id,
						teqcol.id_tipo_equipo,
						teqcol.tipo_col,
						teqcol.id_usuario_reg,
						teqcol.fecha_reg,
						teqcol.id_usuario_mod,
						teqcol.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						teqcol.orden,
						case teqcol.tipo_col
						 when ''Variables'' then (select nombre from gem.ttipo_variable where id_tipo_variable = teqcol.id::integer)
						 else teqcol.id
						end as desc_id	
						from gem.ttipo_equipo_col teqcol
						inner join segu.tusuario usu1 on usu1.id_usuario = teqcol.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = teqcol.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_TEQCOL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 11:20:37
	***********************************/

	elsif(p_transaccion='GM_TEQCOL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_equipo_col)
					    from gem.ttipo_equipo_col teqcol
					    inner join segu.tusuario usu1 on usu1.id_usuario = teqcol.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = teqcol.id_usuario_mod
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
ALTER FUNCTION "gem"."ft_tipo_equipo_col_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
