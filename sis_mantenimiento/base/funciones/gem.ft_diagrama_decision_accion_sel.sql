CREATE OR REPLACE FUNCTION gem.ft_diagrama_decision_accion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de presupuesto
 FUNCION: 		pre.ft_diagrama_decision_accion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'pre.tpartida'
 AUTOR: 		 (admin)
 FECHA:	        14-12-2012
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
    v_where				varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_diagrama_decision_accion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEDIAC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		14-12-2012
	***********************************/

	if(p_transaccion='GEM_GEDIAC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						diac.id_diagrama_decision_accion,
						diac.estado_reg,
						diac.id_diagrama_decision_accion_fk,
						diac.tipo,
						diac.nombre,
						diac.codigo,
						diac.id_usuario_reg,
						diac.fecha_reg,
						diac.id_usuario_mod,
						diac.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tdiagrama_decision_accion diac
						inner join segu.tusuario usu1 on usu1.id_usuario = diac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = diac.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
	/*********************************    
 	#TRANSACCION:  'GEM_GEDIAC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		14-12-2012
	***********************************/

	elsif(p_transaccion='GEM_GEDIAC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_diagrama_decision_accion)
					    from gem.tdiagrama_decision_accion diac
					    inner join segu.tusuario usu1 on usu1.id_usuario = diac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = diac.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
		
	/*********************************   
     #TRANSACCION:  'GEM_GEDIARB_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:            Gonzalo Sarmiento
     #FECHA:            24-09-2012
    ***********************************/

    elseif(p_transaccion='GEM_GEDIARB_SEL')then
                    
        begin       
              if(v_parametros.id_padre = '%') then
                v_where := ' diac.id_diagrama_decision_accion_fk is NULL';   
                     
              else
                v_where := ' diac.id_diagrama_decision_accion_fk = '||v_parametros.id_padre;
              end if;
       
       
            --Sentencia de la consulta
            v_consulta:='select
                        diac.id_diagrama_decision_accion,
                        diac.id_diagrama_decision_accion_fk,
                        diac.codigo,
                        diac.tipo,
                        diac.nombre,
                         case
                          when (diac.id_diagrama_decision_accion_fk is null )then
                               ''raiz''::varchar
                          ELSE
                              ''hijo''::varchar
                          END as tipo_nodo
                        from gem.tdiagrama_decision_accion diac
                        where  '||v_where||' and diac.id_diagrama_decision='
                        ||v_parametros.id_diagrama_decision|| 
                        'ORDER BY diac.id_diagrama_decision_accion';
            raise notice '%',v_consulta;
           
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