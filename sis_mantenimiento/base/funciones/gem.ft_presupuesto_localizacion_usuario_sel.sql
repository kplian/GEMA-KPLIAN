CREATE OR REPLACE FUNCTION "gem"."ft_presupuesto_localizacion_usuario_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_presupuesto_localizacion_usuario_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tpresupuesto_localizacion_usuario'
 AUTOR: 		 (admin)
 FECHA:	        02-07-2013 04:45:06
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

	v_nombre_funcion = 'gem.ft_presupuesto_localizacion_usuario_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_GPREUS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		02-07-2013 04:45:06
	***********************************/

	if(p_transaccion='GM_GPREUS_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gpreus.id_presupuesto_localizacion_usuario,
						gpreus.estado_reg,
						gpreus.id_presupuesto_localizacion,
						gpreus.id_usuario,
						gpreus.id_usuario_reg,
						gpreus.fecha_reg,
						gpreus.id_usuario_mod,
						gpreus.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						usu3.desc_persona	
						from gem.tpresupuesto_localizacion_usuario gpreus
						inner join segu.tusuario usu1 on usu1.id_usuario = gpreus.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gpreus.id_usuario_mod
						inner join segu.vusuario usu3 on usu3.id_usuario = gpreus.id_usuario
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_GPREUS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		02-07-2013 04:45:06
	***********************************/

	elsif(p_transaccion='GM_GPREUS_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_presupuesto_localizacion_usuario)
					    from gem.tpresupuesto_localizacion_usuario gpreus
					    inner join segu.tusuario usu1 on usu1.id_usuario = gpreus.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gpreus.id_usuario_mod
						inner join segu.vusuario usu3 on usu3.id_usuario = gpreus.id_usuario
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
ALTER FUNCTION "gem"."ft_presupuesto_localizacion_usuario_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
