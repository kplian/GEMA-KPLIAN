<?php
/**
*@package pXP
*@file gen-MODAnalisisMant.php
*@author  (admin)
*@date 30-09-2012 21:44:06
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAnalisisMant extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAnalisisMant(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_analisis_mant_sel';
		$this->transaccion='GEM_GEANMA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_analisis_mant','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('id_tipo_mant','int4');
		$this->captura('id_persona_rev','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_emision','date');
		$this->captura('descripcion','varchar');
		$this->captura('fecha_rev','date');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_tipo_mant','varchar');
		$this->captura('desc_person','text');
		$this->captura('id_usuario_prep','int4');
		$this->captura('preparado_por','text');
		$this->captura('id_uni_cons_hijo','int4');
		$this->captura('desc_uni_cons_hijo','varchar');
		$this->captura('id_uo','int4');
		$this->captura('nombre_unidad','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarAnalisisMant(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_mant_ime';
		$this->transaccion='GEM_GEANMA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_tipo_mant','id_tipo_mant','int4');
		$this->setParametro('id_persona_rev','id_persona_rev','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_emision','fecha_emision','date');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('fecha_rev','fecha_rev','date');
		$this->setParametro('id_persona_prep','id_persona_prep','int4');
		$this->setParametro('id_uni_cons_hijo','id_uni_cons_hijo','int4');
		$this->setParametro('id_uo','id_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAnalisisMant(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_mant_ime';
		$this->transaccion='GEM_GEANMA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_mant','id_analisis_mant','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_tipo_mant','id_tipo_mant','int4');
		$this->setParametro('id_persona_rev','id_persona_rev','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_emision','fecha_emision','date');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('fecha_rev','fecha_rev','date');
		$this->setParametro('id_persona_prep','id_persona_prep','int4');
		$this->setParametro('id_uni_cons_hijo','id_uni_cons_hijo','int4');
		$this->setParametro('id_uo','id_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAnalisisMant(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_analisis_mant_ime';
		$this->transaccion='GEM_GEANMA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_analisis_mant','id_analisis_mant','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

    function reporteAnalisisMant(){
        $this->procedimiento='gem.ft_analisis_mant_sel';
        $this->transaccion='GEM_GEANMA_REP';
        $this->tipo_procedimiento='SEL';
        $this->setCount(false);
        
        $this->setParametro('id_analisis_mant','id_analisis_mant','int4');
        
        $this->captura('localizacion','varchar');
        $this->captura('tag','varchar');
        $this->captura('nombre_sis','varchar');
        $this->captura('nombre_sub','varchar');
        $this->captura('preparado_por','varchar');      
        $this->captura('revisado_por','text');
        $this->captura('fecha_emision','text');
        $this->captura('fecha_rev','text');
        $this->captura('descripcion','varchar');
        
        $this->armarConsulta();
		//echo $this->consulta;exit;
        $this->ejecutarConsulta();
		
		
        
        return $this->respuesta;   
    }
			
}
?>