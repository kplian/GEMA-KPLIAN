CREATE OR REPLACE FUNCTION pre.ft_presup_partida_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de presupuesto
 FUNCION: 		pre.ft_presup_partida_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'pre.tpresup_partida'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        26-11-2012 22:02:47
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
	v_id_presup_partida	integer;
			    
BEGIN

    v_nombre_funcion = 'pre.ft_presup_partida_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PRE_PREPAR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-11-2012 22:02:47
	***********************************/

	if(p_transaccion='PRE_PREPAR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into pre.tpresup_partida(
			estado_reg,
			tipo,
			id_centro_costo,
			id_presupuesto,
			id_partida,
			fecha_hora,
			id_moneda,
			importe,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.tipo,
			v_parametros.id_centro_costo,
			v_parametros.id_presupuesto,
			v_parametros.id_partida,
			v_parametros.fecha_hora,
			v_parametros.id_moneda,
			v_parametros.importe,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_presup_partida into v_id_presup_partida;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PresupPartida almacenado(a) con exito (id_presup_partida'||v_id_presup_partida||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presup_partida',v_id_presup_partida::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PRE_PREPAR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-11-2012 22:02:47
	***********************************/

	elsif(p_transaccion='PRE_PREPAR_MOD')then

		begin
			--Sentencia de la modificacion
			update pre.tpresup_partida set
			tipo = v_parametros.tipo,
			id_centro_costo = v_parametros.id_centro_costo,
			id_presupuesto = v_parametros.id_presupuesto,
			id_partida = v_parametros.id_partida,
			fecha_hora = v_parametros.fecha_hora,
			id_moneda = v_parametros.id_moneda,
			importe = v_parametros.importe,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_presup_partida=v_parametros.id_presup_partida;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PresupPartida modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presup_partida',v_parametros.id_presup_partida::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PRE_PREPAR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-11-2012 22:02:47
	***********************************/

	elsif(p_transaccion='PRE_PREPAR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from pre.tpresup_partida
            where id_presup_partida=v_parametros.id_presup_partida;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PresupPartida eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presup_partida',v_parametros.id_presup_partida::varchar);
              
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