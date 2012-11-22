--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_actividad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_actividad_sel
 DESCRIPCION:   Transacciones de retorno de datos para la tabla Actividad
 AUTOR: 		aao
 FECHA:	        19-11-2012 11:52:00
 COMENTARIOS:	
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_actividad_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_ACTI_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		aao
 	#FECHA:		19-11-2012 11:53:00
	***********************************/

	if(p_transaccion='GEM_ACTI_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
                    acti.id_actividad,
                    acti.id_usuario_reg,
                    usu1.cuenta as usr_reg,
                    acti.id_usuario_mod,
                    usu2.cuenta as usr_mod,
                    acti.fecha_reg,
                    acti.fecha_mod,
                    acti.estado_reg,
                    acti.id_orden_trabajo,
                    ot.descripcion as orden_trabajo,
                    acti.id_usuario_resp,
                    (pres.nombre || '' '' || pres.apellido_paterno)::varchar as usuario_resp,
                    acti.estado,
                    acti.descripcion,
                    acti.observaciones,
                    acti.fecha_plan_ini,
                    acti.fecha_plan_fin,
                    acti.fecha_eje_ini,
                    acti.fecha_eje_fin
                    from gem.tactividad acti
                    inner join segu.tusuario usu1 on usu1.id_usuario = acti.id_usuario_reg
                    left join segu.tusuario usu2 on usu2.id_usuario = acti.id_usuario_mod
                    inner join gem.torden_trabajo ot on ot.id_orden_trabajo = acti.id_orden_trabajo
                    left join segu.tusuario ures on ures.id_usuario = acti.id_usuario_resp
                    left join segu.tpersona pres on ures.id_persona = pres.id_persona
			    where acti.id_orden_trabajo = ' || v_parametros.id_orden_trabajo || ' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_ACTI_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		aao	
 	#FECHA:		19-11-2012 11:53:00
	***********************************/

	elsif(p_transaccion='GEM_ACTI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select
                    count(acti.id_actividad)
                    from gem.tactividad acti
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