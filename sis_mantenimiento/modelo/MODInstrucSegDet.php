<?php
/**
*@package pXP
*@file gen-MODInstrucSegDet.php
*@author  (admin)
*@date 13-04-2013 03:01:16
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODInstrucSegDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarInstrucSegDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_instruc_seg_det_sel';
		$this->transaccion='GM_INSEDE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_instruc_seg_det','int4');
		$this->captura('id_instruc_seg','int4');
		$this->captura('descripcion','varchar');
		$this->captura('nro','int4');
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
			
	function insertarInstrucSegDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_instruc_seg_det_ime';
		$this->transaccion='GM_INSEDE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_instruc_seg','id_instruc_seg','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nro','nro','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarInstrucSegDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_instruc_seg_det_ime';
		$this->transaccion='GM_INSEDE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_instruc_seg_det','id_instruc_seg_det','int4');
		$this->setParametro('id_instruc_seg','id_instruc_seg','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nro','nro','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarInstrucSegDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_instruc_seg_det_ime';
		$this->transaccion='GM_INSEDE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_instruc_seg_det','id_instruc_seg_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>