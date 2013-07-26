<?php
/**
*@package pXP
*@file gen-MODOrdenTrabajo.php
*@author  (admin)
*@date 30-08-2012 02:48:41
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODOrdenTrabajo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarOrdenTrabajo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_orden_trabajo_sel';
		$this->transaccion='GEM_GEOOTT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		//Definicion de la lista del resultado del query
		$this->captura('id_orden_trabajo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_plan_ini','date');
		$this->captura('fecha_eje_ini','date');
		$this->captura('tiempo_estimado','numeric');
		$this->captura('num_oit','varchar');
		$this->captura('nota_tecnico_equipo','varchar');
		$this->captura('observacion','varchar');
		$this->captura('acumulado','numeric');
		$this->captura('codigo_oit','varchar');
		$this->captura('fecha_emision','date');
		$this->captura('id_funcionario_asig','int4');
		$this->captura('id_unidad_medida','int4');
		$this->captura('descripcion','varchar');
		$this->captura('id_funcionario_sol','int4');
		$this->captura('ubicacion_tecnica','varchar');
		$this->captura('fecha_eje_fin','date');
		$this->captura('id_uni_cons_mant_predef','int4');
		$this->captura('id_tipo_mant','int4');
		$this->captura('nota_tecnico_loc','varchar');
		$this->captura('id_uni_cons','int4');
		$this->captura('cat_estado','varchar');
		$this->captura('cat_prior','varchar');
		$this->captura('cat_tipo','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_person','text');
		$this->captura('desc_person1','text');
		$this->captura('equipo','varchar');
		$this->captura('tipo_mant','varchar');
		$this->captura('desc_unidad_medida','varchar');
		$this->captura('id_localizacion','int4');
		$this->captura('nombre_localizacion','varchar');
		$this->captura('descripcion_lugar','varchar');
		$this->captura('id_centro_costo','int4');
		$this->captura('codigo_centro_costo','varchar');
		$this->captura('especialidades','varchar');
		$this->captura('id_funcionario_aprob','int4');
		$this->captura('desc_funcionario_aprob','text');
		$this->captura('id_funcionario_recib','int4');
		$this->captura('desc_funcionario_recib','text');
		$this->captura('comentarios','varchar');
		$this->captura('accidentes','varchar');
		$this->captura('reclamos','varchar');
		$this->captura('otros','varchar');
		$this->captura('hora_eje_inicio','time');
		$this->captura('hora_eje_fin','time');
		$this->captura('codigo','varchar');
		$this->captura('descripcion_causa','varchar');
		$this->captura('prevension','varchar');
		$this->captura('descripcion_progresiva','varchar');
		$this->captura('id_cuenta','int4');
		$this->captura('desc_cuenta','text');
		$this->captura('fecha_server','date');
		$this->captura('cuenta','varchar');
		$this->captura('id_mant_predef','int4');
		$this->captura('desc_mant_predef','text');
		$this->captura('id_orden_trabajo_sol','int4');
		$this->captura('desc_ot_sol','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//echo $this->consulta;exit;
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarOrdenTrabajo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_orden_trabajo_ime';
		$this->transaccion='GEM_GEOOTT_INS';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_plan_ini','fecha_plan_ini','date');
		$this->setParametro('fecha_eje_ini','fecha_eje_ini','date');
		$this->setParametro('tiempo_estimado','tiempo_estimado','numeric');
		$this->setParametro('num_oit','num_oit','varchar');
		$this->setParametro('nota_tecnico_equipo','nota_tecnico_equipo','varchar');
		$this->setParametro('observacion','observacion','varchar');
		$this->setParametro('acumulado','acumulado','numeric');
		$this->setParametro('codigo_oit','codigo_oit','varchar');
		$this->setParametro('id_funcionario_asig','id_funcionario_asig','int4');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_funcionario_sol','id_funcionario_sol','int4');
		$this->setParametro('ubicacion_tecnica','ubicacion_tecnica','varchar');
		$this->setParametro('fecha_eje_fin','fecha_eje_fin','date');
		$this->setParametro('id_uni_cons_mant_predef','id_uni_cons_mant_predef','int4');
		$this->setParametro('id_tipo_mant','id_tipo_mant','int4');
		$this->setParametro('nota_tecnico_loc','nota_tecnico_loc','varchar');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('cat_estado','cat_estado','varchar');
		$this->setParametro('cat_prior','cat_prior','varchar');
		$this->setParametro('cat_tipo','cat_tipo','varchar');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('descripcion_lugar','descripcion_lugar','varchar');
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('especialidades','especialidades','varchar');
		$this->setParametro('id_funcionario_aprob','id_funcionario_aprob','int4');
		$this->setParametro('id_funcionario_recib','id_funcionario_recib','int4');
		$this->setParametro('comentarios','comentarios','varchar');
		$this->setParametro('accidentes','accidentes','varchar');
		$this->setParametro('reclamos','reclamos','varchar');
		$this->setParametro('otros','otros','varchar');
		$this->setParametro('hora_eje_inicio','hora_eje_inicio','time');
		$this->setParametro('hora_eje_fin','hora_eje_fin','time');
		$this->setParametro('mensaje_estado', 'mensaje_estado', 'varchar');
		$this->setParametro('descripcion_causa', 'descripcion_causa', 'varchar');
		$this->setParametro('prevension', 'prevension', 'varchar');
		$this->setParametro('descripcion_progresiva', 'descripcion_progresiva', 'varchar');
		$this->setParametro('id_cuenta','id_cuenta','int4');
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarOrdenTrabajo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_orden_trabajo_ime';
		$this->transaccion='GEM_GEOOTT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_plan_ini','fecha_plan_ini','date');
		$this->setParametro('fecha_eje_ini','fecha_eje_ini','date');
		$this->setParametro('tiempo_estimado','tiempo_estimado','numeric');
		$this->setParametro('num_oit','num_oit','varchar');
		$this->setParametro('nota_tecnico_equipo','nota_tecnico_equipo','varchar');
		$this->setParametro('observacion','observacion','varchar');
		$this->setParametro('acumulado','acumulado','numeric');
		$this->setParametro('codigo_oit','codigo_oit','varchar');
		$this->setParametro('id_funcionario_asig','id_funcionario_asig','int4');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_funcionario_sol','id_funcionario_sol','int4');
		$this->setParametro('ubicacion_tecnica','ubicacion_tecnica','varchar');
		$this->setParametro('fecha_eje_fin','fecha_eje_fin','date');
		$this->setParametro('id_uni_cons_mant_predef','id_uni_cons_mant_predef','int4');
		$this->setParametro('id_tipo_mant','id_tipo_mant','int4');
		$this->setParametro('nota_tecnico_loc','nota_tecnico_loc','varchar');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('cat_estado','cat_estado','varchar');
		$this->setParametro('cat_prior','cat_prior','varchar');
		$this->setParametro('cat_tipo','cat_tipo','varchar');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('descripcion_lugar','descripcion_lugar','varchar');
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('especialidades','especialidades','varchar');
		$this->setParametro('id_funcionario_aprob','id_funcionario_aprob','int4');
		$this->setParametro('id_funcionario_recib','id_funcionario_recib','int4');
		$this->setParametro('comentarios','comentarios','varchar');
		$this->setParametro('accidentes','accidentes','varchar');
		$this->setParametro('reclamos','reclamos','varchar');
		$this->setParametro('otros','otros','varchar');
		$this->setParametro('hora_eje_inicio','hora_eje_inicio','time');
		$this->setParametro('hora_eje_fin','hora_eje_fin','time');
		$this->setParametro('mensaje_estado', 'mensaje_estado', 'varchar');
		$this->setParametro('descripcion_causa', 'descripcion_causa', 'varchar');
		$this->setParametro('prevension', 'prevension', 'varchar');
		$this->setParametro('descripcion_progresiva', 'descripcion_progresiva', 'varchar');
		$this->setParametro('id_cuenta','id_cuenta','int4');
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('id_orden_trabajo_sol','id_orden_trabajo_sol','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarOrdenTrabajo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_orden_trabajo_ime';
		$this->transaccion='GEM_GEOOTT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('mensaje_estado', 'mensaje_estado', 'varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function generarAllOT(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_generar_orden_trabajo';
		$this->transaccion='GEM_GENALLOT_GEN';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('id_localizacion','id_localizacion','int4');
		$this->setParametro('tipo_nodo','tipo_nodo','varchar');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('fecha_fin','fecha_fin','date');
		
 
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
		
		
	}
	
	function generarOT(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_generar_orden_trabajo';
		$this->transaccion='GEM_GENEOT_GEN';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_mant_predef','id_uni_cons_mant_predef','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('mensaje_estado', 'mensaje_estado', 'varchar');
 
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function procesarOT() {
		$this->procedimiento='gem.ft_orden_trabajo_ime';
		$this->transaccion='GEM_PROCESSOT_MOD';
		$this->tipo_procedimiento='IME';
		
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('cat_estado','cat_estado','varchar');
		$this->setParametro('mensaje_estado', 'mensaje_estado', 'varchar');
		$this->setParametro('fecha_eje_ini', 'fecha_eje_ini', 'date');
		$this->setParametro('fecha_eje_fin', 'fecha_eje_fin', 'date');
		
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		return $this->respuesta;
	}

	function listarCostoOIT(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_get_costo_oit_sel';
		$this->transaccion='GEM_CTOIT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		$this->setTipoRetorno('record');

		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('sw_oit','sw_oit','varchar');
		//Definicion de la lista del resultado del query
		$this->captura('descripcion','varchar');
		$this->captura('costo','numeric');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function precerrarOIT() {
		$this->procedimiento='gem.ft_orden_trabajo_ime';
		$this->transaccion='GEM_PRECER_MOD';
		$this->tipo_procedimiento='IME';
		
		$this->setParametro('id_orden_trabajo','id_orden_trabajo','int4');
		$this->setParametro('descripcion_causa','descripcion_causa','varchar');
		$this->setParametro('comentarios', 'comentarios', 'varchar');
		$this->setParametro('prevension', 'prevension', 'varchar');
		$this->setParametro('accidentes', 'accidentes', 'varchar');
		$this->setParametro('reclamos', 'reclamos', 'varchar');
		
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
}
?>