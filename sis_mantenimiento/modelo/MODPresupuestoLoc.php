<?php
/**
*@package pXP
*@file gen-MODPresupuestoLoc.php
*@author  (admin)
*@date 11-06-2013 19:38:04
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPresupuestoLoc extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPresupuestoLoc(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_presupuesto_loc_sel';
		$this->transaccion='GM_GEPRLO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_presupuesto_loc','int4');
		$this->captura('id_localizacion','int4');
		$this->captura('mes','varchar');
		$this->captura('id_presupuesto','int4');
		$this->captura('monto_ejec','numeric');
		$this->captura('porcen_prog_techo','numeric');
		$this->captura('monto_prog','numeric');
		$this->captura('monto_techo','numeric');
		$this->captura('monto_presup','numeric');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_localizacion','varchar');
		$this->captura('desc_localizacion','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPresupuestoLoc(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_presupuesto_loc_ime';
		$this->transaccion='GM_GEPRLO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('mes','mes','varchar');
		$this->setParametro('id_presupuesto','id_presupuesto','int4');
		$this->setParametro('monto_ejec','monto_ejec','numeric');
		$this->setParametro('porcen_prog_techo','porcen_prog_techo','numeric');
		$this->setParametro('monto_prog','monto_prog','numeric');
		$this->setParametro('monto_techo','monto_techo','numeric');
		$this->setParametro('monto_presup','monto_presup','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPresupuestoLoc(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_presupuesto_loc_ime';
		$this->transaccion='GM_GEPRLO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_presupuesto_loc','id_presupuesto_loc','int4');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('mes','mes','varchar');
		$this->setParametro('id_presupuesto','id_presupuesto','int4');
		$this->setParametro('monto_ejec','monto_ejec','numeric');
		$this->setParametro('porcen_prog_techo','porcen_prog_techo','numeric');
		$this->setParametro('monto_prog','monto_prog','numeric');
		$this->setParametro('monto_techo','monto_techo','numeric');
		$this->setParametro('monto_presup','monto_presup','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPresupuestoLoc(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_presupuesto_loc_ime';
		$this->transaccion='GM_GEPRLO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_presupuesto_loc','id_presupuesto_loc','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarPresupuestoLocRegistro(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_presupuesto_loc_sel';
		$this->transaccion='GM_GEPRLOEX_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_presupuesto_loc','int4');
		$this->captura('id_localizacion','int4');
		$this->captura('mes','varchar');
		$this->captura('id_presupuesto','int4');
		$this->captura('monto_ejec','numeric');
		$this->captura('porcen_prog_techo','numeric');
		$this->captura('monto_prog','numeric');
		$this->captura('monto_techo','numeric');
		$this->captura('monto_presup','numeric');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_localizacion','varchar');
		$this->captura('desc_localizacion','varchar');
		$this->captura('desc_presupuesto','text');
		$this->captura('gestion','integer');
		$this->captura('estado_pres','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>