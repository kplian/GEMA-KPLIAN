CREATE OR REPLACE FUNCTION gem.ft_plan_mant_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_plan_mant_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tplan_mant'
 AUTOR: 		 (rac)
 FECHA:	        12-10-2012 16:15:31
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
	v_id_plan_mant	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_plan_mant_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_PLAMA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		12-10-2012 16:15:31
	***********************************/

	if(p_transaccion='GEM_PLAMA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tplan_mant(
			id_funcionario,
			id_funcionario_rev,
			id_tipo_mant,
			id_uni_cons,
			descripcion,
			fecha,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_funcionario,
			v_parametros.id_funcionario_rev,
			v_parametros.id_tipo_mant,
			v_parametros.id_uni_cons,
			v_parametros.descripcion,
			v_parametros.fecha,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_plan_mant into v_id_plan_mant;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plan de Mantenimiento almacenado(a) con exito (id_plan_mant'||v_id_plan_mant||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plan_mant',v_id_plan_mant::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_PLAMA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		12-10-2012 16:15:31
	***********************************/

	elsif(p_transaccion='GEM_PLAMA_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tplan_mant set
			id_funcionario = v_parametros.id_funcionario,
			id_funcionario_rev = v_parametros.id_funcionario_rev,
			id_tipo_mant = v_parametros.id_tipo_mant,
			id_uni_cons = v_parametros.id_uni_cons,
			descripcion = v_parametros.descripcion,
			fecha = v_parametros.fecha,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_plan_mant=v_parametros.id_plan_mant;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plan de Mantenimiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plan_mant',v_parametros.id_plan_mant::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_PLAMA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		12-10-2012 16:15:31
	***********************************/

	elsif(p_transaccion='GEM_PLAMA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tplan_mant
            where id_plan_mant=v_parametros.id_plan_mant;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plan de Mantenimiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plan_mant',v_parametros.id_plan_mant::varchar);
              
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