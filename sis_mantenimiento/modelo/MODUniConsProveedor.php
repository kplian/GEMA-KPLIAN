<?php
/**
*@package       pXP
*@file          gen-MODUniConsProveedor.php
*@author        (rac)
*@date          01-11-2012 14:45:49
*@description   Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUniConsProveedor extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUniConsProveedor(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_uni_cons_proveedor_sel';
		$this->transaccion='GEM_unipro_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_uni_cons_proveedor','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_uni_cons','int4');        
		$this->captura('id_proveedor','int4');
        $this->captura('desc_proveedor','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('institucion','varchar');
		$this->captura('contacto','varchar');
		$this->captura('direccion','varchar');
		$this->captura('telefono','varchar');
		$this->captura('email','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarUniConsProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_uni_cons_proveedor_ime';
		$this->transaccion='GEM_unipro_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUniConsProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_uni_cons_proveedor_ime';
		$this->transaccion='GEM_unipro_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_proveedor','id_uni_cons_proveedor','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarUniConsProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_uni_cons_proveedor_ime';
		$this->transaccion='GEM_unipro_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_proveedor','id_uni_cons_proveedor','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>