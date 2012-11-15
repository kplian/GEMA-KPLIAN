CREATE OR REPLACE FUNCTION alm.f_get_correlativo (
  v_id_almacen integer,
  v_id_movimiento_tipo integer,
  v_periodo varchar
)
RETURNS integer AS
$body$
DECLARE
  v_correl_sig		INTEGER;
BEGIN
  select almcor.correl_sig into v_correl_sig
  from alm.talmacen_correlativo almcor
  where almcor.id_almacen=v_id_almacen and
  almcor.id_movimiento_tipo=v_id_movimiento_tipo and
  almcor.periodo=v_periodo;
  RETURN v_correl_sig;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;