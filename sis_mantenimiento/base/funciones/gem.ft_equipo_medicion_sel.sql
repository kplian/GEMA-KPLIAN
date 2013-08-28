CREATE OR REPLACE FUNCTION gem.ft_equipo_medicion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
SISTEMA: SISTEMA DE GESTION DE MANTENIMIENTO
FUNCION: gem.ft_equipo_medicion_sel
DESCRIPCION: Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tequipo_medicion'
AUTOR: (admin)
FECHA: 27-09-2012 03:02:35
COMENTARIOS:
***************************************************************************
HISTORIAL DE MODIFICACIONES:

DESCRIPCION:
AUTOR:
FECHA:
***************************************************************************/

DECLARE

  v_consulta varchar;
    v_consulta1 varchar;
    v_consulta2 varchar;
  v_parametros record;
  v_nombre_funcion text;
  v_resp varchar;
    g_registros record;
    g_registros2 record;
    v_cod varchar;
    v_cod2 varchar;
    v_pos integer;
    v_ids varchar;
    v_cond varchar;
    v_kilometraje numeric;
    v_combustible numeric;
    v_rend numeric;
    v_aux text;
    v_columnas varchar;
    v_col_rend varchar;
    v_col_kil varchar;
    v_col_comb varchar;
    v_aux1 varchar;
    v_tot numeric;
    v_tot1 numeric;
    
    v_col_02 varchar;
    v_col_03 varchar;
    v_col_04 varchar;
    v_col_05 varchar;
    v_col_06 varchar;
    v_col_07 varchar;
    v_col_08 varchar;
    v_col_09 varchar;
    v_col_10 varchar;
    v_col_11 varchar;
    v_col_12 varchar;
    v_col_13 varchar;
    v_col_14 varchar;
    v_col_15 varchar;
    v_col_16 varchar;
    v_col_17 varchar;
    
    v_col_val_02 numeric;
    v_col_val_03 numeric;
    v_col_val_04 numeric;
    v_col_val_05 numeric;
    v_col_val_06 numeric;
    v_col_val_07 numeric;
    v_col_val_08 numeric;
    v_col_val_09 numeric;
    v_col_val_10 numeric;
    v_col_val_11 numeric;
    v_col_val_12 numeric;
    v_col_val_13 numeric;
    v_col_val_14 numeric;
    v_col_val_15 numeric;
    v_col_val_16 numeric;
    v_col_val_17 numeric;

BEGIN

    v_nombre_funcion = 'gem.ft_equipo_medicion_sel';
    v_parametros = pxp.f_get_record(p_tabla);
    v_columnas = '';
    v_col_rend = '';
    v_col_kil = '';
    v_col_comb = '';

/*********************************
#TRANSACCION: 'GEM_GEMEDI_SEL'
#DESCRIPCION: Consulta de datos
#AUTOR: admin
#FECHA: 27-09-2012 03:02:35
***********************************/

if(p_transaccion='GEM_GEMEDI_SEL')then
     
     begin
     --Sentencia de la consulta
v_consulta:='select
gemedi.id_equipo_medicion,
gemedi.id_equipo_variable,
gemedi.observaciones,
gemedi.estado_reg,
gemedi.fecha_medicion,
gemedi.medicion,
gemedi.id_usuario_reg,
gemedi.fecha_reg,
gemedi.id_usuario_mod,
gemedi.fecha_mod,
usu1.cuenta as usr_reg,
usu2.cuenta as usr_mod,
geeqva.valor_max,
geeqva.valor_min,
getiva.nombre as nombre_tipo_variable,
getiva.descripcion as desc_tipo_variable,
paunme.codigo as desc_unidad_medida,
geeqva.id_uni_cons,
geunco.codigo as cod_equipo,
geunco.nombre as desc_equipo
from gem.tequipo_medicion gemedi
inner join segu.tusuario usu1 on usu1.id_usuario = gemedi.id_usuario_reg
left join segu.tusuario usu2 on usu2.id_usuario = gemedi.id_usuario_mod
inner join gem.tequipo_variable geeqva on geeqva.id_equipo_variable = gemedi.id_equipo_variable
inner join gem.ttipo_variable getiva on getiva.id_tipo_variable = geeqva.id_tipo_variable
inner join param.tunidad_medida paunme on paunme.id_unidad_medida = getiva.id_unidad_medida
inner join gem.tuni_cons geunco on geunco.id_uni_cons = geeqva.id_uni_cons
where ';

--Definicion de la respuesta
v_consulta:=v_consulta||v_parametros.filtro;
v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

--Devuelve la respuesta
return v_consulta;

