<?php
/**
*@package pXP
*@author  aao
*@date 20-11-2012 12:10:00
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTRecurso extends ACTbase {
			
	function listarRecursoActividad() {
		$this->objParam->defecto('ordenacion','id_recurso');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODRecurso','listarRecursoActividad');
		} else {
			$this->objFunc = $this->create('MODRecurso');
			$this->res=$this->objFunc->listarRecursoActividad();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function guardarRecursoActividad() {
		$this->objFunc = $this->create('MODRecurso');
		if($this->objParam->insertar('id_recurso')) {
			$this->res=$this->objFunc->insertarRecursoActividad();			
		} else {
			$this->res=$this->objFunc->modificarRecursoActividad();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarRecurso() {
		$this->objFunc=$this->create('MODRecurso');	
		$this->res=$this->objFunc->eliminarRecurso();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}

?>