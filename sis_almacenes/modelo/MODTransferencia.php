<?php
/**
*@package pXP
*@file MODTransferencia.php
*@author  Gonzalo Sarmiento
*@date 27-09-2012
*@description Clase que envia los parametros requeridos a la Base de datos para
* 			  la ejecucion de las funciones, y que recibe la respuesta del 
* 			  resultado de la ejecucion de las mismas
*/

class MODTransferencia extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTransferencia(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_transferencia_sel';	//nombre de la funcion
		$this->transaccion='SAL_TRA_SEL';
		$this->tipo_procedimiento='SEL';	//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento','integer');
		$this->captura('id_movimiento_tipo','integer');
		$this->captura('id_almacen_origen','integer');
		$this->captura('almacen_origen','varchar');		
		$this->captura('id_funcionario','integer');
		$this->captura('id_proveedor','integer');
		$this->captura('id_almacen_destino','integer');
		$this->captura('almacen_destino','varchar');
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
			
	function insertarTransferencia(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_transferencia_ime';		//nombre de la funcion
		$this->transaccion='SAL_TRA_INS';
		$this->tipo_procedimiento='IME';			//tipo de transaccion
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','integer');
		$this->setParametro('id_almacen_origen','id_almacen_origen','integer');
		$this->setParametro('id_funcionario','id_funcionario','integer');
		$this->setParametro('id_proveedor','id_proveedor','integer');
		$this->setParametro('id_almacen_destino','id_almacen_destino','integer');
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
			
	function modificarTransferencia(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_transferencia_ime';
		$this->transaccion='SAL_TRA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion		
		$this->setParametro('id_movimiento','id_movimiento','integer');
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','integer');
		$this->setParametro('id_almacen_origen','id_almacen_origen','integer');
		$this->setParametro('id_funcionario','id_proveedor','integer');
		$this->setParametro('id_proveedor','id_proveedor','integer');
		$this->setParametro('id_almacen_destino','id_almacen_destino','integer');
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
			
	function eliminarTransferencia(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_transferencia_ime';
		$this->transaccion='SAL_TRA_ELI';
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