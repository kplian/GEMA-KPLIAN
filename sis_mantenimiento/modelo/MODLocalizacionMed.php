<?php
/**
*@package pXP
*@file gen-MODLocalizacionMed.php
*@author  (admin)
*@date 07-12-2012 14:20:30
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLocalizacionMed extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLocalizacionMed(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_localizacion_med_sel';
		$this->transaccion='GM_LOCMED_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_localizacion_med','int4');
		$this->captura('id_localizacion','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('tiempo_mnp_hrs','numeric');
		$this->captura('estado_reg','varchar');
		$this->captura('tiempo_standby_hrs','numeric');
		$this->captura('num_paros','int4');
		$this->captura('tiempo_op_hrs','numeric');
		$this->captura('fecha_med','date');
		$this->captura('tiempo_mpp_hrs','numeric');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_uni_cons','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarLocalizacionMed(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_med_ime';
		$this->transaccion='GM_LOCMED_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('tiempo_mnp_hrs','tiempo_mnp_hrs','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tiempo_standby_hrs','tiempo_standby_hrs','numeric');
		$this->setParametro('num_paros','num_paros','int4');
		$this->setParametro('tiempo_op_hrs','tiempo_op_hrs','numeric');
		$this->setParametro('fecha_med','fecha_med','date');
		$this->setParametro('tiempo_mpp_hrs','tiempo_mpp_hrs','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLocalizacionMed(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_med_ime';
		$this->transaccion='GM_LOCMED_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion_med','id_localizacion_med','int4');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('tiempo_mnp_hrs','tiempo_mnp_hrs','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tiempo_standby_hrs','tiempo_standby_hrs','numeric');
		$this->setParametro('num_paros','num_paros','int4');
		$this->setParametro('tiempo_op_hrs','tiempo_op_hrs','numeric');
		$this->setParametro('fecha_med','fecha_med','date');
		$this->setParametro('tiempo_mpp_hrs','tiempo_mpp_hrs','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLocalizacionMed(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_med_ime';
		$this->transaccion='GM_LOCMED_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion_med','id_localizacion_med','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>