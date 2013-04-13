<?php
/**
*@package pXP
*@file MODCuenta.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-02-2013 15:04:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCuenta extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCuenta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_cuenta_sel';
		$this->transaccion='GEM_CTA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_cuenta','int4');
		$this->captura('id_cuenta_padre','int4');
		$this->captura('nro_cuenta','varchar');
		$this->captura('nombre_cuenta','varchar');
		
		$this->captura('id_usuario_reg','int4');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
        $this->captura('estado_reg','varchar');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

 function listarCuentaArb(){
    //Definicion de variables para ejecucion del procedimientp
    $this->procedimiento='gem.ft_cuenta_sel';
    $this-> setCount(false);
    $this->transaccion='GEM_CTA_ARB_SEL';
    $this->tipo_procedimiento='SEL';//tipo de transaccion
    
    $id_padre = $this->objParam->getParametro('id_padre');
    
    $this->setParametro('id_padre','id_padre','varchar'); 
            
    //Definicion de la lista del resultado del query
     $this->captura('id_cuenta','int4');
     $this->captura('id_cuenta_padre','int4');
     $this->captura('nro_cuenta','varchar');
     $this->captura('nombre_cuenta','varchar');
	 $this->captura('tipo_nodo','varchar');
    
    //Ejecuta la instruccion
    $this->armarConsulta();
    $this->ejecutarConsulta();
    
    return $this->respuesta;       
 }
			
	function insertarCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_cuenta_ime';
		$this->transaccion='GEM_CTA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cuenta_padre','id_cuenta_padre','varchar');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('nombre_cuenta','nombre_cuenta','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_cuenta_ime';
		$this->transaccion='GEM_CTA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cuenta','id_cuenta','int4');
		$this->setParametro('id_cuenta_padre','id_cuenta_padre','varchar');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('nombre_cuenta','nombre_cuenta','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_cuenta_ime';
		$this->transaccion='GEM_CTA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cuenta','id_cuenta','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>