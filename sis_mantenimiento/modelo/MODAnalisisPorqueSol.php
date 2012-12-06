<?php
/**
*@package   pXP
*@file      MODAnalisisPorqueSol.php
*@author    Gonzalo Sarmiento Sejas
*@date 28-11-2012 22:28:33
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAnalisisPorqueSol extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAnalisisPorqueSol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_analisis_porque_sol_sel';
		$this->transaccion='GM_PORSOL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
	    $this->setParametro('id_analisis_porque','id_analisis_porque','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_analisis_porque_sol','int4');
		$this->captura('id_analisis_porque','int4');
		$this->captura('id_funcionario','int4');
        $this->captura('desc_funcionario1','text');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('fecha','timestamp');
		$this->captura('descripcion','varchar');
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
			
	function insertarAnalisisPorqueSol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_sol_ime';
		$this->transaccion='GM_PORSOL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_porque','id_analisis_porque','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAnalisisPorqueSol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_sol_ime';
		$this->transaccion='GM_PORSOL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_porque_sol','id_analisis_porque_sol','int4');
		$this->setParametro('id_analisis_porque','id_analisis_porque','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAnalisisPorqueSol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_porque_sol_ime';
		$this->transaccion='GM_PORSOL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_porque_sol','id_analisis_porque_sol','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    
    function reporteAnalisisPorqueSol(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='gem.ft_analisis_porque_sol_sel';
        $this->transaccion='GM_PORSOL_REP';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $this->setCount(false);
        $this->setParametro('id_analisis_porque','id_analisis_porque','int4');
        //Definicion de la lista del resultado del query
        $this->captura('id_analisis_porque_sol','int4');
        $this->captura('id_analisis_porque','int4');
        $this->captura('id_funcionario','int4');
        $this->captura('desc_funcionario1','text');
        $this->captura('estado','varchar');
        $this->captura('fecha','text');
        $this->captura('descripcion','varchar');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
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