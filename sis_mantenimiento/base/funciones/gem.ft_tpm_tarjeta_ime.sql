CREATE OR REPLACE FUNCTION "gem"."ft_tpm_tarjeta_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_tpm_tarjeta_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.ttpm_tarjeta'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        29-11-2012 02:21:39
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
	v_id_tpm_tarjeta	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_tpm_tarjeta_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_TARTPM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		29-11-2012 02:21:39
	***********************************/

	if(p_transaccion='GM_TARTPM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.ttpm_tarjeta(
			id_localizacion,
			estado_reg,
			fecha_emision,
			tipo,
			revision,
			codigo,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_localizacion,
			'activo',
			v_parametros.fecha_emision,
			v_parametros.tipo,
			v_parametros.revision,
			v_parametros.codigo,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_tpm_tarjeta into v_id_tpm_tarjeta;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Control de Tarjetas TPM almacenado(a) con exito (id_tpm_tarjeta'||v_id_tpm_tarjeta||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tpm_tarjeta',v_id_tpm_tarjeta::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_TARTPM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		29-11-2012 02:21:39
	***********************************/

	elsif(p_transaccion='GM_TARTPM_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.ttpm_tarjeta set
			id_localizacion = v_parametros.id_localizacion,
			fecha_emision = v_parametros.fecha_emision,
			tipo = v_parametros.tipo,
			revision = v_parametros.revision,
			codigo = v_parametros.codigo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_tpm_tarjeta=v_parametros.id_tpm_tarjeta;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Control de Tarjetas TPM modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tpm_tarjeta',v_parametros.id_tpm_tarjeta::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_TARTPM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		29-11-2012 02:21:39
	***********************************/

	elsif(p_transaccion='GM_TARTPM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.ttpm_tarjeta
            where id_tpm_tarjeta=v_parametros.id_tpm_tarjeta;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Control de Tarjetas TPM eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tpm_tarjeta',v_parametros.id_tpm_tarjeta::varchar);
              
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
ALTER FUNCTION "gem"."ft_tpm_tarjeta_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
