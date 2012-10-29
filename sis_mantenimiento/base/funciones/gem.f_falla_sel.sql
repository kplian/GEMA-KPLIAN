CREATE OR REPLACE FUNCTION gem.f_falla_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_falla_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tfalla'
 AUTOR: 		 (rac)
 FECHA:	        21-08-2012 20:44:06
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

	v_nombre_funcion = 'gem.f_falla_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_FAL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		21-08-2012 20:44:06
	***********************************/

	if(p_transaccion='GEM_FAL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						fal.id_falla,
						fal.estado_reg,
						fal.obs,
						fal.nombre,
						fal.codigo,
						fal.id_tipo_equipo,
						fal.id_usuario_reg,
						fal.fecha_reg,
						fal.id_usuario_mod,
						fal.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tfalla fal
						inner join segu.tusuario usu1 on usu1.id_usuario = fal.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = fal.id_usuario_mod
				        where fal.estado_reg = ''activo''  AND fal.id_tipo_equipo ='|| v_parametros.id_tipo_equipo||' AND ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_FAL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		21-08-2012 20:44:06
	***********************************/

	elsif(p_transaccion='GEM_FAL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_falla)
					    from gem.tfalla fal
					    inner join segu.tusuario usu1 on usu1.id_usuario = fal.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = fal.id_usuario_mod
					    where  fal.estado_reg = ''activo''  AND fal.id_tipo_equipo ='|| v_parametros.id_tipo_equipo||' AND ';
			
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;