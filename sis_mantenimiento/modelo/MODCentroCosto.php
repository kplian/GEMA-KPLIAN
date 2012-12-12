<?php
/**
*@package pXP
*@file gen-MODCentroCosto.php
*@author  (admin)
*@date 08-12-2012 05:45:32
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCentroCosto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCentroCosto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_centro_costo_sel';
		$this->transaccion='GM_cencos_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_centro_costo','int4');
		$this->captura('tipo','varchar');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo_anh','varchar');
		$this->captura('descripcion_anh','varchar');
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
			
	function insertarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_centro_costo_ime';
		$this->transaccion='GM_cencos_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo_anh','codigo_anh','varchar');
		$this->setParametro('descripcion_anh','descripcion_anh','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_centro_costo_ime';
		$this->transaccion='GM_cencos_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo_anh','codigo_anh','varchar');
		$this->setParametro('descripcion_anh','descripcion_anh','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_centro_costo_ime';
		$this->transaccion='GM_cencos_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_centro_costo','id_centro_costo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>