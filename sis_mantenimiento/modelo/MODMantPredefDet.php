<?php
/**
*@package pXP
*@file gen-MODMantPredefDet.php
*@author  (admin)
*@date 28-08-2012 21:15:37
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMantPredefDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMantPredefDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_mant_predef_det_sel';
		$this->transaccion='GEM_GEDETM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_mant_predef_det','int4');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_mant_predef','int4');
		$this->captura('observacion','varchar');
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
			
	function insertarMantPredefDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_det_ime';
		$this->transaccion='GEM_GEDETM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('observacion','observacion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMantPredefDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_det_ime';
		$this->transaccion='GEM_GEDETM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_mant_predef_det','id_mant_predef_det','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('observacion','observacion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMantPredefDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_det_ime';
		$this->transaccion='GEM_GEDETM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_mant_predef_det','id_mant_predef_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>