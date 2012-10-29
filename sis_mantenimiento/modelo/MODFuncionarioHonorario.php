<?php
/**
*@package pXP
*@file gen-MODFuncionarioHonorario.php
*@author  (admin)
*@date 22-09-2012 01:44:56
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFuncionarioHonorario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFuncionarioHonorario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_funcionario_honorario_sel';
		$this->transaccion='GEM_GEFUHO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_funcionario_honorario','int4');
		$this->captura('id_tipo_horario','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('id_moneda','int4');
		$this->captura('costo_hora','numeric');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_tipo_horario','varchar');
		$this->captura('desc_moneda','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFuncionarioHonorario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcionario_honorario_ime';
		$this->transaccion='GEM_GEFUHO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_horario','id_tipo_horario','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('costo_hora','costo_hora','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFuncionarioHonorario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcionario_honorario_ime';
		$this->transaccion='GEM_GEFUHO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario_honorario','id_funcionario_honorario','int4');
		$this->setParametro('id_tipo_horario','id_tipo_horario','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('costo_hora','costo_hora','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFuncionarioHonorario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_funcionario_honorario_ime';
		$this->transaccion='GEM_GEFUHO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario_honorario','id_funcionario_honorario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>