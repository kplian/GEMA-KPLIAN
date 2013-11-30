<?php
/**
*@package pXP
*@file gen-MODLocalizacionMed.php
*@author  (admin)
*@date 07-12-2012 14:20:30
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLocalizacionMed extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLocalizacionMed(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_localizacion_med_sel';
		$this->transaccion='GM_LOCMED_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//Parametros
		$this->setParametro('id_localizacion','id_localizacion','int4');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_localizacion_med','int4');
		$this->captura('id_localizacion','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('tiempo_mnp_hrs','numeric');
		$this->captura('estado_reg','varchar');
		$this->captura('tiempo_standby_hrs','numeric');
		$this->captura('num_paros','int4');
		$this->captura('tiempo_op_hrs','numeric');
		$this->captura('fecha_med','date');
		$this->captura('tiempo_mpp_hrs','numeric');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_uni_cons','varchar');
		$this->captura('observaciones','varchar');
		$this->captura('num_paros_planif','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarLocalizacionMed(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_med_ime';
		$this->transaccion='GM_LOCMED_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('tiempo_mnp_hrs','tiempo_mnp_hrs','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tiempo_standby_hrs','tiempo_standby_hrs','numeric');
		$this->setParametro('num_paros','num_paros','int4');
		$this->setParametro('tiempo_op_hrs','tiempo_op_hrs','numeric');
		$this->setParametro('fecha_med','fecha_med','date');
		$this->setParametro('tiempo_mpp_hrs','tiempo_mpp_hrs','numeric');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('num_paros_planif','num_paros_planif','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLocalizacionMed(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_med_ime';
		$this->transaccion='GM_LOCMED_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion_med','id_localizacion_med','int4');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('tiempo_mnp_hrs','tiempo_mnp_hrs','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tiempo_standby_hrs','tiempo_standby_hrs','numeric');
		$this->setParametro('num_paros','num_paros','int4');
		$this->setParametro('tiempo_op_hrs','tiempo_op_hrs','numeric');
		$this->setParametro('fecha_med','fecha_med','date');
		$this->setParametro('tiempo_mpp_hrs','tiempo_mpp_hrs','numeric');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('num_paros_planif','num_paros_planif','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLocalizacionMed(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_localizacion_med_ime';
		$this->transaccion='GM_LOCMED_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_localizacion_med','id_localizacion_med','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarIndicadores(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_formula_indicadores_sel';
		$this->transaccion='GEM_FORIND_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		$this->setTipoRetorno('record');
		
		//Parametros
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('num_dias','num_dias','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('fecha_fin','fecha_fin','date');
		
		//Definicion de la lista del resultado del query
		$this->captura('nombre','varchar');
		$this->captura('indicador','numeric');
		$this->captura('observaciones','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
    function reporteLocalizacionMed(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='gem.ft_localizacion_med_sel';
        $this->transaccion='GM_LOCMED_REP';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(false);
        //Parametros
        $this->setParametro('id_localizacion','id_localizacion','int4');
        $this->setParametro('fecha_ini','fecha_ini','varchar');
        $this->setParametro('fecha_fin','fecha_fin','varchar');
                
        //Definicion de la lista del resultado del query
        $this->captura('nombre_sistema','varchar');
        $this->captura('nombre_localizacion','varchar');
        $this->captura('codigo','varchar');
        $this->captura('tiempo_mnp_hrs','numeric');
        $this->captura('estado_reg','varchar');
        $this->captura('tiempo_standby_hrs','numeric');
        $this->captura('num_paros','int4');
        $this->captura('tiempo_op_hrs','numeric');
        $this->captura('mes_literal','text');
        $this->captura('mes','text');
        $this->captura('anio','text');
        $this->captura('fecha_med','text');
        $this->captura('tiempo_mpp_hrs','numeric');
        $this->captura('fecha_reg','text');
        $this->captura('fecha_mod','text');
		$this->captura('num_paros_planif','int4');
		$this->captura('fecha_med_real','text');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        //echo $this->consulta;exit;
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }

    function reporteAnualLocalizacionMed(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='gem.ft_localizacion_med_sel';
        $this->transaccion='GM_LOCMED_REP_ANUAL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(false);
        //Parametros
        $this->setParametro('id_localizacion','id_localizacion','int4');
        $this->setParametro('fecha_ini','fecha_ini','varchar');
        $this->setParametro('fecha_fin','fecha_fin','varchar');
                
        //Definicion de la lista del resultado del query
        $this->captura('num_paros','varchar');
        $this->captura('tiempo_op_hrs','varchar');
        $this->captura('tiempo_standby_hrs','varchar');
        $this->captura('tiempo_mnp_hrs','varchar');
        $this->captura('tiempo_mpp_hrs','varchar');
        $this->captura('mes','varchar');
        $this->captura('dias','varchar');
        $this->captura('nombre_sistema','varchar');
        $this->captura('nombre_localizacion','varchar');
        $this->captura('codigo','varchar');
		$this->captura('num_paros_planif','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        //echo $this->consulta;exit;
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }

	function datosIndicadoresGraf(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_calculo_indicadores_graf_sel';
		
		if($this->objParam->getParametro('tipo_indicador')=='costos'){
			$this->transaccion='GM_GRACOS_SEL';
		} else if($this->objParam->getParametro('tipo_indicador')=='ejecucion'){
			$this->transaccion='GM_GRAEJM_SEL';
		} else{ 
			//Por defecto es el de Tipos de Mantenimiento
			$this->transaccion='GM_GRATMA_SEL';
		}
		
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->count=false;
		
		//Parametros
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('mes_ini','mes_ini','int4');
		$this->setParametro('mes_fin','mes_fin','int4');
		$this->setParametro('gestion_ini','gestion_ini','int4');
		$this->setParametro('gestion_fin','gestion_fin','int4');
		
		//Definicion de la lista del resultado del query
		if($this->objParam->getParametro('tipo_indicador')=='costos'){
			$this->captura('tipo','text');
			$this->captura('total','numeric');
		} else if($this->objParam->getParametro('tipo_indicador')=='ejecucion'){
			$this->captura('tipo','text');
			$this->captura('total_pla','numeric');
			$this->captura('total_eje','numeric');
		} else{ 
			//Por defecto es el de Tipos de Mantenimiento
			$this->captura('tipo','varchar');
			$this->captura('total','bigint');
		}
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		//echo $this->consulta;exit;
		//Devuelve la respuesta
		return $this->respuesta;
	}		
}
?>