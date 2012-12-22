--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_uni_cons_doc_tec_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_uni_cons_doc_tec_ime
 DESCRIPCION:   Transacciones IME para la tabla tuni_cons_doc_tec
 AUTOR: 		aao
 FECHA:	        21-12-2012 12:20:00
 COMENTARIOS:	
***************************************************************************/

DECLARE

	v_parametros           	record;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;

	v_id_documento_tec			integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_uni_cons_doc_tec_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_UCDOCTEC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		aao
 	#FECHA:		21-12-2012 12:24:00
	***********************************/

	if(p_transaccion='GEM_UCDOCTEC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons_doc_tec(
            id_usuario_reg,
            id_usuario_mod,
            fecha_reg,
            fecha_mod,
            estado_reg,
            nombre_documento,
            adjunto,
            codigo,
            observaciones,
            id_uni_cons
          	) values(
            p_id_usuario,
            null,
            now(),
            null,
            'activo',
            v_parametros.nombre_documento,
            v_parametros.adjunto,
            v_parametros.codigo,
            v_parametros.observaciones,
            v_parametros.id_uni_cons
            )RETURNING id_documento_tec into v_id_documento_tec;
            
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentacion tecnica almacenada con exito (id_documento_tec: '||v_id_documento_tec||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_tec',v_id_documento_tec::varchar);
			
            --Devuelve la respuesta
            return v_resp;
		end;
	
	/*********************************    
 	#TRANSACCION:  'GEM_UCDOCTEC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		aao	
 	#FECHA:		21-12-2012 12:27:00
	***********************************/

	elsif(p_transaccion='GEM_UCDOCTEC_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons_doc_tec set
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              nombre_documento = v_parametros.nombre_documento,
              adjunto = v_parametros.adjunto,
              codigo = v_parametros.codigo,
              observaciones = v_parametros.observaciones,
              id_uni_cons = v_parametros.id_uni_cons
            where id_documento_tec = v_parametros.id_documento_tec;
            
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentacion Tecnica modificada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_tec',v_parametros.id_documento_tec::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_UCDOCTEC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		aoo	
 	#FECHA:		21-12-2012 12:30:00
	***********************************/

	elsif(p_transaccion='GEM_UCDOCTEC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons_doc_tec
            where id_documento_tec=v_parametros.id_documento_tec;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentacion tecnica eliminada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_tec',v_parametros.id_documento_tec::varchar);
              
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;