--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_genera_calendario_equipo (
  v_id_uni_cons integer,
  v_fecha_ini date,
  v_fecha_fin date,
  v_id_usuario integer
)
RETURNS boolean AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		gem.f_genera_calendario_equipo
 DESCRIPCIÓN: 	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			2012
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCIÓN:
 AUTOR:       
 FECHA:      

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

-- PARÁMETROS FIJOS
/*
pm_id_usuario                               integer (si))
pm_ip_origen                                varchar(40) (si)
pm_mac_maquina                              macaddr (si)
pm_log_error                                varchar -- log -- error //variable interna (si)
pm_codigo_procedimiento                     varchar  // valor que identifica el tipo
                                                        de operacion a realizar
                                                        insert  (insertar)
                                                        delete  (eliminar)
                                                        update  (actualizar)
                                                        select  (visualizar)
pm_proc_almacenado                          varchar  // para colocar el nombre del procedimiento en caso de ser llamado
                                                        por otro procedimiento
*/


/*
   0)   Verficar que la fecha inicio sea menor que la fecha fin
   1)  for listado de mantenimientos del equipo
   2)  calcular los dias de mantenimiento 
   
       -  obtener la id_unidad_medida
        
             horas
             dias
             semanas
             meses
     
       - con la frecuencia  y unidad   convertir a  la unidad de "dias" en la variable dias_dic
       
       
       - var fecha_dic = fecha_ini
       
       
       2.1) Mientras  fecha_dic <  fecha_fin
         
       2.1.1) inserta en calendario la fecha de mantenimiento
       2.1.2)  fecha_dic = fecha_dic + dias_dic

   

*/


DECLARE

g_registros                record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
v_id_uni_cons_comp integer;
v_count  integer;
 v_resp_bool boolean;
 v_dias_dic integer;
 v_fecha_dic date;
 


BEGIN

 --  0)   Verficar que la fecha inicio sea menor que la fecha fin
 
    if  v_fecha_fin  < v_fecha_ini then
    
    raise exception 'La fecha de inicio no puedo ser menor a la fecha fin';
    
    end if;
    
    -- validamos si la misma unidad ya tiene registro con fecha superior a la fecha de inicia indicada
    -- si existen los eliminamos
    
    
    delete from gem.tcalendario_planificado c
         where  c.id_uni_cons_mant_predef in ( Select id_uni_cons_mant_predef 
                                               from  gem.tuni_cons_mant_predef mt 
                                               where mt.id_uni_cons = v_id_uni_cons)
         and c.fecha_ini >= v_fecha_ini;
    
 
 
 --  1)  for listado de mantenimientos del equipo
 
   --raise exception 'LL %',v_id_uni_cons; 
 

   FOR g_registros in  (select  man.frecuencia, man.horas_dia, un.descripcion,man.id_uni_cons_mant_predef
                        from gem.tuni_cons_mant_predef man 
                        inner join  param.tunidad_medida un  on un.id_unidad_medida = man.id_unidad_medida 
                        where   man.id_uni_cons = v_id_uni_cons 
                        and man.estado_reg='activo') LOOP
 
 
     --  2)  calcular los dias de mantenimiento 
     
    
       
     --      -  obtener la id_unidad_medida ( horas,dias,semanas,meses)
          IF ( g_registros.descripcion not in ('Hora','Dia','Semana','Mes','Demana','Año)')) THEN
          
               raise exception 'No se permite la unid ad de frecuencia en % , solo son validos los valores: Hora,Dia,Semana, Mes, Año (Considerar mayusculas) ',g_registros.descripcion;
          
          
          END IF;
         
         
     --      - con la frecuencia  y unidad   convertir a  la unidad de "dias" en la variable dias_dic
     
     
     if (g_registros.descripcion= 'Hora') THEN
     
           v_dias_dic =  round ( (g_registros.frecuencia / g_registros.horas_dia) , 0 );  
     
     elseif(g_registros.descripcion= 'dia') THEN
     
           v_dias_dic =  round ((g_registros.frecuencia) * 1, 0 ); 
 
     elseif(g_registros.descripcion= 'semana') then 
     
           v_dias_dic =  round ((g_registros.frecuencia ) * 7, 0 ); 
           
     elseif(g_registros.descripcion= 'mes')then 
     
           v_dias_dic =  round ((g_registros.frecuencia) * 30, 0 );     
     
      else
      --anho
     
           v_dias_dic =  round ((g_registros.frecuencia) * 365, 0 ); 
     
     end if;
           
           
     --      var fecha_dic = fecha_ini
           
           v_fecha_dic = v_fecha_ini;
           
     --      2.1) Mientras  fecha_dic <  fecha_fin\\
     
    
     
      WHILE v_fecha_dic <= v_fecha_fin LOOP
      
     
      
               
    --       2.1.1) inserta en calendario la fecha de mantenimiento
                      INSERT INTO 
                    gem.tcalendario_planificado
                  (
                    id_usuario_reg,
                    estado_reg,
                    id_uni_cons_mant_predef,
                    fecha_ini,
                    estado,
                    tipo,
                    observaciones
                  ) 
                  VALUES (
                     v_id_usuario,
                    'activo',                   
                    g_registros.id_uni_cons_mant_predef,
                    v_fecha_dic,                    
                    'generado',
                    'planificado',
                    'autogenerado'
                  );
    
    
    --       2.1.2)  fecha_dic = fecha_dic + dias_dic
    
     
    
       v_fecha_dic=  (v_fecha_dic::date +  CAST(  v_dias_dic::varchar||' days' as INTERVAL));
      
      END LOOP;
    


END LOOP;

 RETURN TRUE;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;