CREATE OR REPLACE FUNCTION "alm"."ft_almacen_usuario_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_almacen_usuario_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.talmacen_usuario'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        28-11-2012 14:52:50
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
	v_id_almacen_usuario	integer;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_almacen_usuario_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_ALMUSR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:			Gonzalo Sarmiento Sejas
 	#FECHA:		28-11-2012 14:52:50
	***********************************/

	if(p_transaccion='SAL_ALMUSR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.talmacen_usuario(
			id_usuario,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_usuario,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_almacen_usuario into v_id_almacen_usuario;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuarios de almacenes almacenado(a) con exito (id_almacen_usuario'||v_id_almacen_usuario||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_usuario',v_id_almacen_usuario::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMUSR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:			Gonzalo Sarmiento Sejas
 	#FECHA:		28-11-2012 14:52:50
	***********************************/

	elsif(p_transaccion='SAL_ALMUSR_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.talmacen_usuario set
			id_usuario = v_parametros.id_usuario,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_almacen_usuario=v_parametros.id_almacen_usuario;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuarios de almacenes modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_usuario',v_parametros.id_almacen_usuario::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMUSR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:			Gonzalo Sarmiento Sejas
 	#FECHA:		28-11-2012 14:52:50
	***********************************/

	elsif(p_transaccion='SAL_ALMUSR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.talmacen_usuario
            where id_almacen_usuario=v_parametros.id_almacen_usuario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuarios de almacenes eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_usuario',v_parametros.id_almacen_usuario::varchar);
              
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
ALTER FUNCTION "alm"."ft_almacen_usuario_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
