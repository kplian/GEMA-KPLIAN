CREATE OR REPLACE FUNCTION "gem"."f_falla_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_falla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tfalla'
 AUTOR: 		 (rac)
 FECHA:	        21-08-2012 20:44:06
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
	v_id_falla	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_falla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_FAL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		21-08-2012 20:44:06
	***********************************/

	if(p_transaccion='GEM_FAL_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tfalla(
			estado_reg,
			obs,
			nombre,
			codigo,
			id_tipo_equipo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.obs,
			v_parametros.nombre,
			v_parametros.codigo,
			v_parametros.id_tipo_equipo,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_falla into v_id_falla;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Falla almacenado(a) con exito (id_falla'||v_id_falla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_falla',v_id_falla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_FAL_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		21-08-2012 20:44:06
	***********************************/

	elsif(p_transaccion='GEM_FAL_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tfalla set
			obs = v_parametros.obs,
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			id_tipo_equipo = v_parametros.id_tipo_equipo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_falla=v_parametros.id_falla;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Falla modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_falla',v_parametros.id_falla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_FAL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		21-08-2012 20:44:06
	***********************************/

	elsif(p_transaccion='GEM_FAL_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tfalla
            where id_falla=v_parametros.id_falla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Falla eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_falla',v_parametros.id_falla::varchar);
              
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
ALTER FUNCTION "gem"."f_falla_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
