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
		
		$this->armarConsulta();
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