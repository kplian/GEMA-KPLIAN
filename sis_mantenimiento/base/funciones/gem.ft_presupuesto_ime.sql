CREATE OR REPLACE FUNCTION "gem"."ft_presupuesto_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_presupuesto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tpresupuesto'
 AUTOR: 		 (admin)
 FECHA:	        12-06-2013 08:25:14
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
	v_id_presupuesto	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_presupuesto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_GEPRES_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-06-2013 08:25:14
	***********************************/

	if(p_transaccion='GM_GEPRES_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tpresupuesto(
			estado_reg,
			codigo,
			gestion,
			nombre,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.codigo,
			v_parametros.gestion,
			v_parametros.nombre,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_presupuesto into v_id_presupuesto;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuestos almacenado(a) con exito (id_presupuesto'||v_id_presupuesto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto',v_id_presupuesto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_GEPRES_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-06-2013 08:25:14
	***********************************/

	elsif(p_transaccion='GM_GEPRES_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tpresupuesto set
			codigo = v_parametros.codigo,
			gestion = v_parametros.gestion,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_presupuesto=v_parametros.id_presupuesto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuestos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto',v_parametros.id_presupuesto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_GEPRES_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-06-2013 08:25:14
	***********************************/

	elsif(p_transaccion='GM_GEPRES_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tpresupuesto
            where id_presupuesto=v_parametros.id_presupuesto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuestos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto',v_parametros.id_presupuesto::varchar);
              
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
ALTER FUNCTION "gem"."ft_presupuesto_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
