--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_uni_cons_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_uni_cons_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_uni_cons	integer;
    v_id_uni_cons_comp integer;
    
    v_estado  varchar;
    v_id_uni_cons_padre integer;
    v_tipo_nodo varchar;
    v_id_tipo_equipo integer;
    g_registros record;
    v_resp_bool boolean;
    v_id_uni_cons_base integer;
    v_bool boolean;
  
   
BEGIN

    v_nombre_funcion = 'gem.f_uni_cons_ime';
    v_parametros = pxp.f_get_record(p_tabla);
    
    /*********************************    
 	#TRANSACCION:  'GEM_TUC_INS'
 	#DESCRIPCION:	La interfaz funciona para TUC y UC
                    Insercion de Tipos de Unidades contructivas en estado borrador 
                    Inerta Unidad Contructivas
 	#AUTOR:	     	rac	
 	#FECHA:	    	09-08-2012 00:42:57
	***********************************/

	if(p_transaccion='GEM_TUC_INS')then
		     BEGIN     
             
            
            IF (pxp.f_existe_parametro(p_tabla,'nombre_tipo_equipo')) THEN
                            
             --verifie if "tipo_equipo" don't exist    
              
             if v_parametros.id_tipo_equipo is null and v_parametros.nombre_tipo_equipo  != '' then
                 --search for other sames
                 select teq.id_tipo_equipo into v_id_tipo_equipo  
                 from gem.ttipo_equipo  teq 
                 where teq.nombre ilike v_parametros.nombre_tipo_equipo  
                 and teq.estado_reg='activo' limit 1 offset 0;
                 
                   if v_id_tipo_equipo is null then
                           --insert new "tipo_equipo"
                             insert into gem.ttipo_equipo(
                            estado_reg,
                            nombre,
                            descripcion,
                            codigo,
                            id_usuario_reg,
                            fecha_reg                   
                            ) values(
                            'activo',
                            upper(v_parametros.nombre_tipo_equipo),
                            '',
                            'reg indirecto',
                            p_id_usuario,
                            now()                   
                            )RETURNING id_tipo_equipo into v_id_tipo_equipo;  
                     
                      end if;
                  else
                       v_id_tipo_equipo = v_parametros.id_tipo_equipo;                   
                  end IF;
             else
                v_id_tipo_equipo = v_parametros.id_tipo_equipo;                   
             END IF;
               -- verificar duplicidad de codigo de uo
               if exists (
                   select distinct 1 
                   from gem.tuni_cons uc 
                   where lower(uc.codigo)=lower(v_parametros.codigo) and uc.estado_reg='activo') then
                   
                   raise exception 'CODIGO DUPLICADO';
                end if;
                
                if(v_parametros.tipo = 'tuc') then
                
                  v_estado = 'borrador';  --falta validar
                 else
                  v_estado = 'registrado';  -- falta confirma el proceso de alta ,si ya no necesita modificaciones
                
                end if;
                
                --verifica el tipo_nodo
                 if(v_parametros.id_uni_cons_padre='id') then
                   v_tipo_nodo='base';--carpetas agrupadores
                   v_id_uni_cons_padre=NULL;
                 
                 else
                 
                    --revismos el padre si es base entoces el nodo sera tipo raiz
                      v_id_uni_cons_padre = (v_parametros.id_uni_cons_padre)::integer;
                      select  uc.tipo_nodo into v_tipo_nodo from gem.tuni_cons uc where uc.id_uni_cons=v_id_uni_cons_padre;
                      
                      if v_tipo_nodo = 'base' then
                          v_tipo_nodo = 'raiz';
                      else
                          v_tipo_nodo = 'rama';
                      end if;
                end if;
               
               --registra primera unidad
               
                --Sentencia de la insercion
                insert into gem.tuni_cons(
                estado_reg,
                estado,
                nombre,
                tipo,
                codigo,
                id_tipo_equipo,
               -- id_localizacion,
                id_usuario_reg,
                fecha_reg,
                fecha_mod,
                id_usuario_mod,
                tipo_nodo
                ) values(
                'activo',
                v_estado,
                upper(v_parametros.nombre),
                v_parametros.tipo,
                upper(v_parametros.codigo),
                v_id_tipo_equipo,
               -- v_parametros.id_localizacion,
                p_id_usuario,
                now(),
                null,
                null,
                v_tipo_nodo
                )RETURNING id_uni_cons into v_id_uni_cons;
                
                
               
               
               -- si no es un nodo base registramo la relacion con el padre
               
               if(v_tipo_nodo != 'base')then
               
                     insert into gem.tuni_cons_comp(
                        estado_reg,
                        opcional,
                        id_uni_cons_padre,
                        cantidad,
                        id_uni_cons_hijo,
                        id_usuario_reg,
                        fecha_reg,
                        id_usuario_mod,
                        fecha_mod
                        ) values(
                        'activo',
                        'no',
                        v_id_uni_cons_padre,
                        '1',
                        v_id_uni_cons,
                        p_id_usuario,
                        now(),
                        null,
                        null
                        )RETURNING id_uni_cons_comp into v_id_uni_cons_comp;
               
               
               end if;
               
               
               
          
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Equipos almacenado(a) con exito (id_uni_cons'||v_id_uni_cons||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons',v_id_uni_cons::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TUC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	elsif(p_transaccion='GEM_TUC_MOD')then

		begin
             
            IF (pxp.f_existe_parametro(p_tabla,'nombre_tipo_equipo')) THEN
                            
             --verifie if "tipo_equipo" don't exist    
              
             if v_parametros.id_tipo_equipo is null and v_parametros.nombre_tipo_equipo  != '' then
                 --search for other sames
                 select teq.id_tipo_equipo into v_id_tipo_equipo  
                 from gem.ttipo_equipo  teq 
                 where teq.nombre ilike v_parametros.nombre_tipo_equipo  
                 and teq.estado_reg='activo' limit 1 offset 0;
                 
                   if v_id_tipo_equipo is null then
                           --insert new "tipo_equipo"
                             insert into gem.ttipo_equipo(
                            estado_reg,
                            nombre,
                            descripcion,
                            codigo,
                            id_usuario_reg,
                            fecha_reg                   
                            ) values(
                            'activo',
                            upper(v_parametros.nombre_tipo_equipo),
                            '',
                            'reg indirecto',
                            p_id_usuario,
                            now()                   
                            )RETURNING id_tipo_equipo into v_id_tipo_equipo;  
                     
                      end if;
                  else
                       v_id_tipo_equipo = v_parametros.id_tipo_equipo;                   
                  end IF;
             else
                v_id_tipo_equipo = v_parametros.id_tipo_equipo;                   
             END IF;
        
         -- verificar duplicidad de codigo de uo
               if exists (
                   select distinct 1 
                   from gem.tuni_cons uc 
                   where lower(uc.codigo)=lower(v_parametros.codigo) 
                   and uc.estado_reg='activo' and uc.id_uni_cons!=v_parametros.id_uni_cons) then
                   raise exception 'CODIGO DUPLICADO';
                end if;
        
			--Sentencia de la modificacion
			update    gem.tuni_cons set
			nombre = upper(v_parametros.nombre),
			codigo = upper(v_parametros.codigo),
			id_tipo_equipo = v_id_tipo_equipo,
			--id_localizacion = v_parametros.id_localizacion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_uni_cons=v_parametros.id_uni_cons;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Equipos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons',v_parametros.id_uni_cons::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
        
    /*********************************    
 	#TRANSACCION:  'GEM_TUCESTBL_MOD'
 	#DESCRIPCION:	Bloquea y Desbloquea, solo se utiliza para el tuc tipo raiz
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	elsif(p_transaccion='GEM_TUCESTBL_MOD')then

		begin
            -- get node data
        
            select uc.estado, uc.tipo_nodo 
              into v_estado ,v_tipo_nodo 
            from gem.tuni_cons uc where uc.id_uni_cons = v_parametros.id_uni_cons ;
           
            --then, check the node type root
            if v_tipo_nodo!='raiz' then
            
                raise exception 'solo los nodo raiz pueden ser bloqueados';
            
            end if;
            
            --then check the current status,  aprobrado for block or borrador for aunblock
            
            if v_estado  = v_parametros.estado then
             raise exception 'El equipo ya se encuentra en estado %',v_estado;
            
            end if;
          
			--Sentencia de la modificacion
			update    gem.tuni_cons set
			estado = v_parametros.estado,			
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_uni_cons=v_parametros.id_uni_cons;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Equipos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons',v_parametros.id_uni_cons::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
        
              
    /*********************************    
 	#TRANSACCION:  'GEM_ADDUC_MOD'
 	#DESCRIPCION:	Generate unicons fron template tipo_cuni_cons
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/
    
     elseif(p_transaccion='GEM_ADDUC_MOD')then
		     BEGIN   
             
             
            
             /*
             1) busca los datos del primer nodo raiz
             2)  los inserta con UC
             3) busca recursivamente hijos pxp.f_addunicon_recursivo
             */
             
             
             
             --el codigo tiene que ser unico para la UC
             
             
             IF exists( select 1 from  gem.tuni_cons  uc 
                      where uc.codigo = upper(v_parametros.codigo_uni_cons )) THEN
              raise exception 'El codigo de equipo ya existe';
             END IF;
              
             
             --0) revisa si el lugar ya tiene un nodo creado desde el campo id_plantilla
             
             select tuc.id_uni_cons  into v_id_uni_cons_base 
             from gem.tuni_cons  tuc 
             where tuc.id_localizacion = v_parametros.id_localizacion  
             and tuc.estado_reg='activo' 
             and tuc.tipo_nodo = 'base';
             
             
             if  v_id_uni_cons_base is null then
             
               -- insertamos nodo base
                --Sentencia de la insercion
                        insert into gem.tuni_cons(
                        estado_reg,
                        estado,
                        nombre,
                        tipo,
                        codigo,
                        id_usuario_reg,
                        fecha_reg,
                        id_localizacion,
                        tipo_nodo
                        ) values(
                        'activo',
                       'registrado',
                        upper(v_parametros.nombre),
                        'uc',
                        upper(v_parametros.codigo_localizacion),
                        p_id_usuario,
                        now(),
                        v_parametros.id_localizacion,
                        'base'
                        )RETURNING id_uni_cons into v_id_uni_cons_base;
             
              end if;
             
             
             
             
             -- 1) busca los datos del primer nodo raiz
             
             FOR g_registros in  (select  tuc.codigo,tuc.estado,tuc.id_tipo_equipo,tuc.nombre,tuc.tipo_nodo , tuc.id_uni_cons
                                  from gem.tuni_cons tuc 
                                    where   tuc.id_uni_cons =  v_parametros.id_uni_cons  
                                    and tuc.estado_reg='activo') LOOP
                
                
                
                -- 2)  los inserta como UC
                      
                       --Sentencia de la insercion
                        insert into gem.tuni_cons(
                        estado_reg,
                        estado,
                        nombre,
                        tipo,
                        codigo,
                        id_tipo_equipo,
                                        
                        id_usuario_reg,
                        fecha_reg,
                        id_localizacion,
                         tipo_nodo,
                         id_plantilla
                        ) values(
                        'activo',
                       'registrado',
                        upper(g_registros.nombre),
                        'uc',
                        upper(v_parametros.codigo_uni_cons),
                        g_registros.id_tipo_equipo,
                        p_id_usuario,
                        now(),
                        v_parametros.id_localizacion,
                        'raiz',
                         v_parametros.id_uni_cons
                        
                        )RETURNING id_uni_cons into v_id_uni_cons;
                        
                        
                     --insertamos la relacion con el nodo relacionador
                     
                      --inseta la relacion con el padre    
                    
                
                
            insert into gem.tuni_cons_comp(
                        estado_reg,
                        opcional,
                        id_uni_cons_padre,
                        cantidad,
                        id_uni_cons_hijo,
                        id_usuario_reg,
                        fecha_reg,
                        id_usuario_mod,
                        fecha_mod
                        ) values(
                        'activo',
                        'no',
                        v_id_uni_cons_base,  --padre
                        '1',
                        v_id_uni_cons,--hijo
                        p_id_usuario,
                        now(),
                        null,
                        null
                        )RETURNING id_uni_cons_comp into v_id_uni_cons_comp;    
           
                        
      END LOOP;
            -- 3) busca recursivamente hijos pxp.f_addunicon_recursivo
      
             v_resp_bool = gem.f_addunicon_recursivo(v_parametros.id_uni_cons,v_id_uni_cons,p_id_usuario);
             
         
          
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Dulicado desde plantilla  el uni_con  (id_uni_cons'||v_id_uni_cons||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons',v_id_uni_cons::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;   
        




 /*********************************    
 	#TRANSACCION:  'GEM_GENCAL_MOD'
 	#DESCRIPCION:	Genera calendario para los quipos seleccionados
 	#AUTOR:		rac	KPLIAN
 	#FECHA:		09-08-2012 00:42:57
	***********************************/
    
     elseif(p_transaccion='GEM_GENCAL_MOD')then
		     BEGIN   
             
             
             --si es el nodo es de tipo localizacion
             
             if v_parametros.tipo_nodo <> 'uni_cons' THEN
             
                   -- 1)  busca recursivamente los equipos que correponden a la localizacion indicada
                       
                    FOR g_registros in  (
                     WITH RECURSIVE sub_localizacion(id_localizacion, id_localizacion_fk, nombre) 
                          AS (
                              SELECT id_localizacion, id_localizacion_fk, nombre 
                              FROM gem.tlocalizacion WHERE id_localizacion =  v_parametros.id_localizacion
                                UNION ALL
                              SELECT l.id_localizacion, l.id_localizacion_fk, l.nombre
                              FROM sub_localizacion subl, gem.tlocalizacion l
                              WHERE l.id_localizacion_fk = subl.id_localizacion
                             )
                          SELECT unicon.id_uni_cons FROM gem.tuni_cons unicon 
                          WHERE unicon.id_localizacion 
                          IN ( SELECT id_localizacion FROM sub_localizacion ORDER BY id_localizacion) 
                          AND unicon.tipo_nodo ilike 'raiz' and unicon.tipo = 'uc') LOOP
                   
                  
                   
                   -- 2) for llama a una funcion para generar el calendaio para el equipo indicado
                   
                    v_bool =  gem.f_genera_calendario_equipo (g_registros.id_uni_cons,v_parametros.fecha_ini,v_parametros.fecha_fin,p_id_usuario);
                      IF NOT v_bool THEN
                       raise exception 'error al generar calendario para %',g_registros.id_uni_cons;
                      END IF;
                   
                   END LOOP;
             
             ELSE
              --si no es localizacion es la unidad constructiva, generamos directamente
             
              v_bool =  gem.f_genera_calendario_equipo (v_parametros.id_localizacion,v_parametros.fecha_ini,v_parametros.fecha_fin,p_id_usuario);
                   
             
             END IF;
             
             
             
             -- 3) retonra exito
             
             
            

             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Generando el calendario para la localizacion : '|| v_parametros.id_localizacion ); 
             
             return v_resp;
     

            END;

	/*********************************    
 	#TRANSACCION:  'GEM_TUC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	elsif(p_transaccion='GEM_TUC_ELI')then

		begin
        
           --0)  verifica el estado solo puede eliminar cuando el estado es borrador
           if exists ( select DISTINCT 1 
                          from gem.tuni_cons uc
                          where uc.estado != 'borrador' 
                          and   uc.id_uni_cons = v_parametros.id_uni_cons) then
               
                             
                        raise exception 'Eliminacion no realizada. El elemento que quiere eliminar no se encuentra en estado borrador';
              
              end if;
           
               
        
        
            --1) verificamos si tiene relaciones activas con sus hijos (asumimos que si tiene hijos tendra relaciones activas con ellos)
            
            if exists ( select DISTINCT 1 
                          from gem.tuni_cons uc
                          inner join  gem.tuni_cons_comp ucc  on uc.id_uni_cons = ucc.id_uni_cons_padre   and ucc.estado_reg='activo' 
                          where uc.id_uni_cons = v_parametros.id_uni_cons) then
               
                        --NOTA) sera necesario adicionar  una trsaccion que realize una eliminacion recursiva
                        --      previa confirmacion del usuario despues de este error 
                             
                        raise exception 'Eliminacion no realizada. El elemento que quiere eliminar tienes subpartes anidadas';
              
              end if;
              
                             
               --2) inactiva la unidad
               update gem.tuni_cons 
               set estado_reg='inactivo'
               where id_uni_cons= v_parametros.id_uni_cons;
               
               
               -- 3) inactiva las relaciones con los padres (para que se cumpla siempre la regla en 1)
               update gem.tuni_cons_comp
               set estado_reg='inactivo'
               where id_uni_cons_hijo=v_parametros.id_uni_cons;
              
  
		               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Equipos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons',v_parametros.id_uni_cons::varchar);
              
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