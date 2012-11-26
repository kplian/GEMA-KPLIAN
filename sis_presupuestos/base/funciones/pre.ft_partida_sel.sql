CREATE OR REPLACE FUNCTION pre.ft_partida_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de presupuesto
 FUNCION: 		pre.ft_partida_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'pre.tpartida'
 AUTOR: 		 (admin)
 FECHA:	        23-11-2012 20:06:53
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

	v_nombre_funcion = 'pre.ft_partida_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PRE_PAR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		23-11-2012 20:06:53
	***********************************/

	if(p_transaccion='PRE_PAR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						par.id_partida,
						par.estado_reg,
						par.id_partida_fk,
						par.tipo,
						par.descripcion,
						par.codigo,
						par.id_usuario_reg,
						par.fecha_reg,
						par.id_usuario_mod,
						par.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from pre.tpartida par
						inner join segu.tusuario usu1 on usu1.id_usuario = par.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = par.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
	/*********************************   
     #TRANSACCION:  'ALM_CLA_ARB_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:            Gonzalo Sarmiento
     #FECHA:            24-09-2012
    ***********************************/

    elseif(p_transaccion='PRE_PAR_ARB_SEL')then
                    
        begin       
              if(v_parametros.id_padre = '%') then
                v_where := ' par.id_partida_fk is NULL';   
                     
              else
                v_where := ' par.id_partida_fk = '||v_parametros.id_padre;
              end if;
       
       
            --Sentencia de la consulta
            v_consulta:='select
                        par.id_partida,
                        par.id_partida_fk,
                        par.codigo,
                        par.tipo,
                        par.descripcion,
                         case
                          when (par.id_partida_fk is null )then
                               ''raiz''::varchar
                          ELSE
                              ''hijo''::varchar
                          END as tipo_nodo
                        from pre.tpartida par
                        where  '||v_where|| ' 
                        ORDER BY par.id_partida';
            raise notice '%',v_consulta;
           
            --Devuelve la respuesta
            return v_consulta;
                       
        end;     
    
	/*********************************    
 	#TRANSACCION:  'PRE_PAR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		23-11-2012 20:06:53
	***********************************/

	elsif(p_transaccion='PRE_PAR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_partida)
					    from pre.tpartida par
					    inner join segu.tusuario usu1 on usu1.id_usuario = par.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = par.id_usuario_mod
					    where ';
			
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