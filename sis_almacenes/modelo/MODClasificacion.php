<?php
/**
*@package pXP
*@file MODClasificacion.php
*@author  Gonzalo Sarmiento
*@date 21-09-2012
*@description Clase que envia los parametros requeridos a la Base de datos para
*             la ejecucion de las funciones, y que recibe la respuesta del 
*             resultado de la ejecucion de las mismas
*/

class MODClasificacion extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
    
    function listarClasificacion(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='alm.ft_clasificacion_sel';
        $this->transaccion='ALM_CLA_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('id_clasificacion','integer');
        $this->captura('nombre','varchar');     
        $this->captura('codigo_largo','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
    function listarClasificacionArb(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='alm.ft_clasificacion_sel';
        $this-> setCount(false);
        $this->transaccion='ALM_CLA_ARB_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $id_padre = $this->objParam->getParametro('id_padre');
        
        $this->setParametro('id_padre','id_padre','varchar');       
        //$this->setParametro('id_subsistema','id_subsistema','integer');
                
        //Definicion de la lista del resultado del query
        $this->captura('id_clasificacion','int4');      
        $this->captura('id_clasificacion_fk','int4');
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('descripcion','varchar');
        $this->captura('tipo_nodo','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        if($this->respuesta->getTipo()=='ERROR'){
            return $this->respuesta;
        }
        elseif($id_padre!= '%'){
            $this->procedimiento='alm.ft_item_sel';
            $this->transaccion='SAL_ARB_SEL';
            $this->tipo_procedimiento='SEL';
            $this->setCount(false);
            //$this->setCount(false);
            $this->resetCaptura();
            $this->addConsulta();
            
            $this->setParametro('id_clasificacion','id_padre','varchar');    
            
            $this->captura('id_item','integer');
            $this->captura('nombre','varchar');
            $this->captura('codigo','varchar');
            $this->captura('id_clasificacion_fk','integer');
            $this->captura('id_clasificacion','varchar');
            $this->captura('tipo_nodo','varchar');
            
            $this->armarConsulta();
            $consulta=$this->getConsulta();
            
      
            $this->ejecutarConsulta($this->respuesta);
        }
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarClasificacion(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_clasificacion_ime';        //nombre de la funcion
        $this->transaccion='SAL_CLA_INS';
        $this->tipo_procedimiento='IME';            //tipo de transaccion
                
        //Define los parametros para la funcion
        $this->setParametro('id_clasificacion_fk','id_clasificacion_fk','integer');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('descripcion','descripcion','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarClasificacion(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_clasificacion_ime';
        $this->transaccion='SAL_CLA_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion     
        $this->setParametro('id_clasificacion','id_clasificacion','integer');
        $this->setParametro('id_clasificacion_fk','id_clasificacion_fk','integer');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('descripcion','descripcion','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarClasificacion(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_clasificacion_ime';
        $this->transaccion='SAL_CLA_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_clasificacion','id_clasificacion','integer');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }           
}
?>