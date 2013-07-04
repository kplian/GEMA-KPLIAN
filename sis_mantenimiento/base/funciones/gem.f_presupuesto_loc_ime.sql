CREATE OR REPLACE FUNCTION "gem"."f_presupuesto_loc_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.f_presupuesto_loc_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tpresupuesto_loc'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_presupuesto_loc	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_presupuesto_loc_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_GEPRLO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		11-06-2013 19:38:04
	***********************************/

	if(p_transaccion='GM_GEPRLO_INS')then
					
        begin
        
        	--Validación de existencia previa del presupuesto
        	if exists(select 1 from gem.tpresupuesto_loc
        			where id_presupuesto = v_parametros.id_presupuesto
        			and mes = v_parametros.mes
        			and id_localizacion = v_parametros.id_localizacion) then
        		raise exception 'Ya se registró el presupuesto para ese Mes y Localización';
        	end if;
        	--Sentencia de la insercion
        	insert into gem.tpresupuesto_loc(
			id_localizacion,
			mes,
			id_presupuesto,
			monto_ejec,
			porcen_prog_techo,
			monto_prog,
			monto_techo,
			monto_presup,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_localizacion,
			v_parametros.mes,
			v_parametros.id_presupuesto,
			v_parametros.monto_ejec,
			v_parametros.porcen_prog_techo,
			v_parametros.monto_prog,
			v_parametros.monto_techo,
			v_parametros.monto_presup,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_presupuesto_loc into v_id_presupuesto_loc;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización almacenado(a) con exito (id_presupuesto_loc'||v_id_presupuesto_loc||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_loc',v_id_presupuesto_loc::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_GEPRLO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		11-06-2013 19:38:04
	***********************************/

	elsif(p_transaccion='GM_GEPRLO_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tpresupuesto_loc set
			id_localizacion = v_parametros.id_localizacion,
			mes = v_parametros.mes,
			id_presupuesto = v_parametros.id_presupuesto,
			monto_ejec = v_parametros.monto_ejec,
			porcen_prog_techo = v_parametros.porcen_prog_techo,
			monto_prog = v_parametros.monto_prog,
			monto_techo = v_parametros.monto_techo,
			monto_presup = v_parametros.monto_presup,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_presupuesto_loc=v_parametros.id_presupuesto_loc;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_loc',v_parametros.id_presupuesto_loc::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_GEPRLO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		11-06-2013 19:38:04
	***********************************/

	elsif(p_transaccion='GM_GEPRLO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tpresupuesto_loc
            where id_presupuesto_loc=v_parametros.id_presupuesto_loc;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_loc',v_parametros.id_presupuesto_loc::varchar);
              
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
ALTER FUNCTION "gem"."f_presupuesto_loc_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
