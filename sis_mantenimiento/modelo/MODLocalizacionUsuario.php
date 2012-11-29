<?php
/**
*@package pXP
*@file gen-MODLocalizacionUsuario.php
*@author  (admin)
*@date 25-11-2012 04:18:06
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLocalizacionUsuario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLocalizacionUsuario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_localizacion_usuario_sel';
		$this->transaccion='GM_LOCUSU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_localizacion_usuario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('tipo','varchar');
		$this->captura('id_localizacion','int4');
		$this->captura('id_usuario','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_persona','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarLocalizacionUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_usuario_ime';
		$this->transaccion='GM_LOCUSU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_usuario','id_usuario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLocalizacionUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_usuario_ime';
		$this->transaccion='GM_LOCUSU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion_usuario','id_localizacion_usuario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_usuario','id_usuario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLocalizacionUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_usuario_ime';
		$this->transaccion='GM_LOCUSU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion_usuario','id_localizacion_usuario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>