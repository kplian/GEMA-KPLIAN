<?php
/**
*@package pXP
*@author  aao
*@date 20-11-2012 12:10:00
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTActividadOT extends ACTbase {
			
	function listarActividadOT() {
		$this->objParam->defecto('ordenacion','id_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarActividadOT');
		} else {
			$this->objFunc = new FuncionesMantenimiento();
			$this->res=$this->objFunc->listarActividadOT($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function guardarActividadOT() {
		$this->objFunc = new FuncionesMantenimiento();
		if($this->objParam->insertar('id_actividad')) {
			$this->res=$this->objFunc->insertarActividadOT($this->objParam);			
		} else {
			$this->res=$this->objFunc->modificarActividadOT($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarActividadOT() {
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarActividadOT($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}

?>