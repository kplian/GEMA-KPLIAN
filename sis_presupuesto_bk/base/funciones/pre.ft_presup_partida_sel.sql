CREATE OR REPLACE FUNCTION pre.ft_presup_partida_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de presupuesto
 FUNCION: 		pre.ft_presup_partida_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'pre.tpresup_partida'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        26-11-2012 22:02:47
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

	v_nombre_funcion = 'pre.ft_presup_partida_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PRE_PREPAR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-11-2012 22:02:47
	***********************************/

	if(p_transaccion='PRE_PREPAR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						prepar.id_presup_partida,
						prepar.estado_reg,
						prepar.tipo,
						prepar.id_centro_costo,
                        cen.codigo as centro_codigo,
						prepar.id_presupuesto,
						prepar.id_partida,
                        par.codigo as partida_codigo,
						prepar.fecha_hora,
						prepar.id_moneda,
                        mon.moneda,
						prepar.importe,
						prepar.fecha_reg,
						prepar.id_usuario_reg,
						prepar.fecha_mod,
						prepar.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from pre.tpresup_partida prepar
						inner join segu.tusuario usu1 on usu1.id_usuario = prepar.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = prepar.id_usuario_mod
                        left join gem.tcentro_costo cen on cen.id_centro_costo = prepar.id_centro_costo
                        inner join pre.tpartida par on par.id_partida = prepar.id_partida	
                        inner join param.tmoneda mon on mon.id_moneda = prepar.id_moneda
				        where prepar.id_presupuesto='||v_parametros.id_presupuesto||
                        ' and prepar.tipo='''||v_parametros.tipo||''' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PRE_PREPAR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-11-2012 22:02:47
	***********************************/

	elsif(p_transaccion='PRE_PREPAR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_presup_partida)
					    from pre.tpresup_partida prepar
					    inner join segu.tusuario usu1 on usu1.id_usuario = prepar.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = prepar.id_usuario_mod
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