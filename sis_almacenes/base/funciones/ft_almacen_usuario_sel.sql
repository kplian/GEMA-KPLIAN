CREATE OR REPLACE FUNCTION "alm"."ft_almacen_usuario_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_almacen_usuario_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.talmacen_usuario'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        28-11-2012 14:52:50
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

	v_nombre_funcion = 'alm.ft_almacen_usuario_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_ALMUSR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			Gonzalo Sarmiento Sejas
 	#FECHA:		28-11-2012 14:52:50
	***********************************/

	if(p_transaccion='SAL_ALMUSR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						almusr.id_almacen_usuario,
						almusr.id_usuario,
						usualm.cuenta,
						almusr.estado_reg,
						almusr.id_usuario_reg,
						almusr.fecha_reg,
						almusr.fecha_mod,
						almusr.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from alm.talmacen_usuario almusr
						inner join segu.tusuario usu1 on usu1.id_usuario = almusr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = almusr.id_usuario_mod
					    inner join segu.tusuario usualm on usualm.id_usuario = almusr.id_usuario
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMUSR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:			Gonzalo Sarmiento Sejas
 	#FECHA:		28-11-2012 14:52:50
	***********************************/

	elsif(p_transaccion='SAL_ALMUSR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_almacen_usuario)
					    from alm.talmacen_usuario almusr
					    inner join segu.tusuario usu1 on usu1.id_usuario = almusr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = almusr.id_usuario_mod
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
ALTER FUNCTION "alm"."ft_almacen_usuario_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
