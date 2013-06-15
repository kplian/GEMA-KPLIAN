CREATE OR REPLACE FUNCTION "gem"."ft_orden_trabajo_sol_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_orden_trabajo_sol_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.torden_trabajo_sol'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_orden_trabajo_sol	integer;
	v_id_uni_cons 			integer;
	v_fecha 				date;
	v_nro					varchar;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_orden_trabajo_sol_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_SOLORD_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-01-2013 15:59:36
	***********************************/

	if(p_transaccion='GM_SOLORD_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.torden_trabajo_sol(
			id_solicitante,
			id_uni_cons,
			id_responsable,
			id_unidad_medida_req,
			id_uo,
			id_localizacion,
			id_orden_trabajo,
			inspeccion_lugar,
			fecha_estimada,
			estado,
			nota,
			descripcion,
			descripcion_req,
			fecha_requerida,
			estado_reg,
			inspeccion_exacto,
			cantidad_req,
			importancia,
			fecha_real,
			observaciones_resp,
			fecha_recepcion,
			observacion,
			prioridad,
			fecha,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_solicitante,
			v_parametros.id_uni_cons,
			v_parametros.id_responsable,
			v_parametros.id_unidad_medida_req,
			v_parametros.id_uo,
			v_parametros.id_localizacion,
			v_parametros.id_orden_trabajo,
			v_parametros.inspeccion_lugar,
			v_parametros.fecha_estimada,
			'borrador',
			v_parametros.nota,
			v_parametros.descripcion,
			v_parametros.descripcion_req,
			v_parametros.fecha_requerida,
			'activo',
			v_parametros.inspeccion_exacto,
			v_parametros.cantidad_req,
			v_parametros.importancia,
			v_parametros.fecha_real,
			v_parametros.observaciones_resp,
			v_parametros.fecha_recepcion,
			v_parametros.observacion,
			v_parametros.prioridad,
			v_parametros.fecha,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_orden_trabajo_sol into v_id_orden_trabajo_sol;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Solicitud de Orden de Trabajo almacenado(a) con exito (id_orden_trabajo_sol'||v_id_orden_trabajo_sol||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo_sol',v_id_orden_trabajo_sol::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_SOLORD_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-01-2013 15:59:36
	***********************************/

	elsif(p_transaccion='GM_SOLORD_MOD')then

		begin
		
			if exists(select 1 from gem.torden_trabajo_sol
						where id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol
						and estado = 'finalizado') then
				raise exception 'Esta solicitud ya fue finalizada';
			end if;
			--Sentencia de la modificacion
			update gem.torden_trabajo_sol set
			id_solicitante = v_parametros.id_solicitante,
			id_uni_cons = v_parametros.id_uni_cons,
			id_responsable = v_parametros.id_responsable,
			id_unidad_medida_req = v_parametros.id_unidad_medida_req,
			id_uo = v_parametros.id_uo,
			id_localizacion = v_parametros.id_localizacion,
			id_orden_trabajo = v_parametros.id_orden_trabajo,
			inspeccion_lugar = v_parametros.inspeccion_lugar,
			fecha_estimada = v_parametros.fecha_estimada,
			estado = v_parametros.estado,
			nota = v_parametros.nota,
			descripcion = v_parametros.descripcion,
			descripcion_req = v_parametros.descripcion_req,
			fecha_requerida = v_parametros.fecha_requerida,
			inspeccion_exacto = v_parametros.inspeccion_exacto,
			cantidad_req = v_parametros.cantidad_req,
			importancia = v_parametros.importancia,
			fecha_real = v_parametros.fecha_real,
			observaciones_resp = v_parametros.observaciones_resp,
			fecha_recepcion = v_parametros.fecha_recepcion,
			observacion = v_parametros.observacion,
			prioridad = v_parametros.prioridad,
			fecha = v_parametros.fecha,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_orden_trabajo_sol=v_parametros.id_orden_trabajo_sol;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Solicitud de Orden de Trabajo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo_sol',v_parametros.id_orden_trabajo_sol::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_SOLORD_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-01-2013 15:59:36
	***********************************/

	elsif(p_transaccion='GM_SOLORD_ELI')then

		begin
			if exists(select 1 from gem.torden_trabajo_sol
						where id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol
						and estado = 'finalizado') then
				raise exception 'Esta solicitud ya fue finalizada';
			end if;
			--Sentencia de la eliminacion
			delete from gem.torden_trabajo_sol
            where id_orden_trabajo_sol=v_parametros.id_orden_trabajo_sol;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Solicitud de Orden de Trabajo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo_sol',v_parametros.id_orden_trabajo_sol::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'GM_SOLFIN_MOD'
 	#DESCRIPCION:	Finalizar solicitud de ot
 	#AUTOR:		rcm
 	#FECHA:		05/01/2012
	***********************************/

	elsif(p_transaccion='GM_SOLFIN_MOD')then

		begin
		
			if not exists(select 1 from gem.torden_trabajo_sol
						where id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol) then
				raise exception 'Solicitud no enviada: no existe el registro';
			end if;
		
			if v_parametros.estado = 'pendiente' then
				if exists(select 1 from gem.torden_trabajo_sol
						where id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol
						and estado != 'borrador') then
					raise exception 'Esta solicitud debe estar en Borrador para ser Finalizada';
				end if;
				select id_uni_cons, fecha
				into v_id_uni_cons, v_fecha
				from gem.torden_trabajo_sol
				where id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol; 
				
				--Obtención del correlativo
				v_nro = gem.f_get_correlativo(v_id_uni_cons,'sol_oit',v_fecha);
				
				update gem.torden_trabajo_sol set
				nro_sol = v_nro
				where id_orden_trabajo_sol=v_parametros.id_orden_trabajo_sol;
				
			elsif v_parametros.estado = 'finalizado' then
				if exists(select 1 from gem.torden_trabajo_sol
						where id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol
						and estado != 'pendiente') then
					raise exception 'Esta solicitud debe estar Pendiente para ser Aprobada';
				end if;
			
			elsif v_parametros.estado = 'no_aprobado' then
				if exists(select 1 from gem.torden_trabajo_sol
						where id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol
						and estado != 'pendiente') then
					raise exception 'Esta solicitud debe estar Pendiente para ser Rechazada';
				end if;
			end if;
		
			--Sentencia de la modificación
			update gem.torden_trabajo_sol set
			estado = v_parametros.estado,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_orden_trabajo_sol=v_parametros.id_orden_trabajo_sol;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Solicitud de Orden de Trabajo en estado '||v_parametros.estado); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo_sol',v_parametros.id_orden_trabajo_sol::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

  /*********************************    
  #TRANSACCION:  'GM_UPLFIL_MOD'
  #DESCRIPCION: Insercion de registros
  #AUTOR:   RCM
  #FECHA:   2013
  ***********************************/		
  elsif(p_transaccion='GEM_UPLFIL_MOD')then
      begin
          update gem.torden_trabajo_sol set
            archivo=v_parametros.archivo,
            extension=v_parametros.extension
            where id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol;
            
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo modificado con exito '||v_parametros.id_orden_trabajo_sol); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo_sol',v_parametros.id_orden_trabajo_sol::varchar);
             
             return v_resp;
        end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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
ALTER FUNCTION "gem"."ft_orden_trabajo_sol_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
