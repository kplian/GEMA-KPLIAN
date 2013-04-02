<?php
/**
*@package pXP
*@file gen-MODTipoEquipoCol.php
*@author  (admin)
*@date 19-03-2013 11:20:37
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoEquipoCol extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoEquipoCol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_tipo_equipo_col_sel';
		$this->transaccion='GM_TEQCOL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_equipo_col','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id','varchar');
		$this->captura('id_tipo_equipo','int4');
		$this->captura('tipo_col','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('orden','int4');
		$this->captura('desc_id','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoEquipoCol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tipo_equipo_col_ime';
		$this->transaccion='GM_TEQCOL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id','id','varchar');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('tipo_col','tipo_col','varchar');
		$this->setParametro('orden','orden','int4');
		$this->setParametro('id_ficha','id_ficha','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoEquipoCol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tipo_equipo_col_ime';
		$this->transaccion='GM_TEQCOL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_equipo_col','id_tipo_equipo_col','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id','id','varchar');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('tipo_col','tipo_col','varchar');
		$this->setParametro('orden','orden','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoEquipoCol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tipo_equipo_col_ime';
		$this->transaccion='GM_TEQCOL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_equipo_col','id_tipo_equipo_col','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>