CREATE OR REPLACE FUNCTION gem.ft_uni_cons_archivo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_uni_cons_archivo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons_archivo'
 AUTOR: 		 (rac)
 FECHA:	        26-10-2012 18:08:27
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
	v_id_uni_cons_archivo	integer;
    v_transferencia			record;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_uni_cons_archivo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_UNIDOC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		26-10-2012 18:08:27
	***********************************/

	if(p_transaccion='GEM_UNIDOC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons_archivo(
			resumen,
			palabras_clave,
			estado_reg,
			codigo,
			nombre,
			nombre_archivo,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.resumen,
			v_parametros.palabras_clave,
			'activo',
			v_parametros.codigo,
			v_parametros.nombre,
			v_parametros.nombre_archivo,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_uni_cons_archivo into v_id_uni_cons_archivo;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivos de Unidades Constructoras almacenado(a) con exito (id_uni_cons_archivo'||v_id_uni_cons_archivo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_archivo',v_id_uni_cons_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_UNIDOC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		26-10-2012 18:08:27
	***********************************/

	elsif(p_transaccion='GEM_UNIDOC_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons_archivo set
			resumen = v_parametros.resumen,
			palabras_clave = v_parametros.palabras_clave,
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			nombre_archivo = v_parametros.nombre_archivo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_uni_cons_archivo=v_parametros.id_uni_cons_archivo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivos de Unidades Constructoras modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_archivo',v_parametros.id_uni_cons_archivo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_UNIDOC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		26-10-2012 18:08:27
	***********************************/

	elsif(p_transaccion='GEM_UNIDOC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons_archivo
            where id_uni_cons_archivo=v_parametros.id_uni_cons_archivo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivos de Unidades Constructoras eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_archivo',v_parametros.id_uni_cons_archivo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    elsif(p_transaccion='GEM_UPARCH_MOD')then
     	begin
        	update gem.tuni_cons_archivo set
            archivo=v_parametros.archivo,
            extension=v_parametros.extension
            where id_uni_cons_archivo=v_parametros.id_uni_cons_archivo;
            
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo modificado con exito '||v_parametros.id_uni_cons_archivo); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_archivo',v_parametros.id_uni_cons_archivo::varchar);
             
             return v_resp;
        end;
     elsif(p_transaccion='GEM_UPARCHVER_MOD')then
     	begin
			select * into v_transferencia from gem.tuni_cons_archivo uniarc where uniarc.id_uni_cons_archivo=v_parametros.id_uni_cons_archivo;         	
            insert into gem.tuni_cons_archivo(
            id_uni_cons_archivo_padre, codigo,
            nombre, nombre_archivo,
            resumen, extension,
            palabras_clave, archivo,
            tipo,
            id_usuario_reg,
            fecha_reg,
            estado_reg
            )values(
            v_transferencia.id_uni_cons_archivo,
            v_transferencia.codigo,
            v_transferencia.nombre,
            v_transferencia.nombre_archivo,
            v_transferencia.resumen,
            v_transferencia.extension,
            v_transferencia.palabras_clave,
            v_transferencia.archivo,
            'hijo',            
            p_id_usuario,
            now(),
			'activo'
            );
            
            update gem.tuni_cons_archivo set
            extension=v_parametros.extension,
            archivo=v_parametros.archivo
            where id_uni_cons_archivo=v_parametros.id_uni_cons_archivo;
            
            v_resp=pxp.f_agrega_clave(v_resp,'mensaje','Archivo versionado con exito');
            v_resp=pxp.f_agrega_clave(v_resp,'id_uni_cons_archivo',v_parametros.id_uni_cons_archivo::varchar);
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