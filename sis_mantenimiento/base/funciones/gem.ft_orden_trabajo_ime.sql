--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_orden_trabajo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
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
			fecha_plan_ini,
			fecha_eje_ini,
			tiempo_estimado,
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
			ubicacion_tecnica,
			fecha_eje_fin,
			id_uni_cons_mant_predef,
			id_tipo_mant,
			nota_tecnico_loc,
			id_uni_cons,
            cat_estado,
            cat_prior,
            cat_tipo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
            id_localizacion,
            descripcion_lugar,
            id_centro_costo,
            especialidades,
            id_funcionario_aprob,
            id_funcionario_recib,
            comentarios,
            accidentes,
            reclamos,
            otros
          	) values(
			'activo',
			v_parametros.fecha_plan_ini,
			v_parametros.fecha_eje_ini,
			v_parametros.tiempo_estimado,
			v_parametros.num_oit,
			v_parametros.nota_tecnico_equipo,
			v_parametros.observacion,
			v_parametros.acumulado,
			v_parametros.codigo_oit,
			now(),
			v_parametros.id_funcionario_asig,
			v_parametros.id_unidad_medida,
			v_parametros.descripcion,
			v_parametros.id_funcionario_sol,
			v_parametros.ubicacion_tecnica,
			v_parametros.fecha_eje_fin,
			v_parametros.id_uni_cons_mant_predef,
			v_parametros.id_tipo_mant,
			v_parametros.nota_tecnico_loc,
			v_parametros.id_uni_cons,
            v_parametros.cat_estado,
            v_parametros.cat_prior,
            v_parametros.cat_tipo,
			p_id_usuario,
			now(),
			null,
			null,
            v_parametros.id_localizacion,
            v_parametros.descripcion_lugar,
            v_parametros.id_centro_costo,
            v_parametros.especialidades,
            v_parametros.id_funcionario_aprob,
            v_parametros.id_funcionario_recib,
            v_parametros.comentarios,
            v_parametros.accidentes,
            v_parametros.reclamos,
            v_parametros.otros
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
			fecha_plan_ini = v_parametros.fecha_plan_ini,
			fecha_eje_ini = v_parametros.fecha_eje_ini,
			tiempo_estimado = v_parametros.tiempo_estimado,
			num_oit = v_parametros.num_oit,
			nota_tecnico_equipo = v_parametros.nota_tecnico_equipo,
			observacion = v_parametros.observacion,
			acumulado = v_parametros.acumulado,
			codigo_oit = v_parametros.codigo_oit,
			id_funcionario_asig = v_parametros.id_funcionario_asig,
			id_unidad_medida = v_parametros.id_unidad_medida,
			descripcion = v_parametros.descripcion,
			id_funcionario_sol = v_parametros.id_funcionario_sol,
			ubicacion_tecnica = v_parametros.ubicacion_tecnica,
			fecha_eje_fin = v_parametros.fecha_eje_fin,
			id_uni_cons_mant_predef = v_parametros.id_uni_cons_mant_predef,
			id_tipo_mant = v_parametros.id_tipo_mant,
			nota_tecnico_loc = v_parametros.nota_tecnico_loc,
			id_uni_cons = v_parametros.id_uni_cons,
			cat_estado = v_parametros.cat_estado,
            cat_prior = v_parametros.cat_prior,
            cat_tipo = v_parametros.cat_tipo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
            id_localizacion = v_parametros.id_localizacion,
            descripcion_lugar = v_parametros.descripcion_lugar,
            id_centro_costo = v_parametros.id_centro_costo,
            especialidades = v_parametros.especialidades,
            id_funcionario_aprob = v_parametros.id_funcionario_aprob,
            id_funcionario_recib = v_parametros.id_funcionario_recib,
            comentarios = v_parametros.comentarios,
            accidentes = v_parametros.accidentes,
            reclamos = v_parametros.reclamos,
            otros = v_parametros.otros
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

    /*********************************    
 	#TRANSACCION:  'GEM_PROCESSOT_MOD'
 	#DESCRIPCION:	Cambio de estado OIT
 	#AUTOR:		aao
 	#FECHA:		05-12-2012 03:58:00
	***********************************/

	elsif(p_transaccion='GEM_PROCESSOT_MOD')then

		begin
			--Sentencia de la eliminacion
			update gem.torden_trabajo set
			cat_estado = v_parametros.cat_estado,
            id_usuario_mod = p_id_usuario,
			fecha_mod = now()
            where id_orden_trabajo = v_parametros.id_orden_trabajo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo Procesada'); 
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;