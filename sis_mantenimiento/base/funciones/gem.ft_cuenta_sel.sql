--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_cuenta_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Mantenimiento
 FUNCION: 		gem.ft_cuenta_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'conta.tcuenta'
 AUTOR: 		RCM
 FECHA:	        14-04-2013
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
    v_where 			varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_cuenta_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_CTA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		RCM	
 	#FECHA:		14-04-2013
	***********************************/

	if(p_transaccion='GEM_CTA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='SELECT 
                        cta.id_cuenta,
                        cta.id_cuenta_padre,
                        cta.nro_cuenta,
                        cta.nombre_cuenta,
                        cta.id_usuario_reg,
                        cta.id_usuario_mod,
                        cta.fecha_reg,
                        cta.fecha_mod,
                        cta.estado_reg,
                        usu1.cuenta as usr_reg,
						            usu2.cuenta as usr_mod
                        from gem.tcuenta cta
						            inner join segu.tusuario usu1 on usu1.id_usuario = cta.id_usuario_reg
						            left join segu.tusuario usu2 on usu2.id_usuario = cta.id_usuario_mod
                        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    /*********************************   
     #TRANSACCION:  'GEM_CTA_ARB_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:            RCM
     #FECHA:            14-04-2013
    ***********************************/

    elseif(p_transaccion='GEM_CTA_ARB_SEL')then
                    
        begin       
              if(v_parametros.id_padre = '%') then
                v_where := ' cta.id_cuenta_padre is NULL';   
                     
              else
                v_where := ' cta.id_cuenta_padre = '||v_parametros.id_padre;
              end if;
       
       
            --Sentencia de la consulta
            v_consulta:='select
                        cta.id_cuenta,
                        cta.id_cuenta_padre,
                        cta.nro_cuenta,
                        cta.nombre_cuenta,
                        case
                          when (cta.id_cuenta_padre is null )then
                               ''raiz''::varchar
                          ELSE
                              ''hijo''::varchar
                          END as tipo_nodo
                        from gem.tcuenta cta
                        where  '||v_where|| ' 
                                 and cta.estado_reg = ''activo''
                        ORDER BY cta.nro_cuenta';
            raise notice '%',v_consulta;
           
            --Devuelve la respuesta
            return v_consulta;
                       
        end;     

	/*********************************    
 	#TRANSACCION:  'GEM_CTA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		RCM	
 	#FECHA:		14-04-2013
	***********************************/

	elsif(p_transaccion='GEM_CTA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_cuenta)
					    from gem.tcuenta cta
						      inner join segu.tusuario usu1 on usu1.id_usuario = cta.id_usuario_reg
      						left join segu.tusuario usu2 on usu2.id_usuario = cta.id_usuario_mod
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