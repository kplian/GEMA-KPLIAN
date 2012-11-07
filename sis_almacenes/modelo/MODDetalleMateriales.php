<?php
/**
 * @package pxP
 * @author Gonzalo Sarmiento
 * @file MODDetalleMateriales.php
 * @date 02-10-2012
 * @description Clase que envia los parametros requeridos a la base de datos para la ejecucion de las funciones y recibe el resultado de le ejecucion de las mismas
 */

 class MODDetalleMateriales extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);       
    }
    
    function listarDetalleMateriales(){
        $this->procedimiento = 'alm.ft_movimiento_det_sel';
        $this->transaccion = 'SAL_MOV_DET_SEL';
        $this->tipo_procedimiento = 'SEL';
        
        $this->setParametro('id_movimiento','id_movimiento','int4');
        
        $this->captura('id_movimiento_det','int4');
        $this->captura('id_movimiento','int4');
        $this->captura('id_item','int4');
        $this->captura('desc_item','varchar');
        $this->captura('cantidad','numeric');
        $this->captura('costo_unitario','numeric');
        $this->captura('fecha_caducidad','date');
        $this->captura('id_usuario_reg','integer');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','integer');
        $this->captura('fecha_mod','timestamp');
        
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;        
    }
    
    function insertarDetalleMateriales(){
        $this->procedimiento = 'alm.ft_movimiento_det_ime';
        $this->transaccion = 'SAL_MOV_DET_INS';
        $this->tipo_procedimiento = 'IME';
        
        $this->setParametro('id_movimiento','id_movimiento','integer');
        $this->setParametro('id_item','id_item','integer');
        $this->setParametro('cant','cantidad','numeric');
        $this->setParametro('costo_unitario','costo_unitario','numeric');
        $this->setParametro('fecha_caducidad','fecha_caducidad','date');
        
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;
    }

    function modificarDetalleMateriales(){
        $this->procedimiento = 'alm.ft_movimiento_det_ime';
        $this->transaccion = 'SAL_MOV_DET_MOD';
        $this->tipo_procedimiento = 'IME';
        
        $this->setParametro('id_movimiento_det','id_movimiento_det','integer');
        $this->setParametro('id_movimiento','id_movimiento','integer');
        $this->setParametro('id_item','id_item','integer');
        $this->setParametro('cant','cantidad','numeric');
        $this->setParametro('costo_unitario','costo_unitario','numeric');
        $this->setParametro('fecha_caducidad','fecha_caducidad','date');
        
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;
    } 

    function eliminarDetalleMateriales(){
        $this->procedimiento = 'alm.ft_movimiento_det_ime';
        $this->transaccion = 'SAL_MOV_DET_ELI';
        $this->tipo_procedimiento = 'IME';
        
        $this->setParametro('id_movimiento_det','id_movimiento_det','integer');
        
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;
    }
 }
?>