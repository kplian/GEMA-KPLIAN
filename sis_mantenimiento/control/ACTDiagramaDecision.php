<?php
/**
*@package pXP
*@file gen-ACTDiagramaDecision.php
*@author  (admin)
*@date 02-10-2012 01:25:12
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDiagramaDecision extends ACTbase{    
			
	function listarDiagramaDecision(){
		$this->objParam->defecto('ordenacion','id_diagrama_decision');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODDiagramaDecision','listarDiagramaDecision');
		} else{
			$this->objFunc=$this->create('MODDiagramaDecision');	
			$this->res=$this->objFunc->listarDiagramaDecision();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDiagramaDecision(){
		$this->objFunc=$this->create('MODDiagramaDecision');	
		if($this->objParam->insertar('id_diagrama_decision')){
			$this->res=$this->objFunc->insertarDiagramaDecision();			
		} else{			
			$this->res=$this->objFunc->modificarDiagramaDecision();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDiagramaDecision(){
		$this->objFunc=$this->create('MODDiagramaDecision');	
		$this->res=$this->objFunc->eliminarDiagramaDecision();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>