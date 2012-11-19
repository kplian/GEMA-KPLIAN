--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_equipo_medicion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_equipo_medicion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tequipo_medicion'
 AUTOR: 		 (admin)
 FECHA:	        27-09-2012 03:02:35
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
    v_consulta1    		varchar;
    v_consulta2    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
    g_registros         record;
    g_registros2         record;
    v_cod               varchar;
    v_cod2				varchar;
    v_pos 				integer;
			    
BEGIN

	v_nombre_funcion = 'gem.ft_equipo_medicion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	if(p_transaccion='GEM_GEMEDI_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gemedi.id_equipo_medicion,
						gemedi.id_equipo_variable,
						gemedi.observaciones,
						gemedi.estado_reg,
						gemedi.fecha_medicion,
						gemedi.medicion,
						gemedi.id_usuario_reg,
						gemedi.fecha_reg,
						gemedi.id_usuario_mod,
						gemedi.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						geeqva.valor_max,
						geeqva.valor_min,
						getiva.nombre as nombre_tipo_variable,
						getiva.descripcion as desc_tipo_variable,
						paunme.codigo as desc_unidad_medida,
						geeqva.id_uni_cons,
						geunco.codigo as cod_equipo,
						geunco.nombre as desc_equipo
						from gem.tequipo_medicion gemedi
						inner join segu.tusuario usu1 on usu1.id_usuario = gemedi.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gemedi.id_usuario_mod
						inner join gem.tequipo_variable geeqva on geeqva.id_equipo_variable = gemedi.id_equipo_variable
						inner join gem.ttipo_variable getiva on getiva.id_tipo_variable = geeqva.id_tipo_variable
						inner join param.tunidad_medida paunme on paunme.id_unidad_medida = getiva.id_unidad_medida
						inner join gem.tuni_cons geunco on geunco.id_uni_cons = geeqva.id_uni_cons
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	elsif(p_transaccion='GEM_GEMEDI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_equipo_medicion)
					    from gem.tequipo_medicion gemedi
					    inner join segu.tusuario usu1 on usu1.id_usuario = gemedi.id_usuario_reg
					    left join segu.tusuario usu2 on usu2.id_usuario = gemedi.id_usuario_mod
					    inner join gem.tequipo_variable geeqva on geeqva.id_equipo_variable = gemedi.id_equipo_variable
						inner join gem.ttipo_variable getiva on getiva.id_tipo_variable = geeqva.id_tipo_variable
						inner join param.tunidad_medida paunme on paunme.id_unidad_medida = getiva.id_unidad_medida
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MEDGRA_SEL'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rcm	
 	#FECHA:		28-09-2012 22:09
	***********************************/

	elsif(p_transaccion='GEM_MEDGRA_SEL')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select
					equmed.id_equipo_medicion,equvar.id_uni_cons, equipo.codigo, equipo.nombre, tipvar.nombre as var_nombre, tipvar.descripcion as var_desc,
					unimed.codigo as cod_unimed, unimed.descripcion as unimed_desc, equmed.fecha_medicion, equmed.medicion
					from gem.tequipo_medicion equmed
					inner join gem.tequipo_variable equvar on equvar.id_equipo_variable = equmed.id_equipo_variable
					inner join gem.ttipo_variable tipvar on tipvar.id_tipo_variable = equvar.id_tipo_variable
					inner join param.tunidad_medida unimed on unimed.id_unidad_medida = tipvar.id_unidad_medida
					inner join gem.tuni_cons equipo on equipo.id_uni_cons = equvar.id_uni_cons
					where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MEDGRA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rcm	
 	#FECHA:		22/09/2012 22:09
	***********************************/

	elsif(p_transaccion='GEM_MEDGRA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_equipo_medicion)
					from gem.tequipo_medicion equmed
					inner join gem.tequipo_variable equvar on equvar.id_equipo_variable = equmed.id_equipo_variable
					inner join gem.ttipo_variable tipvar on tipvar.id_tipo_variable = equvar.id_tipo_variable
					inner join param.tunidad_medida unimed on unimed.id_unidad_medida = tipvar.id_unidad_medida
					inner join gem.tuni_cons equipo on equipo.id_uni_cons = equvar.id_uni_cons
					where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	/*********************************    
      #TRANSACCION:  'GEM_EQMDI_SEL'
      #DESCRIPCION:	  coonsulta dinamica a las mediciones del equipo indicado
      #AUTOR:		rac	
      #FECHA:		12/11/2012
      ***********************************/

	elseif(p_transaccion='GEM_EQMEDI_SEL')then

	    begin	
        
            --1) crear tabla temporal segun la fecha inicio y ficha final indicada
        
          v_consulta = 'create temp table tt_mediciones_equipo_'||p_id_usuario||'(
                        id_mediciones_mes serial,
                        fecha date,
                        hora time
          ';  
        
         
          FOR g_registros in  (select
						eqv.id_equipo_variable,
						eqv.estado_reg,
						eqv.valor_max,
						eqv.id_uni_cons,
						eqv.obs,
						eqv.valor_min,
						eqv.id_tipo_variable,
						eqv.id_usuario_reg,
						eqv.fecha_reg,
						eqv.id_usuario_mod,
						eqv.fecha_mod,
						tva.nombre as nombre_tipo_variable
                       
						from gem.tequipo_variable eqv
						inner join gem.ttipo_variable tva on tva.id_tipo_variable = eqv.id_tipo_variable
                       
				        where  eqv.estado_reg = 'activo' and eqv.tipo='numeric'  AND eqv.id_uni_cons = v_parametros.id_uni_cons) LOOP
            
            v_cod= 'col_'||g_registros.id_equipo_variable;
   
            --semana 1
            v_cod2=v_cod||'_time';
            v_consulta =v_consulta||',  '||v_cod||'  varchar';
            v_consulta =v_consulta||',  '||v_cod||'_key integer';
         
           end loop;
          
          --concatena el finald e la creacion 
           v_consulta =v_consulta||') on commit drop';
          
          --crea tabla
          
           raise notice 'CREA TABLA TEMPORAL,%',v_consulta;
           execute(v_consulta);
          
       
         --  LLenamos la tabla temporal          
                       
          --  2) FOR  consulta las fechas de la tabla  equipo medicion filtrados por uni_cons,
                   
               FOR g_registros in  (select DISTINCT em.fecha_medicion, em.hora 
                                      from gem.tequipo_medicion em 
                                      inner join gem.tequipo_variable ev 
                                      on ev.id_equipo_variable = em.id_equipo_variable 
                                      where  ev.id_uni_cons = v_parametros.id_uni_cons
                                              and  ev.estado_reg = 'activo' and ev.tipo='numeric'
                                                and em.fecha_medicion between  v_parametros.fecha_ini and v_parametros.fecha_fin 
                                      order by em.fecha_medicion) LOOP
                                      
                      --2.0) (atributos) arma primera parte de la cadena de insercion con datos del equipo y del mantenimiento
     
               
           					 v_consulta1= 'INSERT into tt_mediciones_equipo_'||p_id_usuario||' (
                                                     fecha,
                                                     hora ';
                                                       
 							--  (valores)   arma la cadena de insercion de valores 
         
         
            				v_consulta2= ') values('''||g_registros.fecha_medicion||''','''||g_registros.hora||'''';                  
                                                                              
                    
                     --2.1) FOR  consulta los registros de la tabla  equipo medicion agrupados por fecha y unic_cons,
                      FOR g_registros2 in  (select ev.id_equipo_variable,
                                                   em.id_equipo_medicion,
                                                   em.medicion,
                                                   em.hora
                                            from gem.tequipo_medicion em 
                                            inner join gem.tequipo_variable ev 
                                            on ev.id_equipo_variable = em.id_equipo_variable 
                                            inner join gem.ttipo_variable tva on tva.id_tipo_variable = ev.id_tipo_variable
                         
                                            where  ev.estado_reg = 'activo'  and ev.tipo='numeric'
                                                   AND ev.id_uni_cons = v_parametros.id_uni_cons 
                                                   and em.fecha_medicion = g_registros.fecha_medicion
                                                   and em.hora = g_registros.hora
                                            ) LOOP
            
                       --  2.1.1) arma consulta de insercion
                       v_cod =  'col_'||g_registros2.id_equipo_variable;
                       
                       --revisa si la medicion no se repita para la misma fecha y hora
                       --si se repeti nos quedamos con la primera
                       v_pos = position (v_cod in v_consulta1);
                       
                        if(v_pos = 0) then
                           v_consulta1=v_consulta1||','||v_cod||','||v_cod||'_key';
                           v_consulta2=v_consulta2||','''||g_registros2.medicion||''','||g_registros2.id_equipo_medicion;
                        end if;
                      
                      END LOOP;
                      
                       --  2.2)  finaliza la cadena de insercion
                      
                       v_consulta1 = v_consulta1||v_consulta2|| ') ';
         
                      
                      --  2.3) inserta los datos en la tabla temporal
                      
                      raise notice 'INSERCION %',v_consulta1;
   
    				  execute(v_consulta1);
        
             END LOOP;      
          
         --  3) consulta de la tabla temporal
         
         
         
         v_consulta:='select  * from tt_mediciones_equipo_'||p_id_usuario||' where '||v_parametros.filtro;
		 v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

         
		--Devuelve la respuesta
		return v_consulta;	
         
       
		end;
    /*********************************    
 	#TRANSACCION:  'GEM_EQMEDI_CONT'
 	#DESCRIPCION:	Conteo de registros de la consulta dinamica de mediciones por quipo
 	#AUTOR:		rac	
 	#FECHA:		22/09/2012 22:09
	***********************************/

	elsif(p_transaccion='GEM_EQMEDI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count (DISTINCT (em.fecha_medicion,em.hora))
					        from gem.tequipo_medicion em 
                            inner join gem.tequipo_variable ev 
                                on ev.id_equipo_variable = em.id_equipo_variable 
                                 where  ev.id_uni_cons = '||v_parametros.id_uni_cons||'
                                      and  ev.estado_reg = ''activo'' and ev.tipo=''numeric''';
			
			
			--Devuelve la respuesta
            
           -- raise exception '%',v_consulta;
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