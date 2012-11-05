CREATE OR REPLACE FUNCTION "gem"."ft_documento_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_documento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tdocumento'
 AUTOR: 		 (admin)
 FECHA:	        28-08-2012 22:24:50
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
	v_id_documento	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_documento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEDOCU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 22:24:50
	***********************************/

	if(p_transaccion='GEM_GEDOCU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tdocumento(
			nombre,
			codigo,
			resumen,
			nombre_archivo,
			extension,
			palabras_clave,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre,
			v_parametros.codigo,
			v_parametros.resumen,
			v_parametros.nombre_archivo,
			v_parametros.extension,
			v_parametros.palabras_clave,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_documento into v_id_documento;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos almacenado(a) con exito (id_documento'||v_id_documento||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento',v_id_documento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDOCU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 22:24:50
	***********************************/

	elsif(p_transaccion='GEM_GEDOCU_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tdocumento set
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			resumen = v_parametros.resumen,
			nombre_archivo = v_parametros.nombre_archivo,
			extension = v_parametros.extension,
			palabras_clave = v_parametros.palabras_clave,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_documento=v_parametros.id_documento;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento',v_parametros.id_documento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDOCU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 22:24:50
	***********************************/

	elsif(p_transaccion='GEM_GEDOCU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tdocumento
            where id_documento=v_parametros.id_documento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento',v_parametros.id_documento::varchar);
              
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
ALTER FUNCTION "gem"."ft_documento_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
