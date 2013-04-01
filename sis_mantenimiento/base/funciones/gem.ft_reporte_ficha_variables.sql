CREATE OR REPLACE FUNCTION gem.ft_reporte_ficha_variables (
  p_id_tipo_equipo integer
)
RETURNS SETOF record AS
$body$
/*
Autor: RCM
Fecha: 21/03/2013
*/
DECLARE

  v_consulta varchar;
    v_consulta1 varchar;
    v_consulta2 varchar;
    v_rec record;
    v_rec1 record;
    v_cod varchar;
    v_ids varchar;
    v_cond varchar;

BEGIN

  --Verifica el filtro para ubicar los equipos a considerar
/*    if (pxp.f_existe_parametro(p_tabla,'id_localizacion')) then
      v_ids = gem.f_get_id_localizaciones(v_parametros.id_localizacion);
      v_cond = ' ucons.id_localizacion in ('||v_ids||')';
    elsif (pxp.f_existe_parametro(p_tabla,'id_uni_cons')) then
        v_cond = ' ucons.id_uni_cons = ' || v_parametros.id_uni_cons;
    else
        raise exception 'Localizacion/Equipo indefinido';
    end if;*/

  v_consulta = 'create temp table tt_reporte_ficha_var(
        id_reporte serial,
                id_uni_cons integer,
                fecha date,
        hora time';
    
    --Aumenta las columnas de la ficha técnica            
    for v_rec in execute('select
                        distinct tvar.id_tipo_variable::varchar as id, tvar.nombre
                        from gem.tequipo_variable evar
                        inner join gem.ttipo_variable tvar
                        on tvar.id_tipo_variable = evar.id_tipo_variable
                        inner join gem.tuni_cons ucons
                        on ucons.id_uni_cons = evar.id_uni_cons
                        where ucons.id_tipo_equipo = '|| p_id_tipo_equipo) loop
                  
      v_cod = 'col_'||v_rec.id;
        v_consulta = v_consulta||', '||v_cod||'_key varchar';
        v_consulta = v_consulta||', '||v_cod||' varchar';
        
    end loop;
    
    --Aumenta las columnas de la ficha técnica            
    for v_rec in (select
                  distinct lower(trim(udet.nombre)) as id, udet.nombre 
                  from gem.tuni_cons_det udet
                  inner join gem.tuni_cons ucons
                  on ucons.id_uni_cons = udet.id_uni_cons
                  where ucons.id_tipo_equipo = p_id_tipo_equipo) loop
                  
      v_cod = 'col_'||v_rec.id;
        v_consulta = v_consulta||', '||v_cod||'_key varchar';
        v_consulta = v_consulta||', '||v_cod||' varchar';
        
    end loop;
    
  --Completa la sentencia de creación de la tabla temporal
  v_consulta =v_consulta||') on commit drop';
--    raise exception '%',v_consulta;      
  --Creación de la tabla
  execute(v_consulta);
    
     -----------------
            -- (2) CARGADO DE DATOS
            -----------------
            
            v_consulta = 'select
                          evar.id_uni_cons, tvar.id_tipo_variable, emed.fecha_medicion, emed.hora,
                          emed.medicion
                          from gem.tequipo_variable evar
                          inner join gem.ttipo_variable tvar
                          on tvar.id_tipo_variable = evar.id_tipo_variable
                          inner join gem.tuni_cons ucons
                          on ucons.id_uni_cons = evar.id_uni_cons
                          inner join gem.tequipo_medicion emed
                          on emed.id_equipo_variable = evar.id_equipo_variable
                          where ucons.id_tipo_equipo = '||p_id_tipo_equipo||'
                          order by emed.fecha_medicion, emed.hora';
                          
            for v_rec in execute(v_consulta) loop
            v_consulta1= 'INSERT into tt_reporte_ficha_var (
                  id_uni_cons,
                        fecha,
                        hora';

        -- (valores) arma los valores de las columnas fijas
             v_consulta2= ') values('||v_rec.id_uni_cons||','''||v_rec.fecha_medicion||''','''||v_rec.hora||'''';
             
             
              for v_rec1 in (select tva.id_tipo_variable,
                                 em.id_equipo_medicion,
                                 em.medicion,
                                 em.hora
                                 from gem.tequipo_medicion em
                                 inner join gem.tequipo_variable ev
                                 on ev.id_equipo_variable = em.id_equipo_variable
                                 inner join gem.ttipo_variable tva on tva.id_tipo_variable = ev.id_tipo_variable
                                 where ev.estado_reg = 'activo' and ev.tipo='numeric'
                                 and ev.id_uni_cons = v_rec.id_uni_cons
                                 and em.fecha_medicion = v_rec.fecha_medicion
                                 and em.hora = v_rec.hora) loop
                                 
                  v_cod = 'col_'||v_rec1.id_tipo_variable::varchar;
                    v_consulta1 = v_consulta1||','||v_cod||','||v_cod||'_key';
                    v_consulta2 = v_consulta2||','||quote_literal(v_rec1.medicion)||','||v_rec1.id_equipo_medicion;

                                 
                end loop;
                
                -- Une las consultas
              v_consulta1 = v_consulta1||v_consulta2|| ') ';
                      
              -- Ejecuta (inserta) los datos
          execute(v_consulta1);
            
            end loop;
            
            
             --FICHA TECNICA
            v_consulta = 'select
                          udet.id_uni_cons, lower(trim(udet.nombre)) as id, udet.valor
                          from gem.tuni_cons_det udet
                          inner join gem.tuni_cons ucons
                          on ucons.id_uni_cons = udet.id_uni_cons
                          where ucons.id_tipo_equipo = '||p_id_tipo_equipo||'
                          order by udet.nombre';
                          
                         -- raise notice '%',v_consulta;
                          
            for v_rec in execute(v_consulta) loop
                /*v_consulta1= 'INSERT into tt_reporte_ficha_var(
                            id_uni_cons';

                  -- (valores) arma los valores de las columnas fijas
                v_consulta2= ') values('||v_rec.id_uni_cons;
                                 
                v_cod = 'col_'||v_rec.id;
                v_consulta1 = v_consulta1||','||v_cod||','||v_cod||'_key';
                v_consulta2 = v_consulta2||','||quote_literal(v_rec.valor)||','||v_rec.id_uni_cons;
                
        -- Une las consultas
              v_consulta1 = v_consulta1||v_consulta2|| ') ';
                      
              -- Ejecuta (inserta) los datos
          execute(v_consulta1);*/
                v_cod = 'col_'||v_rec.id;
                v_consulta1='UPDATE tt_reporte_ficha_var SET '||
                      v_cod||'='||quote_literal(v_rec.valor)||','||
                            v_cod||'_key='||v_rec.id_uni_cons|| '
                            where id_uni_cons='||v_rec.id_uni_cons;
            
              -- Ejecuta (inserta) los datos
                
                raise notice '=>%',v_consulta1;
          execute(v_consulta1);
            
            end loop;

    
    --Devuelve la consulta de la tabla creada
    for v_rec in execute('select * from tt_reporte_ficha_var') loop
      return next v_rec;
    end loop;
    
    return;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100 ROWS 1000;