<?php
/**
*@package pXP
*@file gen-ACTAriableGlobal.php
*@author  (admin)
*@date 14-01-2013 17:19:57
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAriableGlobal extends ACTbase{    
			
	function listarAriableGlobal(){
		$this->objParam->defecto('ordenacion','id_variable_global');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAriableGlobal','listarAriableGlobal');
		} else{
			$this->objFunc=$this->create('MODAriableGlobal');
			
			$this->res=$this->objFunc->listarAriableGlobal($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAriableGlobal(){
		$this->objFunc=$this->create('MODAriableGlobal');	
		if($this->objParam->insertar('id_variable_global')){
			$this->res=$this->objFunc->insertarAriableGlobal($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAriableGlobal($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAriableGlobal(){
			$this->objFunc=$this->create('MODAriableGlobal');	
		$this->res=$this->objFunc->eliminarAriableGlobal($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>