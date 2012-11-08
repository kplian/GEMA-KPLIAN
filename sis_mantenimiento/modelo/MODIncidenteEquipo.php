<?php
/**
*@package pXP
*@file gen-MODIncidenteEquipo.php
*@author  (admin)
*@date 08-11-2012 17:11:06
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODIncidenteEquipo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarIncidenteEquipo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_incidente_equipo_sel';
		$this->transaccion='GEM_GEEQIN_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_incidente_equipo','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('id_falla_evento','int4');
		$this->captura('descripcion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_desde','timestamp');
		$this->captura('fecha_hasta','timestamp');
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
			
	function insertarIncidenteEquipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_incidente_equipo_ime';
		$this->transaccion='GEM_GEEQIN_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_falla_evento','id_falla_evento','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_desde','fecha_desde','timestamp');
		$this->setParametro('fecha_hasta','fecha_hasta','timestamp');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarIncidenteEquipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_incidente_equipo_ime';
		$this->transaccion='GEM_GEEQIN_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_incidente_equipo','id_incidente_equipo','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_falla_evento','id_falla_evento','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_desde','fecha_desde','timestamp');
		$this->setParametro('fecha_hasta','fecha_hasta','timestamp');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarIncidenteEquipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_incidente_equipo_ime';
		$this->transaccion='GEM_GEEQIN_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_incidente_equipo','id_incidente_equipo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>