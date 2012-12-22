--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_uni_cons_doc_tec_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_uni_cons_doc_tec_sel
 DESCRIPCION:   Transacciones de retorno de datos para la tabla tuni_cons_doc_tec
 AUTOR: 		aao
 FECHA:	        21-12-2012 12:40:00
 COMENTARIOS:	
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_uni_cons_doc_tec_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_UCDOCTEC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		aao
 	#FECHA:		21-12-2012 12:48:00
	***********************************/

	if(p_transaccion='GEM_UCDOCTEC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
                    doctec.id_documento_tec,
                    doctec.id_usuario_reg,
                    usu1.cuenta as usr_reg,
                    doctec.id_usuario_mod,
                    usu2.cuenta as usr_mod,
                    doctec.fecha_reg,
                    doctec.fecha_mod,
                    doctec.estado_reg,
                    doctec.id_uni_cons,
                    doctec.nombre_documento,
                    doctec.adjunto,
                    doctec.codigo,
                    doctec.observaciones
                    from gem.tuni_cons_doc_tec doctec
                    inner join segu.tusuario usu1 on usu1.id_usuario = doctec.id_usuario_reg
                    left join segu.tusuario usu2 on usu2.id_usuario = doctec.id_usuario_mod
                    where doctec.id_uni_cons = ' || v_parametros.id_uni_cons || 
                    ' and doctec.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_UCDOCTEC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		aao	
 	#FECHA:		21-12-2012 12:49:00
	***********************************/

	elsif(p_transaccion='GEM_UCDOCTEC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(doctec.id_documento_tec)
                    from gem.tuni_cons_doc_tec doctec
                    inner join segu.tusuario usu1 on usu1.id_usuario = doctec.id_usuario_reg
                    left join segu.tusuario usu2 on usu2.id_usuario = doctec.id_usuario_mod
                    where doctec.id_uni_cons = ' || v_parametros.id_uni_cons || 
                    ' and doctec.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

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