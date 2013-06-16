CREATE OR REPLACE FUNCTION gem.ft_orden_trabajo_sol_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_orden_trabajo_sol_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.torden_trabajo_sol'
 AUTOR: 		 (admin)
 FECHA:	        02-01-2013 15:59:36
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
	v_tipo				varchar;
	v_perfil			varchar;
	v_cond				varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_orden_trabajo_sol_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_SOLORD_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		02-01-2013 15:59:36
	***********************************/

	if(p_transaccion='GM_SOLORD_SEL')then
     				
    	begin
    	
    		--Verifica permisos
    		v_cond='';
    		if p_administrador!=1 then
    			--Obtención del perfil
    			v_perfil = gem.f_get_perfil_usuario(p_id_usuario);
    			if v_perfil = 'Operador' then
    				v_cond = ' and solord.id_usuario_reg = ' ||p_id_usuario;
    			else
    				v_cond = ' and ' || p_id_usuario||' = ANY (unicon.id_usuarios) ';
    			end if;
    		end if;
    	
    		--Sentencia de la consulta
			v_consulta:='select
						solord.id_orden_trabajo_sol,
						solord.id_solicitante,
						solord.id_uni_cons,
						solord.id_responsable,
						solord.id_unidad_medida_req,
						solord.id_uo,
						solord.id_localizacion,
						solord.id_orden_trabajo,
						solord.inspeccion_lugar,
						solord.fecha_estimada,
						solord.estado,
						solord.nota,
						solord.descripcion,
						solord.descripcion_req,
						solord.fecha_requerida,
						solord.estado_reg,
						solord.inspeccion_exacto,
						solord.cantidad_req,
						solord.importancia,
						solord.fecha_real,
						solord.observaciones_resp,
						solord.fecha_recepcion,
						solord.observacion,
						solord.prioridad,
						solord.fecha,
						solord.id_usuario_reg,
						solord.fecha_reg,
						solord.id_usuario_mod,
						solord.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						funsol.desc_funcionario1 as desc_solicitante,
						locali.codigo || '' - '' || locali.nombre as desc_localizacion,
						unicon.codigo || '' - '' || unicon.nombre as desc_equipo,
						funres.desc_funcionario1 as desc_responsable,
						unimed.descripcion as desc_unidad_medida,
						uniorg.codigo || '' - '' || uniorg.nombre_unidad as desc_uo,
						solord.nro_sol,
						--solord.archivo,
						solord.extension 
						from gem.torden_trabajo_sol solord
						inner join segu.tusuario usu1 on usu1.id_usuario = solord.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = solord.id_usuario_mod
						inner join orga.vfuncionario funsol on funsol.id_funcionario = solord.id_solicitante
						inner join gem.tlocalizacion locali on locali.id_localizacion = solord.id_localizacion
						inner join gem.tuni_cons unicon on unicon.id_uni_cons = solord.id_uni_cons
						left join orga.vfuncionario funres on funres.id_funcionario = solord.id_responsable
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = solord.id_unidad_medida_req
						left join orga.tuo uniorg on uniorg.id_uo = solord.id_uo
				        where ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			
			if v_cond != '' then
				v_consulta = v_consulta || v_cond;
			end if;
			
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_SOLORD_REP'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		    Gonzalo Sarmiento	
 	#FECHA:			15-01-2013
	***********************************/

	elsif(p_transaccion='GM_SOLORD_REP')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						solord.id_orden_trabajo_sol,
						solord.id_solicitante,
						solord.id_uni_cons,
						solord.id_responsable,
						solord.id_unidad_medida_req,
						solord.id_uo,
						solord.id_localizacion,
						solord.id_orden_trabajo,
						solord.inspeccion_lugar,
						solord.fecha_estimada,
						solord.estado,
						solord.nota,
						solord.descripcion,
						solord.descripcion_req,
						solord.fecha_requerida,
						solord.estado_reg,
						solord.inspeccion_exacto,
						solord.cantidad_req,
						solord.importancia,
						solord.fecha_real,
						solord.observaciones_resp,
						solord.fecha_recepcion,
						solord.observacion,
						solord.prioridad,
						solord.fecha,
						solord.id_usuario_reg,
						solord.fecha_reg,
						solord.id_usuario_mod,
						solord.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						funsol.desc_funcionario1 as desc_solicitante,
						locali.codigo || '' - '' || locali.nombre as desc_localizacion,
						unicon.codigo || '' - '' || unicon.nombre as desc_equipo,
						funres.desc_funcionario1 as desc_responsable,
						unimed.descripcion as desc_unidad_medida,
						uniorg.codigo as codigo_uo,
                        uniorg.nombre_unidad as nombre_uo,
                        uniorg.nombre_cargo as nombre_cargo,
                        solord.nro_sol,
                        (select nombre_cargo from orga.tuo where id_uo = orga.f_obtener_uo_x_funcionario(solord.id_solicitante,''funcionario'',now()::date)) as cargo_solicitante,
                        (select nombre_cargo from orga.tuo where id_uo = orga.f_obtener_uo_x_funcionario(solord.id_responsable,''funcionario'',now()::date)) as cargo_responsable
						from gem.torden_trabajo_sol solord
						inner join segu.tusuario usu1 on usu1.id_usuario = solord.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = solord.id_usuario_mod
						inner join orga.vfuncionario funsol on funsol.id_funcionario = solord.id_solicitante
						inner join gem.tlocalizacion locali on locali.id_localizacion = solord.id_localizacion
						inner join gem.tuni_cons unicon on unicon.id_uni_cons = solord.id_uni_cons
						left join orga.vfuncionario funres on funres.id_funcionario = solord.id_responsable
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = solord.id_unidad_medida_req
						left join orga.tuo uniorg on uniorg.id_uo = solord.id_uo
				        where solord.id_orden_trabajo_sol='||v_parametros.id_orden_trabajo_sol||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
	/*********************************    
 	#TRANSACCION:  'GM_SOLORD_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		02-01-2013 15:59:36
	***********************************/

	elsif(p_transaccion='GM_SOLORD_CONT')then

		begin
			--Verifica permisos
    		v_cond='';
    		if p_administrador!=1 then
    			--Obtención del perfil
    			v_perfil = gem.f_get_perfil_usuario(p_id_usuario);
    			if v_perfil = 'Operador' then
    				v_cond = ' and solord.id_usuario_reg = ' ||p_id_usuario;
    			else
    				v_cond = ' and ' || p_id_usuario||' = ANY (unicon.id_usuarios) ';
    			end if;
    		end if;
    		
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_orden_trabajo_sol)
					    from gem.torden_trabajo_sol solord
					    inner join segu.tusuario usu1 on usu1.id_usuario = solord.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = solord.id_usuario_mod
						inner join orga.vfuncionario funsol on funsol.id_funcionario = solord.id_solicitante
						inner join gem.tlocalizacion locali on locali.id_localizacion = solord.id_localizacion
						inner join gem.tuni_cons unicon on unicon.id_uni_cons = solord.id_uni_cons
						left join orga.vfuncionario funres on funres.id_funcionario = solord.id_responsable
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = solord.id_unidad_medida_req
						left join orga.tuo uniorg on uniorg.id_uo = solord.id_uo
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
		
	/*********************************    
  #TRANSACCION:  'GM_OTSOAR_REP'
  #DESCRIPCION: Consulta de datos
  #AUTOR:       RCM
  #FECHA:     28/05/2013
  ***********************************/

  elsif(p_transaccion='GM_OTSOAR_REP')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
            solord.id_orden_trabajo_sol,
            solord.archivo,
            solord.extension 
            from gem.torden_trabajo_sol solord
            where solord.id_orden_trabajo_sol='||v_parametros.id_orden_trabajo_sol||' and ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

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