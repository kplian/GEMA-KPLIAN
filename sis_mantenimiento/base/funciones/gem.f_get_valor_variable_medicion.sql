CREATE OR REPLACE FUNCTION gem.f_get_valor_variable_medicion (
  p_id_tipo_equipo integer,
  p_nombre_variable varchar,
  p_id_uni_cons integer,
  p_fecha_ini date,
  p_fecha_fin date
)
RETURNS numeric AS
$body$
DECLARE

  v_total numeric;

BEGIN

  select
    sum(coalesce(emed.medicion,0))
    into v_total
    from gem.tequipo_medicion emed
    inner join gem.tequipo_variable evar
    on evar.id_equipo_variable = emed.id_equipo_variable
    inner join gem.ttipo_variable tvar
    on tvar.id_tipo_variable = evar.id_tipo_variable
    where evar.id_uni_cons = p_id_uni_cons
    and upper(trim(tvar.nombre)) = upper(trim(p_nombre_variable))
    and emed.fecha_medicion between p_fecha_ini and p_fecha_fin;
    
    return coalesce(v_total,0);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;