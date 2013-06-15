<?php
/**
*@author  aao
*@date 19-11-2012 10:20:00
*@description: métodos de acceso a datos para la tabla Actividad.
*/

class MODRecurso extends MODbase {
	
	function __construct(CTParametro $pParam) {
		parent::__construct($pParam);
	}
			
	function listarRecursoActividad() {
		$this->procedimiento='gem.ft_recurso_sel';
		$this->transaccion='GEM_RECACTI_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setParametro('id_actividad','id_actividad','varchar');

		$this->captura('id_recurso','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_mod','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('id_actividad','int4');
		$this->captura('id_item','int4');
		$this->captura('nombre_item','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('nombre_funcionario','varchar');
		$this->captura('id_especialidad','int4');
		$this->captura('nombre_especialidad','varchar');
		$this->captura('id_servicio','int4');
		$this->captura('nombre_servicio','varchar');
		$this->captura('id_moneda','int4');
		$this->captura('codigo_moneda','varchar');
		$this->captura('cantidad','numeric');
		$this->captura('costo','numeric');
		$this->captura('observaciones','varchar');
		$this->captura('id_unidad_medida','int4');
		$this->captura('codigo_unidad_medida','varchar');
		$this->captura('hh_normal','numeric');
		$this->captura('hh_extras','numeric');
		$this->captura('hh_ext_mov','numeric');
		$this->captura('codigo','varchar');
		$this->captura('existencias','varchar');
		$this->captura('recurso','varchar');
		$this->captura('id_orden_trabajo','int4');
		$this->captura('hh_fer_dom','numeric');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}

	function listarRecursoOT() {
		$this->procedimiento='gem.ft_recurso_sel';
		$this->transaccion='GEM_RECOT_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','varchar');

		$this->captura('id_recurso','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_mod','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('id_actividad','int4');
		$this->captura('id_item','int4');
		$this->captura('nombre_item','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('nombre_funcionario','varchar');
		$this->captura('cargo_funcionario','varchar');
		$this->captura('id_especialidad','int4');
		$this->captura('nombre_especialidad','varchar');
		$this->captura('id_servicio','int4');
		$this->captura('nombre_servicio','varchar');
		$this->captura('id_moneda','int4');
		$this->captura('codigo_moneda','varchar');
		$this->captura('cantidad','numeric');
		$this->captura('costo','numeric');
		$this->captura('observaciones','varchar');
		$this->captura('id_unidad_medida','int4');
		$this->captura('codigo_unidad_medida','varchar');
		$this->captura('hh_normal','numeric');
		$this->captura('hh_extras','numeric');
		$this->captura('hh_ext_mov','numeric');
		$this->captura('codigo','varchar');
		$this->captura('existencias','varchar');
		$this->captura('id_orden_trabajo','int4');
		$this->captura('hh_fer_dom','numeric');
		$this->captura('costo_total','numeric');
		
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
			
	function insertarRecursoActividad() {
		$this->procedimiento='gem.ft_recurso_ime';
		$this->transaccion='GEM_RECACTI_INS';
		$this->tipo_procedimiento='IME';
		
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_especialidad','id_especialidad','int4');
		$this->setParametro('id_servicio','id_servicio','int4');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('cantidad_recurso','cantidad','numeric');
		$this->setParametro('costo','costo','numeric');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('hh_normal','hh_normal','numeric');
		$this->setParametro('hh_extras','hh_extras','numeric');
		$this->setParametro('hh_ext_mov','hh_ext_mov','numeric');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('existencias','existencias','varchar');
		$this->setParametro('recurso','recurso','varchar');
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('hh_fer_dom','hh_fer_dom','numeric');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarRecursoActividad() {
		$this->procedimiento='gem.ft_recurso_ime';
		$this->transaccion='GEM_RECACTI_MOD';
		$this->tipo_procedimiento='IME';
		
		$this->setParametro('id_recurso','id_recurso','int4');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_especialidad','id_especialidad','int4');
		$this->setParametro('id_servicio','id_servicio','int4');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('cantidad_recurso','cantidad','numeric');
		$this->setParametro('costo','costo','numeric');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('hh_normal','hh_normal','numeric');
		$this->setParametro('hh_extras','hh_extras','numeric');
		$this->setParametro('hh_ext_mov','hh_ext_mov','numeric');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('existencias','existencias','varchar');
		$this->setParametro('recurso','recurso','varchar');
		$this->setParametro('hh_fer_dom','hh_fer_dom','numeric');
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarRecurso() {
		$this->procedimiento = 'gem.ft_recurso_ime';
		$this->transaccion = 'GEM_RECURSO_ELI';
		$this->tipo_procedimiento = 'IME';
				
		$this->setParametro('id_recurso','id_recurso','int4');

		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
}
?>