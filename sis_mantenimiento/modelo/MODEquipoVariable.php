<?php
/**
*@package pXP
*@file gen-MODEquipoVariable.php
*@author  (rac)
*@date 15-08-2012 17:09:17
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEquipoVariable extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEquipoVariable(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_equipo_variable_sel';
		$this->transaccion='GEM_EQV_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_uni_cons','id_uni_cons','integer');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_equipo_variable','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('valor_max','numeric');
		$this->captura('id_uni_cons','int4');
		$this->captura('obs','varchar');
		$this->captura('valor_min','numeric');
		$this->captura('id_tipo_variable','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_tipo_variable','varchar');
		$this->captura('codigo_unidad_medida','varchar');
		$this->captura('id_unidad_medida','int4');
		$this->captura('key','int4');
		$this->captura('tipo','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarEquipoVariable(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_equipo_variable_ime';
		$this->transaccion='GEM_EQV_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('valor_max','valor_max','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('valor_min','valor_min','int4');
		$this->setParametro('id_tipo_variable','id_tipo_variable','int4');
        $this->setParametro('nombre_tipo_variable','nombre_tipo_variable','varchar');
         $this->setParametro('id_unidad_medida','id_unidad_medida','int4');
        $this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEquipoVariable(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_equipo_variable_ime';
		$this->transaccion='GEM_EQV_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_equipo_variable','id_equipo_variable','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('valor_max','valor_max','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('valor_min','valor_min','int4');
		$this->setParametro('id_tipo_variable','id_tipo_variable','int4');
		$this->setParametro('nombre_tipo_variable','nombre_tipo_variable','varchar');
        
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
        $this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEquipoVariable(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_equipo_variable_ime';
		$this->transaccion='GEM_EQV_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_equipo_variable','id_equipo_variable','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarVariables(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_equipo_variable_sel';
		$this->transaccion='GEM_EQUVAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_uni_cons','id_uni_cons','integer');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_equipo_variable','int4');
		$this->captura('valor_max','numeric');
		$this->captura('valor_min','numeric');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('desc_un_med','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>