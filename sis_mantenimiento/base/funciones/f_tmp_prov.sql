CREATE OR REPLACE FUNCTION gem.tmp_prov (
)
RETURNS varchar AS
$body$
DECLARE

	v_rec record;
    v_id_persona integer;
    v_id_institucion integer;
    v_aux varchar;
    a_nombres varchar[];
    v_nom varchar;
    v_pat varchar;
    v_mat varchar;
    v_tam integer;
    v_correl integer;
    v_cod varchar;

BEGIN
	--1. Recorrer todos los registros del temporal prov
    --2. Verificar si es persona o institucion, y verificar si existe el registro,sino se registra
    --en cualquier caso guardar el id_persona o id_insitucion segun corresponda
    --3. Eliminar todos los proveedores
    --4. Recorrer todos los registros del temporal prov y crar un proveedor por cada registros
    
    v_correl=1;
    for v_rec in select * from gem.prov_aux loop
    	--Obtiene el nombre
    	v_aux = v_rec.responsable;
        if coalesce(v_rec.responsable,'') = '' then
            v_aux = v_rec.razon_social;
        end if;
        --Explode del nombre
        a_nombres = regexp_split_to_array(v_aux, E'\\s+');
        v_tam = array_length(a_nombres,1);
            
        --En función del tamaño del array define el nombre serializado de la persona
        if v_tam = 2 then
            v_nom = TRIM(a_nombres[1]);
            v_pat = TRIM(a_nombres[2]);
            v_mat = null;
        elsif v_tam = 3 then
            v_nom = TRIM(a_nombres[1]);
            v_pat = TRIM(a_nombres[2]);
            v_mat = TRIM(a_nombres[3]);
        elsif v_tam = 4 then
            v_nom = TRIM(a_nombres[1]) || ' ' || TRIM(a_nombres[2]);
            v_pat = TRIM(a_nombres[3]);
            v_mat = TRIM(a_nombres[4]);
        elsif v_tam =5 then
            v_nom = TRIM(a_nombres[1]) || ' ' || TRIM(a_nombres[2]);
            v_pat = TRIM(a_nombres[3]) || ' ' || TRIM(a_nombres[4]);
            v_mat = TRIM(a_nombres[5]);
        elsif v_tam =6 then
            v_nom = TRIM(a_nombres[1]) || ' ' || TRIM(a_nombres[2]);
            v_pat = TRIM(a_nombres[3]) || ' ' || TRIM(a_nombres[4]);
            v_mat = TRIM(a_nombres[5]) || ' ' || TRIM(a_nombres[6]);
        end if;
            
    	if v_rec.tipo = 'persona natural' then
			--Verifica existencia de la persona
            if v_mat is not null then
                select id_persona
                into v_id_persona
                from segu.tpersona a
                where upper(a.nombre) = upper(v_nom)
                and upper(a.apellido_paterno) = upper(v_pat)
                and upper(a.apellido_materno) = upper(v_mat);
            else
            	select id_persona
                into v_id_persona
                from segu.tpersona a
                where upper(a.nombre) = upper(v_nom)
                and upper(a.apellido_paterno) = upper(v_pat);
            end if;
            
            if v_id_persona is null then
            	--registra la persona y guarda el id
                insert into segu.tpersona(
                id_usuario_reg, fecha_reg, estado_reg, nombre,
                apellido_paterno, apellido_materno,direccion,
                telefono1, telefono2,celular1,correo
                ) values(
                1, now(), 'activo', initcap(v_nom),
                initcap(v_pat), initcap(v_mat), v_rec.direccion,
                substr(v_rec.telefono,1,15), v_rec.fax, substr(v_rec.celular,1,15), v_rec.correo
                )RETURNING id_persona into v_id_persona;
            end if;
            
            --Actualiza la persona
            update gem.prov_aux set
            id_persona = v_id_persona
            where id = v_rec.id;

        elsif v_rec.tipo = 'persona juridica' then
        	--Verfica si tiene responsable
            if coalesce(v_rec.responsable,'') != '' then
            	--Verifica existencia de la persona
                if v_mat is not null then
                    select id_persona
                    into v_id_persona
                    from segu.tpersona a
                    where upper(a.nombre) = upper(v_nom)
                    and upper(a.apellido_paterno) = upper(v_pat)
                    and upper(a.apellido_materno) = upper(v_mat);
                else
                    select id_persona
                    into v_id_persona
                    from segu.tpersona a
                    where upper(a.nombre) = upper(v_nom)
                    and upper(a.apellido_paterno) = upper(v_pat);
                end if;
                
                if v_id_persona is null then
                    --registra la persona y guarda el id
                    insert into segu.tpersona(
                    id_usuario_reg, fecha_reg, estado_reg, nombre,
                    apellido_paterno, apellido_materno,direccion,
                    telefono1, telefono2,celular1,correo
                    ) values(
                    1, now(), 'activo', initcap(v_nom),
                    initcap(v_pat), initcap(v_mat), v_rec.direccion,
                    substr(v_rec.telefono,1,15), substr(v_rec.fax,1,15),
                    substr(v_rec.celular,1,15), substr(v_rec.correo,1,50)
                    ) RETURNING id_persona into v_id_persona;
                end if;
                
                --Actualiza la persona
                update gem.prov_aux set
                id_persona = v_id_persona
                where id = v_rec.id;
            	
            end if;
            
            --Insituciones
            select id_institucion
            into v_id_institucion
            from param.tinstitucion
            where upper(nombre) = trim(upper(v_rec.razon_social));
            
            if v_id_institucion is null then
            	v_cod = 'INS-'||pxp.f_llenar_ceros(v_correl,4);
            	--Registra la institucion
                insert into param.tinstitucion(
                id_usuario_reg, fecha_reg, estado_reg, doc_id,
                nombre, telefono1, telefono2, celular1, email1,
                codigo
                ) values(
                1, now(), 'activo', v_rec.nit,
                initcap(v_rec.razon_social), substr(v_rec.telefono,1,15),
                substr(v_rec.fax,1,15), substr(v_rec.celular,1,15),
                substr(v_rec.correo,1,50), v_cod
                ) RETURNING id_institucion into v_id_institucion;
                v_correl = v_correl + 1;
            end if;
            
            --Actualiza la institucion
            update gem.prov_aux set
            id_institucion = v_id_institucion
            where id = v_rec.id;
        end if;
        
    end loop;
    
    --Registro del proveedor
    v_correl=1;
    for v_rec in select * from gem.prov_aux loop
    	--Forma el codigo
        v_cod = 'PRO-'||pxp.f_llenar_ceros(v_correl,4);
        
        if v_rec.tipo = 'persona natural' then
        	v_rec.id_institucion = null;
        else
        	v_rec.id_persona=null;
        end if;
    
    	insert into param.tproveedor(
        id_usuario_reg, fecha_reg, estado_reg, id_institucion,
        id_persona, tipo, nit, id_lugar, codigo
        ) values(
        1, now(), 'activo', v_rec.id_institucion,
        v_rec.id_persona, v_rec.tipo, v_rec.nit, v_rec.id_lugar, v_cod
        );

        v_correl = v_correl + 1;
    end loop;
    
	return 'exito';
    
/*exception
	when others then
    	raise exception '%, %, %',SQLSTATE,SQLERRM,v_rec.id;*/


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;