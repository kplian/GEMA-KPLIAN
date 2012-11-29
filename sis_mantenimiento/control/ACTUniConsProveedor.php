<?php
/**
*@package       pXP
*@file          gen-ACTUniConsProveedor.php
*@author        (rac)
*@date          01-11-2012 14:45:49
*@description   Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsProveedor extends ACTbase{    
			
	function listarUniConsProveedor(){
		$this->objParam->defecto('ordenacion','id_uni_cons_proveedor');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsProveedor','listarUniConsProveedor');
		} else{
			$this->objFunc=$this->create('MODUniConsProveedor');	
			$this->res=$this->objFunc->listarUniConsProveedor();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsProveedor(){
		$this->objFunc=$this->create('MODUniConsProveedor');	
		if($this->objParam->insertar('id_uni_cons_proveedor')){
			$this->res=$this->objFunc->insertarUniConsProveedor();			
		} else{			
			$this->res=$this->objFunc->modificarUniConsProveedor();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsProveedor(){
		$this->objFunc=$this->create('MODUniConsProveedor');	
		$this->res=$this->objFunc->eliminarUniConsProveedor();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}
?>