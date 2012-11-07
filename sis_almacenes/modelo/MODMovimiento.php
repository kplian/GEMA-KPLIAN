<?php
/**
*@package pXP
*@file    MODMovimiento.php
*@author  Gonzalo Sarmiento
*@date    02-10-2012
*@description Clase que envia los parametros requeridos a la Base de datos para
*             la ejecucion de las funciones, y que recibe la respuesta del 
*             resultado de la ejecucion de las mismas
*/

class MODMovimiento extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarMovimiento(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='alm.ft_movimiento_sel';   //nombre de la funcion
        $this->transaccion='SAL_MOV_SEL';
        $this->tipo_procedimiento='SEL';    //tipo de transaccion
                
        $this->setParametro('codigo','codigo','varchar');
        //Definicion de la lista del resultado del query
        $this->captura('id_movimiento','integer');
        $this->captura('id_movimiento_tipo','integer');
        $this->captura('id_almacen','integer');
        $this->captura('nombre_origen','varchar');
        $this->captura('id_funcionario','integer');
        $this->captura('desc_funcionario1','text');
        $this->captura('id_proveedor','integer');
        $this->captura('desc_proveedor','varchar');
        $this->captura('id_almacen_dest','integer');
        $this->captura('nombre_destino','varchar');
        $this->captura('fecha_mov','timestamp');
        $this->captura('numero_mov','varchar');
        $this->captura('descripcion','varchar');
        $this->captura('observaciones','varchar');
        $this->captura('id_usuario_reg','integer');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','integer');
        $this->captura('fecha_mod','timestamp');
        $this->captura('estado_mov','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarMovimiento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_movimiento_ime';       //nombre de la funcion
        $this->transaccion='SAL_MOV_INS';
        $this->tipo_procedimiento='IME';            //tipo de transaccion
                
        //Define los parametros para la funcion
        $this->setParametro('id_movimiento','id_movimiento','integer');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('id_almacen','id_almacen','integer');
        $this->setParametro('id_funcionario','id_funcionario','integer');
        $this->setParametro('id_proveedor','id_proveedor','integer');
        $this->setParametro('id_almacen_dest','id_almacen_dest','integer');
        $this->setParametro('fecha_mov','fecha_mov','timestamp');
        $this->setParametro('numero_mov','numero_mov','varchar');
        $this->setParametro('descripcion','descripcion','varchar');
        $this->setParametro('observaciones','observaciones','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarMovimiento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_movimiento_ime';
        $this->transaccion='SAL_MOV_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion     
        $this->setParametro('id_movimiento','id_movimiento','integer');
        $this->setParametro('id_almacen','id_almacen','integer');
        $this->setParametro('id_funcionario','id_funcionario','integer');
        $this->setParametro('id_proveedor','id_proveedor','integer');
        $this->setParametro('id_almacen_dest','id_almacen_dest','integer');
        $this->setParametro('fecha_mov','fecha_mov','timestamp');
        $this->setParametro('numero_mov','numero_mov','varchar');
        $this->setParametro('descripcion','descripcion','varchar');
        $this->setParametro('observaciones','observaciones','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarMovimiento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_movimiento_ime';
        $this->transaccion='SAL_MOV_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_movimiento','id_movimiento','integer');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    function finalizarMovimiento(){
        $this->procedimiento='alm.ft_movimiento_ime';
        $this->transaccion='SAL_MOV_FIN';
        $this->tipo_procedimiento='IME';
        
        $this->setParametro('id_movimiento','id_movimiento','integer');
        $this->setParametro('operacion','operacion','varchar');
        $this->setParametro('id_almacen','id_almacen','integer');
        $this->setParametro('id_funcionario','id_funcionario','integer');
        $this->setParametro('id_almace_dest','id_almacen_dest','integer');
        $this->setParametro('fecha_mov','fecha_mov','timestamp');       
        $this->setParametro('numero_mov','numero_mov','integer');
        
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;
    }           
}
?>