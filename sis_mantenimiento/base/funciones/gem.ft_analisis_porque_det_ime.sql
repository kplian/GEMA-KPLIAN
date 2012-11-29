CREATE OR REPLACE FUNCTION "gem"."ft_analisis_porque_det_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_analisis_porque_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tanalisis_porque_det'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        28-11-2012 22:01:17
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
	v_id_analisis_porque_det	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_analisis_porque_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_DET_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		28-11-2012 22:01:17
	***********************************/

	if(p_transaccion='GM_DET_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tanalisis_porque_det(
			id_analisis_porque,
			solucion,
			estado_reg,
			porque,
			respuesta,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_analisis_porque,
			v_parametros.solucion,
			'activo',
			v_parametros.porque,
			v_parametros.respuesta,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_analisis_porque_det into v_id_analisis_porque_det;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle almacenado(a) con exito (id_analisis_porque_det'||v_id_analisis_porque_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_analisis_porque_det',v_id_analisis_porque_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_DET_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		28-11-2012 22:01:17
	***********************************/

	elsif(p_transaccion='GM_DET_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tanalisis_porque_det set
			id_analisis_porque = v_parametros.id_analisis_porque,
			solucion = v_parametros.solucion,
			porque = v_parametros.porque,
			respuesta = v_parametros.respuesta,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_analisis_porque_det=v_parametros.id_analisis_porque_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_analisis_porque_det',v_parametros.id_analisis_porque_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_DET_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		28-11-2012 22:01:17
	***********************************/

	elsif(p_transaccion='GM_DET_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tanalisis_porque_det
            where id_analisis_porque_det=v_parametros.id_analisis_porque_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_analisis_porque_det',v_parametros.id_analisis_porque_det::varchar);
              
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
ALTER FUNCTION "gem"."ft_analisis_porque_det_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
