<?php
/**
*@package pXP
*@file MODIngreso.php
*@author  Gonzalo Sarmiento
*@date 21-09-2012
*@description Clase que envia los parametros requeridos a la Base de datos para
* 			  la ejecucion de las funciones, y que recibe la respuesta del 
* 			  resultado de la ejecucion de las mismas
*/

class MODIngreso extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarIngreso(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_ingreso_sel';	//nombre de la funcion
		$this->transaccion='SAL_ING_SEL';
		$this->tipo_procedimiento='SEL';	//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento','integer');
		$this->captura('id_movimiento_tipo','integer');
		$this->captura('fecha_mov','timestamp');
		$this->captura('numero_mov','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('observaciones','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarIngreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_ingreso_ime';		//nombre de la funcion
		$this->transaccion='SAL_ING_INS';
		$this->tipo_procedimiento='IME';			//tipo de transaccion
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','integer');
		$this->setParametro('fecha_mov','fecha_mov','timestamp');
		$this->setParametro('numero_mov','numero_mov','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('observaciones','observaciones','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarIngreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_ingreso_ime';
		$this->transaccion='SAL_ING_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion		
		$this->setParametro('id_movimiento','id_movimiento','integer');
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','integer');
		$this->setParametro('fecha_mov','fecha_mov','timestamp');
		$this->setParametro('numero_mov','numero_mov','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('observaciones','observaciones','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarIngreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_ingreso_ime';
		$this->transaccion='SAL_ING_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento','id_movimiento','integer');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}			
}
?>