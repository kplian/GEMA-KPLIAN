<?php
/**
*@package pXP
*@file gen-MODOrdenTrabajoSolInsumo.php
*@author  (admin)
*@date 17-02-2013 07:39:55
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODOrdenTrabajoSolInsumo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarOrdenTrabajoSolInsumo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_orden_trabajo_sol_insumo_sel';
		$this->transaccion='GM_OTSOIN_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_orden_trabajo_sol_insumo','int4');
		$this->captura('id_orden_trabajo_sol','int4');
		$this->captura('id_unidad_medida','int4');
		$this->captura('descripcion','varchar');
		$this->captura('cant_insum','numeric');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('unidad_medida','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarOrdenTrabajoSolInsumo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_orden_trabajo_sol_insumo_ime';
		$this->transaccion='GM_OTSOIN_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','int4');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('cant_insum','cant_insum','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarOrdenTrabajoSolInsumo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_orden_trabajo_sol_insumo_ime';
		$this->transaccion='GM_OTSOIN_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_orden_trabajo_sol_insumo','id_orden_trabajo_sol_insumo','int4');
		$this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','int4');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('cant_insum','cant_insum','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarOrdenTrabajoSolInsumo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_orden_trabajo_sol_insumo_ime';
		$this->transaccion='GM_OTSOIN_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_orden_trabajo_sol_insumo','id_orden_trabajo_sol_insumo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>