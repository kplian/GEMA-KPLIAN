CREATE OR REPLACE FUNCTION gem.ft_rep_presupuesto_periodo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS SETOF record AS
$body$
/*
Fecha: 03/07/2013
Autor: RCM
Propósito: Devolver el presupuesto de varios periodos en columnas
*/
DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
	v_i 				integer;
    v_rec 				record;
    v_cont 				integer;
    v_sql 				varchar;
    v_sw_col 			boolean;

BEGIN

	v_nombre_funcion = 'gem.ft_rep_presupuesto_periodo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_REPPRE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			rcm
 	#FECHA:			04/07/2013
	***********************************/

	if(p_transaccion='GM_REPPRE_SEL')then
     				
    	begin
            --Verifica que el mes ini sea menor o igual que el mes fin
            if v_parametros.mes_ini > v_parametros.mes_fin then
                raise exception 'El mes Inicial debe ser menor o igual que el mes Final';
            end if;

            --1. Crear tabla temporal con un solo mes, que adelante sera complementada con mas campos para mas meses si es el caso
            create temp table tt_presupuesto_periodo(
              id_localizacion integer,
              localizacion varchar(500),
              monto_prog_1 numeric(18,2),
              monto_techo_1 numeric(18,2),
              porcen_prog_techo_1 numeric(18,2),
              monto_presup_1 numeric(18,2),
              monto_ejec_1 numeric(18,2),
              porcen_presup_ejec_1 numeric(18,2)
            ) on commit drop;
            
            --2. Obtener los datos del presupuesto y los periodos indicados
            --3. Procesar los presupuestos por cada mes e ir cargando los datos en la tabla temporal    
            v_cont=1;
            for v_i in v_parametros.mes_ini.. v_parametros.mes_fin loop
                for v_rec in (select
                              ploc.mes, ploc.id_localizacion,
                              gem.f_get_nombre_localizacion_rec(ploc.id_localizacion,'padres') as desc_localizacion,
                              coalesce(ploc.monto_prog,0) as monto_prog,
                              coalesce(ploc.monto_techo,0) as monto_techo,
                              coalesce(ploc.porcen_prog_techo,0) as porcen_prog_techo,
                              coalesce(ploc.monto_presup,0) as monto_presup,
                              coalesce(ploc.monto_ejec,0) as monto_ejec,
                              coalesce(case coalesce(ploc.monto_presup,0)
                                when 0 then 0::numeric
                                else ploc.monto_ejec/ploc.monto_presup
                              end,0) as porcen_presup_ejec
                              from gem.tpresupuesto_loc ploc
                              where ploc.id_presupuesto = v_parametros.id_presupuesto
                              and ploc.mes::integer = v_i) loop
                              raise notice '%',v_cont;
                    if v_cont = 1 then
                        insert into tt_presupuesto_periodo(
                        id_localizacion,localizacion, monto_prog_1, monto_techo_1,porcen_prog_techo_1,
                        monto_presup_1, monto_ejec_1, porcen_presup_ejec_1
                        ) values(
                        v_rec.id_localizacion,v_rec.desc_localizacion, v_rec.monto_prog, v_rec.monto_techo, v_rec.porcen_prog_techo,
                        v_rec.monto_presup, v_rec.monto_ejec,v_rec.porcen_presup_ejec
                        );
                    else
                        --crear nuevas columnas
                        if not v_sw_col then
                            v_sw_col = true;
                            v_sql = 'alter table tt_presupuesto_periodo
                                    add column monto_prog_'||v_cont||' numeric(18,2),
                                    add column monto_techo_'||v_cont||' numeric(18,2),
                                    add column porcen_prog_techo_'||v_cont||' numeric(18,2),
                                    add column monto_presup_'||v_cont||' numeric(18,2),
                                    add column monto_ejec_'||v_cont||' numeric(18,2),
                                    add column porcen_presup_ejec_'||v_cont||' numeric(18,2)';
                            execute(v_sql);
                        end if;
                        --update de datos
                        v_sql = 'update tt_presupuesto_periodo set
                                 monto_prog_'||v_cont||'='||v_rec.monto_prog||',
                                  monto_techo_'||v_cont||'='||v_rec.monto_techo||',
                                  porcen_prog_techo_'||v_cont||'='||v_rec.porcen_prog_techo||',
                                  monto_presup_'||v_cont||'='||v_rec.monto_presup||',
                                  monto_ejec_'||v_cont||'='||v_rec.monto_ejec||',
                                  porcen_presup_ejec_'||v_cont||'='||v_rec.porcen_presup_ejec||'
                                  where id_localizacion = '||v_rec.id_localizacion;
                        execute(v_sql);
                    
                    end if;
                end loop;
                v_cont = v_cont + 1;
                v_sw_col = false;
            end loop;
            
            --Inserta linea al final con los totales
            v_sql = 'insert into tt_presupuesto_periodo';
            
            
            v_sql = v_sql || ' select ''0'', ''TOTALES	'',
                    sum(monto_prog_1), sum(monto_techo_1), sum(porcen_prog_techo_1), sum(monto_presup_1),
                    sum(monto_ejec_1), sum(porcen_presup_ejec_1)';
                  
            for v_i in 2..v_cont-1 loop
                v_sql = v_sql || ',sum(monto_prog_'||v_i||'),
                                sum(monto_techo_'||v_i||'),
                                sum(porcen_prog_techo_'||v_i||'),
                                sum(monto_presup_'||v_i||'),
                                sum(monto_ejec_'||v_i||'),
                                sum(porcen_presup_ejec_'||v_i||')';
            end loop;
            
            v_sql = v_sql || 'from tt_presupuesto_periodo';
            
            execute(v_sql);
            
            for v_rec in (select * from tt_presupuesto_periodo) loop
                return next v_rec;
            end loop;

        	return;

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
COST 100 ROWS 1000;