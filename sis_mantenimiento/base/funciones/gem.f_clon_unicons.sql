--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_clon_unicons (
  v_id_orig integer,
  v_id_cop integer,
  v_id_usuario integer
)
RETURNS boolean AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		gem.f_clon_unicons
 DESCRIPCIÓN: 	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			09 11 2012
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
  1) listamos el regisotr con el v_id_orgi
  
  2) IF sy hay registros
     2.1) recorremso el listado
     2.2) insertamos el nuevo id con la llave forane de padre v_id_cop
     2.3) llamamos recursivamente a la funcion pxp.f_addunicon_recursivo con el nuevo 
          id_cop la insercions y el nuevo id_orgig
     
  
  3) retornamos TRUE

*/


DECLARE

g_registros record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
v_id_uni_cons integer;

v_id_uni_cons_comp integer;
v_count  integer;
 v_resp_bool boolean;



BEGIN

  --  1)  clonar   unicons det  
  
         -- FOR consultar
          FOR g_registros in  (
                          select  ucd.codigo,ucd.descripcion, 
                                  ucd.id_uni_cons, 
                                  ucd.id_unidad_medida,
                                  ucd.codigo,
                                  ucd.descripcion, 
                                  ucd.nombre, 
                                  ucd.valor
                          from gem.tuni_cons_det ucd 
                          where ucd.id_uni_cons = v_id_orig  
                          and ucd.estado_reg = 'activo') LOOP
         
          
                           INSERT INTO 
                                gem.tuni_cons_det
                              (
                                id_usuario_reg,
                                fecha_reg,
                                estado_reg,
                                id_unidad_medida,
                                id_uni_cons,
                                codigo,
                                nombre,
                                descripcion,
                                valor
                              ) 
                              VALUES (
                                v_id_usuario,
                                now(),
                                'activo',
                                 g_registros.id_unidad_medida,
                                v_id_cop,
                                g_registros.codigo,
                                g_registros.nombre,
                                g_registros.descripcion,
                                g_registros.valor
                              );
          
          
          
          END LOOP;
         
         
         --     insertar
  
  --  2)  clonar  equipo variable
        --FOR consultar
        --        insertar
        
              
        
           FOR g_registros in  ( select   ev.id_tipo_variable, ev.obs, ev.valor_max, ev.valor_min
        						 from gem.tequipo_variable ev
        						 where ev.id_uni_cons = v_id_orig  
           						 and ev.estado_reg = 'activo'
                          ) LOOP
         
                                INSERT INTO 
                        gem.tequipo_variable
                      (
                        id_usuario_reg,
                        fecha_reg,
                        estado_reg,
                        id_uni_cons,
                        id_tipo_variable,
                        obs,
                        valor_min,
                        valor_max
                      ) 
                      VALUES (
                         v_id_usuario,
                         now(),
                         'activo',
                        v_id_cop,
                        g_registros.id_tipo_variable,
                        g_registros.obs,
                        g_registros.valor_min,
                        g_registros.valor_max
                      );
          
          END LOOP;
 
 RETURN TRUE;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;