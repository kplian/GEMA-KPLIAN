CREATE OR REPLACE FUNCTION "gem"."f_orden_trabajo_sol_insumo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.f_orden_trabajo_sol_insumo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.torden_trabajo_sol_insumo'
 AUTOR: 		 (admin)
 FECHA:	        17-02-2013 07:39:55
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
	v_id_orden_trabajo_sol_insumo	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_orden_trabajo_sol_insumo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_OTSOIN_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2013 07:39:55
	***********************************/

	if(p_transaccion='GM_OTSOIN_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.torden_trabajo_sol_insumo(
			id_orden_trabajo_sol,
			id_unidad_medida,
			descripcion,
			cant_insum,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_orden_trabajo_sol,
			v_parametros.id_unidad_medida,
			v_parametros.descripcion,
			v_parametros.cant_insum,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_orden_trabajo_sol_insumo into v_id_orden_trabajo_sol_insumo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Insumos almacenado(a) con exito (id_orden_trabajo_sol_insumo'||v_id_orden_trabajo_sol_insumo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo_sol_insumo',v_id_orden_trabajo_sol_insumo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_OTSOIN_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2013 07:39:55
	***********************************/

	elsif(p_transaccion='GM_OTSOIN_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.torden_trabajo_sol_insumo set
			id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol,
			id_unidad_medida = v_parametros.id_unidad_medida,
			descripcion = v_parametros.descripcion,
			cant_insum = v_parametros.cant_insum,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_orden_trabajo_sol_insumo=v_parametros.id_orden_trabajo_sol_insumo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Insumos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo_sol_insumo',v_parametros.id_orden_trabajo_sol_insumo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_OTSOIN_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2013 07:39:55
	***********************************/

	elsif(p_transaccion='GM_OTSOIN_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.torden_trabajo_sol_insumo
            where id_orden_trabajo_sol_insumo=v_parametros.id_orden_trabajo_sol_insumo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Insumos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo_sol_insumo',v_parametros.id_orden_trabajo_sol_insumo::varchar);
              
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
ALTER FUNCTION "gem"."f_orden_trabajo_sol_insumo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
