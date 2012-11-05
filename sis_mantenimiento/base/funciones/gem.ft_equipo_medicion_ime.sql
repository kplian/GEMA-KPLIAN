CREATE OR REPLACE FUNCTION "gem"."ft_equipo_medicion_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_equipo_medicion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tequipo_medicion'
 AUTOR: 		 (admin)
 FECHA:	        27-09-2012 03:02:35
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
	v_id_equipo_medicion	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_equipo_medicion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	if(p_transaccion='GEM_GEMEDI_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tequipo_medicion(
			id_equipo_variable,
			observaciones,
			estado_reg,
			fecha_medicion,
			medicion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_equipo_variable,
			v_parametros.observaciones,
			'activo',
			v_parametros.fecha_medicion,
			v_parametros.medicion,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_equipo_medicion into v_id_equipo_medicion;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones almacenado(a) con exito (id_equipo_medicion'||v_id_equipo_medicion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_medicion',v_id_equipo_medicion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	elsif(p_transaccion='GEM_GEMEDI_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tequipo_medicion set
			id_equipo_variable = v_parametros.id_equipo_variable,
			observaciones = v_parametros.observaciones,
			fecha_medicion = v_parametros.fecha_medicion,
			medicion = v_parametros.medicion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_equipo_medicion=v_parametros.id_equipo_medicion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_medicion',v_parametros.id_equipo_medicion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	elsif(p_transaccion='GEM_GEMEDI_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tequipo_medicion
            where id_equipo_medicion=v_parametros.id_equipo_medicion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_medicion',v_parametros.id_equipo_medicion::varchar);
              
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
ALTER FUNCTION "gem"."ft_equipo_medicion_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
