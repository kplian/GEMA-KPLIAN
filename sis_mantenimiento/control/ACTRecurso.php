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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarRecursoActividad');
		} else {
			$this->objFunc = new FuncionesMantenimiento();
			$this->res=$this->objFunc->listarRecursoActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function guardarRecursoActividad() {
		$this->objFunc = new FuncionesMantenimiento();
		if($this->objParam->insertar('id_recurso')) {
			$this->res=$this->objFunc->insertarRecursoActividad($this->objParam);			
		} else {
			$this->res=$this->objFunc->modificarRecursoActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarRecurso() {
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarRecurso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}

?>