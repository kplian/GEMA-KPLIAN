-- Function: gem.ft_equipo_medicion_sel(integer, integer, character varying, character varying)

-- DROP FUNCTION gem.ft_equipo_medicion_sel(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION gem.ft_equipo_medicion_sel(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_equipo_medicion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tequipo_medicion'
 AUTOR: 		 (admin)
 FECHA:	        27-09-2012 03:02:35
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

	v_nombre_funcion = 'gem.ft_equipo_medicion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	if(p_transaccion='GEM_GEMEDI_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gemedi.id_equipo_medicion,
						gemedi.id_equipo_variable,
						gemedi.observaciones,
						gemedi.estado_reg,
						gemedi.fecha_medicion,
						gemedi.medicion,
						gemedi.id_usuario_reg,
						gemedi.fecha_reg,
						gemedi.id_usuario_mod,
						gemedi.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						geeqva.valor_max,
						geeqva.valor_min,
						getiva.nombre as nombre_tipo_variable,
						getiva.descripcion as desc_tipo_variable,
						paunme.codigo as desc_unidad_medida,
						geeqva.id_uni_cons,
						geunco.codigo as cod_equipo,
						geunco.nombre as desc_equipo
						from gem.tequipo_medicion gemedi
						inner join segu.tusuario usu1 on usu1.id_usuario = gemedi.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gemedi.id_usuario_mod
						inner join gem.tequipo_variable geeqva on geeqva.id_equipo_variable = gemedi.id_equipo_variable
						inner join gem.ttipo_variable getiva on getiva.id_tipo_variable = geeqva.id_tipo_variable
						inner join param.tunidad_medida paunme on paunme.id_unidad_medida = getiva.id_unidad_medida
						inner join gem.tuni_cons geunco on geunco.id_uni_cons = geeqva.id_uni_cons
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	elsif(p_transaccion='GEM_GEMEDI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_equipo_medicion)
					    from gem.tequipo_medicion gemedi
					    inner join segu.tusuario usu1 on usu1.id_usuario = gemedi.id_usuario_reg
					    left join segu.tusuario usu2 on usu2.id_usuario = gemedi.id_usuario_mod
					    inner join gem.tequipo_variable geeqva on geeqva.id_equipo_variable = gemedi.id_equipo_variable
						inner join gem.ttipo_variable getiva on getiva.id_tipo_variable = geeqva.id_tipo_variable
						inner join param.tunidad_medida paunme on paunme.id_unidad_medida = getiva.id_unidad_medida
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MEDGRA_SEL'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rcm	
 	#FECHA:		28-09-2012 22:09
	***********************************/

	elsif(p_transaccion='GEM_MEDGRA_SEL')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select
					equmed.id_equipo_medicion,equvar.id_uni_cons, equipo.codigo, equipo.nombre, tipvar.nombre as var_nombre, tipvar.descripcion as var_desc,
					unimed.codigo as cod_unimed, unimed.descripcion as unimed_desc, equmed.fecha_medicion, equmed.medicion
					from gem.tequipo_medicion equmed
					inner join gem.tequipo_variable equvar on equvar.id_equipo_variable = equmed.id_equipo_variable
					inner join gem.ttipo_variable tipvar on tipvar.id_tipo_variable = equvar.id_tipo_variable
					inner join param.tunidad_medida unimed on unimed.id_unidad_medida = tipvar.id_unidad_medida
					inner join gem.tuni_cons equipo on equipo.id_uni_cons = equvar.id_uni_cons
					where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MEDGRA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rcm	
 	#FECHA:		22/09/2012 22:09
	***********************************/

	elsif(p_transaccion='GEM_MEDGRA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_equipo_medicion)
					from gem.tequipo_medicion equmed
					inner join gem.tequipo_variable equvar on equvar.id_equipo_variable = equmed.id_equipo_variable
					inner join gem.ttipo_variable tipvar on tipvar.id_tipo_variable = equvar.id_tipo_variable
					inner join param.tunidad_medida unimed on unimed.id_unidad_medida = tipvar.id_unidad_medida
					inner join gem.tuni_cons equipo on equipo.id_uni_cons = equvar.id_uni_cons
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
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gem.ft_equipo_medicion_sel(integer, integer, character varying, character varying) OWNER TO postgres;
