CREATE OR REPLACE FUNCTION gem.ft_modo_falla_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_modo_falla_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tmodo_falla'
 AUTOR: 		 (rac)
 FECHA:	        18-10-2012 04:54:08
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

	v_nombre_funcion = 'gem.ft_modo_falla_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_MODFALLA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		18-10-2012 04:54:08
	***********************************/

	if(p_transaccion='GEM_MODFALLA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						modfalla.id_modo_falla,
						modfalla.id_funcion_falla,
						modfalla.modo_falla,
						modfalla.efecto_falla,
						modfalla.orden,
						modfalla.estado_reg,
						modfalla.fecha_reg,
						modfalla.id_usuario_reg,
						modfalla.fecha_mod,
						modfalla.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tmodo_falla modfalla
						inner join segu.tusuario usu1 on usu1.id_usuario = modfalla.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = modfalla.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MODFALLA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		18-10-2012 04:54:08
	***********************************/

	elsif(p_transaccion='GEM_MODFALLA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_modo_falla)
					    from gem.tmodo_falla modfalla
					    inner join segu.tusuario usu1 on usu1.id_usuario = modfalla.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = modfalla.id_usuario_mod
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;