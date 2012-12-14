--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_sinc_usuarios_uni_cons (
  par_id_localizacion integer,
  par_id_usuarios integer [] = '{}'::integer[]
)
RETURNS boolean AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		gem.f_sinc_usuarios_uni_cons
 DESCRIPCIÓN: 	esta funcion sincroniza los usuarios asignados a una lozalizacion de manera decendente con las uni_cons dependientes
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
 
  1) buscamos los hijos de la localizacion
  1.1) por cada hijo buscamos lo usuarios y lo adicionamos al vector de id_usuarios
  1.2) buscamos las uni_cons dependiente de cada localizacion hijo  y llamamos a la funcion de insertar usuarios
  1.3) llamada recursiva a esta funcion  

*/





DECLARE

g_registros                record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
g_reg_usu_loc   record;
g_reg_uni_loc   record;
v_usuarios_tmp integer[];
v_resp boolean;

BEGIN

 -- 1) buscamos los hijos de la localizacion

  FOR g_registros in (select id_localizacion from gem.tlocalizacion l 
                        where  l.id_localizacion_fk =  par_id_localizacion 
                              and l.estado_reg = 'activo'  ) LOOP
  
    --  1.1) por cada hijo buscamos lo usuarios y lo adicionamos al vector de id_usuarios
       v_usuarios_tmp= par_id_usuarios;
        
       FOR g_reg_usu_loc in ( select DISTINCT ul.id_usuario  
                              from gem.tlocalizacion_usuario ul 
                              where ul.id_localizacion = g_registros.id_localizacion 
                              and ul.estado_reg = 'activo') LOOP
       
       
       v_usuarios_tmp= array_append(v_usuarios_tmp, g_reg_usu_loc.id_usuario);
       END LOOP;
    
  --  1.2)  buscamos las uni_cons dependiente de cada localizacion hijo  y llamamos a la funcion de insertar usuarios
       
          -- o simple update
      
         update gem.tuni_cons set
         id_usuarios = v_usuarios_tmp
          where id_localizacion =g_registros.id_localizacion 
                               and tipo = 'uc' and tipo_nodo = 'raiz' and estado_reg='activo';
      
   
  --1.3) llamada recursiva a esta funcion 
  
    
      v_resp =   gem.f_sinc_usuarios_uni_cons( g_registros.id_localizacion ,v_usuarios_tmp);
     
     
       IF(not v_resp) THEN
         raise exception 'Falla al sincronizar usuarios';
       END IF;

 END LOOP;

 RETURN TRUE;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;