<?php
/**
*@package pXP
*@file gen-MODDiagramaDecision.php
*@author  (admin)
*@date 02-10-2012 01:25:12
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDiagramaDecision extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDiagramaDecision(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_diagrama_decision_sel';
		$this->transaccion='GEM_GEDIDE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_diagrama_decision','int4');
		$this->captura('id_metodologia','int4');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('fecha_desde_validez','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_metodologia','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDiagramaDecision(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_diagrama_decision_ime';
		$this->transaccion='GEM_GEDIDE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_metodologia','id_metodologia','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('fecha_desde_validez','fecha_desde_validez','timestamp');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDiagramaDecision(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_diagrama_decision_ime';
		$this->transaccion='GEM_GEDIDE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_diagrama_decision','id_diagrama_decision','int4');
		$this->setParametro('id_metodologia','id_metodologia','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('fecha_desde_validez','fecha_desde_validez','timestamp');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDiagramaDecision(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_diagrama_decision_ime';
		$this->transaccion='GEM_GEDIDE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_diagrama_decision','id_diagrama_decision','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>