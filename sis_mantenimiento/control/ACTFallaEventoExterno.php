<?php
/**
*@package pXP
*@file gen-ACTFallaEventoExterno.php
*@author  (admin)
*@date 30-09-2012 21:41:31
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFallaEventoExterno extends ACTbase{    
			
	function listarFallaEventoExterno(){
		$this->objParam->defecto('ordenacion','id_falla_evento');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODFallaEventoExterno','listarFallaEventoExterno');
		} else{
			$this->objFunc=$this->create('MODFallaEventoExterno');	
			$this->res=$this->objFunc->listarFallaEventoExterno();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFallaEventoExterno(){
		$this->objFunc=$this->create('MODFallaEventoExterno');	
		if($this->objParam->insertar('id_falla_evento')){
			$this->res=$this->objFunc->insertarFallaEventoExterno();			
		} else{			
			$this->res=$this->objFunc->modificarFallaEventoExterno();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFallaEventoExterno(){
		$this->objFunc=$this->create('MODFallaEventoExterno');	
		$this->res=$this->objFunc->eliminarFallaEventoExterno();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>