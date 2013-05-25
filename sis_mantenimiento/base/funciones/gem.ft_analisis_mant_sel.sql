--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_analisis_mant_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_analisis_mant_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tanalisis_mant'
 AUTOR: 		 (admin)
 FECHA:	        30-09-2012 21:44:06
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

	v_nombre_funcion = 'gem.ft_analisis_mant_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEANMA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:44:06
	***********************************/

	if(p_transaccion='GEM_GEANMA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						geanma.id_analisis_mant,
						geanma.id_uni_cons,
						geanma.id_tipo_mant,
						geanma.id_persona_rev,
						geanma.estado_reg,
						geanma.fecha_emision,
						geanma.descripcion,
						geanma.fecha_rev,
						geanma.id_usuario_reg,
						geanma.fecha_reg,
						geanma.id_usuario_mod,
						geanma.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						getima.nombre as desc_tipo_mant,
						per.nombre_completo1 as desc_person,
						geanma.id_persona_prep,
						per1.nombre_completo1 as preparado_por,
						geanma.id_uni_cons_hijo,
						uch.nombre as desc_uni_cons_hijo,
						geanma.id_uo,
						uo.nombre_unidad	
						from gem.tanalisis_mant geanma
						inner join segu.tusuario usu1 on usu1.id_usuario = geanma.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geanma.id_usuario_mod
						inner join gem.ttipo_mant getima on getima.id_tipo_mant = geanma.id_tipo_mant
						inner join segu.vpersona per on per.id_persona = geanma.id_persona_rev
						left join segu.vpersona per1 on per1.id_persona = geanma.id_persona_prep
						left join gem.tuni_cons uch on uch.id_uni_cons = geanma.id_uni_cons_hijo
						left join orga.tuo uo on uo.id_uo = geanma.id_uo 
				    where geanma.id_uni_cons='||v_parametros.id_uni_cons|| ' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEANMA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		30-09-2012 21:44:06
	***********************************/

	elsif(p_transaccion='GEM_GEANMA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_analisis_mant)
					    from gem.tanalisis_mant geanma
						inner join segu.tusuario usu1 on usu1.id_usuario = geanma.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = geanma.id_usuario_mod
						inner join gem.ttipo_mant getima on getima.id_tipo_mant = geanma.id_tipo_mant
						inner join segu.vpersona per on per.id_persona = geanma.id_persona_rev
						inner join segu.vpersona per1 on per1.id_persona = geanma.id_persona_prep
						left join gem.tuni_cons uch on uch.id_uni_cons = geanma.id_uni_cons_hijo
						left join orga.tuo uo on uo.id_uo = geanma.id_uo
				    where geanma.id_uni_cons='||v_parametros.id_uni_cons|| ' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
		
	/*********************************    
 	#TRANSACCION:  'GEM_GEANMA_REP'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:			Gonzalo Sarmiento Sejas
 	#FECHA:			18-12-2012 
	***********************************/
    elsif(p_transaccion='GEM_GEANMA_REP')then
    	begin
        	v_consulta:='select
        	             case coalesce(anamant.id_uni_cons_hijo,0)
        	                 when 0 then locp.nombre 
        	                 else locp.nombre  
        	             end as localizacion,
                       sis.codigo as tag,
                       case coalesce(anamant.id_uni_cons_hijo,0)
                            when 0 then loc.nombre 
                            else sis.nombre
                        end as nombre_sis,
                        case coalesce(anamant.id_uni_cons_hijo,0)
                            when 0 then sis.nombre
                            else ssis.nombre 
                        end as nombre_sub,
                        case coalesce(anamant.id_uo,0)
                            when 0 then per1.nombre_completo1
                            else uo.nombre_unidad
                        end as preparado_por,
                        per.nombre_completo1 as revisado_por,
                        to_char(anamant.fecha_emision,''dd/mm/yyyy'') as fecha_emision,
                        to_char(anamant.fecha_rev,''dd/mm/yyyy'') as fecha_rev,
                        anamant.descripcion
                        from gem.tanalisis_mant anamant
                        inner join segu.vpersona per on per.id_persona=anamant.id_persona_rev
                        left join segu.vpersona per1 on per1.id_persona=anamant.id_persona_prep
                        inner join gem.tuni_cons sis on sis.id_uni_cons = anamant.id_uni_cons
                        left join gem.tuni_cons ssis on ssis.id_uni_cons = anamant.id_uni_cons_hijo
                        inner join gem.tlocalizacion loc on loc.id_localizacion = sis.id_localizacion
                        inner join gem.tlocalizacion locp on locp.id_localizacion = loc.id_localizacion_fk
                        left join orga.tuo uo on uo.id_uo = anamant.id_uo
                        where anamant.id_analisis_mant='||v_parametros.id_analisis_mant||' and ';
                        
                        v_consulta:=v_consulta||v_parametros.filtro;
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