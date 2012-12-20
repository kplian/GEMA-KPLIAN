CREATE OR REPLACE FUNCTION "kge"."ft_issue_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Kplian Gestión
 FUNCION: 		kge.ft_issue_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'kge.tissue'
 AUTOR: 		 (admin)
 FECHA:	        10-12-2012 19:16:36
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
	v_id_issue	integer;
			    
BEGIN

    v_nombre_funcion = 'kge.ft_issue_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'KG_ISSUE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-12-2012 19:16:36
	***********************************/

	if(p_transaccion='KG_ISSUE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into kge.tissue(
			titulo,
			creador,
			descripcion,
			nro_issue,
			milestone,
			developer,
			fecha_cierre,
			labels,
			fecha_act,
			estado_reg,
			estado,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod,
			tiempo_hrs,
			semana,
			prioridad
          	) values(
			v_parametros.titulo,
			v_parametros.creador,
			v_parametros.descripcion,
			v_parametros.nro_issue,
			v_parametros.milestone,
			v_parametros.developer,
			v_parametros.fecha_cierre,
			v_parametros.labels,
			v_parametros.fecha_act,
			'activo',
			v_parametros.estado,
			p_id_usuario,
			now(),
			null,
			null,
			v_parametros.tiempo_hrs,
			v_parametros.semana,
			v_parametros.prioridad
			)RETURNING id_issue into v_id_issue;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Issue almacenado(a) con exito (id_issue'||v_id_issue||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_issue',v_id_issue::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'KG_ISSUE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-12-2012 19:16:36
	***********************************/

	elsif(p_transaccion='KG_ISSUE_MOD')then

		begin
			--Sentencia de la modificacion
			update kge.tissue set
			titulo = v_parametros.titulo,
			creador = v_parametros.creador,
			descripcion = v_parametros.descripcion,
			nro_issue = v_parametros.nro_issue,
			milestone = v_parametros.milestone,
			developer = v_parametros.developer,
			fecha_cierre = v_parametros.fecha_cierre,
			labels = v_parametros.labels,
			fecha_act = v_parametros.fecha_act,
			estado = v_parametros.estado,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			tiempo_hrs = v_parametros.tiempo_hrs,
			semana = v_parametros.semana,
			prioridad = v_parametros.prioridad
			where id_issue=v_parametros.id_issue;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Issue modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_issue',v_parametros.id_issue::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'KG_ISSUE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-12-2012 19:16:36
	***********************************/

	elsif(p_transaccion='KG_ISSUE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from kge.tissue
            where id_issue=v_parametros.id_issue;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Issue eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_issue',v_parametros.id_issue::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
	/*********************************    
 	#TRANSACCION:  'KG_ISSUPD_DEL'
 	#DESCRIPCION:	Eliminación de los datos
 	#AUTOR:		admin	
 	#FECHA:		10-12-2012 19:16:36
	***********************************/

	elsif(p_transaccion='KG_ISSUPD_DEL')then
					
        begin
        
        	--Sentencia de la insercion
        	delete from kge.tissue;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Issues eliminados'); 

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
ALTER FUNCTION "kge"."ft_issue_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
