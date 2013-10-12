CREATE OR REPLACE FUNCTION "gem"."ft_mant_predef_item_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_mant_predef_item_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tmant_predef_item'
 AUTOR: 		 (admin)
 FECHA:	        10-10-2013 23:53:04
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
	v_id_mant_predef_item	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_mant_predef_item_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_MAPRIT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-10-2013 23:53:04
	***********************************/

	if(p_transaccion='GM_MAPRIT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tmant_predef_item(
			id_mant_predef,
			id_item,
			cantidad_item,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_mant_predef,
			v_parametros.id_item,
			v_parametros.cantidad_item,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_mant_predef_item into v_id_mant_predef_item;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Repuestos por Mantenimiento almacenado(a) con exito (id_mant_predef_item'||v_id_mant_predef_item||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef_item',v_id_mant_predef_item::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_MAPRIT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-10-2013 23:53:04
	***********************************/

	elsif(p_transaccion='GM_MAPRIT_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tmant_predef_item set
			id_mant_predef = v_parametros.id_mant_predef,
			id_item = v_parametros.id_item,
			cantidad_item = v_parametros.cantidad_item,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_mant_predef_item=v_parametros.id_mant_predef_item;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Repuestos por Mantenimiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef_item',v_parametros.id_mant_predef_item::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_MAPRIT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-10-2013 23:53:04
	***********************************/

	elsif(p_transaccion='GM_MAPRIT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tmant_predef_item
            where id_mant_predef_item=v_parametros.id_mant_predef_item;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Repuestos por Mantenimiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef_item',v_parametros.id_mant_predef_item::varchar);
              
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
ALTER FUNCTION "gem"."ft_mant_predef_item_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
