<?php
/**
*@package pXP
*@file gen-ACTFuncion.php
*@author  (admin)
*@date 30-09-2012 21:41:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFuncion extends ACTbase{    
			
	function listarFuncion(){
		$this->objParam->defecto('ordenacion','id_funcion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODFuncion','listarFuncion');
		} else{
			$this->objFunc=$this->create('MODFuncion');	
			$this->res=$this->objFunc->listarFuncion();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFuncion(){
		$this->objFunc=$this->create('MODFuncion');	
		if($this->objParam->insertar('id_funcion')){
			$this->res=$this->objFunc->insertarFuncion();			
		} else{			
			$this->res=$this->objFunc->modificarFuncion();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFuncion(){
		$this->objFunc=$this->create('MODFuncion');	
		$this->res=$this->objFunc->eliminarFuncion();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>