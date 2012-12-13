CREATE OR REPLACE FUNCTION "gem"."ft_localizacion_med_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_localizacion_med_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tlocalizacion_med'
 AUTOR: 		 (admin)
 FECHA:	        07-12-2012 14:20:30
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
	v_id_localizacion_med	integer;
	v_tot					numeric;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_localizacion_med_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_LOCMED_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-12-2012 14:20:30
	***********************************/

	if(p_transaccion='GM_LOCMED_INS')then
					
        begin
        
        	--Verifica que no haya más de una medición para una localizacion en una misma fecha
        	if exists(select 1 from gem.tlocalizacion_med
        			where fecha_med = v_parametros.fecha_med
        			and id_localizacion = v_parametros.id_localizacion) then
        		raise exception 'Ya se registró anteriormente la medición para esta fecha';
        	end if;
        
        	--Verifica que se esté registrando al menos un valor
        	v_tot = coalesce(v_parametros.tiempo_op_hrs,0) + coalesce(v_parametros.tiempo_standby_hrs,0) + coalesce(v_parametros.tiempo_mnp_hrs,0) + coalesce(v_parametros.tiempo_mpp_hrs,0);
        	if (v_tot) = 0 then
        		raise exception 'Debe registrarse al menos una de las columnas de medición.';
        	end if; 
        	
        	--Verifica que las horas totales no sobrepasen las 24 horas
        	if(v_tot > 24) then
        		raise exception 'El total de las horas del día no puede ser mayor a 24 horas.';
        	end if;
        
        	--Sentencia de la insercion
        	insert into gem.tlocalizacion_med(
			id_localizacion,
			id_uni_cons,
			tiempo_mnp_hrs,
			estado_reg,
			tiempo_standby_hrs,
			num_paros,
			tiempo_op_hrs,
			fecha_med,
			tiempo_mpp_hrs,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_localizacion,
			v_parametros.id_uni_cons,
			v_parametros.tiempo_mnp_hrs,
			'activo',
			v_parametros.tiempo_standby_hrs,
			v_parametros.num_paros,
			v_parametros.tiempo_op_hrs,
			v_parametros.fecha_med,
			v_parametros.tiempo_mpp_hrs,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_localizacion_med into v_id_localizacion_med;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones almacenado(a) con exito (id_localizacion_med'||v_id_localizacion_med||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_localizacion_med',v_id_localizacion_med::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_LOCMED_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-12-2012 14:20:30
	***********************************/

	elsif(p_transaccion='GM_LOCMED_MOD')then

		begin
		
			--Verifica que no haya más de una medición para una localizacion en una misma fecha
        	if exists(select 1 from gem.tlocalizacion_med
        			where fecha_med = v_parametros.fecha_med
        			and id_localizacion = v_parametros.id_localizacion
        			and id_localizacion_med <> v_parametros.id_localizacion_med) then
        		raise exception 'Ya se registró anteriormente la medición para esta fecha';
        	end if;
        
        	--Verifica que se esté registrando al menos un valor
        	v_tot = coalesce(v_parametros.tiempo_op_hrs,0) + coalesce(v_parametros.tiempo_standby_hrs,0) + coalesce(v_parametros.tiempo_mnp_hrs,0) + coalesce(v_parametros.tiempo_mpp_hrs,0);
        	if (v_tot) = 0 then
        		raise exception 'Debe registrarse al menos una de las columnas de medición.';
        	end if; 
        	
        	--Verifica que las horas totales no sobrepasen las 24 horas
        	if(v_tot > 24) then
        		raise exception 'El total de las horas del día no puede ser mayor a 24 horas.';
        	end if;
			
			--Sentencia de la modificacion
			update gem.tlocalizacion_med set
			id_localizacion = v_parametros.id_localizacion,
			id_uni_cons = v_parametros.id_uni_cons,
			tiempo_mnp_hrs = v_parametros.tiempo_mnp_hrs,
			tiempo_standby_hrs = v_parametros.tiempo_standby_hrs,
			num_paros = v_parametros.num_paros,
			tiempo_op_hrs = v_parametros.tiempo_op_hrs,
			fecha_med = v_parametros.fecha_med,
			tiempo_mpp_hrs = v_parametros.tiempo_mpp_hrs,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_localizacion_med=v_parametros.id_localizacion_med;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_localizacion_med',v_parametros.id_localizacion_med::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_LOCMED_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-12-2012 14:20:30
	***********************************/

	elsif(p_transaccion='GM_LOCMED_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tlocalizacion_med
            where id_localizacion_med=v_parametros.id_localizacion_med;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_localizacion_med',v_parametros.id_localizacion_med::varchar);
              
            --Devuelve la respuesta
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
ALTER FUNCTION "gem"."ft_localizacion_med_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
