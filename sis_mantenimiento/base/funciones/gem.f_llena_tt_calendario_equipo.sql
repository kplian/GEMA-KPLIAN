--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_llena_tt_calendario_equipo (
  v_id_uni_cons integer,
  v_fecha_ini date,
  v_fecha_fin date,
  v_id_usuario integer,
  v_codigo text,
  v_nombre text
)
RETURNS boolean AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		gem.f_llena_tt_calendario_equipo
 DESCRIPCIÓN: 	llena la tabla temporal con los datos del equipo
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			4 de noviembre de 2012
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
            
   
   1)   for listado de mantenimientos del equipo indicado
   
   1.0)  (atributos) arma primera parte de la cadena de insercion con datos del equipo y del mantenimiento
         (valores)   arma la cadena de insercion de valores
         
         
               
   1.1)    for listados de los calendarios agendados para ese equipo entre fecha_ini y fecha_fin
   1.1.1)     --ubica la semana correspondiente 
                --obtiene el dia del mes
                
                if     dia_mes % 7 == 0  o  dia_mes > 28 entonces v_sum = 0
                else   v_sum =1
                
                v_semana =  (dia_mes / 7) + v_sum
                
   1.1.2)   arma cadena de insercion de atributos (col_semana)
            arma cadena de insercion de valroes   (valor col_semana)
            arma cadena de insercion de atributos (id col_semana)
            arma cadena de insercion de valroes   (valor id col_semana)
            
   1.2   finaliza la cadena de insercion
   1.3   ejecuta la cadena de insercion
   
   2. retorna TRUE
   

*/


DECLARE

g_registros                record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
g_registros2               record;
v_id_uni_cons_comp integer;
v_count  integer;
 v_resp_bool boolean;
 v_dias_dic integer;
 v_fecha_dic date;
 
 
 v_consulta1 varchar;
 v_consulta2 varchar;
 
 v_dia integer;
 v_mes varchar;
 v_ano varchar;
 v_cod varchar;
 V_semana integer;
 v_sum integer;
 
 v_pos integer;
 


BEGIN
   --0)   Verficar que la fecha inicio sea menor que la fecha fin
       
   
 
    if  v_fecha_fin  < v_fecha_ini then
    
    raise exception 'La fecha de inicio no puedo ser menor a la fecha fin';
    
    end if;     
   
   --1)   for listado de los mantenimientos correspondientes al equipo indicado
   
    FOR g_registros in  (select  man.frecuencia, 
                         man.horas_dia, 
                         man.id_uni_cons_mant_predef,
                         uni.id_uni_cons, 
                         uni.codigo,
                         man.id_mant_predef,
                         mp.codigo as codigo_man,
                         uni.nombre as nombre_equipo,
                         mp.nombre
                         from gem.tuni_cons_mant_predef man 
                         inner join gem.tuni_cons uni on uni.id_uni_cons = man.id_uni_cons
                         inner join gem.tmant_predef mp on mp.id_mant_predef = man.id_mant_predef
                         where   man.id_uni_cons = v_id_uni_cons 
                         and man.estado_reg='activo') LOOP
   
   
   --1.0.A)  (atributos) arma primera parte de la cadena de insercion con datos del equipo y del mantenimiento
     
               
            v_consulta1= 'INSERT into tt_calendario_meses_'||v_id_usuario||'( id_uni_cons ,
                                                       id_uni_cons_mant_predef ,
                                                       nombre_uni_cons ,
                                                       nombre_mant ,
                                                       codigo_man,
                                                       codigo_equipo  ';
                                                       
 -- 1.0.B)  (valores)   arma la cadena de insercion de valores 
         
         
            v_consulta2= ') values('||g_registros.id_uni_cons||','||g_registros.id_uni_cons_mant_predef||','''||v_nombre||''','''||g_registros.nombre||''','''||g_registros.codigo_man||''','''||v_codigo||'''';                  
                                                                              
                                                       
   
    
               
   --1.1)    for listados de los calendarios agendados para ese equipo entre fecha_ini y fecha_fin
               
               
   
   
             FOR g_registros2 in  (select cp.fecha_ini,cp.id_calendario_planificado,cp.estado
                                   from gem.tcalendario_planificado cp 
                                   where cp.fecha_ini >= v_fecha_ini and cp.fecha_ini <= v_fecha_fin 
                                   and cp.tipo = 'planificado'
                                   and cp.id_uni_cons_mant_predef = g_registros.id_uni_cons_mant_predef ) LOOP
   
   
             
             --1.1.1)     --ubica la semana correspondiente 
                          --obtiene el dia del mes
                          
                          raise notice 'LLEGA DIA - SEMANA';
                         v_dia = (to_char(g_registros2.fecha_ini, 'dd'))::integer;
                          
                          --if     dia_mes % 7 == 0  o  dia_mes > 28 entonces v_sum = 0
                          --else   v_sum =1
                          
                          if( ( v_dia% 7) = 0  or v_dia > 28) THEN
                          
                            v_sum =0;
                          
                          ELSE
                            v_sum = 1;
                          
                          END IF;
                          --v_semana =  (dia_mes / 7) + v_sum
                          
                          v_semana = (v_dia /7) +v_sum;
                          
                          raise notice ' -------->  SEMANA %',v_semana;
                          
             --1.1.2)   arma cadena de insercion de atributos (col_semana) 
              --         arma cadena de insercion de atributos (id col_semana)             
             v_mes = TRIM(to_char(g_registros2.fecha_ini, 'Month'));
             v_ano =  to_char(g_registros2.fecha_ini, 'YYYY');
            
               v_cod = lower(v_mes||'_'||v_ano||'_s'||v_semana);
               
               -- 1.1.4)  VERIFICA QUE NO EXISTA DUPLIDICAD
               v_pos = position (v_cod in v_consulta1);
               
               
               if(v_pos = 0) then
               
               --1.1.4.1)   arma cadena de insercion de atributos (col_semana) 
               --         arma cadena de insercion de atributos (id col_semana) 
               
                v_consulta1=v_consulta1||','||v_cod||', cp_'||v_cod ;
                
                --         arma cadena de insercion de valroes   (valor col_semana)
                --         arma cadena de insercion de valroes   (valor id col_semana)
                
                --segun el estado cambia de color la bola que se muestra en la grilla
                    IF(g_registros2.estado = 'orden_trabajo') THEN
                   		 v_consulta2=v_consulta2||(',''2'',')::varchar||g_registros2.id_calendario_planificado;
                    ELSEIF(g_registros2.estado = 'ejecutado') THEN
                    	v_consulta2=v_consulta2||(',''3'',')::varchar||g_registros2.id_calendario_planificado;
                    ELSE
                    	v_consulta2=v_consulta2||(',''1'',')::varchar||g_registros2.id_calendario_planificado;
                    END IF;
                end IF;
               
             
   
   
         
          END LOOP; --FIN DEL SEGUNDO FOR
          
         
         
   --1.2   finaliza la cadena de insercion
   
    v_consulta1 = v_consulta1||v_consulta2|| ') ';
   
   --1.3   ejecuta la cadena de insercion
   
   raise notice 'INSERCION %',v_consulta1;
   
    execute(v_consulta1);
          
    raise notice '===> DA LA VUELTA';
   END LOOP;--FIN DEL PRIMER FOOR
   
   
   
   --2. retorna TRUE


     RETURN TRUE;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;