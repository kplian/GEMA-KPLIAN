--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_actividad_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_actividad_ime
 DESCRIPCION:   Transacciones IME para la tabla actividad
 AUTOR: 		aao
 FECHA:	        19-11-2012 10:28:00
 COMENTARIOS:	
***************************************************************************/

DECLARE

	v_parametros           	record;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;

	v_id_actividad			integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_actividad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_ACTI_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		aao
 	#FECHA:		19-11-2012 10:32:00
	***********************************/

	if(p_transaccion='GEM_ACTI_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tactividad(
            id_usuario_reg,
            id_usuario_mod,
            fecha_reg,
            fecha_mod,
            estado_reg,
            id_orden_trabajo,
            id_usuario_resp,
            estado,
            descripcion,
            observaciones,
            fecha_plan_ini,
            fecha_plan_fin,
            fecha_eje_ini,
            fecha_eje_fin
          	) values(
            p_id_usuario,
            null,
            now(),
            null,
            'activo',
            v_parametros.id_orden_trabajo,
            v_parametros.id_usuario_resp,
            v_parametros.estado,
            v_parametros.descripcion,
            v_parametros.observaciones,
            v_parametros.fecha_plan_ini,
            v_parametros.fecha_plan_fin,
            v_parametros.fecha_eje_ini,
            v_parametros.fecha_eje_fin
            )RETURNING id_actividad into v_id_actividad;
            
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad almacenada con exito (id_actividad: '||v_id_actividad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_id_actividad::varchar);
			
            --Devuelve la respuesta
            return v_resp;
		end;
	
	/*********************************    
 	#TRANSACCION:  'GEM_ACTI_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		aao	
 	#FECHA:		19-11-2012 10:49:00
	***********************************/

	elsif(p_transaccion='GEM_ACTI_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tactividad set
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              id_orden_trabajo = v_parametros.id_orden_trabajo,
              id_usuario_resp = v_parametros.id_usuario_resp,
              estado = v_parametros.estado,
              descripcion = v_parametros.descripcion,
              observaciones = v_parametros.observaciones,
              fecha_plan_ini = v_parametros.fecha_plan_ini,
              fecha_plan_fin = v_parametros.fecha_plan_fin,
              fecha_eje_ini = v_parametros.fecha_eje_ini,
              fecha_eje_fin = v_parametros.fecha_eje_fin            
			where id_actividad = v_parametros.id_actividad;
            
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad modificada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_parametros.id_actividad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_ACTI_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		aoo	
 	#FECHA:		19-11-2012 11:00:00
	***********************************/

	elsif(p_transaccion='GEM_ACTI_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tactividad
            where id_actividad=v_parametros.id_actividad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad eliminada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_parametros.id_actividad::varchar);
              
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