CREATE OR REPLACE FUNCTION gem.ft_tarea_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_tarea_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.ttarea'
 AUTOR: 		 (rac)
 FECHA:	        17-10-2012 18:28:03
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
	v_id_tarea	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_tarea_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_TARE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		17-10-2012 18:28:03
	***********************************/

	if(p_transaccion='GEM_TARE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.ttarea(
			id_plan_mant,
			id_uni_cons,
			id_uni_cons_hijo,
			id_modo_falla,
			id_unidad_medida,
			tareas,
			col_hson3,
			col_h4,
			col_h,
			id_falla_evento,
			col_h5,
			col_n,
			col_hson2,
			estado_reg,
			frecuencia,
			id_especialidad,
			col_o,
			col_s,
			col_s4,
			col_hson1,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_plan_mant,
			v_parametros.id_uni_cons,
			v_parametros.id_uni_cons_hijo,
			v_parametros.id_modo_falla,
			v_parametros.id_unidad_medida,
			v_parametros.tareas,
			v_parametros.col_hson3,
			v_parametros.col_h4,
			v_parametros.col_h,
			v_parametros.id_falla_evento,
			v_parametros.col_h5,
			v_parametros.col_n,
			v_parametros.col_hson2,
			'activo',
			v_parametros.frecuencia,
			v_parametros.id_especialidad,
			v_parametros.col_o,
			v_parametros.col_s,
			v_parametros.col_s4,
			v_parametros.col_hson1,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_tarea into v_id_tarea;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tareas de mantenimiento almacenado(a) con exito (id_tarea'||v_id_tarea||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tarea',v_id_tarea::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TARE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		17-10-2012 18:28:03
	***********************************/

	elsif(p_transaccion='GEM_TARE_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.ttarea set
			id_plan_mant = v_parametros.id_plan_mant,
			id_uni_cons = v_parametros.id_uni_cons,
			id_uni_cons_hijo = v_parametros.id_uni_cons_hijo,
			id_modo_falla = v_parametros.id_modo_falla,
			id_unidad_medida = v_parametros.id_unidad_medida,
			tareas = v_parametros.tareas,
			col_hson3 = v_parametros.col_hson3,
			col_h4 = v_parametros.col_h4,
			col_h = v_parametros.col_h,
			id_falla_evento = v_parametros.id_falla_evento,
			col_h5 = v_parametros.col_h5,
			col_n = v_parametros.col_n,
			col_hson2 = v_parametros.col_hson2,
			frecuencia = v_parametros.frecuencia,
			id_especialidad = v_parametros.id_especialidad,
			col_o = v_parametros.col_o,
			col_s = v_parametros.col_s,
			col_s4 = v_parametros.col_s4,
			col_hson1 = v_parametros.col_hson1,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tarea=v_parametros.id_tarea;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tareas de mantenimiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tarea',v_parametros.id_tarea::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TARE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		17-10-2012 18:28:03
	***********************************/

	elsif(p_transaccion='GEM_TARE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.ttarea
            where id_tarea=v_parametros.id_tarea;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tareas de mantenimiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tarea',v_parametros.id_tarea::varchar);
              
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