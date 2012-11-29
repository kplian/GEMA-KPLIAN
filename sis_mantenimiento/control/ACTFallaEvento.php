<?php
/**
*@package pXP
*@file gen-ACTFallaEvento.php
*@author  (admin)
*@date 30-09-2012 21:41:31
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFallaEvento extends ACTbase{    
			
	function listarFallaEvento(){
		$this->objParam->defecto('ordenacion','id_falla_evento');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODFallaEvento','listarFallaEvento');
		} else{
			$this->objFunc=$this->create('MODFallaEvento');	
			$this->res=$this->objFunc->listarFallaEvento();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFallaEvento(){
		$this->objFunc=$this->create('MODFallaEvento');	
		if($this->objParam->insertar('id_falla_evento')){
			$this->res=$this->objFunc->insertarFallaEvento();			
		} else{			
			$this->res=$this->objFunc->modificarFallaEvento();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFallaEvento(){
		$this->objFunc=$this->create('MODFallaEvento');	
		$this->res=$this->objFunc->eliminarFallaEvento();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>