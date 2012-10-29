CREATE OR REPLACE FUNCTION "gem"."ft_orden_trabajo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_orden_trabajo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.torden_trabajo'
 AUTOR: 		 (admin)
 FECHA:	        30-08-2012 02:48:41
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
	v_id_orden_trabajo	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_orden_trabajo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEOOTT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-08-2012 02:48:41
	***********************************/

	if(p_transaccion='GEM_GEOOTT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.torden_trabajo(
			estado_reg,
			planta_estacion,
			fecha_plan_ini,
			fecha_eje_ini,
			periodicidad,
			num_oit,
			nota_tecnico_equipo,
			observacion,
			acumulado,
			codigo_oit,
			fecha_emision,
			id_funcionario_asig,
			id_unidad_medida,
			descripcion,
			id_funcionario_sol,
			prioridad,
			ubicacion_tecnica,
			fecha_eje_fin,
			id_uni_cons_mant_predef,
			id_tipo_mant,
			fecha_plan_fin,
			nota_tecnico_loc,
			id_uni_cons,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.planta_estacion,
			v_parametros.fecha_plan_ini,
			v_parametros.fecha_eje_ini,
			v_parametros.periodicidad,
			v_parametros.num_oit,
			v_parametros.nota_tecnico_equipo,
			v_parametros.observacion,
			v_parametros.acumulado,
			v_parametros.codigo_oit,
			v_parametros.fecha_emision,
			v_parametros.id_funcionario_asig,
			v_parametros.id_unidad_medida,
			v_parametros.descripcion,
			v_parametros.id_funcionario_sol,
			v_parametros.prioridad,
			v_parametros.ubicacion_tecnica,
			v_parametros.fecha_eje_fin,
			v_parametros.id_uni_cons_mant_predef,
			v_parametros.id_tipo_mant,
			v_parametros.fecha_plan_fin,
			v_parametros.nota_tecnico_loc,
			v_parametros.id_uni_cons,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_orden_trabajo into v_id_orden_trabajo;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo almacenado(a) con exito (id_orden_trabajo'||v_id_orden_trabajo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo',v_id_orden_trabajo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEOOTT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-08-2012 02:48:41
	***********************************/

	elsif(p_transaccion='GEM_GEOOTT_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.torden_trabajo set
			planta_estacion = v_parametros.planta_estacion,
			fecha_plan_ini = v_parametros.fecha_plan_ini,
			fecha_eje_ini = v_parametros.fecha_eje_ini,
			periodicidad = v_parametros.periodicidad,
			num_oit = v_parametros.num_oit,
			nota_tecnico_equipo = v_parametros.nota_tecnico_equipo,
			observacion = v_parametros.observacion,
			acumulado = v_parametros.acumulado,
			codigo_oit = v_parametros.codigo_oit,
			fecha_emision = v_parametros.fecha_emision,
			id_funcionario_asig = v_parametros.id_funcionario_asig,
			id_unidad_medida = v_parametros.id_unidad_medida,
			descripcion = v_parametros.descripcion,
			id_funcionario_sol = v_parametros.id_funcionario_sol,
			prioridad = v_parametros.prioridad,
			ubicacion_tecnica = v_parametros.ubicacion_tecnica,
			fecha_eje_fin = v_parametros.fecha_eje_fin,
			id_uni_cons_mant_predef = v_parametros.id_uni_cons_mant_predef,
			id_tipo_mant = v_parametros.id_tipo_mant,
			fecha_plan_fin = v_parametros.fecha_plan_fin,
			nota_tecnico_loc = v_parametros.nota_tecnico_loc,
			id_uni_cons = v_parametros.id_uni_cons,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_orden_trabajo=v_parametros.id_orden_trabajo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo',v_parametros.id_orden_trabajo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEOOTT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-08-2012 02:48:41
	***********************************/

	elsif(p_transaccion='GEM_GEOOTT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.torden_trabajo
            where id_orden_trabajo=v_parametros.id_orden_trabajo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo',v_parametros.id_orden_trabajo::varchar);
              
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
ALTER FUNCTION "gem"."ft_orden_trabajo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
