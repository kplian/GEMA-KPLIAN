<?php
/**
*@package       pXP
*@file          gen-MODTarea.php
*@author        (rac)
*@date          17-10-2012 18:22:11
*@description   Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTarea extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTarea(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_tarea_sel';
		$this->transaccion='GEM_TARE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
		$this->setParametro('id_plan_mant','id_plan_mant','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_tarea','int4');
		$this->captura('id_plan_mant','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('id_uni_cons_hijo','int4');
		$this->captura('nombre_uni_cons_hijo','varchar');
		$this->captura('id_modo_falla','int4');
		$this->captura('modo_falla','varchar');
		$this->captura('id_unidad_medida','int4');
		$this->captura('codigo','varchar');
		$this->captura('tareas','varchar');
		$this->captura('col_hson3','varchar');
		$this->captura('col_h4','varchar');
		$this->captura('col_h','varchar');
		$this->captura('id_falla_evento','int4');
		$this->captura('nombre_falla','varchar');
		$this->captura('col_h5','varchar');
		$this->captura('col_n','varchar');
		$this->captura('col_hson2','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('frecuencia','numeric');
		$this->captura('id_especialidad','int4');
		$this->captura('nombre_especialidad','varchar');
		$this->captura('col_o','varchar');
		$this->captura('col_s','varchar');
		$this->captura('col_s4','varchar');
		$this->captura('col_hson1','varchar');
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
			
	function insertarTarea(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tarea_ime';
		$this->transaccion='GEM_TARE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plan_mant','id_plan_mant','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_uni_cons_hijo','id_uni_cons_hijo','int4');
		$this->setParametro('id_modo_falla','id_modo_falla','int4');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('tareas','tareas','varchar');
		$this->setParametro('col_hson3','col_hson3','varchar');
		$this->setParametro('col_h4','col_h4','varchar');
		$this->setParametro('col_h','col_h','varchar');
		$this->setParametro('id_falla_evento','id_falla_evento','int4');
		$this->setParametro('col_h5','col_h5','varchar');
		$this->setParametro('col_n','col_n','varchar');
		$this->setParametro('col_hson2','col_hson2','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('frecuencia','frecuencia','numeric');
		$this->setParametro('id_especialidad','id_especialidad','int4');
		$this->setParametro('col_o','col_o','varchar');
		$this->setParametro('col_s','col_s','varchar');
		$this->setParametro('col_s4','col_s4','varchar');
		$this->setParametro('col_hson1','col_hson1','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTarea(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tarea_ime';
		$this->transaccion='GEM_TARE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tarea','id_tarea','int4');
		$this->setParametro('id_plan_mant','id_plan_mant','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_uni_cons_hijo','id_uni_cons_hijo','int4');
		$this->setParametro('id_modo_falla','id_modo_falla','int4');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('tareas','tareas','varchar');
		$this->setParametro('col_hson3','col_hson3','varchar');
		$this->setParametro('col_h4','col_h4','varchar');
		$this->setParametro('col_h','col_h','varchar');
		$this->setParametro('id_falla_evento','id_falla_evento','int4');
		$this->setParametro('col_h5','col_h5','varchar');
		$this->setParametro('col_n','col_n','varchar');
		$this->setParametro('col_hson2','col_hson2','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('frecuencia','frecuencia','numeric');
		$this->setParametro('id_especialidad','id_especialidad','int4');
		$this->setParametro('col_o','col_o','varchar');
		$this->setParametro('col_s','col_s','varchar');
		$this->setParametro('col_s4','col_s4','varchar');
		$this->setParametro('col_hson1','col_hson1','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTarea(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_tarea_ime';
		$this->transaccion='GEM_TARE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tarea','id_tarea','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>