CREATE OR REPLACE FUNCTION gem.ft_uni_cons_archivo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_uni_cons_archivo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tuni_cons_archivo'
 AUTOR: 		 (rac)
 FECHA:	        26-10-2012 18:08:27
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

	v_nombre_funcion = 'gem.ft_uni_cons_archivo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_UNIDOC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		26-10-2012 18:08:27
	***********************************/

	if(p_transaccion='GEM_UNIDOC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						unidoc.id_uni_cons_archivo,
						unidoc.id_uni_cons_archivo_padre,
						unidoc.extension,
						unidoc.resumen,
						unidoc.palabras_clave,
						unidoc.estado_reg,
						unidoc.codigo,
						unidoc.nombre,
						unidoc.archivo,
						unidoc.nombre_archivo,
						unidoc.fecha_reg,
						unidoc.id_usuario_reg,
						unidoc.id_usuario_mod,
						unidoc.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tuni_cons_archivo unidoc
						inner join segu.tusuario usu1 on usu1.id_usuario = unidoc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = unidoc.id_usuario_mod
				        where unidoc.id_uni_cons_archivo_padre is NULL and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
	/*********************************    
 	#TRANSACCION:  'GEM_ARCHVER_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		26-10-2012 18:08:27
	***********************************/
    elseif(p_transaccion='GEM_ARCHVER_SEL')then
    	begin
        	v_consulta:='select
						unidoc.id_uni_cons_archivo,
						unidoc.id_uni_cons_archivo_padre,
						unidoc.extension,
						unidoc.resumen,
						unidoc.palabras_clave,
						unidoc.estado_reg,
						unidoc.codigo,
						unidoc.nombre,
						unidoc.archivo,
						unidoc.nombre_archivo,
						unidoc.fecha_reg,
						unidoc.id_usuario_reg,
						unidoc.id_usuario_mod,
						unidoc.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tuni_cons_archivo unidoc
						inner join segu.tusuario usu1 on usu1.id_usuario = unidoc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = unidoc.id_usuario_mod
				        where unidoc.id_uni_cons_archivo_padre='||v_parametros.id_uni_cons_archivo||' and ';

            v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
        end;

	/*********************************    
 	#TRANSACCION:  'GEM_UNIDOC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		26-10-2012 18:08:27
	***********************************/

	elsif(p_transaccion='GEM_UNIDOC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_uni_cons_archivo)
					    from gem.tuni_cons_archivo unidoc
					    inner join segu.tusuario usu1 on usu1.id_usuario = unidoc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = unidoc.id_usuario_mod
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