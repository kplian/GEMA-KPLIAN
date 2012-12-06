<?php
/**
*@package   pXP
*@file      MODTpmTarjeta.php
*@author    Gonzalo Sarmiento Sejas
*@date 29-11-2012 02:21:39
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTpmTarjeta extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTpmTarjeta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_tpm_tarjeta_sel';
		$this->transaccion='GM_TARTPM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
	    $this->setParametro('id_localizacion','id_localizacion','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_tpm_tarjeta','int4');
		$this->captura('id_localizacion','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_emision','date');
		$this->captura('tipo','varchar');
		$this->captura('revision','int4');
		$this->captura('codigo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTpmTarjeta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tpm_tarjeta_ime';
		$this->transaccion='GM_TARTPM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_emision','fecha_emision','date');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('revision','revision','int4');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTpmTarjeta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tpm_tarjeta_ime';
		$this->transaccion='GM_TARTPM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tpm_tarjeta','id_tpm_tarjeta','int4');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_emision','fecha_emision','date');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('revision','revision','int4');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTpmTarjeta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tpm_tarjeta_ime';
		$this->transaccion='GM_TARTPM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tpm_tarjeta','id_tpm_tarjeta','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    
    function listarTpmTarjetaReporte(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='gem.ft_tpm_tarjeta_sel';
        $this->transaccion='GM_TARTPM_REP';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
    
        $this->setParametro('id_tpm_tarjeta','id_tpm_tarjeta','int4');
        //Definicion de la lista del resultado del query
        $this->captura('id_tpm_tarjeta','int4');
        $this->captura('id_localizacion','int4');
        $this->captura('localizacion','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('fecha_emision','date');
        $this->captura('tipo','varchar');
        $this->captura('revision','int4');
        $this->captura('codigo','varchar');
        $this->captura('fecha_reg','text');
        $this->captura('id_usuario_reg','int4');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','text');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>