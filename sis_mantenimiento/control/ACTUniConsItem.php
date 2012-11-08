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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarUniConsItem');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarUniConsItem($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsItem(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_uni_cons_item')){
			$this->res=$this->objFunc->insertarUniConsItem($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUniConsItem($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsItem(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarUniConsItem($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}
?>