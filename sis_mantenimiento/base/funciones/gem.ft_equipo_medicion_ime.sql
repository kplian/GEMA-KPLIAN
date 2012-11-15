--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.ft_equipo_medicion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.ft_equipo_medicion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tequipo_medicion'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_equipo_medicion	integer;
    
    v_consulta_modificacion varchar;
    v_consulta_inser varchar;
    v_consulta varchar;
    
    
    v_param varchar[]; 
    v_param_det varchar[]; 
    v_tamano  integer;
    v_i integer;
    
   v_medicion varchar;
   v_id_equipo_variable varchar[];
 
                
                
    
			    
BEGIN

    v_nombre_funcion = 'gem.ft_equipo_medicion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	if(p_transaccion='GEM_GEMEDI_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tequipo_medicion(
			id_equipo_variable,
			observaciones,
			estado_reg,
			fecha_medicion,
			medicion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_equipo_variable,
			v_parametros.observaciones,
			'activo',
			v_parametros.fecha_medicion,
			v_parametros.medicion,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_equipo_medicion into v_id_equipo_medicion;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones almacenado(a) con exito (id_equipo_medicion'||v_id_equipo_medicion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_medicion',v_id_equipo_medicion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	elsif(p_transaccion='GEM_GEMEDI_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tequipo_medicion set
			id_equipo_variable = v_parametros.id_equipo_variable,
			observaciones = v_parametros.observaciones,
			fecha_medicion = v_parametros.fecha_medicion,
			medicion = v_parametros.medicion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_equipo_medicion=v_parametros.id_equipo_medicion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_medicion',v_parametros.id_equipo_medicion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_GEMEDI_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-09-2012 03:02:35
	***********************************/

	elsif(p_transaccion='GEM_GEMEDI_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tequipo_medicion
            where id_equipo_medicion=v_parametros.id_equipo_medicion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mediciones eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_equipo_medicion',v_parametros.id_equipo_medicion::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
    /*********************************    
 	#TRANSACCION:  'GEM_EQUMEDDIN_INS'
 	#DESCRIPCION:	Insercion de mediciones desde la interfaz equipo medicion dinamico
 	#AUTOR:		rac	
 	#FECHA:		16-03-2012 17:06:17
	***********************************/

	elseif(p_transaccion='GEM_EQUMEDDIN_INS')then
					
        begin
        
             
           
        
        
        
        --Sentencia de la consulta
			  v_consulta_inser:='insert into gem.tequipo_medicion (
                                                              fecha_medicion,
                                                              hora,
                                                              estado_reg,
                                                              id_usuario_reg,
                                                              fecha_reg,
                                                              id_equipo_variable,
                                                              medicion) values(
                                                                              '''||v_parametros.fecha ||''',
                                                                              '''||v_parametros.hora||''',
                                                                              ''estado'',
                                                                              '||p_id_usuario||',
                                                                              '''||now()||''',' ;
        
               
              v_consulta_modificacion = 'UPDATE 
                                          gem.tequipo_medicion  
                                        SET 
                                          id_usuario_mod = '||p_id_usuario||',
                                          fecha_mod = '''||now()||''',
                                          hora = '''||v_parametros.hora||''',
                                          fecha_medicion = '''||v_parametros.fecha||''',';
                                          
                                          /*
                                          medicion = :medicion
                                          
                                         
                                        WHERE 
                                          id_equipo_medicion = :id_equipo_medicion';*/
                                     
           
                        
              v_param= string_to_array(v_parametros.datos,'@');
              v_tamano = coalesce(array_length(v_param, 1),0);
             
             v_i = 4; --iniciamos dsde la posicion 4 que es porterioa  :  id, fecha, hora,.... 
	       
            raise notice '>>>>>>         WHILE' ;
            WHILE  v_i <= v_tamano LOOP
          
        
        
                v_param_det= string_to_array(v_param[v_i],'#');
              raise notice '111111111' ;
                v_medicion:=trim(pxp.f_get_parametro(p_tabla,v_param_det[1]));
                raise notice '22222' ;
                v_id_equipo_variable=string_to_array(v_param_det[1],'_'); --el valor del id esta en la posicion 2
                  raise notice '33333333' ;
                v_param_det= string_to_array(v_param[v_i+1],'#');  
                 raise notice '444444444' ;
               
                v_id_equipo_medicion:=(trim(pxp.f_get_parametro(p_tabla,v_param_det[1])))::integer;--el valor de id_quipo_medicion
                
                raise NOTICE '<<<<<<   nombre   %   medicion %  id_equipo_medicion  %      ev  %',v_param_det[1],v_medicion,v_id_equipo_medicion,v_id_equipo_variable[2];
                
                
                 --define si insertamos o modificammos
                IF(v_id_equipo_medicion is NULL) THEN
                --insertamos
                
                 v_consulta=v_consulta_inser||v_id_equipo_variable[2]||','''||coalesce(v_medicion,'NULL')||''')';
                  if(v_medicion !='') then
                        --ejecutamos la consulta
                       raise notice '%',v_consulta;
                       execute(v_consulta);
                   end if;
                
                ELSE
                --modificamos
                  
                  v_consulta = v_consulta_modificacion || 'medicion = '''||coalesce(v_medicion,'NULL')||'''  WHERE id_equipo_medicion='||v_id_equipo_medicion;
                
                 --ejecutamos la consulta
                  if(v_medicion !='') then
                     raise notice '%',v_consulta;
                     execute(v_consulta);
                  else
                  --si el valor esta vacio eliminamos la medicion
                   v_consulta = 'delete from gem.tequipo_medicion  WHERE id_equipo_medicion='||v_id_equipo_medicion;
                   execute(v_consulta);
                  
                  end if;
                
              
              
               END IF;
                
             
                
                   
                --se prepara para siguiente vuelta
                  v_i = v_i + 2;
                  
            END LOOP;
            
          	--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','inserciones realizadas a la interfaz'); 
         

            --Devuelve la respuesta
            return v_resp;

		end;     
	 /*********************************    
 	#TRANSACCION:  'GEM_EQUMEDDIN_ELI'
 	#DESCRIPCION:	Eliminacion de mediciones desde la interfaz equipo medicion dinamico
 	#AUTOR:		rac	
 	#FECHA:		16-03-2012 17:06:17
	***********************************/

	elseif(p_transaccion='GEM_EQUMEDDIN_ELI')then
					
        begin
        
             
             
              v_consulta = 'delete from gem.tequipo_medicion where id_equipo_medicion in ('||v_parametros.keys||')';     
        
              execute (v_consulta);
          	
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','eliminaciones  realizadas a la tabla equipo_medicion'); 
         

            --Devuelve la respuesta
            return v_resp;

		end;  
    
    else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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