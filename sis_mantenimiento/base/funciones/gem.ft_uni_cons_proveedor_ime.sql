CREATE OR REPLACE FUNCTION gem.ft_uni_cons_proveedor_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_uni_cons_proveedor_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons_proveedor'
 AUTOR: 		 (rac)
 FECHA:	        01-11-2012 14:45:49
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
	v_id_uni_cons_proveedor	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_uni_cons_proveedor_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_unipro_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		01-11-2012 14:45:49
	***********************************/

	if(p_transaccion='GEM_unipro_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons_proveedor(
			estado_reg,
			id_uni_cons,
			id_proveedor,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.estado_reg,
			v_parametros.id_uni_cons,
			v_parametros.id_proveedor,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_uni_cons_proveedor into v_id_uni_cons_proveedor;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores del equipo almacenado(a) con exito (id_uni_cons_proveedor'||v_id_uni_cons_proveedor||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_proveedor',v_id_uni_cons_proveedor::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_unipro_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		01-11-2012 14:45:49
	***********************************/

	elsif(p_transaccion='GEM_unipro_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons_proveedor set
			id_uni_cons = v_parametros.id_uni_cons,
			id_proveedor = v_parametros.id_proveedor,
            estado_reg=v_parametros.estado_reg,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_uni_cons_proveedor=v_parametros.id_uni_cons_proveedor;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores del equipo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_proveedor',v_parametros.id_uni_cons_proveedor::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_unipro_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		01-11-2012 14:45:49
	***********************************/

	elsif(p_transaccion='GEM_unipro_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons_proveedor
            where id_uni_cons_proveedor=v_parametros.id_uni_cons_proveedor;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores del equipo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_proveedor',v_parametros.id_uni_cons_proveedor::varchar);
              
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;