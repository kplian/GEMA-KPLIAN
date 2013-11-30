<?php
/**
*@package pXP
*@file gen-ACTOrdenTrabajo.php
*@author  (admin)
*@date 30-08-2012 02:48:41
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/ROrdenTrabajo.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');

class ACTOrdenTrabajo extends ACTbase{    
			
	function listarOrdenTrabajo(){
		$this->objParam->defecto('ordenacion','fecha_emision');
		$this->objParam->addParametroConsulta('dir_ordenacion','desc');
		
		if($this->objParam->getParametro('id_uni_cons_p')!=''){
			$this->objParam->addFiltro("geoott.id_uni_cons = ".$this->objParam->getParametro('id_uni_cons_p'));	
		}
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODOrdenTrabajo','listarOrdenTrabajo');
		} else {
			if($this->objParam->getParametro('nombreVista') == 'registrarOT') {
				$this->objParam->addFiltro(" geoott.cat_estado in (''Borrador'',''Pendiente'',''generado'')");
			} elseif($this->objParam->getParametro('nombreVista') == 'ejecutarOT') {
				$this->objParam->addFiltro(" (geoott.cat_estado = ''Pendiente'' or geoott.cat_estado = ''Abierto'' or geoott.cat_estado = ''EjecucionPendiente'')");
			} elseif($this->objParam->getParametro('nombreVista') == 'revisarOT') {
				$this->objParam->addFiltro(" (geoott.cat_estado = ''Cerrado'' or geoott.cat_estado = ''Revisado'')");
			}
			$this->objFunc=$this->create('MODOrdenTrabajo');
			$this->res=$this->objFunc->listarOrdenTrabajo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarOrdenTrabajo(){
		$this->objFunc=$this->create('MODOrdenTrabajo');	
		if($this->objParam->insertar('id_orden_trabajo')){
			$this->res=$this->objFunc->insertarOrdenTrabajo();
		} else{
			$this->res=$this->objFunc->modificarOrdenTrabajo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarOrdenTrabajo(){
		$this->objFunc=$this->create('MODOrdenTrabajo');	
		$this->res=$this->objFunc->eliminarOrdenTrabajo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function generarOT(){
		$this->objFunc=$this->create('MODOrdenTrabajo');	
		$this->res=$this->objFunc->generarOT();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function generarAllOT(){
		$this->objFunc=$this->create('MODOrdenTrabajo');	
		$this->res=$this->objFunc->generarAllOT();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function procesarOT() {
		$this->objFunc = $this->create('MODOrdenTrabajo');
		$this->res=$this->objFunc->procesarOT();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function reporteOT() {
		$dataSource = new DataSource();
		$idOrdenTrabajo = $this->objParam->getParametro('id_orden_trabajo');
		$this->objParam->addParametroConsulta('filtro', ' geoott.id_orden_trabajo = '.$idOrdenTrabajo);
		$this->objParam->addParametroConsulta('ordenacion', 'geoott.id_orden_trabajo');
		$this->objParam->addParametroConsulta('dir_ordenacion', 'asc');
		$this->objParam->addParametroConsulta('cantidad', 1000);
		$this->objParam->addParametroConsulta('puntero', 0);
		$this->objFunc = $this->create('MODOrdenTrabajo');
		$resultOT = $this->objFunc->listarOrdenTrabajo($this->objParam);
		$datosOT = $resultOT->getDatos();
		
		//var_dump($datosOT);exit;
		
		//calculo dias reales trabajados
		$diasReales = $this->getDaysBetweenDates($datosOT[0]['fecha_eje_ini'], $datosOT[0]['fecha_eje_fin']);
		$dataSource->putParameter('fechaEmision', $datosOT[0]['fecha_emision']);
		$dataSource->putParameter('codigo', $datosOT[0]['codigo_oit']);
		$dataSource->putParameter('sectorSolicitante', $datosOT[0]['nombre_localizacion']);
		$dataSource->putParameter('prioridad', $datosOT[0]['cat_prior']);
		$dataSource->putParameter('sector', $datosOT[0]['descripcion_lugar']);
		$dataSource->putParameter('centro_costo', $datosOT[0]['codigo_centro_costo']);
		$dataSource->putParameter('cuenta', $datosOT[0]['cuenta']);
		$dataSource->putParameter('equipo', $datosOT[0]['equipo']);
		$dataSource->putParameter('nOit', $datosOT[0]['num_oit']);
		$dataSource->putParameter('tipoOit', $datosOT[0]['tipo_mant']);
		$dataSource->putParameter('tipoMant', $datosOT[0]['cat_tipo']);
		$dataSource->putParameter('especialidad', $datosOT[0]['especialidades']);
		$dataSource->putParameter('observacion', $datosOT[0]['observacion']);
		$dataSource->putParameter('descripcion', $datosOT[0]['descripcion']);
		$dataSource->putParameter('fechaPlanIni', $datosOT[0]['fecha_plan_ini']);
		$dataSource->putParameter('tiempoEstimado', $datosOT[0]['tiempo_estimado']);
		$dataSource->putParameter('unidadMedidaTiempoEstimado', $datosOT[0]['desc_unidad_medida']);		
		$dataSource->putParameter('diasReales', $diasReales);
		$dataSource->putParameter('fechaEjecIni', $datosOT[0]['fecha_eje_ini']);
		$dataSource->putParameter('fechaEjecFin', $datosOT[0]['fecha_eje_fin']);
		$dataSource->putParameter('nombreSolicitante', $datosOT[0]['desc_person']);
		$dataSource->putParameter('nombreAprobado', $datosOT[0]['desc_funcionario_aprob']);
		$dataSource->putParameter('nombreEjecutado', $datosOT[0]['desc_person1']);
		$dataSource->putParameter('nombreRecibido', $datosOT[0]['desc_funcionario_recib']);
		$dataSource->putParameter('comentarios', $datosOT[0]['comentarios']);
		$dataSource->putParameter('accidentes', $datosOT[0]['accidentes']);
		$dataSource->putParameter('reclamos', $datosOT[0]['reclamos']);
		$dataSource->putParameter('otros', $datosOT[0]['otros']);
		$dataSource->putParameter('horaEjeInicio', $datosOT[0]['hora_eje_inicio']);
		$dataSource->putParameter('horaEjeFin', $datosOT[0]['hora_eje_fin']);
		$dataSource->putParameter('codigo', $datosOT[0]['codigo']);
		$dataSource->putParameter('descripcion_progresiva', $datosOT[0]['descripcion_progresiva']);
		$dataSource->putParameter('ubicacion_tecnica', $datosOT[0]['ubicacion_tecnica']);
		$dataSource->putParameter('nota_tecnico_loc', $datosOT[0]['nota_tecnico_loc']);
		$dataSource->putParameter('desc_mant_predef', $datosOT[0]['desc_mant_predef']);
		$dataSource->putParameter('cat_estado', $datosOT[0]['cat_estado']);
		
		
		$this->objParam->addParametroConsulta('filtro', ' 0 = 0');
		$this->objParam->addParametroConsulta('ordenacion', 'id_recurso');
		$modActividad = $this->create('MODActividadOT');
		$resultActividad = $modActividad->listarActividadOT();
		$actividadesDataSource = new DataSource();
		$actividadesDataSource->setDataset($resultActividad->getDatos());
		$dataSource->putParameter('actividadesDataSource', $actividadesDataSource);
		
		$this->objParam->addParametroConsulta('filtro', ' rec.id_item is not null ');
		$modRepuestos = $this->create('MODRecurso');
		$resultRepuestos = $modRepuestos->listarRecursoOT();
		$repuestosDataSource = new DataSource();
		$repuestosDataSource->setDataset($resultRepuestos->getDatos());
		//var_dump($resultRepuestos->getDatos());exit;
		$dataSource->putParameter('repuestosDataSource', $repuestosDataSource);
		
		$this->objParam->addParametroConsulta('filtro', ' rec.id_funcionario is not null ');
		$modFuncionarios = $this->create('MODRecurso');
		$resultFuncionarios = $modFuncionarios->listarRecursoOT();
		$funcionariosDataSource = new DataSource();
		$funcionariosDataSource->setDataset($resultFuncionarios->getDatos());
		$dataSource->putParameter('funcionariosDataSource', $funcionariosDataSource);
		
		//Mantenimientos predefinidos
		$this->objParam->addParametroConsulta('filtro', ' id_mant_predef = '.$datosOT[0]['id_mant_predef'] );
		$this->objParam->addParametroConsulta('ordenacion', 'id_mant_predef_det');
		$modMantPredef = $this->create('MODMantPredefDet');
		$resultMantPredef = $modMantPredef->listarMantPredefDetOT();
		$mantPredefDataSource = new DataSource();
		$mantPredefDataSource->setDataset($resultMantPredef->getDatos());
		$dataSource->putParameter('mantPredefDataSource', $mantPredefDataSource);
		
		//Costos
		$this->objParam->addParametro('id_orden_trabajo', $this->objParam->getParametro('id_orden_trabajo'));
		$this->objParam->addParametro('sw_oit', "'si'");
		$modCosto = $this->create('MODOrdenTrabajo');
		$resultCosto = $modCosto->listarCostoOIT();
		$mantCostoDataSource = new DataSource();
		$mantCostoDataSource->setDataset($resultCosto->getDatos());
		$dataSource->putParameter('mantCostoDataSource', $mantCostoDataSource);
		//var_dump($resultCosto->getDatos());exit;
		
		
		$reporte = new ROrdenTrabajo();
		$reporte->setDataSource($dataSource);
		$nombreArchivo = 'OrdenTrabajo.pdf';
		$reportWriter = new ReportWriter($reporte, dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo);
		$reportWriter->writeReport(ReportWriter::PDF);
		
		$mensajeExito = new Mensaje();
		$mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
										'Se generó con éxito el reporte: '.$nombreArchivo,'control');
		$mensajeExito->setArchivoGenerado($nombreArchivo);
		$this->res = $mensajeExito;
		$this->res->imprimirRespuesta($this->res->generarJson());
	} 

	private function getDaysBetweenDates($startDate, $endDate) {
		$diffDays = 0;
		if($startDate != null && $endDate){
			list($startYear, $startMonth, $startDay) = explode('-', $startDate);
			list($endYear, $endMonth, $endDay) = explode('-', $endDate);
			$startMillis = mktime(0, 0, 0, $startMonth, $startDay, $startYear);
			$endMillis = mktime(0, 0, 0, $endMonth, $endDay, $endYear);
			$diffMillis = $endMillis - $startMillis;
			
			$diffDays = $diffMillis / (60 * 60 * 24);
			$diffDays = abs($diffDays);
			$diffDays = floor($diffDays);
		}
		return $diffDays;
	}
	
	function listarCostoOIT(){
		$this->objParam->defecto('ordenacion','descripcion');

		$this->objParam->addParametroConsulta('dir_ordenacion','desc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODOrdenTrabajo','listarCostoOIT');
		} else {
			$this->objFunc=$this->create('MODOrdenTrabajo');
			$this->res=$this->objFunc->listarCostoOIT();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function precerrarOIT() {
		$this->objFunc = $this->create('MODOrdenTrabajo');
		$this->res=$this->objFunc->precerrarOIT();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}
?>
