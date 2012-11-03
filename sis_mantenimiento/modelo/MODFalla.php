<?php
/**
*@package pXP
*@file gen-MODFalla.php
*@author  (rac)
*@date 21-08-2012 20:44:06
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFalla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFalla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_falla_sel';
		$this->transaccion='GEM_FAL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		
				
		//Definicion de la lista del resultado del query
		$this->captura('id_falla','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('obs','varchar');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('id_tipo_equipo','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_falla_ime';
		$this->transaccion='GEM_FAL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_falla_ime';
		$this->transaccion='GEM_FAL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_falla','id_falla','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_falla_ime';
		$this->transaccion='GEM_FAL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_falla','id_falla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>