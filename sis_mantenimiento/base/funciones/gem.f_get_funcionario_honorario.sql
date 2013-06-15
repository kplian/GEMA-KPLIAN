CREATE OR REPLACE FUNCTION gem.f_get_funcionario_honorario (
  p_id_funcionario integer,
  p_codigo_horario varchar
)
RETURNS numeric AS
$body$
/*
Autor: RCM
Fecha: 15/06/2013
Propósito: Devolver la tarifa por hora de un tipo de horario del funcionario indicado
*/
DECLARE

	v_costo_hora numeric;

BEGIN

	select
    funho.costo_hora
    into
    v_costo_hora
    from gem.tfuncionario_honorario funho
    inner join orga.ttipo_horario tho
    on tho.id_tipo_horario = funho.id_tipo_horario
    where funho.id_funcionario = p_id_funcionario
    and tho.codigo = p_codigo_horario
    and tho.estado_reg = 'activo';
    
	return round(coalesce(v_costo_hora,0),2);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;