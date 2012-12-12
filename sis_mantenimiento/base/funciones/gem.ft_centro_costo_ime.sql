CREATE OR REPLACE FUNCTION "gem"."ft_centro_costo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_centro_costo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tcentro_costo'
 AUTOR: 		 (admin)
 FECHA:	        08-12-2012 05:45:32
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
	v_id_centro_costo	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_centro_costo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_cencos_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-12-2012 05:45:32
	***********************************/

	if(p_transaccion='GM_cencos_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tcentro_costo(
			tipo,
			codigo,
			descripcion,
			estado_reg,
			codigo_anh,
			descripcion_anh,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.tipo,
			v_parametros.codigo,
			v_parametros.descripcion,
			'activo',
			v_parametros.codigo_anh,
			v_parametros.descripcion_anh,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_centro_costo into v_id_centro_costo;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costo almacenado(a) con exito (id_centro_costo'||v_id_centro_costo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_id_centro_costo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_cencos_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-12-2012 05:45:32
	***********************************/

	elsif(p_transaccion='GM_cencos_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tcentro_costo set
			tipo = v_parametros.tipo,
			codigo = v_parametros.codigo,
			descripcion = v_parametros.descripcion,
			codigo_anh = v_parametros.codigo_anh,
			descripcion_anh = v_parametros.descripcion_anh,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_centro_costo=v_parametros.id_centro_costo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_parametros.id_centro_costo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_cencos_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-12-2012 05:45:32
	***********************************/

	elsif(p_transaccion='GM_cencos_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tcentro_costo
            where id_centro_costo=v_parametros.id_centro_costo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_parametros.id_centro_costo::varchar);
              
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
ALTER FUNCTION "gem"."ft_centro_costo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
