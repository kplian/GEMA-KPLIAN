CREATE OR REPLACE FUNCTION "gem"."ft_analisis_mant_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_analisis_mant_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tanalisis_mant'
 AUTOR: 		 (admin)
 FECHA:	        30-09-2012 21:44:06
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

	v_nombre_funcion = 'gem.ft_analisis_mant_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEANMA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:44:06
	***********************************/

	if(p_transaccion='GEM_GEANMA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						geanma.id_analisis_mant,
						geanma.id_uni_cons,
						geanma.id_tipo_mant,
						geanma.id_funcionario_rev,
						geanma.estado_reg,
						geanma.fecha_emision,
						geanma.descripcion,
						geanma.fecha_rev,
						geanma.id_usuario_reg,
						geanma.fecha_reg,
						geanma.id_usuario_mod,
						geanma.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						getima.nombre as desc_tipo_mant,
						fun.desc_funcionario1 as desc_person	
						from gem.tanalisis_mant geanma
						inner join segu.tusuario usu1 on usu1.id_usuario = geanma.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geanma.id_usuario_mod
						inner join gem.ttipo_mant getima on getima.id_tipo_mant = geanma.id_tipo_mant
						inner join orga.vfuncionario fun on fun.id_funcionario = geanma.id_funcionario_rev
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEANMA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:44:06
	***********************************/

	elsif(p_transaccion='GEM_GEANMA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_analisis_mant)
					    from gem.tanalisis_mant geanma
					    inner join segu.tusuario usu1 on usu1.id_usuario = geanma.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geanma.id_usuario_mod
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
ALTER FUNCTION "gem"."ft_analisis_mant_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
