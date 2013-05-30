CREATE OR REPLACE FUNCTION gem.ft_plan_mant_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_plan_mant_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tplan_mant'
 AUTOR: 		 (rac)
 FECHA:	        12-10-2012 16:15:31
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
			    
BEGIN

	v_nombre_funcion = 'gem.ft_plan_mant_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_PLAMA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		12-10-2012 16:15:31
	***********************************/

	if(p_transaccion='GEM_PLAMA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						plama.id_plan_mant,
						plama.id_persona,
            per.nombre_completo1 as nombre_funcionario,
						plama.id_persona_rev,
            per1.nombre_completo1 as nombre_funcionario_rev,
						plama.id_tipo_mant,
            tip.nombre as tipo_mant,
						plama.id_uni_cons,
						plama.descripcion,                       
						plama.fecha,
						plama.estado_reg,
						plama.id_usuario_reg,
						plama.fecha_reg,
						plama.fecha_mod,
						plama.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
            plama.id_uni_cons_hijo,
            uch.nombre as desc_uni_cons_hijo,
            plama.id_uo,
            uo.nombre_unidad,
            plama.fecha_emision
						from gem.tplan_mant plama
						inner join segu.tusuario usu1 on usu1.id_usuario = plama.id_usuario_reg
            left join segu.vpersona per on per.id_persona=plama.id_persona
            inner join segu.vpersona per1 on per1.id_persona=plama.id_persona_rev                          
						inner join gem.ttipo_mant tip on tip.id_tipo_mant=plama.id_tipo_mant
            left join segu.tusuario usu2 on usu2.id_usuario = plama.id_usuario_mod
            left join gem.tuni_cons uch on uch.id_uni_cons = plama.id_uni_cons_hijo
            left join orga.tuo uo on uo.id_uo = plama.id_uo
				    where  plama.id_uni_cons='||v_parametros.id_uni_cons||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_PLAMA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		12-10-2012 16:15:31
	***********************************/

	elsif(p_transaccion='GEM_PLAMA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_plan_mant)
					    from gem.tplan_mant plama
					    inner join segu.tusuario usu1 on usu1.id_usuario = plama.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = plama.id_usuario_mod
						left join segu.vpersona per on per.id_persona=plama.id_persona
						inner join segu.vpersona per1 on per1.id_persona=plama.id_persona_rev
						left join gem.tuni_cons uch on uch.id_uni_cons = plama.id_uni_cons_hijo
						left join orga.tuo uo on uo.id_uo = plama.id_uo
						where  plama.id_uni_cons='||v_parametros.id_uni_cons||' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
    
    /*********************************    
 	#TRANSACCION:  'GEM_PLAMA_REP'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			Gonzalo Sarmiento Sejas	
 	#FECHA:			20-12-2012
	***********************************/

	elsif(p_transaccion='GEM_PLAMA_REP')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
			             case coalesce(plama.id_uni_cons_hijo,0)
                           when 0 then locp.nombre 
                           else locp.nombre  
                       end as localizacion,
                       sis.codigo as tag,
                       case coalesce(plama.id_uni_cons_hijo,0)
                            when 0 then loc.nombre 
                            else sis.nombre
                        end as nombre_sis,
                        case coalesce(plama.id_uni_cons_hijo,0)
                            when 0 then sis.nombre
                            else ssis.nombre 
                        end as nombre_sub,
                        case coalesce(plama.id_uo,0)
                            when 0 then per.nombre_completo1
                            else uo.nombre_unidad
                        end as preparado_por,
                        per1.nombre_completo1 as revisado_por,
                        to_char(plama.fecha_emision,''dd/mm/yyyy'') as fecha_emision,
                        to_char(plama.fecha,''dd/mm/yyyy'') as fecha,
                        plama.descripcion
						from gem.tplan_mant plama
						left join segu.vpersona per on per.id_persona=plama.id_persona
            inner join segu.vpersona per1 on per1.id_persona=plama.id_persona_rev
            inner join gem.tuni_cons sis on sis.id_uni_cons = plama.id_uni_cons
            left join gem.tuni_cons ssis on ssis.id_uni_cons = plama.id_uni_cons_hijo
            inner join gem.tlocalizacion loc on loc.id_localizacion = sis.id_localizacion
            inner join gem.tlocalizacion locp on locp.id_localizacion = loc.id_localizacion_fk
            left join orga.tuo uo on uo.id_uo = plama.id_uo
						where  plama.id_plan_mant ='||v_parametros.id_plan_mant||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

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