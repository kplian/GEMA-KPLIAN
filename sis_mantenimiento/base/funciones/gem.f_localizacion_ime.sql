CREATE OR REPLACE FUNCTION gem.f_localizacion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_localizacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tlocalizacion'
 AUTOR: 		 (rac)
 FECHA:	        14-06-2012 03:48:41
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
	v_id_localizacion	integer;
    
    v_codigo_largo  varchar;
			    
BEGIN

    v_nombre_funcion = 'gem.f_localizacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_loc_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		14-06-2012 03:48:41
	***********************************/

	if(p_transaccion='GEM_loc_INS')then
					
        begin
        /*
            --obtiene codigo recursivamente
            IF v_parametros.id_lugar_fk is null THEN
               v_codigo_largo = v_parametros.codigo;
            ELSE
            
             WITH RECURSIVE t(id,id_fk,cod,n) AS (
               SELECT l.id_localizacion,l.id_localizacion_fk, l.codigo,1 
               FROM gem.tlocalizacion l 
               WHERE l.id_localizacion = v_parametros.id_localizacion_fk
              UNION ALL
               SELECT l.id_localizacion,l.id_localizacion_fk, l.codigo , n+1
               FROM gem.tlocalizacion l, t
               WHERE l.id_localizacion = t.id_fk
            )
            SELECT textcat_all(a.cod||'.')
             into  
             v_codigo_largo
            FROM (SELECT  cod
                  FROM t 
                 order by n desc)  a;
                 
                 
               v_codigo_largo = v_codigo_largo||v_parametros.codigo;
            END IF;
            */
           
        	--Sentencia de la insercion
        	insert into gem.tlocalizacion(
			codigo,
			estado_reg,
			nombre,
			id_localizacion_fk,
			ubicacion,
			coordenadas,
			desc_ubicacion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
            latitud,
            longitud
          	) values(
			v_parametros.codigo,
			'activo',
			v_parametros.nombre,
			v_parametros.id_localizacion_fk,
			v_parametros.ubicacion,
			v_parametros.coordenadas,
			v_parametros.desc_ubicacion,
			p_id_usuario,
			now(),
			null,
			null,
            v_parametros.latitud,
            v_parametros.longitud
			)RETURNING id_localizacion into v_id_localizacion;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Localizacion almacenado(a) con exito (id_localizacion'||v_id_localizacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_localizacion',v_id_localizacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_loc_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		14-06-2012 03:48:41
	***********************************/

	elsif(p_transaccion='GEM_loc_MOD')then

		begin 
        
     --   raise exception   'XXX %',v_parametros.id_localizacion;
			--Sentencia de la modificacion
			update gem.tlocalizacion set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			ubicacion = v_parametros.ubicacion,
			coordenadas = v_parametros.coordenadas,
			desc_ubicacion = v_parametros.desc_ubicacion,
            latitud=v_parametros.latitud,
            longitud=v_parametros.longitud,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_localizacion=v_parametros.id_localizacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Localizacion modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_localizacion',v_parametros.id_localizacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_loc_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		14-06-2012 03:48:41
	***********************************/

	elsif(p_transaccion='GEM_loc_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tlocalizacion
            where id_localizacion=v_parametros.id_localizacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Localizacion eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_localizacion',v_parametros.id_localizacion::varchar);
              
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