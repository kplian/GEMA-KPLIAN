CREATE OR REPLACE FUNCTION gem.ft_modo_falla_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_modo_falla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tmodo_falla'
 AUTOR: 		 (rac)
 FECHA:	        18-10-2012 04:54:08
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
	v_id_modo_falla	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_modo_falla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_MODFALLA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		18-10-2012 04:54:08
	***********************************/

	if(p_transaccion='GEM_MODFALLA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tmodo_falla(
			id_funcion_falla,
			modo_falla,
			efecto_falla,
			orden,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_funcion_falla,
			v_parametros.modo_falla,
			v_parametros.efecto_falla,
			v_parametros.orden,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_modo_falla into v_id_modo_falla;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Modos de Falla almacenado(a) con exito (id_modo_falla'||v_id_modo_falla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_modo_falla',v_id_modo_falla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MODFALLA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		18-10-2012 04:54:08
	***********************************/

	elsif(p_transaccion='GEM_MODFALLA_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tmodo_falla set
			id_funcion_falla = v_parametros.id_funcion_falla,
			modo_falla = v_parametros.modo_falla,
			efecto_falla = v_parametros.efecto_falla,
			orden = v_parametros.orden,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_modo_falla=v_parametros.id_modo_falla;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Modos de Falla modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_modo_falla',v_parametros.id_modo_falla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MODFALLA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		18-10-2012 04:54:08
	***********************************/

	elsif(p_transaccion='GEM_MODFALLA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tmodo_falla
            where id_modo_falla=v_parametros.id_modo_falla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Modos de Falla eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_modo_falla',v_parametros.id_modo_falla::varchar);
              
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