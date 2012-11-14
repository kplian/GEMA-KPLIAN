CREATE OR REPLACE FUNCTION alm.f_almacen_usuario_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.f_almacen_usuario_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.talmacen_usuario'
 AUTOR: 		 (admin)
 FECHA:	        13-11-2012 01:30:22
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

    v_nombre_funcion = 'alm.f_almacen_usuario_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_ALMUSU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-11-2012 01:30:22
	***********************************/

	if(p_transaccion='SAL_ALMUSU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.talmacen_usuario(
			estado_reg,
			id_usuario,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_usuario,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_almacen_usuario into v_id_almacen_usuario;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Almaceneros almacenado(a) con exito (id_almacen_usuario'||v_id_almacen_usuario||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_usuario',v_id_almacen_usuario::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMUSU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-11-2012 01:30:22
	***********************************/

	elsif(p_transaccion='SAL_ALMUSU_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.talmacen_usuario set
			id_usuario = v_parametros.id_usuario,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_almacen_usuario=v_parametros.id_almacen_usuario;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Almaceneros modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_usuario',v_parametros.id_almacen_usuario::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMUSU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-11-2012 01:30:22
	***********************************/

	elsif(p_transaccion='SAL_ALMUSU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.talmacen_usuario
            where id_almacen_usuario=v_parametros.id_almacen_usuario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Almaceneros eliminado(a)'); 
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;