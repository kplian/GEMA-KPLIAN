CREATE OR REPLACE FUNCTION "gem"."ft_instruc_seg_det_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_instruc_seg_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tinstruc_seg_det'
 AUTOR: 		 (admin)
 FECHA:	        13-04-2013 03:01:16
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
	v_id_instruc_seg_det	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_instruc_seg_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_INSEDE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-04-2013 03:01:16
	***********************************/

	if(p_transaccion='GM_INSEDE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tinstruc_seg_det(
			id_instruc_seg,
			descripcion,
			nro,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_instruc_seg,
			v_parametros.descripcion,
			v_parametros.nro,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_instruc_seg_det into v_id_instruc_seg_det;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle de Instrucciones de Seguridad almacenado(a) con exito (id_instruc_seg_det'||v_id_instruc_seg_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_instruc_seg_det',v_id_instruc_seg_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_INSEDE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-04-2013 03:01:16
	***********************************/

	elsif(p_transaccion='GM_INSEDE_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tinstruc_seg_det set
			id_instruc_seg = v_parametros.id_instruc_seg,
			descripcion = v_parametros.descripcion,
			nro = v_parametros.nro,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_instruc_seg_det=v_parametros.id_instruc_seg_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle de Instrucciones de Seguridad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_instruc_seg_det',v_parametros.id_instruc_seg_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_INSEDE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-04-2013 03:01:16
	***********************************/

	elsif(p_transaccion='GM_INSEDE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tinstruc_seg_det
            where id_instruc_seg_det=v_parametros.id_instruc_seg_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle de Instrucciones de Seguridad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_instruc_seg_det',v_parametros.id_instruc_seg_det::varchar);
              
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
ALTER FUNCTION "gem"."ft_instruc_seg_det_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
