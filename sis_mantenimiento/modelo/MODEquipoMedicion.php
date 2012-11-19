<?php
/**
*@package pXP
*@file gen-MODEquipoMedicion.php
*@author  (admin)
*@date 27-09-2012 03:02:35
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEquipoMedicion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEquipoMedicion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_equipo_medicion_sel';
		$this->transaccion='GEM_GEMEDI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_equipo_medicion','int4');
		$this->captura('id_equipo_variable','int4');
		$this->captura('observaciones','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_medicion','timestamp');
		$this->captura('medicion','numeric');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('valor_max','numeric');
		$this->captura('valor_min','numeric');
		$this->captura('nombre_tipo_variable','varchar');
		$this->captura('desc_tipo_variable','varchar');
		$this->captura('desc_unidad_medida','varchar');
		$this->captura('id_uni_cons','int4');
		$this->captura('cod_equipo','varchar');
		$this->captura('desc_equipo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

   function listarEquipoMedicionDinamico(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_equipo_medicion_sel';
		$this->transaccion='GEM_EQMEDI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//$this->objParam->defecto('ordenacion','id_tipo_sensor_columna');
        //$this->objParam->defecto('dir_ordenacion','asc');
        //$this->count=false;
        
		$datos = $this->objParam->getParametro('datos');
		
		//$this->setParametro('datos','datos','varchar');	
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
   
     function insertarEquipoMedicionDinamico(){
		
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_equipo_medicion_ime';
		$this->transaccion='GEM_EQUMEDDIN_INS';
		$this->tipo_procedimiento='IME';
		
		//$id33 = $this->objParam->getParametro('id_mediciones_mes');
		//$datos =$id33['datos'];
		
		$aux = $this->objParam->getParametro(0);
		$datos = $aux['datos'];
		
		
		if (!isset($datos)){
		
			
			$datos = $this->objParam->getParametro('datos');
		}
        
		
		$this->setParametro('datos','datos','varchar');	
		
		
		$parametros= explode('@',$datos);
		
		$tamaño = sizeof($parametros);
		
		for($i=0;$i<$tamaño;$i++){
			
			$parametros_tipo=explode('#',$parametros[$i]);
			
			$this->setParametro($parametros_tipo[0],$parametros_tipo[0],$parametros_tipo[1]);
		
			
		}
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		

		//Devuelve la respuesta
		return $this->respuesta;
	}
		
	function eliminarEquipoMedicionDinamico(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_equipo_medicion_ime';
		$this->transaccion='GEM_EQUMEDDIN_ELI';
		$this->tipo_procedimiento='IME';
		
				
		$this->setParametro('keys','keys','varchar');	
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
        //Devuelve la respuesta
		return $this->respuesta;
	}
	
			
	function insertarEquipoMedicion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_equipo_medicion_ime';
		$this->transaccion='GEM_GEMEDI_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_equipo_variable','id_equipo_variable','int4');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_medicion','fecha_medicion','timestamp');
		$this->setParametro('medicion','medicion','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEquipoMedicion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_equipo_medicion_ime';
		$this->transaccion='GEM_GEMEDI_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_equipo_medicion','id_equipo_medicion','int4');
		$this->setParametro('id_equipo_variable','id_equipo_variable','int4');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_medicion','fecha_medicion','timestamp');
		$this->setParametro('medicion','medicion','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEquipoMedicion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_equipo_medicion_ime';
		$this->transaccion='GEM_GEMEDI_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_equipo_medicion','id_equipo_medicion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarMedicionGraf(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_equipo_medicion_sel';
		$this->transaccion='GEM_MEDGRA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_equipo_medicion','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('cod_equipo','varchar');
		$this->captura('equipo','varchar');
		$this->captura('var_nombre','varchar');
		$this->captura('var_desc','varchar');
		$this->captura('cod_unimed','varchar');
		$this->captura('desc_unimed','varchar');
		$this->captura('fecha_medicion','timestamp');
		$this->captura('medicion','timestamp');
		$this->captura('id_equipo_variable','varchar');
		$this->captura('id_tipo_variable','varchar');
		$this->captura('id_unidad_medida','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>