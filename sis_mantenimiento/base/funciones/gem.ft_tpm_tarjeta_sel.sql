CREATE OR REPLACE FUNCTION gem.ft_tpm_tarjeta_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_tpm_tarjeta_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.ttpm_tarjeta'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        29-11-2012 02:21:39
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

	v_nombre_funcion = 'gem.ft_tpm_tarjeta_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_TARTPM_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		29-11-2012 02:21:39
	***********************************/

	if(p_transaccion='GM_TARTPM_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tartpm.id_tpm_tarjeta,
						tartpm.id_localizacion,
						tartpm.estado_reg,
						tartpm.fecha_emision,
						tartpm.tipo,
						tartpm.revision,
						tartpm.codigo,
						tartpm.fecha_reg,
						tartpm.id_usuario_reg,
						tartpm.id_usuario_mod,
						tartpm.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.ttpm_tarjeta tartpm
						inner join segu.tusuario usu1 on usu1.id_usuario = tartpm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tartpm.id_usuario_mod
				        where tartpm.id_localizacion='||v_parametros.id_localizacion||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
    /*********************************    
 	#TRANSACCION:  'GM_TARTPM_REP'
 	#DESCRIPCION:	Consulta de datos para el reporte
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		04-12-2012 02:21:39
	***********************************/

	elsif(p_transaccion='GM_TARTPM_REP')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tartpm.id_tpm_tarjeta,
						tartpm.id_localizacion,
                        loc.nombre as localizacion,
						tartpm.estado_reg,
						tartpm.fecha_emision,
						tartpm.tipo,
						tartpm.revision,
						tartpm.codigo,
						to_char(tartpm.fecha_reg, ''dd/MM/YYYY'') as fecha_reg,
						tartpm.id_usuario_reg,
                        tartpm.id_usuario_mod,
						to_char(tartpm.fecha_mod,''dd/MM/YYYY'') as fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.ttpm_tarjeta tartpm
						inner join segu.tusuario usu1 on usu1.id_usuario = tartpm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tartpm.id_usuario_mod
                        left join gem.tlocalizacion loc on loc.id_localizacion = tartpm.id_localizacion
				        where tartpm.id_tpm_tarjeta='||v_parametros.id_tpm_tarjeta||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_TARTPM_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		29-11-2012 02:21:39
	***********************************/

	elsif(p_transaccion='GM_TARTPM_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tpm_tarjeta)
					    from gem.ttpm_tarjeta tartpm
					    inner join segu.tusuario usu1 on usu1.id_usuario = tartpm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tartpm.id_usuario_mod
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