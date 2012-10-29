CREATE OR REPLACE FUNCTION "gem"."ft_mant_predef_det_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_mant_predef_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tmant_predef_det'
 AUTOR: 		 (admin)
 FECHA:	        28-08-2012 21:15:37
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
	v_id_mant_predef_det	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_mant_predef_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEDETM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 21:15:37
	***********************************/

	if(p_transaccion='GEM_GEDETM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tmant_predef_det(
			nombre,
			descripcion,
			id_mant_predef,
			observacion,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre,
			v_parametros.descripcion,
			v_parametros.id_mant_predef,
			v_parametros.observacion,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_mant_predef_det into v_id_mant_predef_det;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Mantenimiento Predefinido almacenado(a) con exito (id_mant_predef_det'||v_id_mant_predef_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef_det',v_id_mant_predef_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDETM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 21:15:37
	***********************************/

	elsif(p_transaccion='GEM_GEDETM_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tmant_predef_det set
			nombre = v_parametros.nombre,
			descripcion = v_parametros.descripcion,
			id_mant_predef = v_parametros.id_mant_predef,
			observacion = v_parametros.observacion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_mant_predef_det=v_parametros.id_mant_predef_det;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Detalle Mantenimiento Predefinido modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_mant_predef_det',v_parametros.id_mant_predef_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDETM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 21:15:37
	***********************************/

	elsif(p_transaccion='GEM_GEDETM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tmant_predef_det
            where id_mant_predef_det=v_parametros.id_mant_predef_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Mantenimiento Predefinido eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef_det',v_parametros.id_mant_predef_det::varchar);
              
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
ALTER FUNCTION "gem"."ft_mant_predef_det_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
