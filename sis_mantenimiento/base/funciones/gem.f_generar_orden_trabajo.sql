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
                         man.id_unidad_medida,
                         man.tiempo_estimado,
                         man.id_unidad_medida_estimado,
                         man.horas_dia,
                         un.descripcion,
                         man.id_uni_cons,
                         man.id_mant_predef
                         
                      into 
                         v_id_uni_cons_mant_predef,
                         v_periodicidad,
                         v_id_unidad_medida_periodicidad,
                         v_tiempo_estimado,
                         v_id_unidad_medida_estimado,
                         v_horas_dia ,
                         v_desc_unidad_medida  ,
                         v_id_uni_cons,
                         v_id_mant_predef                
                         from gem.tuni_cons_mant_predef man 
                         inner join gem.tuni_cons uni on uni.id_uni_cons = man.id_uni_cons
                         inner join gem.tmant_predef mp on mp.id_mant_predef = man.id_mant_predef
                         inner join  param.tunidad_medida un  on un.id_unidad_medida = man.id_unidad_medida 
                         where   
                               man.id_uni_cons_mant_predef = v_parametros.id_uni_cons_mant_predef 
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
               
               
          
          IF v_fecha_inicial is not NULL THEN
                raise exception 'Exiten Mantenimeinto planificados en fecha anterior si Orden de Trabajo desde el %',v_fecha_inicial;
           END IF ;   
           
           
           
           --validar que no existan ordenes de trabajo en el periodo selecionado
                v_fecha_inicial = NULL;
              SELECT  cp.fecha_ini 
              into    v_fecha_inicial 
              from gem.tcalendario_planificado cp 
              WHERE    cp.id_uni_cons_mant_predef = v_id_uni_cons_mant_predef
                   and cp.fecha_ini >=  v_parametros.fecha_ini
                   and cp.fecha_ini <= v_parametros.fecha_fin
                   and cp.estado = 'orden_trabajo'
              ORDER BY cp.fecha_ini     
              LIMIT 1 OFFSET 0 ;
           
            IF v_fecha_inicial is not NULL THEN
                raise exception 'Exiten  alguna Orden de Trabajo desde el %',v_fecha_inicial;
            END IF ;   
           
           
         
         --2) obteine datos del mantenimiento apra realizar la insercion de las OT's
         
             --  *id_uni_cons  equipo                       <-v_parametros
             --  *equipo, codigo                            <- tuni_cons
             --  *planta , estacion						   <- tuni_cons
             --  localizacion                              <- recursicamente tuni_cons luego tlocalizacion
             --  *id_uni_cons_mant_predef                   
             --  fecha_ini  fecha de inicio planificada  <- tcalendario_planificado
             --  fecha_fin  fecha de finalizacion         <- tcalendario_planificado y tuni_cons_mante_predef
             --  *periodicidad y unidad de medida          <- tuni_cons_mant_predef
         
         
           select      un.id_uni_cons,un.codigo,        un.nombre,         un.tipo_unicons
                  into v_uni_cons,    v_codigo_uni_cons,v_nombre_uni_cons, v_tipo_planta_estacio   
           from gem.tuni_cons un 
           where un.id_uni_cons = v_id_uni_cons;
         
       
            
            -- obtiene localizacion recursivamente
            
            
         
          -- OBTENER LOS DATOS DE LOS DETALLES DE LAS ACTIVIDADES
         
             -- recuperar un registro  con los nomres y descripcion de  tmant_predef_det correspondientes al id_mant_predef
             --dentro de un array 
             v_cont_actividades = 0;
           FOR g_registros in (select  mp.nombre ,mp.descripcion    from gem.tmant_predef_det  mp 
                               where mp.id_mant_predef = v_id_mant_predef
                                     and mp.estado_reg='activo') LOOP
           
           
                  va_codigos_actividades = array_append( va_codigos_actividades,g_registros.nombre);
                  va_nombres_actividades = array_append( va_codigos_actividades,g_registros.descripcion);
                  v_cont_actividades=v_cont_actividades +1;
           
           END LOOP;
             
             
         
          --3)FOR listar todos lo calendarios ee estado generado entre las fechas senhaladas 
          
          FOR g_registros in ( SELECT  cp.fecha_ini, cp.id_alarma 
                                      from gem.tcalendario_planificado cp 
                              WHERE    	cp.id_uni_cons_mant_predef = v_id_uni_cons_mant_predef
                                      and cp.fecha_ini >=  v_parametros.fecha_ini 
                                      and cp.fecha_ini <= v_parametros.fecha_fin
                                      and cp.estado = 'generado'
                              ORDER BY cp.fecha_ini) LOOP
                    
          
          
                              
                              --calcular fecha de finalizacion de antenimietno
                              
                             /*
                               v_tiempo_estimado,
                               v_id_unidad_medida_estimado,
                               v_horas_dia 
                             
                             */ 
                            
                   
                             
                             
                             if (v_desc_unidad_medida= 'Hora' or v_desc_unidad_medida= 'mes') THEN
                             
                                   v_dias_dic =  round ( (v_tiempo_estimado / v_horas_dia) , 0 );  
                             
                             elseif (v_desc_unidad_medida= 'Dia' or v_desc_unidad_medida= 'dia') THEN
                             
                                   v_dias_dic =  round ((v_tiempo_estimado) * 1, 0 ); 
                         
                             elseif(v_desc_unidad_medida= 'Semana' or v_desc_unidad_medida= 'semana') then 
                             
                                   v_dias_dic =  round ((v_tiempo_estimado ) * 7, 0 ); 
                                   
                             elseif(v_desc_unidad_medida= 'Mes' or v_desc_unidad_medida= 'mes')then 
                             
                                   v_dias_dic =  round ((v_tiempo_estimado) * 30, 0 );     
                             
                              elseif(v_desc_unidad_medida in ('Año','ano','año','ano')) then 
                              --anho
                             
                                   v_dias_dic =  round ((v_tiempo_estimado) * 365, 0 );
                                   
                              else
                              raise exception 'Unidad no reconocida %', v_desc_unidad_medida;     
                             
                             end if;
                             
                             
                             v_fecha_fin = (g_registros.fecha_ini + CAST('+'||v_dias_dic||' days' as INTERVAL));
                              
                 -- 3.1)  crear una orden de trabajo para cada fecha del calendario_planificado
           
                            INSERT INTO gem.torden_trabajo
                              (
                                id_usuario_reg,
                                fecha_reg,
                                estado_reg,
                                id_uni_cons_mant_predef,
                                id_uni_cons,
                              
                                id_unidad_medida, -- periodicidad
                                fecha_plan_ini,
                                fecha_plan_fin,
                                periodicidad,
                                cat_estado
                              ) 
                              VALUES (
                                p_id_usuario,
                                now(),
                                'activo',
                                v_id_uni_cons_mant_predef,
                                v_id_uni_cons,
                                v_id_unidad_medida_periodicidad,
                                g_registros.fecha_ini,
                                v_fecha_fin,
                                v_periodicidad,
                                'generado'
                               
                              )RETURNING id_orden_trabajo   into v_id_orden_trabajo;
                            
                 -- 3.2) FOR recorrer array de actividaedes
                 --3.2.1 inserta las actividades del mantenimeinto
                 
                   v_i = 1;
                 
                   WHILE v_i <= v_cont_actividades LOOP
                   
               
      
                       INSERT INTO 
                            gem.tactividad
                          (
                            id_usuario_reg,
                            fecha_reg,
                            estado_reg,
                            id_orden_trabajo,
                            estado,             --pendiente
                            descripcion
                           
                          ) 
                          VALUES (
                             p_id_usuario,
                             now(),
                             'activo',
                             v_id_orden_trabajo,
                             'pendiente',
                             va_codigos_actividades[v_i]||' '||va_nombres_actividades[v_i]
                          );
                      v_i=v_i+1;
                   END LOOP; 
                 
                
            --eliminamos las alarmas si existen
            
            delete  from param.talarma a where  a.id_alarma = ANY (g_registros.id_alarma);
           
                 
         
          END LOOP;
          
          
          
          --4)  cambiar de estado todos los calendario planificados entre las fecha al estado = orden de trabajo
          UPDATE  gem.tcalendario_planificado SET
          		estado = 'orden_trabajo', 
                observaciones = (observaciones || ', orden de trabajo automatica el  '||now())::varchar
          WHERE    	id_uni_cons_mant_predef = v_id_uni_cons_mant_predef
                and fecha_ini >=  v_parametros.fecha_ini         
                and fecha_ini <= v_parametros.fecha_fin
                and estado = 'generado';
		
        
        
        --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Genera ordenes de trabajo para la uni_cons'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons',v_id_uni_cons::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'id_mant_predef',v_id_mant_predef::varchar);
               
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