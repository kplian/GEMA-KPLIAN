<?php
/**
*@package pXP
*@file gen-ACTFalla.php
*@author  (rac)
*@date 21-08-2012 20:44:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFalla extends ACTbase{    
			
	function listarFalla(){
		$this->objParam->defecto('ordenacion','id_falla');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODFalla','listarFalla');
		} else{
			$this->objFunc=$this->create('MODFalla');	
			$this->res=$this->objFunc->listarFalla();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFalla(){
		$this->objFunc=$this->create('MODFalla');	
		if($this->objParam->insertar('id_falla')){
			$this->res=$this->objFunc->insertarFalla();			
		} else{			
			$this->res=$this->objFunc->modificarFalla();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFalla(){
		$this->objFunc=$this->create('MODFalla');	
		$this->res=$this->objFunc->eliminarFalla();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>