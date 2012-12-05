<?php
/**
*@package pXP
*@file gen-MODLocalizacion.php
*@author  (rac)
*@date 14-06-2012 03:46:45
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLocalizacion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLocalizacion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_localizacion_sel';
		$this->transaccion='GEM_loc_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_localizacion','int4');
		$this->captura('codigo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('fk_id_localizacion','int4');
		$this->captura('ubicacion','varchar');
		$this->captura('coordenadas','varchar');
		$this->captura('desc_ubicacion','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('latitud','text');
		$this->captura('longitud','text');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

function listarLocalizacionArb(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_localizacion_sel';
		$this-> setCount(false);
		$this->transaccion='GEM_LOC_ARB_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$id_padre = $this->objParam->getParametro('id_padre');
		
						
        $this->setParametro('id_padre','id_padre','varchar');		
		
		
		//Definicion de la lista del resultado del query
		$this->captura('id_localizacion','int4');
		$this->captura('codigo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_localizacion_fk','int4');
		$this->captura('ubicacion','varchar');
		$this->captura('coordenadas','varchar');
		$this->captura('desc_ubicacion','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('latitud','text');
		$this->captura('longitud','text');
		$this->captura('usr_reg','varchar');
		$this->captura('texto','text');
		
		$this->captura('tipo_nodo','varchar');
		
		//Ejecuta la instruccion
		
		
		$this->armarConsulta();
	    $consulta=$this->getConsulta();
		$this->ejecutarConsulta();
        
        
		/*obtencion de procedimientos*/
		
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		elseif($id_padre!= '%'){
		    $this->procedimiento='gem.f_uni_cons_sel';
			$this->transaccion='GEM_TUCPLAARB_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			//$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
		
			$this->setParametro('id_localizacion','id_padre','varchar');	
			
			$this->captura('id_uni_cons','integer');
			$this->captura('nombre','varchar');
			$this->captura('codigo','varchar');
			$this->captura('id_localizacion_fk','integer');
			$this->captura('id_localizacion','varchar');
			$this->captura('incluir_calgen','boolean');
			$this->captura('tipo_nodo','varchar');
			
			
			
			
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();
			//echo $consulta;exit;
	  
	  		$this->ejecutarConsulta($this->respuesta);
			
	
		}
		
		
		//Devuelve la respuesta
		return $this->respuesta;
		
		
		
				
		
		
	}
			
	function insertarLocalizacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_localizacion_ime';
		$this->transaccion='GEM_loc_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_localizacion_fk','id_localizacion_fk','int4');
		$this->setParametro('ubicacion','ubicacion','varchar');
		$this->setParametro('coordenadas','coordenadas','varchar');
		$this->setParametro('desc_ubicacion','desc_ubicacion','varchar');
		$this->setParametro('latitud','latitud','varchar');
		$this->setParametro('longitud','longitud','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLocalizacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_localizacion_ime';
		$this->transaccion='GEM_loc_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_localizacion_fk','id_localizacion_fk','int4');
		$this->setParametro('ubicacion','ubicacion','varchar');
		$this->setParametro('coordenadas','coordenadas','varchar');
		$this->setParametro('desc_ubicacion','desc_ubicacion','varchar');
		$this->setParametro('latitud','latitud','varchar');
		$this->setParametro('longitud','longitud','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLocalizacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_localizacion_ime';
		$this->transaccion='GEM_loc_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion','id_localizacion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>