CREATE OR REPLACE FUNCTION gem.f_equipo_variable_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_equipo_variable_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tequipo_variable'
 AUTOR: 		 (rac)
 FECHA:	        15-08-2012 17:09:17
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
	v_id_equipo_variable	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_equipo_variable_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_EQV_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 17:09:17
	***********************************/

	if(p_transaccion='GEM_EQV_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tequipo_variable(
			estado_reg,
			valor_max,
			id_uni_cons,
			obs,
			valor_min,
			id_tipo_variable,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.valor_max,
			v_parametros.id_uni_cons,
			v_parametros.obs,
			v_parametros.valor_min,
			v_parametros.id_tipo_variable,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_equipo_variable into v_id_equipo_variable;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Variables del Equipo almacenado(a) con exito (id_equipo_variable'||v_id_equipo_variable||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_variable',v_id_equipo_variable::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_EQV_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 17:09:17
	***********************************/

	elsif(p_transaccion='GEM_EQV_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tequipo_variable set
			valor_max = v_parametros.valor_max,
			id_uni_cons = v_parametros.id_uni_cons,
			obs = v_parametros.obs,
			valor_min = v_parametros.valor_min,
			id_tipo_variable = v_parametros.id_tipo_variable,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_equipo_variable=v_parametros.id_equipo_variable;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Variables del Equipo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_variable',v_parametros.id_equipo_variable::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_EQV_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 17:09:17
	***********************************/

	elsif(p_transaccion='GEM_EQV_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tequipo_variable
            where id_equipo_variable=v_parametros.id_equipo_variable;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Variables del Equipo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_variable',v_parametros.id_equipo_variable::varchar);
              
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