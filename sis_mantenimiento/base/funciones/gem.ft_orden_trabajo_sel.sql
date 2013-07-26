CREATE OR REPLACE FUNCTION gem.ft_orden_trabajo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_orden_trabajo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.torden_trabajo'
 AUTOR: 		 (admin)
 FECHA:	        30-08-2012 02:48:41
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
    v_cargo				varchar;
    v_filtro			varchar;
    v_id_funcionario	varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_orden_trabajo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEOOTT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		30-08-2012 02:48:41
	***********************************/

	if(p_transaccion='GEM_GEOOTT_SEL')then
     				
    	begin
        	
        	select tipo
        	into v_cargo
        	from gem.tlocalizacion_usuario 
            where id_usuario = p_id_usuario
            and estado_reg = 'activo'
            offset 0 limit 1;
            
            if v_cargo is null then
            	v_cargo = 'Operador';
            end if;

            select tf.id_funcionario
            into v_id_funcionario
            from orga.tfuncionario tf
            inner join segu.tusuario tu on tf.id_persona = tu.id_persona
            where tu.id_usuario = p_id_usuario 
            and tf.estado_reg = 'activo'
            offset 0 limit 1;
            
        	if p_administrador = 1 then
           		v_filtro = ' 0=0 and ';
            elseif v_cargo in('Gerente','Ingeniero','Jefe','Asistente') then
	            v_filtro =  p_id_usuario::varchar||' = ANY (unicons.id_usuarios) and ';
            elseif (v_cargo = 'Operador' and (v_id_funcionario is not null)) then
            	v_filtro =  '('||v_id_funcionario||' = geoott.id_funcionario_asig or geoott.id_usuario_reg = '||p_id_usuario||') and ';
            else 
            	raise exception 'Debes ser un funcionario para poder ver estas ordenes de trabajo';
            end if;
            
    		--Sentencia de la consulta
			v_consulta:='select
						geoott.id_orden_trabajo,
						geoott.estado_reg,
						geoott.fecha_plan_ini,
						geoott.fecha_eje_ini,
						geoott.tiempo_estimado,
						geoott.num_oit,
						geoott.nota_tecnico_equipo,
						geoott.observacion,
						geoott.acumulado,
						geoott.codigo_oit,
						geoott.fecha_emision,
						geoott.id_funcionario_asig,
						geoott.id_unidad_medida,
						geoott.descripcion,
						geoott.id_funcionario_sol,
						geoott.ubicacion_tecnica,
						geoott.fecha_eje_fin,
						geoott.id_uni_cons_mant_predef,
						geoott.id_tipo_mant,
						geoott.nota_tecnico_loc,
						geoott.id_uni_cons,
                        geoott.cat_estado,
                        geoott.cat_prior,
                        geoott.cat_tipo,
						geoott.id_usuario_reg,
						geoott.fecha_reg,
						geoott.id_usuario_mod,
						geoott.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						fun.desc_funcionario1 as desc_person,
						fun1.desc_funcionario1 as desc_person1,
						(unicons.codigo || '' - '' ||unicons.nombre)::varchar as equipo,
						(tipman.codigo||'' - ''||tipman.nombre)::varchar as tipo_mant,
						unimed.descripcion as desc_unidad_medida,
                        geoott.id_localizacion,
                        local.nombre as nombre_localizacion,
                        geoott.descripcion_lugar,
                        geoott.id_centro_costo,
                        cencost.codigo as codigo_centro_costo,
                        geoott.especialidades,
                        geoott.id_funcionario_aprob,
                        fun2.desc_funcionario1 as desc_funcionario_aprob,
                        geoott.id_funcionario_recib,
                        fun3.desc_funcionario1 as desc_funcionario_recib,
                        geoott.comentarios,
                        geoott.accidentes,
                        geoott.reclamos,
                        geoott.otros,
                        geoott.hora_eje_inicio,
        	    		geoott.hora_eje_fin,
						unicons.codigo,
						geoott.descripcion_causa,
						geoott.prevension,
						geoott.descripcion_progresiva,
						geoott.id_cuenta,
						cue.nro_cuenta ||'' - ''||cue.nombre_cuenta as desc_cuenta,
						now()::date as fecha_server,
						cue.nro_cuenta as cuenta,
						geoott.id_mant_predef,
						coalesce(mpre.codigo,'''') || '' - '' || coalesce(mpre.nombre,'''')  as desc_mant_predef,
						geoott.id_orden_trabajo_sol,
						otsol.nro_sol as desc_ot_sol
						from gem.torden_trabajo geoott
						inner join segu.tusuario usu1 on usu1.id_usuario = geoott.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geoott.id_usuario_mod
						left join orga.vfuncionario fun on fun.id_funcionario = geoott.id_funcionario_sol
						left join orga.vfuncionario fun1 on fun1.id_funcionario = geoott.id_funcionario_asig
                        left join orga.vfuncionario fun2 on fun2.id_funcionario = geoott.id_funcionario_aprob
                        left join orga.vfuncionario fun3 on fun3.id_funcionario = geoott.id_funcionario_recib
						inner join gem.tuni_cons unicons on unicons.id_uni_cons = geoott.id_uni_cons
						left join gem.ttipo_mant tipman on tipman.id_tipo_mant = geoott.id_tipo_mant
                        left join gem.tlocalizacion local on local.id_localizacion = geoott.id_localizacion
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = geoott.id_unidad_medida
                        left join gem.tcentro_costo cencost on cencost.id_centro_costo = geoott.id_centro_costo
            			left join gem.tcuenta cue on cue.id_cuenta = geoott.id_cuenta
            			left join gem.tmant_predef mpre on mpre.id_mant_predef = geoott.id_mant_predef
            			left join gem.torden_trabajo_sol otsol on otsol.id_orden_trabajo_sol = geoott.id_orden_trabajo_sol
				        where geoott.estado_reg = ''activo''
				        and unicons.tipo = ''uc''
				        and unicons.estado_reg = ''activo''
                		and unicons.tipo_nodo = ''raiz''
                		and (unicons.estado=''aprobado'' or unicons.estado=''registrado'') and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta|| v_filtro || v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			
raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEOOTT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		30-08-2012 02:48:41
	***********************************/

	elsif(p_transaccion='GEM_GEOOTT_CONT')then
		begin
        	select tipo into v_cargo from gem.tlocalizacion_usuario 
            where id_usuario = p_id_usuario and estado_reg = 'activo' offset 0 limit 1;

            select tf.id_funcionario into v_id_funcionario from orga.tfuncionario tf
            inner join segu.tusuario tu on tf.id_persona = tu.id_persona
            where tu.id_usuario = p_id_usuario 
            and tf.estado_reg = 'activo' offset 0 limit 1;
            
        	if p_administrador = 1 then
           		v_filtro = ' 0=0 and ';
            elseif v_cargo = 'Gerente' or v_cargo = 'Ingeniero' or v_cargo = 'Jefe' then
	            v_filtro =  p_id_usuario::varchar||' = ANY (unicons.id_usuarios) and ';
            elseif (v_cargo = 'Operador' and (v_id_funcionario is not null)) then
            	v_filtro =  '('||v_id_funcionario||' = geoott.id_funcionario_asig or geoott.id_usuario_reg = '||p_id_usuario||') and ';
            else 
            	raise exception 'Debes ser un funcionario para poder ver estas ordenes de trabajo';
            end if;
	       --Sentencia de la consulta de conteo de registros
            
			v_consulta:='select count(geoott.id_orden_trabajo)
					    from gem.torden_trabajo geoott
					    inner join segu.tusuario usu1 on usu1.id_usuario = geoott.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geoott.id_usuario_mod
						left join orga.vfuncionario fun on fun.id_funcionario = geoott.id_funcionario_sol
						left join orga.vfuncionario fun1 on fun1.id_funcionario = geoott.id_funcionario_asig
                        left join orga.vfuncionario fun2 on fun2.id_funcionario = geoott.id_funcionario_aprob
                        left join orga.vfuncionario fun3 on fun3.id_funcionario = geoott.id_funcionario_recib
						inner join gem.tuni_cons unicons on unicons.id_uni_cons = geoott.id_uni_cons
						left join gem.ttipo_mant tipman on tipman.id_tipo_mant = geoott.id_tipo_mant
                        left join gem.tlocalizacion local on local.id_localizacion = geoott.id_localizacion
						left join param.tunidad_medida unimed on unimed.id_unidad_medida = geoott.id_unidad_medida
                        left join gem.tcentro_costo cencost on cencost.id_centro_costo = geoott.id_centro_costo
                        left join gem.tcuenta cue on cue.id_cuenta = geoott.id_cuenta
                        left join gem.tmant_predef mpre on mpre.id_mant_predef = geoott.id_mant_predef
                        left join gem.torden_trabajo_sol otsol on otsol.id_orden_trabajo_sol = geoott.id_orden_trabajo_sol
					    where geoott.estado_reg = ''activo''
					    and unicons.tipo = ''uc''
				        and unicons.estado_reg = ''activo''
                		and unicons.tipo_nodo = ''raiz''
                		and (unicons.estado=''aprobado'' or unicons.estado=''registrado'') and ';
			
            
			--Definicion de la respuesta		    
			v_consulta:=v_consulta|| v_filtro || v_parametros.filtro;

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