CREATE OR REPLACE FUNCTION "gem"."ft_tpm_tarjeta_det_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_tpm_tarjeta_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.ttpm_tarjeta_det'
 AUTOR: 		Gonzalo Sarmiento Sejas 
 FECHA:	        29-11-2012 14:51:50
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
	v_id_tpm_tarjeta_det	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_tpm_tarjeta_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_TARDET_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas 	
 	#FECHA:		29-11-2012 14:51:50
	***********************************/

	if(p_transaccion='GM_TARDET_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.ttpm_tarjeta_det(
			id_tpm_tarjeta,
			id_funcionario_detec,
			id_funcionario_efec,
			id_uni_cons,
			observaciones,
			falla_el,
			fecha_retiro,
			contaminacion,
			oportunidad_mejora,
			falla_ist,
			descripcion,
			acceso_dificil,
			falla_ne,
			falla_me,
			fecha_coloc,
			estado_reg,
			cond_inseg,
			falla_hi,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_tpm_tarjeta,
			v_parametros.id_funcionario_detec,
			v_parametros.id_funcionario_efec,
			v_parametros.id_uni_cons,
			v_parametros.observaciones,
			v_parametros.falla_el,
			v_parametros.fecha_retiro,
			v_parametros.contaminacion,
			v_parametros.oportunidad_mejora,
			v_parametros.falla_ist,
			v_parametros.descripcion,
			v_parametros.acceso_dificil,
			v_parametros.falla_ne,
			v_parametros.falla_me,
			v_parametros.fecha_coloc,
			'activo',
			v_parametros.cond_inseg,
			v_parametros.falla_hi,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_tpm_tarjeta_det into v_id_tpm_tarjeta_det;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle almacenado(a) con exito (id_tpm_tarjeta_det'||v_id_tpm_tarjeta_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tpm_tarjeta_det',v_id_tpm_tarjeta_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_TARDET_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas 	
 	#FECHA:		29-11-2012 14:51:50
	***********************************/

	elsif(p_transaccion='GM_TARDET_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.ttpm_tarjeta_det set
			id_tpm_tarjeta = v_parametros.id_tpm_tarjeta,
			id_funcionario_detec = v_parametros.id_funcionario_detec,
			id_funcionario_efec = v_parametros.id_funcionario_efec,
			id_uni_cons = v_parametros.id_uni_cons,
			observaciones = v_parametros.observaciones,
			falla_el = v_parametros.falla_el,
			fecha_retiro = v_parametros.fecha_retiro,
			contaminacion = v_parametros.contaminacion,
			oportunidad_mejora = v_parametros.oportunidad_mejora,
			falla_ist = v_parametros.falla_ist,
			descripcion = v_parametros.descripcion,
			acceso_dificil = v_parametros.acceso_dificil,
			falla_ne = v_parametros.falla_ne,
			falla_me = v_parametros.falla_me,
			fecha_coloc = v_parametros.fecha_coloc,
			cond_inseg = v_parametros.cond_inseg,
			falla_hi = v_parametros.falla_hi,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tpm_tarjeta_det=v_parametros.id_tpm_tarjeta_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tpm_tarjeta_det',v_parametros.id_tpm_tarjeta_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_TARDET_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas 	
 	#FECHA:		29-11-2012 14:51:50
	***********************************/

	elsif(p_transaccion='GM_TARDET_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.ttpm_tarjeta_det
            where id_tpm_tarjeta_det=v_parametros.id_tpm_tarjeta_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tpm_tarjeta_det',v_parametros.id_tpm_tarjeta_det::varchar);
              
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
ALTER FUNCTION "gem"."ft_tpm_tarjeta_det_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
