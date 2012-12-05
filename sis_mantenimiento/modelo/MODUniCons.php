<?php
/**
*@package pXP
*@file gen-MODUniCons.php
*@author  (rac)
*@date 09-08-2012 00:42:57
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUniCons extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUniCons(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_sel';
		$this->transaccion='GEM_TUC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		
		$this->setParametro('id_padre','id_padre','varchar');
		$this->setParametro('tipo','tipo','varchar');
		
		
		//Definicion de la lista del resultado del query
		$this->captura('id_uni_cons','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('nombre','varchar');
		$this->captura('tipo','varchar');
		$this->captura('codigo','varchar');
		$this->captura('id_tipo_equipo','int4');
		$this->captura('id_localizacion','int4');
		
		$this->captura('tipo_nodo','varchar');
        $this->captura('id_uni_cons_comp','int4');
        $this->captura('id_uni_cons_padre','int4');
        $this->captura('opcional','varchar');
        $this->captura('cantidad','int4');
		
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_tipo_equipo','varchar');
		$this->captura('text','varchar');
		$this->captura('incluir_calgen','boolean');
		$this->captura('id_uni_loc','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

	/*
	 * Author: RCM
	 * Date: 30/08/2012
	 * Description: Query that returns only the Equipments roots
	 */	
	function listarUniConsPlano(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_sel';
		$this->transaccion='GEM_TUCPLA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('tipo','tipo','varchar');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_uni_cons','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('nombre','varchar');
		$this->captura('tipo','varchar');
		$this->captura('codigo','varchar');
		$this->captura('id_tipo_equipo','int4');
		$this->captura('id_localizacion','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_tipo_equipo','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	/*Fin RCM*/
	
	function listarUniConsHijo(){
        $this->procedimiento='gem.f_uni_cons_sel';
        $this->transaccion='GEM_TUCHIJO_SEL';
        $this->tipo_procedimiento='SEL';
        $this->setCount(false);
        
        $this->setParametro('id_uni_cons','id_uni_cons','int4');
        
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('id_uni_cons_hijo','int4');
        
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;        
    }
			
	function insertarUniCons(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_ime';
		$this->transaccion='GEM_TUC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('tipo_nodo','tipo_nodo','varchar');
		$this->setParametro('id_uni_cons_padre','id_uni_cons_padre','varchar');
		
		
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('nombre_tipo_equipo','nombre_tipo_equipo','varchar');
		$this->setParametro('id_localizacion','id_localizacion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUniCons(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_ime';
		$this->transaccion='GEM_TUC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_tipo_equipo','id_tipo_equipo','int4');
		$this->setParametro('id_localizacion','id_localizacion','int4');
        $this->setParametro('nombre_tipo_equipo','nombre_tipo_equipo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

    function modificarInclucionGeneracionCalendarioUniCons(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_ime';
		$this->transaccion='GEM_TUCGENCAL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('incluir_calgen','incluir_calgen','boolean');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

     function setBlockUnblockUniCons(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_ime';
		$this->transaccion='GEM_TUCESTBL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('estado','estado','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	 
	 function addUniCons(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_ime';
		$this->transaccion='GEM_ADDUC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('codigo_uni_cons','codigo_uni_cons','varchar');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('codigo_localizacion','codigo_localizacion','varchar');
		$this->setParametro('nombre','nombre','varchar');
		
		//var_dump('XXXXxxx');
		//exit;
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	 
	 
	function GenerarCalendarioConfirmado(){
		//Definicion de variables para ejecucion del procedimiento
	 	$this->procedimiento='gem.f_uni_cons_ime';
		$this->transaccion='GEM_GENCAL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('tipo_nodo','tipo_nodo','varchar');
		
				
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	} 
	 
	function GenerarCalendario(){
		//Definicion de variables para ejecucion del procedimiento
	 	$this->procedimiento='gem.f_uni_cons_ime';
		$this->transaccion='GEM_VERCALGEN_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('tipo_nodo','tipo_nodo','varchar');
		
				
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	} 
	 
		
			
	function eliminarUniCons(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_ime';
		$this->transaccion='GEM_TUC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function obtenerUniCons() {
		$this->procedimiento='gem.f_uni_cons_sel';
		$this->transaccion='GEM_TUCGET_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setParametro('id_uni_cons', 'id_uni_cons', 'int4');
		
		$this->captura('id_uni_cons','int4');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('tipo','varchar');
		$this->captura('estado','varchar');
		$this->captura('tipo_nodo','varchar');
		$this->captura('cod_localizacion','varchar');
		$this->captura('nombre_localizacion','varchar');
		$this->captura('ubicacion','varchar');
		$this->captura('codigo_tipo_equipo','varchar');
		$this->captura('nombre_tipo_equipo','varchar');
		$this->captura('id_uni_cons_padre','int4');
		$this->captura('fecha_reg', 'text');
		$this->captura('fecha_mod', 'text');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	
	
	

	function listarUniConsHijos() {
		$this->procedimiento='gem.f_uni_cons_sel';
		$this->transaccion='GEM_TUCHIJOS_SEL';
		$this->tipo_procedimiento="SEL";
		
		$this->setParametro('id_uni_cons_padre', 'id_uni_cons_padre', 'int4');
		
		$this->captura('id_uni_cons','int4');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('tipo','varchar');
		$this->captura('estado','varchar');
		$this->captura('tipo_nodo','varchar');
		$this->captura('cod_localizacion','varchar');
		$this->captura('nombre_localizacion','varchar');
		$this->captura('ubicacion','varchar');
		$this->captura('codigo_tipo_equipo','varchar');
		$this->captura('nombre_tipo_equipo','varchar');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function listarUniConsDetalle() {
		$this->procedimiento = 'gem.f_uni_cons_sel';
		$this->transaccion = 'GEM_TUCDETALLE_SEL';
		$this->tipo_procedimiento = "SEL";
		
		$this->setParametro('id_uni_cons', 'id_uni_cons', 'int4');
		
		$this->captura('id_equipo_det', 'int4');
		$this->captura('codigo', 'varchar');
		$this->captura('nombre', 'varchar');
		$this->captura('descripcion', 'varchar');
		$this->captura('valor', 'varchar');
		$this->captura('unidad_medida', 'varchar');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}

    function listarUniConsLocalizacion(){
        $this->procedimiento = 'gem.f_uni_cons_sel';
        $this->transaccion = 'GEM_TUCLOC_SEL';
        $this->tipo_procedimiento = 'SEL';
        $this->setCount(false);
        
        $this->setParametro('id_localizacion','id_localizacion','int4');
        
        $this->captura('id_uni_cons','int4');
        $this->captura('id_localizacion','int4');
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;
    }
	
	function inactivarUniCons(){
		$this->procedimiento = 'gem.f_uni_cons_ime';
        $this->transaccion = 'GEM_INACUC_UPD';
        $this->tipo_procedimiento = 'IME';
		
		$this->setParametro('id_uni_cons','id_uni_cons','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
}
?>