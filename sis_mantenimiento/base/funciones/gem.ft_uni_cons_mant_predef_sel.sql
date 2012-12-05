CREATE OR REPLACE FUNCTION "gem"."ft_uni_cons_mant_predef_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_uni_cons_mant_predef_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tuni_cons_mant_predef'
 AUTOR: 		 (admin)
 FECHA:	        12-10-2012 23:35:54
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

	v_nombre_funcion = 'gem.ft_uni_cons_mant_predef_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEEQMA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		12-10-2012 23:35:54
	***********************************/

	if(p_transaccion='GEM_GEEQMA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						geeqma.id_uni_cons_mant_predef,
						geeqma.id_mant_predef,
						geeqma.id_uni_cons,
						geeqma.id_unidad_medida,
						geeqma.frecuencia,
						geeqma.ult_fecha_mant,
						geeqma.fecha_ini,
						geeqma.estado_reg,
						geeqma.fecha_reg,
						geeqma.id_usuario_reg,
						geeqma.id_usuario_mod,
						geeqma.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						gemapr.codigo || '' - '' || gemapr.nombre as desc_mant_predef,
						paunme.codigo || '' - '' || paunme.descripcion as desc_unidad_medida,
						geeqma.id_unidad_medida_estimado,
						geeqma.tiempo_estimado,
						unimed.descripcion as desc_unidad_medida_estimado
						from gem.tuni_cons_mant_predef geeqma
						inner join segu.tusuario usu1 on usu1.id_usuario = geeqma.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geeqma.id_usuario_mod
						inner join gem.tmant_predef gemapr on gemapr.id_mant_predef = geeqma.id_mant_predef
						inner join param.tunidad_medida paunme on paunme.id_unidad_medida = geeqma.id_unidad_medida
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = geeqma.id_unidad_medida_estimado
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEEQMA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		12-10-2012 23:35:54
	***********************************/

	elsif(p_transaccion='GEM_GEEQMA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_uni_cons_mant_predef)
					    from gem.tuni_cons_mant_predef geeqma
					    inner join segu.tusuario usu1 on usu1.id_usuario = geeqma.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geeqma.id_usuario_mod
						inner join gem.tmant_predef gemapr on gemapr.id_mant_predef = geeqma.id_mant_predef
						inner join param.tunidad_medida paunme on paunme.id_unidad_medida = geeqma.id_unidad_medida
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = geeqma.id_unidad_medida_estimado
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
ALTER FUNCTION "gem"."ft_uni_cons_mant_predef_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
