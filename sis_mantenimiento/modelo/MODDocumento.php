<?php
/**
*@package pXP
*@file gen-MODDocumento.php
*@author  (admin)
*@date 28-08-2012 22:24:50
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDocumento extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarDocumento(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='gem.ft_documento_sel';
        $this->transaccion='GEM_GEDOCU_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $_SESSION["ARCHIVO"]=array();       
        //Definicion de la lista del resultado del query
        $this->captura('id_documento','int4');
        $this->captura('nombre','varchar');
        $this->captura('codigo','varchar');
        $this->captura('resumen','varchar');
        $this->captura('nombre_archivo','varchar');
        $this->captura('extension','varchar');
        $this->captura('archivo','bytea','id_documento','extension','archivo','../../../sis_mantenimiento/control/documentos/');
        $this->captura('palabras_clave','varchar');
        $this->captura('tipo','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('id_documento_padre','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarDocumento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='gem.ft_documento_ime';
        $this->transaccion='GEM_GEDOCU_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('resumen','resumen','varchar');
        $this->setParametro('nombre_archivo','nombre_archivo','varchar');
        //$this->setParametro('extension','extension','varchar');
        $this->setParametro('palabras_clave','palabras_clave','varchar');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_documento_padre','id_documento_padre','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarDocumento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='gem.ft_documento_ime';
        $this->transaccion='GEM_GEDOCU_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_documento','id_documento','int4');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('resumen','resumen','varchar');
        $this->setParametro('nombre_archivo','nombre_archivo','varchar');
        $this->setParametro('extension','extension','varchar');
        $this->setParametro('palabras_clave','palabras_clave','varchar');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_documento_padre','id_documento_padre','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarDocumento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='gem.ft_documento_ime';
        $this->transaccion='GEM_GEDOCU_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_documento','id_documento','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function subirDocumento(){
        $this->procedimiento='gem.ft_documento_ime';
        $this->transaccion='GEM_UPDOCU_MOD';
        $this->tipo_procedimiento='IME';
        
        $ext = pathinfo($this->arregloFiles['archivo']['name']);
        $this->arreglo['extension']= $ext['extension'];
        
        //Define los parametros para la funcion 
        $this->setParametro('id_documento','id_documento','integer');   
        $this->setParametro('extension','extension','varchar');
        $this->setParametro('archivo','archivo','bytea',false,'',false,array('doc','pdf','docx'));
                
        
        //Ejecuta la instruccion
        $this->armarConsulta();
                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
    
    function subirVersionDocumento(){
        $this->procedimiento='gem.ft_documento_ime';
        $this->transaccion='GEM_UPDOCVER_MOD';
        $this->tipo_procedimiento='IME';
        
        $ext = pathinfo($this->arregloFiles['archivo']['name']);
        $this->arreglo['extension']= $ext['extension'];
        
        //Define los parametros para la funcion 
        $this->setParametro('id_documento','id_documento','integer');   
        $this->setParametro('extension','extension','varchar');
        $this->setParametro('archivo','archivo','bytea',false,'',false,array('doc','pdf','docx'));
                        
        //Ejecuta la instruccion
        $this->armarConsulta();
                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
    
    function listarVersionDocumento(){
        $this->procedimiento='gem.ft_documento_sel';
        $this->transaccion='GEM_GEDOCUVER_SEL';
        $this->tipo_procedimiento='SEL';
        
        $this->setCount(false);
        $this->setParametro('id_documento','id_documento','int4');
        
        $_SESSION["ARCHIVO"]=array();       
        //Definicion de la lista del resultado del query
        $this->captura('id_documento','int4');
        $this->captura('nombre','varchar');
        $this->captura('codigo','varchar');
        $this->captura('resumen','varchar');
        $this->captura('nombre_archivo','varchar');
        $this->captura('extension','varchar');
        $this->captura('archivo','bytea','id_documento','extension','archivo','../../../sis_mantenimiento/control/documentos/');
        $this->captura('palabras_clave','varchar');
        $this->captura('tipo','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('id_documento_padre','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;        
    }       
}
?>