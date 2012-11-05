<?php
/**
*@package pXP
*@file gen-MODFuncionFalla.php
*@author  (admin)
*@date 30-09-2012 21:41:13
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFuncionFalla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFuncionFalla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_funcion_falla_sel';
		$this->transaccion='GEM_GEFALL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_funcion_falla','int4');
		$this->captura('id_funcion','int4');
		$this->captura('id_falla_evento','int4');
		$this->captura('modo_falla','varchar');
		$this->captura('orden','int4');
		$this->captura('efecto_falla','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_falla_evento','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFuncionFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcion_falla_ime';
		$this->transaccion='GEM_GEFALL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcion','id_funcion','int4');
		$this->setParametro('id_falla_evento','id_falla_evento','int4');
		$this->setParametro('modo_falla','modo_falla','varchar');
		$this->setParametro('orden','orden','int4');
		$this->setParametro('efecto_falla','efecto_falla','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFuncionFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcion_falla_ime';
		$this->transaccion='GEM_GEFALL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcion_falla','id_funcion_falla','int4');
		$this->setParametro('id_funcion','id_funcion','int4');
		$this->setParametro('id_falla_evento','id_falla_evento','int4');
		$this->setParametro('modo_falla','modo_falla','varchar');
		$this->setParametro('orden','orden','int4');
		$this->setParametro('efecto_falla','efecto_falla','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFuncionFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcion_falla_ime';
		$this->transaccion='GEM_GEFALL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcion_falla','id_funcion_falla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>