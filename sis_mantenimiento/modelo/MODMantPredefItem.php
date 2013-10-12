<?php
/**
*@package pXP
*@file gen-MODMantPredefItem.php
*@author  (admin)
*@date 10-10-2013 23:53:04
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMantPredefItem extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMantPredefItem(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_mant_predef_item_sel';
		$this->transaccion='GM_MAPRIT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_mant_predef_item','int4');
		$this->captura('id_mant_predef','int4');
		$this->captura('id_item','int4');
		$this->captura('cantidad_item','numeric');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_item','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMantPredefItem(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_item_ime';
		$this->transaccion='GM_MAPRIT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('cantidad_item','cantidad_item','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMantPredefItem(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_item_ime';
		$this->transaccion='GM_MAPRIT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_mant_predef_item','id_mant_predef_item','int4');
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('cantidad_item','cantidad_item','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMantPredefItem(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_item_ime';
		$this->transaccion='GM_MAPRIT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_mant_predef_item','id_mant_predef_item','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>