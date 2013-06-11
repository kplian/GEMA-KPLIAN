<?php
/**
*@package pXP
*@file gen-ACTMetodologia.php
*@author  (admin)
*@date 17-08-2012 15:52:46
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMetodologia extends ACTbase{    
			
	function listarMetodologia(){
		$this->objParam->defecto('ordenacion','id_metodologia');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODMetodologia','listarMetodologia');
		} else{
			$this->objFunc=$this->create('MODMetodologia');	
			$this->res=$this->objFunc->listarMetodologia();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMetodologia(){
		$this->objFunc=$this->create('MODMetodologia');	
		if($this->objParam->insertar('id_metodologia')){
			$this->res=$this->objFunc->insertarMetodologia();			
		} else{			
			$this->res=$this->objFunc->modificarMetodologia();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMetodologia(){
		$this->objFunc=$this->create('MODMetodologia');	
		$this->res=$this->objFunc->eliminarMetodologia();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>