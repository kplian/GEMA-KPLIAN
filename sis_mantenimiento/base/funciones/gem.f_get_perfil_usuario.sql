CREATE OR REPLACE FUNCTION gem.f_get_perfil_usuario (
  p_id_usuario integer
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 18/06/2013
Descripción: DEvuelve el perfil más alto del usuario

	Gerente: 1
    Ingeniero: 2
    Jefe: 3
    Asistente: 4
    Operador: 5
*/
DECLARE

	v_cont integer;
    v_perfil varchar;
    v_rec record;

BEGIN
	--Constante para evaluar laprioridad
    v_cont=5;
    v_perfil='Operador';
    
    --Verifica si el usuio es administrador
    if exists(select 1
    		from segu.tusuario_rol
            where id_usuario = p_id_usuario
            and id_rol =1) then
		return 'Gerente';
    end if;
    
	--Obtención del perfil
    for v_rec in (select tipo,
    				case tipo
                    	when 'Gerente' then 1
                        when 'Ingeniero' then 2
                        when 'Jefe' then 3
                        when 'Asistente' then 4
                        when 'Operador' then 5
                        else 5
                    end as prior
                  from gem.tlocalizacion_usuario
                  where id_usuario = p_id_usuario) loop
    	if v_cont > v_rec.prior then
        	v_cont = v_rec.prior;
            v_perfil = v_rec.tipo;
        end if;
    end loop;
    
    return v_perfil;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;