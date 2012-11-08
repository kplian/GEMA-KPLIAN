CREATE OR REPLACE FUNCTION gem.ft_tarea_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_tarea_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.ttarea'
 AUTOR: 		 (rac)
 FECHA:	        17-10-2012 18:28:03
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

	v_nombre_funcion = 'gem.ft_tarea_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_TARE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		17-10-2012 18:28:03
	***********************************/

	if(p_transaccion='GEM_TARE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
            			tare.id_tarea,
						tare.id_plan_mant,
						tare.id_uni_cons,
						tare.id_uni_cons_hijo,
                        unicons.nombre as nombre_uni_cons_hijo,
						tare.id_modo_falla,
                        mod.modo_falla,
						tare.id_unidad_medida,
                        uni.codigo,
						tare.tareas,
						tare.col_hson3,
						tare.col_h4,
						tare.col_h,
						tare.id_falla_evento,
                        fal.nombre as nombre_evento,
						tare.col_h5,
						tare.col_n,
						tare.col_hson2,
						tare.estado_reg,
						tare.frecuencia,
						tare.id_especialidad,
                        esp.nombre as nombre_especialidad,
						tare.col_o,
						tare.col_s,
						tare.col_s4,
						tare.col_hson1,
						tare.fecha_reg,
						tare.id_usuario_reg,
						tare.fecha_mod,
						tare.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.ttarea tare
						inner join segu.tusuario usu1 on usu1.id_usuario = tare.id_usuario_reg
                        inner join gem.tmodo_falla mod on mod.id_modo_falla=tare.id_modo_falla
                        left join gem.tuni_cons unicons on unicons.id_uni_cons=tare.id_uni_cons_hijo
                        left join gem.tfalla_evento fal on fal.id_falla_evento=tare.id_falla_evento
                        left join orga.tespecialidad esp on esp.id_especialidad=tare.id_especialidad
                        inner join param.tunidad_medida uni on uni.id_unidad_medida=tare.id_unidad_medida
						left join segu.tusuario usu2 on usu2.id_usuario = tare.id_usuario_mod
				        where id_plan_mant='||v_parametros.id_plan_mant||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TARE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		17-10-2012 18:28:03
	***********************************/

	elsif(p_transaccion='GEM_TARE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tarea)
					    from gem.ttarea tare
					    inner join segu.tusuario usu1 on usu1.id_usuario = tare.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tare.id_usuario_mod
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