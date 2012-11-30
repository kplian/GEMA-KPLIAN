<?php
/**
*@package   pXP
*@file      MODTpmTarjetaDet.php
*@author    Gonzalo Sarmiento Sejas 
*@date 29-11-2012 14:51:50
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTpmTarjetaDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTpmTarjetaDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_tpm_tarjeta_det_sel';
		$this->transaccion='GM_TARDET_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_tpm_tarjeta','id_tpm_tarjeta','int4');	
		//Definicion de la lista del resultado del query
		$this->captura('id_tpm_tarjeta_det','int4');
		$this->captura('id_tpm_tarjeta','int4');
		$this->captura('id_funcionario_detec','int4');
        $this->captura('desc_func_detec','text');
		$this->captura('id_funcionario_efec','int4');
		$this->captura('desc_func_efec','text');
		$this->captura('id_uni_cons','int4');
        $this->captura('desc_uni_cons','varchar');
		$this->captura('observaciones','varchar');
		$this->captura('falla_el','varchar');
		$this->captura('fecha_retiro','date');
		$this->captura('contaminacion','varchar');
		$this->captura('oportunidad_mejora','varchar');
		$this->captura('falla_ist','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('acceso_dificil','varchar');
		$this->captura('falla_ne','varchar');
		$this->captura('falla_me','varchar');
		$this->captura('fecha_coloc','date');
		$this->captura('estado_reg','varchar');
		$this->captura('cond_inseg','varchar');
		$this->captura('falla_hi','varchar');
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
			
	function insertarTpmTarjetaDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tpm_tarjeta_det_ime';
		$this->transaccion='GM_TARDET_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tpm_tarjeta','id_tpm_tarjeta','int4');
		$this->setParametro('id_funcionario_detec','id_funcionario_detec','int4');
		$this->setParametro('id_funcionario_efec','id_funcionario_efec','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('falla_el','falla_el','varchar');
		$this->setParametro('fecha_retiro','fecha_retiro','date');
		$this->setParametro('contaminacion','contaminacion','varchar');
		$this->setParametro('oportunidad_mejora','oportunidad_mejora','varchar');
		$this->setParametro('falla_ist','falla_ist','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('acceso_dificil','acceso_dificil','varchar');
		$this->setParametro('falla_ne','falla_ne','varchar');
		$this->setParametro('falla_me','falla_me','varchar');
		$this->setParametro('fecha_coloc','fecha_coloc','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('cond_inseg','cond_inseg','varchar');
		$this->setParametro('falla_hi','falla_hi','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTpmTarjetaDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tpm_tarjeta_det_ime';
		$this->transaccion='GM_TARDET_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tpm_tarjeta_det','id_tpm_tarjeta_det','int4');
		$this->setParametro('id_tpm_tarjeta','id_tpm_tarjeta','int4');
		$this->setParametro('id_funcionario_detec','id_funcionario_detec','int4');
		$this->setParametro('id_funcionario_efec','id_funcionario_efec','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('falla_el','falla_el','varchar');
		$this->setParametro('fecha_retiro','fecha_retiro','date');
		$this->setParametro('contaminacion','contaminacion','varchar');
		$this->setParametro('oportunidad_mejora','oportunidad_mejora','varchar');
		$this->setParametro('falla_ist','falla_ist','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('acceso_dificil','acceso_dificil','varchar');
		$this->setParametro('falla_ne','falla_ne','varchar');
		$this->setParametro('falla_me','falla_me','varchar');
		$this->setParametro('fecha_coloc','fecha_coloc','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('cond_inseg','cond_inseg','varchar');
		$this->setParametro('falla_hi','falla_hi','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTpmTarjetaDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tpm_tarjeta_det_ime';
		$this->transaccion='GM_TARDET_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tpm_tarjeta_det','id_tpm_tarjeta_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>