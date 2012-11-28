--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_recurso_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_recurso_sel
 DESCRIPCION:   Transacciones de retorno de datos para la tabla Recurso
 AUTOR: 		aao
 FECHA:	        26-11-2012 15:27:00
 COMENTARIOS:	
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_recurso_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_RECACTI_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		aao
 	#FECHA:		26-11-2012 15:28:00
	***********************************/

	if(p_transaccion='GEM_RECACTI_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
                    rec.id_recurso,
                    rec.id_usuario_reg,
                    usu1.cuenta as usr_reg,
                    rec.id_usuario_mod,
                    usu2.cuenta as usr_mod,
                    rec.fecha_reg,
                    rec.fecha_mod,
                    rec.estado_reg,
                    rec.id_actividad,
                    rec.id_item,
                    itm.nombre as nombre_item,
                    rec.id_funcionario,
                    (pers.nombre || '' '' || pers.apellido_paterno)::varchar as nombre_funcionario,
                    rec.id_especialidad,
                    esp.nombre as nombre_especialidad,
                    rec.id_servicio,
                    serv.nombre as nombre_servicio,
                    rec.id_moneda,
                    mon.codigo as codigo_moneda,
                    rec.cantidad,
                    rec.costo,
                    rec.observaciones
                    from gem.trecurso rec
                    inner join segu.tusuario usu1 on usu1.id_usuario = rec.id_usuario_reg
                    left join segu.tusuario usu2 on usu2.id_usuario = rec.id_usuario_mod
                    left join alm.titem itm on rec.id_item = itm.id_item
                    left join orga.tespecialidad esp on rec.id_especialidad = esp.id_especialidad
                    left join param.tservicio serv on rec.id_servicio = serv.id_servicio
                    left join orga.tfuncionario func on rec.id_funcionario = func.id_funcionario
                    left join segu.tpersona pers on func.id_persona = pers.id_persona
                    left join param.tmoneda mon on rec.id_moneda = mon.id_moneda
                    where rec.id_actividad = ' || v_parametros.id_actividad || ' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_RECACTI_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		aao	
 	#FECHA:		26-11-2012 16:41:00
	***********************************/

	elsif(p_transaccion='GEM_RECACTI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(rec.id_recurso)
                    from gem.trecurso rec
                    where rec.id_actividad = ' || v_parametros.id_actividad || ' and ';
			
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