<?php
/**
*@package pXP
*@file gen-MODAriableGlobal.php
*@author  (admin)
*@date 14-01-2013 17:19:57
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAriableGlobal extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAriableGlobal(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='pxp.f_ariable_global_sel';
		$this->transaccion='PXP_aaa_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_variable_global','int4');
		$this->captura('variable','varchar');
		$this->captura('valor','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarAriableGlobal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pxp.f_ariable_global_ime';
		$this->transaccion='PXP_aaa_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('variable','variable','varchar');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAriableGlobal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pxp.f_ariable_global_ime';
		$this->transaccion='PXP_aaa_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_variable_global','id_variable_global','int4');
		$this->setParametro('variable','variable','varchar');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAriableGlobal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pxp.f_ariable_global_ime';
		$this->transaccion='PXP_aaa_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_variable_global','id_variable_global','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>