CREATE OR REPLACE FUNCTION "gem"."ft_funcion_falla_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_funcion_falla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tfuncion_falla'
 AUTOR: 		 (admin)
 FECHA:	        30-09-2012 21:41:13
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
	v_id_funcion_falla	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_funcion_falla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEFALL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:41:13
	***********************************/

	if(p_transaccion='GEM_GEFALL_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tfuncion_falla(
			id_funcion,
			id_falla_evento,
			modo_falla,
			orden,
			efecto_falla,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_funcion,
			v_parametros.id_falla_evento,
			v_parametros.modo_falla,
			v_parametros.orden,
			v_parametros.efecto_falla,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_funcion_falla into v_id_funcion_falla;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Fallas almacenado(a) con exito (id_funcion_falla'||v_id_funcion_falla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcion_falla',v_id_funcion_falla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEFALL_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:41:13
	***********************************/

	elsif(p_transaccion='GEM_GEFALL_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tfuncion_falla set
			id_funcion = v_parametros.id_funcion,
			id_falla_evento = v_parametros.id_falla_evento,
			modo_falla = v_parametros.modo_falla,
			orden = v_parametros.orden,
			efecto_falla = v_parametros.efecto_falla,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_funcion_falla=v_parametros.id_funcion_falla;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Fallas modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcion_falla',v_parametros.id_funcion_falla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEFALL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:41:13
	***********************************/

	elsif(p_transaccion='GEM_GEFALL_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tfuncion_falla
            where id_funcion_falla=v_parametros.id_funcion_falla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Fallas eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcion_falla',v_parametros.id_funcion_falla::varchar);
              
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
ALTER FUNCTION "gem"."ft_funcion_falla_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
