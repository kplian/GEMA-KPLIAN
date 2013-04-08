CREATE OR REPLACE FUNCTION gem.f_tmp_cargar_variables_vehiculos (
)
RETURNS varchar AS
$body$
DECLARE

  v_id_tipo_equipo integer;
    v_id_tipo_variable integer;
    v_ids_tipo_variable varchar;
    v_rec record;
    v_sql varchar;

BEGIN

  v_ids_tipo_variable = '0';

  --Ubica el id del tipo de equipo Vehiculos
    select
    id_tipo_equipo
    into
    v_id_tipo_equipo
    from gem.ttipo_equipo
    where nombre ilike '%vehiculo%' or nombre ilike '%vehículo%';
    
    if v_id_tipo_equipo is null then
      raise exception 'No se encuentra el tipo de equipo Vehiculos';
    end if;
    
    --Inserta las variables para el reporte de vehiculos
    --///1
    v_id_tipo_variable=null;
    select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Kilometraje%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Kilometraje', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
        
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 7, E'2013-03-20 05:00:20');
    
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;

    --///2
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Recorrido%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Recorrido', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 8, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///3
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Consumo Combustible (Lts)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Consumo Combustible (Lts)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 9, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
     --///4
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Costo Combustible (Bs)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Costo Combustible (Bs)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 10, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///5
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Costo Parchado (Bs)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Costo Parchado (Bs)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 11, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///6
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Costo Lubricantes (Bs)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Costo Lubricantes (Bs)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 12, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///7
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Costo Lavado (Bs)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Costo Lavado (Bs)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 13, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///8
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Costo Batería (Bs)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Costo Batería (Bs)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 14, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///9
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Costo Neumatico (Bs)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Costo Neumatico (Bs)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 15, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///10
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Costo Mtto.(Bs)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "numeric")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Costo Mtto.(Bs)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 16, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///11
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Costo Total (Bs)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "formula")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Costo Total (Bs)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 17, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///12
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Rendimiento (Km/Lt)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "formula")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Rendimiento (Km/Lt)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 18, E'2013-03-20 05:00:20');
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    --///13
    v_id_tipo_variable=null;
     select id_tipo_variable
    into v_id_tipo_variable
    from gem.ttipo_variable a
    where a.nombre ilike '%Factor Costo (Bs/Km)%';
   
    if v_id_tipo_variable is null then
      --Inserta
        INSERT INTO gem.ttipo_variable ("id_usuario_reg", "fecha_reg", "estado_reg", "id_tipo_equipo", "id_unidad_medida", "nombre", "descripcion", "observaciones", "calculo", "formula")
    VALUES (1, E'2012-12-20 14:14:05.024', E'activo',  v_id_tipo_equipo, 9, E'Factor Costo (Bs/Km)', NULL, NULL, NULL, NULL) returning id_tipo_variable into v_id_tipo_variable;
    end if;
    
    --Forma la plantilla
    INSERT INTO gem.ttipo_equipo_col ("id_usuario_reg", "estado_reg", "id_tipo_equipo", "tipo_col", "id", "orden", "fecha_reg")
  VALUES (1, E'activo', 12, E'Variables', v_id_tipo_variable, 19, E'2013-03-20 05:00:20');
    
    v_ids_tipo_variable = v_ids_tipo_variable ||','||v_id_tipo_variable::varchar;
    
    
    --Relaciona estas nuevas columnas creadas con los vehiculos
    for v_rec in (select *
          from gem.tuni_cons a
                where a.id_tipo_equipo = v_id_tipo_equipo) loop
      v_sql = 'insert into gem.tequipo_variable(
                  id_usuario_reg, fecha_reg, estado_reg, id_tipo_variable, id_uni_cons, tipo
                  )
                  select
                  1, now(),''activo'', bb.id_tipo_variable,'||v_rec.id_uni_cons||',''formula''
                  from gem.ttipo_variable bb
                  where bb.id_tipo_variable in ('||v_ids_tipo_variable||')
                  and bb.id_tipo_variable not in (select id_tipo_variable
                                    from gem.tequipo_variable
                                                    where id_uni_cons = ' ||v_rec.id_uni_cons||')';


    raise notice '%', v_sql;                                                   
        execute(v_sql);
        
            
    end loop;

    
    
    
    return 'Hecho';
    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;