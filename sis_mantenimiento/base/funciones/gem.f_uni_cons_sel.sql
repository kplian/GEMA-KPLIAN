CREATE OR REPLACE FUNCTION gem.f_uni_cons_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION:     gem.f_uni_cons_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tuni_cons'
 AUTOR:      (rac)
 FECHA:         09-08-2012 00:42:57
 COMENTARIOS: 
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/

DECLARE

  v_consulta        varchar;
  v_parametros      record;
  v_nombre_funcion    text;
  v_resp        varchar;
    v_condicion    varchar;
    v_join varchar;
    v_join_te varchar;
    v_tipo varchar;
    v_filtro varchar;
    v_ids_loc     varchar;
    v_cond varchar;
          
BEGIN

  v_nombre_funcion = 'gem.f_uni_cons_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'GEM_TUC_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   rac 
  #FECHA:   09-08-2012 00:42:57
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
               
    if v_parametros.tipo_nodo = 'base'  and  v_parametros.tipo = 'uc' and  p_administrador != 1  then
      v_filtro = p_id_usuario||' = ANY (tuc.id_usuarios) ';
    else 
            v_filtro = '  0=0 ';
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
            (tuc.nombre||''-[''||tuc.codigo||'']'')::varchar as text,
            tuc.incluir_calgen,
            (COALESCE(tuc.id_localizacion,0)||''_''||tuc.id_uni_cons)::varchar as id_uni_loc,
            tuc.herramientas_especiales,
            tuc.otros_datos_tec,
            tuc.funcion,
            tuc.punto_recepcion_despacho,
            tuc.horas_dia,
            tuc.ficha_tecnica
            from gem.tuni_cons tuc
            '||v_join||' join gem.tuni_cons_comp ucc on ucc.id_uni_cons_hijo = tuc.id_uni_cons  and ucc.estado_reg=''activo'' 
            inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
            left join gem.ttipo_equipo eq on eq.id_tipo_equipo= tuc.id_tipo_equipo
            where  '||v_condicion|| '  and '||v_filtro;
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||' order by tuc.id_uni_cons';
            
            raise notice '%', v_consulta;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'GEM_TUC_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   rac 
  #FECHA:   09-08-2012 00:42:57
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
  #DESCRIPCION: Consulta de datos
  #AUTOR:   rcm 
  #FECHA:   30/08/2012
    ***********************
    #AUTOR_MOD:   rac
  #FECHA_MOD:   3/09/2012
    #DESCRIPCION_MOD  aumtenra el parametro tipo 
                      para escoger el tipo de estructura que se lista, 
                      ademas solo lista nodos raiz con estado  aprobado o registrado
  ***********************************/
    
  elsif(p_transaccion='GEM_TUCPLA_SEL')then
            
    begin
          v_tipo='uc';        
          if pxp.f_existe_parametro(p_tabla,'tipo') then
            v_tipo='tuc';        
          end if;
          if pxp.f_existe_parametro(p_tabla,'id_localizacion') then
            v_ids_loc=gem.f_get_id_localizaciones(v_parametros.id_localizacion);        
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
            eq.nombre as nombre_tipo_equipo,
                        gem.f_get_nombre_localizacion_rec(tuc.id_localizacion,''padres'') as padres_loc,
                        loc.codigo || '' - '' || loc.nombre as desc_localizacion
            from gem.tuni_cons tuc
            inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
                        left join gem.ttipo_equipo eq on eq.id_tipo_equipo= tuc.id_tipo_equipo
                        left join gem.tlocalizacion loc on loc.id_localizacion = tuc.id_localizacion
                where tuc.tipo = '''||v_tipo||'''
                and tuc.estado_reg = ''activo'' and tuc.tipo_nodo = ''raiz'' and (tuc.estado=''aprobado'' or tuc.estado=''registrado'') and ';
           if pxp.f_existe_parametro(p_tabla,'id_localizacion') then
           		v_consulta = v_consulta ||' tuc.id_localizacion in (' || v_ids_loc ||') and ';
           end if;
       
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
      raise notice '%',v_consulta;
      --Devuelve la respuesta
      return v_consulta;
            
    end;
        
     
  /*********************************    
  #TRANSACCION:  'GEM_TUCPLA_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   rac 
  #FECHA:   09-08-2012 00:42:57
  ***********************************/

  elsif(p_transaccion='GEM_TUCPLA_CONT')then

    begin

        v_tipo='uc';        
		if pxp.f_existe_parametro(p_tabla,'tipo') then
        	v_tipo='tuc';        
        end if;
        if pxp.f_existe_parametro(p_tabla,'id_localizacion') then
            v_ids_loc=gem.f_get_id_localizaciones(v_parametros.id_localizacion);        
        end if;
        
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_uni_cons)
              from gem.tuni_cons tuc
            inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
                        left join gem.ttipo_equipo eq on eq.id_tipo_equipo= tuc.id_tipo_equipo
                        left join gem.tlocalizacion loc on loc.id_localizacion = tuc.id_localizacion
                where tuc.tipo = '''||v_tipo||'''
                and tuc.estado_reg = ''activo'' and tuc.tipo_nodo = ''raiz'' and (tuc.estado=''aprobado'' or tuc.estado=''registrado'') and ';
       
           -- raise exception '%', v_consulta;
           
		if pxp.f_existe_parametro(p_tabla,'id_localizacion') then
        	v_consulta = v_consulta ||' tuc.id_localizacion in (' || v_ids_loc ||') and ';
		end if;
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;   
        
    /*********************************    
  #TRANSACCION:  'GEM_TUCPLAARB_SEL'
  #DESCRIPCION: para el litado de unidades constructivas desde el arbol de localizaciones
                    no tiene contador solo filtro por id_localizacion
  #AUTOR:   rcm 
  #FECHA:   1/09/2012
    ***********************************/
    
	elsif(p_transaccion='GEM_TUCPLAARB_SEL')then
            
		begin
    
        	--tenemos que uamentar un filtro , si es administros todos si no solo las unidades donde el tenga acceso
           
			if p_administrador = 1 then
				v_filtro = ' 0=0 ';
            else
            	v_filtro =  p_id_usuario::varchar||' = ANY (tuc.id_usuarios) ';
            end if;
            
			--Sentencia de la consulta
      		v_consulta:='select
			            tuc.id_uni_cons,
			            tuc.nombre,
			            tuc.codigo,
			            tuc.id_localizacion as id_localizacion_fk,
	                    (tuc.id_localizacion::varchar||''_''||tuc.id_uni_cons::varchar)::varchar as id_localizacion,
	                    tuc.incluir_calgen,
	                    case 
	                    	when (tuc.incluir_calgen)then
	                           ''uni_cons''::varchar
	                      ELSE
	                          ''uni_cons_f''::varchar
	                    END as tipo_nodo
			            from gem.tuni_cons tuc
			            inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
			            left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
			            where tuc.tipo = ''uc''
			            and tuc.estado_reg = ''activo''
			            and tuc.tipo_nodo = ''raiz''
			            and (tuc.estado=''aprobado'' or tuc.estado=''registrado'') 
			            and  '|| v_filtro ||' and  tuc.id_localizacion= '|| v_parametros.id_localizacion;
       
      --Definicion de la respuesta
      v_consulta:=v_consulta||' order by tuc.codigo';
            
            
                 
              

      --Devuelve la respuesta
      return v_consulta;
            
    end;    

    
  /*********************************    
  #TRANSACCION:  'GEM_TUCHIJO_SEL'
  #DESCRIPCION: Para listar las unidades cosntructivas segun el id_uni_cons_padre de la unidad constructiva
  #AUTOR:     Gonzalo Sarmiento 
  #FECHA:     23-10-2012
  ***********************************/
  elsif(p_transaccion='GEM_TUCHIJO_SEL')then
      begin
          v_consulta:='select
        uni.codigo,
          uni.nombre,
                uni.id_uni_cons as id_uni_cons_hijo
        from gem.tuni_cons uni
              inner join gem.tuni_cons_comp unicomp on unicomp.id_uni_cons_hijo=uni.id_uni_cons
              where unicomp.id_uni_cons_padre='||v_parametros.id_uni_cons||' and unicomp.estado_reg=''activo'' and uni.tipo_nodo=''rama'' and ';
              
         v_consulta = v_consulta || v_parametros.filtro;
                
      v_consulta:=v_consulta||' order by uni.nombre';

      --Devuelve la respuesta
      return v_consulta;
      end;        
  
        /*********************************
        #TRANSACCION: 'GEM_TUCGET_SEL'
        #DESCRIPCION: para obtener una unidad constructiva
        #AUTOR: aao
        #FECHA: 12/11/2012
        ***********************************/

        elsif(p_transaccion='GEM_TUCGET_SEL')then
             
             begin
             --Sentencia de la consulta
        v_consulta:='select tuc.id_uni_cons,
                        tuc.codigo,
                        tuc.nombre,
                        tuc.tipo,
                        tuc.estado,
                        tuc.tipo_nodo,
                        loc.codigo as cod_localizacion,
                        loc.nombre as nombre_localizacion,
                        loc.ubicacion as ubicacion,
                        teq.codigo as codigo_tipo_equipo,
                        teq.nombre as nombre_tipo_equipo,
                        tcc.id_uni_cons_padre,
                        to_char(tuc.fecha_reg, ''dd/MM/YYYY'') as fecha_reg,
                        to_char(tuc.fecha_mod, ''dd/MM/YYYY'') as fecha_mod,
                        tuc.herramientas_especiales,
                        tuc.otros_datos_tec,
                        tuc.funcion,
                        tuc.punto_recepcion_despacho,
                        tuc.ficha_tecnica,
                        loc1.nombre as loc_padre
                      from gem.tuni_cons tuc
                      left join gem.ttipo_equipo teq on tuc.id_tipo_equipo = teq.id_tipo_equipo
                      left join gem.tlocalizacion loc on tuc.id_localizacion = loc.id_localizacion
                      left join gem.tuni_cons_comp tcc on tuc.id_uni_cons = tcc.id_uni_cons_hijo
                      left join gem.tlocalizacion loc1 on loc1.id_localizacion = loc.id_localizacion_fk
                      where tuc.id_uni_cons = '|| v_parametros.id_uni_cons;

        --Devuelve la respuesta
        return v_consulta;
        end;

        /*********************************
        #TRANSACCION: 'GEM_TUCGET_CONT'
        #DESCRIPCION: Conteo de registros
        #AUTOR: aao
        #FECHA: 12-11-2012 10:33:00
        ***********************************/

        elsif(p_transaccion='GEM_TUCGET_CONT')then

        begin
        --Sentencia de la consulta de conteo de registros
        v_consulta:='select count(tuc.id_uni_cons)
                        from gem.tuni_cons tuc
                    where tuc.id_uni_cons = '|| v_parametros.id_uni_cons;

        --Devuelve la respuesta
        return v_consulta;

        end;
            
        /*********************************
        #TRANSACCION: 'GEM_TUCHIJOS_SEL'
        #DESCRIPCION: obtiene los hijos de una unidad constructiva en su primer nivel
        #AUTOR: aao
        #FECHA: 12/11/2012
        ***********************************/

        elsif(p_transaccion='GEM_TUCHIJOS_SEL')then
             
             begin
             --Sentencia de la consulta
              v_consulta:='select tuc.id_uni_cons,
                              tuc.codigo,
                              tuc.nombre,
                              tuc.tipo,
                              tuc.estado,
                              tuc.tipo_nodo,
                              loc.codigo as cod_localizacion,
                              loc.nombre as nombre_localizacion,
                              loc.ubicacion as ubicacion,
                              teq.codigo as codigo_tipo_equipo,
                              teq.nombre as nombre_tipo_equipo,
                              tuc.ficha_tecnica
                          from gem.tuni_cons tuc
                          inner join gem.tuni_cons_comp tcc on tuc.id_uni_cons = tcc.id_uni_cons_hijo
                          left join gem.ttipo_equipo teq on tuc.id_tipo_equipo = teq.id_tipo_equipo
                          left join gem.tlocalizacion loc on tuc.id_localizacion = loc.id_localizacion
                          where tcc.estado_reg = ''activo''
                          and tcc.id_uni_cons_padre = '|| v_parametros.id_uni_cons_padre || ' and ';
                          
              --Definicion de la respuesta        
      		v_consulta:=v_consulta||v_parametros.filtro;
                          
              raise notice '%',v_consulta;

            --Devuelve la respuesta
            return v_consulta;
        end;

        /*********************************
        #TRANSACCION: 'GEM_TUCHIJOS_CONT'
        #DESCRIPCION: Conteo de registros
        #AUTOR: aao
        #FECHA: 12-11-2012 10:49:00
        ***********************************/

        elsif(p_transaccion='GEM_TUCHIJOS_CONT')then

        begin
        --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(tuc.id_uni_cons)
                        from gem.tuni_cons tuc
                        inner join gem.tuni_cons_comp tcc on tuc.id_uni_cons = tcc.id_uni_cons_hijo
                        where tcc.estado_reg = ''activo''
                        and tcc.id_uni_cons_padre = '|| v_parametros.id_uni_cons_padre;

            --Devuelve la respuesta
            return v_consulta;

        end;
            
        /*********************************
        #TRANSACCION: 'GEM_TUCDETALLE_SEL'
        #DESCRIPCION: obtiene los pares ordenados del detalle de una unidad constructiva
        #AUTOR: aao
        #FECHA: 12/11/2012
        ***********************************/

        elsif(p_transaccion='GEM_TUCDETALLE_SEL')then
             
             begin
             --Sentencia de la consulta
                  v_consulta:='select tcd.id_uni_cons_det,
                                  tcd.codigo,
                                  tcd.nombre,
                                  tcd.descripcion,
                                  tcd.valor,
                                  tum.codigo as unidad_medidad
                              from gem.tuni_cons_det tcd
                              left join param.tunidad_medida tum on tcd.id_unidad_medida = tum.id_unidad_medida
                              where tcd.estado_reg = ''activo''
                              and tcd.id_uni_cons = '|| v_parametros.id_uni_cons;

            --Devuelve la respuesta
            return v_consulta;
        end;

        /*********************************
        #TRANSACCION: 'GEM_TUCDETALLE_CONT'
        #DESCRIPCION: Conteo de registros
        #AUTOR: aao
        #FECHA: 12-11-2012 10:49:00
        ***********************************/

        elsif(p_transaccion='GEM_TUCDETALLE_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(tcd.id_uni_cons_det)
                        from gem.tuni_cons_det tcd
                        where tcd.estado_reg = ''activo''
                        and tcd.id_uni_cons = '|| v_parametros.id_uni_cons;

            --Devuelve la respuesta
            return v_consulta;

        end;
        
        /*********************************
        #TRANSACCION: 'GEM_TUCLOC_SEL'
        #DESCRIPCION: Obtiene los registros de una unidades constructivas por localizacion
        #AUTOR: Gonzalo Sarmiento Sejas
        #FECHA: 29/11/2012
        ***********************************/

        elsif(p_transaccion='GEM_TUCLOC_SEL')then
             
             begin
             --Sentencia de la consulta
                  v_consulta:='select
                        tuc.id_uni_cons,
              tuc.id_localizacion,
                            tuc.codigo,                            
                            tuc.nombre                            
                            from gem.tuni_cons tuc
                          where tuc.estado_reg=''activo'' and tuc.tipo_nodo!=''base'' and tuc.id_localizacion='||v_parametros.id_localizacion||' and ';
      v_consulta:=v_consulta||v_parametros.filtro;
            --Devuelve la respuesta
            return v_consulta;
        end;
        
      	/*********************************
        #TRANSACCION: 'GEM_EQGRAL_SEL'
        #DESCRIPCION: Listado plano de todos los equipos a partir de una localización padre
        #AUTOR: rcm
        #FECHA: 05/02/2013
        ***********************************/

        elsif(p_transaccion='GEM_EQGRAL_SEL')then
             
             begin
             
--             raise exception '%,%',v_parametros.tipo_nodo,v_parametros.id_uni_cons;
              if v_parametros.tipo_nodo in ('uni_cons','uni_cons_f','rama','raiz_registrado') then
                --equipo
                v_consulta:=' select * from (
                          select
                equipo.id_uni_cons,
                equipo.id_tipo_equipo,
                equipo.id_localizacion,
                equipo.tipo_unicons,
                equipo.id_plantilla,
                equipo.codigo,
                equipo.incluir_calgen,
                equipo.otros_datos_tec,
                equipo.estado_reg,
                equipo.punto_recepcion_despacho,
                equipo.tipo_nodo,
                equipo.id_usuarios,
                equipo.tipo,
                equipo.herramientas_especiales,
                equipo.estado,
                equipo.nombre,
                equipo.funcion,
                equipo.id_usuario_reg,
                equipo.fecha_reg,
                equipo.id_usuario_mod,
                equipo.fecha_mod,
                usu1.cuenta as usr_reg,
                usu2.cuenta as usr_mod,
                --gem.f_get_localizacion_nombre_predecesores(equipo.id_localizacion) as localizaciones,
                teq.nombre as desc_tipo_equipo,
                equipo.nombre as desc_plantilla,
                equipo.horas_dia
                from gem.tuni_cons equipo
                inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                inner join gem.ttipo_equipo teq
                on teq.id_tipo_equipo = equipo.id_tipo_equipo
                inner join gem.tuni_cons plant
                on plant.id_uni_cons = equipo.id_plantilla
                where equipo.id_uni_cons = '||v_parametros.id_uni_cons||') eqgral
                where ';
                
          v_consulta:=v_consulta||v_parametros.filtro;
          v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
               
              elsif v_parametros.tipo_nodo in ('id') then
                --raiz
                v_consulta:=' select * from (
                          select
                equipo.id_uni_cons,
                equipo.id_tipo_equipo,
                equipo.id_localizacion,
                equipo.tipo_unicons,
                equipo.id_plantilla,
                equipo.codigo,
                equipo.incluir_calgen,
                equipo.otros_datos_tec,
                equipo.estado_reg,
                equipo.punto_recepcion_despacho,
                equipo.tipo_nodo,
                equipo.id_usuarios,
                equipo.tipo,
                equipo.herramientas_especiales,
                equipo.estado,
                equipo.nombre,
                equipo.funcion,
                equipo.id_usuario_reg,
                equipo.fecha_reg,
                equipo.id_usuario_mod,
                equipo.fecha_mod,
                usu1.cuenta as usr_reg,
                usu2.cuenta as usr_mod,
                --gem.f_get_localizacion_nombre_predecesores(equipo.id_localizacion) as localizaciones,
                teq.nombre as desc_tipo_equipo,
                equipo.nombre as desc_plantilla,
                equipo.horas_dia
                from gem.tuni_cons equipo
                inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                inner join gem.ttipo_equipo teq
                on teq.id_tipo_equipo = equipo.id_tipo_equipo
                inner join gem.tuni_cons plant
                on plant.id_uni_cons = equipo.id_plantilla
                where equipo.tipo = ''uc''
                and equipo.tipo_nodo = ''raiz''
                and equipo.estado_reg = ''activo'') eqgral
                where ';
                
          v_consulta:=v_consulta||v_parametros.filtro;
          v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
               
              else
                --localizaciones
                --Obtiene todos los id_localizacion
          WITH RECURSIVE t(id,id_fk,nombre,n) AS (
              SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
              FROM gem.tlocalizacion l 
              WHERE l.id_localizacion = v_parametros.id_localizacion
              UNION ALL
              SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
              FROM gem.tlocalizacion l, t
              WHERE l.id_localizacion_fk = t.id
            )
          SELECT pxp.list(id::text)
          into v_ids_loc
          FROM t;
          
                --Sentencia de la consulta
                    v_consulta:=' select * from (
                          select
                equipo.id_uni_cons,
                equipo.id_tipo_equipo,
                equipo.id_localizacion,
                equipo.tipo_unicons,
                equipo.id_plantilla,
                equipo.codigo,
                equipo.incluir_calgen,
                equipo.otros_datos_tec,
                equipo.estado_reg,
                equipo.punto_recepcion_despacho,
                equipo.tipo_nodo,
                equipo.id_usuarios,
                equipo.tipo,
                equipo.herramientas_especiales,
                equipo.estado,
                equipo.nombre,
                equipo.funcion,
                equipo.id_usuario_reg,
                equipo.fecha_reg,
                equipo.id_usuario_mod,
                equipo.fecha_mod,
                usu1.cuenta as usr_reg,
                usu2.cuenta as usr_mod,
                --gem.f_get_localizacion_nombre_predecesores(equipo.id_localizacion) as localizaciones,
                teq.nombre as desc_tipo_equipo,
                equipo.nombre as desc_plantilla,
                equipo.horas_dia
                from gem.tuni_cons equipo
                inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                inner join gem.ttipo_equipo teq
                on teq.id_tipo_equipo = equipo.id_tipo_equipo
                inner join gem.tuni_cons plant
                on plant.id_uni_cons = equipo.id_plantilla
                where equipo.tipo = ''uc''
                and equipo.tipo_nodo = ''raiz''
                and equipo.estado_reg = ''activo''
                and equipo.id_localizacion in ('||v_ids_loc||')) eqgral
                where ';
                
          v_consulta:=v_consulta||v_parametros.filtro;
          v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
                    
              end if;
           raise notice '%',v_consulta;  
              
            --Devuelve la respuesta
            return v_consulta;
        end;

        /*********************************
        #TRANSACCION: 'GEM_EQGRAL_CONT'
        #DESCRIPCION: Conteo de registros
        #AUTOR: aao
        #FECHA: 12-11-2012 10:49:00
        ***********************************/

        elsif(p_transaccion='GEM_EQGRAL_CONT')then

        begin
        
          if v_parametros.tipo_nodo in ('uni_cons','uni_cons_f','rama','raiz_registrado') then
            --unicons
            v_consulta:=' select count(id_uni_cons)
                       from (
                            select
                  equipo.id_uni_cons,
                  equipo.id_tipo_equipo,
                  equipo.id_localizacion,
                  equipo.tipo_unicons,
                  equipo.id_plantilla,
                  equipo.codigo,
                  equipo.incluir_calgen,
                  equipo.otros_datos_tec,
                  equipo.estado_reg,
                  equipo.punto_recepcion_despacho,
                  equipo.tipo_nodo,
                  equipo.id_usuarios,
                  equipo.tipo,
                  equipo.herramientas_especiales,
                  equipo.estado,
                  equipo.nombre,
                  equipo.funcion,
                  equipo.id_usuario_reg,
                  equipo.fecha_reg,
                  equipo.id_usuario_mod,
                  equipo.fecha_mod,
                  usu1.cuenta as usr_reg,
                  usu2.cuenta as usr_mod,
                  equipo.horas_dia
                                  --,gem.f_get_localizacion_nombre_predecesores(equipo.id_localizacion)
                  from gem.tuni_cons equipo
                  inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                  left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                  inner join gem.ttipo_equipo teq
                  on teq.id_tipo_equipo = equipo.id_tipo_equipo
                  inner join gem.tuni_cons plant
                  on plant.id_uni_cons = equipo.id_plantilla
                  where equipo.id_uni_cons = '|| v_parametros.id_uni_cons ||') eqgral
                  where ';
                    
        v_consulta:=v_consulta||v_parametros.filtro;
          
          elsif v_parametros.tipo_nodo in ('id') then
            --Nodo raiz
            v_consulta:=' select count(id_uni_cons)
                       from (
                            select
                  equipo.id_uni_cons,
                  equipo.id_tipo_equipo,
                  equipo.id_localizacion,
                  equipo.tipo_unicons,
                  equipo.id_plantilla,
                  equipo.codigo,
                  equipo.incluir_calgen,
                  equipo.otros_datos_tec,
                  equipo.estado_reg,
                  equipo.punto_recepcion_despacho,
                  equipo.tipo_nodo,
                  equipo.id_usuarios,
                  equipo.tipo,
                  equipo.herramientas_especiales,
                  equipo.estado,
                  equipo.nombre,
                  equipo.funcion,
                  equipo.id_usuario_reg,
                  equipo.fecha_reg,
                  equipo.id_usuario_mod,
                  equipo.fecha_mod,
                  usu1.cuenta as usr_reg,
                  usu2.cuenta as usr_mod,
                  equipo.horas_dia
                                  --,gem.f_get_localizacion_nombre_predecesores(equipo.id_localizacion)
                  from gem.tuni_cons equipo
                  inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                  left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                  inner join gem.ttipo_equipo teq
                  on teq.id_tipo_equipo = equipo.id_tipo_equipo
                  inner join gem.tuni_cons plant
                  on plant.id_uni_cons = equipo.id_plantilla
                  where equipo.tipo = ''uc''
                  and equipo.tipo_nodo = ''raiz''
                  and equipo.estado_reg = ''activo'') eqgral
                  where ';
                    
        v_consulta:=v_consulta||v_parametros.filtro;
          
          else
            --Localizacion
            --Obtiene todos los id_localizacion
        WITH RECURSIVE t(id,id_fk,nombre,n) AS (
            SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
            FROM gem.tlocalizacion l 
            WHERE l.id_localizacion = v_parametros.id_localizacion
            UNION ALL
            SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
            FROM gem.tlocalizacion l, t
            WHERE l.id_localizacion_fk = t.id
          )
        SELECT pxp.list(id::text)
        into v_ids_loc
        FROM t;
            
              --Sentencia de la consulta de conteo de registros
              v_consulta:=' select count(id_uni_cons)
                       from (
                            select
                  equipo.id_uni_cons,
                  equipo.id_tipo_equipo,
                  equipo.id_localizacion,
                  equipo.tipo_unicons,
                  equipo.id_plantilla,
                  equipo.codigo,
                  equipo.incluir_calgen,
                  equipo.otros_datos_tec,
                  equipo.estado_reg,
                  equipo.punto_recepcion_despacho,
                  equipo.tipo_nodo,
                  equipo.id_usuarios,
                  equipo.tipo,
                  equipo.herramientas_especiales,
                  equipo.estado,
                  equipo.nombre,
                  equipo.funcion,
                  equipo.id_usuario_reg,
                  equipo.fecha_reg,
                  equipo.id_usuario_mod,
                  equipo.fecha_mod,
                  usu1.cuenta as usr_reg,
                  usu2.cuenta as usr_mod,
                  equipo.horas_dia
                                  --,gem.f_get_localizacion_nombre_predecesores(equipo.id_localizacion)
                  from gem.tuni_cons equipo
                  inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                  left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                  inner join gem.ttipo_equipo teq
                  on teq.id_tipo_equipo = equipo.id_tipo_equipo
                  inner join gem.tuni_cons plant
                  on plant.id_uni_cons = equipo.id_plantilla
                  where equipo.tipo = ''uc''
                  and equipo.tipo_nodo = ''raiz''
                  and equipo.estado_reg = ''activo''
                  and equipo.id_localizacion in ('||v_ids_loc||')) eqgral
                  where ';
                    
        v_consulta:=v_consulta||v_parametros.filtro;
          
          end if;
        
          
            --Devuelve la respuesta
            return v_consulta;

        end;
        
        /*********************************
        #TRANSACCION: 'GEM_INVEQU_SEL'
        #DESCRIPCION: Inventario de los equipos
        #AUTOR: rcm
        #FECHA: 14/05/2013
        ***********************************/

        elsif(p_transaccion='GEM_INVEQU_SEL')then
             
            begin
              if v_parametros.tipo_nodo in ('uni_cons','uni_cons_f') then
                --equipo
                v_consulta:=' select * from (
                          select
                          equipo.codigo, equipo.nombre, teq.nombre as tipo_equipo,
                          locp1.nombre as unidad, locp2.nombre as lugar, locp3.nombre as est_pla,
                          locp4.nombre as localiz,
                          equipo.id_usuario_reg,
                          equipo.fecha_reg,
                          equipo.id_usuario_mod,
                          equipo.fecha_mod,
                          usu1.cuenta as usr_reg,
                          usu2.cuenta as usr_mod
                          from gem.tuni_cons equipo
                          inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                          left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                          inner join gem.ttipo_equipo teq
                          on teq.id_tipo_equipo = equipo.id_tipo_equipo
                          inner join gem.tlocalizacion locp1 on locp1.id_localizacion = equipo.id_localizacion
                          inner join gem.tlocalizacion locp2 on locp2.id_localizacion = locp1.id_localizacion_fk
                          inner join gem.tlocalizacion locp3 on locp3.id_localizacion = locp2.id_localizacion_fk
                          inner join gem.tlocalizacion locp4 on locp4.id_localizacion = locp3.id_localizacion_fk
                          where equipo.id_uni_cons = '||v_parametros.id_uni_cons||') eqgral
                          where ';
                
          v_consulta:=v_consulta||v_parametros.filtro;
          v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
               
              elsif v_parametros.tipo_nodo in ('id') then
                --raiz
                v_consulta:=' select * from (
                          select
                          equipo.codigo, equipo.nombre, teq.nombre as tipo_equipo,
                          locp1.nombre as unidad, locp2.nombre as lugar, locp3.nombre as est_pla,
                          locp4.nombre as localiz,
                          equipo.id_usuario_reg,
                          equipo.fecha_reg,
                          equipo.id_usuario_mod,
                          equipo.fecha_mod,
                          usu1.cuenta as usr_reg,
                          usu2.cuenta as usr_mod
                          from gem.tuni_cons equipo
                          inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                          left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                          inner join gem.ttipo_equipo teq
                          on teq.id_tipo_equipo = equipo.id_tipo_equipo
                          inner join gem.tlocalizacion locp1 on locp1.id_localizacion = equipo.id_localizacion
                          inner join gem.tlocalizacion locp2 on locp2.id_localizacion = locp1.id_localizacion_fk
                          inner join gem.tlocalizacion locp3 on locp3.id_localizacion = locp2.id_localizacion_fk
                          inner join gem.tlocalizacion locp4 on locp4.id_localizacion = locp3.id_localizacion_fk
                          where equipo.tipo = ''uc''
                          and equipo.tipo_nodo = ''raiz''
                          and equipo.estado_reg = ''activo'') eqgral
                          where ';
                
          v_consulta:=v_consulta||v_parametros.filtro;
          v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
               
              else
                --localizaciones
                --Obtiene todos los id_localizacion
          WITH RECURSIVE t(id,id_fk,nombre,n) AS (
              SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
              FROM gem.tlocalizacion l 
              WHERE l.id_localizacion = v_parametros.id_localizacion
              UNION ALL
              SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
              FROM gem.tlocalizacion l, t
              WHERE l.id_localizacion_fk = t.id
            )
          SELECT pxp.list(id::text)
          into v_ids_loc
          FROM t;
          
                --Sentencia de la consulta
                    v_consulta:=' select * from (
                          select
                          equipo.codigo, equipo.nombre, teq.nombre as tipo_equipo,
                          locp1.nombre as unidad, locp2.nombre as lugar, locp3.nombre as est_pla,
                          locp4.nombre as localiz,
                          equipo.id_usuario_reg,
                          equipo.fecha_reg,
                          equipo.id_usuario_mod,
                          equipo.fecha_mod,
                          usu1.cuenta as usr_reg,
                          usu2.cuenta as usr_mod
                          from gem.tuni_cons equipo
                          inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                          left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                          inner join gem.ttipo_equipo teq
                          on teq.id_tipo_equipo = equipo.id_tipo_equipo
                          inner join gem.tlocalizacion locp1 on locp1.id_localizacion = equipo.id_localizacion
                          inner join gem.tlocalizacion locp2 on locp2.id_localizacion = locp1.id_localizacion_fk
                          inner join gem.tlocalizacion locp3 on locp3.id_localizacion = locp2.id_localizacion_fk
                          inner join gem.tlocalizacion locp4 on locp4.id_localizacion = locp3.id_localizacion_fk
                          where equipo.tipo = ''uc''
                          and equipo.tipo_nodo = ''raiz''
                          and equipo.estado_reg = ''activo''
                          and equipo.id_localizacion in ('||v_ids_loc||')) eqgral
                          where ';
                
          v_consulta:=v_consulta||v_parametros.filtro;
          v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
                    
              end if;
           raise notice '%',v_consulta;  
              
            --Devuelve la respuesta
            return v_consulta;
        end;

        /*********************************
        #TRANSACCION: 'GEM_INVEQU_CONT'
        #DESCRIPCION: Conteo de registros
        #AUTOR: aao
        #FECHA: 12-11-2012 10:49:00
        ***********************************/

        elsif(p_transaccion='GEM_INVEQU_CONT')then

        begin
        
          if v_parametros.tipo_nodo in ('uni_cons','uni_cons_f') then
            --unicons
            v_consulta:=' select count(codigo)
                       from (
                            select
                          equipo.codigo, equipo.nombre, teq.nombre as tipo_equipo,
                          locp1.nombre as unidad, locp2.nombre as lugar, locp3.nombre as est_pla,
                          locp4.nombre as localiz,
                          equipo.id_usuario_reg,
                          equipo.fecha_reg,
                          equipo.id_usuario_mod,
                          equipo.fecha_mod,
                          usu1.cuenta as usr_reg,
                          usu2.cuenta as usr_mod
                          from gem.tuni_cons equipo
                          inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                          left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                          inner join gem.ttipo_equipo teq
                          on teq.id_tipo_equipo = equipo.id_tipo_equipo
                          inner join gem.tlocalizacion locp1 on locp1.id_localizacion = equipo.id_localizacion
                          inner join gem.tlocalizacion locp2 on locp2.id_localizacion = locp1.id_localizacion_fk
                          inner join gem.tlocalizacion locp3 on locp3.id_localizacion = locp2.id_localizacion_fk
                          inner join gem.tlocalizacion locp4 on locp4.id_localizacion = locp3.id_localizacion_fk
                  where equipo.id_uni_cons = '|| v_parametros.id_uni_cons ||') eqgral
                  where ';
                    
        v_consulta:=v_consulta||v_parametros.filtro;
          
          elsif v_parametros.tipo_nodo in ('id') then
            --Nodo raiz
            v_consulta:=' select count(codigo)
                       from (
                            select
                          equipo.codigo, equipo.nombre, teq.nombre as tipo_equipo,
                          locp1.nombre as unidad, locp2.nombre as lugar, locp3.nombre as est_pla,
                          locp4.nombre as localiz,
                          equipo.id_usuario_reg,
                          equipo.fecha_reg,
                          equipo.id_usuario_mod,
                          equipo.fecha_mod,
                          usu1.cuenta as usr_reg,
                          usu2.cuenta as usr_mod
                  from gem.tuni_cons equipo
                  inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                  left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                  inner join gem.ttipo_equipo teq
                  on teq.id_tipo_equipo = equipo.id_tipo_equipo
                  inner join gem.tlocalizacion locp1 on locp1.id_localizacion = equipo.id_localizacion
                  inner join gem.tlocalizacion locp2 on locp2.id_localizacion = locp1.id_localizacion_fk
                  inner join gem.tlocalizacion locp3 on locp3.id_localizacion = locp2.id_localizacion_fk
                  inner join gem.tlocalizacion locp4 on locp4.id_localizacion = locp3.id_localizacion_fk
                  where equipo.tipo = ''uc''
                  and equipo.tipo_nodo = ''raiz''
                  and equipo.estado_reg = ''activo'') eqgral
                  where ';
                    
        v_consulta:=v_consulta||v_parametros.filtro;
          
          else
            --Localizacion
            --Obtiene todos los id_localizacion
        WITH RECURSIVE t(id,id_fk,nombre,n) AS (
            SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
            FROM gem.tlocalizacion l 
            WHERE l.id_localizacion = v_parametros.id_localizacion
            UNION ALL
            SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
            FROM gem.tlocalizacion l, t
            WHERE l.id_localizacion_fk = t.id
          )
        SELECT pxp.list(id::text)
        into v_ids_loc
        FROM t;
            
              --Sentencia de la consulta de conteo de registros
              v_consulta:=' select count(codigo)
                       from (
                            select
                          equipo.codigo, equipo.nombre, teq.nombre as tipo_equipo,
                          locp1.nombre as unidad, locp2.nombre as lugar, locp3.nombre as est_pla,
                          locp4.nombre as localiz,
                          equipo.id_usuario_reg,
                          equipo.fecha_reg,
                          equipo.id_usuario_mod,
                          equipo.fecha_mod,
                          usu1.cuenta as usr_reg,
                          usu2.cuenta as usr_mod
                  from gem.tuni_cons equipo
                  inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                  left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                  inner join gem.ttipo_equipo teq
                  on teq.id_tipo_equipo = equipo.id_tipo_equipo
                  inner join gem.tlocalizacion locp1 on locp1.id_localizacion = equipo.id_localizacion
                  inner join gem.tlocalizacion locp2 on locp2.id_localizacion = locp1.id_localizacion_fk
                  inner join gem.tlocalizacion locp3 on locp3.id_localizacion = locp2.id_localizacion_fk
                  inner join gem.tlocalizacion locp4 on locp4.id_localizacion = locp3.id_localizacion_fk
                  where equipo.tipo = ''uc''
                  and equipo.tipo_nodo = ''raiz''
                  and equipo.estado_reg = ''activo''
                  and equipo.id_localizacion in ('||v_ids_loc||')) eqgral
                  where ';
                    
        v_consulta:=v_consulta||v_parametros.filtro;
          
          end if;
        
          
            --Devuelve la respuesta
            return v_consulta;

        end;
        
  		/*********************************
        #TRANSACCION: 'GEM_EQGRALH_SEL'
        #DESCRIPCION: Listado plano de todos los subsistemas de un equipo
        #AUTOR: rcm
        #FECHA: 05/02/2013
        ***********************************/

        elsif(p_transaccion='GEM_EQGRALH_SEL')then
             
            begin
             
				if not pxp.f_existe_parametro(p_tabla,'id_uni_cons') then
					raise exception 'Equipo no definido';
				end if;
             
                v_consulta:=' select * from (
                          select
		                equipo.id_uni_cons,
		                equipo.id_tipo_equipo,
		                equipo.id_localizacion,
		                equipo.tipo_unicons,
		                equipo.id_plantilla,
		                equipo.codigo,
		                equipo.incluir_calgen,
		                equipo.otros_datos_tec,
		                equipo.estado_reg,
		                equipo.punto_recepcion_despacho,
		                equipo.tipo_nodo,
		                equipo.id_usuarios,
		                equipo.tipo,
		                equipo.herramientas_especiales,
		                equipo.estado,
		                equipo.nombre,
		                equipo.funcion,
		                equipo.id_usuario_reg,
		                equipo.fecha_reg,
		                equipo.id_usuario_mod,
		                equipo.fecha_mod,
		                usu1.cuenta as usr_reg,
		                usu2.cuenta as usr_mod,
		                --gem.f_get_localizacion_nombre_predecesores(equipo.id_localizacion) as localizaciones,
		                teq.nombre as desc_tipo_equipo,
		                equipo.nombre as desc_plantilla,
		                equipo.horas_dia
		                from gem.tuni_cons_comp ucomp 
		                inner join gem.tuni_cons equipo on equipo.id_uni_cons = ucomp.id_uni_cons_hijo
		                inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
		                left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
		                inner join gem.ttipo_equipo teq
		                on teq.id_tipo_equipo = equipo.id_tipo_equipo
		                where ucomp.id_uni_cons_padre = '||v_parametros.id_uni_cons||') eqgral
		                where ';
                
          v_consulta:=v_consulta||v_parametros.filtro;
          v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
               

           raise notice '%',v_consulta;  
              
            --Devuelve la respuesta
            return v_consulta;
        end;      
   
  		/*********************************
        #TRANSACCION: 'GEM_EQGRALH_CONT'
        #DESCRIPCION: Listado plano de todos los subsistemas de un equipo
        #AUTOR: rcm
        #FECHA: 05/02/2013
        ***********************************/

        elsif(p_transaccion='GEM_EQGRALH_CONT')then
             
            begin
             
				if not pxp.f_existe_parametro(p_tabla,'id_uni_cons') then
					raise exception 'Equipo no definido';
				end if;
             
                v_consulta:=' select count(id_uni_cons) from (
                          select
		                equipo.id_uni_cons,
		                equipo.id_tipo_equipo,
		                equipo.id_localizacion,
		                equipo.tipo_unicons,
		                equipo.id_plantilla,
		                equipo.codigo,
		                equipo.incluir_calgen,
		                equipo.otros_datos_tec,
		                equipo.estado_reg,
		                equipo.punto_recepcion_despacho,
		                equipo.tipo_nodo,
		                equipo.id_usuarios,
		                equipo.tipo,
		                equipo.herramientas_especiales,
		                equipo.estado,
		                equipo.nombre,
		                equipo.funcion,
		                equipo.id_usuario_reg,
		                equipo.fecha_reg,
		                equipo.id_usuario_mod,
		                equipo.fecha_mod,
		                usu1.cuenta as usr_reg,
		                usu2.cuenta as usr_mod,
		                --gem.f_get_localizacion_nombre_predecesores(equipo.id_localizacion) as localizaciones,
		                teq.nombre as desc_tipo_equipo,
		                equipo.nombre as desc_plantilla,
		                equipo.horas_dia
		                from gem.tuni_cons_comp ucomp 
		                inner join gem.tuni_cons equipo on equipo.id_uni_cons = ucomp.id_uni_cons_hijo
		                inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
		                left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
		                inner join gem.ttipo_equipo teq
		                on teq.id_tipo_equipo = equipo.id_tipo_equipo
		                where ucomp.id_uni_cons_padre = '||v_parametros.id_uni_cons||') eqgral
		                where ';
                
          v_consulta:=v_consulta||v_parametros.filtro;

           raise notice '%',v_consulta;  
              
            --Devuelve la respuesta
            return v_consulta;
        end;
        
        
  /*********************************    
  #TRANSACCION:  'GEM_TUCPLA2_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   rcm 
  #FECHA:   13/06/2013
  ***********************************/
    
  elsif(p_transaccion='GEM_TUCPLA2_SEL')then
            
    begin
          v_tipo='uc';        
          if pxp.f_existe_parametro(p_tabla,'tipo') then
            v_tipo='tuc';        
          end if;
          if pxp.f_existe_parametro(p_tabla,'id_localizacion') then
            v_ids_loc=gem.f_get_id_localizaciones(v_parametros.id_localizacion);        
          end if;
          
          v_cond='';
          	if p_administrador!=1 then
          		v_cond = ' and ' || p_id_usuario||' = ANY (tuc.id_usuarios) ';
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
            eq.nombre as nombre_tipo_equipo,
                        gem.f_get_nombre_localizacion_rec(tuc.id_localizacion,''padres'') as padres_loc,
                        loc.codigo || '' - '' || loc.nombre as desc_localizacion,
            tuc.codigo || '' - '' ||tuc.nombre as desc_equipo
            from gem.tuni_cons tuc
            inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
                        left join gem.ttipo_equipo eq on eq.id_tipo_equipo= tuc.id_tipo_equipo
                        left join gem.tlocalizacion loc on loc.id_localizacion = tuc.id_localizacion
                where tuc.tipo = '''||v_tipo||'''
                and tuc.estado_reg = ''activo'' and tuc.tipo_nodo = ''raiz'' and (tuc.estado=''aprobado'' or tuc.estado=''registrado'') and ';
           if pxp.f_existe_parametro(p_tabla,'id_localizacion') then
           		v_consulta = v_consulta ||' tuc.id_localizacion in (' || v_ids_loc ||') and ';
           end if;
       
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      if v_cond !='' then
      	v_consulta = v_consulta || v_cond;
      end if;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
      raise notice '%',v_consulta;
      --Devuelve la respuesta
      return v_consulta;
            
    end;
        
     
  /*********************************    
  #TRANSACCION:  'GEM_TUCPLA2_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   rcm 
  #FECHA:   13/06/2013
  ***********************************/

  elsif(p_transaccion='GEM_TUCPLA2_CONT')then

    begin

        v_tipo='uc';        
		if pxp.f_existe_parametro(p_tabla,'tipo') then
        	v_tipo='tuc';        
        end if;
        if pxp.f_existe_parametro(p_tabla,'id_localizacion') then
            v_ids_loc=gem.f_get_id_localizaciones(v_parametros.id_localizacion);        
        end if;
        
        v_cond='';
        if p_administrador!=1 then
          		v_cond = ' and ' || p_id_usuario||' = ANY (tuc.id_usuarios) ';
		end if;
        
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_uni_cons)
              from gem.tuni_cons tuc
            inner join segu.tusuario usu1 on usu1.id_usuario = tuc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = tuc.id_usuario_mod
                        left join gem.ttipo_equipo eq on eq.id_tipo_equipo= tuc.id_tipo_equipo
                        left join gem.tlocalizacion loc on loc.id_localizacion = tuc.id_localizacion
                where tuc.tipo = '''||v_tipo||'''
                and tuc.estado_reg = ''activo'' and tuc.tipo_nodo = ''raiz'' and (tuc.estado=''aprobado'' or tuc.estado=''registrado'') and ';
       
           -- raise exception '%', v_consulta;
           
		if pxp.f_existe_parametro(p_tabla,'id_localizacion') then
        	v_consulta = v_consulta ||' tuc.id_localizacion in (' || v_ids_loc ||') and ';
		end if;
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;
      
      if v_cond !='' then
      	v_consulta = v_consulta || v_cond;
      end if;

      --Devuelve la respuesta
      return v_consulta;

    end; 
    
    /*********************************
    #TRANSACCION: 'GEM_EQOPER_SEL'
    #DESCRIPCION: Listado plano de todos los equipos que tiene asignado una persona
    #AUTOR: rcm
    #FECHA: 01/08/2013
    ***********************************/

    elsif(p_transaccion='GEM_EQOPER_SEL')then
         
         begin
         
         	if p_administrador != 1  then
		      	v_filtro = p_id_usuario||' = ANY (equipo.id_usuarios) ';
		    else 
		        v_filtro = '  0=0 ';
		    end if;
         
         	v_consulta:=' select
                  equipo.id_uni_cons,
                  equipo.id_tipo_equipo,
                  equipo.id_localizacion,
                  equipo.tipo_unicons,
                  equipo.id_plantilla,
                  equipo.codigo,
                  equipo.incluir_calgen,
                  equipo.otros_datos_tec,
                  equipo.estado_reg,
                  equipo.punto_recepcion_despacho,
                  equipo.tipo_nodo,
                  equipo.id_usuarios,
                  equipo.tipo,
                  equipo.herramientas_especiales,
                  equipo.estado,
                  equipo.nombre,
                  equipo.funcion,
                  equipo.id_usuario_reg,
                  equipo.fecha_reg,
                  equipo.id_usuario_mod,
                  equipo.fecha_mod,
                  usu1.cuenta as usr_reg,
                  usu2.cuenta as usr_mod,
                  equipo.horas_dia,
                  gem.f_get_nombre_localizacion_rec(equipo.id_localizacion,''padres'') as desc_localizacion
                  from gem.tuni_cons equipo
                  inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
                  left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
                  inner join gem.ttipo_equipo teq
                  on teq.id_tipo_equipo = equipo.id_tipo_equipo
                  inner join gem.tuni_cons plant
                  on plant.id_uni_cons = equipo.id_plantilla
                  where equipo.estado_reg=''activo'' and equipo.tipo_nodo = ''raiz'' and (equipo.estado=''aprobado'' or equipo.estado=''registrado'') and ' || v_filtro ||' and ';
                    
  			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			
			--Devuelve la respuesta
			return v_consulta;
         	
         end;
             
	/*********************************    
  	#TRANSACCION:  'GEM_EQOPER_CONT'
  	#DESCRIPCION: Conteo de registros
  	#AUTOR:   rcm 
  	#FECHA:   01/08/2013
  	***********************************/

  	elsif(p_transaccion='GEM_EQOPER_CONT')then

    	begin
    	
    		if p_administrador != 1  then
		      	v_filtro = p_id_usuario||' = ANY (equipo.id_usuarios) ';
		    else 
		        v_filtro = '  0=0 ';
		    end if;
   
   			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(equipo.id_uni_cons)
					    from gem.tuni_cons equipo
	                  inner join segu.tusuario usu1 on usu1.id_usuario = equipo.id_usuario_reg
	                  left join segu.tusuario usu2 on usu2.id_usuario = equipo.id_usuario_mod
	                  inner join gem.ttipo_equipo teq
	                  on teq.id_tipo_equipo = equipo.id_tipo_equipo
	                  inner join gem.tuni_cons plant
	                  on plant.id_uni_cons = equipo.id_plantilla
	                  where equipo.estado_reg=''activo'' and equipo.tipo_nodo = ''raiz'' and (equipo.estado=''aprobado'' or equipo.estado=''registrado'') and ' || v_filtro ||' and ';
			
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