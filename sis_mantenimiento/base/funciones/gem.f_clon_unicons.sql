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
 DESCRIPCI�N: 	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			09 11 2012
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCI�N:
 AUTOR:       
 FECHA:      

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCI�N --
--------------------------

-- PAR�METROS FIJOS
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
 
v_id_copia_2 integer;
v_id_copia_3 integer;
v_id_copia_4 integer;

g_registros_2 record;
g_registros_3 record;
g_registros_4 record;


BEGIN

  --  1)  clonar   unicons det  
  
         -- FOR consultar
		FOR g_registros in  (
			select  
            	ucd.id_uni_cons, 
                ucd.id_unidad_medida,
                ucd.codigo,
                ucd.nombre, 
                ucd.descripcion, 
                ucd.valor
			from gem.tuni_cons_det ucd 
            where ucd.id_uni_cons = v_id_orig  
            and ucd.estado_reg = 'activo'
            order by ucd.id_uni_cons_det
		) LOOP
        	INSERT INTO gem.tuni_cons_det (
				id_usuario_reg,
              	fecha_reg,
              	estado_reg,
              	id_unidad_medida,
              	id_uni_cons,
              	codigo,
              	nombre,
              	descripcion,
              	valor
            ) VALUES (
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
  
  --  2)  clonar  equipo variable
        
		FOR g_registros in ( 
        	select 
            	ev.id_tipo_variable, 
                ev.obs, 
                ev.valor_max, 
                ev.valor_min,
                ev.tipo
			from gem.tequipo_variable ev
			where ev.id_uni_cons = v_id_orig  
			and ev.estado_reg = 'activo'
			order by ev.id_equipo_variable
		) LOOP
        	INSERT INTO gem.tequipo_variable (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_uni_cons,
                id_tipo_variable,
                obs,
                valor_min,
                valor_max,
                tipo
			) VALUES (
				v_id_usuario,
				now(),
				'activo',
                v_id_cop,
                g_registros.id_tipo_variable,
                g_registros.obs,
                g_registros.valor_min,
                g_registros.valor_max,
                g_registros.tipo
            );  
		END LOOP;
          
    --3) clonar items de equipo.
    
		FOR g_registros in ( 
			SELECT 
            	ucitm.id_item, 
                ucitm.estado_reg, 
                ucitm.observaciones
			FROM gem.tuni_cons_item ucitm
			WHERE ucitm.id_uni_cons = v_id_orig
		) LOOP
        	INSERT INTO gem.tuni_cons_item (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_uni_cons,
                id_item,
                observaciones
            ) VALUES (
                v_id_usuario,
                now(),
                g_registros.estado_reg,
                v_id_cop,
                g_registros.id_item,
                g_registros.observaciones
            );
		END LOOP;
          
	-- 4) clonar proveedores de equipo.
    	
    	FOR g_registros in ( 
			SELECT 
            	ucprov.id_proveedor,
                ucprov.estado_reg
			FROM gem.tuni_cons_proveedor ucprov
			WHERE ucprov.id_uni_cons = v_id_orig
		) LOOP
        	INSERT INTO gem.tuni_cons_proveedor (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_uni_cons,
                id_proveedor
            ) VALUES (
                v_id_usuario,
                now(),
                g_registros.estado_reg,
                v_id_cop,
                g_registros.id_proveedor
            );
		END LOOP;
	
    -- 5) clonar Analisis Mantenimiento de Equipos
    
    	FOR g_registros in ( 
			SELECT 
            	amant.id_analisis_mant,
            	amant.id_tipo_mant,
                amant.id_persona_rev,
                amant.fecha_emision,
                amant.fecha_rev,
                amant.descripcion
			FROM gem.tanalisis_mant amant
			WHERE amant.id_uni_cons = v_id_orig
            	and amant.estado_reg = 'activo'
		) LOOP
        	INSERT INTO gem.tanalisis_mant (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_uni_cons,
                id_tipo_mant,
                id_persona_rev,
                fecha_emision,
                fecha_rev,
                descripcion
            ) VALUES (
                v_id_usuario,
                now(),
                'activo',
                v_id_cop,
                g_registros.id_tipo_mant,
                g_registros.id_persona_rev,
                g_registros.fecha_emision,
                g_registros.fecha_rev,
                g_registros.descripcion
            ) RETURNING id_analisis_mant INTO v_id_copia_2;
            
            -- clonar funcion de Analisis Mant
            FOR g_registros_2 in ( 
                SELECT 
                	func.id_funcion,
                    func.descripcion,
                    func.orden
                FROM gem.tfuncion func
                WHERE func.id_analisis_mant = g_registros.id_analisis_mant
                    and func.estado_reg = 'activo'
            ) LOOP
                INSERT INTO gem.tfuncion (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_analisis_mant,
                    descripcion,
                    orden
                ) VALUES (
                    v_id_usuario,
                    now(),
                    'activo',
                    v_id_copia_2,
                    g_registros_2.descripcion,
                    g_registros_2.orden
                ) RETURNING id_funcion INTO v_id_copia_3;
                
                -- clonar falla de funcion
                
                FOR g_registros_3 in ( 
                    SELECT 
                        funfall.id_funcion_falla,
                        funfall.id_falla_evento,
                        funfall.modo_falla,
                        funfall.efecto_falla,
                        funfall.orden
                    FROM gem.tfuncion_falla funfall
                    WHERE funfall.id_funcion = g_registros_2.id_funcion
                        and funfall.estado_reg = 'activo'
                ) LOOP
                    INSERT INTO gem.tfuncion_falla (
                        id_usuario_reg,
                        fecha_reg,
                        estado_reg,
                        id_funcion,
                        id_falla_evento,
                        modo_falla,
                        efecto_falla,
                        orden
                    ) VALUES (
                        v_id_usuario,
                        now(),
                        'activo',
                        v_id_copia_3,
                        g_registros_3.id_falla_evento,
                        g_registros_3.modo_falla,
                        g_registros_3.efecto_falla,
                        g_registros_3.orden
                    ) RETURNING id_funcion_falla INTO v_id_copia_4;
                    
                    -- clonar Modo falla de falla
                    
                    FOR g_registros_4 in (
                        SELECT 
                            modfall.id_modo_falla,
                            modfall.modo_falla,
                            modfall.efecto_falla,
                            modfall.orden
                        FROM gem.tmodo_falla modfall
                        WHERE modfall.id_funcion_falla = g_registros_3.id_funcion_falla
                            and modfall.estado_reg = 'activo'
                    ) LOOP
                        INSERT INTO gem.tmodo_falla (
                            id_usuario_reg,
                            fecha_reg,
                            estado_reg,
                            id_funcion_falla,
                            modo_falla,
                            efecto_falla,
                            orden
                        ) VALUES (
                            v_id_usuario,
                            now(),
                            'activo',
                            v_id_copia_4,
                            g_registros_4.modo_falla,
                            g_registros_4.efecto_falla,
                            g_registros_4.orden
                        );
                  	END LOOP;
                END LOOP;
            END LOOP;
		END LOOP;
        
    -- 6) clonar Plan de Mantenimiento
    
    	FOR g_registros in ( 
			SELECT 
            	pmant.id_plan_mant,
            	pmant.id_tipo_mant,
                pmant.id_persona,
                pmant.id_persona_rev,
                pmant.fecha,
                pmant.descripcion
			FROM gem.tplan_mant pmant
			WHERE pmant.id_uni_cons = v_id_orig
            	and pmant.estado_reg = 'activo'
		) LOOP
        	INSERT INTO gem.tplan_mant (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_uni_cons,
                id_tipo_mant,
                id_persona,
                id_persona_rev,
                fecha,
                descripcion
            ) VALUES (
                v_id_usuario,
                now(),
                'activo',
                v_id_cop,
                g_registros.id_tipo_mant,
                g_registros.id_persona,
                g_registros.id_persona_rev,
                g_registros.fecha,
                g_registros.descripcion
            ) RETURNING id_plan_mant INTO v_id_copia_2;
            
            -- clonar Tarea de Mantenimiento
            
            FOR g_registros_2 in ( 
                SELECT 
                    tarea.id_falla_evento,
                    tarea.id_uni_cons,
                    tarea.id_uni_cons_hijo,
                    tarea.id_modo_falla,
                    tarea.id_especialidad,
                    tarea.id_unidad_medida,
                    tarea.tareas,
                    tarea.frecuencia,
                    tarea.col_h,
                    tarea.col_s,
                    tarea.col_o,
                    tarea.col_n,
                    tarea.col_hson1,
                    tarea.col_hson2,
                    tarea.col_hson3,
                    tarea.col_h4,
                    tarea.col_h5,
                    tarea.col_s4
                FROM gem.ttarea tarea
                WHERE tarea.id_plan_mant = g_registros.id_plan_mant
                    and tarea.estado_reg = 'activo'
            ) LOOP
                INSERT INTO gem.ttarea (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_plan_mant,
                    id_falla_evento,
                    id_uni_cons,
                    id_uni_cons_hijo,
                    id_modo_falla,
                    id_especialidad,
                    id_unidad_medida,
                    tareas,
                    frecuencia,
                    col_h,
                    col_s,
                    col_o,
                    col_n,
                    col_hson1,
                    col_hson2,
                    col_hson3,
                    col_h4,
                    col_h5,
                    col_s4
                ) VALUES (
                    v_id_usuario,
                    now(),
                    'activo',
                    v_id_copia_2,
                    g_registros_2.id_falla_evento,
                    g_registros_2.id_uni_cons,
                    g_registros_2.id_uni_cons_hijo,
                    g_registros_2.id_modo_falla,
                    g_registros_2.id_especialidad,
                    g_registros_2.id_unidad_medida,
                    g_registros_2.tareas,
                    g_registros_2.frecuencia,
                    g_registros_2.col_h,
                    g_registros_2.col_s,
                    g_registros_2.col_o,
                    g_registros_2.col_n,
                    g_registros_2.col_hson1,
                    g_registros_2.col_hson2,
                    g_registros_2.col_hson3,
                    g_registros_2.col_h4,
                    g_registros_2.col_h5,
                    g_registros_2.col_s4
                );
            END LOOP;
		END LOOP;
    
    -- 7) clonar documentacion tecnica de equipo.
    	
    	FOR g_registros in ( 
			SELECT 
            	ucdoc.nombre_documento,
                ucdoc.adjunto,
                ucdoc.codigo,
                ucdoc.observaciones
			FROM gem.tuni_cons_doc_tec ucdoc
			WHERE ucdoc.id_uni_cons = v_id_orig
            	and ucdoc.estado_reg = 'activo'
		) LOOP
        	INSERT INTO gem.tuni_cons_doc_tec (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_uni_cons,
                nombre_documento,
                adjunto,
                codigo,
                observaciones
            ) VALUES (
                v_id_usuario,
                now(),
                'activo',
                v_id_cop,
                g_registros.nombre_documento,
                g_registros.adjunto,
                g_registros.codigo,
                g_registros.observaciones
            );
		END LOOP;
        
	-- 8) clonar los archivos de equipo.
    	
    	FOR g_registros in ( 
			SELECT 
            	ucarch.id_uni_cons_archivo,
            	ucarch.nombre,
                ucarch.nombre_archivo,
                ucarch.resumen,
                ucarch.extension,
                ucarch.palabras_clave,
                ucarch.codigo,
                ucarch.archivo,
                ucarch.tipo,
                ucarch.reporte
			FROM gem.tuni_cons_archivo ucarch
			WHERE ucarch.id_uni_cons = v_id_orig
            	and ucarch.estado_reg = 'activo'
                and ucarch.id_uni_cons_archivo_padre is null
		) LOOP
        	INSERT INTO gem.tuni_cons_archivo (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_uni_cons,
                nombre,
                nombre_archivo,
                resumen,
                extension,
                palabras_clave,
                codigo,
                archivo,
                tipo,
                reporte
            ) VALUES (
                v_id_usuario,
                now(),
                'activo',
                v_id_cop,
                g_registros.nombre,
                g_registros.nombre_archivo,
                g_registros.resumen,
                g_registros.extension,
                g_registros.palabras_clave,
                g_registros.codigo,
                g_registros.archivo,
                g_registros.tipo,
                g_registros.reporte
            ) RETURNING id_uni_cons_archivo INTO v_id_copia_2;
            
            -- clonar los uni_cons_archvio tipo hijos
            
            FOR g_registros_2 in ( 
                SELECT 
                	ucarch2.id_uni_cons,
                    ucarch2.nombre,
                    ucarch2.nombre_archivo,
                    ucarch2.resumen,
                    ucarch2.extension,
                    ucarch2.palabras_clave,
                    ucarch2.codigo,
                    ucarch2.archivo,
                    ucarch2.tipo,
                    ucarch2.reporte
                FROM gem.tuni_cons_archivo ucarch2
                WHERE ucarch2.id_uni_cons_archivo_padre = g_registros.id_uni_cons_archivo
                    and ucarch2.estado_reg = 'activo'
            ) LOOP
                INSERT INTO gem.tuni_cons_archivo (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_uni_cons_archivo_padre,
                    id_uni_cons,
                    nombre,
                    nombre_archivo,
                    resumen,
                    extension,
                    palabras_clave,
                    codigo,
                    archivo,
                    tipo,
                    reporte
                ) VALUES (
                    v_id_usuario,
                    now(),
                    'activo',
                    v_id_copia_2,
                    g_registros_2.id_uni_cons,
                    g_registros_2.nombre,
                    g_registros_2.nombre_archivo,
                    g_registros_2.resumen,
                    g_registros_2.extension,
                    g_registros_2.palabras_clave,
                    g_registros_2.codigo,
                    g_registros_2.archivo,
                    g_registros_2.tipo,
                    g_registros_2.reporte
                );
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