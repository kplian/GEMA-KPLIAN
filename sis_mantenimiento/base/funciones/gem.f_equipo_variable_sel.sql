--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_equipo_variable_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_equipo_variable_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tequipo_variable'
 AUTOR: 		 (rac)
 FECHA:	        15-08-2012 17:09:17
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

	v_nombre_funcion = 'gem.f_equipo_variable_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_EQV_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 17:09:17
	***********************************/

	if(p_transaccion='GEM_EQV_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						eqv.id_equipo_variable,
						eqv.estado_reg,
						eqv.valor_max,
						eqv.id_uni_cons,
						eqv.obs,
						eqv.valor_min,
						eqv.id_tipo_variable,
						eqv.id_usuario_reg,
						eqv.fecha_reg,
						eqv.id_usuario_mod,
						eqv.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	,
                        tva.nombre as nombre_tipo_variable,
                        um.codigo as codigo_unidad_medida,
                        um.id_unidad_medida,
                        eqv.id_equipo_variable as key,
                        eqv.tipo
						from gem.tequipo_variable eqv
						inner join gem.ttipo_variable tva on tva.id_tipo_variable = eqv.id_tipo_variable
                        inner join segu.tusuario usu1 on usu1.id_usuario = eqv.id_usuario_reg
                        inner join param.tunidad_medida um on  um.id_unidad_medida = tva.id_unidad_medida
						left join segu.tusuario usu2 on usu2.id_usuario = eqv.id_usuario_mod
				        where  eqv.estado_reg = ''activo''  AND eqv.id_uni_cons ='|| v_parametros.id_uni_cons||' AND ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_EQV_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 17:09:17
	***********************************/

	elsif(p_transaccion='GEM_EQV_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_equipo_variable)
					    from gem.tequipo_variable eqv
					   	inner join gem.ttipo_variable tva on tva.id_tipo_variable = eqv.id_tipo_variable
                        inner join segu.tusuario usu1 on usu1.id_usuario = eqv.id_usuario_reg
                        inner join param.tunidad_medida um on  um.id_unidad_medida = tva.id_unidad_medida
						left join segu.tusuario usu2 on usu2.id_usuario = eqv.id_usuario_mod
				         where  eqv.estado_reg = ''activo''  AND eqv.id_uni_cons ='|| v_parametros.id_uni_cons||' AND ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_EQUVAR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rcm	
 	#FECHA:		26/09/2012
	***********************************/

	elsif(p_transaccion='GEM_EQUVAR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
					geeqva.id_equipo_variable, geeqva.valor_max, geeqva.valor_min,
					getiva.codigo, getiva.descripcion, paunme.codigo as desc_un_med
					from gem.tequipo_variable geeqva
					inner join gem.ttipo_variable getiva on getiva.id_tipo_variable = geeqva.id_tipo_variable
					inner join param.tunidad_medida paunme on paunme.id_unidad_medida = getiva.id_unidad_medida
					where ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_EQUVAR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rcm	
 	#FECHA:		26/09/2012
	***********************************/

	elsif(p_transaccion='GEM_EQUVAR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select
					count(geeqva.id_equipo_variable)
					from gem.tequipo_variable geeqva
					inner join gem.ttipo_variable getiva on getiva.id_tipo_variable = geeqva.id_tipo_variable
					inner join param.tunidad_medida paunme on paunme.id_unidad_medida = getiva.id_unidad_medida
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