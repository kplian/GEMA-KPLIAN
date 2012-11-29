<?php
/**
*@package       pXP
*@file          gen-ACTUniConsItem.php
*@author        (rac)
*@date          01-11-2012 11:53:15
*@description   Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsItem extends ACTbase{    
			
	function listarUniConsItem(){
		$this->objParam->defecto('ordenacion','id_uni_cons_item');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsItem','listarUniConsItem');
		} else{
			$this->objFunc=$this->create('MODUniConsItem');	
			$this->res=$this->objFunc->listarUniConsItem();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsItem(){
		$this->objFunc=$this->create('MODUniConsItem');	
		if($this->objParam->insertar('id_uni_cons_item')){
			$this->res=$this->objFunc->insertarUniConsItem();			
		} else{			
			$this->res=$this->objFunc->modificarUniConsItem();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsItem(){
		$this->objFunc=$this->create('MODUniConsItem');	
		$this->res=$this->objFunc->eliminarUniConsItem();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}
?>