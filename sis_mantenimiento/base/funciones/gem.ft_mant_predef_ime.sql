CREATE OR REPLACE FUNCTION "gem"."ft_mant_predef_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_mant_predef_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tmant_predef'
 AUTOR: 		 (admin)
 FECHA:	        28-08-2012 20:25:32
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
	v_id_mant_predef	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_mant_predef_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEMAPR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 20:25:32
	***********************************/

	if(p_transaccion='GEM_GEMAPR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tmant_predef(
			codigo,
			descripcion,
			nombre,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod,
			id_tipo_equipo,
			id_unidad_medida_estimado,
			tiempo_estimado
          	) values(
			v_parametros.codigo,
			v_parametros.descripcion,
			v_parametros.nombre,
			'activo',
			p_id_usuario,
			now(),
			null,
			null,
			v_parametros.id_tipo_equipo,
			v_parametros.id_unidad_medida_estimado,
			v_parametros.tiempo_estimado
			)RETURNING id_mant_predef into v_id_mant_predef;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mantenimientos predefinidos almacenado(a) con exito (id_mant_predef'||v_id_mant_predef||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef',v_id_mant_predef::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMAPR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 20:25:32
	***********************************/

	elsif(p_transaccion='GEM_GEMAPR_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tmant_predef set
			codigo = v_parametros.codigo,
			descripcion = v_parametros.descripcion,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_tipo_equipo = v_parametros.id_tipo_equipo,
			id_unidad_medida_estimado = v_parametros.id_unidad_medida_estimado,
			tiempo_estimado = v_parametros.tiempo_estimado
			where id_mant_predef=v_parametros.id_mant_predef;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mantenimientos predefinidos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef',v_parametros.id_mant_predef::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMAPR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		28-08-2012 20:25:32
	***********************************/

	elsif(p_transaccion='GEM_GEMAPR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tmant_predef
            where id_mant_predef=v_parametros.id_mant_predef;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mantenimientos predefinidos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef',v_parametros.id_mant_predef::varchar);
              
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
ALTER FUNCTION "gem"."ft_mant_predef_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
