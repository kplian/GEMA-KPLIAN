CREATE OR REPLACE FUNCTION gem.f_verifica_parametro (
  p_parametro varchar,
  p_valor varchar
)
RETURNS boolean AS
$body$
/*
Autor: RCM
Fecha: 29/04/2013
Dscripción: Verifica si se cumple alguna condición de un parámetro
*/
DECLARE

	v_valor varchar;
    v_resp boolean;

BEGIN

	select
    valor
    into
    v_valor
    from gem.tparametro
    where tipo_proceso = p_parametro;
    
    if v_valor is not null then
    	v_resp = true;
    end if;
    
    return v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;