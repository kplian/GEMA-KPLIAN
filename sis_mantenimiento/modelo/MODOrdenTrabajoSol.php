<?php
/**
*@package pXP
*@file gen-MODOrdenTrabajoSol.php
*@author  (admin)
*@date 02-01-2013 15:59:36
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODOrdenTrabajoSol extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarOrdenTrabajoSol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_orden_trabajo_sol_sel';
		$this->transaccion='GM_SOLORD_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('estado','estado','varchar');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_orden_trabajo_sol','int4');
		$this->captura('id_solicitante','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('id_responsable','int4');
		$this->captura('id_unidad_medida_req','int4');
		$this->captura('id_uo','int4');
		$this->captura('id_localizacion','int4');
		$this->captura('id_orden_trabajo','int4');
		$this->captura('inspeccion_lugar','varchar');
		$this->captura('fecha_estimada','date');
		$this->captura('estado','varchar');
		$this->captura('nota','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('descripcion_req','varchar');
		$this->captura('fecha_requerida','date');
		$this->captura('estado_reg','varchar');
		$this->captura('inspeccion_exacto','varchar');
		$this->captura('cantidad_req','numeric');
		$this->captura('importancia','varchar');
		$this->captura('fecha_real','date');
		$this->captura('observaciones_resp','varchar');
		$this->captura('fecha_recepcion','date');
		$this->captura('observacion','varchar');
		$this->captura('prioridad','varchar');
		$this->captura('fecha','date');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_solicitante','text');
		$this->captura('desc_localizacion','text');
		$this->captura('desc_equipo','text');
		$this->captura('desc_responsable','text');
		$this->captura('desc_unidad_medida','varchar');
		$this->captura('desc_uo','text');
		$this->captura('nro_sol','varchar');
		//$this->captura('nombre','varchar');
		$this->captura('extension','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarOrdenTrabajoSol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_orden_trabajo_sol_ime';
		$this->transaccion='GM_SOLORD_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_solicitante','id_solicitante','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_responsable','id_responsable','int4');
		$this->setParametro('id_unidad_medida_req','id_unidad_medida_req','int4');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('inspeccion_lugar','inspeccion_lugar','varchar');
		$this->setParametro('fecha_estimada','fecha_estimada','date');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('nota','nota','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('descripcion_req','descripcion_req','varchar');
		$this->setParametro('fecha_requerida','fecha_requerida','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('inspeccion_exacto','inspeccion_exacto','varchar');
		$this->setParametro('cantidad_req','cantidad_req','numeric');
		$this->setParametro('importancia','importancia','varchar');
		$this->setParametro('fecha_real','fecha_real','date');
		$this->setParametro('observaciones_resp','observaciones_resp','varchar');
		$this->setParametro('fecha_recepcion','fecha_recepcion','date');
		$this->setParametro('observacion','observacion','varchar');
		$this->setParametro('prioridad','prioridad','varchar');
		$this->setParametro('fecha','fecha','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarOrdenTrabajoSol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_orden_trabajo_sol_ime';
		$this->transaccion='GM_SOLORD_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','int4');
		$this->setParametro('id_solicitante','id_solicitante','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_responsable','id_responsable','int4');
		$this->setParametro('id_unidad_medida_req','id_unidad_medida_req','int4');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('inspeccion_lugar','inspeccion_lugar','varchar');
		$this->setParametro('fecha_estimada','fecha_estimada','date');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('nota','nota','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('descripcion_req','descripcion_req','varchar');
		$this->setParametro('fecha_requerida','fecha_requerida','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('inspeccion_exacto','inspeccion_exacto','varchar');
		$this->setParametro('cantidad_req','cantidad_req','numeric');
		$this->setParametro('importancia','importancia','varchar');
		$this->setParametro('fecha_real','fecha_real','date');
		$this->setParametro('observaciones_resp','observaciones_resp','varchar');
		$this->setParametro('fecha_recepcion','fecha_recepcion','date');
		$this->setParametro('observacion','observacion','varchar');
		$this->setParametro('prioridad','prioridad','varchar');
		$this->setParametro('fecha','fecha','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarOrdenTrabajoSol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_orden_trabajo_sol_ime';
		$this->transaccion='GM_SOLORD_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function finalizarOrdenTrabajoSol(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_orden_trabajo_sol_ime';
		$this->transaccion='GM_SOLFIN_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','int4');
		$this->setParametro('estado','estado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    
	function listarOrdenTrabajoRep(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='gem.ft_orden_trabajo_sol_sel';
        $this->transaccion='GM_SOLORD_REP';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $this->setCount(false);
        $this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','int4');        
        //Definicion de la lista del resultado del query
        $this->captura('id_orden_trabajo_sol','int4');
        $this->captura('id_solicitante','int4');
        $this->captura('id_uni_cons','int4');
        $this->captura('id_responsable','int4');
        $this->captura('id_unidad_medida_req','int4');
        $this->captura('id_uo','int4');
        $this->captura('id_localizacion','int4');
        $this->captura('id_orden_trabajo','int4');
        $this->captura('inspeccion_lugar','varchar');
        $this->captura('fecha_estimada','date');
        $this->captura('estado','varchar');
        $this->captura('nota','varchar');
        $this->captura('descripcion','varchar');
        $this->captura('descripcion_req','varchar');
        $this->captura('fecha_requerida','date');
        $this->captura('estado_reg','varchar');
        $this->captura('inspeccion_exacto','varchar');
        $this->captura('cantidad_req','numeric');
        $this->captura('importancia','varchar');
        $this->captura('fecha_real','date');
        $this->captura('observaciones_resp','varchar');
        $this->captura('fecha_recepcion','date');
        $this->captura('observacion','varchar');
        $this->captura('prioridad','varchar');
        $this->captura('fecha','date');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('desc_solicitante','text');
        $this->captura('desc_localizacion','text');
        $this->captura('desc_equipo','text');
        $this->captura('desc_responsable','text');
        $this->captura('desc_unidad_medida','varchar');
        $this->captura('codigo_uo','varchar');
        $this->captura('nombre_uo','varchar');
        $this->captura('nombre_cargo','varchar');
		$this->captura('nro_sol','varchar');
		$this->captura('cargo_solicitante','varchar');
		$this->captura('cargo_responsable','varchar');
        //Ejecuta la instruccion
        $this->armarConsulta();
		//echo $this->consulta;exit;
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }

	function subirArchivo(){
        $this->procedimiento='gem.ft_orden_trabajo_sol_ime';
        $this->transaccion='GEM_UPLFIL_MOD';
        $this->tipo_procedimiento='IME';
        
        $ext = pathinfo($this->arregloFiles['archivo']['name']);
        $this->arreglo['extension']= $ext['extension'];
        
        //Define los parametros para la funcion 
        $this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','integer');   
        $this->setParametro('extension','extension','varchar');
        $this->setParametro('archivo','archivo','bytea',false,'',false,array('doc','pdf','docx','jpg','jpeg','bmp','gif','png'));
                
        
        //Ejecuta la instruccion
        $this->armarConsulta();
                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
	
	function listarOrdenTrabajoSolArchivo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_orden_trabajo_sol_sel';
		$this->transaccion='GM_OTSOAR_REP';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','integer');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_orden_trabajo_sol','int4');
		$this->captura('archivo','bytea','id_orden_trabajo_sol','extension','archivo','../../../archivos_uni_cons/');
		$this->captura('extension','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}		
}
?>