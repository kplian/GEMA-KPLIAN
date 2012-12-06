CREATE OR REPLACE FUNCTION gem.ft_analisis_porque_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_analisis_porque_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tanalisis_porque'
 AUTOR: 		 (admin)
 FECHA:	        28-11-2012 20:22:29
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

	v_nombre_funcion = 'gem.ft_analisis_porque_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_ANAPOR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		28-11-2012 20:22:29
	***********************************/

	if(p_transaccion='GM_ANAPOR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						anapor.id_analisis_porque,
						anapor.id_uni_cons,
						anapor.tecnicos,
						anapor.estado_reg,
						anapor.estado,
						anapor.fecha,
						anapor.operadores,
						anapor.coordinadores,
						anapor.problema,
						anapor.numero,
						anapor.id_usuario_reg,
						anapor.fecha_reg,
						anapor.id_usuario_mod,
						anapor.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tanalisis_porque anapor
						inner join segu.tusuario usu1 on usu1.id_usuario = anapor.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = anapor.id_usuario_mod
				        where anapor.id_uni_cons='||v_parametros.id_uni_cons||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_ANAPOR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		28-11-2012 20:22:29
	***********************************/

	elsif(p_transaccion='GM_ANAPOR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_analisis_porque)
					    from gem.tanalisis_porque anapor
					    inner join segu.tusuario usu1 on usu1.id_usuario = anapor.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = anapor.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
    /*********************************    
 	#TRANSACCION:  'GM_ANAPOR_REP'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-12-2012 20:22:29
	***********************************/

	elsif(p_transaccion='GM_ANAPOR_REP')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
            			anapor.id_analisis_porque,						
                        anapor.numero as revision,
						to_char(anapor.fecha_reg, ''dd/MM/YYYY'') as fecha_reg,
						to_char(anapor.fecha_mod, ''dd/MM/YYYY'') as fecha_mod,
                        loc.nombre as nombre_loc,
						anapor.id_analisis_porque as nro_analisis,
                        uni.nombre as maquina,
                        uni.codigo as tag,
						anapor.problema,                        
                        to_char(anapor.fecha, ''dd/MM/YYYY'') as fecha,
                        anapor.estado,
                        anapor.operadores,
						anapor.coordinadores,
						anapor.tecnicos,
						anapor.estado_reg,
						anapor.id_usuario_reg,
						anapor.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tanalisis_porque anapor
						inner join segu.tusuario usu1 on usu1.id_usuario = anapor.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = anapor.id_usuario_mod
                        inner join gem.tuni_cons uni on uni.id_uni_cons = anapor.id_uni_cons
                        inner join gem.tuni_cons_comp unicomp on unicomp.id_uni_cons_hijo = anapor.id_uni_cons
					    inner join gem.tuni_cons_comp unipad on unipad.id_uni_cons_hijo = unicomp.id_uni_cons_padre
						inner join gem.tuni_cons unilug on unilug.id_uni_cons = unipad.id_uni_cons_padre
                        inner join gem.tlocalizacion loc on loc.id_localizacion = unilug.id_localizacion 				        
                        where anapor.id_analisis_porque='||v_parametros.id_analisis_porque||' and ';
			
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