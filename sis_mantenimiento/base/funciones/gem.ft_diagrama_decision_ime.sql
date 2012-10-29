CREATE OR REPLACE FUNCTION "gem"."ft_diagrama_decision_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_diagrama_decision_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tdiagrama_decision'
 AUTOR: 		 (admin)
 FECHA:	        02-10-2012 01:25:12
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
	v_id_diagrama_decision	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_diagrama_decision_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIDE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-10-2012 01:25:12
	***********************************/

	if(p_transaccion='GEM_GEDIDE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tdiagrama_decision(
			id_metodologia,
			codigo,
			nombre,
			fecha_desde_validez,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_metodologia,
			v_parametros.codigo,
			v_parametros.nombre,
			v_parametros.fecha_desde_validez,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_diagrama_decision into v_id_diagrama_decision;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Diagrama de Decisión almacenado(a) con exito (id_diagrama_decision'||v_id_diagrama_decision||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_diagrama_decision',v_id_diagrama_decision::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIDE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-10-2012 01:25:12
	***********************************/

	elsif(p_transaccion='GEM_GEDIDE_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tdiagrama_decision set
			id_metodologia = v_parametros.id_metodologia,
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			fecha_desde_validez = v_parametros.fecha_desde_validez,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_diagrama_decision=v_parametros.id_diagrama_decision;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Diagrama de Decisión modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_diagrama_decision',v_parametros.id_diagrama_decision::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIDE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-10-2012 01:25:12
	***********************************/

	elsif(p_transaccion='GEM_GEDIDE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tdiagrama_decision
            where id_diagrama_decision=v_parametros.id_diagrama_decision;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Diagrama de Decisión eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_diagrama_decision',v_parametros.id_diagrama_decision::varchar);
              
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
ALTER FUNCTION "gem"."ft_diagrama_decision_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
