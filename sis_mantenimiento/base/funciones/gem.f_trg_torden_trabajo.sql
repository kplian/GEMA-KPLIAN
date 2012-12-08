--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_trg_torden_trabajo (
)
RETURNS trigger AS
$body$
/**************************************************************************
 SISTEMA DE MANTENIMIENTO (GEM)
***************************************************************************
 AUTOR: 		AAO
 FECHA:			07-12-2012
 COMENTARIOS:	
***************************************************************************/
DECLARE
BEGIN
    IF TG_OP = 'INSERT' THEN
	BEGIN
    	insert into gem.torden_trabajo_log(
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
            id_orden_trabajo,
            estado_ini,
            estado_fin,
            fecha
          	) values(
			'activo',
			NEW.id_usuario_reg,
			now(),
			null,
			null,
            NEW.id_orden_trabajo,
            null,
            NEW.cat_estado,
            now()
        );
	END;
	ELSIF TG_OP = 'UPDATE' THEN
	BEGIN
    	IF NEW.cat_estado != OLD.cat_estado THEN
        	insert into gem.torden_trabajo_log(
                estado_reg,
                id_usuario_reg,
                fecha_reg,
                id_usuario_mod,
                fecha_mod,
                id_orden_trabajo,
                estado_ini,
                estado_fin,
                fecha
                ) values(
                'activo',
                NEW.id_usuario_mod,
                now(),
                null,
                null,
                NEW.id_orden_trabajo,
                OLD.cat_estado,
                NEW.cat_estado,
                now()
            );
        END IF;
   END;
   
   END IF;
   RETURN NULL;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;