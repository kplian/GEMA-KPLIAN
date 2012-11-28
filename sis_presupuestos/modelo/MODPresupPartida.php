<?php
/**
*@package pXP
*@file gen-MODPresupPartida.php
*@author  Gonzalo Sarmiento Sejas
*@date 26-11-2012 22:02:47
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPresupPartida extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPresupPartida(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='pre.ft_presup_partida_sel';
		$this->transaccion='PRE_PREPAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		$this->setParametro('id_presupuesto','id_presupuesto','int4');
        $this->setParametro('tipo','tipo','varchar');
		//Definicion de la lista del resultado del query
		$this->captura('id_presup_partida','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('tipo','varchar');
		$this->captura('id_centro_costo','int4');
        $this->captura('centro_codigo','varchar');
		$this->captura('id_presupuesto','int4');
		$this->captura('id_partida','int4');
        $this->captura('partida_codigo','varchar');
		$this->captura('fecha_hora','timestamp');
		$this->captura('id_moneda','int4');
        $this->captura('moneda','varchar');
		$this->captura('importe','numeric');
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
			
	function insertarPresupPartida(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_presup_partida_ime';
		$this->transaccion='PRE_PREPAR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('id_presupuesto','id_presupuesto','int4');
		$this->setParametro('id_partida','id_partida','int4');
		$this->setParametro('fecha_hora','fecha_hora','timestamp');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('importe','importe','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPresupPartida(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_presup_partida_ime';
		$this->transaccion='PRE_PREPAR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_presup_partida','id_presup_partida','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('id_presupuesto','id_presupuesto','int4');
		$this->setParametro('id_partida','id_partida','int4');
		$this->setParametro('fecha_hora','fecha_hora','timestamp');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('importe','importe','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPresupPartida(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_presup_partida_ime';
		$this->transaccion='PRE_PREPAR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_presup_partida','id_presup_partida','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>