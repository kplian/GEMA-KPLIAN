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
 
 REVISION: RCM
 FECHA:		05/07/2013
 DESCRIPCIÓN: Se aumenta control de cambio de estados para actualizar el calendario planificado si es que lo tiene
***************************************************************************/
DECLARE

	v_id_calendario_planificacion integer;
    v_cat_estado varchar;
    v_estado	varchar;

BEGIN
	v_estado='';
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
            
            --Verifica estados para actualizar el calendario si lo tiene
            select id_calendario_planificacion, cat_estado
            into v_id_calendario_planificacion, v_cat_estado
            from gem.torden_trabajo
            where id_orden_trabajo = NEW.id_orden_trabajo;
            
            if v_id_calendario_planificacion is not null then
            	if v_cat_estado = 'Abierto' then
                	v_estado = 'abierto';
                elsif v_cat_estado = 'Cerrado' then
                	v_estado = 'cerrado';
                end if;
            end if;
            
            if v_estado !='' then
            	update gem.tcalendario_planificado set
                estado = v_estado
                where id_calendario_planificado = v_id_calendario_planificacion;
            end if;
            
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
                    fecha,
                    mensaje_estado
                    ) values(
                    'activo',
                    NEW.id_usuario_mod,
                    now(),
                    null,
                    null,
                    NEW.id_orden_trabajo,
                    OLD.cat_estado,
                    NEW.cat_estado,
                    now(),
                    NEW.mensaje_estado
                );
            END IF;
            
            --Verifica estados para actualizar el calendario si lo tiene
            select id_calendario_planificacion, cat_estado
            into v_id_calendario_planificacion, v_cat_estado
            from gem.torden_trabajo
            where id_orden_trabajo = OLD.id_orden_trabajo;
            
            if v_id_calendario_planificacion is not null then
            	if v_cat_estado = 'Abierto' then
                	v_estado = 'abierto';
                elsif v_cat_estado = 'Cerrado' then
                	v_estado = 'cerrado';
                end if;
            end if;
            
            if v_estado !='' then
            	update gem.tcalendario_planificado set
                estado = v_estado
                where id_calendario_planificado = v_id_calendario_planificacion;
            end if;
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