end;

/*********************************
#TRANSACCION: 'GEM_GEMEDI_CONT'
#DESCRIPCION: Conteo de registros
#AUTOR: admin
#FECHA: 27-09-2012 03:02:35
***********************************/

elsif(p_transaccion='GEM_GEMEDI_CONT')then

begin
--Sentencia de la consulta de conteo de registros
v_consulta:='select count(id_equipo_medicion)
from gem.tequipo_medicion gemedi
inner join segu.tusuario usu1 on usu1.id_usuario = gemedi.id_usuario_reg
left join segu.tusuario usu2 on usu2.id_usuario = gemedi.id_usuario_mod
inner join gem.tequipo_variable geeqva on geeqva.id_equipo_variable = gemedi.id_equipo_variable
inner join gem.ttipo_variable getiva on getiva.id_tipo_variable = geeqva.id_tipo_variable
inner join param.tunidad_medida paunme on paunme.id_unidad_medida = getiva.id_unidad_medida
where ';

--Definicion de la respuesta
v_consulta:=v_consulta||v_parametros.filtro;

--Devuelve la respuesta
return v_consulta;

end;

/*********************************
#TRANSACCION: 'GEM_MEDGRA_SEL'
#DESCRIPCION: Conteo de registros
#AUTOR: rcm
#FECHA: 28-09-2012 22:09
***********************************/

elsif(p_transaccion='GEM_MEDGRA_SEL')then

begin
--Sentencia de la consulta de conteo de registros
v_consulta:='select
equmed.id_equipo_medicion,equvar.id_uni_cons, equipo.codigo, equipo.nombre, tipvar.nombre as var_nombre, tipvar.descripcion as var_desc,
unimed.codigo as cod_unimed, unimed.descripcion as unimed_desc, equmed.fecha_medicion, equmed.medicion
from gem.tequipo_medicion equmed
inner join gem.tequipo_variable equvar on equvar.id_equipo_variable = equmed.id_equipo_variable
inner join gem.ttipo_variable tipvar on tipvar.id_tipo_variable = equvar.id_tipo_variable
inner join param.tunidad_medida unimed on unimed.id_unidad_medida = tipvar.id_unidad_medida
inner join gem.tuni_cons equipo on equipo.id_uni_cons = equvar.id_uni_cons
where ';

--Definicion de la respuesta
v_consulta:=v_consulta||v_parametros.filtro;

--Devuelve la respuesta
return v_consulta;

end;

/*********************************
#TRANSACCION: 'GEM_MEDGRA_CONT'
#DESCRIPCION: Conteo de registros
#AUTOR: rcm
#FECHA: 22/09/2012 22:09
***********************************/

elsif(p_transaccion='GEM_MEDGRA_CONT')then

begin
--Sentencia de la consulta de conteo de registros
v_consulta:='select count(id_equipo_medicion)
from gem.tequipo_medicion equmed
inner join gem.tequipo_variable equvar on equvar.id_equipo_variable = equmed.id_equipo_variable
inner join gem.ttipo_variable tipvar on tipvar.id_tipo_variable = equvar.id_tipo_variable
inner join param.tunidad_medida unimed on unimed.id_unidad_medida = tipvar.id_unidad_medida
inner join gem.tuni_cons equipo on equipo.id_uni_cons = equvar.id_uni_cons
where ';

--Definicion de la respuesta
v_consulta:=v_consulta||v_parametros.filtro;

--Devuelve la respuesta
return v_consulta;

end;
/*********************************
#TRANSACCION: 'GEM_EQMDI_SEL'
#DESCRIPCION: coonsulta dinamica a las mediciones del equipo indicado
#AUTOR: rac
#FECHA: 12/11/2012
***********************************/

elseif(p_transaccion='GEM_EQMEDI_SEL')then

begin
        
            --1) crear tabla temporal segun la fecha inicio y ficha final indicada
        
          v_consulta = 'create temp table tt_mediciones_equipo_'||p_id_usuario||'(
