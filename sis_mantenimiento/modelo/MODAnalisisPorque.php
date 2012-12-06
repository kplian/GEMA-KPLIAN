<?php
/**
*@package   pXP
*@file      MODAnalisisPorque.php
*@author    Gonzalo Sarmiento Sejas
*@date      28-11-2012 20:22:29
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAnalisisPorque extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAnalisisPorque(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_analisis_porque_sel';
		$this->transaccion='GM_ANAPOR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_analisis_porque','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('tecnicos','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('fecha','timestamp');
		$this->captura('operadores','varchar');
		$this->captura('coordinadores','varchar');
		$this->captura('problema','varchar');
		$this->captura('numero','int4');
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
			
	function insertarAnalisisPorque(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_ime';
		$this->transaccion='GM_ANAPOR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('tecnicos','tecnicos','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('operadores','operadores','varchar');
		$this->setParametro('coordinadores','coordinadores','varchar');
		$this->setParametro('problema','problema','varchar');
		$this->setParametro('numero','numero','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAnalisisPorque(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_ime';
		$this->transaccion='GM_ANAPOR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_porque','id_analisis_porque','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('tecnicos','tecnicos','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('operadores','operadores','varchar');
		$this->setParametro('coordinadores','coordinadores','varchar');
		$this->setParametro('problema','problema','varchar');
		$this->setParametro('numero','numero','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAnalisisPorque(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_ime';
		$this->transaccion='GM_ANAPOR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_porque','id_analisis_porque','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    
    function listarAnalisisPorqueReporte(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='gem.ft_analisis_porque_sel';
        $this->transaccion='GM_ANAPOR_REP';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(false);
        
        $this->setParametro('id_analisis_porque','id_analisis_porque','int4');
        //Definicion de la lista del resultado del query
        $this->captura('id_analisis_porque','int4');
        $this->captura('revision','int4');
        $this->captura('fecha_reg','text');        
        $this->captura('fecha_mod','text');
        $this->captura('nombre_loc','varchar');
        $this->captura('nro_analisis','int4');
        $this->captura('maquina','varchar');
        $this->captura('tag','varchar');
        $this->captura('problema','varchar');        
        $this->captura('fecha','text');                
        $this->captura('estado','varchar');        
        $this->captura('operadores','varchar');        
        $this->captura('coordinadores','varchar');
        $this->captura('tecnicos','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>