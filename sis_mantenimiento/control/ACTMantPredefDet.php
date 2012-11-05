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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarMantPredefDet');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarMantPredefDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMantPredefDet(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_mant_predef_det')){
			$this->res=$this->objFunc->insertarMantPredefDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarMantPredefDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMantPredefDet(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarMantPredefDet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>