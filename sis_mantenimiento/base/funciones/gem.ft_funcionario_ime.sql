CREATE OR REPLACE FUNCTION gem.ft_funcionario_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		gem.ft_funcionario_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 	    KPLIAN	
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		KPLIAN (rac)
 FECHA:		21-01-2011
 ***************************************************************************/
DECLARE

	v_parametros                record;
	v_resp                      varchar;
	v_nombre_funcion            text;
	v_mensaje_error             text;
	
	v_id_funcion  				integer;
	v_ids						varchar[];
	v_tamano					integer;
	v_i 						integer;
	v_id_funcionario			integer;
	v_id_moneda					integer;

BEGIN

     v_nombre_funcion:='orga.ft_funcionario_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
     
 /*******************************    
 #TRANSACCION:   GE_FUNCIO_INS
 #DESCRIPCION:	Inserta Funcionarios
 #AUTOR:			
 #FECHA:		25-01-2011	
***********************************/
     if(par_transaccion='GE_FUNCIO_INS')then
        
		BEGIN

          	--Verifica si esta persona ya este funcionario pero está inactivo
			if exists(select 1 from orga.tfuncionario
           			where id_persona=v_parametros.id_persona
           			and estado_reg='inactivo') then

           		--Obtiene el id funcionario
           		select id_funcionario
           		into v_id_funcionario
           		from orga.tfuncionario
           		where id_persona=v_parametros.id_persona
           		and estado_reg='inactivo';
                
           			
				update orga.tfuncionario set
				estado_reg='activo',
				codigo=v_parametros.codigo,
                id_usuario_mod=par_id_usuario,
                email_empresa=v_parametros.email_empresa,
                interno=v_parametros.interno,
                fecha_ingreso=v_parametros.fecha_ingreso,
                fecha_mod=now()::date,
                telefono_ofi = v_parametros.telefono_ofi
				where id_funcionario = v_id_funcionario;
				
				--Elimina sus especialidades y sus honorarios
				delete from orga.tfuncionario_especialidad
				where id_funcionario = v_id_funcionario;
				
				delete from gem.tfuncionario_honorario
				where id_funcionario = v_id_funcionario;
				
			
			else
					--insercion de nuevo FUNCIONARIO
	               if exists (select 1 from orga.tfuncionario
	               			where codigo=v_parametros.codigo
	               			and estado_reg='activo'
	               			and id_persona!=v_parametros.id_persona) then
	                  raise exception 'Inserción no realizada. Código de Funcionario ya utilizado.';
	               end if;
	               
	               if exists(select 1 from orga.tfuncionario
	               			where id_persona=v_parametros.id_persona
	               			and estado_reg='activo') then
	                  raise exception 'Insercion no realizada. Esta persona ya está registrada como funcionario';
	               end if;
	
	               INSERT INTO orga.tfuncionario(
			               codigo,
			               id_persona,
			               estado_reg,
			               fecha_reg,
			               id_usuario_reg,
			               email_empresa,
			               interno,
			               fecha_ingreso,
			               telefono_ofi)
	               values(
	                      v_parametros.codigo,
	                      v_parametros.id_persona, 
	                      'activo',now()::date, 
	                      par_id_usuario,
	                      v_parametros.email_empresa,
	                      v_parametros.interno,
	                      v_parametros.fecha_ingreso,
	                      v_parametros.telefono_ofi)
	               RETURNING id_funcionario into v_id_funcionario;
	               
				end if;	
	               
	             --Inserción de especialidades  
	             v_ids= string_to_array(v_parametros.id_especialidades,',');
	             v_tamano = coalesce(array_length(v_ids, 1),0);
	             
	             FOR v_i IN 1..v_tamano LOOP
	              --insertamos  registro si no esta presente como activo
	                  insert into orga.tfuncionario_especialidad(
	                  id_funcionario, id_especialidad, estado_reg, id_usuario_reg
	                  ) values(
	                  v_id_funcionario, v_ids[v_i]::integer,'activo',par_id_usuario ); 
	             
	             END LOOP;
	             
	             --Obtiene la moneda base
	             v_id_moneda = param.f_get_moneda_base();
	             
	             --Inserción de costo por horarios
	             if coalesce(v_parametros.horario1,0) > 0 then
	             	insert into gem.tfuncionario_honorario(
	             	id_funcionario, costo_hora, id_tipo_horario, estado_reg, id_usuario_reg, id_moneda
	             	) values(
	             	v_id_funcionario, v_parametros.horario1, 3, 'activo', par_id_usuario, v_id_moneda
	             	);
	             end if;
	             
	             if coalesce(v_parametros.horario2,0) > 0 then
	             	insert into gem.tfuncionario_honorario(
	             	id_funcionario, costo_hora, id_tipo_horario, estado_reg, id_usuario_reg, id_moneda
	             	) values(
	             	v_id_funcionario, v_parametros.horario2, 4, 'activo', par_id_usuario, v_id_moneda
	             	);
	             end if;
	             
	             if coalesce(v_parametros.horario3,0) > 0 then
	             	insert into gem.tfuncionario_honorario(
	             	id_funcionario, costo_hora, id_tipo_horario, estado_reg, id_usuario_reg, id_moneda
	             	) values(
	             	v_id_funcionario, v_parametros.horario3, 5, 'activo', par_id_usuario, v_id_moneda
	             	);
	             end if;
	             if coalesce(v_parametros.horario4,0) > 0 then
	              insert into gem.tfuncionario_honorario(
	              id_funcionario, costo_hora, id_tipo_horario, estado_reg, id_usuario_reg, id_moneda
	              ) values(
	              v_id_funcionario, v_parametros.horario4, 6, 'activo', par_id_usuario, v_id_moneda
	              );
	             end if;
			
			
     
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','funcionario '||v_parametros.codigo ||' insertado con exito ');
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_id_funcionario::varchar);
               
         END;
 /*******************************    
 #TRANSACCION:      RH_FUNCIO_MOD
 #DESCRIPCION:	Modifica la parametrizacion seleccionada
 #AUTOR:			
 #FECHA:		25-01-2011
***********************************/
     elsif(par_transaccion='GE_FUNCIO_MOD')then

          
          BEGIN
        
          
                if exists (select 1 from orga.tfuncionario
                			where id_funcionario!=v_parametros.id_funcionario
                			and codigo=v_parametros.codigo
                			and estado_reg='activo') then
                  raise exception 'Modificacion no realizada. CODIGO EN USO';
                end if;
                
                if exists(select 1 from orga.tfuncionario
                			where id_funcionario!=v_parametros.id_funcionario
                			and id_persona=v_parametros.id_persona and estado_reg='activo') then
                  raise exception 'Insercion no realizada. Esta persona ya está registrada como funcionario';
               end if;
                
                update orga.tfuncionario set
                	codigo=v_parametros.codigo,
                    id_usuario_mod=par_id_usuario,
                    id_persona=v_parametros.id_persona,
                    estado_reg=v_parametros.estado_reg,
                    email_empresa=v_parametros.email_empresa,
                    interno=v_parametros.interno,
                    fecha_ingreso=v_parametros.fecha_ingreso,
                    fecha_mod=now()::date,
                    telefono_ofi = v_parametros.telefono_ofi
                where id_funcionario=v_parametros.id_funcionario;
                
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcionario modificado con exito '||v_parametros.id_funcionario);
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_parametros.id_funcionario::varchar);
               
                
          END;
          
/*******************************    
 #TRANSACCION:  RH_FUNCIO_ELI
 #DESCRIPCION:	Inactiva la parametrizacion selecionada
 #AUTOR:			
 #FECHA:		25-01-2011
***********************************/

    elsif(par_transaccion='GE_FUNCIO_ELI')then
        BEGIN
        
         --inactivacion de la periodo
               update orga.tfuncionario
               set estado_reg='inactivo'
               where id_funcionario=v_parametros.id_funcionario;
               return 'Funcionario eliminado con exito';
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcionario eliminado con exito '||v_parametros.id_funcionario);
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_parametros.id_funcionario::varchar);

        END;
        
   
    else

         raise exception 'No existe la transaccion: %',par_transaccion;
    end if;
    
 return v_resp;  

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