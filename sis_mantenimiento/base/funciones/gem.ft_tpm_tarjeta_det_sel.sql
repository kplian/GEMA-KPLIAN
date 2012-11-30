CREATE OR REPLACE FUNCTION gem.ft_tpm_tarjeta_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_tpm_tarjeta_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.ttpm_tarjeta_det'
 AUTOR: 		Gonzalo Sarmiento Sejas 
 FECHA:	        29-11-2012 14:51:50
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

	v_nombre_funcion = 'gem.ft_tpm_tarjeta_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_TARDET_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas 	
 	#FECHA:		29-11-2012 14:51:50
	***********************************/

	if(p_transaccion='GM_TARDET_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tardet.id_tpm_tarjeta_det,
						tardet.id_tpm_tarjeta,
						tardet.id_funcionario_detec,
                        fundet.desc_funcionario1 as desc_fun_detec,
						tardet.id_funcionario_efec,
                        funefe.desc_funcionario1 as desc_fun_efec,
						tardet.id_uni_cons,
                        (uni.nombre||''-[''||uni.codigo||'']'')::varchar as desc_uni_cons,
						tardet.observaciones,
						tardet.falla_el,
						tardet.fecha_retiro,
						tardet.contaminacion,
						tardet.oportunidad_mejora,
						tardet.falla_ist,
						tardet.descripcion,
						tardet.acceso_dificil,
						tardet.falla_ne,
						tardet.falla_me,
						tardet.fecha_coloc,
						tardet.estado_reg,
						tardet.cond_inseg,
						tardet.falla_hi,
						tardet.id_usuario_reg,
						tardet.fecha_reg,
						tardet.fecha_mod,
						tardet.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.ttpm_tarjeta_det tardet
						inner join segu.tusuario usu1 on usu1.id_usuario = tardet.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tardet.id_usuario_mod
                        left join orga.vfuncionario fundet on fundet.id_funcionario=tardet.id_funcionario_detec
                        left join orga.vfuncionario funefe on funefe.id_funcionario=tardet.id_funcionario_efec
                        left join gem.tuni_cons uni on uni.id_uni_cons=tardet.id_uni_cons
				        where tardet.id_tpm_tarjeta='||v_parametros.id_tpm_tarjeta||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_TARDET_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas 	
 	#FECHA:		29-11-2012 14:51:50
	***********************************/

	elsif(p_transaccion='GM_TARDET_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tpm_tarjeta_det)
					    from gem.ttpm_tarjeta_det tardet
					    inner join segu.tusuario usu1 on usu1.id_usuario = tardet.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tardet.id_usuario_mod
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