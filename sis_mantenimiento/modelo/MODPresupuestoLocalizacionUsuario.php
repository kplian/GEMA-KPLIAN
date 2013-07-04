<?php
/**
*@package pXP
*@file gen-MODPresupuestoLocalizacionUsuario.php
*@author  (admin)
*@date 02-07-2013 04:45:06
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPresupuestoLocalizacionUsuario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPresupuestoLocalizacionUsuario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_presupuesto_localizacion_usuario_sel';
		$this->transaccion='GM_GPREUS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_presupuesto_localizacion_usuario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_presupuesto_localizacion','int4');
		$this->captura('id_usuario','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_persona','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPresupuestoLocalizacionUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_presupuesto_localizacion_usuario_ime';
		$this->transaccion='GM_GPREUS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_presupuesto_localizacion','id_presupuesto_localizacion','int4');
		$this->setParametro('id_usuario','id_usuario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPresupuestoLocalizacionUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_presupuesto_localizacion_usuario_ime';
		$this->transaccion='GM_GPREUS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_presupuesto_localizacion_usuario','id_presupuesto_localizacion_usuario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_presupuesto_localizacion','id_presupuesto_localizacion','int4');
		$this->setParametro('id_usuario','id_usuario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPresupuestoLocalizacionUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_presupuesto_localizacion_usuario_ime';
		$this->transaccion='GM_GPREUS_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_presupuesto_localizacion_usuario','id_presupuesto_localizacion_usuario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>