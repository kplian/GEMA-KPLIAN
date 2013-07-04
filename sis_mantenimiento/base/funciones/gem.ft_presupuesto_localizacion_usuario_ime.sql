CREATE OR REPLACE FUNCTION "gem"."ft_presupuesto_localizacion_usuario_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_presupuesto_localizacion_usuario_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tpresupuesto_localizacion_usuario'
 AUTOR: 		 (admin)
 FECHA:	        02-07-2013 04:45:06
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
	v_id_presupuesto_localizacion_usuario	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_presupuesto_localizacion_usuario_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_GPREUS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-07-2013 04:45:06
	***********************************/

	if(p_transaccion='GM_GPREUS_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tpresupuesto_localizacion_usuario(
			estado_reg,
			id_presupuesto_localizacion,
			id_usuario,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_presupuesto_localizacion,
			v_parametros.id_usuario,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_presupuesto_localizacion_usuario into v_id_presupuesto_localizacion_usuario;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización Usuario almacenado(a) con exito (id_presupuesto_localizacion_usuario'||v_id_presupuesto_localizacion_usuario||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_localizacion_usuario',v_id_presupuesto_localizacion_usuario::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_GPREUS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-07-2013 04:45:06
	***********************************/

	elsif(p_transaccion='GM_GPREUS_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tpresupuesto_localizacion_usuario set
			id_presupuesto_localizacion = v_parametros.id_presupuesto_localizacion,
			id_usuario = v_parametros.id_usuario,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_presupuesto_localizacion_usuario=v_parametros.id_presupuesto_localizacion_usuario;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización Usuario modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_localizacion_usuario',v_parametros.id_presupuesto_localizacion_usuario::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_GPREUS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-07-2013 04:45:06
	***********************************/

	elsif(p_transaccion='GM_GPREUS_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tpresupuesto_localizacion_usuario
            where id_presupuesto_localizacion_usuario=v_parametros.id_presupuesto_localizacion_usuario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización Usuario eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_localizacion_usuario',v_parametros.id_presupuesto_localizacion_usuario::varchar);
              
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
ALTER FUNCTION "gem"."ft_presupuesto_localizacion_usuario_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
