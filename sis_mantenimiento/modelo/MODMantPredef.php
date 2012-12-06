<?php
/**
*@package pXP
*@file gen-MODMantPredef.php
*@author  (admin)
*@date 28-08-2012 20:25:32
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMantPredef extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMantPredef(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_mant_predef_sel';
		$this->transaccion='GEM_GEMAPR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_mant_predef','int4');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('id_tipo_equipo','int4');
		$this->captura('desc_tipo_equipo','varchar');
		$this->captura('id_unidad_medida_estimado','int4');
		$this->captura('tiempo_estimado','numeric');
		$this->captura('desc_unidad_medida_estimado','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMantPredef(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_ime';
		$this->transaccion='GEM_GEMAPR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('id_unidad_medida_estimado','id_unidad_medida_estimado','int4');
		$this->setParametro('tiempo_estimado','tiempo_estimado','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMantPredef(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_ime';
		$this->transaccion='GEM_GEMAPR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('id_unidad_medida_estimado','id_unidad_medida_estimado','int4');
		$this->setParametro('tiempo_estimado','tiempo_estimado','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMantPredef(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_mant_predef_ime';
		$this->transaccion='GEM_GEMAPR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_mant_predef','id_mant_predef','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	//RCM: 06-12-2012
	function listarMantPredefUC(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_mant_predef_sel';
		$this->transaccion='GEM_GEMPUC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_mant_predef','int4');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('id_tipo_equipo','int4');
		$this->captura('desc_tipo_equipo','varchar');
		$this->captura('id_unidad_medida_estimado','int4');
		$this->captura('tiempo_estimado','numeric');
		$this->captura('desc_unidad_medida_estimado','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>