--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_verifica_alarma_gem (
  p_id_usuario integer
)
RETURNS varchar AS
$body$
/**********************************************************************************************
 FUNCION: 		f_verifica_alarma_gem
 DESCRIPCION:   Verifica las alarmas correspondientes al subsistema enviado 
                desde el control si no existe la alarma la inserta,
                para los casos que se tengan alarmas con tiempo de vencimiento
 
 AUTOR: 	    RAC KPLIAN
 FECHA:	        06-12-2012
 COMENTARIOS:	

***********************************************************************************************/

DECLARE
 
    v_dif_dias							integer;
    v_id_subsistema						integer;
    v_id_rpc							integer;
    v_id_sup    						integer;
    v_id_rep_legal						integer; 
    v_id_sup_boleta						integer;  
    v_dias_calendario_planificado		integer;
    v_descrip_calendario_planificado	varchar;
    v_dias_ot							integer;
    v_descrip_ot						varchar;
    g_registros  						record;  
    g_registros1						record;  
    g_registros2						record;  
    v_alarmas							integer[];
    v_alarmas_con						integer[];
    v_id_funcionario					integer;
    v_id_alarma							integer; 
    v_funcionarios						integer[];
    v_funcionarios_cargo				varchar[];
    v_funcionarios_con					integer[]; 
    v_funcionarios_url      			varchar[]; 
	v_funcionarios_class				varchar[];
    v_indice							integer;
    v_desc_alarma           			varchar;
    v_num_cotrato 						varchar;
    v_contratista 						varchar;
    v_id_localizaciones 				integer[];
    v_id_uni_cons_raiz 					integer; 
    v_id_localizacion_raiz 				integer;
    v_consulta 							varchar;
    v_i 								integer;
    v_j 								integer;
    v_codigo_localizacion 				varchar;
    
    
