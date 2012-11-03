/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.f_sal_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento') de salida
 AUTOR:          Gonzalo Sarmiento
 FECHA:          25-09-2012
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_movimiento    integer;

BEGIN

    v_nombre_funcion = 'alm.f_sal_ime';
    v_parametros = f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'SAL_SAL_INS'
     #DESCRIPCION:  Insercion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        25-09-2012
    ***********************************/

    if(p_transaccion='SAL_SAL_INS')then

        begin
            --Sentencia de la insercion--
            insert into alm.tmovimiento(
            id_movimiento_tipo,
            fecha_mov,
            numero_mov,
            descripcion,
            observaciones
              ) values(
              2,
            v_parametros.fecha_mov,
            v_parametros.numero_mov,
            v_parametros.descripcion,
            v_parametros.observaciones
            )RETURNING id_movimiento into v_id_movimiento;

            --Definicion de la respuesta--
            v_resp = f_agrega_clave(v_resp,'mensaje','Movimiento almacenado(a) con exito (id_movimiento'||v_id_movimiento||')');
            v_resp = f_agrega_clave(v_resp,'id_movimiento',v_id_movimiento::varchar);

            --Devuelve la respuesta--
            return v_resp;

        end;

    /*********************************
     #TRANSACCION:  'SAL_SAL_MOD'
     #DESCRIPCION:  Modificacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        25-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_SAL_MOD')then

        begin
            --Sentencia de la modificacion--
            update alm.tmovimiento set
            fecha_mov = v_parametros.fecha_mov,
            numero_mov = v_parametros.numero_mov,
            descripcion = v_parametros.descripcion,
            observaciones = v_parametros.observaciones
            where id_movimiento=v_parametros.id_movimiento;

            --Definicion de la respuesta--
            v_resp = f_agrega_clave(v_resp,'mensaje','Movimiento modificado(a)');
            v_resp = f_agrega_clave(v_resp,'id_movimiento',v_parametros.id_movimiento::VARCHAR);

            --Devuelve la respuesta--
            return v_resp;

        end;

    /*********************************
     #TRANSACCION:  'SAL_SAL_ELI'
     #DESCRIPCION:  Eliminacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        25-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_SAL_ELI')then

        begin
            --Sentencia de la eliminacion--
            delete from alm.tmovimiento
            where id_movimiento=v_parametros.id_movimiento;

            --Definicion de la respuesta--
            v_resp = f_agrega_clave(v_resp,'mensaje','Movimiento eliminado(a)');
            v_resp = f_agrega_clave(v_resp,'id_movimiento',v_parametros.id_movimiento::varchar);

            --Devuelve la respuesta--
            return v_resp;

        end;

    else

        raise exception 'Transaccion inexistente: %',p_transaccion;

    end if;

EXCEPTION

    WHEN OTHERS THEN
        v_resp='';
        v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
        v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
        raise exception '%',v_resp;

END;