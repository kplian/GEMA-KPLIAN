CREATE OR REPLACE FUNCTION gem.f_actualizar_calendario (
  p_id_usuario integer,
  p_id_calendario_planificado integer,
  p_nueva_fecha_ini date,
  p_recursivo varchar
)
RETURNS varchar AS
$body$
/*
	Autor: RCM
    Fecha:08-03/2013
    Propósito: Actualizar la fecha de un mantenimiento planificado y opcionalmente todos los siguientes mantenimientos
*/

DECLARE

	v_fecha_ini  				date;
	v_dif 						integer;
    v_id_uni_cons_mant_predef 	integer;
    v_estado 					varchar;
    v_tipo 						varchar;
    v_resp						varchar;

BEGIN

	--Recuperación de datos del mantenimiento planificado
	select c.fecha_ini,c.id_uni_cons_mant_predef , c.estado, c.tipo
    into v_fecha_ini,v_id_uni_cons_mant_predef, v_estado, v_tipo
	from gem.tcalendario_planificado c
	where id_calendario_planificado=p_id_calendario_planificado;      
          
	if (v_estado!='generado' and v_tipo = 'planificado') then
		raise exception 'Solo puede cambiar las fechas que no tienen asignada una Orden de Trabajo';
	end if;
          
	--verifica si desea modificar en cadena las fecha siguientes
	if p_recursivo = 'true' then
		--definimos si sumamos o restamos
        --calculo la diferencia en dias
        v_dif=   v_fecha_ini - p_nueva_fecha_ini::date; 
--      raise exception '%, %, %',v_dif, v_fecha_ini, p_nueva_fecha_ini;
        -- Modificcación en cadena todos los mantenimiento siguientes en que esten en estado planificado
        update gem.tcalendario_planificado set
        fecha_ini = fecha_ini -  CAST((v_dif)::varchar||' days' as INTERVAL),
        id_usuario_mod = p_id_usuario,
        fecha_mod = now(),
        observaciones='Fecha modificada en cadena'
        where id_uni_cons_mant_predef=v_id_uni_cons_mant_predef 
        and fecha_ini > v_fecha_ini and tipo='planificado';
        
		--Modificación la fecha pivote
		update gem.tcalendario_planificado set
        fecha_ini = p_nueva_fecha_ini,
        id_usuario_mod = p_id_usuario,
        fecha_mod = now()
        where id_calendario_planificado=p_id_calendario_planificado;
        
        raise notice '%',p_id_calendario_planificado;
            
	else
            
		--En caso de que no querer modificar en cadena
        --Sentencia de la modificacion
        update gem.tcalendario_planificado set
        fecha_ini = p_nueva_fecha_ini,
        id_usuario_mod = p_id_usuario,
        fecha_mod = now()
        where id_calendario_planificado=p_id_calendario_planificado;
               
	end if;   
    
	 
    --Devuelve la respuesta
    v_resp='Calendario actualizado';
	return v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;