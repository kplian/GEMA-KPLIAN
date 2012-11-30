<?php
/**
*@package pXP
*@file    ACTAnalisisPorqueDet.php
*@author  Gonzalo Sarmiento Sejas
*@date 28-11-2012 22:01:17
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAnalisisPorqueDet extends ACTbase{    
			
	function listarAnalisisPorqueDet(){
		$this->objParam->defecto('ordenacion','id_analisis_porque_det');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAnalisisPorqueDet','listarAnalisisPorqueDet');
		} else{
			$this->objFunc=$this->create('MODAnalisisPorqueDet');	
			$this->res=$this->objFunc->listarAnalisisPorqueDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnalisisPorqueDet(){
		$this->objFunc=$this->create('MODAnalisisPorqueDet');	
		if($this->objParam->insertar('id_analisis_porque_det')){
			$this->res=$this->objFunc->insertarAnalisisPorqueDet();			
		} else{			
			$this->res=$this->objFunc->modificarAnalisisPorqueDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnalisisPorqueDet(){
		$this->objFunc=$this->create('MODAnalisisPorqueDet');	
		$this->res=$this->objFunc->eliminarAnalisisPorqueDet();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>