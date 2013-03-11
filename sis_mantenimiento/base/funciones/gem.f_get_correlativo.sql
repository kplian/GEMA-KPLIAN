CREATE OR REPLACE FUNCTION gem.f_get_correlativo (
  p_id_uni_cons integer,
  p_cod_formulario varchar,
  p_fecha date
)
RETURNS varchar AS
$body$
DECLARE

	v_rec record;
    v_ids_loc			varchar;
    v_id_localizacion integer;
    v_gestion integer;
    v_sw boolean;
    v_id_localizacion_correl integer;
    v_correl integer;
    v_sql varchar;
    v_codigo varchar;

BEGIN

	--Inicializa variables
    v_sw = false;
    v_id_localizacion_correl=-1;

	--Se obtiene datos de la Unidad Constructiva
    select 
    id_localizacion
    into v_id_localizacion
    from gem.tuni_cons
    where id_uni_cons = p_id_uni_cons;
    
    --Se obtiene la gestión de la fecha enviada
    v_gestion = to_char(p_fecha,'yyyy')::integer;

	--Se obtiene los ids de los padres de la localizacion del uni_cons
	WITH RECURSIVE t(id,id_fk,nombre,n) AS (
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre,1
					FROM gem.tlocalizacion l 
					WHERE l.id_localizacion = v_id_localizacion
					UNION ALL
					SELECT l.id_localizacion,l.id_localizacion_fk, l.nombre , n+1
					FROM gem.tlocalizacion l, t
					WHERE l.id_localizacion = t.id_fk
				)
    SELECT pxp.list(id::text)
    into v_ids_loc
    FROM t;
    
    --Se ubica la localizacion que contenga la numeracion del formulario requerido
    v_sql = 'select *
		    from gem.tlocalizacion loc
		    where loc.id_localizacion in ('||v_ids_loc||')
            and loc.tipo_numeracion ilike ''%'||p_cod_formulario||'%''
            order by loc.id_localizacion desc limit 1';
    raise notice '%',v_sql;        
	for v_rec in execute(v_sql) loop
    	v_sw = true;
        v_id_localizacion = v_rec.id_localizacion;
		v_codigo = v_rec.codigo;
	end loop;
            
    --Se verifica si existe el registro, e.o.c se crea el registro
    if not v_sw then
		raise exception 'No es posible obtener el número de correlativo: no se encuentra marcada ninguna localización para este formulario en el árbol de localizaciones del Equipo recibido';
	else
    	select
        id_localizacion_correl
        into v_id_localizacion_correl
        from gem.tlocalizacion_correl 
        where id_localizacion = v_id_localizacion
        and gestion = v_gestion
        and codigo_formulario = p_cod_formulario;

    	if v_id_localizacion_correl is null then
        	--Crea el registro
            insert into gem.tlocalizacion_correl(
            gestion, correl, codigo_formulario, id_localizacion
            ) values(
            v_gestion, 0, p_cod_formulario, v_id_localizacion
            ) RETURNING id_localizacion_correl into v_id_localizacion_correl;
        end if;
        	
    end if;
    
    --Se obtiene el correlativo
    select correl+1
    into v_correl
    from gem.tlocalizacion_correl
    where id_localizacion_correl = v_id_localizacion_correl;
    
    --Se actualiza el correlativo
    update gem.tlocalizacion_correl set
    correl = correl + 1
    where id_localizacion_correl = v_id_localizacion_correl;
            
	return v_codigo||'-'||pxp.f_llenar_ceros(v_correl,5)||'/'||v_gestion;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;