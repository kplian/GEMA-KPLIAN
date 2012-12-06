CREATE OR REPLACE FUNCTION gem.ft_analisis_porque_sol_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_analisis_porque_sol_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tanalisis_porque_sol'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        28-11-2012 22:28:33
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

	v_nombre_funcion = 'gem.ft_analisis_porque_sol_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_PORSOL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		28-11-2012 22:28:33
	***********************************/

	if(p_transaccion='GM_PORSOL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						porsol.id_analisis_porque_sol,
						porsol.id_analisis_porque,
						porsol.id_funcionario,
                        fun.desc_funcionario1,
						porsol.estado_reg,
						porsol.estado,
						porsol.fecha,
						porsol.descripcion,
						porsol.id_usuario_reg,
						porsol.fecha_reg,
						porsol.id_usuario_mod,
						porsol.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tanalisis_porque_sol porsol
						inner join segu.tusuario usu1 on usu1.id_usuario = porsol.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = porsol.id_usuario_mod
                        inner join orga.vfuncionario fun on fun.id_funcionario = porsol.id_funcionario
				        where porsol.id_analisis_porque='||v_parametros.id_analisis_porque||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
    /*********************************    
 	#TRANSACCION:  'GM_PORSOL_REP'
 	#DESCRIPCION:	Consulta para reporte de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-12-2012 22:28:33
	***********************************/

	elsif(p_transaccion='GM_PORSOL_REP')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						porsol.id_analisis_porque_sol,
						porsol.id_analisis_porque,
						porsol.id_funcionario,
                        fun.desc_funcionario1,
						porsol.estado,
						to_char(porsol.fecha,''dd/MM/YYYY'')as fecha,
						porsol.descripcion,
						porsol.fecha_reg,
						porsol.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tanalisis_porque_sol porsol
						inner join segu.tusuario usu1 on usu1.id_usuario = porsol.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = porsol.id_usuario_mod
                        inner join orga.vfuncionario fun on fun.id_funcionario = porsol.id_funcionario
				        where porsol.id_analisis_porque='||v_parametros.id_analisis_porque||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;
						
		end;


	/*********************************    
 	#TRANSACCION:  'GM_PORSOL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		28-11-2012 22:28:33
	***********************************/

	elsif(p_transaccion='GM_PORSOL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_analisis_porque_sol)
					    from gem.tanalisis_porque_sol porsol
					    inner join segu.tusuario usu1 on usu1.id_usuario = porsol.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = porsol.id_usuario_mod
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