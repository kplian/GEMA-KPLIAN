CREATE OR REPLACE FUNCTION "gem"."ft_mant_predef_item_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_mant_predef_item_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tmant_predef_item'
 AUTOR: 		 (admin)
 FECHA:	        10-10-2013 23:53:04
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

	v_nombre_funcion = 'gem.ft_mant_predef_item_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_MAPRIT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		10-10-2013 23:53:04
	***********************************/

	if(p_transaccion='GM_MAPRIT_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						maprit.id_mant_predef_item,
						maprit.id_mant_predef,
						maprit.id_item,
						maprit.cantidad_item,
						maprit.estado_reg,
						maprit.id_usuario_reg,
						maprit.fecha_reg,
						maprit.fecha_mod,
						maprit.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						coalesce(itm.codigo,'''') || '' - '' || coalesce(itm.nombre,'''') as desc_item
						from gem.tmant_predef_item maprit
						inner join segu.tusuario usu1 on usu1.id_usuario = maprit.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = maprit.id_usuario_mod
						inner join alm.titem itm on itm.id_item = maprit.id_item
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_MAPRIT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		10-10-2013 23:53:04
	***********************************/

	elsif(p_transaccion='GM_MAPRIT_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_mant_predef_item)
					    from gem.tmant_predef_item maprit
					    inner join segu.tusuario usu1 on usu1.id_usuario = maprit.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = maprit.id_usuario_mod
						inner join alm.titem itm on itm.id_item = maprit.id_item
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
ALTER FUNCTION "gem"."ft_mant_predef_item_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
