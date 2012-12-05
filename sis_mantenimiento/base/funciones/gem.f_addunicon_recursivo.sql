--------------- SQL ---------------

 -- object recreation
CREATE OR REPLACE FUNCTION gem.f_addunicon_recursivo (
  v_id_orig integer,
  v_id_cop integer,
  v_id_usuario integer,
  v_tipo_nodo varchar,
  v_codigo varchar
)
RETURNS boolean AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		gem.f_addunicon_recursivo
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
  1) listamos el regisotr con el v_id_orgi
  
  2) IF sy hay registros
     2.1) recorremso el listado
     2.2) insertamos el nuevo id con la llave forane de padre v_id_cop
     2.3) llamamos recursivamente a la funcion pxp.f_addunicon_recursivo con el nuevo 
          id_cop la insercions y el nuevo id_orgig
     
  
  3) retornamos TRUE

*/


DECLARE

g_registros                record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
v_id_uni_cons integer;

 v_id_uni_cons_comp integer;
 v_count  integer;
 v_resp_bool boolean;
 v_incluir_calgen boolean;


BEGIN

 -- 1) buscamos los hijos de  v_id_orgi
     
     v_count=0;
     
     select count(tuc.id_uni_cons)    
     into v_count
     from gem.tuni_cons tuc 
     inner join gem.tuni_cons_comp ucc  on ucc.id_uni_cons_hijo = tuc.id_uni_cons 
     where   ucc.id_uni_cons_padre = v_id_orig and tuc.estado_reg='activo';


  -- 2)IF  si hay registros 
       if(v_count >0)THEN 


 --    2.1) recorremso el listado      
      
      FOR g_registros in  (select  tuc.codigo,tuc.estado,
                                          tuc.id_tipo_equipo,tuc.nombre,tuc.tipo_nodo , tuc.id_uni_cons
                                 from gem.tuni_cons tuc 
                                 inner join gem.tuni_cons_comp ucc  on ucc.id_uni_cons_hijo = tuc.id_uni_cons 
                                 where   ucc.id_uni_cons_padre = v_id_orig and tuc.estado_reg='activo') LOOP
               

  --   2.2) insertamos el nuevo id con la llave forane de padre v_id_cop
        
   --Sentencia de la insercion
             if v_tipo_nodo = 'raiz' then
             -- revisame si el padre es raiz si es raiz el primer hijo se incluye en la generacion de calendario pro defecto
                v_incluir_calgen = true;
             else
                v_incluir_calgen = false;
             end if;
   
   
                insert into gem.tuni_cons(
                estado_reg,
                estado,
                nombre,
                tipo,
                codigo,
                id_tipo_equipo,
              
                id_usuario_reg,
                fecha_reg,
                
                tipo_nodo,
                incluir_calgen
                ) values(
                'activo',
               'registrado',
                upper(g_registros.nombre),
                'uc',
                v_codigo||'-'||upper(g_registros.codigo),
                g_registros.id_tipo_equipo,
                v_id_usuario,
                now(),
                'rama',
                v_incluir_calgen
                )RETURNING id_uni_cons into v_id_uni_cons;
            
   
   --inseta la relacion con el padre    
            insert into gem.tuni_cons_comp(
                        estado_reg,
                        opcional,
                        id_uni_cons_padre,
                        cantidad,
                        id_uni_cons_hijo,
                        id_usuario_reg,
                        fecha_reg,
                        id_usuario_mod,
                        fecha_mod
                        ) values(
                        'activo',
                        'no',
                        v_id_cop,  --padre
                        '1',
                        v_id_uni_cons,--hijo
                        v_id_usuario,
                        now(),
                        null,
                        null
                        )RETURNING id_uni_cons_comp into v_id_uni_cons_comp;     
                
                
  
  
 	 --   2.3) llamamos recursivamente a la funcion pxp.f_addunicon_recursivo con el nuevo 
  	 --         id_cop la insercions y el nuevo id_orgig
           
        v_resp_bool = gem.f_addunicon_recursivo(g_registros.id_uni_cons ,v_id_uni_cons,v_id_usuario,'rama', v_codigo||'-'||upper(g_registros.codigo));
      
      
      -- 2.4) llamada a la clonacion de datos
      
        v_resp_bool= gem.f_clon_unicons(g_registros.id_uni_cons ,v_id_uni_cons,v_id_usuario);
                         
                                  
      END LOOP;
 
 
  END IF;
  
  --3) retornamos TRUE

 RETURN TRUE;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION "gem"."f_addunicon_recursivo"(v_id_orig integer, v_id_cop integer, v_id_usuario integer, v_tipo_nodo varchar, v_codigo varchar)
  OWNER TO postgres;