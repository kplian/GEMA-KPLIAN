<?php
/**
*@package  pXP
*@file     MODAnalisisPorqueDet.php
*@author   Gonzalo Sarmiento Sejas
*@date 28-11-2012 22:01:17
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAnalisisPorqueDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAnalisisPorqueDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_analisis_porque_det_sel';
		$this->transaccion='GM_DET_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_analisis_porque','id_analisis_porque','int4');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_analisis_porque_det','int4');
		$this->captura('id_analisis_porque','int4');
		$this->captura('solucion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('porque','varchar');
		$this->captura('respuesta','varchar');
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
			
	function insertarAnalisisPorqueDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_det_ime';
		$this->transaccion='GM_DET_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_porque','id_analisis_porque','int4');
		$this->setParametro('solucion','solucion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('porque','porque','varchar');
		$this->setParametro('respuesta','respuesta','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAnalisisPorqueDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_det_ime';
		$this->transaccion='GM_DET_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_porque_det','id_analisis_porque_det','int4');
		$this->setParametro('id_analisis_porque','id_analisis_porque','int4');
		$this->setParametro('solucion','solucion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('porque','porque','varchar');
		$this->setParametro('respuesta','respuesta','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAnalisisPorqueDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_det_ime';
		$this->transaccion='GM_DET_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_porque_det','id_analisis_porque_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>