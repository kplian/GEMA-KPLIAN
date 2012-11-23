CREATE OR REPLACE FUNCTION gem.f_tipo_mant_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_tipo_mant_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.ttipo_mant'
 AUTOR: 		 (admin)
 FECHA:	        17-08-2012 12:04:42
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
	v_id_tipo_mant	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_tipo_mant_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GETIMA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 12:04:42
	***********************************/

	if(p_transaccion='GEM_GETIMA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.ttipo_mant(
			codigo,
			nombre,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
			tipo
          	) values(
			v_parametros.codigo,
			v_parametros.nombre,
			'activo',
			p_id_usuario,
			now(),
			null,
			null,
			v_parametros.tipo
			)RETURNING id_tipo_mant into v_id_tipo_mant;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Mantenimiento almacenado(a) con exito (id_tipo_mant'||v_id_tipo_mant||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_mant',v_id_tipo_mant::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GETIMA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 12:04:42
	***********************************/

	elsif(p_transaccion='GEM_GETIMA_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.ttipo_mant set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			tipo = v_parametros.tipo
			where id_tipo_mant=v_parametros.id_tipo_mant;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Mantenimiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_mant',v_parametros.id_tipo_mant::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GETIMA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 12:04:42
	***********************************/

	elsif(p_transaccion='GEM_GETIMA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.ttipo_mant
            where id_tipo_mant=v_parametros.id_tipo_mant;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Mantenimiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_mant',v_parametros.id_tipo_mant::varchar);
              
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