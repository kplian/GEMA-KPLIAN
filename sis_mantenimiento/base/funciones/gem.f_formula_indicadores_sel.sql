CREATE OR REPLACE FUNCTION gem.f_formula_indicadores_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS SETOF record AS
$body$
/**************************************************************************
 PXP - KPLIAN
***************************************************************************
 SCRIPT: 		gem.f_formula_indicadores_sel
 DESCRIPCION: 	
 AUTOR: 		RCM
 FECHA:			19/12/2012
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCIÓN:
 AUTOR:       
 FECHA:      

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCION --
--------------------------

-- PARAMETROS FIJOS
/*
pm_id_usuario                               integer (si)
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

DECLARE

	v_consulta 		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp			varchar;
	g_registros  record;

	v_rec record;
	v_sql varchar;
	v_ids varchar;
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

	v_nombre_funcion = 'gem.f_formula_indicadores_sel';
	v_parametros = pxp.f_get_record(p_tabla);

	--Algoritmo de calculo de los indicadores (General para cualquiera de las dos transacciones)
	--1. Validaciones
		--1.1 Verificacion de existencia de la localizacion
		if not exists(select 1 from gem.tlocalizacion
				where id_localizacion = v_parametros.id_localizacion) then
			raise exception 'Localizacion inexistente';
		end if;
		--1.2 Verificacion de cantidad de horas que no puede ser cero ni nulo
		if coalesce(v_parametros.num_dias,0)=0 then
			raise exception 'La Cantidad de dias debe ser mayor a cero';
		end if;

		--2. Calculo de las horas totales en funcion de la cantidad de dias
		v_horas_tot = v_parametros.num_dias * 24;

		--3. Obtencion de los ids de localizacion
		WITH RECURSIVE t(id,id_fk,nombre,n) AS (
			SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
			FROM gem.tlocalizacion l 
			WHERE l.id_localizacion = v_parametros.id_localizacion
			UNION ALL
			SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,n+1
			FROM gem.tlocalizacion l, t
			WHERE l.id_localizacion_fk = t.id
		)
		SELECT (pxp.list(id::text))::varchar
		INTO v_ids
		FROM t;

		--raise exception '%',v_ids;

		--v_ids = v_parametros.id_localizacion::varchar;

		--4. Creacion de la tabla temporal para guardar los indicadores
		create temporary table tt_indicadores(
				tot_paros integer,
				tot_op numeric,
				tot_stand numeric,
				tot_mnp numeric,
				tot_mpp numeric,
				disp numeric,
				conf numeric,
				tmef numeric,
				tmpr numeric
			) on commit drop;

		--5. Obtencion de las mediciones de los ids y en las fechas solicitadas
		v_sql = 'insert into tt_indicadores
			select
			coalesce(sum(num_paros),0) as tot_paros, coalesce(sum(tiempo_op_hrs),0) as tot_op,
			coalesce(sum(tiempo_standby_hrs),0) as tot_stand, coalesce(sum(tiempo_mnp_hrs),0) as tot_mnp,
			coalesce(sum(tiempo_mpp_hrs),0) as tot_mpp
			from gem.tlocalizacion_med
			where id_localizacion in ('||v_ids||')
			and fecha_med between '''||v_parametros.fecha_ini || '''and '''||v_parametros.fecha_fin||'''';
		raise notice '%',v_sql;
		execute(v_sql);
		
		--6. Calculo de indicadores
		for v_rec in (select * from tt_indicadores) loop
			--Disponibilidad
			v_disp = (v_horas_tot - v_rec.tot_mnp - v_rec.tot_mpp) / v_horas_tot * 100;
			--TMEF
			if v_rec.tot_paros = 0 then
				v_tmef = 0;
				v_tmef_obs = 'No hubieron paros por falla en este período';
			else
				v_tmef = (v_horas_tot - v_rec.tot_mnp) / v_rec.tot_paros;
			end if;
			--TMPR
			if v_rec.tot_paros = 0 then
				v_tmpr = 0;
				v_tmpr_obs = 'No hubieron paros por falla en este período';
			else
				v_tmpr = v_rec.tot_mnp / v_rec.tot_paros;
			end if;
			--Confiabilidad
			if v_horas_tot = 0 then
				v_conf=0;
				v_conf_obs='El tiempo total es cero)';
			else
				--v_conf = (v_tmef/v_tmef + v_tmpr) * 100;
				v_conf = ((v_horas_tot - v_rec.tot_mnp)/v_horas_tot)*100;
			end if;
			
		end loop;

		--7. Creacion de tabla temporal para los resultados
		create temporary table tt_indicadores_res(
				nombre varchar(50),
				indicador numeric,
				observaciones varchar(300)
			) on commit drop;

		--7. Almacena los resultados en una temporal
		insert into tt_indicadores_res(nombre, indicador, observaciones) values('Disponibilidad (%)',v_disp,v_disp_obs);
		insert into tt_indicadores_res(nombre, indicador, observaciones) values('TMEF (Horas)',v_tmef,v_tmef_obs);
		insert into tt_indicadores_res(nombre, indicador, observaciones) values('Confiabilidad (%)',v_conf,v_conf_obs);
		insert into tt_indicadores_res(nombre, indicador, observaciones) values('TMPR (Horas)',v_tmpr,v_tmpr_obs);
		
	--FIN

	/*********************************    
 	#TRANSACCION:  'GEM_FORIND_SEL'
 	#DESCRIPCION:	Resultado de las formulas de los indicadores
 	#AUTOR:		RCM
 	#FECHA:		19-12-2012
	***********************************/

	IF(p_transaccion='GEM_FORIND_SEL')then
	    begin
		--8. Consulta de respuesta

		for v_rec in (select nombre, round(indicador,2), observaciones
				from tt_indicadores_res) loop
			return next v_rec;
		end loop;
		
		return;
	    end;
	/*********************************    
 	#TRANSACCION:  'GEM_FORIND_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rcm
 	#FECHA:		19-12-2012
	***********************************/

	elsif(p_transaccion='GEM_FORIND_CONT')then

		begin

		

			--8. Consulta de respuesta
			--v_consulta = 'select count(nombre) from tt_indicadores_res';
		    
			/*for v_rec in (select count(nombre) from tt_indicadores_res) loop
				return next v_rec;
			end loop;
			raise exception 'bien %',v_consulta;
			return;*/

			FOR g_registros in (select count(nombre) from tt_indicadores_res) LOOP
			     RETURN NEXT g_registros;
		   END LOOP;

		end;

	ELSE
					     
		raise exception 'Transaccion inexistente';
    
	END IF;


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
COST 100 ROWS 1000;