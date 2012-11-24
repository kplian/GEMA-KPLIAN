<?php
/**
*@author  aao
*@date 19-11-2012 10:20:00
*@description: métodos de acceso a datos para la tabla Actividad.
*/

class MODActividadOT extends MODbase {
	
	function __construct(CTParametro $pParam) {
		parent::__construct($pParam);
	}
			
	function listarActividadOT() {
		$this->procedimiento='gem.ft_actividad_sel';
		$this->transaccion='GEM_ACTI_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','varchar');
		
		$this->captura('id_actividad','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_mod','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('id_orden_trabajo','int4');
		$this->captura('orden_trabajo','varchar');
		$this->captura('id_usuario_resp','int4');
		$this->captura('usuario_resp','varchar');
		$this->captura('estado','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('observaciones','varchar');
		$this->captura('fecha_plan_ini','date');
		$this->captura('fecha_plan_fin','date');
		$this->captura('fecha_eje_ini','date');
		$this->captura('fecha_eje_fin','date');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
			
	function insertarActividadOT() {
		$this->procedimiento='gem.ft_actividad_ime';
		$this->transaccion='GEM_ACTI_INS';
		$this->tipo_procedimiento='IME';
		
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('id_usuario_resp','id_usuario_resp','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('fecha_plan_ini','fecha_plan_ini','date');
		$this->setParametro('fecha_plan_fin','fecha_plan_fin','date');
		$this->setParametro('fecha_eje_ini','fecha_eje_ini','date');
		$this->setParametro('fecha_eje_fin','fecha_eje_fin','date');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarActividadOT() {
		$this->procedimiento='gem.ft_actividad_ime';
		$this->transaccion='GEM_ACTI_MOD';
		$this->tipo_procedimiento='IME';
				
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('id_usuario_resp','id_usuario_resp','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('fecha_plan_ini','fecha_plan_ini','date');
		$this->setParametro('fecha_plan_fin','fecha_plan_fin','date');
		$this->setParametro('fecha_eje_ini','fecha_eje_ini','date');
		$this->setParametro('fecha_eje_fin','fecha_eje_fin','date');

		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarActividadOT() {
		$this->procedimiento = 'gem.ft_actividad_ime';
		$this->transaccion = 'GEM_ACTI_ELI';
		$this->tipo_procedimiento = 'IME';
				
		$this->setParametro('id_actividad','id_actividad','int4');

		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
}
?>