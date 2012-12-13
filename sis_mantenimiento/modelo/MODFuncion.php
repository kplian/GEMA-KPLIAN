<?php
/**
*@package pXP
*@file gen-MODFuncion.php
*@author  (admin)
*@date 30-09-2012 21:41:09
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFuncion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFuncion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_funcion_sel';
		$this->transaccion='GEM_GEFUNC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_funcion','int4');
		$this->captura('id_analisis_mant','int4');
		$this->captura('descripcion','varchar');
		$this->captura('orden','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarFuncion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcion_ime';
		$this->transaccion='GEM_GEFUNC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_mant','id_analisis_mant','int4');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('orden','orden','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFuncion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcion_ime';
		$this->transaccion='GEM_GEFUNC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcion','id_funcion','int4');
		$this->setParametro('id_analisis_mant','id_analisis_mant','int4');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('orden','orden','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFuncion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcion_ime';
		$this->transaccion='GEM_GEFUNC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcion','id_funcion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>
