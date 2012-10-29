CREATE OR REPLACE FUNCTION alm.ft_ingreso_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_ingreso_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento' para ingresos
 AUTOR:          Gonzalo Sarmiento
 FECHA:          24-09-2012
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
               
BEGIN

    v_nombre_funcion = 'alm.ft_ingreso_sel';
    v_parametros = f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_ING_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        24-09-2012
    ***********************************/

    if(p_transaccion='SAL_ING_SEL')then
                  
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        mov.id_movimiento,
                        mov.id_movimiento_tipo,
                        mov.fecha_mov,
                        mov.numero_mov,
                        mov.descripcion,                       
                        mov.observaciones                     
                        from alm.tmovimiento mov
                        where mov.id_movimiento_tipo=1 and ';

            --Definicion de la respuesta--
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--raise exception '%',v_consulta;
            --Devuelve la respuesta--
            return v_consulta;
            
                       
        end;

    /*********************************   
     #TRANSACCION:  'SAL_ING_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        24-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ING_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros--
            v_consulta:='select count(mov.id_movimiento)
                        from alm.tmovimiento mov
                        where ';
           
            --Definicion de la respuesta--           
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;
                   
    else
                        
        raise exception 'Transaccion inexistente';
                            
    end if;
                   
EXCEPTION
                   
    WHEN OTHERS THEN
            v_resp='';
            v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
            v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
            v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
            raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;