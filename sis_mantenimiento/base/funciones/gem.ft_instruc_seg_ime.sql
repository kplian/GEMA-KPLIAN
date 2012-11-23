CREATE OR REPLACE FUNCTION "gem"."ft_instruc_seg_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_instruc_seg_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tinstruc_seg'
 AUTOR: 		 (admin)
 FECHA:	        22-11-2012 15:45:32
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
	v_id_instruc_seg	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_instruc_seg_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_INSEG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-11-2012 15:45:32
	***********************************/

	if(p_transaccion='GM_INSEG_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tinstruc_seg(
			estado_reg,
			descripcion,
			codigo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.descripcion,
			v_parametros.codigo,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_instruc_seg into v_id_instruc_seg;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Instrucciones de seguridad almacenado(a) con exito (id_instruc_seg'||v_id_instruc_seg||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_instruc_seg',v_id_instruc_seg::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_INSEG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-11-2012 15:45:32
	***********************************/

	elsif(p_transaccion='GM_INSEG_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tinstruc_seg set
			descripcion = v_parametros.descripcion,
			codigo = v_parametros.codigo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_instruc_seg=v_parametros.id_instruc_seg;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Instrucciones de seguridad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_instruc_seg',v_parametros.id_instruc_seg::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_INSEG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-11-2012 15:45:32
	***********************************/

	elsif(p_transaccion='GM_INSEG_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tinstruc_seg
            where id_instruc_seg=v_parametros.id_instruc_seg;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Instrucciones de seguridad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_instruc_seg',v_parametros.id_instruc_seg::varchar);
              
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
ALTER FUNCTION "gem"."ft_instruc_seg_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
