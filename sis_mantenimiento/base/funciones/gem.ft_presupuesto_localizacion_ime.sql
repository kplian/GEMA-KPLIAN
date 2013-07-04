CREATE OR REPLACE FUNCTION "gem"."ft_presupuesto_localizacion_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.ft_presupuesto_localizacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tpresupuesto_localizacion'
 AUTOR: 		 (admin)
 FECHA:	        02-07-2013 00:18:34
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
	v_id_presupuesto_localizacion	integer;
	v_rec					record;
	v_estado_reg			varchar;
			    
BEGIN

    v_nombre_funcion = 'gem.ft_presupuesto_localizacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_GPRELO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-07-2013 00:18:34
	***********************************/

	if(p_transaccion='GM_GPRELO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tpresupuesto_localizacion(
			id_presupuesto,
			id_localizacion,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_presupuesto,
			v_parametros.id_localizacion,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_presupuesto_localizacion into v_id_presupuesto_localizacion;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización almacenado(a) con exito (id_presupuesto_localizacion'||v_id_presupuesto_localizacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_localizacion',v_id_presupuesto_localizacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_GPRELO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-07-2013 00:18:34
	***********************************/

	elsif(p_transaccion='GM_GPRELO_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tpresupuesto_localizacion set
			id_presupuesto = v_parametros.id_presupuesto,
			id_localizacion = v_parametros.id_localizacion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_presupuesto_localizacion=v_parametros.id_presupuesto_localizacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_localizacion',v_parametros.id_presupuesto_localizacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_GPRELO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-07-2013 00:18:34
	***********************************/

	elsif(p_transaccion='GM_GPRELO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tpresupuesto_localizacion
            where id_presupuesto_localizacion=v_parametros.id_presupuesto_localizacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Localización eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto_localizacion',v_parametros.id_presupuesto_localizacion::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'GM_GPRELO_HAB'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:			rcm	
 	#FECHA:			01/07/2013
	***********************************/

	elsif(p_transaccion='GM_GPRELO_HAB')then
					
        begin
        
        	--Verificación de existencia del presupuesto
        	if not exists(select 1
			        	from gem.tpresupuesto
			        	where id_presupuesto = v_parametros.id_presupuesto) then
				raise exception 'Presupuesto no existente';
        	end if;
        
        	--Obtención de datos del presupuesto
        	select estado_reg
        	into v_estado_reg
        	from gem.tpresupuesto
        	where id_presupuesto = v_parametros.id_presupuesto;
        	
        	if v_estado_reg = v_parametros.estado_reg then
        		raise exception 'El presupuesto ya fue habilitado para %',coalesce(v_estado_reg,'S/E');
        	end if;
        	
        	if not exists(select 1 from gem.tpresupuesto_localizacion
        				where id_presupuesto = v_parametros.id_presupuesto) then
        		raise exception 'Para habilitar el Presupuesto, previamente defina las Localizaciones que presupuestaran';
        	end if;
        	
        	if v_parametros.estado_reg = 'formular' then
        	
	        	--Genera el registro de todas las localizaciones para todos los meses de la gestion del presupuesto
	        	for v_rec in (select id_localizacion
	        				from gem.tpresupuesto_localizacion
	        				where id_presupuesto = v_parametros.id_presupuesto) loop
	        				
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'1',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'2',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'3',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'4',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'5',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'6',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'7',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'8',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'9',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'10',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'11',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        		insert into gem.tpresupuesto_loc(id_localizacion,mes,id_presupuesto,estado_reg,fecha_reg,id_usuario_reg)
	        		values(v_rec.id_localizacion,'12',v_parametros.id_presupuesto,'activo',now(),p_id_usuario);
	        				
	        	end loop;
        	
        	elsif v_parametros.estado_reg = 'ejecucion' then
        		--Por el momento no hace ninguna acción
        	else
        		raise exception 'No puede habilitarse el presupuesto, acción no reconicida';
        	end if;
        	
        	--Actualiza el presupuesto
        	update gem.tpresupuesto set
        	estado_reg = v_parametros.estado_reg
        	where id_presupuesto = v_parametros.id_presupuesto;
        	
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Habilitado para '||COALESCE(v_parametros.estado_reg,'S/E')); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_presupuesto',v_parametros.id_presupuesto::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "gem"."ft_presupuesto_localizacion_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
