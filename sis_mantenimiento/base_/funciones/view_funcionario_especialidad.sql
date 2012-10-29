/*
Author: RCM
Date: 24/08/2012
Script: Create a Skill Employee interface
Content:
1) Create the table rhu.tfuncionario_especialidad
2) Create function rhum.f_funcionario_especialidad_sel
3) Create function  rhum.f_funcionario_especialidad_ime
4) Add new constraint for validate no repeat the skill for a user
*/
--
--1)
--
-- Table: rhum.tfuncionario_especialidad

-- DROP TABLE rhum.tfuncionario_especialidad;

CREATE TABLE rhum.tfuncionario_especialidad
(
  id_funcionario_especialidad serial NOT NULL,
  id_funcionario integer NOT NULL,
  id_especialidad integer NOT NULL,
  CONSTRAINT tfuncionario_especialidad_pkey PRIMARY KEY (id_funcionario_especialidad),
  CONSTRAINT uq__id_funcionario_especialidad UNIQUE (id_funcionario, id_especialidad)
) INHERITS (tbase) WITH ( OIDS=TRUE);
ALTER TABLE rhum.tfuncionario_especialidad OWNER TO postgres;

--
--2)
--
-- Function: rhum.f_funcionario_especialidad_sel(integer, integer, character varying, character varying)

-- DROP FUNCTION rhum.f_funcionario_especialidad_sel(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION rhum.f_funcionario_especialidad_sel(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		rhum.f_funcionario_especialidad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'rhum.tfuncionario_especialidad'
 AUTOR: 		 (admin)
 FECHA:	        17-08-2012 17:48:38
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
			    
BEGIN

	v_nombre_funcion = 'rhum.f_funcionario_especialidad_sel';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:38
	***********************************/

	if(p_transaccion='RH_RHESFU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						rhesfu.id_funcionario_especialidad,
						rhesfu.id_funcionario,
						rhesfu.estado_reg,
						rhesfu.id_especialidad,
						rhesfu.id_usuario_reg,
						rhesfu.fecha_reg,
						rhesfu.id_usuario_mod,
						rhesfu.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						especi.nombre as desc_especialidad
						from rhum.tfuncionario_especialidad rhesfu
						inner join segu.tusuario usu1 on usu1.id_usuario = rhesfu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = rhesfu.id_usuario_mod
						inner join rhum.tespecialidad especi on especi.id_especialidad = rhesfu.id_especialidad
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:38
	***********************************/

	elsif(p_transaccion='RH_RHESFU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_funcionario_especialidad)
					    from rhum.tfuncionario_especialidad rhesfu
					    inner join segu.tusuario usu1 on usu1.id_usuario = rhesfu.id_usuario_reg
					    left join segu.tusuario usu2 on usu2.id_usuario = rhesfu.id_usuario_mod
					    inner join rhum.tespecialidad especi on especi.id_especialidad = rhesfu.id_especialidad
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
			v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION rhum.f_funcionario_especialidad_sel(integer, integer, character varying, character varying) OWNER TO postgres;

--
--3)
--
-- Function: rhum.f_funcionario_especialidad_ime(integer, integer, character varying, character varying)

-- DROP FUNCTION rhum.f_funcionario_especialidad_ime(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION rhum.f_funcionario_especialidad_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		rhum.f_funcionario_especialidad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'rhum.tfuncionario_especialidad'
 AUTOR: 		 (admin)
 FECHA:	        17-08-2012 17:48:37
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
	v_id_funcionario_especialidad	integer;
			    
BEGIN

    v_nombre_funcion = 'rhum.f_funcionario_especialidad_ime';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:37
	***********************************/

	if(p_transaccion='RH_RHESFU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into rhum.tfuncionario_especialidad(
			id_funcionario,
			estado_reg,
			id_especialidad,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_funcionario,
			'activo',
			v_parametros.id_especialidad,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_funcionario_especialidad into v_id_funcionario_especialidad;
               
			--Definicion de la respuesta
			v_resp = f_agrega_clave(v_resp,'mensaje','Especialidades Funcionarios almacenado(a) con exito (id_funcionario_especialidad'||v_id_funcionario_especialidad||')'); 
            v_resp = f_agrega_clave(v_resp,'id_funcionario_especialidad',v_id_funcionario_especialidad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:37
	***********************************/

	elsif(p_transaccion='RH_RHESFU_MOD')then

		begin
			--Sentencia de la modificacion
			update rhum.tfuncionario_especialidad set
			id_funcionario = v_parametros.id_funcionario,
			id_especialidad = v_parametros.id_especialidad,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_funcionario_especialidad=v_parametros.id_funcionario_especialidad;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Especialidades Funcionarios modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_funcionario_especialidad',v_parametros.id_funcionario_especialidad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:37
	***********************************/

	elsif(p_transaccion='RH_RHESFU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from rhum.tfuncionario_especialidad
            where id_funcionario_especialidad=v_parametros.id_funcionario_especialidad;
               
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Especialidades Funcionarios eliminado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_funcionario_especialidad',v_parametros.id_funcionario_especialidad::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION rhum.f_funcionario_especialidad_ime(integer, integer, character varying, character varying) OWNER TO postgres;


--
--4)
--
alter table rhum.tfuncionario_especialidad
add constraint uq__id_funcionario_especialidad unique (id_funcionario,id_especialidad)
