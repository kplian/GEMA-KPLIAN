CREATE OR REPLACE FUNCTION gem.f_genera_calendario_equipo (
  p_id_uni_cons integer,
  p_fecha_fin date,
  p_id_usuario integer
)
RETURNS boolean AS
$body$
/**************************************************************************
 SISTEMA PXP
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

    g_registros record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
    v_id_uni_cons_comp integer;
    v_count  integer;
    v_resp_bool boolean;
    v_dias_dic integer;
    v_fecha_dic date;
    v_fecha_ot date;
 
 BEGIN


 --  0)   Verficar que la fecha inicio sea menor que la fecha fin
 
     /*
     
     lo comentamos por que ya no tendremos el dato de fecha inicion como parametro
     if    < v_fecha_ini then
    	raise exception 'La fecha de inicio no puedo ser menor a la fecha fin';
     end if;
     
     
     
    
    -- validamos si la misma unidad ya tiene registro con fecha superior a la fecha de inicia indicada
    -- si existen los eliminamos
    
     delete from gem.tcalendario_planificado c
         where  c.id_uni_cons_mant_predef in ( Select id_uni_cons_mant_predef 
                                               from  gem.tuni_cons_mant_predef mt 
                                               where mt.id_uni_cons = v_id_uni_cons )
           and c.fecha_ini >= v_fecha_ini 
           and c.tipo = 'planificado' 
           and c.estado = 'generado';
    
    */
   
 
  --si el equipo esta marcod para no entra a generacion retorna directamente TRUE
  SELECT 
     uc2.incluir_calgen 
     into
     g_registros 
     FROM gem.tuni_cons uc2    
     WHERE uc2.id_uni_cons = p_id_uni_cons;
     
     IF not  g_registros.incluir_calgen  THEN
       RETURN TRUE;
     END IF;
     
     
 	----------------
    -- (1)GENERACION DEL CALENDARIO
    ----------------
 
 --  1)  for listado de mantenimientos del equipo
 
	FOR g_registros in (select man.id_uni_cons_mant_predef, 
                               man.frecuencia, 
                               ucons.horas_dia, 
                               un.descripcion,
                               man.id_uni_cons_mant_predef,
                               man.fecha_ini
                        from gem.tuni_cons_mant_predef man 
                        inner join  param.tunidad_medida un  on un.id_unidad_medida = man.id_unidad_medida 
                        inner join gem.tuni_cons ucons on ucons.id_uni_cons = p_id_uni_cons
                        where man.id_uni_cons = p_id_uni_cons 
                        and man.estado_reg='activo') LOOP

		--  2)  calcular los dias de mantenimiento 
		IF ( g_registros.descripcion not in ('Hora','Dia','Semana','Mes','Semana','Año','hora','dia','semana','mes','semana','año')) THEN
               raise exception 'No se permite la unidad de frecuencia en % , solo son validos los valores: Hora, Dia, Semana, Mes, Año (Considerar mayusculas) ',g_registros.descripcion;
		END IF;
         
     	-- con la frecuencia  y unidad   convertir a  la unidad de "dias" en la variable dias_dic
		if (g_registros.descripcion= 'Hora' or g_registros.descripcion= 'hora') THEN
			v_dias_dic =  round ( (g_registros.frecuencia / g_registros.horas_dia) , 0 );  
		elseif(g_registros.descripcion= 'Dia' or g_registros.descripcion= 'dia') THEN
           v_dias_dic =  round ((g_registros.frecuencia) * 1, 0 ); 
	    elseif(g_registros.descripcion= 'Semana' or g_registros.descripcion= 'semana') then 
			v_dias_dic =  round ((g_registros.frecuencia ) * 7, 0 ); 
		elseif(g_registros.descripcion= 'Mes' or g_registros.descripcion= 'mes')then
			--TODO (RCM 14/06/2013): se cambia el 30 por 32 días para que cuando se planifique mensual no toque mas de un mantenimiento por mes.
			--Más adelante podría calcularse la cantidad de días por mes para no considerar siempre una cantidad constante. 
			v_dias_dic =  round ((g_registros.frecuencia) * 32, 0 );     
		elseif(g_registros.descripcion in ('Año','ano','año','ano')) then 
			v_dias_dic =  round ((g_registros.frecuencia) * 365, 0 );
		else
			raise exception 'Unidad no reconocida %', g_registros.descripcion;     
		end if;
     
     
        -- si la misma unidad ya tiene mantenimietnos en fecha igual o superior ya planificados los eliminamos
        -- los de fecha pasada se respetan
        -- 
            
        delete from gem.tcalendario_planificado c
        where  c.id_uni_cons_mant_predef in ( Select id_uni_cons_mant_predef 
                                           from  gem.tuni_cons_mant_predef mt 
                                           where mt.id_uni_cons_mant_predef = g_registros.id_uni_cons_mant_predef )
        and c.fecha_ini >= g_registros.fecha_ini 
        and c.tipo = 'planificado' 
        and c.estado = 'generado';
           
     	--var fecha_dic = fecha_ini
        --v_fecha_dic = v_fecha_ini;
        v_fecha_dic = g_registros.fecha_ini;  -- tomamos la fecha de inicio del mantenimiento predef
               
        -- buscamos la ultima fecha de calendario con orden de trabajo (estado orden_trabajo o ejecutado) y la tomamos como fecha inicia;
        SELECT  c.fecha_ini 
        into v_fecha_ot  
        FROM gem.tcalendario_planificado c
        WHERE c.id_uni_cons_mant_predef = g_registros.id_uni_cons_mant_predef
        --  and c.fecha_ini >= v_fecha_ini 
        and c.fecha_ini >= g_registros.fecha_ini   -- tomamos la fecha de inicio del manteniminto predef
        and c.estado in  ('orden_trabajo','ejecutado') 
        and c.tipo = 'planificado' 
        order by  c.fecha_ini desc
        limit 1 offset 0;
        
        IF v_fecha_ot is not null THEN
            v_fecha_dic= (v_fecha_ot::date +  CAST(  v_dias_dic::varchar||' days' as INTERVAL));
        END IF;

     	--2.1) Mientras  fecha_dic <  fecha_fin\\
		WHILE v_fecha_dic <= p_fecha_fin LOOP
			-- 2.1.1) inserta en calendario la fecha de mantenimiento
            INSERT INTO gem.tcalendario_planificado(
                    id_usuario_reg,
                    estado_reg,
                    id_uni_cons_mant_predef,
                    fecha_ini,
                    estado,
                    tipo,
                    observaciones
            ) VALUES(
                     p_id_usuario,
                    'activo',                   
                    g_registros.id_uni_cons_mant_predef,
                    v_fecha_dic,                    
                    'generado',
                    'planificado',
                    'autogenerado'
            );
    
		    --2.1.2)  fecha_dic = fecha_dic + dias_dic
       		v_fecha_dic=  (v_fecha_dic::date +  CAST(  v_dias_dic::varchar||' days' as INTERVAL));
      
		END LOOP;

	END LOOP;

	--------------
    -- (2) RESPUESTA
    --------------
	RETURN TRUE;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;