id_mediciones_mes serial,
fecha date,
hora time,
observaciones varchar
';
        
         
          FOR g_registros in (select
                            eqv.id_equipo_variable,
                            eqv.estado_reg,
                            eqv.valor_max,
                            eqv.id_uni_cons,
                            eqv.obs,
                            eqv.valor_min,
                            eqv.id_tipo_variable,
                            eqv.id_usuario_reg,
                            eqv.fecha_reg,
                            eqv.id_usuario_mod,
                            eqv.fecha_mod,
                            tva.nombre as nombre_tipo_variable
                            from gem.tequipo_variable eqv
                            inner join gem.ttipo_variable tva on tva.id_tipo_variable = eqv.id_tipo_variable
                            where eqv.estado_reg = 'activo'
                            and eqv.tipo='numeric'
                            and eqv.id_uni_cons = v_parametros.id_uni_cons
                            order by eqv.id_equipo_variable) LOOP
            
            v_cod= 'col_'||g_registros.id_equipo_variable;
   
            --semana 1
            v_cod2=v_cod||'_time';
            v_consulta =v_consulta||', '||v_cod||' varchar';
            v_consulta =v_consulta||', '||v_cod||'_key integer';
         
           end loop;
          
          --concatena el finald e la creacion
           v_consulta =v_consulta||') on commit drop';
          
          --crea tabla
          
           raise notice 'CREA TABLA TEMPORAL,%',v_consulta;
           execute(v_consulta);
          
       
         -- LLenamos la tabla temporal
                       
          -- 2) FOR consulta las fechas de la tabla equipo medicion filtrados por uni_cons,
-- raise exception 'paciencia';
               FOR g_registros in (select DISTINCT em.fecha_medicion, em.hora, coalesce(em.observaciones,'') as observaciones
                                      from gem.tequipo_medicion em
                                      inner join gem.tequipo_variable ev
                                      on ev.id_equipo_variable = em.id_equipo_variable
                                      where ev.id_uni_cons = v_parametros.id_uni_cons
                                              and ev.estado_reg = 'activo' and ev.tipo='numeric'
                                                and em.fecha_medicion between v_parametros.fecha_ini and v_parametros.fecha_fin
                                      order by em.fecha_medicion) LOOP
-- raise notice 'PPPPPPP %',v_consulta2;
                      --2.0) (atributos) arma primera parte de la cadena de insercion con datos del equipo y del mantenimiento
     
               
            v_consulta1= 'INSERT into tt_mediciones_equipo_'||p_id_usuario||' (
fecha,
hora,
observaciones ';
                                                       
  -- (valores) arma la cadena de insercion de valores
         

             v_consulta2= ') values('''||g_registros.fecha_medicion||''','''||g_registros.hora||''','''||g_registros.observaciones||'''';
                            
                       -- raise notice 'fytftttrfd%',v_consulta2;
                                                                              
                    
                     --2.1) FOR consulta los registros de la tabla equipo medicion agrupados por fecha y unic_cons,
                      FOR g_registros2 in (select ev.id_equipo_variable,
                                                   em.id_equipo_medicion,
                                                   em.medicion,
                                                   em.hora
                                            from gem.tequipo_medicion em
                                            inner join gem.tequipo_variable ev
                                            on ev.id_equipo_variable = em.id_equipo_variable
                                            inner join gem.ttipo_variable tva on tva.id_tipo_variable = ev.id_tipo_variable
                         
                                            where ev.estado_reg = 'activo' and ev.tipo='numeric'
                                                   AND ev.id_uni_cons = v_parametros.id_uni_cons
                                                   and em.fecha_medicion = g_registros.fecha_medicion
                                                   and em.hora = g_registros.hora
                                            ) LOOP
            
                       -- 2.1.1) arma consulta de insercion
                       v_cod = 'col_'||g_registros2.id_equipo_variable;
                       
                       --revisa si la medicion no se repita para la misma fecha y hora
                       --si se repeti nos quedamos con la primera
                       v_pos = position (v_cod in v_consulta1);
                       
                        if(v_pos = 0) then
                           v_consulta1=v_consulta1||','||v_cod||','||v_cod||'_key';
                           v_consulta2=v_consulta2||','''||g_registros2.medicion||''','||g_registros2.id_equipo_medicion;
                        end if;
                      
                      END LOOP;
                      
                       -- 2.2) finaliza la cadena de insercion
                      
                       v_consulta1 = v_consulta1||v_consulta2|| ') ';
         
                      
                      -- 2.3) inserta los datos en la tabla temporal
                      
                      raise notice 'INSERCION %',v_consulta1;
   
     execute(v_consulta1);
        
             END LOOP;
          
         -- 3) consulta de la tabla temporal
         
         
         
         v_consulta:='select * from tt_mediciones_equipo_'||p_id_usuario||' where '||v_parametros.filtro;
v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

         
--Devuelve la respuesta
return v_consulta;
         
       
end;
    /*********************************
#TRANSACCION: 'GEM_EQMEDI_CONT'
#DESCRIPCION: Conteo de registros de la consulta dinamica de mediciones por quipo
#AUTOR: rac
#FECHA: 22/09/2012 22:09
***********************************/

elsif(p_transaccion='GEM_EQMEDI_CONT')then

begin
--Sentencia de la consulta de conteo de registros
v_consulta:='select count (DISTINCT (em.fecha_medicion,em.hora))
from gem.tequipo_medicion em
inner join gem.tequipo_variable ev
on ev.id_equipo_variable = em.id_equipo_variable
where ev.id_uni_cons = '||v_parametros.id_uni_cons||'
and ev.estado_reg = ''activo'' and ev.tipo=''numeric''';


