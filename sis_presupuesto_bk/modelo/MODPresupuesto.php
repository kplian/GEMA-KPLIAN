<?php
/**
*@package pXP
*@file gen-MODPresupuesto.php
*@author  Gonzalo Sarmiento Sejas
*@date 26-11-2012 21:35:35
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPresupuesto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPresupuesto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='pre.ft_presupuesto_sel';
		$this->transaccion='PRE_PRE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_presupuesto','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('estado','varchar');
		$this->captura('gestion','int4');
		$this->captura('codigo','varchar');
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
			
	function insertarPresupuesto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_presupuesto_ime';
		$this->transaccion='PRE_PRE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('gestion','gestion','int4');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPresupuesto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_presupuesto_ime';
		$this->transaccion='PRE_PRE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_presupuesto','id_presupuesto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('gestion','gestion','int4');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPresupuesto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='pre.ft_presupuesto_ime';
		$this->transaccion='PRE_PRE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_presupuesto','id_presupuesto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    
    function reportePresupuesto(){
        $this->procedimiento='pre.ft_presupuesto_sel';
        $this->transaccion='PRE_SALPRE_SEL';
        $this->tipo_procedimiento='SEL';
        
        $this->setCount(false);
        
        //definicion de los parametros para la funcion
        $this->setParametro('id_presupuesto','id_presupuesto','varchar');
        $this->setParametro('id_partida','id_partida','varchar');
        $this->setParametro('fecha_ini','fecha_ini','timestamp');
        $this->setParametro('fecha_fin','fecha_fin','timestamp');
        
        //Definicion de la lista del resultado del query
        $this->captura('id_partida','int4');
        $this->captura('codigo_par','varchar');
        $this->captura('id_presupuesto','int4');
        $this->captura('codigo_pres','varchar');
        $this->captura('centro_costo','varchar');
        $this->captura('moneda','varchar');      
        $this->captura('presup_ene','numeric');
        $this->captura('ejec_ene','numeric');
        $this->captura('presup_feb','numeric');
        $this->captura('ejec_feb','numeric');
        $this->captura('presup_mar','numeric');
        $this->captura('ejec_mar','numeric');
        $this->captura('presup_abr','numeric');
        $this->captura('ejec_abr','numeric');
        $this->captura('presup_may','numeric');
        $this->captura('ejec_may','numeric');
        $this->captura('presup_jun','numeric');
        $this->captura('ejec_jun','numeric');
        $this->captura('presup_jul','numeric');
        $this->captura('ejec_jul','numeric');
        $this->captura('presup_ago','numeric');
        $this->captura('ejec_ago','numeric');
        $this->captura('presup_sep','numeric');
        $this->captura('ejec_sep','numeric');
        $this->captura('presup_oct','numeric');
        $this->captura('ejec_oct','numeric');
        $this->captura('presup_nov','numeric');
        $this->captura('ejec_nov','numeric');
        $this->captura('presup_dic','numeric');
        $this->captura('ejec_dic','numeric');        
        
        //devuelve la respuesta
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        return $this->respuesta;
    }			
}
?>