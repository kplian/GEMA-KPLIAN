CREATE OR REPLACE FUNCTION gem.f_get_mediciones_equipo (
  p_id_uni_cons integer,
  p_fecha_desde date,
  p_fecha_hasta date,
  p_variable varchar
)
RETURNS numeric AS
$body$
/*
	Autor: RCM
    Proposito: Devolver el total de mediciones por equipo y por variable en un rango definido de fechas
*/

DECLARE

	v_total numeric;

BEGIN

  	select
    sum(emed.medicion)
    into v_total
    from gem.tequipo_medicion emed
    inner join gem.tequipo_variable evar
    on evar.id_equipo_variable = emed.id_equipo_variable
    inner join gem.ttipo_variable tvar
    on tvar.id_tipo_variable = evar.id_tipo_variable
    where evar.id_uni_cons = p_id_uni_cons
    and tvar.nombre = p_variable
    and emed.fecha_medicion between p_fecha_desde and p_fecha_hasta;
    
    return coalesce(v_total,0);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;