CREATE OR REPLACE FUNCTION "gem"."ft_uni_cons_mant_predef_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_uni_cons_mant_predef_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons_mant_predef'
 AUTOR: 		 (admin)
 FECHA:	        12-10-2012 23:35:54
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
	v_id_uni_cons_mant_predef	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_uni_cons_mant_predef_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEEQMA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-10-2012 23:35:54
	***********************************/

	if(p_transaccion='GEM_GEEQMA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons_mant_predef(
			id_mant_predef,
			id_uni_cons,
			id_unidad_medida,
			frecuencia,
			fecha_ini,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod,
			id_unidad_medida_estimado,
			tiempo_estimado
          	) values(
			v_parametros.id_mant_predef,
			v_parametros.id_uni_cons,
			v_parametros.id_unidad_medida,
			v_parametros.frecuencia,
			v_parametros.fecha_ini,
			'activo',
			now(),
			p_id_usuario,
			null,
			null,
			v_parametros.id_unidad_medida_estimado,
			v_parametros.tiempo_estimado
			)RETURNING id_uni_cons_mant_predef into v_id_uni_cons_mant_predef;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Equipo - Mantenimiento almacenado(a) con exito (id_uni_cons_mant_predef'||v_id_uni_cons_mant_predef||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_mant_predef',v_id_uni_cons_mant_predef::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEEQMA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-10-2012 23:35:54
	***********************************/

	elsif(p_transaccion='GEM_GEEQMA_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons_mant_predef set
			id_mant_predef = v_parametros.id_mant_predef,
			id_uni_cons = v_parametros.id_uni_cons,
			id_unidad_medida = v_parametros.id_unidad_medida,
			frecuencia = v_parametros.frecuencia,
			fecha_ini = v_parametros.fecha_ini,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_unidad_medida_estimado = v_parametros.id_unidad_medida_estimado,
			tiempo_estimado = v_parametros.tiempo_estimado
			where id_uni_cons_mant_predef=v_parametros.id_uni_cons_mant_predef;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Equipo - Mantenimiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_mant_predef',v_parametros.id_uni_cons_mant_predef::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEEQMA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-10-2012 23:35:54
	***********************************/

	elsif(p_transaccion='GEM_GEEQMA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons_mant_predef
            where id_uni_cons_mant_predef=v_parametros.id_uni_cons_mant_predef;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Equipo - Mantenimiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_mant_predef',v_parametros.id_uni_cons_mant_predef::varchar);
              
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
ALTER FUNCTION "gem"."ft_uni_cons_mant_predef_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
