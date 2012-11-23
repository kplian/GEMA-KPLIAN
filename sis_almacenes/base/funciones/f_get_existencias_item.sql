CREATE OR REPLACE FUNCTION alm.f_get_existencias_item (
  p_id_item integer
)
RETURNS NUMERIC AS
$body$
/**************************************************************************

 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO

 FUNCION: 		gem.f_get_existencias_item

 DESCRIPCION:   	Función que devuelve los la cantidad restante (saldo) existente del item con ID: p_id_item
 
 RETORNA:			Devuelve el valor de la cantidad disponible para el item: p_id_item
 					devuleve -1 cuando el saldo es negativo y null cuando el item no existe.

 AUTOR: 		 (frh)

 FECHA:	        	19/11/2012

 COMENTARIOS:	

***************************************************************************

 HISTORIAL DE MODIFICACIONES:



 DESCRIPCION:	

 AUTOR:			

 FECHA:		

***************************************************************************/



DECLARE

	v_nombre_funcion   	text;
    v_resp				varchar;
    v_item_saldo numeric;   
   	v_resultado record;
   	v_consulta  varchar;  

BEGIN

    v_nombre_funcion = 'gem.f_get_existencias_item';    
    v_item_saldo := 0;    
    
    -- Eliminacion de tabla temporal (si existe)
    DROP TABLE IF EXISTS  tt_item_saldo;
        
    /***********************************
    # Consulta para obtener la diferencia entre la sumatoria total de las cantidades 
    # ingresadas y la sumatoria total de las salidas para el item: p_id_item. 
    # Cuando el saldo es positivo devuelve la cantidad que es un valor numeric,
    # si el saldo es negativo o cero devuelve el valor -1.
    ***********************************/
    
    v_consulta = '
    WITH item_ingresos
    AS (
      SELECT movdet.id_item, array_agg(mov.id_movimiento) AS id_movimiento_ingresos, sum(cantidad) AS suma_ingresos
      FROM alm.tmovimiento_det movdet
      INNER JOIN alm.tmovimiento mov ON mov.id_movimiento = movdet.id_movimiento
      INNER JOIN alm.tmovimiento_tipo movti ON mov.id_movimiento_tipo = movti.id_movimiento_tipo
      WHERE movti.codigo ilike ''INGRESO'' and movdet.id_item ='|| p_id_item ||'
      GROUP BY id_item
      ),  	
    item_salidas 
    AS (
      SELECT movdet.id_item, array_agg(mov.id_movimiento) AS id_movimiento_salidas, sum(cantidad) AS suma_salidas
      FROM alm.tmovimiento_det movdet
      INNER JOIN alm.tmovimiento mov ON mov.id_movimiento = movdet.id_movimiento
      INNER JOIN alm.tmovimiento_tipo movti ON mov.id_movimiento_tipo = movti.id_movimiento_tipo
      WHERE movti.codigo ilike ''SALIDA'' and movdet.id_item ='|| p_id_item ||'
      GROUP BY id_item
      ),
    item_saldo
    AS (
      SELECT iin.id_item, iin.id_movimiento_ingresos, iout.id_movimiento_salidas, iin.suma_ingresos, iout.suma_salidas,
      (iin.suma_ingresos - iout.suma_salidas)::NUMERIC AS saldo
      FROM item_ingresos iin
      LEFT  JOIN item_salidas iout ON iin.id_item = iout.id_item
      )
    SELECT * INTO TEMP tt_item_saldo FROM  item_saldo';
    execute(v_consulta);
    
    SELECT saldo INTO v_item_saldo FROM tt_item_saldo;    
    
    IF v_item_saldo <= 0 THEN
    	v_item_saldo = -1;
        raise notice 'saldo, %', v_item_saldo;
    END IF;
    
    RETURN v_item_saldo;
	
    -- En caso de que se requiera retornar un record (RETURNS SETOF  record AS $$) 
    -- con la información de las cantidaddes de los ingresos y salidas ademas del saldo. 
    
    --RETURN QUERY SELECT * FROM tt_item_saldo;
    --SETOF  record
    
    
    --El SELECT para obtener los valores seria:
    /*
    	SELECT * gem.f_get_existencias_item ( 5 ) 
         f ( id_item  integer,              
             id_movimiento_ingresos integer[],
             id_movimiento_salidas integer[],
             suma_ingresos numeric,
             suma_salidas numeric,
             saldo numeric
         	);
    */				

EXCEPTION					

	WHEN OTHERS THEN

			v_resp='';

			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);

			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);

			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);

			raise exception '%',v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

