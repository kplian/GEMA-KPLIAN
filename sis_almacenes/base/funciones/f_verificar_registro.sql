CREATE OR REPLACE FUNCTION alm.f_verificar_registro (
  v_id_almacen integer,
  v_id_movimiento_tipo integer,
  v_periodo varchar
)
RETURNS boolean AS
$body$
DECLARE
	v_count integer;
BEGIN
	v_count=0;
	select count(almcor.id_almacen_correl)
    into v_count
    from alm.talmacen_correlativo almcor
    where almcor.id_almacen=v_id_almacen and 
          almcor.id_movimiento_tipo=v_id_movimiento_tipo
	      and almcor.periodo=v_periodo;
    if(v_count>0)then
    	RETURN TRUE;
    else
    	RETURN FALSE;
    end if;    
    
	
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;