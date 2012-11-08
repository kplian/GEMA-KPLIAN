CREATE OR REPLACE FUNCTION gem.ft_plan_mant_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_plan_mant_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tplan_mant'
 AUTOR: 		 (rac)
 FECHA:	        12-10-2012 16:15:31
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

	v_nombre_funcion = 'gem.ft_plan_mant_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_PLAMA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		12-10-2012 16:15:31
	***********************************/

	if(p_transaccion='GEM_PLAMA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						plama.id_plan_mant,
						plama.id_funcionario,
                        vper.nombre_completo1 as nombre_funcionario,
						plama.id_funcionario_rev,
                        vperev.nombre_completo1 as nombre_funcionario_rev,
						plama.id_tipo_mant,
						plama.id_uni_cons,
						plama.descripcion,                       
						plama.fecha,
						plama.estado_reg,
						plama.id_usuario_reg,
						plama.fecha_reg,
						plama.fecha_mod,
						plama.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tplan_mant plama
						inner join segu.tusuario usu1 on usu1.id_usuario = plama.id_usuario_reg
                        inner join orga.tfuncionario fun on fun.id_funcionario=plama.id_funcionario
                        inner join segu.vpersona vper on vper.id_persona=fun.id_persona
                        inner join orga.tfuncionario funrev on funrev.id_funcionario=plama.id_funcionario_rev                          
                        inner join segu.vpersona vperev on vperev.id_persona=funrev.id_persona
						left join segu.tusuario usu2 on usu2.id_usuario = plama.id_usuario_mod
				        where  plama.id_uni_cons='||v_parametros.id_uni_cons||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_PLAMA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		12-10-2012 16:15:31
	***********************************/

	elsif(p_transaccion='GEM_PLAMA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_plan_mant)
					    from gem.tplan_mant plama
					    inner join segu.tusuario usu1 on usu1.id_usuario = plama.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = plama.id_usuario_mod
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