--Devuelve la respuesta
            
           -- raise exception '%',v_consulta;
return v_consulta;

end;
    
    /*********************************
	#TRANSACCION: 'GEM_LOMECO_SEL'
	#DESCRIPCION: Mediciones consolidades por Localización
	#AUTOR: rcm
	#FECHA: 14/02/2013
	***********************************/
	elsif(p_transaccion='GEM_LOMECO_SEL')then
     
		begin
        
        	--1.Obtención de los IDs para obtención de los equipos
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
            
            --2.Creación de tabla temporal para almacenar las mediciones
			create temp table tt_uni_cons_med(
	        	nombre varchar,
	            total numeric,
	            unidad_medida varchar,
	            descripcion varchar,
	            orden integer
	        ) on commit drop;
            
        
      		--3.Sentencia de la consulta de conteo de registros
      		v_consulta:='insert into tt_uni_cons_med
							select
			                tvar.nombre,sum(eqmed.medicion) as total,umed.codigo as unidad_medida, umed.descripcion, tvar.orden
			                from gem.tuni_cons ucons
			                inner join gem.tequipo_variable eqvar
			                on eqvar.id_uni_cons = ucons.id_uni_cons
			                inner join gem.tequipo_medicion eqmed
			                on eqmed.id_equipo_variable = eqvar.id_equipo_variable
			                inner join gem.ttipo_variable tvar
			                on tvar.id_tipo_variable = eqvar.id_tipo_variable
			                inner join param.tunidad_medida umed
			                on umed.id_unidad_medida = tvar.id_unidad_medida
			                where ucons.tipo = ''uc'' and ucons.tipo_nodo = ''raiz'' and ucons.estado_reg = ''activo''
			                and ' || v_cond || '
			                and eqvar.tipo = ''numeric''
			                and eqmed.fecha_medicion between ''' || v_parametros.fecha_desde || ''' and ''' || v_parametros.fecha_hasta || '''
			                group by tvar.nombre,umed.codigo, umed.descripcion,tvar.orden';
      
                  raise notice '%', v_consulta;
                        
            execute(v_consulta);
            
            --Verifica si alguno de los equipos tienen fórmulas
            v_consulta = 'select
			                distinct tvar.nombre as nombre, tvar.orden
			                from gem.tuni_cons ucons
			                inner join gem.tequipo_variable eqvar
			                on eqvar.id_uni_cons = ucons.id_uni_cons
			                inner join gem.ttipo_variable tvar
			                on tvar.id_tipo_variable = eqvar.id_tipo_variable
			                inner join param.tunidad_medida umed
			                on umed.id_unidad_medida = tvar.id_unidad_medida
			                where ucons.tipo = ''uc'' and ucons.tipo_nodo = ''raiz'' and ucons.estado_reg = ''activo''
			                and ' || v_cond || '
			                and eqvar.tipo = ''formula''
			                group by tvar.nombre, tvar.orden';
			                
			for g_registros in execute(v_consulta) loop
				if g_registros.nombre = 'Costo Total (Bs)' then
					--Se obtiene la suma de todos los costos
					select coalesce(sum(total),0)
					into v_tot
					from tt_uni_cons_med
					where nombre in ('Costo Comb.(Bs.)','Costo Parchado (Bs)','Costo Lubricantes (Bs)','Costo Lavado (Bs)','Costo Batería (Bs)','Costo Neumatico (Bs)','Costo Mtto1.(Bs)','Costo Mtto2.(Bs)','Costo Mtto3.(Bs)','Costo Mtto4.(Bs)','Costo Mtto5.(Bs.)');
					--Inserción del cálculo de la fórmula
					insert into tt_uni_cons_med(nombre, total,unidad_medida,descripcion,orden) values(g_registros.nombre, round(v_tot,2), 'Bs.', 'Bolivianos',g_registros.orden);

				elsif  g_registros.nombre = 'Rendimiento(Km/Lt)' then
					select coalesce(sum(total),0)
					into v_tot
					from tt_uni_cons_med
					where nombre in ('Kilometraje del mes');
					select coalesce(sum(total),0)
					into v_tot1
					from tt_uni_cons_med
					where nombre in ('Consumo comb.(Lts)');
					
					if v_tot1 > 0 then
						v_tot=v_tot/v_tot1;
					else
						v_tot=0;
					end if;
					
					--Inserción del cálculo de la fórmula
					insert into tt_uni_cons_med(nombre, total,unidad_medida,descripcion,orden) values(g_registros.nombre, round(v_tot,2), 'Km/Lt', 'Kilómetros por Litro',g_registros.orden);
				
				elsif g_registros.nombre = 'Factor Costo (Bs/Km)' then
					--Se obtiene la suma de todos los costos
					select coalesce(sum(total),0)
					into v_tot
					from tt_uni_cons_med
					where nombre in ('Costo Comb.(Bs.)','Costo Parchado (Bs)','Costo Lubricantes (Bs)','Costo Lavado (Bs)','Costo Batería (Bs)','Costo Neumatico (Bs)','Costo Mtto1.(Bs)','Costo Mtto2.(Bs)','Costo Mtto3.(Bs)','Costo Mtto4.(Bs)','Costo Mtto5.(Bs)');
					select coalesce(sum(total),0)
					into v_tot1
					from tt_uni_cons_med
					where nombre in ('Kilometraje del mes');
					
					if v_tot1 > 0 then
						v_tot=v_tot/v_tot1;
					else
						v_tot=0;
					end if;
					
					--Inserción del cálculo de la fórmula
					insert into tt_uni_cons_med(nombre, total,unidad_medida,descripcion,orden) values(g_registros.nombre, round(v_tot,2), 'Bs/Km', 'Bolivianos por Kilómetro',g_registros.orden);
				
				end if;
			end loop;
            
		v_consulta = 'select nombre, total, unidad_medida, descripcion
        				from tt_uni_cons_med
                        order by orden';

	    --Devuelve la respuesta
    	return v_consulta;

	end;

