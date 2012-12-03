--------------- SQL ---------------

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
	v_id_localizacion	integer;
    
    v_codigo_largo  varchar;
    v_fecha_inicial date;
    v_id_uni_cons_mant_predef integer;
    v_periodicidad  numeric;
    v_id_unidad_medida_periodicidad integer;
    g_registros record;
    
    
			    
BEGIN

    v_nombre_funcion = 'gem.f_generar_orden_trabajo';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GENEOT_GEN'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		14-06-2012 03:48:41
	***********************************/

	if(p_transaccion='GEM_GENEOT_GEN')then
					
        begin
        
        
         /*
         Calendario planificado 
            tipo  plannificado
            estado:   generado  -> orden_trabajo
         
         
         */
         --0)obtener el tuni_cons_mant_predef
         
         select      
                         man.id_uni_cons_mant_predef,
                         man.frecuencia,
                         man.id_unidad_medida
                      into 
                         v_id_uni_cons_mant_predef,
                         v_periodicidad,
                         v_id_unidad_medida_periodicidad
                        
                         from gem.tuni_cons_mant_predef man 
                         inner join gem.tuni_cons uni on uni.id_uni_cons = man.id_uni_cons
                         inner join gem.tmant_predef mp on mp.id_mant_predef = man.id_mant_predef
                         where   
                               man.id_uni_cons = v_parametros.id_uni_cons 
                           and mp.id_mant_predef = v_parametros.id_mant_predef 
                           and man.estado_reg='activo';
         
       
          --1) validar que no existan  ordenes de trabajo con fecha anteriores para este mantenimento 
          --(calendario_planificado con estado generado)
          
          
          v_fecha_inicial = NULL;
          SELECT  cp.fecha_ini 
          into    v_fecha_inicial 
          from gem.tcalendario_planificado cp 
          WHERE    cp.id_uni_cons_mant_predef = v_id_uni_cons_mant_predef
               and cp.fecha_ini <  v_parametros.fecha_ini
               and cp.estado = 'generado'
          ORDER BY cp.fecha_ini     
          LIMIT 1 OFFSET 0 ;
               
               
          
          IF v_fecha_inicial is NULL THEN
                raise exception 'Exiten Mantenimeinto planificados en fecha anterior si Orden de Trabajo desde el %',v_fecha_inicial;
           END IF ;   
         
         --2) obteine datos del mantenimiento apra realizar la insercion de las OT's
         
             --  id_uni_cons  equipo                       <-v_parametros
             --  equipo, codigo                            <- tuni_cons
             --  planta , estacion						   <- tuni_cons
             --  localizacion                              <- recursicamente tuni_cons luego tlocalizacion
             --  id_uni_cons_mant_predef                   
             --  fecha_ini  fecha de iniciio planificada  <- tcalendario_planificado
             --  fecha_fin  fecha de finalizacion         <- tcalendario_planificado y tuni_cons_mante_predef
             --  periodicidad y unidad de medida          <- tuni_cons_mant_predef
         
         
          -- OBTENER LOS DATOS DE LOS DETALLES DE LAS ACTIVIDADES
         
         
         
          --3)FOR listar todos lo calendarios ee estado generado entre las fechas senhaladas 
          
          FOR g_registros in ( SELECT  cp.fecha_ini 
                                      from gem.tcalendario_planificado cp 
                              WHERE    	cp.id_uni_cons_mant_predef = v_id_uni_cons_mant_predef
                                      and cp.fecha_ini >=  v_parametros.fecha_ini 
                                      and cp.fecha_ini <= v_parametros.fecha_fin
                                      and cp.estado = 'generado'
                              ORDER BY cp.fecha_ini) LOOP
                              
                 -- 3.1)  crear una orden de trabajo para cada fecha del calendario_planificado
           
          
          
                 -- 3.2) copiar las actividades del mantenimeinto
         
         
          END LOOP;
          
          
          
          --4)  cambiar de estado todos los calendario planificados entre las fecha al estado = orden de trabajo
          
		
        
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