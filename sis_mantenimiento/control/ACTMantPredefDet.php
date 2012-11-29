<?php
/**
*@package pXP
*@file gen-ACTMantPredefDet.php
*@author  (admin)
*@date 28-08-2012 21:15:37
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMantPredefDet extends ACTbase{    
			
	function listarMantPredefDet(){
		$this->objParam->defecto('ordenacion','id_mant_predef_det');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_mant_predef')!=''){
			$this->objParam->addFiltro("gedetm.id_mant_predef = ".$this->objParam->getParametro('id_mant_predef'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODMantPredefDet','listarMantPredefDet');
		} else{
			$this->objFunc=$this->create('MODMantPredefDet');	
			$this->res=$this->objFunc->listarMantPredefDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMantPredefDet(){
		$this->objFunc=$this->create('MODMantPredefDet');	
		if($this->objParam->insertar('id_mant_predef_det')){
			$this->res=$this->objFunc->insertarMantPredefDet();			
		} else{			
			$this->res=$this->objFunc->modificarMantPredefDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMantPredefDet(){
		$this->objFunc=$this->create('MODMantPredefDet');	
		$this->res=$this->objFunc->eliminarMantPredefDet();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>