CREATE OR REPLACE FUNCTION "gem"."f_orden_trabajo_sol_insumo_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.f_orden_trabajo_sol_insumo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.torden_trabajo_sol_insumo'
 AUTOR: 		 (admin)
 FECHA:	        17-02-2013 07:39:55
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

	v_nombre_funcion = 'gem.f_orden_trabajo_sol_insumo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_OTSOIN_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-02-2013 07:39:55
	***********************************/

	if(p_transaccion='GM_OTSOIN_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						otsoin.id_orden_trabajo_sol_insumo,
						otsoin.id_orden_trabajo_sol,
						otsoin.id_unidad_medida,
						otsoin.descripcion,
						otsoin.cant_insum,
						otsoin.estado_reg,
						otsoin.fecha_reg,
						otsoin.id_usuario_reg,
						otsoin.fecha_mod,
						otsoin.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						umed.descripcion as unidad_medida	
						from gem.torden_trabajo_sol_insumo otsoin
						inner join segu.tusuario usu1 on usu1.id_usuario = otsoin.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = otsoin.id_usuario_mod
						inner join param.tunidad_medida umed
						on umed.id_unidad_medida = otsoin.id_unidad_medida
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_OTSOIN_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2013 07:39:55
	***********************************/

	elsif(p_transaccion='GM_OTSOIN_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_orden_trabajo_sol_insumo)
					    from gem.torden_trabajo_sol_insumo otsoin
					    inner join segu.tusuario usu1 on usu1.id_usuario = otsoin.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = otsoin.id_usuario_mod
						inner join param.tunidad_medida umed
						on umed.id_unidad_medida = otsoin.id_unidad_medida
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
ALTER FUNCTION "gem"."f_orden_trabajo_sol_insumo_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
