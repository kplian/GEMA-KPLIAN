<?php
/**
*@package pXP
*@file gen-ACTAnalisisMant.php
*@author  (admin)
*@date 30-09-2012 21:44:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAnalisisMant extends ACTbase{    
			
	function listarAnalisisMant(){
		$this->objParam->defecto('ordenacion','id_analisis_mant');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODAnalisisMant','listarAnalisisMant');
		} else{
			$this->objFunc=$this->create('MODAnalisisMant');	
			$this->res=$this->objFunc->listarAnalisisMant();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnalisisMant(){
		$this->objFunc=$this->create('MODAnalisisMant');	
		if($this->objParam->insertar('id_analisis_mant')){
			$this->res=$this->objFunc->insertarAnalisisMant();			
		} else{			
			$this->res=$this->objFunc->modificarAnalisisMant();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnalisisMant(){
		$this->objFunc=$this->create('MODAnalisisMant');	
		$this->res=$this->objFunc->eliminarAnalisisMant();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>