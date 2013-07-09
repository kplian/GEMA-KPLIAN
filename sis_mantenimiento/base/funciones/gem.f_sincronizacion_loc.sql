CREATE FUNCTION gem.f_sincronizacion_loc (
)
RETURNS varchar AS
$body$
DECLARE
 
	g_registros 	record;
    g_reg_usu_loc	record;
    v_usuarios_tmp 	integer[];

BEGIN

	for g_registros in (select l.id_localizacion 
                        from gem.tlocalizacion l 
                        where l.id_localizacion_fk is null 
                        and l.estado_reg = 'activo') loop
             
    	v_usuarios_tmp = NULL;
        
        --Listo los usuarios
        for g_reg_usu_loc in (select DISTINCT ul.id_usuario  
                              from gem.tlocalizacion_usuario ul 
                              where ul.id_localizacion = g_registros.id_localizacion 
                              and ul.estado_reg = 'activo') loop
        	v_usuarios_tmp= array_append(v_usuarios_tmp, g_reg_usu_loc.id_usuario);
		end loop;
               
        update gem.tuni_cons set
        id_usuarios = v_usuarios_tmp
        where id_localizacion =g_registros.id_localizacion 
        and tipo = 'uc'
        and tipo_nodo = 'raiz'
        and estado_reg='activo';
        
        --Llamada a la funcion recursiva
        if (select gem.f_sinc_usuarios_uni_cons(g_registros.id_localizacion,v_usuarios_tmp)) THEN
                 
        else
			raise exception 'Error al sincronizar usuarios (0)';
        end if; 
        
	end loop; 
    
    return 'Sincronización de usuarios realizada para todas las localizaciones';

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;