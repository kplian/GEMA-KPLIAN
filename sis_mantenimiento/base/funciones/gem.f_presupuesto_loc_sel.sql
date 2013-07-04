CREATE OR REPLACE FUNCTION "gem"."f_presupuesto_loc_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.f_presupuesto_loc_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tpresupuesto_loc'
 AUTOR: 		 (admin)
 FECHA:	        11-06-2013 19:38:04
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

	v_nombre_funcion = 'gem.f_presupuesto_loc_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_GEPRLO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		11-06-2013 19:38:04
	***********************************/

	if(p_transaccion='GM_GEPRLO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						geprlo.id_presupuesto_loc,
						geprlo.id_localizacion,
						geprlo.mes,
						geprlo.id_presupuesto,
						geprlo.monto_ejec,
						geprlo.porcen_prog_techo,
						geprlo.monto_prog,
						geprlo.monto_techo,
						geprlo.monto_presup,
						geprlo.estado_reg,
						geprlo.fecha_reg,
						geprlo.id_usuario_reg,
						geprlo.fecha_mod,
						geprlo.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						loc.nombre as nombre_localizacion,
						gem.f_get_nombre_localizacion_rec(geprlo.id_localizacion,''padres'') as desc_localizacion	
						from gem.tpresupuesto_loc geprlo
						inner join segu.tusuario usu1 on usu1.id_usuario = geprlo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geprlo.id_usuario_mod
						inner join gem.tlocalizacion loc on loc.id_localizacion = geprlo.id_localizacion
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_GEPRLO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		11-06-2013 19:38:04
	***********************************/

	elsif(p_transaccion='GM_GEPRLO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_presupuesto_loc)
					    from gem.tpresupuesto_loc geprlo
					    inner join segu.tusuario usu1 on usu1.id_usuario = geprlo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geprlo.id_usuario_mod
						inner join gem.tlocalizacion loc on loc.id_localizacion = geprlo.id_localizacion
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
		
	/*********************************    
 	#TRANSACCION:  'GM_GEPRLOEX_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			rcm
 	#FECHA:		03/07/2013
	***********************************/

	elsif(p_transaccion='GM_GEPRLOEX_SEL')then
     				
    	begin
    	
    		--Sentencia de la consulta
			v_consulta:='select
						geprlo.id_presupuesto_loc,
						geprlo.id_localizacion,
						geprlo.mes,
						geprlo.id_presupuesto,
						geprlo.monto_ejec,
						geprlo.porcen_prog_techo,
						geprlo.monto_prog,
						geprlo.monto_techo,
						geprlo.monto_presup,
						geprlo.estado_reg,
						geprlo.fecha_reg,
						geprlo.id_usuario_reg,
						geprlo.fecha_mod,
						geprlo.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						loc.nombre as nombre_localizacion,
						gem.f_get_nombre_localizacion_rec(geprlo.id_localizacion,''padres'') as desc_localizacion,
						presu.codigo || '' - '' ||presu.nombre as desc_presupuesto,
						presu.gestion,
						presu.estado_reg as estado_pres
						from gem.tpresupuesto_loc geprlo
						inner join segu.tusuario usu1 on usu1.id_usuario = geprlo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geprlo.id_usuario_mod
						inner join gem.tlocalizacion loc on loc.id_localizacion = geprlo.id_localizacion
						inner join gem.tpresupuesto presu on presu.id_presupuesto = geprlo.id_presupuesto';
				        
			--Verificación de rol de admnistrador del usuario que ejecuta la función
    		if p_administrador <> 1 then
    			v_consulta = v_consulta || ' inner join gem.tpresupuesto_localizacion prelo
											on prelo.id_presupuesto = geprlo.id_presupuesto
											and prelo.id_localizacion = geprlo.id_localizacion
											inner join gem.tpresupuesto_localizacion_usuario prelous
											on prelous.id_presupuesto_localizacion = prelo.id_presupuesto_localizacion
											and prelous.id_usuario = ' || p_id_usuario;
    		
    		end if;
    		
    		v_consulta = v_consulta || ' where presu.estado_reg in (''formular'',''ejecucion'') and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_GEPRLOEX_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:			rcm
 	#FECHA:			03/07/2013
	***********************************/

	elsif(p_transaccion='GM_GEPRLOEX_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_presupuesto_loc)
					    from gem.tpresupuesto_loc geprlo
					    inner join segu.tusuario usu1 on usu1.id_usuario = geprlo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geprlo.id_usuario_mod
						inner join gem.tlocalizacion loc on loc.id_localizacion = geprlo.id_localizacion
						inner join gem.tpresupuesto presu on presu.id_presupuesto = geprlo.id_presupuesto';
					    
			--Verificación de rol de admnistrador del usuario que ejecuta la función
    		if p_administrador <> 1 then
    			v_consulta = v_consulta || ' inner join gem.tpresupuesto_localizacion prelo
											on prelo.id_presupuesto = geprlo.id_presupuesto
											and prelo.id_localizacion = geprlo.id_localizacion
											inner join gem.tpresupuesto_localizacion_usuario prelous
											on prelous.id_presupuesto_localizacion = prelo.id_presupuesto_localizacion
											and prelous.id_usuario = ' || p_id_usuario;
    		
    		end if;
    		
    		v_consulta = v_consulta || ' where presu.estado_reg in (''formular'',''ejecucion'') and ';
			
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
ALTER FUNCTION "gem"."f_presupuesto_loc_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
