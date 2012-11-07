<?php
/**
*@package pXP
*@file    MODAlmacenStock.php
*@author  Gonzalo Sarmiento
*@date    01-10-2012
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAlmacenStock extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarAlmacenItem(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='alm.ft_almacen_stock_sel';
        $this->transaccion='SAL_ALMITEM_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->setParametro('id_almacen','id_almacen','integer');   
        
        $this->captura('id_almacen_stock','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_almacen','int4');
        $this->captura('id_item','int4');
        $this->captura('desc_item','varchar');
        $this->captura('cantidad_min','numeric');
        $this->captura('cantidad_alerta_amarilla','numeric');
        $this->captura('cantidad_alerta_roja','numeric');
        $this->captura('id_usuario_reg','integer');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','integer');
        $this->captura('fecha_mod','timestamp');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarAlmacenItem(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_almacen_stock_ime';
        $this->transaccion='SAL_ALMITEM_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_almacen','id_almacen','int4');
        $this->setParametro('id_item','id_item','int4');
        $this->setParametro('cantidad_min','cantidad_min','numeric');
        $this->setParametro('cantidad_alerta_amarilla','cantidad_alerta_amarilla','numeric');
        $this->setParametro('cantidad_alerta_roja','cantidad_alerta_roja','numeric');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarAlmacenItem(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_almacen_stock_ime';
        $this->transaccion='SAL_ALMITEM_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_almacen_stock','id_almacen_stock','int4');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_almacen','id_almacen','int4');
        $this->setParametro('id_item','id_item','int4');
        $this->setParametro('cantidad_min','cantidad_min','numeric');
        $this->setParametro('cantidad_alerta_amarilla','cantidad_alerta_amarilla','numeric');
        $this->setParametro('cantidad_alerta_roja','cantidad_alerta_roja','numeric');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarAlmacenItem(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_almacen_stock_ime';
        $this->transaccion='SAL_ALMITEM_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_almacen_stock','id_almacen_stock','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>