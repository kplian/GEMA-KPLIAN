<?php
/**
*@package       pXP
*@file          gen-ACTTarea.php
*@author        (rac)
*@date          17-10-2012 18:22:11
*@description   Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTarea extends ACTbase{    
			
	function listarTarea(){
		$this->objParam->defecto('ordenacion','id_tarea');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODTarea','listarTarea');
		} else{
			$this->objFunc=$this->create('MODTarea');	
			$this->res=$this->objFunc->listarTarea();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTarea(){
		$this->objFunc=$this->create('MODTarea');	
		if($this->objParam->insertar('id_tarea')){
			$this->res=$this->objFunc->insertarTarea();			
		} else{			
			$this->res=$this->objFunc->modificarTarea();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTarea(){
		$this->objFunc=$this->create('MODTarea');	
		$this->res=$this->objFunc->eliminarTarea();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}
?>