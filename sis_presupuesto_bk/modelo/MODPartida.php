<?php
/**
*@package pXP
*@file  MODPartida.php
*@author  Gonzalo Sarmiento Sejas
*@date 23-11-2012 20:06:53
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPartida extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPartida(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='pre.ft_partida_sel';
		$this->transaccion='PRE_PAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_partida','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_partida_fk','int4');
		$this->captura('tipo','varchar');
		$this->captura('descripcion','varchar');
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
    
    function listarPartidaArb(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='pre.ft_partida_sel';
        $this-> setCount(false);
        $this->transaccion='PRE_PAR_ARB_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $id_padre = $this->objParam->getParametro('id_padre');
        
        $this->setParametro('id_padre','id_padre','varchar');       
        //$this->setParametro('id_subsistema','id_subsistema','integer');
                
        //Definicion de la lista del resultado del query
        $this->captura('id_partida','int4');
        $this->captura('id_partida_fk','int4');
        $this->captura('codigo','varchar');
        $this->captura('tipo','varchar');
        $this->captura('descripcion','varchar');
        $this->captura('tipo_nodo','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $consulta=$this->getConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;       
    }
			
	function insertarPartida(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_partida_ime';
		$this->transaccion='PRE_PAR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_partida_fk','id_partida_fk','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPartida(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_partida_ime';
		$this->transaccion='PRE_PAR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_partida','id_partida','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_partida_fk','id_partida_fk','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPartida(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_partida_ime';
		$this->transaccion='PRE_PAR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_partida','id_partida','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>