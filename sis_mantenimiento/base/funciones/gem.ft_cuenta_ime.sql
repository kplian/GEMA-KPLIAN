--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_cuenta_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Mantenimiento
 FUNCION: 		gem.ft_cuenta_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'conta.tcuenta'
 AUTOR: 		RCM
 FECHA:	        14/04/2013
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
	v_id_cuenta	integer;
    
    v_id_cuenta_padre integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_cuenta_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_CTA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		RCM	
 	#FECHA:		14-04-2013
	***********************************/

	if(p_transaccion='GEM_CTA_INS')then
					
        begin
           IF v_parametros.id_cuenta_padre != 'id' and v_parametros.id_cuenta_padre != '' THEN
             v_id_cuenta_padre=v_parametros.id_cuenta_padre::integer;
           END IF;
        
        
        	--Sentencia de la insercion
        	insert into gem.tcuenta(
            id_cuenta_padre,
            nro_cuenta,
			      nombre_cuenta,
            estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_id_cuenta_padre,
      v_parametros.nro_cuenta,
			v_parametros.nombre_cuenta,
      'activo',
      now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_cuenta into v_id_cuenta;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta almacenado(a) con exito (id_cuenta'||v_id_cuenta||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cuenta',v_id_cuenta::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_CTA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		RCM	
 	#FECHA:		14-04-2013
	***********************************/

	elsif(p_transaccion='GEM_CTA_MOD')then

		begin
           
        IF v_parametros.id_cuenta_padre != 'id' and v_parametros.id_cuenta_padre != '' THEN
             v_id_cuenta_padre=v_parametros.id_cuenta_padre::integer;
        END IF;
        
			--Sentencia de la modificacion
			update gem.tcuenta set
			nombre_cuenta = v_parametros.nombre_cuenta,
			id_cuenta_padre = v_id_cuenta_padre,
			nro_cuenta = v_parametros.nro_cuenta,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_cuenta=v_parametros.id_cuenta;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cuenta',v_parametros.id_cuenta::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_CTA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		RCM	
 	#FECHA:		14-04-2013
	***********************************/

	elsif(p_transaccion='GEM_CTA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tcuenta
            where id_cuenta=v_parametros.id_cuenta;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cuenta',v_parametros.id_cuenta::varchar);
              
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