CREATE OR REPLACE FUNCTION gem.ft_uni_cons_item_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_uni_cons_item_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons_item'
 AUTOR: 		 (rac)
 FECHA:	        01-11-2012 11:53:15
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
	v_id_uni_cons_item	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_uni_cons_item_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_UNITEM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		01-11-2012 11:53:15
	***********************************/

	if(p_transaccion='GEM_UNITEM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons_item(
			estado_reg,
			id_uni_cons,
			id_item,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.estado_reg,
			v_parametros.id_uni_cons,
			v_parametros.id_item,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_uni_cons_item into v_id_uni_cons_item;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Items de la Unidad constructiva almacenado(a) con exito (id_uni_cons_item'||v_id_uni_cons_item||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_item',v_id_uni_cons_item::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_UNITEM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		01-11-2012 11:53:15
	***********************************/

	elsif(p_transaccion='GEM_UNITEM_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons_item set
			id_uni_cons = v_parametros.id_uni_cons,
			id_item = v_parametros.id_item,
            estado_reg = v_parametros.estado_reg,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_uni_cons_item=v_parametros.id_uni_cons_item;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Items de la Unidad constructiva modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_item',v_parametros.id_uni_cons_item::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_UNITEM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		01-11-2012 11:53:15
	***********************************/

	elsif(p_transaccion='GEM_UNITEM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons_item
            where id_uni_cons_item=v_parametros.id_uni_cons_item;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Items de la Unidad constructiva eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_item',v_parametros.id_uni_cons_item::varchar);
              
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