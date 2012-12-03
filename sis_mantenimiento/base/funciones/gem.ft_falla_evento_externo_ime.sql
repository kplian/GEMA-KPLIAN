CREATE OR REPLACE FUNCTION gem.ft_falla_evento_externo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_falla_evento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tfalla_evento'
 AUTOR: 		 (admin)
 FECHA:	        30-09-2012 21:41:31
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
	v_id_falla_evento	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_falla_evento_externo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEFAEV_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:41:31
	***********************************/

	if(p_transaccion='GEM_GEFAEVE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tfalla_evento(
			id_tipo_equipo,
			tipo,
			estado_reg,
			nombre,
			codigo,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod,
            descripcion
          	) values(
			null,
			v_parametros.tipo,
			'activo',
			v_parametros.nombre,
			v_parametros.codigo,
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.descripcion
			)RETURNING id_falla_evento into v_id_falla_evento;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Falla/Evento almacenado(a) con exito (id_falla_evento'||v_id_falla_evento||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_falla_evento',v_id_falla_evento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEFAEV_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:41:31
	***********************************/

	elsif(p_transaccion='GEM_GEFAEVE_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tfalla_evento set
			id_tipo_equipo = v_parametros.id_tipo_equipo,
			tipo = v_parametros.tipo,
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
            descripcion = v_parametros.descripcion
			where id_falla_evento=v_parametros.id_falla_evento;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Falla/Evento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_falla_evento',v_parametros.id_falla_evento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEFAEV_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:41:31
	***********************************/

	elsif(p_transaccion='GEM_GEFAEVE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tfalla_evento
            where id_falla_evento=v_parametros.id_falla_evento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Falla/Evento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_falla_evento',v_parametros.id_falla_evento::varchar);
              
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