BEGIN
	--Inicialización de variables       
	v_indice:=0;
	
    --0) Obtenemos el id_subsistema
    SELECT id_subsistema
    INTO v_id_subsistema
    FROM segu.tsubsistema 
    WHERE codigo='GEM';
    
    ----------------------------------------------------------
    --(1) Alarma para proximidad de mantenimientos por equipo
    ----------------------------------------------------------
       
	--1) Obtenemos los datos de configuracion del calendario_planificado
	SELECT descripcion,dias
	INTO v_descrip_calendario_planificado,v_dias_calendario_planificado
    FROM param.tconfig_alarma 
    WHERE codigo='tcalendario_planificado'
    AND id_subsistema=v_id_subsistema;
       
    --1A) Creamos una tabla temporal para almacenar los usuarios responsables por uni_cons temporalmente para evitar la redudancia de la recursividad
	--Creación de tabla temporal
	create temp table tt_genera_alarmas_gema(
		id_uni_cons  integer,
		id_localizacion_usuario  integer,
		codigo varchar,
		localizacion varchar,
		id_usuario integer,
		tipo varchar,
		id_uni_cons_raiz integer
	)on commit drop;

	--2) Iniciamos el recorrido de todos los mantenimientos próximos a la cantidad definida de días por alarma
	for g_registros IN (select cp.id_calendario_planificado,
						cp.fecha_ini,
                        cp.id_uni_cons_mant_predef,
                        uc.id_uni_cons,
                        uc.codigo,
                        uc.nombre,
                        mp.codigo as codigo_mantenimiento,
                        mp.nombre as nombre_mantenimiento,
                        gem.f_get_nombre_localizacion_rec(uc.id_localizacion,'padres') as localizacion
                        from gem.tcalendario_planificado cp
                        inner join gem.tuni_cons_mant_predef ucm
                        on ucm.id_uni_cons_mant_predef = cp.id_uni_cons_mant_predef
                        inner join gem.tuni_cons uc
                        on uc.id_uni_cons = ucm.id_uni_cons
                        inner join gem.tmant_predef mp
                        on mp.id_mant_predef = ucm.id_mant_predef
                        where cp.id_alarma is null
                        and uc.estado_reg='activo'
                        and uc.tipo_nodo in ('raiz','rama') 
                        and ((cp.fecha_ini-now()::date)<=v_dias_calendario_planificado)
                        and cp.estado = 'generado'
                        and cp.tipo = 'planificado') loop               
		--Calculo cuantos dias falta para vencer; número negativo indica que ya venció
        v_dif_dias= g_registros.fecha_ini-now()::date;
              
        --Verifica si cumple la diferencia de dias para crear una alarma
        if v_dif_dias <= v_dias_calendario_planificado then
            --Obtenermos el nodo raiz del equipo
			WITH RECURSIVE arbol (id_uni_cons,id_uni_cons_padre, id_uni_cons_hijo, codigo, tipo_nodo,id_localizacion) AS (  
                   	select uc.id_uni_cons, ucc.id_uni_cons_padre, ucc.id_uni_cons_hijo,
                   	uc.codigo::text as codigo, uc.tipo_nodo,uc.id_localizacion
					from gem.tuni_cons uc
                    inner join gem.tuni_cons_comp ucc 
                    on ucc.id_uni_cons_hijo = uc.id_uni_cons
                    where uc.id_uni_cons = g_registros.id_uni_cons    
                    union all  
                    select uc2.id_uni_cons, ucc2.id_uni_cons_padre, ucc2.id_uni_cons_hijo,
                    uc2.codigo as codigo ,uc2.tipo_nodo,uc2.id_localizacion  
                    from arbol a 
                    inner join gem.tuni_cons_comp ucc2
                    on ucc2.id_uni_cons_hijo = a.id_uni_cons
                    inner join gem.tuni_cons uc2
                    on uc2.id_uni_cons = ucc2.id_uni_cons_padre
                    where uc2.tipo_nodo in ('rama','raiz') 
			)  
			select id_uni_cons, id_localizacion 
            into  v_id_uni_cons_raiz, v_id_localizacion_raiz 
           	from arbol where tipo_nodo = 'raiz' 
           	limit 1 offset 0;
                  
			--Buscamos el codigo de la unidad raiz 
			if not exists (select localizacion 
						from tt_genera_alarmas_gema  tt
						where tt.id_uni_cons_raiz=v_id_uni_cons_raiz
						limit 1 offset 0)  then 

				--Si no exista el registro de la unidad raiz lo llenamos 
				--Obtenemos la localizacion superior con el uni_cons_raiz
                v_i=1;
				for g_registros2 in (WITH RECURSIVE arbol (id_localizacion,id_localizacion_fk,codigo) AS (  
												select lo.id_localizacion,lo.id_localizacion_fk , lo.codigo::text as codigo 
		                                      	from gem.tlocalizacion lo
												where lo.id_localizacion = v_id_localizacion_raiz    
		                                        UNION ALL  
		                                        SELECT lo2.id_localizacion,lo2.id_localizacion_fk , (lo2.codigo||'',''||a.codigo)::text as codigo  
		                                        FROM arbol a 
		                                        INNER JOIN  gem.tlocalizacion lo2
		                                        on lo2.id_localizacion = a.id_localizacion_fk
                                        	)  
                                       		SELECT distinct id_localizacion,id_localizacion_fk,codigo FROM arbol) loop
                          
					--Llenamos un vector de localizaciones y obtenemos el codigo de la raiz
                    v_id_localizaciones[v_i]= g_registros2.id_localizacion;
                           
                    if g_registros2.id_localizacion_fk is null then
                    	v_codigo_localizacion=g_registros2.codigo;
                    end if;
                           
					v_i=v_i+1;
                           
				end loop;
                      
                --Obtenemos  los usuarios para esas localizaciones
                v_j=1;
                      
                --Recorremos todas las localizaciones superiores  en el vector
	            WHILE v_j < v_i LOOP
					--Lista los usuarios de la localizacion a los que se les mandará la alerta
					for g_registros2 in (select  lu.id_usuario ,lu.id_localizacion_usuario,lu.tipo
                                         from gem.tlocalizacion_usuario lu 
                                         where lu.id_localizacion = v_id_localizaciones[v_j] 
                                         and lu.tipo in ('Gerente','Jefe','Ingeniero','Asistente','gerente','jefe','ingeniero','asistente')
                                         and lu.estado_reg='activo') loop
                              
						--Inserta los usario en la tabla temporal
                        insert into tt_genera_alarmas_gema(
                        id_uni_cons,
                        id_localizacion_usuario,
                        codigo,
                        localizacion,
                        id_usuario,
                        tipo,
                        id_uni_cons_raiz
                        ) values (
                        g_registros.id_uni_cons,
                        g_registros2.id_localizacion_usuario,
                        g_registros.codigo,
                        g_registros.localizacion,
                        g_registros2.id_usuario,
                        g_registros2.tipo,
                        v_id_uni_cons_raiz
                        );
                               
                    END LOOP;
                    v_j=v_j+1;
                    
				END LOOP;
                
            END IF;
                 
			--Buscamos en la tabla temporal si el uni_cons ya tiene sus usuarios
			--raise exception 'contador %',v_j;
			v_indice=1;
               
            FOR g_registros2 in (select id_usuario,codigo,localizacion  
                                 from  tt_genera_alarmas_gema tt
                				where tt.id_uni_cons_raiz= v_id_uni_cons_raiz) LOOP
				--Arma la descripcion de la alarma
				v_desc_alarma='<b>Acción:</b> Generación de Órden de Trabajo<br><b>Fecha Mantenimiento:</b> '||coalesce(g_registros.fecha_ini::varchar,'NR')||'<br><b>TAG: '||coalesce(g_registros.codigo,'NR')||'<br><b>Equipo:</b> '||coalesce(g_registros.nombre,'NR')||'<br><b>Mantenimiento: ('||coalesce(g_registros.codigo_mantenimiento::varchar,'NR') ||') '||coalesce(g_registros.nombre_mantenimiento::varchar,'NR')||'<br><b>Localización:</b> '||coalesce(g_registros2.localizacion,'NR');
                               
				IF g_registros2.id_usuario is NULL THEN                                  
                	raise exception  'El Usuario no Puede ser NULL,  %',  g_registros2.id_usuario ;                                
				ELSE
                	--Solo registra la alrma si tiene un ususario destinatario
					v_id_alarma:=param.f_inserta_alarma(
                                     NULL,
                                     v_desc_alarma,
                                     '../../../sis_mantenimiento/vista/localizacion/Localizacion.php',
                                      g_registros.fecha_ini,
                                     'alarma',
                                     'GMAN-Calendario',
                                      p_id_usuario,
                                     'Localizacion',
                                     'Localizaciones',
                                     '{}',
                                     g_registros2.id_usuario,
                                     'Mantenimientos Pendientes'
                                     ); 
                                     
                    v_alarmas_con[v_indice]:=v_id_alarma;                        
                    v_indice:=v_indice+1;
				END IF;         
                      
            END LOOP;-- <<-------------OJO
                
            --Actualizamos la tabla boleta con el array de alarmas
            Update gem.tcalendario_planificado SET
            id_alarma=v_alarmas_con
            WHERE id_calendario_planificado=g_registros.id_calendario_planificado;
                                      
                                          
		END IF;
          
	END LOOP; 
         
         
     
	-------------------------------------------------------------------------------------  
    --(2)Alarma por generación de ordenes de trabajo pendientes y alertas al responsables 
    -------------------------------------------------------------------------------------
    --obtenemos configuracion de las alertas de OT
        
	SELECT descripcion,dias
   	INTO v_descrip_ot, v_dias_ot
   	FROM param.tconfig_alarma 
   	WHERE codigo='torden_trabajo'
   	AND id_subsistema=v_id_subsistema; 
       
	FOR g_registros IN (SELECT 
                        ot.id_orden_trabajo,
                        ot.fecha_plan_ini,
                        ot.id_funcionario_asig,
                        ot.num_oit,
                        ot.descripcion,
                        ot.id_uni_cons_mant_predef,
                        uc.id_uni_cons,
                        uc.codigo,
                        uc.nombre,
                        mp.codigo as codigo_mantenimiento,
                        mp.nombre as nombre_mantenimiento,
             			ot.ubicacion_tecnica,
             			gem.f_get_nombre_localizacion_rec(ot.id_localizacion,'padres') as localizacion,
             			ot.cat_prior
                        FROM gem.torden_trabajo ot 
                        INNER JOIN gem.tuni_cons_mant_predef ucm on  ucm.id_uni_cons_mant_predef = ot.id_uni_cons_mant_predef
                        INNER JOIN gem.tuni_cons uc on uc.id_uni_cons       = ucm.id_uni_cons
                        INNER JOIN gem.tmant_predef mp on mp.id_mant_predef = ucm.id_mant_predef   
                        WHERE ot.id_alarma IS NULL and uc.estado_reg='activo' and ot.estado_reg='activo'  
                        and ((ot.fecha_plan_ini-now()::date)<=v_dias_ot)
                        and ot.cat_estado in ('Pendiente','Abierto')) LOOP               

		IF(g_registros.id_funcionario_asig is not null) THEN
           
        	v_desc_alarma= '<b>Acción:</b> Ejecutar Orden de Trabajo<br>Fecha asignación: '||to_char(now(),'dd/mm/yyyy')||'<br><b>Fecha Planificada:</b> '||to_char(g_registros.fecha_plan_ini,'dd/mm/yyyy') ||'<br><b>Prioridad:</b> '||g_registros.cat_prior||'<br><b>Nro. OIT:</b> '||coalesce(g_registros.num_oit::varchar,'NR')||'<br><b>Mantenimiento:</b> ('||coalesce(g_registros.codigo_mantenimiento::varchar,'NR')||') '||coalesce(g_registros.nombre_mantenimiento::varchar,'NR')||'<br><b>TAG: '||coalesce(g_registros.codigo::varchar,'NR')||'</b><br><b>Equipo:</b> '||coalesce(g_registros.nombre::varchar,'NR')||'<br><b>Localización:</b> '||coalesce(g_registros.localizacion::varchar,'NR');
           
            v_id_alarma:=param.f_inserta_alarma(
                                     g_registros.id_funcionario_asig,
                                     v_desc_alarma,
                                     '../../../sis_mantenimiento/orden_trabajo/orden_trabajo/EjecutarOT.php',
                                      g_registros.fecha_plan_ini,
                                     'alarma',--notificacion
                                     'GMAN-OIT',
                                      p_id_usuario,
                                     'EjecutarOT',
                                     'OT pendiente',
                                     '{}',
                                      NULL,
                                     'Orden de Trabajo Pendiente'
                                     ); 
        
		END IF;
              
        --Actualizamos la tabla con el array de alarmas
        Update gem.torden_trabajo SET
        id_alarma[1]=v_id_alarma
        WHERE id_orden_trabajo=g_registros.id_orden_trabajo;  

	END LOOP;
    
    -------------------------------- 
    -- Inclusión de otras alarmas  
    --------------------------------  
         
    --Respuesta
	return 'exito';

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100;