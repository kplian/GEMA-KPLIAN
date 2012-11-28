CREATE OR REPLACE FUNCTION "pre"."ft_presupuesto_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de presupuesto
 FUNCION: 		pre.ft_presupuesto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'pre.tpresupuesto'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        26-11-2012 21:35:35
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

    v_nombre_funcion = 'pre.ft_presupuesto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PRE_PRE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-11-2012 21:35:35
	***********************************/

	if(p_transaccion='PRE_PRE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into pre.tpresupuesto(
			estado_reg,
			descripcion,
			estado,
			gestion,
			codigo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.descripcion,
			v_parametros.estado,
			v_parametros.gestion,
			v_parametros.codigo,
			now(),
			p_id_usuario,
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
 	#TRANSACCION:  'PRE_PRE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-11-2012 21:35:35
	***********************************/

	elsif(p_transaccion='PRE_PRE_MOD')then

		begin
			--Sentencia de la modificacion
			update pre.tpresupuesto set
			descripcion = v_parametros.descripcion,
			estado = v_parametros.estado,
			gestion = v_parametros.gestion,
			codigo = v_parametros.codigo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_presupuesto=v_parametros.id_presupuesto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuestos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto',v_parametros.id_presupuesto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PRE_PRE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-11-2012 21:35:35
	***********************************/

	elsif(p_transaccion='PRE_PRE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from pre.tpresupuesto
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
ALTER FUNCTION "pre"."ft_presupuesto_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
