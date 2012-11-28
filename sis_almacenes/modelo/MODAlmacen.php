<?php
/**
*@package pXP
*@file MODAlmacen.php
*@author  Gonzalo Sarmiento
*@date 21-09-2012
*@description Clase que envia los parametros requeridos a la Base de datos para
*             la ejecucion de las funciones, y que recibe la respuesta del 
*             resultado de la ejecucion de las mismas
*/

class MODAlmacen extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarAlmacen(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='alm.ft_almacen_sel';  //nombre de la funcion
        $this->transaccion='SAL_ALM_SEL';
        $this->tipo_procedimiento='SEL';    //tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('id_almacen','integer');
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('localizacion','varchar');
        $this->captura('id_almacen_usuario','integer');
        $this->captura('nombre_completo1','text');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarAlmacen(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_almacen_ime';      //nombre de la funcion
        $this->transaccion='SAL_ALM_INS';
        $this->tipo_procedimiento='IME';            //tipo de transaccion
                
        //Define los parametros para la funcion
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('localizacion','localizacion','varchar');
        $this->setParametro('id_almacen_usuario','id_almacen_usuario','int4');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarAlmacen(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_almacen_ime';
        $this->transaccion='SAL_ALM_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion     
        $this->setParametro('id_almacen','id_almacen','integer');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('localizacion','localizacion','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarAlmacen(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_almacen_ime';
        $this->transaccion='SAL_ALM_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_almacen','id_almacen','integer');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }           
}
?>