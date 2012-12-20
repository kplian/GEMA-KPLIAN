CREATE OR REPLACE FUNCTION "kge"."ft_issue_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Kplian Gestión
 FUNCION: 		kge.ft_issue_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'kge.tissue'
 AUTOR: 		 (admin)
 FECHA:	        10-12-2012 19:16:36
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

	v_nombre_funcion = 'kge.ft_issue_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'KG_ISSUE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		10-12-2012 19:16:36
	***********************************/

	if(p_transaccion='KG_ISSUE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						issue.id_issue,
						issue.titulo,
						issue.creador,
						issue.descripcion,
						issue.nro_issue,
						issue.milestone,
						issue.developer,
						issue.fecha_cierre,
						issue.labels,
						issue.fecha_act,
						issue.estado_reg,
						issue.estado,
						issue.id_usuario_reg,
						issue.fecha_reg,
						issue.fecha_mod,
						issue.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						issue.tiempo_hrs,
						issue.semana,
						issue.prioridad	
						from kge.tissue issue
						inner join segu.tusuario usu1 on usu1.id_usuario = issue.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = issue.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'KG_ISSUE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		10-12-2012 19:16:36
	***********************************/

	elsif(p_transaccion='KG_ISSUE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_issue)
					    from kge.tissue issue
					    inner join segu.tusuario usu1 on usu1.id_usuario = issue.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = issue.id_usuario_mod
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
ALTER FUNCTION "kge"."ft_issue_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
