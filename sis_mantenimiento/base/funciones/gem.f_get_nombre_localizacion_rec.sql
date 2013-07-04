CREATE OR REPLACE FUNCTION gem.f_get_nombre_localizacion_rec (
  p_id_localizacion integer,
  p_padres_hijos varchar = 'hijos'::character varying
)
RETURNS varchar AS
$body$
DECLARE

	v_ids varchar;
    v_rec record;
    v_loc varchar;

BEGIN

	--Obtencion de los IDS
    v_ids = gem.f_get_id_localizaciones(p_id_localizacion,p_padres_hijos);
    v_loc='';
    
    for v_rec in execute('select *
    					from gem.tlocalizacion
                        where id_localizacion in ('||v_ids||')
                        order by id_localizacion') loop
    	v_loc = v_loc || '::'|| coalesce(v_rec.nombre,'S/N');
    
    end loop;
    
    return v_loc;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;