--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_recurso_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_recurso_ime
 DESCRIPCION:   Transacciones IME para la tabla actividad
 AUTOR: 		aao
 FECHA:	        26-11-2012 16:47:00
 COMENTARIOS:	
***************************************************************************/

DECLARE

	v_parametros           	record;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;

	v_id_recurso			integer;
	v_recurso				varchar;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_recurso_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_RECACTI_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		aao
 	#FECHA:		26-11-2012 16:47:00
	***********************************/

	if(p_transaccion='GEM_RECACTI_INS')then
					
        begin
        	v_recurso=null;
        	if v_parametros.recurso in ('hotel','alimentacion','servicios_ott') then
        		v_recurso = v_parametros.recurso;
        	end if;
        	--Sentencia de la insercion
        	insert into gem.trecurso(
            id_usuario_reg,
            id_usuario_mod,
            fecha_reg,
            fecha_mod,
            estado_reg,
            id_item,
			     id_funcionario,
            id_especialidad,
            id_servicio,
            id_tarea,
            id_actividad,
            id_moneda,
            cantidad,
            costo,
            observaciones,
            id_unidad_medida,
            hh_normal,
            hh_extras,
            hh_ext_mov,
            codigo,
            existencias,
            concepto,
            id_orden_trabajo,
            hh_fer_dom
          	) values(
            p_id_usuario,
            null,
            now(),
            null,
            'activo',
            v_parametros.id_item,
            v_parametros.id_funcionario,
            v_parametros.id_especialidad,
            v_parametros.id_servicio,
            null,
            v_parametros.id_actividad,
            v_parametros.id_moneda,
            v_parametros.cantidad_recurso,
            v_parametros.costo,
            v_parametros.observaciones,
            v_parametros.id_unidad_medida,
            v_parametros.hh_normal,
            v_parametros.hh_extras,
            v_parametros.hh_ext_mov,
            v_parametros.codigo,
            v_parametros.existencias,
            v_recurso,
            v_parametros.id_orden_trabajo,
            v_parametros.hh_fer_dom
            )RETURNING id_recurso into v_id_recurso;
            
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Recurso almacenado con exito (id_recurso: '||v_id_recurso||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_recurso',v_id_recurso::varchar);
			
            --Devuelve la respuesta
            return v_resp;
		end;
	
	/*********************************    
 	#TRANSACCION:  'GEM_RECACTI_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		aao	
 	#FECHA:		19-11-2012 10:49:00
	***********************************/

	elsif(p_transaccion='GEM_RECACTI_MOD')then

		begin
			v_recurso=null;
        	if v_parametros.recurso in ('hotel','alimentacion') then
        		v_recurso = v_parametros.recurso;
        	end if;
        	
			--Sentencia de la modificacion
			update gem.trecurso set
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              id_item = v_parametros.id_item,
		          id_funcionario = v_parametros.id_funcionario,
              id_especialidad = v_parametros.id_especialidad,
              id_servicio = v_parametros.id_servicio,
              id_actividad = v_parametros.id_actividad,
              id_moneda = v_parametros.id_moneda,
              cantidad = v_parametros.cantidad_recurso,
              costo = v_parametros.costo,
              observaciones = v_parametros.observaciones,
              id_unidad_medida = v_parametros.id_unidad_medida,
              hh_normal = v_parametros.hh_normal,
              hh_extras = v_parametros.hh_extras,
              hh_ext_mov = v_parametros.hh_ext_mov,
              codigo = v_parametros.codigo,
              existencias = v_parametros.existencias,
              concepto = v_recurso,
              id_orden_trabajo = v_parametros.id_orden_trabajo,
              hh_fer_dom = v_parametros.hh_fer_dom
            where id_recurso = v_parametros.id_recurso;
            
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Recurso modificado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_recurso',v_parametros.id_recurso::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_RECACTI_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		aoo	
 	#FECHA:		26-11-2012 16:56:00
	***********************************/

	elsif(p_transaccion='GEM_RECURSO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.trecurso
            where id_recurso=v_parametros.id_recurso;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Recurso eliminado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_recurso',v_parametros.id_recurso::varchar);
              
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