--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_uni_cons_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_uni_cons_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tuni_cons'
 AUTOR: 		 (rac)
 FECHA:	        09-08-2012 00:42:57
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
    v_condicion    varchar;
    v_join varchar;
    v_join_te varchar;
    v_tipo varchar;
			    
BEGIN

	v_nombre_funcion = 'gem.f_uni_cons_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_TUC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	if(p_transaccion='GEM_TUC_SEL')then
     				
    	begin
        
          if(v_parametros.id_padre = '%') then
               v_condicion:='tuc.tipo_nodo=''base'' ';
                v_join='LEFT';
          else
               v_condicion:='ucc.id_uni_cons_padre='||v_parametros.id_padre||' and tuc.tipo_nodo!=''base'' ';
                v_join='INNER';
          end if;
               v_condicion:=v_condicion ||' and tuc.estado_reg=''activo''  and tuc.tipo='''||v_parametros.tipo||'''';
               
        
    		--Sentencia de la consulta
			v_consulta:='select
						tuc.id_uni_cons,
						tuc.estado_reg,
						tuc.estado,
						tuc.nombre,
						tuc.tipo,
						tuc.codigo,
						tuc.id_tipo_equipo,
						tuc.id_localizacion,
                        case when   tuc.tipo_nodo = ''raiz'' then tuc.tipo_nodo||''_''||tuc.estado
                           else     tuc.tipo_nodo
                        end as tipo_nodo,
                        ucc.id_uni_cons_comp,
                        ucc.id_uni_cons_padre,
                        ucc.opcional,
                        ucc.cantidad,
						tuc.id_usuario_reg,
						tuc.fecha_reg,
						tuc.fecha_mod,
						tuc.id_usuario_mod,                                                
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        eq.nombre as nombre_tipo_equipo,
                        (tuc.nombre||''-[''||tuc.codigo||'']'')::varchar as text
                        
						from gem.tuni_cons tuc
                        '||v_join||' join gem.tuni_cons_comp ucc on ucc.id_uni_cons_hijo = tuc.id_uni_cons  and ucc.estado_reg=''activo'' 
						inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
                        left join gem.ttipo_equipo eq on eq.id_tipo_equipo= tuc.id_tipo_equipo
				        where  '||v_condicion;
			
			--Definicion de la respuesta
		
			v_consulta:=v_consulta||' order by tuc.id_uni_cons';
            
            raise notice '%', v_consulta;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TUC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	elsif(p_transaccion='GEM_TUC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_uni_cons)
					    from gem.tuni_cons tuc
					    inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
		
	/*********************************    
 	#TRANSACCION:  'GEM_TUCPLA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rcm	
 	#FECHA:		30/08/2012
    ***********************
  	#AUTOR_MOD:		rac
 	#FECHA_MOD:		3/09/2012
    #DESCRIPCION_MOD  aumtenra el parametro tipo 
                      para escoger el tipo de estructura que se lisata, 
                      ademas solo lista nodos raiz con estado  aprobado o registrado
	***********************************/
		
	elsif(p_transaccion='GEM_TUCPLA_SEL')then
     				
    	begin
        v_tipo='uc';        
        if pxp.f_existe_parametro(p_tabla,'tipo') then
         v_tipo='tuc';        
        end if;
        
        
    		--Sentencia de la consulta
			v_consulta:='select
						tuc.id_uni_cons,
						tuc.estado_reg,
						tuc.estado,
						tuc.nombre,
						tuc.tipo,
						tuc.codigo,
						tuc.id_tipo_equipo,
						tuc.id_localizacion,
						tuc.id_usuario_reg,
						tuc.fecha_reg,
						tuc.fecha_mod,
						tuc.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						eq.nombre as nombre_tipo_equipo	
						from gem.tuni_cons tuc
						inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
                        left join gem.ttipo_equipo eq on eq.id_tipo_equipo= tuc.id_tipo_equipo
				        where tuc.tipo = '''||v_tipo||'''
				        and tuc.tipo_nodo = ''raiz'' and (tuc.estado=''aprobado'' or tuc.estado=''registrado'') and ';
			 
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    /*********************************    
 	#TRANSACCION:  'GEM_TUCPLAARB_SEL'
 	#DESCRIPCION:	para el litado de uni constructivas des el arbol ed localizaciones
                    no tiene contador solo filtro por ud_localizacion
 	#AUTOR:		rcm	
 	#FECHA:		1/09/2012
  	***********************************/
		
	elsif(p_transaccion='GEM_TUCPLAARB_SEL')then
     				
    	begin
    

        
    		--Sentencia de la consulta
			v_consulta:='select
						tuc.id_uni_cons,
						tuc.nombre,
						tuc.codigo,
						tuc.id_localizacion as id_localizacion_fk,
                        (tuc.id_localizacion::varchar||''_''||tuc.id_uni_cons::varchar)::varchar as id_localizacion,
                         (''uni_cons'')::varchar    as tipo_nodo
						
						from gem.tuni_cons tuc
						inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
                        where tuc.tipo = ''uc''
				        and tuc.tipo_nodo = ''raiz'' and (tuc.estado=''aprobado'' or tuc.estado=''registrado'') 
                        and  tuc.id_localizacion= '|| v_parametros.id_localizacion;
			 
			--Definicion de la respuesta
			v_consulta:=v_consulta||' order by tuc.codigo';

			--Devuelve la respuesta
			return v_consulta;
						
		end;    

	/*********************************    
 	#TRANSACCION:  'GEM_TUCPLA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	elsif(p_transaccion='GEM_TUCPLA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_uni_cons)
					    from gem.tuni_cons tuc
						inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
                        left join gem.ttipo_equipo eq on eq.id_tipo_equipo= tuc.id_tipo_equipo
					    where tuc.tipo = ''uc''
				        and tuc.tipo_nodo = ''raiz'' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
		
	/*********************************    
 	#TRANSACCION:  'GEM_TUCHIJO_SEL'
 	#DESCRIPCION:	Para listar las unidades cosntructivas segun el id_uni_cons_padre de la unidad constructiva
 	#AUTOR:			Gonzalo Sarmiento	
 	#FECHA:			23-10-2012
	***********************************/
	elsif(p_transaccion='GEM_TUCHIJO_SEL')then
    	begin
        	v_consulta:='select
				uni.codigo,
		    	uni.nombre,
                uni.id_uni_cons as id_uni_cons_hijo
				from gem.tuni_cons uni
            	inner join gem.tuni_cons_comp unicomp on unicomp.id_uni_cons_hijo=uni.id_uni_cons
            	where unicomp.id_uni_cons_padre='||v_parametros.id_uni_cons||' and unicomp.estado_reg=''activo'' and uni.tipo_nodo=''rama'' ';
                --Definicion de la respuesta
			v_consulta:=v_consulta||' order by uni.nombre';

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