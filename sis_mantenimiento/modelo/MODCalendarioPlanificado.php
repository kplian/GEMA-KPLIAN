<?php
/**
*@package pXP
*@file gen-MODCalendarioPlanificado.php
*@author  (admin)
*@date 02-11-2012 15:04:36
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCalendarioPlanificado extends MODbase{
	
	function __construct(CTParametro $pParam){
		
		parent::__construct($pParam);
	}
			
	function listarCalendarioPlanificado(){
		
		
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_calendario_planificado_sel';
		$this->transaccion='GEM_CALE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_calendario_planificado','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('tipo','varchar');
		$this->captura('fecha_fin','int4');
		$this->captura('observaciones','int4');
		$this->captura('fecha_ini','date');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarCalendarioPlanificado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_calendario_planificado_ime';
		$this->transaccion='GEM_CALE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('fecha_fin','fecha_fin','int4');
		$this->setParametro('observaciones','observaciones','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCalendarioPlanificado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_calendario_planificado_ime';
		$this->transaccion='GEM_CALE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_calendario_planificado','id_calendario_planificado','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('fecha_fin','fecha_fin','int4');
		$this->setParametro('observaciones','observaciones','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCalendarioPlanificado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_calendario_planificado_ime';
		$this->transaccion='GEM_CALE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_calendario_planificado','id_calendario_planificado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

     function listarMesesCalendario(){
     	
		
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_calendario_meses_sel';
		$this->transaccion='GEM_CALMES_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
			
		//Definicion de la lista del resultado del query
		$this->setParametro('fecha_ini','fecha_ini','date');
		
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->captura('id_mes','int4');
		$this->captura('nombre','varchar');
		$this->captura('fecha_ini','date');
		$this->captura('fecha_fin','date');
		$this->captura('codigo_col','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	 
	 function listarMesesCalendarioDet(){
     	
		
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_calendario_meses_det_sel';
		$this->transaccion='GEM_CALMESDET_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->count=false;
			
		//Definicion de la lista del resultado del query
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->captura('id_sem_mes','int4');
		$this->captura('ano','varchar');
		$this->captura('mes','varchar');
		$this->captura('semana','varchar');
		$this->captura('codigo','varchar');
		
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

   function listarCalendarioPlanificadoDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_calendario_meses_det_sel';
		$this->transaccion='GEM_PLANCALEQ_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//$this->objParam->defecto('ordenacion','id_tipo_sensor_columna');
        //$this->objParam->defecto('dir_ordenacion','asc');
        //$this->count=false;
        
		$datos = $this->objParam->getParametro('datos');
		//$this->setParametro('id_tipo_sensor','id_tipo_sensor','integer');
		//$this->setParametro('id_sensor','id_sensor','integer');	
		$this->setParametro('datos','datos','varchar');	
		$this->setParametro('tipo_nodo','tipo_nodo','varchar');	
		$this->setParametro('id_localizacion','id_localizacion','integer');	
		$this->setParametro('id_uni_cons','id_uni_cons','integer');	
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('fecha_fin','fecha_fin','date');
		
		$parametros= explode('@',$datos);
		
		$tamaño = sizeof($parametros);
		
		for($i=0;$i<$tamaño;$i++){
				
			
			
			$parametros_tipo=explode('#',$parametros[$i]);
			
			$this->captura($parametros_tipo[0],$parametros_tipo[1]);
			
		}
		//Definicion de la lista del resultado del query
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

    function OtenerCalPla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_calendario_planificado_ime';
		$this->transaccion='GEM_OBTCALPLA_EMI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('calendario_planificado','calendario_planificado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function UpdateCalPla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_calendario_planificado_ime';
		$this->transaccion='GEM_UPDCALPLA_IME';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('fecha_ini','fecha_ini','date');
        $this->setParametro('recursivo','recursivo','varchar');
        $this->setParametro('id_calendario_planificado','id_calendario_planificado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	


			
}
?>