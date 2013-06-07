<?php
/**
*@package pXP
*@file gen-MODUniConsDet.php
*@author  (admin)
*@date 08-11-2012 21:12:55
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUniConsDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUniConsDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_det_sel';
		$this->transaccion='GM_UCDET_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
				
		//Definicion de la lista del resultado del query
		
		$this->captura('id_uni_cons_det','int4');
		$this->captura('id_unidad_medida','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('codigo','numeric');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('valor','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('codigo_unidad_medida','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarUniConsDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_det_ime';
		$this->transaccion='GM_UCDET_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUniConsDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_det_ime';
		$this->transaccion='GM_UCDET_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_det','id_uni_cons_det','int4');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarUniConsDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_det_ime';
		$this->transaccion='GM_UCDET_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_det','id_uni_cons_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarCaract(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_det_sel';
		$this->transaccion='GM_LISCAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('nombre','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarColumnasFichaTec(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_det_sel';
		$this->transaccion='GM_TODFIC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id','varchar');
		$this->captura('nombre','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarColumnasFichaTecVar(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_det_sel';
		$this->transaccion='GM_COFIVA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
				
		//Definicion de la lista del resultado del query
		$this->captura('id','varchar');
		$this->captura('nombre','varchar');
		$this->captura('key','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit; 
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarFichaTecnicaVariables(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_det_sel';
		$this->transaccion='GM_FICVAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//$this->objParam->defecto('ordenacion','id_tipo_sensor_columna');
        //$this->objParam->defecto('dir_ordenacion','asc');
        //$this->count=false;
        
		$datos = $this->objParam->getParametro('datos');
		
		//$this->setParametro('datos','datos','varchar');
		$this->setParametro('id_localizacion','id_localizacion','integer');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','integer');		
		$this->setParametro('id_uni_cons','id_uni_cons','integer');	
		$this->setParametro('fecha_ini','fecha_ini','date');	
		$this->setParametro('fecha_fin','fecha_fin','date');	
		
		$parametros= explode('@',$datos);
		$tamaño = sizeof($parametros);
		
		//var_dump($parametros);exit;
		
		for($i=0;$i<$tamaño;$i++){
			$parametros_tipo=explode('#',$parametros[$i]);
			$this->captura($parametros_tipo[0],$parametros_tipo[1]);
		}
		//Definicion de la lista del resultado del query
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>