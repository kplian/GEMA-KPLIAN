<?php
/**
*@package       pXP
*@file          gen-MODPlanMant.php
*@author        (rac)
*@date          12-10-2012 16:15:31
*@description   Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPlanMant extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPlanMant(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_plan_mant_sel';
		$this->transaccion='GEM_PLAMA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_plan_mant','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('nombre_funcionario','text');	
		$this->captura('id_funcionario_rev','int4');
		$this->captura('nombre_funcionario_rev','text');
		$this->captura('id_tipo_mant','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('descripcion','varchar');
		$this->captura('fecha','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarPlanMant(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_plan_mant_ime';
		$this->transaccion='GEM_PLAMA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_funcionario_rev','id_funcionario_rev','int4');
		$this->setParametro('id_tipo_mant','id_tipo_mant','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPlanMant(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_plan_mant_ime';
		$this->transaccion='GEM_PLAMA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plan_mant','id_plan_mant','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_funcionario_rev','id_funcionario_rev','int4');
		$this->setParametro('id_tipo_mant','id_tipo_mant','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPlanMant(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_plan_mant_ime';
		$this->transaccion='GEM_PLAMA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plan_mant','id_plan_mant','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>