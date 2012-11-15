CREATE OR REPLACE FUNCTION alm.f_get_num_mov (
  v_id_almacen integer,
  v_id_movimiento_tipo integer,
  v_fecha_mov timestamp
)
RETURNS varchar AS
$body$
DECLARE
  v_numero_mov 	varchar;
  v_correl_sig	INTEGER;
  v_periodo		varchar;
BEGIN
	--v_parametros=pxp.f_get_record(p_tabla);
    select (extract(month from v_fecha_mov)||'/'||(extract(year from v_fecha_mov)))::varchar into v_periodo;
    raise NOTICE '%''%''%',v_periodo,v_id_almacen,v_id_movimiento_tipo;
    if(alm.f_verificar_registro(v_id_almacen,v_id_movimiento_tipo,v_periodo)IS TRUE) then
    	raise NOTICE '%','existe';
        v_correl_sig = alm.f_get_correlativo(v_id_almacen,v_id_movimiento_tipo,v_periodo);
        raise NOTICE '%',v_correl_sig;        
  	else
    	INSERT INTO alm.talmacen_correlativo(id_almacen,id_movimiento_tipo,periodo)
        VALUES(v_id_almacen,v_id_movimiento_tipo,v_periodo);
    	v_correl_sig=1;
        raise NOTICE '%','no existe';
    end if;
    	UPDATE alm.talmacen_correlativo almcor SET
		correl_act=correl_sig,
		correl_sig=correl_sig+1
		where almcor.id_almacen=v_id_almacen
        and almcor.id_movimiento_tipo=v_id_movimiento_tipo
        and almcor.periodo=v_periodo;
        raise notice '%', 'actualizo';
        
        select substring(movtip.codigo,1,1)||'.'||al.codigo||'.'||
		extract(month from v_fecha_mov)||'000'||v_correl_sig||'/'||
		extract(year from v_fecha_mov)-2000 into v_numero_mov
		from alm.talmacen_correlativo almcor
		inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo=almcor.id_movimiento_tipo
        inner join alm.talmacen al on al.id_almacen=almcor.id_almacen
        where almcor.id_almacen=v_id_almacen
        and almcor.id_movimiento_tipo=v_id_movimiento_tipo
        and almcor.periodo=v_periodo;
		raise notice '%', v_numero_mov;
        return v_numero_mov;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  raise EXCEPTION 'ocurrio una excepcion';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;