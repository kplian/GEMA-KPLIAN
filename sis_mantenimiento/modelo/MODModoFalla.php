<?php
/**
*@package pXP
*@file gen-MODModoFalla.php
*@author  (rac)
*@date 18-10-2012 04:54:08
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODModoFalla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarModoFalla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_modo_falla_sel';
		$this->transaccion='GEM_MODFALLA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_modo_falla','int4');
		$this->captura('id_funcion_falla','int4');
		$this->captura('modo_falla','varchar');
		$this->captura('efecto_falla','varchar');
		$this->captura('orden','int4');
		$this->captura('estado_reg','varchar');
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
			
	function insertarModoFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_modo_falla_ime';
		$this->transaccion='GEM_MODFALLA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcion_falla','id_funcion_falla','int4');
		$this->setParametro('modo_falla','modo_falla','varchar');
		$this->setParametro('efecto_falla','efecto_falla','varchar');
		$this->setParametro('orden','orden','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarModoFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_modo_falla_ime';
		$this->transaccion='GEM_MODFALLA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_modo_falla','id_modo_falla','int4');
		$this->setParametro('id_funcion_falla','id_funcion_falla','int4');
		$this->setParametro('modo_falla','modo_falla','varchar');
		$this->setParametro('efecto_falla','efecto_falla','varchar');
		$this->setParametro('orden','orden','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarModoFalla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_modo_falla_ime';
		$this->transaccion='GEM_MODFALLA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_modo_falla','id_modo_falla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>