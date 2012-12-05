--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_calendario_meses_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************

 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO

 FUNCION: 		gem.f_calendario_meses_det_sel

 DESCRIPCION:   	Función que devuelve los meses y semanas para el calendario

 AUTOR: 		 (rcm)

 FECHA:	        	03/11/2012

 COMENTARIOS:	

***************************************************************************

 HISTORIAL DE MODIFICACIONES:



 DESCRIPCION:	

 AUTOR:			

 FECHA:		

***************************************************************************/



DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
	v_where varchar;
	v_join varchar;
	v_fecha_ini date;
	v_fecha_fin date;
	v_cant_meses integer;
	v_i integer;
	v_fecha_aux date;
    v_tot_col integer;
    g_registros record;
    
    v_mes varchar;
    v_ano varchar;
    v_semana varchar;
    v_cod varchar;
    v_cod2 varchar;
    v_bool boolean;
    g_registros2 record;
    v_nombre_equipo text;
    v_codigo_equipo text;
    
    
    

BEGIN

    v_nombre_funcion = 'gem.f_calendario_meses_det_sel';
    
            
    v_parametros = pxp.f_get_record(p_tabla);
   
 

	/*********************************    
 	#TRANSACCION:  'GEM_CALMESDET_SEL'
 	#DESCRIPCION:	define las columnas de manrea dinamica del calendario planificado
 	#AUTOR:		rac	
 	#FECHA:		04/11/2012
	***********************************/

	if(p_transaccion='GEM_CALMESDET_SEL')then

	    begin	
        
       
     
        
        
         -- obtiene primer del mes correspondiente a la fecha_ini
                        
           v_fecha_ini= '01/'||to_char(v_parametros.fecha_ini, 'MM/yyyy');
        -- obtiene el ultimo dia del mes correspondiente a la fecha_fin
           v_fecha_fin=(date_trunc('MONTH', v_parametros.fecha_fin) + INTERVAL '1 MONTH - 1 day')::date;
                        
        

		--Validación de las fechas
		if v_fecha_ini > v_fecha_fin then
			raise exception 'La fecha final debe ser mayor o igual a la inicial';
		end if;
        
      
        --Creación de tabla temporal
		v_consulta = 'create temp table tt_calendario_meses_'||p_id_usuario||'(
			     id_sem_mes serial,
			     ano varchar,
                 mes varchar,
                 semana varchar,
                 codigo varchar
			)on commit drop';
        
         execute(v_consulta);
         
         
         
            v_fecha_aux = v_fecha_ini;
		    
            --for v_i in 0..v_cant_meses loop
             
            while v_fecha_aux < v_fecha_fin loop 
			
            v_mes = TRIM(to_char(v_fecha_aux, 'Month'));
            v_ano =  to_char(v_fecha_aux, 'YYYY');
            v_cod= lower( v_mes||'_'||v_ano);
            
            
            
            
            v_consulta = 'insert into  tt_calendario_meses_'||p_id_usuario||'(ano,mes,semana,codigo)
			                               values('''||v_ano||''','''||v_mes|| ''',''s1'','''||v_cod||'_s1'');';
			
            execute(v_consulta);
            
             v_consulta = 'insert into  tt_calendario_meses_'||p_id_usuario||'(ano,mes,semana,codigo)
			                               values('''||v_ano||''','''||v_mes|| ''',''s2'','''||v_cod||'_s2'');';
			
            execute(v_consulta);
            
            
            v_consulta = 'insert into  tt_calendario_meses_'||p_id_usuario||'(ano,mes,semana,codigo)
			                               values('''||v_ano||''','''||v_mes|| ''',''s3'','''||v_cod||'_s3'');';
			
            execute(v_consulta);
            
            v_consulta = 'insert into  tt_calendario_meses_'||p_id_usuario||'(ano,mes,semana,codigo)
			                               values('''||v_ano||''','''||v_mes|| ''',''s4'','''||v_cod||'_s4'');';
			
            execute(v_consulta);
            
            
			
            v_fecha_aux = v_fecha_aux + '1 month'::interval;
		    
            end loop;
         	
        v_consulta:='select
			          id_sem_mes,
			          ano,
                      mes,
                      semana,
                      codigo
			          from tt_calendario_meses_'||p_id_usuario;
				
		--Devuelve la respuesta
		return v_consulta;	
    
    

	    end;

 /*********************************    
      #TRANSACCION:  'GEM_PLANCALEQ_SEL'
      #DESCRIPCION:	  consulta de manera recursica el calendario de los equipos
                      para la localizacion indicada
      #AUTOR:		rac	
      #FECHA:		04/11/2012
      ***********************************/

	elseif(p_transaccion='GEM_PLANCALEQ_SEL')then

	    begin	
        
       
		
         -- obtiene primer del mes correspondiente a la fecha_ini
                        
           v_fecha_ini= '01/'||to_char(v_parametros.fecha_ini, 'MM/yyyy');
        -- obtiene el ultimo dia del mes correspondiente a la fecha_fin
           v_fecha_fin=(date_trunc('MONTH', v_parametros.fecha_fin) + INTERVAL '1 MONTH - 1 day')::date;
                        
                        
                        

		--Validación de las fechas
		if v_fecha_ini > v_fecha_fin then
			raise exception 'La fecha final debe ser mayor o igual a la inicial';
		end if;
        	
          --1) crear tabla temporal segun la fecha inicio y ficha final indicada
          
          v_consulta = 'create temp table tt_calendario_meses_'||p_id_usuario||'(
                        id_sem_mes serial,
                        id_uni_cons integer,
                        id_uni_cons_mant_predef integer,
                        nombre_uni_cons text,
                        nombre_mant varchar,
                        codigo_man  varchar,
                        codigo_equipo text
          ';  
          
         
            v_fecha_aux = v_fecha_ini;
		    
            --for v_i in 0..v_cant_meses loop
             
            while v_fecha_aux < v_fecha_fin loop 
			
            v_mes = TRIM(to_char(v_fecha_aux, 'Month'));
            v_ano =  to_char(v_fecha_aux, 'YYYY');
            v_cod= lower(v_mes||'_'||v_ano);
            
         /* v_consulta = 'insert into  tt_calendario_meses_'||p_id_usuario||'(ano,mes,semana,codigo)
			                               values('''||v_ano||''','''||v_mes|| ''',''s1'','''||v_cod||'_s1'');';*/
			
            --semana 1
            v_cod2=v_cod||'_s1';
            v_consulta =v_consulta||',  '||v_cod2||' varchar';
            v_consulta =v_consulta||',cp_'||v_cod2||' integer';
             --semana 2
            v_cod2=v_cod||'_s2';
            v_consulta =v_consulta||',  '||v_cod2||' varchar';
            v_consulta =v_consulta||',cp_'||v_cod2||' integer';
             --semana 3
            v_cod2=v_cod||'_s3';
            v_consulta =v_consulta||',  '||v_cod2||' varchar';
            v_consulta =v_consulta||',cp_'||v_cod2||' integer';
             --semana 4
            v_cod2=v_cod||'_s4';
            v_consulta =v_consulta||',  '||v_cod2||' varchar';
            v_consulta =v_consulta||',cp_'||v_cod2||' integer';
           
            
			
            v_fecha_aux = v_fecha_aux + '1 month'::interval;
		    
            end loop;
          
          --concatena el finald e la creacion 
           v_consulta =v_consulta||') on commit drop';
          
          --crea tabla
          
           raise notice '>>>>>>>>  CREA TABLA TEMPORAL,%',v_consulta;
           execute(v_consulta);
          
         
       --si es el nodo es de tipo localizacion
             
        if v_parametros.tipo_nodo <> 'uni_cons' and  v_parametros.tipo_nodo <> 'rama' THEN  
        
        raise notice '>>>>>>>>>>>>>  Lamada recursisa %', v_parametros.tipo_nodo;
         
          --2) consulta recusiva  de los equipos correspondientes a la localizacion
          
          v_consulta= 'WITH RECURSIVE sub_localizacion(id_localizacion, id_localizacion_fk, nombre) 
                          AS (
                              SELECT id_localizacion, id_localizacion_fk, nombre 
                              FROM gem.tlocalizacion WHERE id_localizacion =  '||v_parametros.id_localizacion||'
                                UNION ALL
                              SELECT l.id_localizacion, l.id_localizacion_fk, l.nombre
                              FROM sub_localizacion subl, gem.tlocalizacion l
                              WHERE l.id_localizacion_fk = subl.id_localizacion
                             )
                          
                           SELECT unicon.id_uni_cons FROM gem.tuni_cons unicon 
                                WHERE unicon.id_localizacion  IN ( SELECT id_localizacion FROM sub_localizacion) 
                           AND unicon.tipo_nodo = ''raiz'' and unicon.tipo = ''uc''';
          
          
          
                        FOR g_registros in  execute(v_consulta) LOOP
                                 
                                  --  2.1) llamada a la funcion para llenar la tabla temporal          
                                  v_consulta='WITH RECURSIVE arbol (id_uni_cons,id_uni_cons_padre, id_uni_cons_hijo, codigo, nombre, incluir_calgen) 
                                                      AS (  
                                                            select  uc.id_uni_cons, ucc.id_uni_cons_padre, ucc.id_uni_cons_hijo, uc.codigo::text , (uc.nombre)::text as nombre, uc.incluir_calgen

                                                            from gem.tuni_cons uc
                                                            LEFT join  gem.tuni_cons_comp ucc 
                                                                        on ucc.id_uni_cons_padre = uc.id_uni_cons
                                                            where    uc.id_uni_cons ='|| g_registros.id_uni_cons||'    
                                                               UNION ALL  
                                                            SELECT uc2.id_uni_cons, ucc2.id_uni_cons_padre, ucc2.id_uni_cons_hijo,(a.codigo||'',''||uc2.codigo)::text as codigo,(a.nombre||'',''||uc2.nombre)::text as nombre, uc2.incluir_calgen  
                                                            FROM arbol a 
                                                            INNER JOIN  gem.tuni_cons uc2   ON uc2.id_uni_cons = a.id_uni_cons_hijo
                                                            LEFT JOIN   gem.tuni_cons_comp ucc2 on ucc2.id_uni_cons_padre = uc2.id_uni_cons
                                                          )  
                                                       SELECT distinct id_uni_cons, codigo, nombre, incluir_calgen FROM arbol';
                         
                                         FOR g_registros2 in  execute( v_consulta ) LOOP
                         
                         
                        
                                                    v_bool = gem.f_llena_tt_calendario_equipo (
                                                                                g_registros2.id_uni_cons,
                                                                                v_fecha_ini,
                                                                                v_fecha_fin,
                                                                                p_id_usuario,
                                                                                g_registros2.codigo,
                                                                                g_registros2.nombre
                                                                              );
                                                                             
                                                                              
                                                    IF NOT v_bool THEN
                                                     raise exception 'error al generar calendario para %',g_registros2.id_uni_cons;
                                                    END IF;
                       
                       
                        END LOOP;
            
                   END LOOP;
         
        ELSEIF   v_parametros.tipo_nodo = 'uni_cons' THEN
         --busca en el primer nivel de la unidades raiz 
         
               v_consulta='WITH RECURSIVE arbol (id_uni_cons,id_uni_cons_padre, id_uni_cons_hijo, codigo, nombre, incluir_calgen) 
                                        AS (  
                                              select  uc.id_uni_cons, ucc.id_uni_cons_padre, ucc.id_uni_cons_hijo, uc.codigo::text ,uc.nombre::text, uc.incluir_calgen

                                              from gem.tuni_cons uc
                                              LEFT join  gem.tuni_cons_comp ucc 
                                                          on ucc.id_uni_cons_padre = uc.id_uni_cons
                                              where    uc.id_uni_cons ='|| v_parametros.id_uni_cons||'    
                                         		 UNION ALL  
                                              SELECT uc2.id_uni_cons, ucc2.id_uni_cons_padre, ucc2.id_uni_cons_hijo,(a.codigo||'',''||uc2.codigo)::text as codigo,(a.nombre||'',''||uc2.nombre)::text as nombre, uc2.incluir_calgen  
                                              FROM arbol a 
                                              INNER JOIN  gem.tuni_cons uc2   ON uc2.id_uni_cons = a.id_uni_cons_hijo
                                              LEFT JOIN   gem.tuni_cons_comp ucc2 on ucc2.id_uni_cons_padre = uc2.id_uni_cons
                                            )  
                                         SELECT distinct id_uni_cons, codigo, nombre, incluir_calgen FROM arbol';
           
           FOR g_registros in  execute( v_consulta ) LOOP
           
           
                                      v_bool = gem.f_llena_tt_calendario_equipo (
                                                                  g_registros.id_uni_cons,
                                                                  v_fecha_ini,
                                                                  v_fecha_fin,
                                                                  p_id_usuario,
                                                                  g_registros.codigo,
                                                                  g_registros.nombre
                                                                );
                                                                
                                      IF NOT v_bool THEN
                                       raise exception 'error al generar calendario para %',g_registros.id_uni_cons;
                                      END IF;
         
         
         
         
         
          END LOOP;
         
        
        
        
        ELSE
        
          --recuperar codigo y nombre de la uni_cons
          select uc.codigo::text, uc.nombre::text
             into v_codigo_equipo,v_nombre_equipo
               from gem.tuni_cons uc where uc.id_uni_cons = v_parametros.id_uni_cons;
           
        
         --  2.1) llamada a la funcion para llenar la tabla temporal          
                raise NOTICE '>>>> Lamada directa a genera calendario';   
                        
                           v_bool = gem.f_llena_tt_calendario_equipo (
                                      v_parametros.id_uni_cons,
                                      v_fecha_ini,
                                      v_fecha_fin,
                                      p_id_usuario,
                                      v_codigo_equipo,
                                      v_nombre_equipo
                                    );
                                    
                            IF NOT v_bool THEN
                       			raise exception 'error al generar calendario para %',g_registros.id_uni_cons;
                      		END IF;        
        
        END IF;
        
          
         --3) consulta de la tabla temporal
         
         v_consulta:='select  * from tt_calendario_meses_'||p_id_usuario||' where '||v_parametros.filtro;
		 v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

         raise notice '>>>>>>>>>>>>>      CONSULTA FINA %',v_consulta;
		--Devuelve la respuesta
		return v_consulta;	
         
         

		end;
    /*********************************    
      #TRANSACCION:  'GEM_PLANCALEQ_COUNT'
      #DESCRIPCION:	  Contadora para la consulta de  recursica del calendario de los equipos
                      para la localizacion indicada
      #AUTOR:		rac	
      #FECHA:		04/11/2012
      ***********************************/

	elseif(p_transaccion='GEM_PLANCALEQ_CONT')then

	    begin
        
         if v_parametros.tipo_nodo <> 'uni_cons' and  v_parametros.tipo_nodo <> 'rama' THEN  
        
        /*v_consulta= 'WITH RECURSIVE sub_localizacion(id_localizacion, id_localizacion_fk, nombre) 
                          AS (
                              SELECT id_localizacion, id_localizacion_fk, nombre 
                              FROM gem.tlocalizacion WHERE id_localizacion =  '||v_parametros.id_localizacion||'
                                UNION ALL
                              SELECT l.id_localizacion, l.id_localizacion_fk, l.nombre
                              FROM sub_localizacion subl, gem.tlocalizacion l
                              WHERE l.id_localizacion_fk = subl.id_localizacion
                             )
                          
                          SELECT count (man.id_uni_cons_mant_predef)*2*4 FROM gem.tuni_cons unicon 
                          INNER JOIN gem.tuni_cons_mant_predef man on man.id_uni_cons = unicon.id_uni_cons
                           inner join gem.tmant_predef mp on mp.id_mant_predef = man.id_mant_predef
                           WHERE unicon.id_localizacion 
                          IN ( SELECT id_localizacion FROM sub_localizacion ORDER BY id_localizacion) 
                          AND unicon.tipo_nodo = ''raiz'' and unicon.tipo = ''uc''   ';*/
                          
                      v_consulta= '     
                         SELECT count (man.id_uni_cons_mant_predef) FROM gem.tuni_cons unicon 
                          INNER JOIN gem.tuni_cons_mant_predef man on man.id_uni_cons = unicon.id_uni_cons
                           inner join gem.tmant_predef mp on mp.id_mant_predef = man.id_mant_predef
                           WHERE  unicon.tipo = ''uc'' ';
        
        
         ELSEIF  v_parametros.tipo_nodo = 'uni_cons' THEN  
         
         
             v_consulta='WITH RECURSIVE arbol (id_uni_cons,id_uni_cons_padre, id_uni_cons_hijo,  incluir_calgen) 
                                        AS (  
                                              select  uc.id_uni_cons, ucc.id_uni_cons_padre, ucc.id_uni_cons_hijo, uc.incluir_calgen

                                              from gem.tuni_cons uc
                                              LEFT join  gem.tuni_cons_comp ucc 
                                                          on ucc.id_uni_cons_padre = uc.id_uni_cons
                                              where    uc.id_uni_cons ='|| v_parametros.id_uni_cons||'    
                                         		 UNION ALL  
                                              SELECT uc2.id_uni_cons, ucc2.id_uni_cons_padre, ucc2.id_uni_cons_hijo, uc2.incluir_calgen  
                                              FROM arbol a 
                                              INNER JOIN  gem.tuni_cons uc2   ON uc2.id_uni_cons = a.id_uni_cons_hijo
                                              LEFT JOIN   gem.tuni_cons_comp ucc2 on ucc2.id_uni_cons_padre = uc2.id_uni_cons
                                            )  
                                         SELECT count(man.id_uni_cons_mant_predef) FROM arbol a  
                                         INNER JOIN gem.tuni_cons_mant_predef man on man.id_uni_cons = a.id_uni_cons
                                         inner join gem.tmant_predef mp on mp.id_mant_predef = man.id_mant_predef';
                                         
          
         ELSE
         
         
       
           
            v_consulta=' SELECT count (man.id_uni_cons_mant_predef) FROM gem.tuni_cons unicon 
                          INNER JOIN gem.tuni_cons_mant_predef man on man.id_uni_cons = unicon.id_uni_cons
                           inner join gem.tmant_predef mp on mp.id_mant_predef = man.id_mant_predef
                           WHERE   unicon.id_uni_cons='|| v_parametros.id_uni_cons;
         
         END IF;
        
            --Definicion de la respuesta		    
			

             raise notice '--> CONSULTA %',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
        
        end;	        

	else

					     

		raise exception 'Transaccion inexistente';

					         

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