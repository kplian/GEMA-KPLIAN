--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_verifica_calendario_equipo (
  v_id_uni_cons integer,
  v_fecha_ini date,
  v_fecha_fin date,
  v_id_usuario integer
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		gem.f_verifica_alendario_equipo
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
 
v_res varchar;


BEGIN

 --  0)   Verficar que la fecha inicio sea menor que la fecha fin
 
    if  v_fecha_fin  < v_fecha_ini then
    
    raise exception 'La fecha de inicio no puede ser menor a la fecha fin';
    
    end if;
    
    -- validamos si la misma unidad ya tiene registro con fecha superior a la fecha de inicia indicada
    -- si existen 
    
  -- retornamos el codigo de unidad para mostrar un error
    
  v_res = '';
    
    IF  exists (select 1  from gem.tcalendario_planificado c
                       where  c.id_uni_cons_mant_predef in ( Select id_uni_cons_mant_predef 
                                               from  gem.tuni_cons_mant_predef mt 
                                               where mt.id_uni_cons = v_id_uni_cons)
                        and c.fecha_ini >= v_fecha_ini 
                        and c.tipo = 'planificado') THEN
         
         
   
      select  (u.codigo||' '|| u.nombre)::varchar as nombres  into v_res 
      from gem.tuni_cons u 
      where u.id_uni_cons = v_id_uni_cons;
  
      
  
     END IF ;
 
 
 

   RETURN v_res;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;