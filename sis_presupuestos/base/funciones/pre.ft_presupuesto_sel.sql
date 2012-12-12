CREATE OR REPLACE FUNCTION pre.ft_presupuesto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de presupuesto
 FUNCION: 		pre.ft_presupuesto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'pre.tpresupuesto'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        26-11-2012 21:35:35
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;    
    v_sql				varchar;
    v_saldos			record;
    v_insertado			record;			
			    
BEGIN

	v_nombre_funcion = 'pre.ft_presupuesto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PRE_PRE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-11-2012 21:35:35
	***********************************/

	if(p_transaccion='PRE_PRE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						pre.id_presupuesto,
						pre.estado_reg,
						pre.descripcion,
						pre.estado,
						pre.gestion,
						pre.codigo,
						pre.fecha_reg,
						pre.id_usuario_reg,
						pre.fecha_mod,
						pre.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from pre.tpresupuesto pre
						inner join segu.tusuario usu1 on usu1.id_usuario = pre.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pre.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PRE_PRE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		26-11-2012 21:35:35
	***********************************/

	elsif(p_transaccion='PRE_PRE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_presupuesto)
					    from pre.tpresupuesto pre
					    inner join segu.tusuario usu1 on usu1.id_usuario = pre.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pre.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
        
    elsif(p_transaccion='PRE_SALPRE_SEL')then
     				
    	begin
        	--1. Crear tabla temporal
            v_sql = 'create temp table tt_pres_saldo(
            			id_presupuesto integer,
                        id_partida integer,
                        monto_presup numeric(18,2),
                        monto_ejec numeric(18,2),
                        mes numeric,
                        centro_costo varchar(20)
            		)
            	';
            execute (v_sql);
            --b. Crear tabla para presupuesto anual
            v_sql='create temp table tt_presup_anual(id_partida integer,id_presupuesto integer, centro_costo varchar(20),
            presup_ene numeric, ejec_ene numeric, presup_feb numeric, ejec_feb numeric,
            presup_mar numeric, ejec_mar numeric, presup_abr numeric, ejec_abr numeric,
            presup_may numeric, ejec_may numeric, presup_jun numeric, ejec_jun numeric,
            presup_jul numeric, ejec_jul numeric, presup_ago numeric, ejec_ago numeric,
            presup_sep numeric, ejec_sep numeric, presup_oct numeric, ejec_oct numeric,
            presup_nov numeric, ejec_nov numeric, presup_dic numeric, ejec_dic numeric)';
			execute(v_sql);           
            
            --2. Obtener los montos presupuestados
            v_sql = 'insert into tt_pres_saldo(id_presupuesto, id_partida, monto_presup, mes, centro_costo)
            		select
                    pre.id_presupuesto, presupart.id_partida, sum(presupart.importe),                    
                    date_part(''month'',presupart.fecha_hora) as mes,
                    cen.codigo as centro_costo
                    from pre.tpresupuesto pre
                    inner join pre.tpresup_partida presupart on presupart.id_presupuesto=pre.id_presupuesto
                    left join gem.tcentro_costo cen on cen.id_centro_costo=presupart.id_centro_costo
                    where presupart.tipo = ''presupuestado'' and pre.id_presupuesto IN ('||v_parametros.id_presupuesto||') 
                        and presupart.fecha_hora BETWEEN '''||v_parametros.fecha_ini||''' AND '''||v_parametros.fecha_fin||'''
                        and presupart.id_partida IN ('||v_parametros.id_partida||')
                    group by pre.id_presupuesto, presupart.id_partida, mes, centro_costo';
            execute(v_sql);
            
            --3. Obtener los montos ejecutados
            v_sql = 'update tt_pres_saldo set
                    monto_ejec = ff.ejecutado
                    from (select
                    pre.id_presupuesto, presupart.id_partida, sum(presupart.importe) as ejecutado,
                    date_part(''month'',presupart.fecha_hora) as mes
                    from pre.tpresupuesto pre
                    inner join pre.tpresup_partida presupart
                    on presupart.id_presupuesto=pre.id_presupuesto
                    where presupart.tipo = ''ejecutado'' and pre.id_presupuesto IN ('||v_parametros.id_presupuesto||') 
                    and presupart.fecha_hora BETWEEN '''||v_parametros.fecha_ini||''' AND '''||v_parametros.fecha_fin||'''
                        and presupart.id_partida IN ('||v_parametros.id_partida||')
                    group by pre.id_presupuesto, presupart.id_partida,mes) ff
                    where tt_pres_saldo.id_presupuesto = ff.id_presupuesto
                    and tt_pres_saldo.id_partida = ff.id_partida and tt_pres_saldo.mes=ff.mes';
            execute (v_sql);
        
    		--Sentencia de la consulta
			v_consulta:='select * from tt_pres_saldo';
                                 
            FOR v_saldos IN EXECUTE (v_consulta)
            LOOP            	
                select * into v_insertado from tt_presup_anual where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                IF NOT FOUND THEN
                	insert into tt_presup_anual(id_partida,id_presupuesto,centro_costo)values(
                	v_saldos.id_partida,v_saldos.id_presupuesto,v_saldos.centro_costo);
                END IF;
                if(trunc(v_saldos.mes)=1)then
                  update tt_presup_anual set presup_ene=v_saldos.monto_presup, ejec_ene=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=2)then
				  update tt_presup_anual set presup_feb=v_saldos.monto_presup, ejec_feb=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=3)then
                  update tt_presup_anual set presup_mar=v_saldos.monto_presup, ejec_mar=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=4)then
                  update tt_presup_anual set presup_abr=v_saldos.monto_presup, ejec_abr=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=5)then
                  update tt_presup_anual set presup_may=v_saldos.monto_presup, ejec_may=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=6)then
                  update tt_presup_anual set presup_jun=v_saldos.monto_presup, ejec_jun=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=7)then
                  update tt_presup_anual set presup_jul=v_saldos.monto_presup, ejec_jul=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=8)then
                  update tt_presup_anual set presup_ago=v_saldos.monto_presup, ejec_ago=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=9)then
                  update tt_presup_anual set presup_sep=v_saldos.monto_presup, ejec_sep=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=10)then
                  update tt_presup_anual set presup_oct=v_saldos.monto_presup, ejec_oct=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                elsif(trunc(v_saldos.mes)=11)then
                  update tt_presup_anual set presup_nov=v_saldos.monto_presup, ejec_nov=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                else
                  update tt_presup_anual set presup_dic=v_saldos.monto_presup, ejec_dic=v_saldos.monto_ejec
                   where id_partida=v_saldos.id_partida and id_presupuesto=v_saldos.id_presupuesto;
                end if;
            END LOOP;            
            v_consulta:='select presanu.id_partida, par.codigo as codigo_part,
             presanu.id_presupuesto, pre.codigo as codigo_pres,presanu.centro_costo, 
             presup_ene, ejec_ene,
             presup_feb, ejec_feb, presup_mar, ejec_mar, presup_abr, ejec_abr,
             presup_may, ejec_may, presup_jun, ejec_jun, presup_jul, ejec_jul,
             presup_ago, ejec_ago, presup_sep, ejec_sep, presup_oct, ejec_oct,
             presup_nov, ejec_nov, presup_dic, ejec_dic from tt_presup_anual presanu
             inner join pre.tpartida par on par.id_partida=presanu.id_partida
             inner join pre.tpresupuesto pre on pre.id_presupuesto=presanu.id_presupuesto';
             
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