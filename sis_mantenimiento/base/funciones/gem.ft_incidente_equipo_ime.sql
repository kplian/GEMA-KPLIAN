CREATE OR REPLACE FUNCTION "gem"."ft_incidente_equipo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_incidente_equipo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tincidente_equipo'
 AUTOR: 		 (admin)
 FECHA:	        08-11-2012 17:11:06
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
	v_id_incidente_equipo	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_incidente_equipo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEEQIN_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-11-2012 17:11:06
	***********************************/

	if(p_transaccion='GEM_GEEQIN_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tincidente_equipo(
			id_uni_cons,
			id_falla_evento,
			descripcion,
			estado_reg,
			fecha_desde,
			fecha_hasta,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_uni_cons,
			v_parametros.id_falla_evento,
			v_parametros.descripcion,
			'activo',
			v_parametros.fecha_desde,
			v_parametros.fecha_hasta,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_incidente_equipo into v_id_incidente_equipo;
               
			--Definicion de la respuesta
			v_resp = pxp.pxp.f_agrega_clave(v_resp,'mensaje','Equipos/Incidentes almacenado(a) con exito (id_incidente_equipo'||v_id_incidente_equipo||')'); 
            v_resp = pxp.pxp.f_agrega_clave(v_resp,'id_incidente_equipo',v_id_incidente_equipo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEEQIN_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-11-2012 17:11:06
	***********************************/

	elsif(p_transaccion='GEM_GEEQIN_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tincidente_equipo set
			id_uni_cons = v_parametros.id_uni_cons,
			id_falla_evento = v_parametros.id_falla_evento,
			descripcion = v_parametros.descripcion,
			fecha_desde = v_parametros.fecha_desde,
			fecha_hasta = v_parametros.fecha_hasta,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_incidente_equipo=v_parametros.id_incidente_equipo;
               
			--Definicion de la respuesta
            v_resp = pxp.pxp.f_agrega_clave(v_resp,'mensaje','Equipos/Incidentes modificado(a)'); 
            v_resp = pxp.pxp.f_agrega_clave(v_resp,'id_incidente_equipo',v_parametros.id_incidente_equipo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEEQIN_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-11-2012 17:11:06
	***********************************/

	elsif(p_transaccion='GEM_GEEQIN_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tincidente_equipo
            where id_incidente_equipo=v_parametros.id_incidente_equipo;
               
            --Definicion de la respuesta
            v_resp = pxp.pxp.f_agrega_clave(v_resp,'mensaje','Equipos/Incidentes eliminado(a)'); 
            v_resp = pxp.pxp.f_agrega_clave(v_resp,'id_incidente_equipo',v_parametros.id_incidente_equipo::varchar);
              
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
ALTER FUNCTION "gem"."ft_incidente_equipo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
