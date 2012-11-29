<?php
/**
*@package pXP
*@file gen-MODFallaEventoExterno.php
*@author  (admin)
*@date 30-09-2012 21:41:31
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFallaEventoExterno extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFallaEventoExterno(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_falla_evento_externo_sel';
		$this->transaccion='GEM_GEFAEVE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_falla_evento','int4');
		$this->captura('id_tipo_equipo','int4');
		$this->captura('tipo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
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
			
	function insertarFallaEventoExterno(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_falla_evento_externo_ime';
		$this->transaccion='GEM_GEFAEVE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFallaEventoExterno(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_falla_evento_externo_ime';
		$this->transaccion='GEM_GEFAEVE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_falla_evento','id_falla_evento','int4');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFallaEventoExterno(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_falla_evento_externo_ime';
		$this->transaccion='GEM_GEFAEVE_ELI';
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