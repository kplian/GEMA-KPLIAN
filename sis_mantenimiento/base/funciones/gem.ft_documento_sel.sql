CREATE OR REPLACE FUNCTION gem.ft_documento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_documento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tdocumento'
 AUTOR: 		 (admin)
 FECHA:	        28-08-2012 22:24:50
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

	v_nombre_funcion = 'gem.ft_documento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEDOCU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 22:24:50
	***********************************/

	if(p_transaccion='GEM_GEDOCU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gedocu.id_documento,
						gedocu.nombre,
						gedocu.codigo,
						gedocu.resumen,
						gedocu.nombre_archivo,
						gedocu.extension,
                        gedocu.archivo,
						gedocu.palabras_clave,
                        gedocu.tipo,
						gedocu.estado_reg,                        
						gedocu.id_documento_padre,
						gedocu.fecha_reg,
						gedocu.id_usuario_reg,
						gedocu.fecha_mod,
						gedocu.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tdocumento gedocu
						inner join segu.tusuario usu1 on usu1.id_usuario = gedocu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gedocu.id_usuario_mod
				        where gedocu.id_documento_padre is NULL and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
    elsif(p_transaccion='GEM_GEDOCUVER_SEL')then
    	begin
        	v_consulta:='select
						gedocu.id_documento,
						gedocu.nombre,
						gedocu.codigo,
						gedocu.resumen,
						gedocu.nombre_archivo,
						gedocu.extension,
                        gedocu.archivo,
						gedocu.palabras_clave,
                        gedocu.tipo,
						gedocu.estado_reg,                        
						gedocu.id_documento_padre,
						gedocu.fecha_reg,
						gedocu.id_usuario_reg,
						gedocu.fecha_mod,
						gedocu.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tdocumento gedocu
						inner join segu.tusuario usu1 on usu1.id_usuario = gedocu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gedocu.id_usuario_mod
				        where gedocu.id_documento_padre='||v_parametros.id_documento|| ' and ';
                        
            --Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
        end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDOCU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 22:24:50
	***********************************/

	elsif(p_transaccion='GEM_GEDOCU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_documento)
					    from gem.tdocumento gedocu
					    inner join segu.tusuario usu1 on usu1.id_usuario = gedocu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gedocu.id_usuario_mod
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