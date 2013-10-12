CREATE OR REPLACE FUNCTION gem.ft_orden_trabajo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION:     gem.ft_orden_trabajo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.torden_trabajo'
 AUTOR:      (admin)
 FECHA:         30-08-2012 02:48:41
 COMENTARIOS: 
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/

DECLARE

  v_nro_requerimiento     integer;
  v_parametros            record;
  v_id_requerimiento      integer;
  v_resp                varchar;
  v_nombre_funcion        text;
  v_mensaje_error         text;
  v_id_orden_trabajo    integer;
  v_mensaje_estado    varchar;
  v_id_uni_cons       integer;
  v_fecha         date;
  v_nro         varchar;
  v_num_oit       varchar;
  v_rec_ot        record;
  v_observaciones     varchar;
  v_id_moneda		integer;
          
BEGIN

    v_nombre_funcion = 'gem.ft_orden_trabajo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'GEM_GEOOTT_INS'
  #DESCRIPCION: Insercion de registros
  #AUTOR:   admin 
  #FECHA:   30-08-2012 02:48:41
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
      --fecha_emision,
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
            otros,
            hora_eje_inicio,
            hora_eje_fin,
            descripcion_causa,
            prevension,
            descripcion_progresiva,
            id_cuenta,
            id_mant_predef,
            id_orden_trabajo_sol
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
      --now(),
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
            v_parametros.otros,
            v_parametros.hora_eje_inicio,
            v_parametros.hora_eje_fin,
            v_parametros.descripcion_causa,
            v_parametros.prevension,
            v_parametros.descripcion_progresiva,
            v_parametros.id_cuenta,
            v_parametros.id_mant_predef,
            v_parametros.id_orden_trabajo_sol
      )RETURNING id_orden_trabajo into v_id_orden_trabajo;
      
      --REgistra los items del mantenimiento selccionado
      if v_parametros.id_mant_predef is not null then
			if not exists(select 1 from gem.trecurso
						where id_orden_trabajo = v_id_orden_trabajo
						and id_item is not null) then
						
				v_id_moneda = param.f_get_moneda_base();
				insert into gem.trecurso(
				  id_usuario_reg,
				  fecha_reg,
				  estado_reg,
				  id_item,
				  id_moneda,
				  cantidad,
				  costo,
				  id_unidad_medida,
				  existencias,
				  id_orden_trabajo)
				select
				p_id_usuario,
				now(),
				'activo',
				mit.id_item,
				v_id_moneda,
				mit.cantidad_item,
				itm.precio_ref,
				itm.id_unidad_medida,
				'Si',
				v_id_orden_trabajo
				from gem.tmant_predef_item mit
				inner join alm.titem itm on itm.id_item = mit.id_item
				where mit.id_mant_predef = v_parametros.id_mant_predef;
			end if;
      end if;
               
      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo almacenado(a) con exito (id_orden_trabajo'||v_id_orden_trabajo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo',v_id_orden_trabajo::varchar);

            --Devuelve la respuesta
            return v_resp;

    end;

  /*********************************    
  #TRANSACCION:  'GEM_GEOOTT_MOD'
  #DESCRIPCION: Modificacion de registros
  #AUTOR:   admin 
  #FECHA:   30-08-2012 02:48:41
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
            otros = v_parametros.otros,
            hora_eje_inicio = v_parametros.hora_eje_inicio,
            hora_eje_fin = v_parametros.hora_eje_fin,
            descripcion_causa = v_parametros.descripcion_causa,
            prevension = v_parametros.prevension,
            descripcion_progresiva = v_parametros.descripcion_progresiva,
            id_cuenta = v_parametros.id_cuenta,
            id_mant_predef = v_parametros.id_mant_predef,
            id_orden_trabajo_sol = v_parametros.id_orden_trabajo_sol
      where id_orden_trabajo=v_parametros.id_orden_trabajo;
      
      --REgistra los items del mantenimiento selccionado
      if v_parametros.id_mant_predef is not null then
			if not exists(select 1 from gem.trecurso
						where id_orden_trabajo = v_id_orden_trabajo
						and id_item is not null) then
						
				v_id_moneda = param.f_get_moneda_base();
				insert into gem.trecurso(
				  id_usuario_reg,
				  fecha_reg,
				  estado_reg,
				  id_item,
				  id_moneda,
				  cantidad,
				  costo,
				  id_unidad_medida,
				  existencias,
				  id_orden_trabajo)
				select
				p_id_usuario,
				now(),
				'activo',
				mit.id_item,
				v_id_moneda,
				mit.cantidad_item,
				itm.precio_ref,
				itm.id_unidad_medida,
				'Si',
				v_parametros.id_orden_trabajo
				from gem.tmant_predef_item mit
				inner join alm.titem itm on itm.id_item = mit.id_item
				where mit.id_mant_predef = v_parametros.id_mant_predef;
			end if;
      end if;
            
      --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo',v_parametros.id_orden_trabajo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
    end;

  /*********************************    
  #TRANSACCION:  'GEM_GEOOTT_ELI'
  #DESCRIPCION: Eliminacion de registros
  #AUTOR:   admin 
  #FECHA:   30-08-2012 02:48:41
  ***********************************/

  elsif(p_transaccion='GEM_GEOOTT_ELI')then

    begin
      --Sentencia de la eliminacion
            update gem.torden_trabajo set
              estado_reg = 'inactivo'
            where id_orden_trabajo=v_parametros.id_orden_trabajo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo',v_parametros.id_orden_trabajo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

    end;

    /*********************************    
  #TRANSACCION:  'GEM_PROCESSOT_MOD'
  #DESCRIPCION: Cambio de estado OIT
  #AUTOR:   aao
  #FECHA:   05-12-2012 03:58:00
  ***********************************/

	elsif(p_transaccion='GEM_PROCESSOT_MOD')then

    	begin
        	--raise exception '%',v_parametros.cat_estado;
            v_mensaje_estado='';
          	if pxp.f_existe_parametro(p_tabla,'mensaje_estado') then
            	v_mensaje_estado = v_parametros.mensaje_estado;
            end if;
            
            --Obtención de datos de la orden de trabajo para validación previa al pasar de estado
            select
            *
            into v_rec_ot
            from gem.torden_trabajo
            where id_orden_trabajo = v_parametros.id_orden_trabajo;
            
            v_observaciones = '';
          	if v_parametros.cat_estado = 'Pendiente' then
            	--Verificación de datos completados
				if v_rec_ot.id_tipo_mant is null then
                	raise exception 'No es posible continuar porque no se ha definido el Tipo de Mantenimiento. Presione el botón Editar y complete los datos faltantes';
                end if;
                if v_rec_ot.cat_prior is null then
                	raise exception 'No es posible continuar porque no se ha definido la Prioridad. Presione el botón Editar y complete los datos faltantes';
                end if;
                if v_rec_ot.descripcion_lugar is null then
                	raise exception 'No es posible continuar porque no se ha definido el Sector. Presione el botón Editar y complete los datos faltantes';
                end if;
                if v_rec_ot.id_centro_costo is null then
                  	raise exception 'No es posible continuar porque no se ha definido la Cuenta. Presione el botón Editar y complete los datos faltantes';
                end if;
                if v_rec_ot.id_funcionario_sol is null then
                  	raise exception 'No es posible continuar porque no se ha definido al Solicitante. Presione el botón Editar y complete los datos faltantes';
                end if;
                if v_rec_ot.id_funcionario_asig is null then
                  	raise exception 'No es posible continuar porque no se ha definido al funcionario Asignado. Presione el botón Editar y complete los datos faltantes';
                end if;
      
                select id_uni_cons, num_oit
                into v_id_uni_cons, v_num_oit
                from gem.torden_trabajo
                where id_orden_trabajo = v_parametros.id_orden_trabajo;
                
                --Obtiene la fecha de emisión
                v_fecha = now();
                
                --Obtención del correlativo
                if coalesce(v_num_oit,'') = '' then
					--Obtención del correlativo
                    v_nro = gem.f_get_correlativo(v_id_uni_cons,'oit',v_fecha);
                  
                    update gem.torden_trabajo set
                    num_oit = v_nro
                    where id_orden_trabajo = v_parametros.id_orden_trabajo;
                else
                    --raise exception 'error: %',v_num_oit;
                end if;
                
                --Verifica el parámetro para saltar el estado de Apertura (estado Pendiente)
                if gem.f_verifica_parametro('abrir_ot','no_abrir') then
                    v_parametros.cat_estado = 'Abierto';
                end if;

                --Actualiza el estado
                update gem.torden_trabajo set
                cat_estado = v_parametros.cat_estado,
                id_usuario_mod = p_id_usuario,
                fecha_mod = v_fecha,
                mensaje_estado = v_mensaje_estado,
                fecha_emision = v_fecha
                where id_orden_trabajo = v_parametros.id_orden_trabajo;  
                
			elsif v_parametros.cat_estado = 'Cerrado' then
            	if not exists(select 1 from gem.trecurso rec
                            where rec.id_orden_trabajo = v_parametros.id_orden_trabajo) then
                	raise exception 'Para Cerrar la OIT previamente debe registrar los Recursos utilizados.';
                end if;
                
                --Verifica el parámetro para saltar el estado de Apertura (estado Pendiente) para habilitar el registro manual de la fecha de inicio y fin d ejecución
                if gem.f_verifica_parametro('abrir_ot','no_abrir') then
                    update gem.torden_trabajo set
                    cat_estado = v_parametros.cat_estado,
                    id_usuario_mod = p_id_usuario,
                    fecha_mod = now(),
                    mensaje_estado = v_mensaje_estado,
                    fecha_eje_ini = v_parametros.fecha_eje_ini,
                    fecha_eje_fin = v_parametros.fecha_eje_fin
                    where id_orden_trabajo = v_parametros.id_orden_trabajo;
                else
                    update gem.torden_trabajo set
                    cat_estado = v_parametros.cat_estado,
                    id_usuario_mod = p_id_usuario,
                    fecha_mod = now(),
                    mensaje_estado = v_mensaje_estado,
                    fecha_eje_fin = now()
                    where id_orden_trabajo = v_parametros.id_orden_trabajo;  
                end if;

            elsif v_parametros.cat_estado = 'Abierto' then
				update gem.torden_trabajo set
                cat_estado = v_parametros.cat_estado,
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                mensaje_estado = v_mensaje_estado,
                fecha_eje_ini = now()
                where id_orden_trabajo = v_parametros.id_orden_trabajo; 
            else
				--Sentencia de la actualización
                update gem.torden_trabajo set
                cat_estado = v_parametros.cat_estado,
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                mensaje_estado = v_mensaje_estado
                where id_orden_trabajo = v_parametros.id_orden_trabajo;    
            end if;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo Procesada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajo',v_parametros.id_orden_trabajo::varchar);
              
            --Devuelve la respuesta
            return v_resp;
    end;
        
      elsif(p_transaccion='GEM_PRECER_MOD')then

    begin
          
      --Sentencia de la eliminacion
      update gem.torden_trabajo set
      descripcion_causa = v_parametros.descripcion_causa,
            comentarios = v_parametros.comentarios,
            prevension = v_parametros.prevension,
            accidentes =v_parametros.accidentes,
            reclamos = v_parametros.reclamos,
            id_usuario_mod = p_id_usuario,
      fecha_mod = now()
            where id_orden_trabajo = v_parametros.id_orden_trabajo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Orden Interna de Trabajo Precerrada'); 
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