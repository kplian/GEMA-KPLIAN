--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_genera_ot_recursivo (
  p_id_usuario integer,
  p_id_localizacion integer,
  p_id_uni_cons integer,
  p_tipo_nodo varchar,
  p_fecha_ini date,
  p_fecha_fin date
)
RETURNS varchar AS
$body$
DECLARE
       v_consulta varchar;

       g_registros record;
       g_registros2 record;
       v_codigo_equipo varchar;
       v_nombre_equipo varchar;
       
       v_arr_id_uni_cons INTEGER[];
       v_cont integer;
       
       v_resp varchar;
       v_nombre_funcion varchar;

BEGIN
 
v_cont= 1;

v_nombre_funcion = 'f_genera_ot_recursivo';

if p_tipo_nodo <> 'uni_cons' and  p_tipo_nodo <> 'rama' THEN  
        
           raise notice '>>>>>>>>>>>>>  Llamada recursisa %', p_tipo_nodo;
         
          --2) consulta recusiva  de los equipos correspondientes a la localizacion
          
          v_consulta= 'WITH RECURSIVE sub_localizacion(id_localizacion, id_localizacion_fk, nombre) 
                          AS (
                              SELECT id_localizacion, id_localizacion_fk, nombre 
                              FROM gem.tlocalizacion WHERE id_localizacion =  '||p_id_localizacion||'
                                UNION ALL
                              SELECT l.id_localizacion, l.id_localizacion_fk, l.nombre
                              FROM sub_localizacion subl, gem.tlocalizacion l
                              WHERE l.id_localizacion_fk = subl.id_localizacion
                             )
                          
                           SELECT unicon.id_uni_cons FROM gem.tuni_cons unicon 
                                WHERE unicon.id_localizacion  IN ( SELECT id_localizacion FROM sub_localizacion) 
                           AND unicon.tipo_nodo = ''raiz'' and unicon.tipo = ''uc''  and unicon.estado_reg = ''activo'''; 
          
                    
          
                        FOR g_registros in  execute(v_consulta) LOOP
                                 
                                  --  2.1) consulta recursiva para unicons
                                  
                                      
                                  v_consulta='WITH RECURSIVE arbol (id_uni_cons,id_uni_cons_padre, id_uni_cons_hijo, codigo, nombre, incluir_calgen) 
                                                      AS (  
                                                            select  uc.id_uni_cons, 
                                                                    ucc.id_uni_cons_padre, 
                                                                    ucc.id_uni_cons_hijo, 
                                                                    uc.codigo::text , 
                                                                    (uc.nombre)::text as nombre, 
                                                                    uc.incluir_calgen

                                                            from gem.tuni_cons uc
                                                            LEFT join  gem.tuni_cons_comp ucc 
                                                                        on ucc.id_uni_cons_padre = uc.id_uni_cons
                                                            where    uc.id_uni_cons ='|| g_registros.id_uni_cons||' and uc.estado_reg = ''activo''   
                                                               UNION ALL  
                                                            SELECT uc2.id_uni_cons, ucc2.id_uni_cons_padre, ucc2.id_uni_cons_hijo,(a.codigo||'',''||uc2.codigo)::text as codigo,(a.nombre||'',''||uc2.nombre)::text as nombre, uc2.incluir_calgen  
                                                            FROM arbol a 
                                                            INNER JOIN  gem.tuni_cons uc2   ON uc2.id_uni_cons = a.id_uni_cons_hijo and uc2.estado_reg = ''activo''
                                                            LEFT JOIN   gem.tuni_cons_comp ucc2 on ucc2.id_uni_cons_padre = uc2.id_uni_cons
                                                          )  
                                                       SELECT distinct id_uni_cons, codigo, nombre, incluir_calgen FROM arbol';
                         
                                         FOR g_registros2 in  execute( v_consulta ) LOOP
                         
                                                   -- GENERAR OT   g_registros2.id_uni_cons
                                                   
                                                  
                                                  
                                                  v_arr_id_uni_cons[v_cont]=g_registros2.id_uni_cons;
                                                  v_cont = v_cont +1;
                        
                                         
                                         END LOOP;
            
                   END LOOP;
         
       

         ELSEIF   p_tipo_nodo = 'uni_cons' THEN
         --busca en el primer nivel de la unidades raiz 
         
               v_consulta='WITH RECURSIVE arbol (id_uni_cons, 
                                                 id_uni_cons_padre, 
                                                 id_uni_cons_hijo, 
                                                 codigo, 
                                                 nombre, 
                                                 incluir_calgen) 
                                        AS (  
                                              select  uc.id_uni_cons, ucc.id_uni_cons_padre, ucc.id_uni_cons_hijo, uc.codigo::text ,uc.nombre::text, uc.incluir_calgen

                                              from gem.tuni_cons uc
                                              LEFT join  gem.tuni_cons_comp ucc 
                                                          on ucc.id_uni_cons_padre = uc.id_uni_cons
                                              where    uc.id_uni_cons ='|| p_id_uni_cons||'  and uc.estado_reg = ''activo'' 
                                         		 UNION ALL  
                                              SELECT uc2.id_uni_cons, ucc2.id_uni_cons_padre, ucc2.id_uni_cons_hijo,(a.codigo||'',''||uc2.codigo)::text as codigo,(a.nombre||'',''||uc2.nombre)::text as nombre, uc2.incluir_calgen  
                                              FROM arbol a 
                                              INNER JOIN  gem.tuni_cons uc2   ON uc2.id_uni_cons = a.id_uni_cons_hijo and uc2.estado_reg = ''activo''
                                              LEFT JOIN   gem.tuni_cons_comp ucc2 on ucc2.id_uni_cons_padre = uc2.id_uni_cons
                                            )  
                                         SELECT distinct id_uni_cons, codigo, nombre, incluir_calgen FROM arbol';
           
           FOR g_registros in  execute( v_consulta ) LOOP
           
           
                      v_arr_id_uni_cons[v_cont]=g_registros.id_uni_cons;
                      v_cont = v_cont +1;
          END LOOP;
         
        
        
        
        ELSE
        
          --recuperar codigo y nombre de la uni_cons
          select uc.codigo::text, uc.nombre::text
             into v_codigo_equipo,v_nombre_equipo
               from gem.tuni_cons uc where uc.id_uni_cons = p_id_uni_cons;
           
        
         --  2.1) llamada a la funcion para llenar la tabla temporal          
                raise NOTICE '>>>> Lamada directa a genera calendario';  
                
                --generar OT
                  v_arr_id_uni_cons[v_cont]=g_registros2.id_uni_cons;
                  v_cont = v_cont +1;       
        
        END IF;


          --consulta mantenimientos predefinidos de unidades identificadas
          --segun consultas recursivas
            FOR g_registros in (  
                         select      
                             man.id_uni_cons_mant_predef
                         from gem.tuni_cons_mant_predef man 
                         where  
                               man.id_uni_cons = ANY (v_arr_id_uni_cons)
                               and man.estado_reg='activo') LOOP
                               
               -- llamada a la funcion para generar OT                 
           
           
                v_resp =  gem.f_generar_orden_trabajo_v2(
                                                        p_id_usuario, 
                                                        g_registros.id_uni_cons_mant_predef,  
                                                        p_fecha_ini, 
                                                        p_fecha_fin);
                 
           
           END LOOP;     
      
return 'TRUE';

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