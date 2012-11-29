<?php
/**
*@package pXP
*@file gen-ACTIncidenteEquipo.php
*@author  (admin)
*@date 08-11-2012 17:11:07
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTIncidenteEquipo extends ACTbase{    
			
	function listarIncidenteEquipo(){
		$this->objParam->defecto('ordenacion','id_incidente_equipo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODIncidenteEquipo','listarIncidenteEquipo');
		} else{
			$this->objFunc=$this->create('MODIncidenteEquipo');	
			$this->res=$this->objFunc->listarIncidenteEquipo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarIncidenteEquipo(){
		$this->objFunc=$this->create('MODIncidenteEquipo');	
		if($this->objParam->insertar('id_incidente_equipo')){
			$this->res=$this->objFunc->insertarIncidenteEquipo();			
		} else{			
			$this->res=$this->objFunc->modificarIncidenteEquipo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarIncidenteEquipo(){
		$this->objFunc=$this->create('MODIncidenteEquipo');	
		$this->res=$this->objFunc->eliminarIncidenteEquipo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>