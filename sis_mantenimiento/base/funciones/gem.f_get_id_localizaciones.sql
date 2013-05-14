CREATE OR REPLACE FUNCTION gem.f_get_id_localizaciones (
  p_id_localizacion integer,
  p_padres_hijos varchar = 'hijos'::character varying
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 11/03/2013
*/
DECLARE

  v_ids varchar;

BEGIN

  if p_id_localizacion is null then
      return '(null)';
    end if;

  if p_padres_hijos = 'padres' then
        WITH RECURSIVE t(id,id_fk,nombre,n) AS (
              SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
              FROM gem.tlocalizacion l
              WHERE l.id_localizacion = p_id_localizacion
              UNION ALL
              SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,n+1
              FROM gem.tlocalizacion l, t
              WHERE l.id_localizacion = t.id_fk
          )
          SELECT (pxp.list(id::text))::varchar
          INTO v_ids
          FROM t;
          
              --raise exception 'fashion: % %',v_ids,p_id_localizacion;
    
    else
      WITH RECURSIVE t(id,id_fk,nombre,n) AS (
            SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
            FROM gem.tlocalizacion l
            WHERE l.id_localizacion = p_id_localizacion
            UNION ALL
            SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,n+1
            FROM gem.tlocalizacion l, t
            WHERE l.id_localizacion_fk = t.id
        )
        SELECT (pxp.list(id::text))::varchar
        INTO v_ids
        FROM t;
    
    end if;
    
    return v_ids;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;