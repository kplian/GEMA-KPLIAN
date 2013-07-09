CREATE OR REPLACE FUNCTION gem.f_generar_orden_trabajo (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_generar_orden_trabajo
 DESCRIPCION:   Funcion para la generacion de ordnes de trabajo  apatir de calendario
 AUTOR: 		 (rac)
 FECHA:	        01-12-2012 03:48:41
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
	v_id_localizacion		integer;
    
    v_codigo_largo  		varchar;
    v_fecha_inicial 		date;
    v_id_uni_cons_mant_predef integer;
    v_periodicidad  		  numeric;
    v_id_unidad_medida_periodicidad 	integer;
    g_registros record;
    v_uni_cons 				integer;    
    v_codigo_uni_cons 		varchar;
    v_nombre_uni_cons 		varchar; 
    v_tipo_planta_estacio 	varchar;
    v_tiempo_estimado 		numeric;
    v_id_unidad_medida_estimado integer;
    va_codigos_actividades 		VARCHAR[];
    va_nombres_actividades 		VARCHAR[];
    v_cont_actividades 			integer;
    v_horas_dia 				integer;
    v_id_orden_trabajo 			integer;
    v_desc_unidad_medida varchar;
    v_dias_dic  integer;
    v_fecha_fin date;
    v_i integer;
    v_id_uni_cons integer;
    v_id_mant_predef integer;
    
    
			    
BEGIN

    v_nombre_funcion = 'gem.f_generar_orden_trabajo';
    v_parametros = pxp.f_get_record(p_tabla);
    
    
    
    
    /*********************************    
 	#TRANSACCION:  'GEM_GENALLOT_GEN'
 	#DESCRIPCION:	generacion recursiva de OT's apratir del arbol de localizaciones
 	#AUTOR:		rac	
 	#FECHA:		19-02-2013 03:48:41
	***********************************/

	if(p_transaccion='GEM_GENALLOT_GEN')then
    
    begin
 
      v_resp = gem.f_genera_ot_recursivo(p_id_usuario,
                                         v_parametros.id_localizacion, 
                                         v_parametros.id_uni_cons,
                                         v_parametros.tipo_nodo, 
                                         v_parametros.fecha_ini, 
                                         v_parametros.fecha_fin);
      
      IF v_resp != 'TRUE'  THEN
      
        raise exception 'Error al generar OTs';
      
      END IF;
      
       --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Genera ordenes de trabajo para la locaizacion o uni_cons'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons', COALESCE(v_parametros.id_uni_cons,0)::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'id_localizacion',  COALESCE(v_parametros.id_localizacion,0)::varchar);
               
            --Devuelve la respuesta
            return v_resp;
    
    
    end;
    

	/*********************************    
 	#TRANSACCION:  'GEM_GENEOT_GEN'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		14-06-2012 03:48:41
	***********************************/

	elseif(p_transaccion='GEM_GENEOT_GEN')then
					
        begin
        
        
         /*
         Calendario planificado 
            tipo  plannificado
            estado:   generado  -> orden_trabajo
         
         
         */
         
         v_resp =  gem.f_generar_orden_trabajo_v2( p_id_usuario, 
                                                  v_parametros.id_uni_cons_mant_predef ,  
                                                  v_parametros.fecha_ini, 
                                                  v_parametros.fecha_fin); 
         
         
         
      
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