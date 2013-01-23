<?php
/**
*@package pXP
*@file  MODPartida.php
*@author  Gonzalo Sarmiento Sejas
*@date 23-11-2012 20:06:53
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDiagramaDecisionAccion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDiagramaDecisionAccion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_diagrama_decision_accion_sel';
		$this->transaccion='GEM-GEDIAC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_diagrama_decision_accion','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_diagrama_decision_accion_fk','int4');
		$this->captura('tipo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
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
    
    function listarDiagramaDecisionAccionArb(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='gem.ft_diagrama_decision_accion_sel';
        $this-> setCount(false);
        $this->transaccion='GEM_GEDIARB_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $id_padre = $this->objParam->getParametro('id_padre');
        
        $this->setParametro('id_padre','id_padre','varchar');
        $this->setParametro('id_diagrama_decision','id_diagrama_decision','int4');       
        //$this->setParametro('id_subsistema','id_subsistema','integer');
                
        //Definicion de la lista del resultado del query
        $this->captura('id_diagrama_decision_accion','int4');
        $this->captura('id_diagrama_decision_accion_fk','int4');
        $this->captura('codigo','varchar');
        $this->captura('tipo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('tipo_nodo','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $consulta=$this->getConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;       
    }
			
	function insertarPartida(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_diagrama_decision_accion_ime';
		$this->transaccion='GEM_GEDIAC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_diagrama_decision_accion_fk','id_diagrama_decision_accion_fk','int4');
        $this->setParametro('id_diagrama_decision','id_diagrama_decision','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPartida(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_diagrama_decision_accion_ime';
		$this->transaccion='GEM_GEDIAC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_diagrama_decision_accion','id_diagrama_decision_accion','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_diagrama_decision_accion_fk','id_diagrama_decision_accion_fk','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDiagramaDecisionAccion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_diagrama_decision_accion_ime';
		$this->transaccion='GEM_GEDIAC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_diagrama_decision_accion','id_diagrama_decision_accion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>