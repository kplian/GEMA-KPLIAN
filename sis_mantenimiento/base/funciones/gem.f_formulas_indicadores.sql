-- Function: gem.f_formulas_indicadores(integer, integer, date, date)

-- DROP FUNCTION gem.f_formulas_indicadores(integer, integer, date, date);

CREATE OR REPLACE FUNCTION gem.f_formulas_indicadores(p_id_localizacion integer, p_num_dias integer, p_fecha_ini date, p_fecha_fin date)
  RETURNS SETOF record AS
$BODY$
DECLARE

	v_rec record;
	v_sql varchar;
	v_ids integer;
	v_horas_tot numeric;
	v_disp numeric=0;
	v_conf numeric=0;
	v_tmef numeric=0;
	v_tmpr numeric=0;

	v_disp_obs varchar='';
	v_conf_obs varchar='';
	v_tmef_obs varchar='';
	v_tmpr_obs varchar='';

BEGIN

	--1. Validaciones
	--1.1 Verificacion de existencia de la localizacion
	if not exists(select 1 from gem.tlocalizacion
			where id_localizacion = p_id_localizacion) then
		raise exception 'Localizacion inexistente';
	end if;
	--1.2 Verificacion de cantidad de horas que no puede ser cero ni nulo
	if coalesce(p_num_dias,0)=0 then
		raise exception 'La Cantidad de dias debe ser mayor a cero';
	end if;

	--2. Calculo de las horas totales en funcion de la cantidad de dias
	v_horas_tot = p_num_dias * 24;

	--3. Obtencion de los ids de localizacion
	v_ids = p_id_localizacion::varchar;

	--4. Creacion de la tabla temporal para guardar los indicadores
	v_sql = 'create temp table tt_indicadores(
			tot_paros integer,
			tot_op numeric,
			tot_stand numeric,
			tot_mnp numeric,
			tot_mpp numeric,
			disp numeric,
			conf numeric,
			tmef numeric,
			tmpr numeric
		) on commit drop';

	execute(v_sql);

	--5. Obtencion de las mediciones de los ids y en las fechas solicitadas
	v_sql = 'insert into tt_indicadores
		select
		coalesce(sum(num_paros),0) as tot_paros, coalesce(sum(tiempo_op_hrs),0) as tot_op,
		coalesce(sum(tiempo_standby_hrs),0) as tot_stand, coalesce(sum(tiempo_mnp_hrs),0) as tot_mnp,
		coalesce(sum(tiempo_mpp_hrs),0) as tot_mpp
		from gem.tlocalizacion_med
		where id_localizacion in ('||v_ids||')
		and fecha_med between '''||p_fecha_ini || '''and '''||p_fecha_fin||'''';
raise notice '%',v_sql;
	execute(v_sql);

	--6. Calculo de indicadores
	for v_rec in execute('select * from tt_indicadores') loop
		--Disponibilidad
		v_disp = (v_horas_tot - v_rec.tot_mnp - v_rec.tot_mpp) / v_horas_tot * 100;
		--TMEF
		if v_rec.tot_paros = 0 then
			v_tmef = -1;
			v_tmef_obs = 'Valor no valido: la cantidad de paros en este periodo es cero (division por cero)';
		else
			v_tmef = (v_horas_tot - v_rec.tot_mnp) / v_rec.tot_paros;
		end if;
		--TMPR
		if v_rec.tot_paros = 0 then
			v_tmpr = -1;
			v_tmpr_obs = 'Valor no valido: la cantidad de paros en este periodo es cero (division por cero)';
		else
			v_tmpr = v_rec.tot_mnp / v_rec.tot_paros;
		end if;
		--Confiabilidad
		if v_tmef + v_tmpr = 0 then
			v_conf=-1;
			v_conf_obs='Valor no valido: TMEF y TMPR suman cero (division por cero)';
		else
			v_conf = (v_tmef/v_tmef + v_tmpr) * 100;
		end if;
		
	end loop;

	--7. Creacion de tabla temporal para los resultados
	v_sql = 'create temp table tt_indicadores_res(
			nombre varchar(50),
			indicador numeric,
			observaciones varchar(300)
		) on commit drop';
	execute(v_sql);
	--7. Almacena los resultados en una temporal
	v_sql = 'insert into tt_indicadores_res values(''Disponibilidad (%)'','||v_disp||','''||v_disp_obs||''');';
	v_sql = v_sql||'insert into tt_indicadores_res values(''TMEF (Horas)'','||v_tmef||','''||v_tmef_obs||''');';
	v_sql = v_sql||'insert into tt_indicadores_res values(''Confiabilidad (%)'','||v_conf||','''||v_conf_obs||''');';
	v_sql = v_sql||'insert into tt_indicadores_res values(''TMPR (Horas)'','||v_tmpr||','''||v_tmpr_obs||''');';
raise notice '%',v_sql;
	execute(v_sql);

	--8. COnsulta de respuesta
	for v_rec in execute('select nombre,indicador,observaciones from tt_indicadores_res') loop
		return next v_rec;
	end loop;
	return;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION gem.f_formulas_indicadores(integer, integer, date, date) OWNER TO postgres;