/*********************************
#TRANSACCION: 'GEM_LOMECO_CONT'
#DESCRIPCION: Conteo de registros
#AUTOR: rcm
#FECHA: 14/02/2013
***********************************/

elsif(p_transaccion='GEM_LOMECO_CONT')then

begin
        
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
      v_consulta:='select count(*)
                        from (select
                        tvar.nombre,sum(eqmed.medicion) as total,umed.codigo as unidad_medida, umed.descripcion
                        from gem.tuni_cons ucons
                        inner join gem.tequipo_variable eqvar
                        on eqvar.id_uni_cons = ucons.id_uni_cons
                        inner join gem.tequipo_medicion eqmed
                        on eqmed.id_equipo_variable = eqvar.id_equipo_variable
                        inner join gem.ttipo_variable tvar
                        on tvar.id_tipo_variable = eqvar.id_tipo_variable
                        inner join param.tunidad_medida umed
                        on umed.id_unidad_medida = tvar.id_unidad_medida
                        where ucons.tipo = ''uc'' and ucons.tipo_nodo = ''raiz'' and ucons.estado_reg = ''activo''
                        and ' || v_cond || '
                        and eqmed.fecha_medicion between ''' || v_parametros.fecha_desde || ''' and ''' || v_parametros.fecha_hasta || '''
                        group by tvar.nombre,umed.codigo, umed.descripcion) med';

            raise notice 'AA%', v_consulta;

      --Devuelve la respuesta
      return v_consulta;

    end;
        
    /*********************************
    #TRANSACCION: 'GEM_EQMECO_SEL'
    #DESCRIPCION: coonsulta dinamica a las mediciones del consolidado
    #AUTOR: rcm
    #FECHA: 11/03/2013
    ***********************************/

    elseif(p_transaccion='GEM_EQMECO_SEL' or p_transaccion = 'GEM_EQMECO_CONT')then

        begin
        
          -------------------------------------------------------
          -- (1) CREACION DE LA TABLA TEMPORAL CON COLUMNAS DINAMICAS
          -------------------------------------------------------
          --Columnaa fijas
          v_consulta = 'create temp table tt_mediciones_equipo_'||p_id_usuario||'(
                  		id_uni_cons integer,
                        id_mediciones_mes serial,
                        fecha date,
                        hora time,
                        observaciones varchar
                        ';
			-------------------------------------------------------
	        -- (2) OBTENCION DE LOS IDS PARA OBTENER LOS EQUIPOS
	        -------------------------------------------------------
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
         
         	-------------------------------------------------------
	        -- (3) OBTENCION DE LAS VARIABLES DE TODOS LOS EQUIPOS FILTRADOS
	        -------------------------------------------------------
         	v_aux = 'select distinct
                  tva.id_tipo_variable,
                  tva.nombre as nombre_tipo_variable,
                  tva.orden
                  from gem.tequipo_variable eqv
                  inner join gem.ttipo_variable tva on tva.id_tipo_variable = eqv.id_tipo_variable
                  inner join gem.tuni_cons ucons on ucons.id_uni_cons = eqv.id_uni_cons
                  where eqv.estado_reg = ''activo'' and eqv.tipo in (''numeric'',''formula'')
                  and ucons.estado_reg = ''activo''
                  and ucons.tipo_nodo = ''raiz''
                  and '||v_cond||'
                  order by tva.orden';
         
			--Bucle para completar las columnas de la tabla temporal a crear
         	v_columnas = 'ucons.codigo as equipo,med.id_uni_cons, med.id_mediciones_mes, med.fecha, med.hora, med.observaciones';

          	for g_registros in execute(v_aux) loop
              	v_cod= 'col_'||g_registros.id_tipo_variable;
              
				--Verifica si existe la columna de rendimiento
				if trim(g_registros.nombre_tipo_variable) = 'Kilometraje del mes' then
				 	v_col_02 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Consumo comb.(Lts)' then
				 	v_col_03 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Comb.(Bs.)' then
				 	v_col_04 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Parchado (Bs)' then
				 	v_col_05 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Lubricantes (Bs)' then
				 	v_col_06 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Lavado (Bs)' then
				 	v_col_07 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Batería (Bs)' then
				 	v_col_08 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Neumatico (Bs)' then
				 	v_col_09 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Mtto1.(Bs)' then
				 	v_col_10 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Mtto2.(Bs)' then
				 	v_col_11 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Mtto3.(Bs)' then
				 	v_col_12 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Mtto4.(Bs)' then
				 	v_col_13 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable)= 'Costo Mtto5.(Bs.)' then
				 	v_col_14 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Costo Total (Bs)' then
				 	v_col_15 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Rendimiento(Km/Lt)' then
				 	v_col_16 = v_cod;
				elsif trim(g_registros.nombre_tipo_variable) = 'Factor Costo (Bs/Km)' then
				 	v_col_17 = v_cod; 
				end if;
				 
				v_cod2=v_cod||'_time';
				v_consulta =v_consulta||', '||v_cod||' varchar';
				v_consulta =v_consulta||', '||v_cod||'_key integer';
				
				if upper(trim(g_registros.nombre_tipo_variable)) = 'RENDIMIENTO' then
					v_columnas = v_columnas || ',med.' ||v_cod||',rend_key';
				else
					v_columnas = v_columnas || ',med.' ||v_cod||',med.'||v_cod||'_key';
				end if;
            
			end loop;
         
			--Concatena el finald e la creacion
           	v_consulta =v_consulta||') on commit drop';
          
          	--Creación de la tabla con todas las columnas fijas y dinámicas
           	execute(v_consulta);
           
            --Verifica si existe la columna Rendimiento para aumentar en la consulta
      		if v_col_rend != '' and v_col_kil != '' and v_col_comb != '' then
            	v_aux1 = 'round(med.'||v_col_kil ||'::numeric/med.'||v_col_comb || '::numeric,2)::varchar as '||v_col_rend;
                v_columnas = replace(v_columnas,'med.'||v_col_rend,v_aux1);
                v_columnas = replace(v_columnas,'rend_key',v_col_rend||'_key');
      		end if;
       
            ----------------------------------------------
            -- (4) CARGADO DE DATOS EN LA TABLA TEMPORAL
            ----------------------------------------------

			--FOR consulta las fechas de la tabla equipo medicion filtrados por uni_cons
    		--Se obtiene la fecha, hora, observacion por equipo para llenar todas las mediciones de una hora y fecha en una fila
    		v_aux= 'select DISTINCT ucons.id_uni_cons, em.fecha_medicion, em.hora,
	                coalesce(em.observaciones,'''') as observaciones
	                from gem.tequipo_medicion em
	                inner join gem.tequipo_variable ev
	                on ev.id_equipo_variable = em.id_equipo_variable
	                inner join gem.tuni_cons ucons
	                on ucons.id_uni_cons = ev.id_uni_cons
	                where '||v_cond||'
	                and ev.estado_reg = ''activo'' and ev.tipo=''numeric''
	                and ucons.estado_reg = ''activo''
	                and ucons.tipo_nodo = ''raiz''
	                and em.fecha_medicion between '''|| v_parametros.fecha_ini||''' and '''|| v_parametros.fecha_fin||'''
	                order by em.fecha_medicion';

    		FOR g_registros in execute(v_aux) LOOP
            	--2(atributos) arma las columnas de las columnas fijas

      			v_consulta1= 'INSERT into tt_mediciones_equipo_'||p_id_usuario||' (
                  			id_uni_cons,
	                        fecha,
	                        hora,
	                        observaciones ';

        		--(valores) arma los valores de las columnas fijas
             	v_consulta2= ') values('||g_registros.id_uni_cons||','''||g_registros.fecha_medicion||''','''||g_registros.hora||''','''||g_registros.observaciones||'''';

            	--2.1) FOR consulta los registros de la tabla equipo medicion agrupados por fecha y uni_cons,
      			FOR g_registros2 in (select tva.id_tipo_variable,
	                                 em.id_equipo_medicion,
	                                 em.medicion,
	                                 em.hora,
	                                 tva.nombre as nombre_tipo_variable
	                                 from gem.tequipo_medicion em
	                                 inner join gem.tequipo_variable ev
	                                 on ev.id_equipo_variable = em.id_equipo_variable
	                                 inner join gem.ttipo_variable tva on tva.id_tipo_variable = ev.id_tipo_variable
	                                 where ev.estado_reg = 'activo' and ev.tipo='numeric'
	                                 and ev.id_uni_cons = g_registros.id_uni_cons
	                                 and em.fecha_medicion = g_registros.fecha_medicion
	                                 and em.hora = g_registros.hora) LOOP
					--2.1.1) arma consulta de insercion
	                v_cod = 'col_'||g_registros2.id_tipo_variable;
	                                       
	                --revisa si la medicion no se repita para la misma fecha y hora
	                --si se repeti nos quedamos con la primera
	                v_pos = position (v_cod in v_consulta1);
	                                       
	                if(v_pos = 0) then
	                    v_consulta1=v_consulta1||','||v_cod||','||v_cod||'_key';
	                    --v_consulta2=v_consulta2||','''||quote_literal(g_registros2.medicion)||''','||g_registros2.id_equipo_medicion;
	                    v_consulta2=v_consulta2||','||quote_literal(g_registros2.medicion)||','||g_registros2.id_equipo_medicion;
	                end if;
	                
	                --Guarda valores para las posibles fórmulas
					if trim(g_registros2.nombre_tipo_variable) = 'Kilometraje del mes' then
					 	v_col_val_02 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Consumo comb.(Lts)' then
					 	v_col_val_03 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Comb.(Bs.)' then
					 	v_col_val_04 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Parchado (Bs)' then
					 	v_col_val_05 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Lubricantes (Bs)' then
					 	v_col_val_06 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Lavado (Bs)' then
					 	v_col_val_07 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Batería (Bs)' then
					 	v_col_val_08 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Neumatico (Bs)' then
					 	v_col_val_09 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Mtto1.(Bs)' then
					 	v_col_val_10 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Mtto2.(Bs)' then
					 	v_col_val_11 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Mtto3.(Bs)' then
					 	v_col_val_12 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Mtto4.(Bs)' then
					 	v_col_val_13 = g_registros2.medicion;
					elsif trim(g_registros2.nombre_tipo_variable) = 'Costo Mtto5.(Bs.)' then
					 	v_col_val_14 = g_registros2.medicion;
					end if;
                      
				END LOOP;

		      	--Verifica existencia de fórmulas
		      	v_aux = 'select distinct
		                  tva.id_tipo_variable,
		                  tva.nombre as nombre_tipo_variable,
		                  tva.orden
		                  from gem.tequipo_variable eqv
		                  inner join gem.ttipo_variable tva on tva.id_tipo_variable = eqv.id_tipo_variable
		                  inner join gem.tuni_cons ucons on ucons.id_uni_cons = eqv.id_uni_cons
		                  where eqv.estado_reg = ''activo'' and eqv.tipo =''formula''
		                  and ucons.estado_reg = ''activo''
		                  and ucons.tipo_nodo = ''raiz''
		                  and '||v_cond||'
		                  order by tva.orden';

        		for g_registros in execute(v_aux) loop
        			if g_registros.nombre_tipo_variable = 'Costo Total (Bs)' then
		        		v_tot = coalesce(v_col_val_04,0)+coalesce(v_col_val_05,0)+coalesce(v_col_val_06,0)+coalesce(v_col_val_07,0)+coalesce(v_col_val_08,0)+coalesce(v_col_val_09,0)+coalesce(v_col_val_10,0)+coalesce(v_col_val_11,0)+coalesce(v_col_val_12,0)+coalesce(v_col_val_13,0)+coalesce(v_col_val_14,0);
		        		v_consulta1=v_consulta1||','||v_col_15||','||v_col_15||'_key';
	                    v_consulta2=v_consulta2||','||quote_literal(round(v_tot,2))||',null';
					elsif g_registros.nombre_tipo_variable = 'Rendimiento(Km/Lt)' then
						v_tot=0;
						if v_col_val_03 > 0 then
							v_tot = coalesce(v_col_val_02,0)/coalesce(v_col_val_03,0);
						end if;
						v_consulta1=v_consulta1||','||v_col_16||','||v_col_16||'_key';
	                    v_consulta2=v_consulta2||','||quote_literal(round(v_tot,2))||',null';
					elsif g_registros.nombre_tipo_variable = 'Factor Costo (Bs/Km)' then
						v_tot=0;
						if v_col_val_02 > 0 then
							v_tot = (coalesce(v_col_val_04,0)+coalesce(v_col_val_05,0)+coalesce(v_col_val_06,0)+coalesce(v_col_val_07,0)+coalesce(v_col_val_08,0)+coalesce(v_col_val_09,0)+coalesce(v_col_val_10,0)+coalesce(v_col_val_11,0)+coalesce(v_col_val_12,0)+coalesce(v_col_val_13,0)+coalesce(v_col_val_14,0))/coalesce(v_col_val_02,0);
						end if;
						v_consulta1=v_consulta1||','||v_col_17||','||v_col_17||'_key';
	                    v_consulta2=v_consulta2||','||quote_literal(round(v_tot,2))||',null';
					end if;

        		end loop;
        		
        		-- 2.2) finaliza la cadena de insercion
		        v_consulta1 = v_consulta1||v_consulta2|| ') ';
                 
		        -- 2.3) inserta los datos en la tabla temporal
		        execute(v_consulta1);
      
			END LOOP;
    
     -- 3) consulta de la tabla temporal
    if(p_transaccion='GEM_EQMECO_SEL') then
    	--Verifica si tiene fórmulas
    	/*v_aux = 'select distinct
                  tva.id_tipo_variable,
                  tva.nombre as nombre_tipo_variable,
                  tva.orden
                  from gem.tequipo_variable eqv
                  inner join gem.ttipo_variable tva on tva.id_tipo_variable = eqv.id_tipo_variable
                  inner join gem.tuni_cons ucons on ucons.id_uni_cons = eqv.id_uni_cons
                  where eqv.estado_reg = ''activo'' and eqv.tipo =''formula''
                  and ucons.estado_reg = ''activo''
                  and ucons.tipo_nodo = ''raiz''
                  and '||v_cond||'
                  order by tva.orden';
        for g_registros in execute(v_aux) loop
        	if g_registros.nombre_tipo_variable = 'Costo Total (Bs)' then
        		v_columnas = v_columnas || ',('||v_col_04||'+'||v_col_05||'+'||v_col_06||'+'||v_col_07||'+'||v_col_08||'+'||v_col_09||'+'||v_col_10||'+'||v_col_11||'+'||v_col_12||'+'||v_col_13||'+'||v_col_14||') as costo_total'; 
			elsif  g_registros.nombre_tipo_variable = 'Rendimiento(Km/Lt)' then
				v_columnas = v_columnas || ',('||v_col_02||'/'||v_col_03||') as rendimiento';
			elsif g_registros.nombre_tipo_variable = 'Factor Costo (Bs/Km)' then
				v_columnas = v_columnas || ',(('||v_col_04||'+'||v_col_05||'+'||v_col_06||'+'||v_col_07||'+'||v_col_08||'+'||v_col_09||'+'||v_col_10||'+'||v_col_11||'+'||v_col_12||'+'||v_col_13||'+'||v_col_14||')/'||v_col_02||') as factor_costo';
			end if;
        end loop;*/
    	
    	--Define la consulta de datos
        v_consulta:='select '||v_columnas||'
                    from tt_mediciones_equipo_'||p_id_usuario||' med
                    inner join gem.tuni_cons ucons on ucons.id_uni_cons = med.id_uni_cons
                    where '||v_parametros.filtro;
       
        v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' ||
        			v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
    else
        v_consulta:='select count (id_mediciones_mes)
              		from tt_mediciones_equipo_'||p_id_usuario||' med
                    inner join gem.tuni_cons ucons on ucons.id_uni_cons = med.id_uni_cons
             		where '||v_parametros.filtro;
    end if; 

    --Devuelve la respuesta
--    raise exception 'SQL: %',v_consulta;
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