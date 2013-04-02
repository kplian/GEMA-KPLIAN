CREATE OR REPLACE FUNCTION "gem"."ft_tipo_equipo_col_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_tipo_equipo_col_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.ttipo_equipo_col'
 AUTOR: 		 (admin)
 FECHA:	        19-03-2013 11:20:37
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
	v_id_tipo_equipo_col	integer;
	v_id                 varchar;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_tipo_equipo_col_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_TEQCOL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 11:20:37
	***********************************/

	if(p_transaccion='GM_TEQCOL_INS')then
					
        begin
          
          if v_parametros.tipo_col = 'Variables' then
              v_id = v_parametros.id;
          else
              v_id = v_parametros.id_ficha;
          end if;
          
        	--Sentencia de la insercion
        	insert into gem.ttipo_equipo_col(
			estado_reg,
			id,
			id_tipo_equipo,
			tipo_col,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
			orden
          	) values(
			'activo',
			v_id,
			v_parametros.id_tipo_equipo,
			v_parametros.tipo_col,
			p_id_usuario,
			now(),
			null,
			null,
			v_parametros.orden	
			)RETURNING id_tipo_equipo_col into v_id_tipo_equipo_col;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Equipo - Columnas almacenado(a) con exito (id_tipo_equipo_col'||v_id_tipo_equipo_col||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_equipo_col',v_id_tipo_equipo_col::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_TEQCOL_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 11:20:37
	***********************************/

	elsif(p_transaccion='GM_TEQCOL_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.ttipo_equipo_col set
			id = v_parametros.id,
			id_tipo_equipo = v_parametros.id_tipo_equipo,
			tipo_col = v_parametros.tipo_col,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			orden = v_parametros.orden
			where id_tipo_equipo_col=v_parametros.id_tipo_equipo_col;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Equipo - Columnas modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_equipo_col',v_parametros.id_tipo_equipo_col::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_TEQCOL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 11:20:37
	***********************************/

	elsif(p_transaccion='GM_TEQCOL_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.ttipo_equipo_col
            where id_tipo_equipo_col=v_parametros.id_tipo_equipo_col;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Equipo - Columnas eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_equipo_col',v_parametros.id_tipo_equipo_col::varchar);
              
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
ALTER FUNCTION "gem"."ft_tipo_equipo_col_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
