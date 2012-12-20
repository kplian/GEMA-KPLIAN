<?php
/**
*@package pXP
*@file gen-MODIssue.php
*@author  (admin)
*@date 10-12-2012 19:16:36
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODIssue extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarIssue(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='kge.ft_issue_sel';
		$this->transaccion='KG_ISSUE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_issue','int4');
		$this->captura('titulo','varchar');
		$this->captura('creador','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('nro_issue','int4');
		$this->captura('milestone','varchar');
		$this->captura('developer','varchar');
		$this->captura('fecha_cierre','date');
		$this->captura('labels','varchar');
		$this->captura('fecha_act','date');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('tiempo_hrs','numeric');
		$this->captura('semana','varchar');
		$this->captura('prioridad','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarIssue(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='kge.ft_issue_ime';
		$this->transaccion='KG_ISSUE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('creador','creador','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nro_issue','nro_issue','int4');
		$this->setParametro('milestone','milestone','varchar');
		$this->setParametro('developer','developer','varchar');
		$this->setParametro('fecha_cierre','fecha_cierre','date');
		$this->setParametro('labels','labels','varchar');
		$this->setParametro('fecha_act','fecha_act','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('tiempo_hrs','tiempo_hrs','numeric');
		$this->setParametro('semana','semana','varchar');
		$this->setParametro('prioridad','prioridad','integer');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarIssue(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='kge.ft_issue_ime';
		$this->transaccion='KG_ISSUE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_issue','id_issue','int4');
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('creador','creador','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nro_issue','nro_issue','int4');
		$this->setParametro('milestone','milestone','varchar');
		$this->setParametro('developer','developer','varchar');
		$this->setParametro('fecha_cierre','fecha_cierre','date');
		$this->setParametro('labels','labels','varchar');
		$this->setParametro('fecha_act','fecha_act','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('tiempo_hrs','tiempo_hrs','numeric');
		$this->setParametro('semana','semana','varchar');
		$this->setParametro('prioridad','prioridad','integer');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarIssue(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='kge.ft_issue_ime';
		$this->transaccion='KG_ISSUE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_issue','id_issue','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function delIssues(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='kge.ft_issue_ime';
		$this->transaccion='KG_ISSUPD_DEL';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>