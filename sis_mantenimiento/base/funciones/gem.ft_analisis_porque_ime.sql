CREATE OR REPLACE FUNCTION "gem"."ft_analisis_porque_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_analisis_porque_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tanalisis_porque'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        28-11-2012 20:22:29
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
	v_id_analisis_porque	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_analisis_porque_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_ANAPOR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:			Gonzalo Sarmiento Sejas
 	#FECHA:		28-11-2012 20:22:29
	***********************************/

	if(p_transaccion='GM_ANAPOR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tanalisis_porque(
			id_uni_cons,
			tecnicos,
			estado_reg,
			estado,
			fecha,
			operadores,
			coordinadores,
			problema,
			numero,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_uni_cons,
			v_parametros.tecnicos,
			'activo',
			v_parametros.estado,
			v_parametros.fecha,
			v_parametros.operadores,
			v_parametros.coordinadores,
			v_parametros.problema,
			v_parametros.numero,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_analisis_porque into v_id_analisis_porque;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Analisis Porque almacenado(a) con exito (id_analisis_porque'||v_id_analisis_porque||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_analisis_porque',v_id_analisis_porque::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_ANAPOR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:			Gonzalo Sarmiento Sejas	
 	#FECHA:		28-11-2012 20:22:29
	***********************************/

	elsif(p_transaccion='GM_ANAPOR_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tanalisis_porque set
			id_uni_cons = v_parametros.id_uni_cons,
			tecnicos = v_parametros.tecnicos,
			estado = v_parametros.estado,
			fecha = v_parametros.fecha,
			operadores = v_parametros.operadores,
			coordinadores = v_parametros.coordinadores,
			problema = v_parametros.problema,
			numero = v_parametros.numero,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_analisis_porque=v_parametros.id_analisis_porque;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Analisis Porque modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_analisis_porque',v_parametros.id_analisis_porque::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_ANAPOR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:			Gonzalo Sarmiento Sejas	
 	#FECHA:		28-11-2012 20:22:29
	***********************************/

	elsif(p_transaccion='GM_ANAPOR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tanalisis_porque
            where id_analisis_porque=v_parametros.id_analisis_porque;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Analisis Porque eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_analisis_porque',v_parametros.id_analisis_porque::varchar);
              
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
ALTER FUNCTION "gem"."ft_analisis_porque_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
