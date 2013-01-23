CREATE OR REPLACE FUNCTION gem.ft_diagrama_decision_accion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de mantenimiento
 FUNCION: 		gem.tdiagrama_decision_accion
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'pre.tpartida'
 AUTOR: 		rcm
 FECHA:	        14-12-2012
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
	v_id_diagrama_decision_accion	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_diagrama_decision_accion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIAC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-12-2012
	***********************************/

	if(p_transaccion='GEM_GEDIAC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tdiagrama_decision_accion(
			estado_reg,
			id_diagrama_decision_accion_fk,
            id_diagrama_decision,
			tipo,
			nombre,
			codigo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_diagrama_decision_accion_fk,
            v_parametros.id_diagrama_decision,
			v_parametros.tipo,
			v_parametros.nombre,
			v_parametros.codigo,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_diagrama_decision_accion into v_id_diagrama_decision_accion;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Partida almacenado(a) con exito (id_diagrama_decision_accion'||v_id_diagrama_decision_accion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_partida',v_id_diagrama_decision_accion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIAC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rcm	
 	#FECHA:		14-12-2012
	***********************************/

	elsif(p_transaccion='GEM_GEDIAC_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tdiagrama_decision_accion set
			id_diagrama_decision_accion_fk = v_parametros.id_diagrama_decision_accion_fk,
			tipo = v_parametros.tipo,
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_diagrama_decision_accion=v_parametros.id_diagrama_decision_accion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_partida',v_parametros.id_diagrama_decision_accion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIAC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-12-2012
	***********************************/

	elsif(p_transaccion='GEM_GEDIAC_ELI') then
		begin
			--Sentencia de la eliminacion
			delete from gem.tdiagrama_decision_accion
            where id_diagrama_decision_accion=v_parametros.id_diagrama_decision_accion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_diagrama_decision_accion',v_parametros.id_diagrama_decision_accion::varchar);
              
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