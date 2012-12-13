CREATE OR REPLACE FUNCTION "gem"."ft_localizacion_med_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
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
						(unicon.codigo || ''-'' || unicon.nombre)::varchar as desc_uni_cons	
						from gem.tlocalizacion_med locmed
						inner join segu.tusuario usu1 on usu1.id_usuario = locmed.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = locmed.id_usuario_mod
						left join gem.tuni_cons unicon on unicon.id_uni_cons = locmed.id_uni_cons
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

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
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_localizacion_med)
					    from gem.tlocalizacion_med locmed
					    inner join segu.tusuario usu1 on usu1.id_usuario = locmed.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = locmed.id_usuario_mod
						left join gem.tuni_cons unicon on unicon.id_uni_cons = locmed.id_uni_cons
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
ALTER FUNCTION "gem"."ft_localizacion_med_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
