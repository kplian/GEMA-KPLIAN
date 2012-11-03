CREATE OR REPLACE FUNCTION "gem"."ft_diagrama_decision_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_diagrama_decision_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tdiagrama_decision'
 AUTOR: 		 (admin)
 FECHA:	        02-10-2012 01:25:12
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

	v_nombre_funcion = 'gem.ft_diagrama_decision_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIDE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		02-10-2012 01:25:12
	***********************************/

	if(p_transaccion='GEM_GEDIDE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gedide.id_diagrama_decision,
						gedide.id_metodologia,
						gedide.codigo,
						gedide.nombre,
						gedide.fecha_desde_validez,
						gedide.estado_reg,
						gedide.fecha_reg,
						gedide.id_usuario_reg,
						gedide.fecha_mod,
						gedide.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						metodo.nombre as desc_metodologia	
						from gem.tdiagrama_decision gedide
						inner join segu.tusuario usu1 on usu1.id_usuario = gedide.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gedide.id_usuario_mod
						inner join gem.tmetodologia metodo on metodo.id_metodologia = gedide.id_metodologia
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIDE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		02-10-2012 01:25:12
	***********************************/

	elsif(p_transaccion='GEM_GEDIDE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_diagrama_decision)
					    from gem.tdiagrama_decision gedide
					    inner join segu.tusuario usu1 on usu1.id_usuario = gedide.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gedide.id_usuario_mod
						inner join gem.tmetodologia metodo on metodo.id_metodologia = gedide.id_metodologia
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
ALTER FUNCTION "gem"."ft_diagrama_decision_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
