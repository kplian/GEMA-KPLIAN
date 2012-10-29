CREATE OR REPLACE FUNCTION "gem"."ft_funcionario_honorario_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_funcionario_honorario_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tfuncionario_honorario'
 AUTOR: 		 (admin)
 FECHA:	        22-09-2012 01:44:56
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
	v_id_funcionario_honorario	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_funcionario_honorario_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEFUHO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-09-2012 01:44:56
	***********************************/

	if(p_transaccion='GEM_GEFUHO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tfuncionario_honorario(
			id_tipo_horario,
			id_funcionario,
			id_moneda,
			costo_hora,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_tipo_horario,
			v_parametros.id_funcionario,
			v_parametros.id_moneda,
			v_parametros.costo_hora,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_funcionario_honorario into v_id_funcionario_honorario;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Honorarios almacenado(a) con exito (id_funcionario_honorario'||v_id_funcionario_honorario||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_honorario',v_id_funcionario_honorario::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEFUHO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-09-2012 01:44:56
	***********************************/

	elsif(p_transaccion='GEM_GEFUHO_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tfuncionario_honorario set
			id_tipo_horario = v_parametros.id_tipo_horario,
			id_funcionario = v_parametros.id_funcionario,
			id_moneda = v_parametros.id_moneda,
			costo_hora = v_parametros.costo_hora,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_funcionario_honorario=v_parametros.id_funcionario_honorario;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Honorarios modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_honorario',v_parametros.id_funcionario_honorario::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEFUHO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-09-2012 01:44:56
	***********************************/

	elsif(p_transaccion='GEM_GEFUHO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tfuncionario_honorario
            where id_funcionario_honorario=v_parametros.id_funcionario_honorario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Honorarios eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_honorario',v_parametros.id_funcionario_honorario::varchar);
              
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
ALTER FUNCTION "gem"."ft_funcionario_honorario_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
