<?php
/**
*@package pXP
*@file gen-MODFallaEvento.php
*@author  (admin)
*@date 30-09-2012 21:41:31
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFallaEvento extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFallaEvento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_falla_evento_sel';
		$this->transaccion='GEM_GEFAEV_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_falla_evento','int4');
		$this->captura('id_tipo_equipo','int4');
		$this->captura('tipo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarFallaEvento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_falla_evento_ime';
		$this->transaccion='GEM_GEFAEV_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFallaEvento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_falla_evento_ime';
		$this->transaccion='GEM_GEFAEV_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_falla_evento','id_falla_evento','int4');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFallaEvento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_falla_evento_ime';
		$this->transaccion='GEM_GEFAEV_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_falla_evento','id_falla_evento','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>