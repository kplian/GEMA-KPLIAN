CREATE OR REPLACE FUNCTION gem.f_uni_cons_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Mantenimiento Industrial - Plantas y Estaciones
 FUNCION:     gem.f_uni_cons_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tuni_cons_det'
 AUTOR:      (admin)
 FECHA:         08-11-2012 21:12:55
 COMENTARIOS: 
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/

DECLARE

  v_consulta        varchar;
  v_parametros      record;
  v_nombre_funcion    text;
  v_resp        varchar;
    v_consulta1       varchar;
    v_consulta2       varchar;
    v_rec       record;
    v_rec1        record;
    v_ids       varchar;
    v_cond        varchar;
    v_cod       varchar;
    
  v_ccomb numeric;
    v_comb numeric;
    v_parch numeric;
    v_lub numeric;
    v_lav numeric;
    v_bat numeric;
    v_neu numeric;
    v_mtto1 numeric;
    v_mtto2 numeric;
    v_mtto3 numeric;
    v_mtto4 numeric;
    v_mtto5 numeric;
    v_kil numeric;
    v_tot numeric;
    v_con1 varchar;
    v_con2 varchar;
          
BEGIN

  v_nombre_funcion = 'gem.f_uni_cons_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'GM_UCDET_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   08-11-2012 21:12:55
  ***********************************/

  if(p_transaccion='GM_UCDET_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
            ucdet.id_uni_cons_det,
            ucdet.id_unidad_medida,
            ucdet.id_uni_cons,
            ucdet.codigo::numeric,
            ucdet.nombre,
            ucdet.descripcion,
            ucdet.valor,
            ucdet.estado_reg,
            ucdet.fecha_reg,
            ucdet.id_usuario_reg,
            ucdet.id_usuario_mod,
            ucdet.fecha_mod,
            usu1.cuenta as usr_reg,
            usu2.cuenta as usr_mod,
            um.codigo as codigo_unidad_medida 
            from gem.tuni_cons_det ucdet
            inner join segu.tusuario usu1 on usu1.id_usuario = ucdet.id_usuario_reg
            left join param.tunidad_medida um on  um.id_unidad_medida = ucdet.id_unidad_medida
            left join segu.tusuario usu2 on usu2.id_usuario = ucdet.id_usuario_mod
            where ucdet.estado_reg = ''activo''  AND ucdet.id_uni_cons ='|| v_parametros.id_uni_cons||' AND ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GM_UCDET_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   admin 
  #FECHA:   08-11-2012 21:12:55
  ***********************************/

  elsif(p_transaccion='GM_UCDET_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_uni_cons_det)
              from gem.tuni_cons_det ucdet
              inner join segu.tusuario usu1 on usu1.id_usuario = ucdet.id_usuario_reg
                        inner join param.tunidad_medida um on  um.id_unidad_medida = ucdet.id_unidad_medida
            left join segu.tusuario usu2 on usu2.id_usuario = ucdet.id_usuario_mod
              where ucdet.estado_reg = ''activo''  AND ucdet.id_uni_cons ='|| v_parametros.id_uni_cons||' AND  ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
        
  /*********************************    
  #TRANSACCION:  'GM_LISCAR_SEL'
  #DESCRIPCION: Lista todas las características
  #AUTOR:     rcm
  #FECHA:     11/03/2013
  ***********************************/

  elsif(p_transaccion='GM_LISCAR_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
                        distinct upper(nombre)
                        from gem.tuni_cons_det
                where ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by 1 asc limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GM_LISCAR_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:     rcm
  #FECHA:     11/03/2013
  ***********************************/

  elsif(p_transaccion='GM_LISCAR_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select
                        count(distinct(upper(nombre)))
                        from gem.tuni_cons_det
                where ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
    
    /*********************************    
  #TRANSACCION:  'GM_FICVAR_SEL'
  #DESCRIPCION: Listado de equipos con ficha tecnica y variables de medicion
  #AUTOR:     rcm
  #FECHA:     21/03/2013
  ***********************************/

  elsif(p_transaccion in ('GM_FICVAR_SEL','GM_FICVAR_CONT'))then
            
      begin
          --raise exception 'id_loc: %, id_ucons: %',v_parametros.id_localizacion,v_parametros.id_uni_cons;
          --Verifica el filtro para ubicar los equipos a considerar
            if (pxp.f_existe_parametro(p_tabla,'id_localizacion')) then
              	if v_parametros.id_localizacion <> -1 then
                    v_ids = gem.f_get_id_localizaciones(v_parametros.id_localizacion);
                    v_cond = ' ucons.id_localizacion in ('||v_ids||')';
                else

                  if pxp.f_existe_parametro(p_tabla,'id_uni_cons') then
                        if v_parametros.id_uni_cons<>-1 then
                            v_cond = ' ucons.id_uni_cons = ' || v_parametros.id_uni_cons;
                        end if;
                    else
                      raise exception 'Localizacion/Equipo indefinido';
                    end if;
                end if;
            elsif (pxp.f_existe_parametro(p_tabla,'id_uni_cons')) then
              if v_parametros.id_uni_cons<>-1 then
                  v_cond = ' ucons.id_uni_cons = ' || v_parametros.id_uni_cons;
                else
                    raise exception 'Localizacion/Equipo indefinido';
                end if;
            else
                raise exception 'Localizacion/Equipo indefinido';
            end if;
        
        
          ---------------
            -- (1) CREACION DE LA TABLA TEMPORAL
            ---------------
          --Consulta para creación de la tabla temporal
        v_consulta = 'create temp table tt_reporte_ficha_var_'||p_id_usuario||'(
                        id_reporte serial,
                        id_uni_cons integer';

        v_con1 = 'select
                                  distinct tvar.id_tipo_variable::varchar as id, tvar.nombre
                                  from gem.tequipo_variable evar
                                  inner join gem.ttipo_variable tvar
                                  on tvar.id_tipo_variable = evar.id_tipo_variable
                                  inner join gem.tuni_cons ucons
                                  on ucons.id_uni_cons = evar.id_uni_cons
                                  inner join gem.ttipo_equipo_col tecol
                                  on tecol.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                                  and tecol.id::integer = tvar.id_tipo_variable
                                  and tecol.tipo_col = ''Variables''
                                  where ucons.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                                  and evar.estado_reg = ''activo''
                                  and ucons.estado_reg = ''activo''
                                  and ucons.tipo_nodo = ''raiz''';

            v_con1= v_con1 || ' and ' || v_cond;            
            v_con1 = v_con1 || ' and evar.tipo in (''numeric'',''formula'')';

            --Aumenta las columnas de las variables de medición        
            for v_rec in execute(v_con1) loop
                            
                v_cod = 'col_'||v_rec.id;
                v_consulta = v_consulta||', '||v_cod||'_key varchar';
                v_consulta = v_consulta||', '||v_cod||' varchar';
                  
            end loop;
            
            v_con1='select
                                  distinct lower(trim(udet.nombre)) as id, udet.nombre 
                                  from gem.tuni_cons_det udet
                                  inner join gem.tuni_cons ucons
                                  on ucons.id_uni_cons = udet.id_uni_cons
                                  inner join gem.ttipo_equipo_col tecol
                                  on tecol.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                                  and tecol.tipo_col = ''Ficha Tecnica''
                                  and tecol.id = lower(trim(udet.nombre))
                                  where ucons.id_tipo_equipo = ' || v_parametros.id_tipo_equipo || '
                                  and ucons.estado_reg = ''activo''
                                  and ucons.tipo_nodo = ''raiz''';

            v_con1 = v_con1 || ' and ' || v_cond;
            
            --Aumenta las columnas de la ficha técnica            
            for v_rec in execute(v_con1) loop

                v_cod = 'col_'||v_rec.id;
                v_consulta = v_consulta||', '||v_cod||'_key varchar';
                v_consulta = v_consulta||', '||v_cod||' varchar';
                  
            end loop;
              
            --Completa la sentencia de creación de la tabla temporal
            v_consulta =v_consulta||') on commit drop';

            --Creación de la tabla
            execute(v_consulta);
            
            -----------------
            -- (2) CARGADO DE DATOS
            -----------------
            --VARIABLES DE MEDICION
            v_consulta = 'select distinct evar.id_uni_cons
                          from gem.tequipo_variable evar
                          inner join gem.ttipo_variable tvar
                          on tvar.id_tipo_variable = evar.id_tipo_variable
                          inner join gem.tuni_cons ucons
                          on ucons.id_uni_cons = evar.id_uni_cons
                          inner join gem.tequipo_medicion emed
                          on emed.id_equipo_variable = evar.id_equipo_variable
                          where ucons.tipo = ''uc''
			              and ucons.estado_reg = ''activo''
			              and ucons.tipo_nodo = ''raiz''
			              and (ucons.estado=''aprobado'' or ucons.estado=''registrado'')
			              and ucons.id_tipo_equipo = '||v_parametros.id_tipo_equipo;

            v_consulta = v_consulta || ' and ' || v_cond;
            
      		v_consulta = v_consulta || ' and emed.fecha_medicion between '''|| v_parametros.fecha_ini||''' and '''|| v_parametros.fecha_fin||'''';
      		
            for v_rec in execute(v_consulta) loop
                v_consulta1= 'INSERT into tt_reporte_ficha_var_'||p_id_usuario||' (
                            id_uni_cons';

                  -- (valores) arma los valores de las columnas fijas
                v_consulta2= ') values('||v_rec.id_uni_cons;
             
             
            for v_rec1 in (select tva.id_tipo_variable,
                                 sum(em.medicion) as medicion
                                 from gem.tequipo_medicion em
                                 inner join gem.tequipo_variable ev
                                 on ev.id_equipo_variable = em.id_equipo_variable
                                 inner join gem.ttipo_variable tva on tva.id_tipo_variable = ev.id_tipo_variable
                                 inner join gem.ttipo_equipo_col tecol
                                 on tecol.id_tipo_equipo = v_parametros.id_tipo_equipo
                                 and tecol.id::integer = tva.id_tipo_variable
                                 and tecol.tipo_col = 'Variables'
                                 where ev.estado_reg = 'activo'
                                 and ev.tipo='numeric'
                                 and ev.id_uni_cons = v_rec.id_uni_cons
                                 and em.fecha_medicion between v_parametros.fecha_ini and v_parametros.fecha_fin
                                 group by  tva.id_tipo_variable) loop
                                 
                  v_cod = 'col_'||v_rec1.id_tipo_variable;
                    v_consulta1 = v_consulta1||','||v_cod||','||v_cod||'_key';
                    v_consulta2 = v_consulta2||','||quote_literal(v_rec1.medicion)||','||v_rec1.id_tipo_variable;

                                 
                end loop;
                
                -- Une las consultas
              v_consulta1 = v_consulta1||v_consulta2|| ') ';
                      
              -- Ejecuta (inserta) los datos
          execute(v_consulta1);
                
                --Formulas
                for v_rec1 in (select tva.id_tipo_variable,
                                 tva.nombre
                                 from gem.tequipo_variable ev
                                 inner join gem.ttipo_variable tva
                                 on tva.id_tipo_variable = ev.id_tipo_variable
                                 inner join gem.ttipo_equipo_col tecol
                                 on tecol.id_tipo_equipo = v_parametros.id_tipo_equipo
                                 and tecol.id::integer = tva.id_tipo_variable
                                 and tecol.tipo_col = 'Variables'
                                 where ev.estado_reg = 'activo'
                                 and ev.tipo='formula'
                                 and ev.id_uni_cons = v_rec.id_uni_cons
                                 --and em.fecha_medicion = v_rec.fecha_medicion
                ) loop
                                                     raise notice 'FFFF: %, %',v_rec1.nombre,v_rec.id_uni_cons;
                  v_tot=0;
          			if upper(trim(v_rec1.nombre))=upper('Rendimiento(Km/Lt)') then
                      	v_kil = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Kilometraje del mes',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_comb = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Consumo comb.(Lts)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_tot=-1;
                        if v_comb!=0 then
                          v_tot=round(v_kil/v_comb,2);
                        end if;
                    elsif upper(trim(v_rec1.nombre))=upper('Costo Total (Bs)') then
                      	v_ccomb = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Comb.(Bs.)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_parch = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Parchado (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_lub = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Lubricantes (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_lav = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Lavado (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_bat = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Batería (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_neu = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Neumatico (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto1 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto1.(Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto2 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto2.(Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto3 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto3.(Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto4 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto4.(Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto5 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto5.(Bs.)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_tot=v_ccomb+v_parch+v_lub+v_lav+v_bat+v_neu+v_mtto1+v_mtto2+v_mtto3+v_mtto4+v_mtto5;
                        
                        --raise exception '% % % % % % % % % % %',v_ccomb,v_parch,v_lub,v_lav,v_bat,v_neu,v_mtto1,v_mtto2,v_mtto3,v_mtto4,v_mtto5;
                    elsif upper(trim(v_rec1.nombre))=upper('Factor Costo (Bs/Km)') then
                      	v_kil = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Kilometraje del mes',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_ccomb = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Comb.(Bs.)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_parch = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Parchado (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_lub = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Lubricantes (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_lav = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Lavado (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_bat = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Batería (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_neu = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Neumatico (Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto1 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto1.(Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto2 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto2.(Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto3 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto3.(Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto4 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto4.(Bs)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_mtto5 = gem.f_get_valor_variable_medicion(v_parametros.id_tipo_equipo,'Costo Mtto5.(Bs.)',v_rec.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin);
                        v_tot=-1;
                        if v_kil!=0 then
                          v_tot=round((v_ccomb+v_parch+v_lub+v_lav+v_bat+v_neu+v_mtto1+v_mtto2+v_mtto3+v_mtto4+v_mtto5)/v_kil,2);
                        end if;
                    end if;
                    
                    v_cod = 'col_'||v_rec1.id_tipo_variable;
                    v_consulta1='UPDATE tt_reporte_ficha_var_'||p_id_usuario||' SET '||
                    v_cod||'='||quote_literal(v_tot)||','||
                    v_cod||'_key='||v_rec.id_uni_cons|| '
                    where id_uni_cons='||v_rec.id_uni_cons;

                    execute(v_consulta1);                     
                        
                end loop;
            
            end loop;
            
            --FICHA TECNICA
            v_consulta = 'select
                          udet.id_uni_cons, lower(trim(udet.nombre)) as id, udet.valor
                          from gem.tuni_cons_det udet
                          inner join gem.tuni_cons ucons
                          on ucons.id_uni_cons = udet.id_uni_cons
                          inner join gem.ttipo_equipo_col tecol
                          on tecol.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                          and tecol.tipo_col = ''Ficha Tecnica''
                          and tecol.id = lower(trim(udet.nombre))
                          where ucons.id_tipo_equipo = '||v_parametros.id_tipo_equipo;
                          
            v_consulta = v_consulta || ' and ' || v_cond;
                          
      v_consulta = v_consulta || ' order by udet.nombre';

      for v_rec in execute(v_consulta) loop
                /*v_consulta1= 'INSERT into tt_reporte_ficha_var_'||p_id_usuario||' (
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
                v_consulta1='UPDATE tt_reporte_ficha_var_'||p_id_usuario||' SET '||
                      v_cod||'='||quote_literal(v_rec.valor)||','||
                            v_cod||'_key='||v_rec.id_uni_cons|| '
                            where id_uni_cons='||v_rec.id_uni_cons;
            
              -- Ejecuta (inserta) los datos
          execute(v_consulta1);
            
            end loop;
            
            if(p_transaccion='GM_FICVAR_SEL') then
                v_consulta = 'select id, nombre, key from (
                              select
                              distinct tvar.id_tipo_variable::varchar as id, tvar.nombre, tvar.id_tipo_variable::varchar as key, tecol.orden
                              from gem.tequipo_variable evar
                              inner join gem.ttipo_variable tvar
                              on tvar.id_tipo_variable = evar.id_tipo_variable
                              inner join gem.tuni_cons ucons
                              on ucons.id_uni_cons = evar.id_uni_cons
                              inner join gem.ttipo_equipo_col tecol
                              on tecol.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                              and tecol.id::integer = tvar.id_tipo_variable
                              and tecol.tipo_col = ''Variables''
                              where ucons.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                              and evar.estado_reg = ''activo''
                              and ucons.estado_reg = ''activo''
                              and ucons.tipo_nodo = ''raiz''';

                v_consulta = v_consulta || ' and ' ||v_cond;

        v_consulta = v_consulta || ' and evar.tipo in (''numeric'',''formula'')';
                              
                              
                v_consulta = v_consulta || ' union
                              select
                              distinct lower(trim(udet.nombre)) as id, udet.nombre, lower(trim(udet.nombre)) as key, tecol.orden
                              from gem.tuni_cons_det udet
                              inner join gem.tuni_cons ucons
                              on ucons.id_uni_cons = udet.id_uni_cons
                              inner join gem.ttipo_equipo_col tecol
                              on tecol.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                              and tecol.tipo_col = ''Ficha Tecnica''
                              and tecol.id = lower(trim(udet.nombre))
                              where ucons.id_tipo_equipo = ' || v_parametros.id_tipo_equipo || '
                              and ucons.estado_reg = ''activo''
                              and ucons.tipo_nodo = ''raiz''';
                              
                v_consulta = v_consulta || ' and ' || v_cond;
                              
                v_consulta = v_consulta ||') FF order by FF.orden ';
                              
                --v_consulta1 = 'select b.codigo||'' - '' ||b.nombre as equipo,a.id_reporte,a.id_uni_cons';
                v_consulta1 = 'select b.codigo as equipo,a.id_reporte,a.id_uni_cons,c.nombre as desc_localizacion';
                for v_rec in execute(v_consulta) loop
                  v_cod = 'col_'||v_rec.id;
                  v_consulta1 = v_consulta1||', a.'||v_cod||'_key';
                  v_consulta1 = v_consulta1||', a.'||v_cod;
                end loop;

              v_consulta1 = v_consulta1 || ' from tt_reporte_ficha_var_'||p_id_usuario ||' a
                                              inner join gem.tuni_cons b
                                              on b.id_uni_cons = a.id_uni_cons
                                              inner join gem.tlocalizacion c
                                              on c.id_localizacion = b.id_localizacion';
                                              
                --raise exception 'FFFF, %',v_consulta1;
            else 
              v_consulta1 = 'select count(id_reporte)
                  from tt_reporte_ficha_var_'||p_id_usuario ||' a
                  inner join gem.tuni_cons b
                        on b.id_uni_cons = a.id_uni_cons';
            
            end if;
            
            
            return v_consulta1;
            
    end;
        
    /*********************************    
  #TRANSACCION:  'GM_TODFIC_SEL'
  #DESCRIPCION: Lista todas las columnas de las fichas técnicas de todos los equipos de un id_tipo_equipo
  #AUTOR:     rcm
  #FECHA:     22/03/2013
  ***********************************/

  elsif(p_transaccion='GM_TODFIC_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
                        distinct lower(trim(udet.nombre))::varchar as id, udet.nombre 
                        from gem.tuni_cons_det udet
                        inner join gem.tuni_cons ucons
                        on ucons.id_uni_cons = udet.id_uni_cons
                where ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by 1 asc limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GM_TODFIC_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:     rcm
  #FECHA:     11/03/2013
  ***********************************/

  elsif(p_transaccion='GM_TODFIC_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select
                        count(distinct(upper(udet.nombre)))
                        from gem.tuni_cons_det udet
                        inner join gem.tuni_cons ucons
                        on ucons.id_uni_cons = udet.id_uni_cons
                where ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
        
   /*********************************    
  #TRANSACCION:  'GM_COFIVA_SEL'
  #DESCRIPCION: COlumnas FIcha VAriables: lista de la ficha técnica y las variables
  #AUTOR:     rcm
  #FECHA:     25/03/2013
  ***********************************/

  elsif(p_transaccion='GM_COFIVA_SEL')then
            
      begin
        
          --Verifica el filtro para ubicar los equipos a considerar
            if (pxp.f_existe_parametro(p_tabla,'id_localizacion')) then
              if v_parametros.id_localizacion <> -1 then
                    v_ids = gem.f_get_id_localizaciones(v_parametros.id_localizacion);
                    v_cond = ' ucons.id_localizacion in ('||v_ids||')';
                else
                  if pxp.f_existe_parametro(p_tabla,'id_uni_cons') then
                        if v_parametros.id_uni_cons<>-1 then
                            v_cond = ' ucons.id_uni_cons = ' || v_parametros.id_uni_cons;
                        end if;
                    else
                      raise exception 'Localizacion/Equipo indefinido';
                    end if;
                end if;
            elsif (pxp.f_existe_parametro(p_tabla,'id_uni_cons')) then
              if v_parametros.id_uni_cons<>-1 then
                  v_cond = ' ucons.id_uni_cons = ' || v_parametros.id_uni_cons;
                else
                    raise exception 'Localizacion/Equipo indefinido';
                end if;
            else
                raise exception 'Localizacion/Equipo indefinido';
            end if;
            
            --Forma la consulta
            v_consulta = 'select id, nombre, key from (
                      select
                          distinct tvar.id_tipo_variable::varchar as id, tvar.nombre, tvar.id_tipo_variable::varchar as key, tecol.orden
                          from gem.tequipo_variable evar
                          inner join gem.ttipo_variable tvar
                          on tvar.id_tipo_variable = evar.id_tipo_variable
                          inner join gem.tuni_cons ucons
                          on ucons.id_uni_cons = evar.id_uni_cons
                          inner join gem.ttipo_equipo_col tecol
                          on tecol.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                          and tecol.id::integer = tvar.id_tipo_variable
                          and tecol.tipo_col = ''Variables''
                          where ucons.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                          and evar.estado_reg = ''activo''
                          and ucons.estado_reg = ''activo''
                          and ucons.tipo_nodo = ''raiz''';

            v_consulta = v_consulta || ' and ' || v_cond;
            
            v_consulta = v_consulta || ' and evar.tipo in (''numeric'',''formula'')';
                          
                          
      v_consulta = v_consulta || ' union
                    select
                          distinct lower(trim(udet.nombre)) as id, udet.nombre, lower(trim(udet.nombre)) as key, tecol.orden
                          from gem.tuni_cons_det udet
                          inner join gem.tuni_cons ucons
                          on ucons.id_uni_cons = udet.id_uni_cons
                          inner join gem.ttipo_equipo_col tecol
                          on tecol.id_tipo_equipo = ' || v_parametros.id_tipo_equipo ||'
                          and tecol.tipo_col = ''Ficha Tecnica''
                          and tecol.id = lower(trim(udet.nombre))
                          where ucons.id_tipo_equipo = ' || v_parametros.id_tipo_equipo || '
                          and ucons.estado_reg = ''activo''
                          and ucons.tipo_nodo = ''raiz''';
      
          v_consulta = v_consulta || ' and ' || v_cond || ') FF order by FF.orden ';
            raise notice 'DDD:%', v_consulta;
                          
      return v_consulta;
        
        end;
        
    /*********************************    
  #TRANSACCION:  'GM_COFIVA_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:     rcm
  #FECHA:     25/03/2013
  ***********************************/

  elsif(p_transaccion='GM_COFIVA_CONT')then

    begin
        
          --Verifica el filtro para ubicar los equipos a considerar
            if (pxp.f_existe_parametro(p_tabla,'id_localizacion')) then
              if v_parametros.id_localizacion <> -1 then
                    v_ids = gem.f_get_id_localizaciones(v_parametros.id_localizacion);
                    v_cond = ' ucons.id_localizacion in ('||v_ids||')';
                else
                  if pxp.f_existe_parametro(p_tabla,'id_uni_cons') then
                        if v_parametros.id_uni_cons<>-1 then
                            v_cond = ' ucons.id_uni_cons = ' || v_parametros.id_uni_cons;
                        end if;
                    else
                      raise exception 'Localizacion/Equipo indefinido';
                    end if;
                end if;
            elsif (pxp.f_existe_parametro(p_tabla,'id_uni_cons')) then
              if v_parametros.id_uni_cons<>-1 then
                  v_cond = ' ucons.id_uni_cons = ' || v_parametros.id_uni_cons;
                else
                    raise exception 'Localizacion/Equipo indefinido';
                end if;
            else
                raise exception 'Localizacion/Equipo indefinido';
            end if;
            
            
      --Sentencia de la consulta de conteo de registros
      --Forma la consulta
            v_consulta = 'SELECT count(id) FROM (select
                          distinct tvar.id_tipo_variable::varchar as id, tvar.nombre
                          from gem.tequipo_variable evar
                          inner join gem.ttipo_variable tvar
                          on tvar.id_tipo_variable = evar.id_tipo_variable
                          inner join gem.tuni_cons ucons
                          on ucons.id_uni_cons = evar.id_uni_cons
                          where ucons.id_tipo_equipo = ' || v_parametros.id_tipo_equipo || '
                          and evar.estado_reg = ''activo''
                          and ucons.estado_reg = ''activo''
                          and ucons.tipo_nodo = ''raiz''';

            v_consulta = v_consulta || ' and ' || v_cond;
            
            v_consulta = v_consulta || ' and evar.tipo in (''numeric'',''formula'')';
                          
      v_consulta = v_consulta || ' union
                    select
                          distinct lower(trim(udet.nombre)) as id, udet.nombre 
                          from gem.tuni_cons_det udet
                          inner join gem.tuni_cons ucons
                          on ucons.id_uni_cons = udet.id_uni_cons
                          where ucons.id_tipo_equipo = ' || v_parametros.id_tipo_equipo || '
                          and ucons.estado_reg = ''activo''
                          and ucons.tipo_nodo = ''raiz''';

            v_consulta = v_consulta || ' and ' || v_cond || ' ) FF';

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